workspace(name = "hyperion")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

HYPERION_URL = "http://hyperion-project.s3-us-west-2.amazonaws.com/"

http_archive(
    name = "io_bazel_rules_rust",
    #              "@//third_party:rules_rust_proc_macro_transition.patch"],
    patch_args = ["-p1"],
    # TODO(m3rcuriel) remove patch when rules_rust upstreams this
    # TODO(m3rcuriel) re-add proc macro patch once it works again
    sha256 = "019958e96fcb9d8b5e5f74f31ad58f9c59804e8c04cf5aae03b983001edc79e0",
    patches = ["@//third_party:rules_rust_disgusting.patch"],
    strip_prefix = "rules_rust-f727669b8ac3c9d237ed9bc7833b8e1eeec90506",
    urls = [
        # Master branch as of 2019-4-23
        "https://github.com/bazelbuild/rules_rust/archive/f727669b8ac3c9d237ed9bc7833b8e1eeec90506.tar.gz",
    ],
)

http_archive(
    name = "bazel_skylib",
    sha256 = "eb5c57e4c12e68c0c20bc774bfbc60a568e800d025557bc4ea022c6479acc867",
    strip_prefix = "bazel-skylib-0.6.0",
    url = "https://github.com/bazelbuild/bazel-skylib/archive/0.6.0.tar.gz",
)

load("@io_bazel_rules_rust//rust:repositories.bzl", "rust_repository_set")

RUST_VERSION = "1.35.0"

rust_repository_set(
    name = "rust_linux_x86_64",
    exec_triple = "x86_64-unknown-linux-gnu",
    extra_target_triples = ["armv7-none-eabi"],
    version = RUST_VERSION,
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
    sha256 = "6efc8bebb42e9d708538dac4040fd5a350a92a3c63c2c85bbe4e9477000d9479",
    type = "tar.gz",
    urls = [HYPERION_URL + "x86_64_clang_disco-6efc8bebb42e9d70.tar.gz"],
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
    type = "tar.bz2",
    urls = [HYPERION_URL + "gcc-arm-none-eabi-8-2019-q3-update-linux.tar.bz2"],
    strip_prefix="gcc-arm-none-eabi-8-2019-q3-update",
)

load("//tools/cpp:register.bzl", register_cpp_toolchains = "register_toolchains")

register_cpp_toolchains()

load("//tools/rust:register.bzl", register_rust_toolchains = "register_toolchains")

register_rust_toolchains()

load("//cargo:crates.bzl", "raze_fetch_remote_crates")

raze_fetch_remote_crates()
