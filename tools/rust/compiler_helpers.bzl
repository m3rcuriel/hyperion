load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

load("@io_bazel_rules_rust//rust:repositories.bzl", "load_arbitrary_tool")

# Based strongly on the repository work for rules_work.

def BUILD_for_compiler(binary_ext, staticlib_ext, dylib_ext, triple):
  return """
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


def BUILD_for_stdlib(binary_ext, staticlib_ext, dylib_ext, triple):
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


def BUILD_for_rust_toolchain(workspace_name, name, binary_ext, staticlib_ext, dylib_ext, target_triple, rustc_name, default_edition = "2018"):
    """Emits a toolchain declaration to match an existing compiler and stdlib.

    Args:
      workspace_name: The name of the workspace that this toolchain resides in
      name: The name of the toolchain declaration
      target_triple: The rust-style target triple of the tool
    """

    return """
rust_toolchain(
    name = "{toolchain_name}_impl",
    rust_doc = "@{workspace_name}//:rustdoc",
    rust_lib = "@{workspace_name}//:rust_lib-{target_triple}",
    rustc = "@{rustc_name}//:rustc",
    rustc_lib = "@{rustc_name}//:rustc_lib",
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
        rustc_name = rustc_name,
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

def _rust_toolchain_repository_impl(ctx):
  BUILD_components = ['load("@io_bazel_rules_rust//rust:toolchain.bzl", "rust_toolchain")']
  if ctx.attr.external_compiler == "":
    load_arbitrary_tool(
        ctx,
        iso_date = ctx.attr.iso_date,
        param_prefix = "rustc_",
        target_triple = ctx.attr.target_triple,
        tool_name = "rustc",
        tool_subdirectory = "rustc",
        version = ctx.attr.version,
    )

    load_arbitrary_tool(
        ctx,
        iso_date = ctx.attr.iso_date,
        param_prefix = "rust-std_",
        target_triple = ctx.attr.target_triple,
        tool_name = "rust-std",
        tool_subdirectory = "rust-std-{}".format(ctx.attr.target_triple),
        version = ctx.attr.version,
    )

    BUILD_components.append(BUILD_for_compiler(ctx.attr.binary_ext,
                                           ctx.attr.staticlib_ext,
                                           ctx.attr.dylib_ext,
                                           ctx.attr.target_triple))
    BUILD_components.append(BUILD_for_stdlib(ctx.attr.binary_ext,
                                        ctx.attr.staticlib_ext,
                                        ctx.attr.dylib_ext,
                                        ctx.attr.target_triple))
    BUILD_components.append(BUILD_for_rust_toolchain(name = "toolchain_for_{triple}".format(
        triple = ctx.attr.target_triple),
                                                      binary_ext = ctx.attr.binary_ext,
                                                      staticlib_ext = ctx.attr.staticlib_ext,
                                                      dylib_ext = ctx.attr.dylib_ext,
                                                      target_triple = ctx.attr.target_triple,
                                                      workspace_name = ctx.attr.name,
                                                      rustc_name = ctx.attr.name,
                                                  ))
  else:
        load_arbitrary_tool(
            ctx,
            iso_date = ctx.attr.iso_date,
            param_prefix = "rust-std_",
            target_triple = ctx.attr.target_triple,
            tool_name = "rust-std",
            tool_subdirectory = "rust-std-{}".format(ctx.attr.target_triple),
            version = ctx.attr.version,
        )

        BUILD_components.append(BUILD_for_stdlib(ctx.attr.binary_ext,
                                            ctx.attr.staticlib_ext,
                                            ctx.attr.dylib_ext,
                                            ctx.attr.target_triple))
        BUILD_components.append(BUILD_for_rust_toolchain(name = "toolchain_for_{triple}".format(
            triple = ctx.attr.target_triple),
                                                         binary_ext = ctx.attr.binary_ext,
                                                         staticlib_ext = ctx.attr.staticlib_ext,
                                                         dylib_ext = ctx.attr.dylib_ext,
                                                         target_triple = ctx.attr.target_triple,
                                                         workspace_name = ctx.attr.name,
                                                         rustc_name = ctx.attr.external_compiler,
                                                      ))


  ctx.file("WORKSPACE", "")
  ctx.file("BUILD", "\n".join(BUILD_components))


rust_toolchain_repository = repository_rule(
    attrs = {
        "version": attr.string(mandatory = True),
        "iso_date": attr.string(),
        "dylib_ext": attr.string(mandatory = True),
        "staticlib_ext": attr.string(mandatory = True),
        "binary_ext": attr.string(mandatory = True),
        "target_triple": attr.string(mandatory = True),
        "external_compiler": attr.string(),
    },
    implementation = _rust_toolchain_repository_impl,
)
