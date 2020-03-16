use bindings::*;

use crate::HalResult;

pub trait InterruptableSensor {
    fn get_port_handle(&self) -> HAL_Handle;
    fn analog_trigger_type(&self) -> HAL_AnalogTriggerType;
}

pub trait Countable : InterruptableSensor {
   fn get_channel(&self) -> i32;
}

pub struct InterruptingSensor<'a, T: InterruptableSensor> {
    interrupt_handle: HAL_Handle,
    sensor: &'a T,
}

pub enum SourceEdge {
    Rising,
    Falling,
    None,
    Both,
}

pub enum WaitResult {
    Timeout,
    RisingEdge,
    FallingEdge,
    Both,
}

// TODO add type safety for enabled by creating an InterruptHandle wrapper
impl<T: InterruptableSensor> InterruptingSensor<'_, T> {
    fn allocate(&mut self, watcher: bool) -> HalResult<HAL_Handle> {
        assert_eq!(self.interrupt_handle, HAL_kInvalidHandle as i32);

        hal_call!(HAL_InitializeInterrupts, watcher as i32)
    }

    // Should be called inside of construction methods
    fn request(&mut self) -> HalResult<()>{
        self.interrupt_handle = self.allocate(true)?;

        hal_call!(HAL_RequestInterrupts, self.interrupt_handle, self.sensor.get_port_handle(), self.sensor.analog_trigger_type())?;
        self.set_up_source_edge(SourceEdge::Rising)
    }

    pub fn set_up_source_edge(&mut self, edges: SourceEdge) -> HalResult<()> {
        let (rising, falling) = match edges {
            SourceEdge::Rising => (true, false),
            SourceEdge::Falling => (false, true),
            SourceEdge::None => (false, false),
            SourceEdge::Both => (true, true)
        };

        hal_call!(HAL_SetInterruptUpSourceEdge, self.interrupt_handle, rising as i32, falling as i32)
    }

    pub fn wait(&mut self, timeout: f64, ignore_previous: bool) -> HalResult<WaitResult> {
        let result = hal_call!(HAL_WaitForInterrupt, self.interrupt_handle, timeout, ignore_previous as i32)?;

        let rising = result & 0xFF != 0;
        let falling = result & 0xFF00 != 0;
        Ok(match (rising, falling) {
            (false, false) => WaitResult::Timeout,
            (true, false) => WaitResult::RisingEdge,
            (false, true) => WaitResult::FallingEdge,
            (true, true) => WaitResult::Both,
        })
    }

    pub fn enable(&mut self) -> HalResult<()> {
        assert_eq!(self.interrupt_handle, HAL_kInvalidHandle as i32);

        hal_call!(HAL_EnableInterrupts, self.interrupt_handle)
    }
}

impl<T: InterruptableSensor> Drop for InterruptingSensor<'_, T> {
    fn drop(&mut self) {
        let _ = hal_call!(HAL_CleanInterrupts, self.interrupt_handle);
    }
}
