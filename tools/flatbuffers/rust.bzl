load("@com_github_google_flatbuffers//:build_defs.bzl", "flatbuffer_library_public",
     "DEFAULT_INCLUDE_PATHS", "DEFAULT_FLATC_ARGS")
load("@io_bazel_rules_rust//rust:rust.bzl", "rust_library")

def flatbuffer_rust_library(
        name,
        srcs,
        srcs_filegroup_name = "",
        out_prefix = "",
        includes = [],
        include_paths = DEFAULT_INCLUDE_PATHS,
        flatc_args = DEFAULT_FLATC_ARGS,
        visibility = None,
        srcs_filegroup_visibility = None,
        gen_reflections = False):
  output_files = [
      (out_prefix + "%s_generated.rs") % (s.replace(".fbs", "").split("/")[-1])
      for s in srcs
  ]

  reflection_name = "%s_reflection" % name if gen_reflections else ""

  srcs_lib = "%s_srcs" % name
  flatbuffer_library_public(
      name = srcs_lib,
      srcs = srcs,
      outs = output_files,
      language_flag = "-r",
      out_prefix = out_prefix,
      includes = includes,
      include_paths = include_paths,
      flatc_args = flatc_args,
      reflection_name = reflection_name,
      reflection_visiblity = visibility,
  )

  rust_library(
      name = name,
      srcs = [
          ":" + srcs_lib,
      ],
      deps = [
          "//cargo:flatbuffers",
      ],
      visibility = visibility,
  )

  native.filegroup(
      name = srcs_filegroup_name if srcs_filegroup_name else "%s_includes" % (name),
      srcs = srcs,
      visibility = srcs_filegroup_visibility if srcs_filegroup_visibility != None else visibility,
  )
