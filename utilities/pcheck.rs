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
