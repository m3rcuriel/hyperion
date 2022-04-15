import numpy as np

from controls.modeling.integration import RungeKuttaWithInput

import math


class ConventionalModule(object):
    """Container class wrapping the continuous dynamics of a conventional swerve module.

    Note that unlike DifferentialModule this could provide a pre-discretized model as well
    but currently does not.

    Attributes:
        linear_motor: The DcMotor which drives the wheel rotation
        angular_motor: The DcMotor which drives the module rotation
    """

    def __init__(self, angular, linear):
        """Initialize ConventionalModule with the provided angular and linear motor models.

        Motors should be passed in as continuous (i.e constructed without fixed dt) to allow
        for modeling as part of a more complex structure.

        Args:
            linear_motor: The DcMotor which drives the wheel rotation (continuous)
            angular_motor: The DcMotor which drives the module rotation (continuous)
        """
        self.angular_motor = angular
        self.linear_motor = linear

    def dynamics(self, X, U):
        """Return the continuous dynamics of a conventional swerve module.

        Args:
            X: colum vector [module angle, module velocity, wheel velocity,
                module disturbance torque, wheel disturbance torque]
            U: column vector [module voltage, wheel voltage]

        Returns:
            Dynamics as derivatives of the states

        """
        dynamics = np.asarray(np.zeros((5, 1)))

        # This is just the normal evolution of a motor model. We include torque error instead of voltage error (like
        # the traditional model) to match the differential model which has advantages from using torque error instead.
        dynamics[0:2] = (
            self.angular_motor.A @ X[0:2]
            + self.angular_motor.B * U[0]
            + X[3] * np.asarray([[0], [self.angular_motor.torque_to_acceleration]])
        )

        # This is the dynamics for a motor where we only care about the velocity of the motor. In the end the global
        # controller only depends on torque and torque is not a function of position.
        dynamics[2] = (
            self.linear_motor.A[1, 1] * X[2]
            + self.linear_motor.B[1] * U[1]
            + X[4] * self.linear_motor.torque_to_acceleration
        )

        # We assume that the torque error doesn't evolve (any estimator will fix these assumptions)
        dynamics[3] = 0.0
        dynamics[4] = 0.0

        return dynamics


class DifferentialModule(object):
    """Container class wrapping the dynamics of a differential swerve module.

    This class assumes that the differential model is in the 971 format (mainly because
    I don't know if it currently extrapolates) and furthermore that the gears on either
    side of the differential are identical.

    Attributes:
        motor1: DcMotor which drives the upper large bevel gear (continuous)
        motor2: DcMotor which drives the lower large bevel gear (continuous)
    """

    # TODO include a diagram
    def __init__(self, motor1, motor2, J1, J3, J4, G):
        """Initializes a DifferentialModule with the given module parameters.

        Args
            motor1: a DcMotor representing one of the motors in the module. Motor should
                be pre-configured with the gear ratio up to the differential.
            motor2: a DcMotor representing one of the motors in the module. Motor should
                be pre-configured with the gear ratio up to the differential.
            J1: the moment of inertia of the large bevel gears
            J3: the moment of inertia of the small wheel rotation driving gear
            J4: the moment of inertia of the whole rotating part of the module
            G: the gear ratio between the small wheel driving gear and the large bevel
                gear, i.e Nphi / N1
        """
        self.motor1 = motor1
        self.motor2 = motor2

        self.J1 = J1
        self.J3 = J3
        self.J4 = J4

        self.G = G

    def dynamics(self, X, U):
        """Returns the continuous dynamics of a differential swerve module as derivatives
        of the states.

        Args:
            X: column vector [module angle, module velocity, wheel velocity,
                module disturbance torque, wheel disturbance torque]
            U: column vector [motor 1 voltage, motor 2 voltage]
        """
        dynamics = np.matrix(np.zeros((5, 1)))

        # module angle' = module velocity
        dynamics[0] = X[1]

        # use the equations from my paper to calculate motor1 and motor2 velocities
        # based on the state
        velocity_1 = X[1] - self.G * X[2]
        velocity_2 = X[1] + self.G * X[2]

        # standard motor calculation for torque output (instead of acceleration)
        T1 = self.motor1.motor_torque * U[0] - self.motor1.back_emf * velocity_1
        T2 = self.motor2.motor_torque * U[1] - self.motor2.back_emf * velocity_2

        # moment calculated in paper
        theta_moment = self.J4 + 2 * self.J1

        # module angle'' = sum of all the torques in the system appropriately scaled
        # this is because the module angle acceleration comes directly from motor1
        # and motor2
        dynamics[1] = T1 / theta_moment + T2 / theta_moment + X[3] / theta_moment

        # wheel moment calculated in paper
        wheel_moment = self.J3 + 2 * self.G ** 2.0 * self.J1

        # wheel angle'' = difference between the two torques scaled by the appropriate
        # gear ratio, plus the disturbance torque.
        dynamics[2] = (
            (self.G * T2 / wheel_moment)
            - (self.G * T1 / wheel_moment)
            + (X[4] / wheel_moment)
        )

        # torque disturbances are assumed to not evolve (estimator fixes this assumption)
        dynamics[3] = 0.0
        dynamics[4] = 0.0

        return dynamics


class ModuleSimulation(object):
    """Simulation of a single module for a provided duration based on a provided starting
    position and inputs.

    Not really useful outside of verifying that models behave as expected.
    """

    def __init__(self, module, x_initial, dt=0.005):
        """Initialize the module simulation with given initial states and timestep.

        Args:
            module: The swerve module model to used
            x_initial: the initial 5-dimensional state of the module
            dt (:obj: `int`, optional): the timestep to use for the simulation, defaults
                to 5 milliseconds
        """
        self.module = module
        self.x_initial = x_initial
        self.dt = dt

    def reset(self):
        """Reset the simulation.
        """
        self.X = self.x_initial

        self.x_history = []
        self.u_history = []
        self.t_history = []

    def run(self, U, total_time):
        self.reset()
        self.t_history = np.linspace(0, total_time, math.ceil(total_time / self.dt + 1))

        for u, t in zip(U, self.t_history):
            self.x_history.append(self.X)
            self.u_history.append(u)
            print(self.X)
            self.X = RungeKuttaWithInput(self.module.dynamics, self.X, u, self.dt)

        self.display()

    def display(self):
        """Display the plots taken over a run showing the position and velocity states
        as well as inputs."""

        import matplotlib.pyplot as plt

        fig = plt.figure()

        for i in range(3):
            ax = fig.add_subplot(4, 1, i + 1)

            ax.plot(
                self.t_history,
                [v[i, 0] for v in self.x_history],
                label="X[{}]".format(i),
            )

            ax.legend()

        ax = fig.add_subplot(4, 1, 4)

        ax.plot(self.t_history, self.u_history, label="u[0]")

        ax.legend()

        plt.tight_layout()

        plt.show()
