load(
    "@io_bazel_rules_rust//bindgen:bindgen.bzl",
    "rust_bindgen_library",
)

rust_bindgen_library(
    name = "bindings",
    bindgen_flags = [
        "--whitelist-type",
        "HAL_\w+",
        "--whitelist-function",
        "HAL_\w+",
        "--whitelist-var",
        "HAL_\w+",
        "--raw-line",
        # only necessary because this is a .h file and there's no mod to add
        # the types to
        "#![allow(non_snake_case, non_camel_case_types, non_upper_case_globals)]",
    ],
    clang_flags = [
        "-x",
        "c++",
        "--std=c++17",
    ],
    visibility = ["//wpilib:__subpackages__"],
    header = "@allwpilib//:hal/src/main/native/include/hal/HAL.h",
    cc_lib = "@allwpilib//:hal",
)
