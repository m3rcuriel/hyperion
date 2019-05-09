TOOLCHAINS = [
    "//tools/rust:x86_64-linux-toolchain",
]

def register_toolchains():
    native.register_toolchains(*TOOLCHAINS)
