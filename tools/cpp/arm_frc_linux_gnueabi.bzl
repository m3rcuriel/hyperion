load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool",
    "tool_path",
    "with_feature_set",
)
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

all_compile_actions = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.assemble,
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.clif_match,
    ACTION_NAMES.lto_backend,
]

all_cpp_compile_actions = [
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.clif_match,
]

preprocessor_compile_actions = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.cpp_header_parsing,
    ACTION_NAMES.cpp_module_compile,
    ACTION_NAMES.clif_match,
]

codegen_compile_actions = [
    ACTION_NAMES.c_compile,
    ACTION_NAMES.cpp_compile,
    ACTION_NAMES.linkstamp_compile,
    ACTION_NAMES.assemble,
    ACTION_NAMES.preprocess_assemble,
    ACTION_NAMES.cpp_module_codegen,
    ACTION_NAMES.lto_backend,
]

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

lto_index_actions = [
    ACTION_NAMES.lto_index_for_executable,
    ACTION_NAMES.lto_index_for_dynamic_library,
    ACTION_NAMES.lto_index_for_nodeps_dynamic_library,
]

def _impl(ctx):
    tool_paths = [
                     tool_path(
                         name = name,
                         path = "arm_frc_linux_gnueabi/arm-frc-linux-gnueabi-%s" % name,
                     )
                     for name in ["ar", "cpp", "gcc", "gcov", "ld", "nm", "objcopy", "objdump", "strip"]
                 ] + \
                 [
                     tool_path(
                         name = "compat-ld",
                         path = "arm_frc_linux_gnueabi/arm-frc-linux-gnueabi-ld",
                     ),
                 ]

    supports_pic_feature = feature(
        name = "supports_pic",
        enabled = True,
    )

    default_link_flags_feature = feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-lstdc++",
                            "-Ltools/cpp/arm_frc_linux_gnueabi/libs",
                            "-no-canonical-prefixes",
                            "-Wl,-z,relro,-z,now",
                            "-lm",
                            "-pass-exit-codes",
                            "-Wl,--build-id=md5",
                            "-Wl,--hash-style=gnu",
                        ],
                    ),
                ],
            ),
            flag_set(
                actions = all_link_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-Wl,--gc-sections",
                        ],
                    ),
                ],
                with_features = [with_feature_set(features = ["opt"])],
            ),
            flag_set(
                actions = ["c++-link-executable"],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-pie",
                        ],
                    ),
                ],
            ),
        ],
    )

    default_compile_flags_feature = feature(
        name = "default_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = ["c-compile"],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-std=gnu99",
                        ],
                    ),
                ],
            ),
            flag_set(
                actions = all_cpp_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-std=c++17",
                            "-isystem",
                            "external/linux_arm_frc_linux_gnueabi_repo/arm-frc2020-linux-gnueabi/usr/include/c++/7.3.0",
                            "-isystem",
                            "external/linux_arm_frc_linux_gnueabi_repo/arm-frc2020-linux-gnueabi/usr/include/c++/7.3.0/arm-frc2020-linux-gnueabi",
                            "-isystem",
                            "external/linux_arm_frc_linux_gnueabi_repo/arm-frc2020-linux-gnueabi/usr/include/c++/7.3.0/backward",
                            "-fno-sized-deallocation",
                        ],
                    ),
                ],
            ),
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-nostdinc",
                            "-isystem",
                            "external/linux_arm_frc_linux_gnueabi_repo/arm-frc2020-linux-gnueabi/usr/lib/gcc/arm-frc2020-linux-gnueabi/7.3.0/include",
                            "-isystem",
                            "external/linux_arm_frc_linux_gnueabi_repo/arm-frc2020-linux-gnueabi/usr/lib/gcc/arm-frc2020-linux-gnueabi/7.3.0/include-fixed",
                            "-fno-canonical-system-headers",
                            "-isystem",
                            "external/linux_arm_frc_linux_gnueabi_repo/arm-frc2020-linux-gnueabi/usr/include",
                            "-mfpu=neon",
                            "-D__STDC_FORMAT_MACROS",
                            "-D__STDC_CONSTANT_MACROS",
                            "-D__STDC_LIMIT_MACROS",
                            "-D_FILE_OFFSET_BITS=64",
                            "-U_FORTIFY_SOURCE",
                            "-fstack-protector",
                            "-fPIE",
                            "-fdiagnostics-color=always",
                            "-Wall",
                            "-Wextra",
                            "-Wpointer-arith",
                            "-Wstrict-aliasing",
                            "-Wcast-qual",
                            "-Wcast-align",
                            "-Wwrite-strings",
                            "-Wtype-limits",
                            "-Wsign-compare",
                            "-Wformat=2",
                            "-Werror",
                            "-Wunused-local-typedefs",
                            "-Wno-cast-align",
                            "-Wno-psabi",
                            "-fno-omit-frame-pointer",
                            "-D__has_feature(x)=0",
                            "-pipe",
                            "-ggdb3",
                        ],
                    ),
                ],
            ),
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-O2",
                            "-DNDEBUG",
                            "-D_FORTIFY_SOURCE=1",
                            "-ffunction-sections",
                            "-fdata-sections",
                        ],
                    ),
                ],
                with_features = [with_feature_set(features = ["dbg"])],
            ),
        ],
    )

    pic_feature = feature(
        name = "pic",
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = ["-fPIC"],
                        expand_if_available = "pic",
                    ),
                ],
            ),
        ],
    )

    unfiltered_compile_flags_feature = feature(
        name = "unfiltered_compile_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-no-canonical-prefixes",
                            "-Wno-builtin-macro-redefined",
                            "-D__DATE__=\"redacted\"",
                            "-D__TIMESTAMP__=\"redacted\"",
                            "-D__TIME__=\"redacted\"",
                        ],
                    ),
                ],
            ),
        ],
    )

    opt_feature = feature(name = "opt")
    dbg_feature = feature(name = "dbg")

    sysroot_feature = feature(
        name = "sysroot",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_compile_actions + all_link_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "--sysroot=external/linux_arm_frc_linux_gnueabi_repo/arm-frc2020-linux-gnueabi",
                        ],
                    ),
                ],
            ),
        ],
    )

    features = [
        opt_feature,
        dbg_feature,
        sysroot_feature,
        unfiltered_compile_flags_feature,
        default_compile_flags_feature,
        default_link_flags_feature,
        pic_feature,
        supports_pic_feature,
    ]

    cxx_builtin_include_directories = [
        "%package(@linux_arm_frc_linux_gnueabi_repo//arm-frc2020-linux-gnueabi/usr/lib/gcc/arm-frc2020-linux-gnueabi/7.3.0/include)%",
        "%package(@linux_arm_frc_linux_gnueabi_repo//arm-frc2020-linux-gnueabi/usr/lib/gcc/arm-frc2020-linux-gnueabi/7.3.0/include-fixed)%",
        "%package(@linux_arm_frc_linux_gnueabi_repo//arm-frc2020-linux-gnueabi/usr/include/c++/7.3.0/arm-frc2020-linux-gnueabi)%",
        "%package(@linux_arm_frc_linux_gnueabi_repo//arm-frc2020-linux-gnueabi/usr/include/c++/7.3.0/backward)%",
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "linux_roborio",
        host_system_name = "linux",
        target_system_name = "roborio_linux",
        target_cpu = "roborio",
        target_libc = "roborio",
        compiler = "gcc",
        abi_version = "roborio",
        abi_libc_version = "roborio",
        builtin_sysroot = None,
        tool_paths = tool_paths,
        cxx_builtin_include_directories = cxx_builtin_include_directories,
        features = features,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    provides = [CcToolchainConfigInfo],
)
