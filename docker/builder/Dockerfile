FROM ubuntu:bionic

RUN apt-get update ; apt-get install -y curl sudo gnupg patch git python3 python3-pytest python3-numpy
RUN ln -s /usr/bin/python3 /usr/bin/python

ENV USER=hyperion
ENV HOME=/home/$USER

RUN useradd -ms /bin/bash $USER \
  && sudo -u $USER mkdir -p $HOME/.cache/bazel
USER hyperion
WORKDIR /home/hyperion/hyperion
