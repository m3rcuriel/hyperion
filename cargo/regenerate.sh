#!/bin/bash -norc

cd "$BUILD_WORKSPACE_DIRECTORY/cargo"
rm -rf remote
cargo generate-lockfile || exit
cargo raze || exit
cat << EOF >> BUILD.bazel
sh_binary(
    name = "regenerate",
    srcs = [":regenerate.sh"],
)
EOF
