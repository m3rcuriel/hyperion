#[cfg(debug_assertions)]
#[macro_export]
macro_rules! unreachable {
    () => { std::unreachable!() };
    ($ msg : expr) => { std::unreachable!($msg) };
    ($ msg : expr,) => { std::unreachable!($msg,) };
    ($ fmt : expr, $ ($ arg : tt) *) => { std::unreachable!($fmt, $ ($ arg ) *) };
}

#[cfg(not(debug_assertions))]
#[macro_export]
macro_rules! unreachable {
    () => std::unreachable_unchecked();
    ($ msg : expr) => std::hints::unreachable_unchecked();
    ($ msg : expr,) => std::hints::unreachable_unchecked();
    ($ fmt : expr, $ ($ arg : tt) *) => std::hints::unreachable_unchecked();
}
