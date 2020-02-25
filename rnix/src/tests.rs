use libc::{c_int, c_uint, c_ulonglong, ssize_t};
use nix::unistd::{fork, read, write, ForkResult};
use rnix::{*};
use rnix::flags::{*};
use std::os::unix::io::{RawFd};
use std::{thread, time};

#[cfg(test)]
mod tests {
    #[test]
    fn it_works() {
        assert_eq!(2 + 2, 4);
    }

    #[test]
    fn test_eventfd() {

        // Literally just the code that man 2 eventfd gives you
        unsafe {
            let efd = rnix::eventfd(0, ErrNo::from_bits(0).unwrap())
                .ok().unwrap();
            
            match fork() {
                Ok(ForkResult::Child) => {
                    println!("Writing to efd...");
                    let mut array: [c_ulonglong; 1] = [888];
                    write(efd, array);
                }
                - => {
                    thread::sleep(time::Duration::from_millis(2000));
                    println!("Reading from efd...");
                    
                    let mut array: [c_ulonglong; 1] = [0; 1];
                    let s = read(efd, &mut array);

                    if s.is_some() {
                        println!("Read {}", s as c_ulonglong);
                        assert_eq!(888, s.ok().unwrap());
                    }
                }
            }
        }
    }
}
