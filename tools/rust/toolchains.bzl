load("//tools/rust:compiler_helpers.bzl", "rust_toolchain_repository")

def _platform_target(triple, constraints):
  return struct(target_triple = triple, compatible_with = constraints)

def _platform_exec(triple, dylib, staticlib, binary, constraints):
  return struct(target_triple = triple,
                dylib_ext = dylib,
                staticlib_ext = staticlib,
                binary_ext = binary,
                compatible_with = constraints)

def _target(exec, targets=[]):
  return (exec, targets)

TARGET_DEFS = [
    _target(
        _platform_exec(
          "x86_64-unknown-linux-gnu", ".so", ".a", "",
          [
              "@bazel_tools//platforms:linux",
              "@bazel_tools//platforms:x86_64",
          ]))
]


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
  for execu,target_list in TARGET_DEFS:
    toolchains.append("//tools/rust:{}_host".format(execu.target_triple))
    for target in target_list:
      toolchains.append("//tools/rust:{}_{}".format(execu.target_triple,
                                                    target.target_triple))

  native.register_toolchains(*toolchains)
