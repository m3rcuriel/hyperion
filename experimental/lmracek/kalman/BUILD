py_library(
    name = "filter",
    srcs = [
        "filter.py",
    ],
    visibility = ["//visibility:public"],
    tags = [ "manual" ],
)

py_library(
    name = "kalman_filter",
    srcs = [
        "kalman.py",
    ],
    visibility = ["//visibility:public"],
    deps = [
        ":filter",
    ],
    tags = [ "manual" ],
)

py_test(
    name = "kalman_test",
    srcs = [
        "kalman_test.py",
    ],
    deps = [
        ":kalman_filter",
    ],
    tags = [ "manual" ],
)
