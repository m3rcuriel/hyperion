from abc import ABCMeta, abstractmethod

class Filter(metaclass=ABCMeta):
    """ A class providing a general filter-like interface.
    """

    @abstractmethod
    def observe(self, observation):
        """Provide the filter with an observation of the outside world.

        :param observation: The observation to update the filter with
        """

    @abstractmethod
    def predict(self, system_input):
        """Advance the filter for a certain timestep.

        :param interval: The amount of time to forward-predict
        :returns: The new predicted state
        """

    @abstractmethod
    def reset(self):
        """Resets the filter back to its initial state.
        """

    @abstractmethod
    def set_state(self, state):
        """Sets the state of the filter to a given position. This should handle resetting any internal state
        which would be rendered invalid by a sudden jump in state.

        :param state: The state to jump to
        """
