load("@io_bazel_rules_rust//rust:rust.bzl", "rust_library")

def generate_all_default(SVDS):
  for desc in SVDS:
    rust_cortexm_description(desc, suffix="default")

def rust_cortexm_description(name, memory="//tools/embedded/hardware:memory.x",
                                   device="",
                                   link="//tools/embedded/hardware:link.x",
                                   suffix=""):
  if suffix != "":
    suffix = "_{}".format(suffix)

  native.genrule(
    name = "{}_{}desc".format(name, suffix),
    srcs = ["//tools/embedded/descriptions:{}.svd".format(name)],
    outs = ["{}_{}build.rs".format(name, suffix), "{}_{}lib.rs".format(name, suffix), "{}_{}device.x".format(name, suffix)],
    cmd = """
$(location //cargo:cargo_bin_svd2rust) -i $(SRCS)
mv build.rs $(@D)/{0}_{1}build.rs
mv lib.rs $(@D)/{0}_{1}lib.rs
mv device.x $(@D)/{0}_{1}device.x
""".format(name, suffix),
    tools = ["//cargo:cargo_bin_svd2rust"],
  )

  if device == "":
    device = "//tools/embedded:{}_{}device.x".format(name, suffix)

  native.genrule(
    name = "{}_{}link.x".format(name, suffix),
    srcs = [device, memory, link],
    outs = ["{}_{}link.ld".format(name, suffix)],
    cmd = "cat $(location {0}) $(location {1}) $(location {2}) > $@".format(device, memory, link),
  )

  rust_library(
    name = "{}{}".format(name, suffix),
    srcs = [":{}_{}lib.rs".format(name, suffix)],
    deps = [
        "//cargo:cortex_m",
        "//cargo:bare_metal",
        "//cargo:vcell",
    ],
  )
