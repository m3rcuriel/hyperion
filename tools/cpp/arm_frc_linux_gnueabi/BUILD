package(default_visibility = ["//tools/cpp:__pkg__"])

filegroup(
    name = "gcc",
    srcs = [
        "arm-frc-linux-gnueabi-gcc",
        "@linux_arm_frc_linux_gnueabi_repo//:gcc",
    ],
)

filegroup(
    name = "ar",
    srcs = [
        "arm-frc-linux-gnueabi-ar",
        "@linux_arm_frc_linux_gnueabi_repo//:ar",
    ],
)

filegroup(
    name = "as",
    srcs = [
        "arm-frc-linux-gnueabi-as",
        "@linux_arm_frc_linux_gnueabi_repo//:as",
    ],
)

filegroup(
    name = "ld",
    srcs = [
        "arm-frc-linux-gnueabi-ld",
        "@linux_arm_frc_linux_gnueabi_repo//:ld",
    ],
)

filegroup(
    name = "nm",
    srcs = [
        "arm-frc-linux-gnueabi-nm",
        "@linux_arm_frc_linux_gnueabi_repo//:nm",
    ],
)

filegroup(
    name = "objcopy",
    srcs = [
        "arm-frc-linux-gnueabi-objcopy",
        "@linux_arm_frc_linux_gnueabi_repo//:objcopy",
    ],
)

filegroup(
    name = "objdump",
    srcs = [
        "arm-frc-linux-gnueabi-objdump",
        "@linux_arm_frc_linux_gnueabi_repo//:objdump",
    ],
)

filegroup(
    name = "strip",
    srcs = [
        "arm-frc-linux-gnueabi-strip",
        "@linux_arm_frc_linux_gnueabi_repo//:strip",
    ],
)

filegroup(
    name = "tool-wrappers",
    srcs = [
        ":ar",
        ":as",
        ":gcc",
        ":ld",
        ":nm",
        ":objcopy",
        ":objdump",
        ":strip",
    ],
)

filegroup(
    name = "libs",
    srcs = glob([
        "libs/**",
    ]),
)
