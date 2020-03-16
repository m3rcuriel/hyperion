#[macro_use]
mod error;

// Re-export result types since they don't
// need to be opaque.
pub use self::error::{HalError, HalResult};

mod robot_base;

pub mod digital;

mod interrupts;

pub use self::interrupts::InterruptingSensor;

mod pneumatics;
