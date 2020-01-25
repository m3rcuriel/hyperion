load(
    "@bazel_tools//tools/cpp:cc_toolchain_config_lib.bzl",
    "feature",
    "flag_group",
    "flag_set",
    "tool_path",
    "with_feature_set",
)
load("@bazel_tools//tools/build_defs/cc:action_names.bzl", "ACTION_NAMES")

def _impl(ctx):
    tool_paths = [
        tool_path(
            name = "ar",
            path = "arm_none_eabi_gcc/arm-none-eabi-ar",
        ),
        tool_path(
            name = "compat-ld",
            path = "arm_none_eabi_gcc/arm-none-eabi-ld",
        ),
        tool_path(
            name = "cpp",
            path = "arm_none_eabi_gcc/arm-none-eabi-cpp",
        ),
        tool_path(
            name = "dwp",
            path = "arm_none_eabi_gcc/arm-none-eabi-dwp",
        ),
        tool_path(
            name = "gcc",
            path = "arm_none_eabi_gcc/arm-none-eabi-gcc",
        ),
        tool_path(
            name = "gcov",
            path = "arm_none_eabi_gcc/arm-none-eabi-gcov",
        ),
        tool_path(
            name = "ld",
            path = "arm_none_eabi_gcc/arm-none-eabi-ld",
        ),
        tool_path(
            name = "nm",
            path = "arm_none_eabi_gcc/arm-none-eabi-nm",
        ),
        tool_path(
            name = "objcopy",
            path = "arm_none_eabi_gcc/arm-none-eabi-objcopy",
        ),
        tool_path(
            name = "objdump",
            path = "arm_none_eabi_gcc/arm-none-eabi-objdump",
        ),
        tool_path(
            name = "strip",
            path = "arm_none_eabi_gcc/arm-none-eabi-strip",
        ),
    ]

    default_link_flags_feature = feature(
        name = "default_link_flags",
        enabled = True,
        flag_sets = [
            flag_set(
                actions = [
                    ACTION_NAMES.cpp_link_executable,
                    ACTION_NAMES.cpp_link_dynamic_library,
                    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-no-canonical-prefixes",
                            "-mcpu=%s" % ctx.attr.cpu,
                            "-mfpu=%s" % ctx.attr.fpu,
                            "-mthumb",
                            "-fno-strict-aliasing",
                            "--specs=nosys.specs",
                            "-lgcc",
                            "-lstdc++_nano",
                            "-lm",
                            "-lc_nano",
                            "-fmessage-length=80",
                            "-fmax-errors=20",
                            "-Wl,--build-id=md5",
                            "-Wl,--hash-style=gnu",
                        ],
                    ),
                ],
            ),
            flag_set(
                actions = [
                    ACTION_NAMES.cpp_link_executable,
                    ACTION_NAMES.cpp_link_dynamic_library,
                    ACTION_NAMES.cpp_link_nodeps_dynamic_library,
                ],
                flag_groups = [
                    flag_group(
                        flags = [
                            "-Wl,--gc-sections",
                        ],
                    ),
                ],
                with_features = [with_feature_set(features = ["opt"])],
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
                            "-Wl,--gc-sections",
                            "-fstack-protector",
                            "-mcpu=%s" % ctx.attr.cpu,
                            "-mfpu=%s" % ctx.attr.fpu,
                            "-mthumb",
                            "-fno-strict-aliasing",
                            "-fmessage-length=80",
                            "-fmax-errors=20",
                            "-Wall",
                            "-Wextra",
                            "-Wpointer-arith",
                            "-Wcast-qual",
                            "-Wwrite-strings",
                            "-Wtype-limits",
                            "-Wsign-compare",
                            "-Wformat=2",
                            "-Werror",
                            "-Wstrict-aliasing",
                            "-Wdouble-promotion",  # because our fpu might be SP only
                            "-pipe",
                            "-fno-common",
                            "-ffreestanding",
                            "-fbuiltin",
                            "-I%{sysroot}/arm-none-eabi/include/c++/8.3.1",
                            "-I%{sysroot}/arm-none-eabi/include",
                            "-I%{sysroot}/lib/gcc/arm-none-eabi/8.3.1/include",
                            "-I%{sysroot}/arm-none-eabi/include/c++/8.3.1/arm-none-eabi/thumb/v7e-m/nofp",
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
                    "-fdata-sections",
                ])],
                with_features = [with_feature_set(features = ["opt"])],
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

    cxx_builtin_include_directories = [
        "/lib/gcc/x86_64-pc-linux-gnu/8.3.1/include",
        "/arm-none-eabi/include",
        "/arm-none-eabi/include/c++/8.3.1",
    ]

    features = [
        include_paths_feature,
        default_link_flags_feature,
        default_compile_flags_feature,
    ]

    return cc_common.create_cc_toolchain_config_info(
        ctx = ctx,
        toolchain_identifier = ctx.attr.cpu,
        host_system_name = "local",
        target_system_name = ctx.attr.cpu,
        target_cpu = ctx.attr.cpu,
        target_libc = ctx.attr.cpu,
        compiler = "gcc",
        abi_version = ctx.attr.cpu,
        abi_libc_version = ctx.attr.cpu,
        builtin_sysroot = "external/arm_none_eabi_gcc",
        tool_paths = tool_paths,
        cxx_builtin_include_directories = cxx_builtin_include_directories,
        features = features,
    )

cc_toolchain_config = rule(
    implementation = _impl,
    attrs = {
        "cpu": attr.string(mandatory = True),
        "fpu": attr.string(mandatory = True),
    },
    provides = [CcToolchainConfigInfo],
)
