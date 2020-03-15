load(
    "@io_bazel_rules_rust//bindgen:bindgen.bzl",
    "rust_bindgen_library",
)

rust_bindgen_library(
    name = "bindings",
    bindgen_flags = [
        "--enable-cxx-namespaces",
        "--whitelist-type",
        "HAL_\w+",
        "--whitelist-function",
        "HAL_\w+",
        "--whitelist-var",
        "HAL_\w+",
    ],
    clang_flags = [
        "-x",
        "c++",
        "--std=c++17",
    ],
    header = "@allwpilib//:hal/src/main/native/include/hal/HAL.h",
    cc_lib = "@allwpilib//:hal",
)
