cc_binary(
    name = "hello_world",
    srcs = ["hello_world.cc"],
)

sh_test(
    name = "cc_compilation_test",
    size = "small",
    srcs = [
        ":cc_check.sh",
    ],
    data = [
        "//tools/cpp/hello_world",
    ],
)
