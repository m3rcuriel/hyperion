"""
cargo-raze crate build file.

DO NOT EDIT! Replaced on runs of cargo-raze
"""
package(default_visibility = [
  # Public for visibility by "@raze__crate__version//" targets.
  #
  # Prefer access through "//cargo", which limits external
  # visibility to explicit Cargo.toml dependencies.
  "//visibility:public",
])

licenses([
  "notice", # "Apache-2.0"
])

load(
    "@io_bazel_rules_rust//rust:rust.bzl",
    "rust_library",
    "rust_binary",
    "rust_test",
)



rust_library(
    name = "flatbuffers",
    crate_root = "rust/flatbuffers/src/lib.rs",
    crate_type = "lib",
    edition = "2015",
    srcs = glob(["**/*.rs"]),
    deps = [
        "@raze__fixedvec__0_2_3//:fixedvec",
        "@raze__smallvec__0_6_9//:smallvec",
    ],
    rustc_flags = [
        "--cap-lints=allow",
    ],
    version = "0.6.0",
    crate_features = [
        "default",
        "std",
    ],
)

