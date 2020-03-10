import numpy as np

from controls import lti_utils


class Motor(object):
    def __init__(
        self, model, gear_ratio, moment, efficiency=1.0, sensor_ratio=1.0, dt=None
    ):

        self.model = model

        self.moment = moment + model.motor_inertia / gear_ratio ** 2.0

        self.motor_torque = (
            efficiency
            * self.model.torque_constant
            / (gear_ratio * self.model.resistance)
        )

        self.back_emf = self.model.torque_constant / (
            self.model.velocity_constant * self.model.resistance * gear_ratio ** 2.0
        )

        self.torque_to_acceleration = 1.0 / self.moment

        A_c = np.asarray([[0.0, 1.0], [0.0, -self.torque_to_acceleration * self.back_emf]])
        B_c = np.asarray([[0.0], [self.torque_to_acceleration * self.motor_torque]])

        self.C = np.asarray([0.0, sensor_ratio])
        self.D = np.asarray([[0.0]])

        self.dt = dt

        if self.dt:
            A_d, B_d, _, _ = lti_utils.discretize(A_c, B_c, self.dt, None, None)
            self.A = A_d
            self.B = B_d
        else:
            self.A = A_c
            self.B = B_c

        self.X = np.asarray([[0.0], [0.0]])

    def update(self, voltage, dt=None):
        assert dt or self.dt, "Must either provide a dt or provide one at construction"

        A_d, B_d = self.A, self.B
        if not self.dt:
            A_d, B_d, _, _ = lti_utils.discretize(self.A, self.B, dt, None, None)

        self.X = A_d @ self.X + B_d @ voltage

    @property
    def output(self):
        return self.C @ self.X


class MultipleMotor(object):
    def __init__(self, model, num_motors):
        self.model = model

        self.stall_torque = model.stall_torque * num_motors
        self.stall_current = model.stall_current * num_motors
        self.free_speed = model.free_speed

        self.free_current = model.free_current * num_motors
        self.resistance = model.resistance / num_motors
        self.velocity_constant = model.velocity_constant
        self.torque_constant = model.torque_constant
        self.motor_inertia = model.motor_inertia * num_motors
