load(":x86_64_linux_gnueabihf_config.bzl", x86_64_configure = "cc_toolchain_config")

package(default_visibility = ["//tools/cpp:__pkg__"])

filegroup(
    name = "empty",
    srcs = [],
)

cc_toolchain_suite(
    name = "toolchain",
    visibility = ["//visibility:public"],
    toolchains = {
        "k8|clang": "cc-compiler-x86_64",
    },
)

x86_64_configure(name = "x86_64_toolchain_config")

filegroup(
    name = "clang_x86_64_linux_gnueabihf_files",
    srcs = [
        "//tools/cpp/x86_64_linux_gnueabihf:all-tools",
        "@x86_64_clang_8//:compiler_libraries",
    ],
)

filegroup(
    name = "clang_x86_64_linux_gnueabihf_compiler_files",
    srcs = [
        "//tools/cpp/x86_64_linux_gnueabihf:as",
        "//tools/cpp/x86_64_linux_gnueabihf:clang",
        "//tools/cpp/x86_64_linux_gnueabihf:ld",
    ],
)

filegroup(
    name = "clang_x86_64_linux_gnueabihf_linker_files",
    srcs = [
        "//tools/cpp/x86_64_linux_gnueabihf:ar",
        "//tools/cpp/x86_64_linux_gnueabihf:clang",
        "//tools/cpp/x86_64_linux_gnueabihf:ld",
        "@x86_64_clang_8//:compiler_libraries",
    ],
)

toolchain(
    name = "cc-compiler-x86_64-toolchain",
    toolchain = ":cc-compiler-x86_64",
    toolchain_type = "@bazel_tools//tools/cpp:toolchain_type",
)

cc_toolchain(
    name = "cc-compiler-x86_64",
    all_files = ":clang_x86_64_linux_gnueabihf_files",
    compiler_files = ":clang_x86_64_linux_gnueabihf_compiler_files",
    cpu = "x86_64",
    dwp_files = ":empty",
    dynamic_runtime_lib = ":empty",
    linker_files = ":clang_x86_64_linux_gnueabihf_linker_files",
    objcopy_files = "//tools/cpp/x86_64_linux_gnueabihf:objcopy",
    static_runtime_lib = ":empty",
    strip_files = "//tools/cpp/x86_64_linux_gnueabihf:strip",
    supports_param_files = 1,
    toolchain_identifier = "x86_64",
    toolchain_config = ":x86_64_toolchain_config",
)
