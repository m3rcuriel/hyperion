use libc::{syscall, SYS_futex, timespec};
use nix::{errno, Result};
use std::time;

use std::thread_local;
use std::cell::RefCell;

enum WakeNumber {
    N(u32),
    All,
}

trait RawFutex {
    fn wake(&mut self, wake: WakeNumber) -> Result<i32>;
    fn wait(&mut self, value: i32, timeout: Option<time::Duration>) -> Result<i32>;
    fn lock_pi(&mut self, value: i32, timeout: Option<time::Duration>) -> Result<i32>;
    fn trylock_pi(&mut self, value: i32, timeout: Option<time::Duration>) -> Result<i32>;
    fn compare_requeue_pi(&mut self, num_wake: WakeNumber, num_requeue: WakeNumber, m: &mut Self, val: u32) -> Result<i32>;
}

#[repr(align(4), C)]
struct Futex(i32);

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

fn install_pthread_hook() -> Result<i32> {
    let result = unsafe { libc::pthread_atfork(None, None, Some(clear_tid_on_fork)) };

    errno::Errno::result(result)
}

impl Futex {
    fn wait_helper(&mut self, op: FutexOp, value: i32, timeout: Option<time::Duration>) -> Result<i32> {
        let timeout_ts = timeout.map(|d| timespec{tv_sec: d.as_secs() as i64, tv_nsec: d.subsec_nanos() as i64});

        let timeout_ptr = if let Some(t) = timeout_ts {
            &t as *const timespec
        } else {
            std::ptr::null()
        };

        let result = unsafe {
            syscall(SYS_futex, &mut self.0 as *mut i32, op, value, timeout_ts.map_or(std::ptr::null(), |t| &t as *const timespec)) as i32
        };

        errno::Errno::result(result)
    }
}

impl Into<libc::c_int> for WakeNumber {
    fn into(self) -> libc::c_int {
        match self {
            WakeNumber::N(i) => i as i32,
            WakeNumber::All => libc::c_int::max_value()
        }
    }
}

impl RawFutex for Futex {
    fn wake(&mut self, wake: WakeNumber) -> Result<i32> {
        let wakenumber: libc::c_int = wake.into();
        let result = unsafe {
            syscall(SYS_futex, &mut self.0 as *mut i32, FutexOp::Wake, wakenumber) as i32
        };

        errno::Errno::result(result)
    }

    fn wait(&mut self, value: i32, timeout: Option<time::Duration>) -> Result<i32> {
        self.wait_helper(FutexOp::Wait, value, timeout)
    }

    fn lock_pi(&mut self, value: i32, timeout: Option<time::Duration>) -> Result<i32> {
        self.wait_helper(FutexOp::LockPi, value, timeout)
    }

    fn trylock_pi(&mut self, value: i32, timeout: Option<time::Duration>) -> Result<i32> {
        self.wait_helper(FutexOp::LockPi, value, timeout)
    }

    fn compare_requeue_pi(&mut self, num_wake: WakeNumber, num_requeue: WakeNumber, m: &mut Self, val: u32) -> Result<i32> {

    }
}
