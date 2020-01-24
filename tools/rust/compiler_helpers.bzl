load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

load("@io_bazel_rules_rust//rust:repositories.bzl", "load_arbitrary_tool")

# Based strongly on the repository work for rules_work.

def BUILD_for_compiler(binary_ext, staticlib_ext, dylib_ext, triple):
  return """
load("@io_bazel_rules_rust//rust:toolchain.bzl", "rust_toolchain")

filegroup(
    name = "rustc",
    srcs = ["bin/rustc{binary_ext}"],
    visibility = ["//visibility:public"],
)

filegroup(
    name = "rustc_lib",
    srcs = glob([
        "lib/*{dylib_ext}",
        "lib/rustlib/{target_triple}/codegen-backends/*{dylib_ext}",
    ]),
    visibility = ["//visibility:public"],
)

filegroup(
    name = "rustdoc",
    srcs = ["bin/rustdoc{binary_ext}"],
    visibility = ["//visibility:public"],
)
""".format(
        binary_ext = binary_ext,
        staticlib_ext = staticlib_ext,
        dylib_ext = dylib_ext,
        target_triple = triple,
    )


def BUILD_for_stdlib(name, binary_ext, staticlib_ext, dylib_ext, triple):
  return """
filegroup(
  name = "rust_lib-{target_triple}",
  srcs = glob(
      [
          "lib/rustlib/{target_triple}/lib/*.rlib",
          "lib/rustlib/{target_triple}/lib/*{dylib_ext}",
          "lib/rustlib/{target_triple}/lib/*{staticlib_ext}",
      ],
      # Some patterns (e.g. `lib/*.a`) don't match anything, see https://github.com/bazelbuild/rules_rust/pull/245
      allow_empty = True,
  ),
  visibility = ["//visibility:public"],
)
""".format(
        binary_ext = binary_ext,
        staticlib_ext = staticlib_ext,
        dylib_ext = dylib_ext,
        target_triple = triple,
    )


def BUILD_for_rust_toolchain(workspace_name, name, binary_ext, staticlib_ext, dylib_ext, target_triple, default_edition = "2018"):
    """Emits a toolchain declaration to match an existing compiler and stdlib.

    Args:
      workspace_name: The name of the workspace that this toolchain resides in
      name: The name of the toolchain declaration
      target_triple: The rust-style target triple of the tool
    """

    system = triple_to_system(target_triple)

    return """
rust_toolchain(
    name = "{toolchain_name}_impl",
    rust_doc = "@{workspace_name}//:rustdoc",
    rust_lib = "@{workspace_name}//:rust_lib-{target_triple}",
    rustc = "@{workspace_name}//:rustc",
    rustc_lib = "@{workspace_name}//:rustc_lib",
    staticlib_ext = "{staticlib_ext}",
    dylib_ext = "{dylib_ext}",
    os = "{system}",
    default_edition = "{default_edition}",
    target_triple = "{target_triple}",
    visibility = ["//visibility:public"],
)
""".format(
        toolchain_name = name,
        workspace_name = workspace_name,
        staticlib_ext = staticlib_ext,
        dylib_ext = dylib_ext,
        system = "STUB",
        default_edition = default_edition,
        target_triple = target_triple,
    )


def BUILD_for_toolchain(name, exec_compatible_with, target_compatible_with):
    return """
toolchain(
    name = "{name}",
    exec_compatible_with = {exec_constraint},
    target_compatible_with = {target_constraint},
    toolchain = ":{name}_impl",
    toolchain_type = "@io_bazel_rules_rust//rust:toolchain",
)
""".format(
        name = name,
        exec_constraint = exec_compatible_with,
        target_constraint = target_compatible_with,
    )


ToolchainProvider = provider()

def _rust_toolchain_definition_impl(ctx):
  toolchain = ToolchainProvider(target_triple = ctx.attr.target_triple,
                                dylib_ext = ctx.attr.dylib_ext,
                                binary_ext = ctx.attr.binary_ext,
                                staticlib_ext = ctx.attr.staticlib_ext,
                                exec_compatible_with = ctx.attr.exec_compatible_with,
                                target_compatible_with = ctx.attr.target_compatible_with,
                                )
  return [toolchain]

rust_toolchain_definition = rule(
    providers = [ToolchainProvider],
    attrs = {
        "target_triple": attr.string(mandatory = True),
        "dylib_ext": attr.string(mandatory = True),
        "binary_ext": attr.string(mandatory = True),
        "staticlib_ext": attr.string(mandatory = True),
        "exec_compatible_with": attr.label_list(mandatory = True, providers = ConstraintValueInfo),
        "target_compatible_with": attr.label_list(mandatory = True, providers = ConstraintValueInfo),
    },
)

def _rust_toolchain_repository_impl(ctx):
    host_definition = ctx.attr.host_definition
    load_arbitrary_tool(
        ctx,
        iso_date = ctx.attr.iso_date,
        param_prefix = "rustc_",
        target_triple = host_definition.target_triple,
        tool_name = "rustc",
        tool_subdirectory = "rustc",
        version = ctx.attr.version,
    )

    BUILD_components = [BUILD_for_compiler(host_definition.binary_ext,
                                           host_definition.staticlib_ext,
                                           host_definition.dylib_ext,
                                           host_definition.target_triple)]

    for target_definition in [ctx.attr.host_definition] + ctx.attr.extra_definitions:
        load_arbitrary_tool(
            ctx,
            iso_date = ctx.attr.iso_date,
            param_prefix = "rust-std_",
            target_triple = target_definition.target_triple,
            tool_name = "rust-std",
            tool_subdirectory = "rust-std-{}".format(target_definition.target_triple),
            version = ctx.attr.version,
        )

        BUILD_components.append(BUILD_for_stdlib(host_definition.binary_ext,
                                           host_definition.staticlib_ext,
                                           host_definition.dylib_ext,
                                           host_definition.target_triple))
        BUILD_components.append(BUILD_for_rust_toolchain(name = "toolchain_for_{triple}".format(
            triple = target_definition.target_triple),
                                                         binary_ext = target_definition.binary_ext,
                                                         staticlib_ext = target_definition.staticlib_ext,
                                                         dylib_ext = target_definition.dylib_ext,
                                                         target_triple = target_definition.target_triple,
                                                         workspace_name = ctx.attr.name,
                                                      ))
        BUILD_components.append(BUILD_for_toolchain(name = "toolchain_for_{triple}".format(triple = target_definition.target_triple),
                                                    target_compatible_with = target_definition.target_compatible_with,
                                                    exec_compatible_with = target_definition.exec_compatible_with))


    ctx.file("WORKSPACE", "")
    ctx.file("BUILD", "\n".join(BUILD_components))


rust_toolchain_repository = repository_rule(
    attrs = {
        "version": attr.string(mandatory = True),
        "iso_date": attr.string(),
        "host_definition": attr.label(mandatory = True, providers = ToolchainProvider),
        "extra_definitions": attr.label_list(providers = ToolchainProvider),
    },
    implementation = _rust_toolchain_repository_impl,
)
