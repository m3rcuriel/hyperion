load(":x86_64_linux_gnueabihf_ubuntu_config.bzl", x86_64_configure = "cc_toolchain_config")

package(default_visibility = ["//tools/cpp:__pkg__"])

filegroup(
    name = "empty",
    srcs = [],
)

cc_toolchain_suite(
    name = "toolchain",
    toolchains = {
        "k8-bionic|clang": "cc-compiler-bionic-x86_64",
        "k8-disco|clang": "cc-compiler-disco-x86_64",
    },
    visibility = ["//visibility:public"],
)

x86_64_configure(
    name = "x86_64_toolchain_bionic_config",
    distro = "bionic",
)

x86_64_configure(
    name = "x86_64_toolchain_disco_config",
    distro = "disco",
)

filegroup(
    name = "clang_disco_x86_64_linux_gnueabihf_files",
    srcs = [
        "//tools/cpp/x86_64_linux_gnueabihf_disco:all-tools",
        "@x86_64_clang_8_disco//:compiler_libraries",
        "@x86_64_sysroot//:compiler_libraries",
    ],
)

filegroup(
    name = "clang_disco_x86_64_linux_gnueabihf_compiler_files",
    srcs = [
        "//tools/cpp/x86_64_linux_gnueabihf_disco:as",
        "//tools/cpp/x86_64_linux_gnueabihf_disco:clang",
        "//tools/cpp/x86_64_linux_gnueabihf_disco:ld",
    ],
)

filegroup(
    name = "clang_disco_x86_64_linux_gnueabihf_linker_files",
    srcs = [
        "//tools/cpp/x86_64_linux_gnueabihf_disco:ar",
        "//tools/cpp/x86_64_linux_gnueabihf_disco:clang",
        "//tools/cpp/x86_64_linux_gnueabihf_disco:ld",
        "@x86_64_clang_8_disco//:compiler_libraries",
        "@x86_64_sysroot//:compiler_libraries",
    ],
)

filegroup(
    name = "clang_bionic_x86_64_linux_gnueabihf_files",
    srcs = [
        "//tools/cpp/x86_64_linux_gnueabihf_bionic:all-tools",
        "@x86_64_clang_8_bionic//:compiler_libraries",
        "@x86_64_sysroot//:compiler_libraries",
    ],
)

filegroup(
    name = "clang_bionic_x86_64_linux_gnueabihf_compiler_files",
    srcs = [
        "//tools/cpp/x86_64_linux_gnueabihf_bionic:as",
        "//tools/cpp/x86_64_linux_gnueabihf_bionic:clang",
        "//tools/cpp/x86_64_linux_gnueabihf_bionic:ld",
    ],
)

filegroup(
    name = "clang_bionic_x86_64_linux_gnueabihf_linker_files",
    srcs = [
        "//tools/cpp/x86_64_linux_gnueabihf_bionic:ar",
        "//tools/cpp/x86_64_linux_gnueabihf_bionic:clang",
        "//tools/cpp/x86_64_linux_gnueabihf_bionic:ld",
        "@x86_64_clang_8_bionic//:compiler_libraries",
        "@x86_64_sysroot//:compiler_libraries",
    ],
)

toolchain(
    name = "cc-compiler-x86_64-bionic-toolchain",
    exec_compatible_with = [
        "@bazel_tools//platforms:x86_64",
        "@bazel_tools//platforms:linux",
        "//tools/platforms:ubuntu-bionic",
    ],
    target_compatible_with = [
        "@bazel_tools//platforms:x86_64",
        "@bazel_tools//platforms:linux",
    ],
    toolchain = ":cc-compiler-bionic-x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

toolchain(
    name = "cc-compiler-x86_64-disco-toolchain",
    exec_compatible_with = [
        "@bazel_tools//platforms:x86_64",
        "@bazel_tools//platforms:linux",
        "//tools/platforms:ubuntu-disco",
    ],
    target_compatible_with = [
        "@bazel_tools//platforms:x86_64",
        "@bazel_tools//platforms:linux",
    ],
    toolchain = ":cc-compiler-disco-x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

cc_toolchain(
    name = "cc-compiler-bionic-x86_64",
    all_files = ":clang_bionic_x86_64_linux_gnueabihf_files",
    compiler_files = ":clang_bionic_x86_64_linux_gnueabihf_compiler_files",
    dwp_files = ":empty",
    dynamic_runtime_lib = ":empty",
    linker_files = ":clang_bionic_x86_64_linux_gnueabihf_linker_files",
    objcopy_files = "//tools/cpp/x86_64_linux_gnueabihf_bionic:objcopy",
    static_runtime_lib = ":empty",
    strip_files = "//tools/cpp/x86_64_linux_gnueabihf_bionic:strip",
    supports_param_files = 1,
    toolchain_config = ":x86_64_toolchain_bionic_config",
    toolchain_identifier = "x86_64",
    visibility = ["//visibility:public"],
)

cc_toolchain(
    name = "cc-compiler-disco-x86_64",
    all_files = ":clang_disco_x86_64_linux_gnueabihf_files",
    compiler_files = ":clang_disco_x86_64_linux_gnueabihf_compiler_files",
    dwp_files = ":empty",
    dynamic_runtime_lib = ":empty",
    linker_files = ":clang_disco_x86_64_linux_gnueabihf_linker_files",
    objcopy_files = "//tools/cpp/x86_64_linux_gnueabihf_disco:objcopy",
    static_runtime_lib = ":empty",
    strip_files = "//tools/cpp/x86_64_linux_gnueabihf_disco:strip",
    supports_param_files = 1,
    toolchain_config = ":x86_64_toolchain_disco_config",
    toolchain_identifier = "x86_64",
    visibility = ["//visibility:public"],
)
