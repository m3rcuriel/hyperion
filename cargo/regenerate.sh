#!/bin/bash -norc

cd "$BUILD_WORKSPACE_DIRECTORY/cargo"
cargo generate-lockfile
cargo raze
cat << EOF >> BUILD
sh_binary(
    name = "regenerate",
    srcs = ["regenerate.sh"],
)
EOF