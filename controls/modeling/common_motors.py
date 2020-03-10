import numpy as np


class CIM(object):
    def __init__(self):
        self.stall_torque = 2.42
        self.stall_current = 133.0
        self.free_speed = 5500.0 / 60.0 * 2.0 * np.pi
        self.free_current = 4.7
        self.resistance = 12.0 / self.stall_current

        self.velocity_constant = self.free_speed / (
            12.0 - self.resistance * self.free_current
        )
        self.torque_constant = self.stall_torque / self.stall_current

        # no one measured this yet
        self.motor_inertia = 0.0


class MiniCIM(object):
    def __init__(self):
        self.stall_torque = 1.41
        self.stall_current = 89.0
        self.free_speed = 5840.0 / 60.0 * 2.0 * np.pi
        self.free_current = 3.0
        self.resistance = 12.0 / self.stall_current

        self.velocity_constant = self.free_speed / (
            12.0 - self.resistance * self.free_current
        )
        self.torque_constant = self.stall_torque / self.stall_current

        # no one measured this yet
        self.motor_inertia = 0.0


class BAG(object):
    def __init__(self):
        self.stall_torque = 0.43
        self.stall_current = 53.0
        self.free_speed = 13180.0 / 60.0 * 2.0 * np.pi
        self.free_current = 1.8
        self.resistance = 12.0 / self.stall_current

        self.velocity_constant = self.free_speed / (
            12.0 - self.resistance * self.free_current
        )
        self.torque_constant = self.stall_torque / self.stall_current
        self.motor_inertia = 0.000006


class Vex775Pro(object):
    def __init__(self):
        self.stall_torque = 0.708
        self.stall_current = 133.6
        self.free_speed = 18734.0 / 60.0 * 2.0 * np.pi
        self.free_current = 0.699
        self.resistance = 12.0 / self.stall_current

        self.velocity_constant = self.free_speed / (
            12.0 - self.resistance * self.free_current
        )

        self.torque_constant = self.stall_torque / self.stall_current
        self.motor_inertia = 0.00001187
