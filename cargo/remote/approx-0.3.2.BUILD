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


# Unsupported target "abs_diff_eq" with type "test" omitted

rust_library(
    name = "approx",
    crate_root = "src/lib.rs",
    crate_type = "lib",
    edition = "2015",
    srcs = glob(["**/*.rs"]),
    deps = [
        "@raze__num_traits__0_2_6//:num_traits",
    ],
    rustc_flags = [
        "--cap-lints=allow",
    ],
    version = "0.3.2",
    crate_features = [
    ],
)

# Unsupported target "macro_import" with type "test" omitted
# Unsupported target "macros" with type "test" omitted
# Unsupported target "relative_eq" with type "test" omitted
# Unsupported target "ulps_eq" with type "test" omitted
