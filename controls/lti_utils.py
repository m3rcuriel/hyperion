import numpy as np
import scipy.linalg

def discretize(A, B, dt, Q=None, R=None):
    """
    Transform the system described by A and B into the discrete time matrices
    A_d and B_d. Also translates the process and measurement noise Q and R
    optionally.

    :param A: # of states x # of states continuous-time system transition matrix
    :type A: matrix-like
    :param B: # of states x # of inputs continuous-time control matrix
    :type B: matrix-like
    :param dt: The time step to use in the discretization
    :type dt: double
    :returns: (A_d, B_d, [Q_d], [R_d])
        - A_d - discretized system transition matrix
        - B_d - discretized control matrix
        - [Q_d] - discretized process noise matrix
        - [R_d] - discretized measurement noise matrix
    """

    A = np.asarray(A)
    B = np.asarray(B)

    states = A.shape[0]
    inputs = B.shape[1]
    exp = np.asarray(np.zeros((states + inputs, states + inputs)))
    exp[:states, :states] = A
    exp[:states, states : states + inputs] = B

    # wikipedia: this leads to result
    # [[A_d, B_d],
    #  [0  , I  ]]
    result = scipy.linalg.expm(exp * dt)
    A_d = result[:states, :states],
    B_d = result[:states, states : states + inputs]

    Q_d = None
    R_d = None

    if Q is not None:
        Q = np.asmatrix(Q)

        # TODO(m3rcuriel) write better docs
        assert Q.shape == A.shape, "Q must match A"

        qexp = np.asmatrix(np.zeros((states + states, states + states)))
        qexp[:states, :states] = -A
        qexp[states : states + states, states : states + states] = A.T
        qexp[:states, states : states + states] = Q

        qresult = scipy.linalg.expm(qexp * dt)

        A_d_T = qresult[states : states + states, states : states + states]
        Q_d = (A_d_T).T * (
            np.linalg.inv(A_d_T) * qresult[:states, states : states + states]
        )

    if R is not None:
        R_d = R * dt

    return (A_d, B_d, Q_d, R_d)


def controllability(A, B):
    """
    Calculate the controllability matrix of the system defined by A and B matrices.

    This matrix can be used to determine if a system is fully controllable, i.e if
    rank(controllability(system)) == # of states.

    :param A: n*n matrix describing the system dynamics
    :type A: matrix-like
    :param B: n*m matrix describing the contol signal dynamics
    :type B: matrix-like
    :return: The controllability matrix for the system
    """
    A = np.asmatrix(A)
    B = np.asmatrix(B)

    states = A.shape[0]
    inputs = B.shape[1]
    cont = np.asmatrix(np.zeros((states, states * inputs)))
    runningExponent = B

    # Construct R = [B AB A^2B A^3B ... ]
    for i in range(0, states, inputs):
        cont[:states, i : i + inputs] = runningExponent
        runningExponent = A * runningExponent

    return cont


def observability(A, C):
    """
    Calculate the observability matrix of the system defined by A and C
        matrices.

    This matrix can be used to determine if a system is fully controllable, i.e if
    rank(observability(system)) == # of states.

    :param A: # of states x # of states matrix describing the system dynamics
    :type A: matrix-like
    :param C: # of states x # of outputs matrix describing the contol signal
        dynamics
    :type C: matrix-like
    :return: The controllability matrix for the system
    """
    A = np.asmatrix(A)
    C = np.asmatrix(C)

    states = A.shape[0]
    outputs = C.shape[0]
    obs = np.asmatrix(np.zeros((states * outputs, states)))
    runningExponent = C

    # Construct R = [B AB A^2B A^3B ... ]
    for i in range(0, states, outputs):
        obs[i : i + outputs, :states] = runningExponent
        runningExponent = runningExponent * A

    return obs


def continuous_lqr(A, B, Q, R):
    """
    Use cost weights Q and R to calculate the steady-state LQR gain matrix.

    :param A: # of states x # of states system transition matrix
    :param B: # of states x # of inputs control input matrix
    :param Q: # of states x # of states state weight matrix
    :param R: # of inputs x # of inputs control weight matrix
    :returns: K - # of inputs x # of states matrix
    """

    A = np.asmatrix(A)
    B = np.asmatrix(B)
    Q = np.asmatrix(Q)
    R = np.asmatrix(R)

    assert (
        np.linalg.matrix_rank(controllability(A, B)) == A.shape[0]
    ), "System must be controllable"

    M = np.asmatrix(scipy.linalg.solve_continuous_are(A, B, Q, R))

    return np.asmatrix(np.linalg.inv(R) * B.T * M)


def discrete_lqr(A, B, Q, R):
    """
    Use cost weights Q and R to calculate the steady-state LQR gain matrix.

    :param A: # of states x # of states system transition matrix
    :param B: # of states x # of inputs control input matrix
    :param Q: # of states x # of states state weight matrix
    :param R: # of inputs x # of inputs control weight matrix
    :returns: K - # of inputs x # of states matrix
    """

    A = np.asmatrix(A)
    B = np.asmatrix(B)
    Q = np.asmatrix(Q)
    R = np.asmatrix(R)

    assert (
        np.linalg.matrix_rank(controllability(A, B)) == A.shape[0]
    ), "System must be controllable"

    M = np.asmatrix(scipy.linalg.solve_continuous_are(A, B, Q, R))

    return np.asmatrix(np.linalg.inv(R + B.T * M * B) * B.T * M * A)


def discrete_kalman(A, C, Q, R):
    A = np.asmatrix(A)
    C = np.asmatrix(C)
    Q = np.asmatrix(Q)
    R = np.asmatrix(R)

    assert (
        np.linalg.matrix_rank(observability(A, C)) == A.shape[0]
    ), "System must be observable"

    P = np.asmatrix(scipy.linalg.solve_discrete_are(A.T, C.T, Q, R))

    return np.asmatrix(P * C.T * np.linalg.inv(R))


def continuous_kalman(A, C, Q, R):
    A = np.asmatrix(A)
    C = np.asmatrix(C)
    Q = np.asmatrix(Q)
    R = np.asmatrix(R)

    assert (
        np.linalg.matrix_rank(observability(A, C)) == A.shape[0]
    ), "System must be observable"

    P = np.asmatrix(scipy.linalg.solve_continuous_are(A.T, C.T, Q, R))

    return np.asmatrix(P * C.T * np.linalg.inv(R))


def feedforwards(A, B, Q=None):
    """
    :param A: # of states x # of states system transition matrix
    :param B: # of states x # of inputs control input matrix
    :param Q: # of states x # of states feedforwards weight matrix
    :returns: # of inputs x # of states optimal feedforwards control matrix
    """

    if Q is None:
        return np.linalg.pinv(B)
    else:
        return np.linalg.inv(B.T * Q * B) * B.T * Q
