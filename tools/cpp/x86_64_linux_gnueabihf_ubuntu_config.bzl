load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
    "with_feature_set",
)
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

all_link_actions = [
    ACTION_NAMES.cpp_link_executable,
    ACTION_NAMES.cpp_link_dynamic_library,
    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
]

def _impl(ctx):
    distro = "x86_64_linux_gnueabihf_" + ctx.attr.distro

    tool_paths = [
        tool_path(
            name = "ar",
            path = "%s/x86_64-linux-gnueabihf-ar" % distro,
        ),
        tool_path(
            name = "compat-ld",
            path = "%s/x86_64-linux-gnueabihf-ld" % distro,
        ),
        tool_path(
            name = "cpp",
            path = "%s/x86_64-linux-gnueabihf-cpp" % distro,
        ),
        tool_path(
            name = "dwp",
            path = "%s/x86_64-linux-gnueabihf-dwp" % distro,
        ),
        tool_path(
            name = "gcc",
            path = "%s/x86_64-linux-gnueabihf-clang" % distro,
        ),
        tool_path(
            name = "gcov",
            path = "%s/x86_64-linux-gnueabihf-gcov" % distro,
        ),
        tool_path(
            name = "ld",
            path = "%s/x86_64-linux-gnueabihf-ld" % distro,
        ),
        tool_path(
            name = "nm",
            path = "%s/x86_64-linux-gnueabihf-nm" % distro,
        ),
        tool_path(
            name = "objcopy",
            path = "%s/x86_64-linux-gnueabihf-objcopy" % distro,
        ),
        tool_path(
            name = "objdump",
            path = "%s/x86_64-linux-gnueabihf-objdump" % distro,
        ),
        tool_path(
            name = "strip",
            path = "%s/x86_64-linux-gnueabihf-strip" % distro,
        ),
    ]

    default_link_flags_feature = feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = all_link_actions,
                flag_groups = [
                    flag_group(
                        flags = [
                            "-no-canonical-prefixes",
                            "-B%{sysroot}/usr/bin",
                            "-fuse-ld=lld",
                            "-nodefaultlibs",
                            "-Lexternal/x86_64_sysroot/usr/lib/gcc/x86_64-linux-gnu/7",
                            "-Lexternal/x86_64_sysroot/lib/x86_64-linux-gnu",
                            "-lm",
                            "-lstdc++",
                            "-lgcc_s",
                            "-lgcc",
                            "-lc",
                            "-lrt",
                            "-Wl,-z,relro,-z,now",
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
                actions = [ACTION_NAMES.cpp_link_executable],
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

    pic_feature = feature(
        name = "pic",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.cpp_module_compile,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-fPIC",
                        ],
                    ),
                ],
            ),
        ],
    )

    include_paths_feature = feature(
        name = "include_paths",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                ],
                flag_groups = [
                    flag_group(
                        flags = ["-iquote%{quote_include_paths}"],
                        iterate_over = "quote_include_paths",
                    ),
                    flag_group(
                        flags = ["-I%{include_paths}"],
                        iterate_over = "include_paths",
                    ),
                    flag_group(
                        flags = ["-I%{system_include_paths}"],
                        iterate_over = "system_include_paths",
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
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-nostdinc",
                            "-pipe",
                            "-no-canonical-prefixes",
                            "-fPIE",
                            "-pipe",
                            "-isystem%{sysroot}/usr/include/c++/7",
                            "-isystem%{sysroot}/usr/include/x86_64-linux-gnu/c++/7",
                            "-isystem%{sysroot}/usr/include/x86_64-linux-gnu",
                            "-isystem%{sysroot}/usr/include",
                            "-isystem%{sysroot}/usr/lib/llvm-8/lib/clang/8.0.1/include",
                        ],
                    ),
                ],
            ),
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [flag_group(flags = [
                    "-g",
                    "-fno-omit-frame-pointer",
                ])],
                with_features = [with_feature_set(features = ["dbg"])],
            ),
            flag_set(
                actions = [
                    ACTION_NAMES.assemble,
                    ACTION_NAMES.preprocess_assemble,
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.c_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [flag_group(flags = [
                    "-O2",
                    "-g0",
                    "-finline-functions",
                    "-ffast-math",
                    "-funroll-loops",
                    "-DNDEBUG",
                    "-ffunction-sections",
                ])],
                with_features = [with_feature_set(features = ["opt"])],
            ),
            flag_set(
                actions = [
                    ACTION_NAMES.linkstamp_compile,
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_compile,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.lto_backend,
                    ACTION_NAMES.clif_match,
                ],
                flag_groups = [flag_group(flags = ["-std=c++1y"])],
            ),
            flag_set(
                actions = [
                    ACTION_NAMES.cpp_compile,
                    ACTION_NAMES.cpp_header_parsing,
                    ACTION_NAMES.cpp_module_codegen,
                    ACTION_NAMES.cpp_module_compile,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-fno-exceptions",
                            "-fno-rtti",
                        ],
                    ),
                ],
            ),
        ],
    )

    cxx_builtin_include_directories = [
        "/usr/include/c++/7",
        "/usr/lib/clang/8.0.1/include",
        "/usr/lib/gcc/x86_64-pc-linux-gnu/8.3.0/include",
        "/usr/include",
    ]

    features = [
        include_paths_feature,
        default_link_flags_feature,
        default_compile_flags_feature,
        pic_feature,
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = "x86_64",
        host_system_name = "linux",
        target_system_name = "x86_64",
        target_cpu = "x86_64",
        target_libc = "2.19",
        compiler = "clang",
        abi_version = "x86_64",
        abi_libc_version = "2.19",
        builtin_sysroot = "external/x86_64_sysroot",
        tool_paths = tool_paths,
        cxx_builtin_include_directories = cxx_builtin_include_directories,
        features = features,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "distro": attr.string(mandatory = True),
    },
    provides = [CcToolchainConfigInfo],
)
