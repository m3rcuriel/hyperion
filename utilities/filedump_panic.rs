use std::fs::File;
use std::panic::{self, PanicInfo};
use backtrace::Backtrace;

use std::io::Write;

use nix::unistd::getpid;

fn get_file() -> String {
  format!("/tmp/hyperion_core_dump.{}", getpid())
}

// TODO do we want to have this log to our logging system as well or just scream loudly
fn file_panic(info: &PanicInfo) {
  let backtrace = Backtrace::new();

  eprintln!("FATAL ERROR!!!");

  eprintln!("{}\n", info);

  eprintln!("{:?}", backtrace);
  println!("FATAL ERROR!!! details in stderr");

  let file_location = get_file();

  let file_result = File::create(&file_location);

  if let Ok(mut file) = file_result {
    writeln!(file, "FATAL ERROR!!!").unwrap();

    writeln!(file, "{}\n", info).unwrap();
    writeln!(file, "{:?}", backtrace).unwrap();
  } else {
    eprintln!("Fatal error attempting to open '{}'", file_location);
  }
}

pub fn register_panic() {
  panic::set_hook(Box::new(file_panic));
}

#[cfg(test)]
mod tests {
  use super::*;

  #[test]
  #[should_panic]
  fn test_panic_works() {
    register_panic();
    panic!("{} panic", 1);
  }
}
