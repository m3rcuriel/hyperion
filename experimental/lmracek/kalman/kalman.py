from dataclasses import dataclass
import numpy as np

from experimental.lmracek.kalman.filter import Filter

@dataclass
class KalmanObservation():
    Y: np.ndarray
    U: np.ndarray

class KalmanFilter(Filter):
    """A class providing a linear Kalman filter.
    """

    def __init__(self, F, B, Q, R, H=None, initial_state=None, P0=None):
        assert F.shape[1] == F.shape[0], "State-transition model must be square."
        self.F = F
        self._state_size = F.shape[0]

        if initial_state is None:
            initial_state = np.zeros((self._state_size, 1))
        assert initial_state.shape[0] == self._state_size, \
            f"Initial state must match state size {self._state_size}"
        assert initial_state.shape[1] == 1, f"Initial state must be a {self._state_size}x1 vector"
        self._initial_state = initial_state
        self.X = initial_state

        assert Q.shape[0] == Q.shape[1], "Q must be a square matrix"
        assert Q.shape[0] == self._state_size, \
            f"Q must be a {self._state_size}x{self._state_size} matrix"
        self.Q = Q

        assert B.shape[0] == self._state_size, \
            f"control-input matrix must match state size {self._state_size}"
        self._control_size = B.shape[0]
        self.B = B

        assert R.shape[0] == R.shape[1], "R must be a square matrix"
        self._obs_size = R.shape[0]
        self.R = R
        if H is None:
            assert self._state_size == self._obs_size, \
                "If a H matrix is not provided, the state must match perfectly onto the observation"
            H = np.ones((self._state_size, self._state_size))
        assert H.shape[0] == self._obs_size and \
            H.shape[1] == self._state_size, f"H must be a {self._obs_size}x{self._state_size} matrix"
        self.H = H

        if P0 is None:
            P0 = np.zeros((self._state_size, self._state_size))
        self.P = P0
        self._P0 = P0
        self.KalmanGain = np.zeros((self._state_size, self._obs_size))
        self._steady_state = False

    def observe(self, observation):
        assert isinstance(observation, KalmanObservation)

        # predict
        X = self.F @ self.X + self.B @ observation.U
        P = self.F @ self.P @ self.F.T + self.Q

        # update
        residual = observation.Y - self.H @ X
        innovation = self.R + self.H @ self.P @ self.H.T
        self.KalmanGain = P @ self.H.T @ np.linalg.inv(innovation)
        self.X = X + self.KalmanGain @ residual
        self.P = (np.eye(self._state_size, self._state_size) - self.KalmanGain @ self.H) @ P

    def predict(self, system_input):
        X = self.F @ self.X + self.B @ system_input
        P = self.F @ self.P @ self.F.T + self.Q
        
        return X

    def reset(self, state=None, cov=None):
        if state is None:
            state = self._initial_state
        if cov is None:
            cov = self._P0
        self.X = state
        self.P = self._P0

    def set_state(self, state):
        self.reset(state)
