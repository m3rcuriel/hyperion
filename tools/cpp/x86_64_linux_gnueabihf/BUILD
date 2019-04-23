package(default_visibility = ["//tools/cpp:__pkg__"])

filegroup(
    name = "clang",
    srcs = [
        "x86_64-linux-gnueabihf-clang",
        "@x86_64_clang_8//:clang",
    ],
)

filegroup(
    name = "ar",
    srcs = [
        "x86_64-linux-gnueabihf-ar",
        "@x86_64_clang_8//:ar",
    ],
)

filegroup(
    name = "nm",
    srcs = [
        "x86_64-linux-gnueabihf-nm",
        "@x86_64_clang_8//:nm",
    ],
)

filegroup(
    name = "ld",
    srcs = [
        "x86_64-linux-gnueabihf-ld",
        "@x86_64_clang_8//:lld",
    ],
)

filegroup(
    name = "objcopy",
    srcs = [
        "x86_64-linux-gnueabihf-objcopy",
        "@x86_64_clang_8//:objcopy",
    ],
)

filegroup(
    name = "objdump",
    srcs = [
        "x86_64-linux-gnueabihf-objdump",
        "@x86_64_clang_8//:objdump",
    ],
)

filegroup(
    name = "strip",
    srcs = [
        "x86_64-linux-gnueabihf-strip",
        "@x86_64_clang_8//:strip",
    ],
)

filegroup(
    name = "as",
    srcs = [
        "x86_64-linux-gnueabihf-as",
        "@x86_64_clang_8//:as",
    ],
)

filegroup(
    name = "all-tools",
    srcs = [
        ":ar",
        ":as",
        ":clang",
        ":ld",
        ":nm",
        ":objcopy",
        ":objdump",
        ":strip",
    ],
)
