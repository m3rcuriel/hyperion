#[macro_export]
macro_rules! pcheck {
    ($function:ident($($arg:expr),* $(,)?)) => {{
        unsafe {
            errno::Errno::result($function($($arg,) *))
        }.unwrap_or_else(|e| panic!("{} failed due to {}", concat!(stringify!($function), stringify!(($($arg), *))), e));
    }};
    ($function:ident($($arg:expr),* $(,)?), $fmt:expr, $($fmtarg:tt)*) => {{
        unsafe {
            errno::Errno::result($function($($arg,) *))
        }.unwrap_or_else(|e| panic!("{} failed due to {}{}", concat!(stringify!($function), stringify!(($($arg), *))), e, format!($fmt, $($fmtarg), *)));
    }};
}
