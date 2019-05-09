workspace(name = "hyperion")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

HYPERION_URL = "http://hyperion-project.s3-us-west-2.amazonaws.com/"

http_archive(
    name = "io_bazel_rules_rust",
    strip_prefix = "rules_rust-81076de8aa74dccd6eef27e64b5b9772efc6678e",
    urls = [
        # Master branch as of 2019-4-23
        "https://github.com/bazelbuild/rules_rust/archive/81076de8aa74dccd6eef27e64b5b9772efc6678e.tar.gz",
    ],
    # TODO(m3rcuriel) remove patch when rules_rust upstreams this
    # TODO(m3rcuriel) re-add proc macro patch once it works again
    patches = ["@//third_party:rules_rust_toolchain_files.patch",
               "@//third_party:rules_rust_disgusting.patch"],
#               "@//third_party:rules_rust_proc_macro_transition.patch"],
    patch_args = ["-p1"],
)

http_archive(
    name = "bazel_skylib",
    sha256 = "eb5c57e4c12e68c0c20bc774bfbc60a568e800d025557bc4ea022c6479acc867",
    strip_prefix = "bazel-skylib-0.6.0",
    url = "https://github.com/bazelbuild/bazel-skylib/archive/0.6.0.tar.gz",
)

load("@io_bazel_rules_rust//rust:repositories.bzl", "rust_repositories")
rust_repositories()

load("@io_bazel_rules_rust//:workspace.bzl", "bazel_version")
bazel_version(name = "bazel_version")

http_archive(
    name = "x86_64_clang_8",
    build_file = "//tools/cpp:x86_64_linux_gnueabihf.BUILD",
    type = "tar.gz",
    sha256 = "e992f5ac09c36ab31c65ddc825e63854b49567b5d82d947bb89b34a728535051",
    urls = [HYPERION_URL + "x86_64_clang_sysroot-e992f5ac09c36ab3.tar.gz"],
)

load("//tools/cpp:register.bzl", register_cpp_toolchains="register_toolchains")
register_cpp_toolchains()

load("//tools/rust:register.bzl", register_rust_toolchains="register_toolchains")
register_rust_toolchains()

load("//cargo:crates.bzl", "raze_fetch_remote_crates")
raze_fetch_remote_crates()
