load(
    "@io_bazel_rules_rust//bindgen:bindgen.bzl",
    "rust_bindgen_library",
)

rust_bindgen_library(
    name = "bindings",
    header = "bindings.h",
    cc_lib = "@allwpilib//:hal",
)
