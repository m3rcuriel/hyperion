use libc::{syscall, timespec, SYS_futex, SYS_gettid};
use nix::errno::Errno;
use nix::{errno, Error as NixError, Result};
use std::time;

use lock_api::RawMutex;

use std::sync::atomic::{AtomicI32, Ordering};

use std::cell::RefCell;
use std::thread_local;

#[allow(dead_code)]
fn likely(a: bool) -> bool {
    a
}

#[allow(dead_code)]
fn unlikely(a: bool) -> bool {
    a
}

const FUTEX_TID_MASK: libc::pid_t = 0x3fffffff;

#[allow(dead_code)]
pub enum WakeNumber {
    N(u32),
    All,
}

pub trait RawFutex {
    fn wake(&self, wake: WakeNumber) -> Result<i32>;
    fn wait(&self, value: i32, timeout: Option<time::Duration>) -> Result<i32>;
    fn lock_pi(&self, value: i32, timeout: Option<time::Duration>) -> Result<i32>;
    fn trylock_pi(&self, value: i32, timeout: Option<time::Duration>) -> Result<i32>;
    fn unlock_pi(&self) -> Result<i32>;
}

#[repr(align(4), C)]
pub struct Futex(AtomicI32);

pub struct FutexMutex(Futex);

#[repr(i32)]
#[derive(Debug)]
#[allow(dead_code)]
enum FutexOp {
    ClockRealtime = libc::FUTEX_CLOCK_REALTIME,
    CmdMask = libc::FUTEX_CMD_MASK,
    CmpRequeue = libc::FUTEX_CMP_REQUEUE,
    CmpRequeuePi = libc::FUTEX_CMP_REQUEUE_PI,
    Fd = libc::FUTEX_FD,
    LockPi = libc::FUTEX_LOCK_PI,
    Requeue = libc::FUTEX_REQUEUE,
    TrylockPi = libc::FUTEX_TRYLOCK_PI,
    UnlockPi = libc::FUTEX_UNLOCK_PI,
    Wait = libc::FUTEX_WAIT,
    WaitBitset = libc::FUTEX_WAIT_BITSET,
    WaitRequeuepi = libc::FUTEX_WAIT_REQUEUE_PI,
    Wake = libc::FUTEX_WAKE,
    WakeBitset = libc::FUTEX_WAKE_BITSET,
    WakeOp = libc::FUTEX_WAKE_OP,
}

thread_local! {
    static TID: RefCell<libc::pid_t> = RefCell::new(0);
}

extern "C" fn clear_tid_on_fork() {
    TID.with(|t| *t.borrow_mut() = 0);
}

fn install_pthread_hook() {
    let result = unsafe { libc::pthread_atfork(None, None, Some(clear_tid_on_fork)) };

    errno::Errno::result(result).unwrap_or_else(|_| {
        panic!(
            "pthread_atfork(None, None, {:p}) failed",
            clear_tid_on_fork as *const ()
        )
    });
}

#[inline]
fn gettid() -> libc::pid_t {
    if unlikely(TID.with(|t| *t.borrow() == 0)) {
        initialize_per_thread();
    }

    TID.with(|t| t.borrow().clone())
}

fn gettid_impl() -> libc::pid_t {
    let result = unsafe { syscall(SYS_gettid) as libc::pid_t };

    errno::Errno::result(result).expect("gettid() failed")
}

static PTHREAD_ONCE: std::sync::Once = std::sync::Once::new();

fn initialize_per_thread() {
    TID.with(|t| *t.borrow() == gettid_impl());
    PTHREAD_ONCE.call_once(|| {
        install_pthread_hook();
    });
}

impl Futex {
    fn wait_helper(&self, op: FutexOp, value: i32, timeout: Option<time::Duration>) -> Result<i32> {
        let timeout_ts = timeout.map(|d| timespec {
            tv_sec: d.as_secs() as i64,
            tv_nsec: d.subsec_nanos() as i64,
        });

        let timeout_ptr = if let Some(t) = timeout_ts {
            &t as *const timespec
        } else {
            std::ptr::null()
        };

        let result = unsafe {
            syscall(
                SYS_futex,
                &self.0 as *const AtomicI32,
                op,
                value,
                timeout_ptr,
            ) as i32
        };

        errno::Errno::result(result)
    }
}

impl Into<libc::c_int> for WakeNumber {
    fn into(self) -> libc::c_int {
        match self {
            WakeNumber::N(i) => i as i32,
            WakeNumber::All => libc::c_int::max_value(),
        }
    }
}

impl RawFutex for Futex {
    fn wake(&self, wake: WakeNumber) -> Result<i32> {
        let wakenumber: libc::c_int = wake.into();
        let result = unsafe {
            syscall(
                SYS_futex,
                &self.0 as *const AtomicI32,
                FutexOp::Wake,
                wakenumber,
            ) as i32
        };

        errno::Errno::result(result)
    }

    fn wait(&self, value: i32, timeout: Option<time::Duration>) -> Result<i32> {
        self.wait_helper(FutexOp::Wait, value, timeout)
    }

    fn lock_pi(&self, value: i32, timeout: Option<time::Duration>) -> Result<i32> {
        self.wait_helper(FutexOp::LockPi, value, timeout)
    }

    fn trylock_pi(&self, value: i32, timeout: Option<time::Duration>) -> Result<i32> {
        self.wait_helper(FutexOp::LockPi, value, timeout)
    }

    fn unlock_pi(&self) -> Result<i32> {
        let result =
            unsafe { syscall(SYS_futex, &self.0 as *const AtomicI32, FutexOp::UnlockPi) as i32 };

        errno::Errno::result(result)
    }
}


impl FutexMutex {
    // TODO This could take a timeout but we're ignoring it until we have a time api
    #[inline]
    fn mutex_get(&self, signal_failure: bool) -> Result<()> {
        let tid = gettid();

        loop {
            // we failed to swap
            if (self.0).0.compare_and_swap(0, tid, Ordering::SeqCst) == 0 {
                let result = self.0.lock_pi(1, None);
                match result {
                    Ok(_) => break,
                    Err(NixError::Sys(errno)) => {
                        if errno == Errno::EINTR {
                            if signal_failure {
                                return Err(NixError::from_errno(Errno::EINTR));
                            } else {
                                continue;
                            }
                        } else if unlikely(errno == Errno::EDEADLK) {
                            panic!(
                                "Somehow attempted to lock {:p} multiple times (blame {})",
                                &self, tid
                            );
                        }

                        panic!("FUTEX_LOCK_PI with (futex={:p}({}), value=1, timeout=None) failed due to {}.",
                            &self.0, (self.0).0.load(Ordering::SeqCst), errno);
                    }
                    _ => panic!("Unexpected error from futex wait (this should never happen)"),
                }
            } else {
                // yay we don't have to use the kernel
                break;
            }
        }

        Ok(())
    }

    fn islocked(&self) -> bool {
        return (self.0).0.load(Ordering::Relaxed) & FUTEX_TID_MASK != gettid();
    }
}

unsafe impl RawMutex for FutexMutex {
    const INIT: FutexMutex = FutexMutex(Futex(AtomicI32::new(0)));

    type GuardMarker = lock_api::GuardSend;

    fn lock(&self) {
        self.mutex_get(false).expect(
            "Failed to grab mutex, this should be impossible since signal_failure is false.",
        );
    }

    fn unlock(&self) {
        let tid = gettid();

        let value = (self.0).0.load(Ordering::SeqCst);

        if value & FUTEX_TID_MASK != tid {
            if tid != gettid_impl() {
                panic!("Failed on unlock: task {} forked to make task {} but didn't initialize the sync logic.");
            }
            if value & FUTEX_TID_MASK == 0 {
                panic!("Multiple unlock of Mutex {:p} by {}", &self, tid);
            } else {
                panic!("Mutex {:p} already locked by {} not {}.", &self, value & FUTEX_TID_MASK, tid);
            }
        }

        if (self.0).0.compare_and_swap(tid, 0, Ordering::SeqCst) != 0 {
            let result = (self.0).unlock_pi();
            let returncode = result.unwrap_or_else(|r| {
                panic!("FUTEX_UNLOCK_PI with (futex={:p}) failed due to {}.", &self, r);
            });
            if returncode != 0 {
                panic!("FUTEX_UNLOCK_PI with (futex={:p}) failed, unlock result positive and nonzero",
                        &self);
            }
        } else {
            // no waiters, we don't have to use the kernel!
        }
    }

    fn try_lock(&self) -> bool {
        let value = (self.0).0.compare_and_swap(0, gettid(), Ordering::SeqCst);

        return value != 0;
    }
}

impl Drop for FutexMutex {
    fn drop(&mut self) {
        if unlikely(self.islocked()) {
            panic!("Trying to drop a locked mutex {:p}", &self)
        }
    }
}

pub type Mutex<T> = lock_api::Mutex<FutexMutex, T>;
pub type MutexGuard<'a, T> = lock_api::MutexGuard<'a, FutexMutex, T>;
