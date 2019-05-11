FROM valkyrieregistry.azurecr.io/hyperion/cached:latest as cache_builder

USER hyperion

ADD . /home/hyperion/hyperion

WORKDIR /home/hyperion/hyperion

RUN bazel --bazelrc=.buildkite/.bazelrc build //... --host_platform=//tools/platforms:bionic-linux-x86_64

FROM valkyrieregistry.azurecr.io/hyperion/builder:latest
COPY --chown=hyperion --from=cache_builder /home/hyperion/.cache/bazel /home/hyperion/.cache/bazel
