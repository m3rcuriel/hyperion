load("@io_bazel_rules_rust//rust:toolchain.bzl", "rust_toolchain_target_config", "rust_toolchain")

rust_toolchain_target_config(
    name = "x86_64-linux-config",
    target_triple = "x86_64-unknown-linux-gnu",
    rust_stdlib = "@rust_linux_x86_64//:rust_lib-x86_64-unknown-linux-gnu",
    staticlib_ext = ".a",
    dylib_ext = ".so",
    binary_ext = "",
    supports_dynamic_linking = True,
    target_constraints = [
        "@bazel_tools//platforms:x86_64",
        "@bazel_tools//platforms:linux",
    ],
)

rust_toolchain(
    name = "x86_64-linux-toolchain_impl",
    visibility = ["//visibility:public"],
    rustc = "@rust_linux_x86_64//:rustc",
    rustc_lib = "@rust_linux_x86_64//:rustc_lib",
    rust_doc = "@rust_linux_x86_64//:rustdoc",
    exec_target = ":x86_64-linux-config",
    target = ":x86_64-linux-config",
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
