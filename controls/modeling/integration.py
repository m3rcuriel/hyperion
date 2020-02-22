def RungeKutta4(f, X, dt):
    """Perform a 4th order Runge Kutta integration for the
    given timestep using dynamics.

    For a system with inputs, one can easily model a zero-order
    hold as something along the lines of `lambda x: f(x, U)`.

    Args:
        f (Callable): function taking as inputs a current state
            and returning state derivatives
        X: current state before integration
        dt: time period to integrate for (same unit as dynamics)
    """
    k1 = f(X)
    k2 = f(X + dt / 2.0 * k1)
    k3 = f(X + dt / 2.0 * k2)
    k4 = f(X + dt * k3)
    return X + dt * (k1 + 2.0 * k2 + 2.0 * k3 + k4) / 6.0


def RungeKuttaWithInput(f, X, U, dt):
    """Convenience wrapper for :meth:`~control.modeling.integration.RungeKutta4`
    which does a zero-order hold on the input.

    Args:
        f (Callable): function taking as inputs a current state
            and returning state derivatives
        X: current state before integration
        U: current input
        dt: time period to integrate for (same unit as dynamics)
    """
    return RungeKutta4(lambda currX: f(currX, U), X, dt)
