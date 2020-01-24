package(default_visibility = ["//visibility:public"])

constraint_value(
    name = "none",
    constraint_setting = "@bazel_tools//platforms:os",
)

constraint_value(
    name = "cortex-m7f",
    constraint_setting = "@bazel_tools//platforms:cpu",
)

constraint_setting(
    name = "distro",
)

constraint_value(
    name = "ubuntu-bionic",
    constraint_setting = ":distro",
)

constraint_value(
    name = "ubuntu-disco",
    constraint_setting = ":distro",
)

platform(
    name = "linux-x86_64",
    constraint_values = [
        "@bazel_tools//platforms:linux",
        "@bazel_tools//platforms:x86_64",
    ],
)

platform(
    name = "bionic-linux-x86_64",
    constraint_values = [
        ":ubuntu-bionic",
    ],
    parents = [
        "linux-x86_64",
    ],
)

platform(
    name = "disco-linux-x86_64",
    constraint_values = [
        ":ubuntu-disco",
    ],
    parents = [
        "linux-x86_64",
    ],
)

platform(
    name = "cortex-m7f-none",
    constraint_values = [
        ":none",
        ":cortex-m7f",
    ],
)
