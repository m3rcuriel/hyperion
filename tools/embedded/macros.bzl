def rust_cortexm_description(name):
  native.genrule(
    name = "{}_desc".format(name),
    srcs = ["//tools/embedded/descriptions/{}.svd".format(name)],
    outs = ["build.rs", "lib.rs", "device.x"],
    cmd = "$(location //cargo:cargo_bin_svd2rust) -i $(SRCS)",
    tools = ["//cargo:cargo_bin_svd2rust"],
  )
