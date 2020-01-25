workspace(name = "hyperion")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

HYPERION_URL = "http://hyperion-project.s3-us-west-2.amazonaws.com/"

http_archive(
    name = "io_bazel_rules_rust",
    patch_args = ["-p1"],
    patches = ["//third_party:rules_rust_sha256.patch"],
    strip_prefix = "rules_rust-a9103cd6260433fb04b36d9a3e1dc4d3ddceaa22",
    urls = [
        # Master branch as of 2019-4-23
        "https://github.com/bazelbuild/rules_rust/archive/a9103cd6260433fb04b36d9a3e1dc4d3ddceaa22.tar.gz",
    ],
)

http_archive(
    name = "bazel_skylib",
    sha256 = "eb5c57e4c12e68c0c20bc774bfbc60a568e800d025557bc4ea022c6479acc867",
    strip_prefix = "bazel-skylib-0.6.0",
    url = "https://github.com/bazelbuild/bazel-skylib/archive/0.6.0.tar.gz",
)

load("@io_bazel_rules_rust//:workspace.bzl", "bazel_version")

bazel_version(name = "bazel_version")

http_archive(
    name = "x86_64_clang_8_bionic",
    build_file = "//tools/cpp:x86_64_linux_gnueabihf_bionic_clang.BUILD",
    sha256 = "e56f98a6b91f64cc6b968c25357bcc40f57ac1f363eb43a9d912fe3f79d66615",
    type = "tar.gz",
    urls = [HYPERION_URL + "x86_64_clang_bionic-e56f98a6b91f64cc.tar.gz"],
)

http_archive(
    name = "x86_64_clang_8_disco",
    build_file = "//tools/cpp:x86_64_linux_gnueabihf_disco_clang.BUILD",
    sha256 = "724d25de8e7d758f160509e9d17687aca0522c08bd5e9c0b6a603cb1a60a8c47",
    type = "tar.gz",
    urls = [HYPERION_URL + "x86_64_clang_disco-724d25de8e7d758f160509.tar.gz"],
)

http_archive(
    name = "x86_64_sysroot",
    build_file = "//tools/cpp:x86_64_linux_gnueabihf_sysroot.BUILD",
    sha256 = "06ab73ca2f67f328ea08314331ef4afb276ad14bf325d71916071b600c63bcc7",
    type = "tar.gz",
    urls = [HYPERION_URL + "x86_64_clang_sysroot-06ab73ca2f67f328.tar.gz"],
)

http_archive(
    name = "arm_none_eabi_gcc",
    build_file = "//tools/cpp:arm_none_eabi_gcc.BUILD",
    sha256 = "b50b02b0a16e5aad8620e9d7c31110ef285c1dde28980b1a9448b764d77d8f92",
    strip_prefix = "gcc-arm-none-eabi-8-2019-q3-update",
    type = "tar.bz2",
    urls = [HYPERION_URL + "gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2"],
)

load("//tools/cpp:register.bzl", register_cpp_toolchains = "register_toolchains")

register_cpp_toolchains()

load("//tools/rust:toolchains.bzl", "rust_toolchains", register_rust_toolchains = "register_toolchains")

rust_toolchains()

register_rust_toolchains()

load("//cargo:crates.bzl", "raze_fetch_remote_crates")

raze_fetch_remote_crates()
