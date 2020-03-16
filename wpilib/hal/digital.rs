use bindings::*;
use crate::{HalResult, robot_base::RobotBase, interrupts::{Countable, InterruptableSensor}};

use std::marker::PhantomData;

pub struct DigitalInput<'a> {
    channel: i32,
    handle: HAL_DigitalHandle,
    _base: PhantomData<&'a RobotBase>,
}

impl<'a> DigitalInput<'a> {
    pub fn get(&self) -> HalResult<bool> {
        Ok(hal_call!(HAL_GetDIO, self.handle)? != 0)
    }
}

impl InterruptableSensor for DigitalInput<'_> {
    #[inline]
    fn get_port_handle(&self) -> HAL_Handle {
        self.handle
    }

    #[inline]
    fn analog_trigger_type(&self) -> HAL_AnalogTriggerType {
        HAL_AnalogTriggerType_HAL_Trigger_kInWindow
    }
}

impl Countable for DigitalInput<'_> {
    #[inline]
    fn get_channel(&self) -> i32 {
        self.channel
    }
}

pub struct PWMOutput<'a> {
    port: DigitalOutput<'a>,
    pwm_generator: HAL_DigitalPWMHandle,
}

impl<'a> PWMOutput<'a> {
    pub fn update_duty_cycle(&mut self, duty_cycle: f64) -> HalResult<()> {
        hal_call!(HAL_SetDigitalPWMDutyCycle, self.pwm_generator, duty_cycle)
    }

    pub fn downgrade(mut self) -> DigitalOutput<'a> {
        std::mem::replace(&mut self.port, DigitalOutput{channel: -1, handle: HAL_kInvalidHandle as i32, _base: PhantomData})
    }
}

impl Drop for PWMOutput<'_> {
    fn drop(&mut self) {
        if self.pwm_generator != HAL_kInvalidHandle as i32 {
            hal_call!(HAL_SetDigitalPWMOutputChannel, self.pwm_generator, HAL_GetNumDigitalChannels()).expect("Failed to route PWM to nothing");
            hal_call!(HAL_FreeDigitalPWM, self.pwm_generator).expect("Failed to free allocated PWM")
        }
    }
}

impl InterruptableSensor for PWMOutput<'_> {
    #[inline]
    fn get_port_handle(&self) -> HAL_Handle {
        self.port.handle
    }

    #[inline]
    fn analog_trigger_type(&self) -> HAL_AnalogTriggerType {
        HAL_AnalogTriggerType_HAL_Trigger_kInWindow
    }
}

impl Countable for PWMOutput<'_> {
    #[inline]
    fn get_channel(&self) -> i32 {
        self.port.channel
    }
}

pub struct DigitalOutput<'a> {
    channel: i32,
    handle: HAL_DigitalHandle,
    _base: PhantomData<&'a RobotBase>,
}

impl<'a> DigitalOutput<'a> {
    pub fn get(&self) -> HalResult<bool> {
        Ok(hal_call!(HAL_GetDIO, self.handle)? != 0)
    }

    pub fn set(&mut self, value: bool) -> HalResult<()> {
        hal_call!(HAL_SetDIO, self.handle, value as i32)
    }

    pub fn pulse(&mut self, length: f64) -> HalResult<()> {
        hal_call!(HAL_Pulse, self.handle, length)
    }

    pub fn is_pulsing(&self) -> HalResult<bool> {
        Ok(hal_call!(HAL_IsPulsing, self.handle)? != 0)
    }
}

impl InterruptableSensor for DigitalOutput<'_> {
    #[inline]
    fn get_port_handle(&self) -> HAL_Handle {
        self.handle
    }

    #[inline]
    fn analog_trigger_type(&self) -> HAL_AnalogTriggerType {
        HAL_AnalogTriggerType_HAL_Trigger_kInWindow
    }
}

impl Countable for DigitalOutput<'_> {
    #[inline]
    fn get_channel(&self) -> i32 {
        self.channel
    }
}
