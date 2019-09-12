FROM ubuntu:bionic

RUN apt-get update ; apt-get install -y curl sudo gnupg patch git python3 python3-pytest python3-numpy
RUN bash -c 'echo "deb [arch=amd64] http://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list ;\
  curl https://bazel.build/bazel-release.pub.gpg | apt-key add - && apt-get update && apt-get install -y bazel'

ENV USER=hyperion
ENV HOME=/home/$USER

RUN useradd -ms /bin/bash $USER \
  && sudo -u $USER mkdir -p $HOME/.cache/bazel
USER hyperion
WORKDIR /home/hyperion/hyperion
