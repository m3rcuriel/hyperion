package(default_visibility = ["@//tools:__subpackages__",
                              "@x86_64_clang_8_bionic//:__subpackages__"])

filegroup(
    name = "clang",
    srcs = [
        "usr/bin/clang",
    ],
)

filegroup(
    name = "ar",
    srcs = [
        "usr/bin/llvm-ar",
    ],
)

filegroup(
    name = "lld",
    srcs = [
        "usr/bin/lld",
        "usr/bin/ld.lld",
    ],
)

filegroup(
    name = "as",
    srcs = [
        "usr/bin/llvm-as",
    ],
)

filegroup(
    name = "nm",
    srcs = [
        "usr/bin/llvm-nm",
    ],
)

filegroup(
    name = "objcopy",
    srcs = [
        "usr/bin/llvm-objcopy",
    ],
)

filegroup(
    name = "objdump",
    srcs = [
        "usr/bin/llvm-objdump",
    ],
)

filegroup(
    name = "strip",
    srcs = [
        "usr/bin/llvm-strip",
    ],
)

cc_library(
    name = "libclang.so",
    srcs = [
      "usr/lib/x86_64-linux-gnu/libclang-8.so.1",
    ],
)

cc_library(
    name = "libstdcxx.so",
    srcs = [
      "usr/lib/x86_64-linux-gnu/libstdc++.so.6.0.25",
    ],
    deps = [":libllvm.so"],
)

cc_library(
    name = "libllvm.so",
    srcs = [
      "usr/lib/x86_64-linux-gnu/libLLVM-8.so.1",
    ],
)

filegroup(
    name = "compiler_libraries",
    srcs = glob([
        "usr/lib/clang/**",
        "usr/lib/llvm-8/**",
        "usr/include/**",
        "usr/lib/*",
        "usr/lib/x86_64-linux-gnu/*",
        "usr/lib/gcc/x86_64-linux-gnu/**",
        "lib/x86_64-linux-gnu/*",
        "lib/*",
    ]),
)

filegroup(
    name = "compiler_binaries",
    srcs = [
        ":ar",
        ":as",
        ":clang",
        ":lld",
        ":nm",
        ":objcopy",
        ":objdump",
        ":strip",
    ],
)
