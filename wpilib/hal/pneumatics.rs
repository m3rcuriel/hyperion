use bindings::*;
use crate::robot_base::RobotBase;
use crate::error::HalResult;

use std::marker::PhantomData;

fn check_valid(module: i32) -> bool {
    unsafe { HAL_CheckSolenoidModule(module) != 0 }
}

pub struct PneumaticsControlModule<'a> {
    module: i32,
    handles: [HAL_Handle; 8],
    values: i32,
    base: PhantomData<&'a RobotBase>,
}

impl Default for PneumaticsControlModule<'_> {
    fn default() -> Self {
        Self::new(0).expect("PCM 0 should never be invalid!")
    }
}

impl<'a> PneumaticsControlModule<'a> {
    fn initialize_solenoids(&mut self) -> HalResult<()> {
        for i in 0..8 {
            let portmodule = unsafe { HAL_GetPortWithModule(self.module, i as i32) };
            self.handles[i] = hal_call!(HAL_InitializeSolenoidPort, portmodule)?;
        }
        Ok(())
    }

    pub fn new(module: i32) -> Option<Self> {
        if check_valid(module) {
            let mut output = Self{ module, handles: [HAL_kInvalidHandle as i32; 8], values: 0, base: PhantomData };
            output.initialize_solenoids().expect("Failed to initialize solenoids");
            Some(output)
        } else {
            None
        }
    }

    pub fn get_all(self) -> HalResult<i32> {
        let values = hal_call!(HAL_GetAllSolenoids, self.module)?;
        Ok(values)
    }

    pub fn flush(&self) -> HalResult<()> {
        hal_call!(HAL_SetAllSolenoids, self.module, self.values as i32)?;
        Ok(())
    }

    pub fn set_solenoid(&mut self, channel: i32, value: bool) {
        self.values |= (value as i32) << channel;
    }
}

impl Drop for PneumaticsControlModule<'_> {
    fn drop(&mut self) {
        for &handle in self.handles.iter() {
            unsafe { HAL_FreeSolenoidPort(handle) };
        }
    }
}
