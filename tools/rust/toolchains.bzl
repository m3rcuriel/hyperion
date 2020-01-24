load("//tools/rust:compiler_helpers.bzl", "rust_toolchain_repository")

TARGET_DEFS = [
    (struct(target_triple = "x86_64-unknown-linux-gnu",
           dylib_ext = ".so",
           staticlib_ext = ".a",
           binary_ext = "",
           compatible_with = [
              "@bazel_tools//platforms:linux",
              "@bazel_tools//platforms:x86_64",
           ]),
    [])]


def rust_toolchains():
  for execu,target_list in TARGET_DEFS:
    rust_toolchain_repository(
      name = "{}_host".format(execu.target_triple),
      version = "1.40.0",
      dylib_ext = execu.dylib_ext,
      binary_ext = execu.binary_ext,
      staticlib_ext = execu.staticlib_ext,
      target_triple = execu.target_triple,
    )

    for target in target_list:
      rust_toolchain_repository(
        name = "{}_{}".format(execu.target_triple, target.target_triple),
        version = "1.40.0",
        dylib_ext = execu.dylib_ext,
        binary_ext = execu.binary_ext,
        staticlib_ext = execu.staticlib_ext,
        target_triple = target.target_triple,
        external_compiler = "{}_host".format(execu.target_triple),
      )


def rust_bazel_toolchains():
  for execu,target_list in TARGET_DEFS:
    native.toolchain(
      name = "{}_host".format(execu.target_triple),
      exec_compatible_with = execu.compatible_with,
      target_compatible_with = execu.compatible_with,
      toolchain = "{}_host//:toolchain_for_{}_impl".format(execu.target_triple),
      toolchain_type = "@io_bazel_rules_rust//rust:toolchain",
    )
    for target in target_list:
      native.toolchain(
        name = "{}_{}".format(execu.target_triple, target.target_triple),
        exec_compatible_with = execu.compatible_with,
        target_compatible_with = target.compatible_with,
        toolchain = "{}_host//:toolchain_for_{}_impl".format(target.target_triple),
        toolchain_type = "@io_bazel_rules_rust//rust:toolchain",
      )


def register_toolchains():
  toolchains = []
  for execu,target_list in TARGET_DEFS:
    toolchains.append("//tools/rust:{}_host".format(execu.target_triple))
    for target in target_list:
      toolchains.append("//tools/rust:{}_{}".format(execu.target_triple,
                                                    target.target_triple))
