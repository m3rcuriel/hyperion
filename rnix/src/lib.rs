#![cfg(unix)]
#![allow(non_camel_case_types)]

#[macro_use]
pub extern crate bitflags;
pub extern crate libc;

pub mod flags {

    use libc::{c_int, c_uint};

    bitflags! {
        pub struct EfdFlag: c_int {
            const EFD_CLOEXEC   = libc::EFD_CLOEXEC;
            const EFD_NONBLOCK  = libc::EFD_NONBLOCK;
            const EFD_SEMAPHORE = libc::EFD_SEMAPHORE;
        }
    }

    bitflags! {
        pub struct ErrNo: c_int {
            const EINVAL = libc::EINVAL;
            const EMFILE = libc::EMFILE;
            const ENFILE = libc::ENFILE;
            const ENODEV = libc::ENODEV;
            const ENOMEM = libc::ENOMEM;
            const ECATCHALL = 0; // placeholder error
            // This is incomplete!!
        }
    }
}

use libc::{c_int, c_uint};
use libc::{__errno_location};
use std::os::unix::io::{RawFd};
use flags::{*};
use Result;

pub fn eventfd(init: c_uint,
               flags: flags::EfdFlag) -> Result<RawFd, flags::ErrNo> {

    let result: c_int  = unsafe {
        libc::eventfd(init, flags.bits())
    };

    match result {
       -1 => {
           let errno: c_int = unsafe { *__errno_location() };
           Err(flags::ErrNo::from_bits(errno).unwrap_or(ErrNo::ECATCHALL))
       },
       _ => Ok(result as RawFd),
    }
}
