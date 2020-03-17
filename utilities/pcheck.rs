/// Allows you to wrap syscalls such that failure of the syscall causes a panic and error dump.
///
/// Ex:
/// `pcheck!(set_scheduler(0, SCHED_FIFO, priority))` 
///
/// Additional arguments can be provided; provided the first argument is a syscall, the second
/// optional argument is custom error text, and the third optional argument is a custom error
/// format (per format! specs). 
#[macro_export]
macro_rules! pcheck {
    ($function:expr) => {{
        unsafe {
            errno::Errno::result($function)
        }.unwrap_or_else(|e| panic!("{} failed due to {}", stringify!($function), e));
    }};
    ($function:expr, $text:expr) => {{
        unsafe {
            errno::Errno::result($function)
        }.unwrap_or_else(|e| panic!("{} failed due to {}{}", stringify!($function), e, $text));
    }};
    ($function:expr, $fmt:expr, $($fmtarg:tt)*) => {{
        unsafe {
            errno::Errno::result($function)
        }.unwrap_or_else(|e| panic!("{} failed due to {}{}", stringify!($function), e, format!($fmt, $($fmtarg), *)));
    }};
}
