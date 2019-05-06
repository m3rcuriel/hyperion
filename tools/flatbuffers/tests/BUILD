load("@io_bazel_rules_rust//rust:rust.bzl", "rust_test")
load("//tools/flatbuffers:rust.bzl", "flatbuffer_rust_library")

rust_test(
    name = "test",
    srcs = ["test.rs"],
    deps = ["test_fbs",
            "//cargo:flatbuffers"],
)

flatbuffer_rust_library(
    name = "test_fbs",
    srcs = ["test.fbs"],
)
