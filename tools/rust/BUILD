load("@io_bazel_rules_rust//rust:toolchain.bzl", "rust_toolchain", "rust_toolchain_target_config")

rust_toolchain_target_config(
    name = "x86_64-linux-config",
    binary_ext = "",
    dylib_ext = ".so",
    rust_stdlib = "@rust_linux_x86_64//:rust_lib-x86_64-unknown-linux-gnu",
    staticlib_ext = ".a",
    supports_dynamic_linking = True,
    target_constraints = [
        "@bazel_tools//platforms:x86_64",
        "@bazel_tools//platforms:linux",
    ],
    target_triple = "x86_64-unknown-linux-gnu",
)

rust_toolchain_target_config(
    name = "arm-none-config",
    binary_ext = "",
    dylib_ext = ".so",
    rust_stdlib = "@rust_linux_x86_64//:rust_lib-x86_64-unknown-linux-gnu",
    staticlib_ext = ".a",
    supports_dynamic_linking = True,
    target_constraints = [
        "//tools/platforms:none",
    ],
    target_triple = "armv7-unknown-linux-gnueabihf",
)

rust_toolchain(
    name = "x86_64-linux-toolchain_impl",
    exec_target = ":x86_64-linux-config",
    rust_doc = "@rust_linux_x86_64//:rustdoc",
    rustc = "@rust_linux_x86_64//:rustc",
    rustc_lib = "@rust_linux_x86_64//:rustc_lib",
    target = ":x86_64-linux-config",
    visibility = ["//visibility:public"],
)

rust_toolchain(
    name = "arm-none-toolchain_impl",
    exec_target = ":x86_64-linux-config",
    rust_doc = "@rust_linux_x86_64//:rustdoc",
    rustc = "@rust_linux_x86_64//:rustc",
    rustc_lib = "@rust_linux_x86_64//:rustc_lib",
    target = ":arm-none-config",
    visibility = ["//visibility:public"],
)

toolchain(
    name = "x86_64-linux-toolchain",
    exec_compatible_with = [
        "@bazel_tools//platforms:x86_64",
        "@bazel_tools//platforms:linux",
    ],
    target_compatible_with = [
        "@bazel_tools//platforms:x86_64",
        "@bazel_tools//platforms:linux",
    ],
    toolchain = ":x86_64-linux-toolchain_impl",
    toolchain_type = "@io_bazel_rules_rust//rust:toolchain",
)

toolchain(
    name = "arm-none-toolchain",
    exec_compatible_with = [
        "@bazel_tools//platforms:x86_64",
        "@bazel_tools//platforms:linux",
    ],
    target_compatible_with = [
        "//tools/platforms:none",
    ],
    toolchain = ":arm-none-toolchain_impl",
    toolchain_type = "@io_bazel_rules_rust//rust:toolchain",
)
