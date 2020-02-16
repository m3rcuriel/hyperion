#![feature(core_intrinsics)]

use libc::{syscall, timespec, SYS_futex, SYS_gettid};
use nix::errno::Errno;
use nix::{errno, Error as NixError, Result};
use std::time;

use lock_api::RawMutex;

use std::sync::atomic::{AtomicI32, Ordering};

use std::cell::RefCell;
use std::thread_local;
use std::intrinsics::{likely, unlikely};

const FUTEX_TID_MASK: libc::pid_t = 0x3fffffff;

/// Number of tasks to wake when waking using a futex.
pub enum WakeNumber {
    /// Wake a certain number of tasks
    N(u32),
    /// Wake all tasks (platform-defined number)
    All,
}

/// Trait representing the basic primitives used in this library for futexes.
/// Higher level functionality is implemented on top of this.
pub trait RawFutex {
    /// Wakes a `WakeNumber` of tasks waiting on this futex.
    fn wake(&self, wake: WakeNumber) -> Result<i32>;

    /// Wait for the futex to be set. If it is set, will return immediately.
    /// On error will return the errno value.
    fn wait(&self, value: i32, timeout: Option<time::Duration>) -> Result<i32>;

    /// This wraps the syscall used after the user-space lock attempt fails. It checks if the
    /// futex is nonzero, and if so sets the `FUTEX_WAITERS` bit, and then attaches the waiter
    /// futex. The waiting occurs in priority order.
    fn lock_pi(&self, value: i32, timeout: Option<time::Duration>) -> Result<i32>;


    /// Attempts to acquire the lock. This is more robust than simply checking the atomic because
    /// the kernel might be able to acquire the lock in cases where the user code lacks the necessary
    /// information (i.e if user-space things are stale or someone died).
    fn trylock_pi(&self, value: i32, timeout: Option<time::Duration>) -> Result<i32>;

    /// Wakes the top priority waiter.
    fn unlock_pi(&self) -> Result<i32>;

    /// User-space atomic operation allowing a compare and swap operation on the user-space atomic
    /// data in the futex.
    fn compare_and_swap(&self, current_value: i32, new_value: i32, ordering: Ordering) -> i32;

    /// User-space atomic operation allowing a load operation on the user-space atomic
    /// data in the futex.
    fn load(&self, ordering: Ordering) -> i32;
}

/// The base Futex type. It literally has to be a 4-byte aligned integer-width piece of
/// memory and that is all.
///
/// Futexes are, from a synchronization stanadpoint, used as "events". This means that
/// they can be set or unset and can be set/unset/waited on from any other task as well.
/// They will wake up all listeners when woken.
///
/// This implementation of Futex locking is not robust against an owner dying.
///
/// When constructing this in shared memory or whatever, something along the lines of:
/// ```rust
/// # use futex::Futex;
/// # use futex::RawFutex;
/// # let shmpointer: *const i32 = &8;
/// let shmfutex: &Futex = unsafe {
///     & *(shmpointer as *const i32 as *const Futex)
/// };
/// shmfutex.lock_pi(1, None);
/// ```
///
/// Other than that the current option is to use `std::mem::zeroed`.
/// Turns out Linux primitives do not pretty Rust make.
#[repr(align(4), C)]
pub struct Futex(AtomicI32);

/// Wrapper around a Futex allowing common mutex operations.
pub struct FutexMutex<T: RawFutex>(T);

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

/// Function called after fork in the child to reset the TID
extern "C" fn clear_tid_on_fork() {
    TID.with(|t| *t.borrow_mut() = 0);
}

/// This installs the hook to clear the TID when fork is called.
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

/// Each thread running this code needs to have its thread local thread ID set,
/// and we install a hook so that a call to pthread_fork will clear the TID.
///
/// The hook should only be installed once per process.
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
        self.wait_helper(FutexOp::TrylockPi, value, timeout)
    }

    fn unlock_pi(&self) -> Result<i32> {
        let result =
            unsafe { syscall(SYS_futex, &self.0 as *const AtomicI32, FutexOp::UnlockPi) as i32 };

        errno::Errno::result(result)
    }

    #[inline]
    fn load(&self, ordering: Ordering) -> i32{
        self.0.load(ordering)
    }

    #[inline]
    fn compare_and_swap(&self, current_value: i32, new_value: i32, ordering: Ordering) -> i32 {
        self.0.compare_and_swap(current_value, new_value, ordering)
    }
}

pub enum MutexLockResult {
    SignalFailure,
    Timeout,
    Ok,
}

impl<T: RawFutex> FutexMutex<T> {
    // TODO This could take a timeout but we're ignoring it until we have a time api
    /// This method abstracts grabbing a mutex away so that we can use it for multiple different
    /// features.
    #[inline]
    fn mutex_get(&self, signal_failure: bool) -> MutexLockResult {
        // grab our TID just to check
        let tid = gettid();

        // this will be replaced with a parameter once we have a sane time api
        let timeout: Option<std::time::Instant> = None;

        let futex = &(self.0);

        loop {
            // attempt to do the fast path
            if futex.compare_and_swap(0, tid, Ordering::SeqCst) != 0 {
                // we failed to do the fast path, wait in the kernel
                let result = futex.lock_pi(1, None);

                match result {
                    // if we succeed, bail
                    Ok(_) => break,

                    // if we fail, we handle this a few different ways
                    Err(NixError::Sys(errno)) => {
                        if likely(errno == Errno::EINTR) {
                            // EINTR means a signal interrupted our syscall
                            // conditionally return or keep trying
                            if signal_failure {
                                return MutexLockResult::SignalFailure;
                            } else {
                                continue;
                            }
                        } else if timeout.is_some() && errno == Errno::ETIMEDOUT {
                            // if we set a timeout and we timeout, explain that
                            return MutexLockResult::Timeout;
                        } else if errno == Errno::EDEADLK {
                            // if this task already had the lock, give up
                            panic!(
                                "Somehow attempted to lock {:p} multiple times (blame {})",
                                &self, tid
                            );
                        }

                        // if we have no idea why we failed, tell the user that
                        panic!("FUTEX_LOCK_PI with (futex={:p}({}), value=1, timeout=None) failed due to {}.",
                            futex, futex.load(Ordering::SeqCst), errno);
                    },
                    // I hope to god this last one is impossible
                    _ => panic!("Unexpected error from futex wait (this should never happen)"),
                }
            } else {
                // yay we don't have to use the kernel
                break;
            }
        }

        MutexLockResult::Ok
    }

    /// Check if this mutex is currently locked using only the fastpath.
    fn islocked(&self) -> bool {
        return self.0.load(Ordering::Relaxed) & FUTEX_TID_MASK != gettid();
    }
}

unsafe impl RawMutex for FutexMutex<Futex> {
    const INIT: FutexMutex<Futex> = FutexMutex(Futex(AtomicI32::new(0)));

    type GuardMarker = lock_api::GuardSend;

    fn lock(&self) {
        let result = self.mutex_get(false);
        match result {
            MutexLockResult::Ok => {},
            _ => {
            panic!("Failed to grab mutex, this should be impossible since signal_failure is false and no timeout.");
            },

        }
    }

    fn unlock(&self) {
        let tid = gettid();

        let value = (self.0).load(Ordering::SeqCst);

        if unlikely(value & FUTEX_TID_MASK != tid) {
            // if the lock is held but not by us
            if tid != gettid_impl() {
                // :facepalm: we forked but didn't previously update our tid
                panic!("Failed on unlock: task {} forked to make task {} but didn't initialize the sync logic.");
            }

            if value & FUTEX_TID_MASK == 0 {
                // this futex is already unlocked
                panic!("Multiple unlock of Mutex {:p} by {}", &self, tid);
            } else {
                // this mutex is locked but not by us and we didn't fork
                panic!("Mutex {:p} already locked by {} not {}.", &self, value & FUTEX_TID_MASK, tid);
            }
        }

        // if we get here, the futex is locked by us right now

        if (self.0).compare_and_swap(tid, 0, Ordering::SeqCst) != 0 {
            // if this transaction fails, people were waiting on this futex (the value is nonzero)
            // we have to let the kernel handle the unlock
            let result = (self.0).unlock_pi();
            let returncode = result.unwrap_or_else(|r| {
                // we failed to unlock
                panic!("FUTEX_UNLOCK_PI with (futex={:p}) failed due to {}.", &self, r);
            });
            if returncode != 0 {
                // we failed to unlock
                panic!("FUTEX_UNLOCK_PI with (futex={:p}) failed, unlock result positive and nonzero",
                        &self);
            }
        } else {
            // no waiters, we don't have to use the kernel!
        }
    }

    fn try_lock(&self) -> bool {
        // Attempt to do the baseline atomic transaction.
        let value = (self.0).compare_and_swap(0, gettid(), Ordering::SeqCst);

        // If this is not equal to 0, we failed to lock.
        return value == 0;
    }
}

impl<T: RawFutex> Drop for FutexMutex<T> {
    fn drop(&mut self) {
        if unlikely(self.islocked()) {
            panic!("Trying to drop a locked mutex {:p}", &self)
        }
    }
}

pub type Mutex<T> = lock_api::Mutex<FutexMutex<Futex>, T>;
pub type MutexGuard<'a, T> = lock_api::MutexGuard<'a, FutexMutex<Futex>, T>;
