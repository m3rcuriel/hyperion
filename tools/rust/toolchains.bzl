load("//tools/rust:compiler_helpers.bzl", "rust_toolchain_repository")

def _platform_target(triple, constraints, sha256 = ""):
    return struct(target_triple = triple, compatible_with = constraints, sha256 = sha256)

def _platform_exec(triple, dylib, staticlib, binary, constraints, compilersha256 = "", librarysha256 = ""):
    return struct(
        target_triple = triple,
        dylib_ext = dylib,
        staticlib_ext = staticlib,
        binary_ext = binary,
        compatible_with = constraints,
        compilersha256 = compilersha256,
        librarysha256 = librarysha256,
    )

def _target(exec, targets = []):
    return (exec, targets)

RUST_VERSION = "nightly"
TARGET_DEFS = [
    _target(
        _platform_exec(
            "x86_64-unknown-linux-gnu",
            ".so",
            ".a",
            "",
            [
                "@bazel_tools//platforms:linux",
                "@bazel_tools//platforms:x86_64",
            ],
            compilersha256 = "0d566d06c633e25dd0c972fb8a6bd04247c88b0721e3c41d9a0ff2c688086884",
            librarysha256 = "8188f14c175957c53b05258372e537f070c67bd18432616c19049c3cd3ca80f0",
        ),
        [
            _platform_target(
                "thumbv7em-none-eabihf",
                [
                    "//tools/platforms:none",
                    "//tools/platforms:cortex-m7f",
                ],
                sha256 = "7f0dd36ddb9c35aa373b1e6ff883eea527a2232d39d06b7e0b9e667004b596df",
            ),
        ],
    ),
]

def rust_toolchains():
    for execu, target_list in TARGET_DEFS:
        rust_toolchain_repository(
            name = "{}_host".format(execu.target_triple),
            version = RUST_VERSION,
            iso_date = "2020-02-14",
            dylib_ext = execu.dylib_ext,
            binary_ext = execu.binary_ext,
            staticlib_ext = execu.staticlib_ext,
            target_triple = execu.target_triple,
            library_sha256 = execu.librarysha256,
            compiler_sha256 = execu.compilersha256,
        )

        for target in target_list:
            rust_toolchain_repository(
                name = "{}_{}".format(execu.target_triple, target.target_triple),
                version = RUST_VERSION,
                iso_date = "2020-02-14",
                dylib_ext = execu.dylib_ext,
                binary_ext = execu.binary_ext,
                staticlib_ext = execu.staticlib_ext,
                target_triple = target.target_triple,
                external_compiler = "{}_host".format(execu.target_triple),
                library_sha256 = target.sha256,
            )

def rust_bazel_toolchains():
    for execu, target_list in TARGET_DEFS:
        native.toolchain(
            name = "{}_host".format(execu.target_triple),
            exec_compatible_with = execu.compatible_with,
            target_compatible_with = execu.compatible_with,
            toolchain = "@{0}_host//:toolchain_for_{0}_impl".format(execu.target_triple),
            toolchain_type = "@io_bazel_rules_rust//rust:toolchain",
        )
        for target in target_list:
            native.toolchain(
                name = "{}_{}".format(execu.target_triple, target.target_triple),
                exec_compatible_with = execu.compatible_with,
                target_compatible_with = target.compatible_with,
                toolchain = "@{0}_{1}//:toolchain_for_{1}_impl".format(execu.target_triple, target.target_triple),
                toolchain_type = "@io_bazel_rules_rust//rust:toolchain",
            )

def register_toolchains():
    toolchains = []
    for execu, target_list in TARGET_DEFS:
        toolchains.append("//tools/rust:{}_host".format(execu.target_triple))
        for target in target_list:
            toolchains.append("//tools/rust:{}_{}".format(
                execu.target_triple,
                target.target_triple,
            ))

    native.register_toolchains(*toolchains)
