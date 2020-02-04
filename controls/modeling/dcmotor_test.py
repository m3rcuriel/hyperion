import pytest

import numpy as np
import sys
import inspect

import functools

import itertools

from controls.modeling.dcmotor import Motor, MultipleMotor
from controls.modeling import common_motors


def _get_all_classes():
    result = []
    for name, obj in inspect.getmembers(common_motors):
        if inspect.isclass(obj):
            result.append(obj)

    return result


# Test for all motor classes, plus a MultipleMotor of CIM, and do each test
# on 12 V, 6 V, 3 V, and 2 V
test_data = itertools.product(
    _get_all_classes()
    + [functools.partial(MultipleMotor, model=common_motors.CIM(), num_motors=2)],
    [1, 2, 4, 6],
)


@pytest.mark.parametrize("modeltype, factor", test_data)
def test_steady_state_velocity(modeltype, factor):
    model = modeltype()
    gear_ratio = 2.0
    motor = Motor(model, gear_ratio, 1.0, dt=0.005)

    position = 0.0
    last_position = 0.0
    last_last_position = 0.0
    for _ in range(10000):
        motor.update(np.asarray([[12.0 / factor]]))
        last_last_position = last_position
        last_position = position
        position = motor.output[0, 0]

    average_velocity = (position - last_position) / 0.005
    last_average_velocity = (last_position - last_last_position) / 0.005
    assert average_velocity == pytest.approx(model.free_speed / factor / gear_ratio, 10)
    assert average_velocity == pytest.approx(last_average_velocity, 1e-4)


if __name__ == "__main__":
    sys.exit(pytest.main([__file__]))
