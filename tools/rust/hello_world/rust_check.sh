#!/bin/bash --norc

set -e
set -u

OUTPUT="$("./tools/rust/hello_world/hello_world")"

if [[ "${OUTPUT}" != "Hello, world!" ]]; then
  echo "Output is actually:" >&2
  echo "${OUTPUT}" >&2
  exit 1
fi
