#!/usr/bin/env python
import pytest
import numpy as np
import sys

from experimental.lmracek.kalman.kalman import KalmanFilter, KalmanObservation

def test_assertions():
    transition = np.array([[1, 2, 3], [1, 2, 3], [1, 2, 3]])
    initial_state = np.array([[3, 5, 6]]).T
    control_input = np.array([[0, 0, 0]]).T
    process_noise = np.array([[0, 0, 0], [0, .1, 0], [0, .8, 0]])
    observation_noise = np.array([[1, 0], [0, 1]]).T
    observation_model = np.array([[1, 1, 1], [1, 0, 0]])

    k = KalmanFilter(transition,
                     control_input,
                     process_noise,
                     observation_noise,
                     observation_model,
                     initial_state)

    with pytest.raises(AssertionError):
        KalmanFilter(transition,
                     control_input,
                     process_noise,
                     observation_noise,
                     observation_model,
                     np.array([[1, 2]]))

    with pytest.raises(AssertionError):
        KalmanFilter(transition,
                     control_input,
                     process_noise,
                     observation_noise,
                     observation_model,
                     np.array([[1, 2], [2, 1]]))

    with pytest.raises(AssertionError):
        KalmanFilter(
                     np.array([[1, 2, 3], [1, 2, 3]]),
                     control_input,
                     process_noise,
                     observation_noise,
                     observation_model,
                     initial_state)

def test_noiseless_1d():
    # this test represents a cart moving on a 1d road
    # with a constant (unknown) velocity
    dt = 0.1
    F = np.array([[1, dt], [0, 1]])
    initial_state = np.array([[0, 1]]).T
    control_input = np.array([[0, 0]]).T
    process_noise = np.array([[1e-8, 0], [0, 1e-8]])
    observation_noise = np.array([[1e-2]])
    observation_model = np.array([[1, 0]])

    kalman_filter = KalmanFilter(F,
                          control_input,
                          process_noise,
                          observation_noise,
                          observation_model,
                          initial_state)
    obs = initial_state
    for i in range(1, 100):
        obs = F@obs
        kalman_filter.observe(KalmanObservation(Y=obs[0], U=np.array([[0]])))


    assert abs(kalman_filter.X[1] - obs[1]) <= 1e-5
    assert abs(kalman_filter.X[1] - 1.0) <= 1e-5

def test_noisey_1d():
    # this test represents a cart moving on a 1d road
    # with a constant (unknown) velocity
    dt = 0.1
    F = np.array([[1, dt], [0, 1]])
    initial_state = np.array([[0, 1]]).T
    control_input = np.array([[0, 0]]).T
    process_noise = np.array([[1e-8**2, 0], [0, 1e-8**2]])
    observation_noise = np.array([[1e-8**2]])
    observation_model = np.array([[1, 0]])

    kalman_filter = KalmanFilter(F,
                          control_input,
                          process_noise,
                          observation_noise,
                          observation_model,
                          initial_state)
    obs = initial_state
    for i in range(1, 100):
        obs = F@obs
        kalman_filter.observe(KalmanObservation(Y=obs[0] + np.random.normal(0, 1e-8),
                                         U=np.array([[0]])))


    assert abs(kalman_filter.X[1] - obs[1]) <= 1e-5
    assert abs(kalman_filter.X[1] - 1.0) <= 1e-5

def test_wrong_noisey_1d():
    # this test represents a cart moving on a 1d road
    # with a constant (unknown) velocity
    #
    # Observation is much larger than KF thinks
    dt = 0.1
    F = np.array([[1, dt], [0, 1]])
    initial_state = np.array([[0, 1]]).T
    control_input = np.array([[0, 0]]).T
    process_noise = np.array([[1e-8**2, 0], [0, 1e-8**2]])
    observation_noise = np.array([[1e-16]])
    observation_model = np.array([[1, 0]])

    kalman_filter = KalmanFilter(F,
                          control_input,
                          process_noise,
                          observation_noise,
                          observation_model,
                          initial_state)
    obs = initial_state
    for i in range(1, 100):
        obs = F@obs
        kalman_filter.observe(KalmanObservation(Y=obs[0] + np.random.normal(0, 1e-5),
                                         U=np.array([[0]])))


    assert abs(kalman_filter.X[1] - obs[1]) <= 1e-5
    assert abs(kalman_filter.X[1] - 1.0) <= 1e-5

def test_wrong_model_1d():
    # this test represents a cart moving on a 1d road
    # with a constant (unknown) velocity
    #
    # Observation is much larger than KF thinks
    dt = 0.1
    F_real = np.array([[1, dt], [0, 1]])
    initial_state = np.array([[0, 1]]).T
    control_input = np.array([[0, 0]]).T
    process_noise = np.array([[1e-8**2, 0], [0, 1e-8**2]])
    observation_noise = np.array([[1e-18]])
    observation_model = np.array([[1, 0]])

    kalman_filter = KalmanFilter(F_real,
                          control_input,
                          process_noise,
                          observation_noise,
                          observation_model,
                          initial_state)
    obs = initial_state
    for i in range(1, 100):
        obs = (F_real + np.random.normal([0, 0], [1e-8, 1e-8]))@obs
        kalman_filter.observe(KalmanObservation(Y=obs[0],
                                         U=np.array([[0]])))


    assert abs(kalman_filter.X[1] - 1.0) <= 1e-5

if __name__ == "__main__":
    sys.exit(pytest.main([__file__]))
