use bindings::HAL_GetErrorMessage;

use std::{fmt, error::Error, ffi::CStr};

#[derive(Copy, Clone)]
pub struct HalError{pub code: i32}

fn get_hal_message(code: i32) -> &'static str {
    // I'm almost certain that the HAL error messages are static
    // binary data, since they say you don't have to free them.
    //
    // The default option would probably be to use a Cow<str>
    // so we can use to_string_lossy, but having read the error
    // messages they should all be valid UTF-8, so we'll just
    // panic if they aren't.

    unsafe { CStr::from_ptr(HAL_GetErrorMessage(code)) }.to_str().unwrap()
}

impl fmt::Debug for HalError {
    fn fmt(&self, f: &mut fmt::Formatter) -> Result<(), fmt::Error> {
        write!(f, "HalError {}: {{ {} }}", self.code, get_hal_message(self.code))
    }
}

impl fmt::Display for HalError {
    fn fmt(&self, f: &mut fmt::Formatter) -> Result<(), fmt::Error> {
        write!(f, "HalError \"{}\"", get_hal_message(self.code))
    }
}

impl Error for HalError {}

impl From<i32> for HalError {
    fn from(code: i32) -> Self {
        HalError{code}
    }
}

pub type HalResult<T> = Result<T, HalError>;

#[macro_export]
macro_rules! hal_call {
    ($function:path, $($arg:expr),* $(,)?) => {{
        let mut status = 0i32;
        let result = unsafe { $function($($arg,)* &mut status)};
        match status {
            0 => Err($crate::HalError::from(status)),
            _ => Ok(result),
        }
    }};
}
