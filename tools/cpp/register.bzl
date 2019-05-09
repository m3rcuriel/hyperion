TOOLCHAINS = [
    "//tools/cpp:cc-compiler-x86_64-bionic-toolchain",
    "//tools/cpp:cc-compiler-x86_64-disco-toolchain",
]

def register_toolchains():
    native.register_toolchains(*TOOLCHAINS)
