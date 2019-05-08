TOOLCHAINS = [
    "//tools/cpp:cc-compiler-x86_64-toolchain"
]

def register_toolchains():
  native.register_toolchains(*TOOLCHAINS)
