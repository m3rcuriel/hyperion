load("@io_bazel_rules_rust//rust:rust.bzl", "rust_binary")

rust_binary(
    name = "hello_world",
    srcs = ["hello_world.rs"],
)

sh_test(
    name = "rust_compilation_test",
    size = "small",
    srcs = [
        "rust_check.sh",
    ],
    data = [
        ":hello_world",
    ],
)
