"""
cargo-raze crate workspace functions

DO NOT EDIT! Replaced on runs of cargo-raze
"""
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")
load("@bazel_tools//tools/build_defs/repo:git.bzl", "new_git_repository")

def _new_http_archive(name, **kwargs):
    if not native.existing_rule(name):
        http_archive(name=name, **kwargs)

def _new_git_repository(name, **kwargs):
    if not native.existing_rule(name):
        new_git_repository(name=name, **kwargs)

def raze_fetch_remote_crates():

    _new_http_archive(
        name = "raze__alga__0_9_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/alga/alga-0.9.0.crate",
        type = "tar.gz",
        sha256 = "a033171acc255e6d0c6490e701097632377c2435fdf084a2a4c0cbeb9e1395ac",
        strip_prefix = "alga-0.9.0",
        build_file = Label("//cargo/remote:alga-0.9.0.BUILD")
    )

    _new_http_archive(
        name = "raze__approx__0_3_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/approx/approx-0.3.2.crate",
        type = "tar.gz",
        sha256 = "f0e60b75072ecd4168020818c0107f2857bb6c4e64252d8d3983f6263b40a5c3",
        strip_prefix = "approx-0.3.2",
        build_file = Label("//cargo/remote:approx-0.3.2.BUILD")
    )

    _new_http_archive(
        name = "raze__autocfg__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/autocfg/autocfg-0.1.2.crate",
        type = "tar.gz",
        sha256 = "a6d640bee2da49f60a4068a7fae53acde8982514ab7bae8b8cea9e88cbcfd799",
        strip_prefix = "autocfg-0.1.2",
        build_file = Label("//cargo/remote:autocfg-0.1.2.BUILD")
    )

    _new_http_archive(
        name = "raze__bitflags__1_0_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bitflags/bitflags-1.0.4.crate",
        type = "tar.gz",
        sha256 = "228047a76f468627ca71776ecdebd732a3423081fcf5125585bcd7c49886ce12",
        strip_prefix = "bitflags-1.0.4",
        build_file = Label("//cargo/remote:bitflags-1.0.4.BUILD")
    )

    _new_http_archive(
        name = "raze__cloudabi__0_0_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cloudabi/cloudabi-0.0.3.crate",
        type = "tar.gz",
        sha256 = "ddfc5b9aa5d4507acaf872de71051dfd0e309860e88966e1051e462a077aac4f",
        strip_prefix = "cloudabi-0.0.3",
        build_file = Label("//cargo/remote:cloudabi-0.0.3.BUILD")
    )

    _new_http_archive(
        name = "raze__fuchsia_cprng__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/fuchsia-cprng/fuchsia-cprng-0.1.1.crate",
        type = "tar.gz",
        sha256 = "a06f77d526c1a601b7c4cdd98f54b5eaabffc14d5f2f0296febdc7f357c6d3ba",
        strip_prefix = "fuchsia-cprng-0.1.1",
        build_file = Label("//cargo/remote:fuchsia-cprng-0.1.1.BUILD")
    )

    _new_http_archive(
        name = "raze__generic_array__0_12_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/generic-array/generic-array-0.12.0.crate",
        type = "tar.gz",
        sha256 = "3c0f28c2f5bfb5960175af447a2da7c18900693738343dc896ffbcabd9839592",
        strip_prefix = "generic-array-0.12.0",
        build_file = Label("//cargo/remote:generic-array-0.12.0.BUILD")
    )

    _new_http_archive(
        name = "raze__libc__0_2_54",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libc/libc-0.2.54.crate",
        type = "tar.gz",
        sha256 = "c6785aa7dd976f5fbf3b71cfd9cd49d7f783c1ff565a858d71031c6c313aa5c6",
        strip_prefix = "libc-0.2.54",
        build_file = Label("//cargo/remote:libc-0.2.54.BUILD")
    )

    _new_http_archive(
        name = "raze__libm__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libm/libm-0.1.2.crate",
        type = "tar.gz",
        sha256 = "03c0bb6d5ce1b5cc6fd0578ec1cbc18c9d88b5b591a5c7c1d6c6175e266a0819",
        strip_prefix = "libm-0.1.2",
        build_file = Label("//cargo/remote:libm-0.1.2.BUILD")
    )

    _new_http_archive(
        name = "raze__matrixmultiply__0_2_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/matrixmultiply/matrixmultiply-0.2.2.crate",
        type = "tar.gz",
        sha256 = "dcfed72d871629daa12b25af198f110e8095d7650f5f4c61c5bac28364604f9b",
        strip_prefix = "matrixmultiply-0.2.2",
        build_file = Label("//cargo/remote:matrixmultiply-0.2.2.BUILD")
    )

    _new_http_archive(
        name = "raze__nalgebra__0_18_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/nalgebra/nalgebra-0.18.0.crate",
        type = "tar.gz",
        sha256 = "8e12856109b5cb8e2934b5e45e4624839416e1c6c1f7d286711a7a66b79db29d",
        strip_prefix = "nalgebra-0.18.0",
        build_file = Label("//cargo/remote:nalgebra-0.18.0.BUILD")
    )

    _new_http_archive(
        name = "raze__num_complex__0_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-complex/num-complex-0.2.1.crate",
        type = "tar.gz",
        sha256 = "107b9be86cd2481930688277b675b0114578227f034674726605b8a482d8baf8",
        strip_prefix = "num-complex-0.2.1",
        build_file = Label("//cargo/remote:num-complex-0.2.1.BUILD")
    )

    _new_http_archive(
        name = "raze__num_traits__0_2_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-traits/num-traits-0.2.6.crate",
        type = "tar.gz",
        sha256 = "0b3a5d7cc97d6d30d8b9bc8fa19bf45349ffe46241e8816f50f62f6d6aaabee1",
        strip_prefix = "num-traits-0.2.6",
        build_file = Label("//cargo/remote:num-traits-0.2.6.BUILD")
    )

    _new_http_archive(
        name = "raze__rand__0_6_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand/rand-0.6.5.crate",
        type = "tar.gz",
        sha256 = "6d71dacdc3c88c1fde3885a3be3fbab9f35724e6ce99467f7d9c5026132184ca",
        strip_prefix = "rand-0.6.5",
        build_file = Label("//cargo/remote:rand-0.6.5.BUILD")
    )

    _new_http_archive(
        name = "raze__rand_chacha__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_chacha/rand_chacha-0.1.1.crate",
        type = "tar.gz",
        sha256 = "556d3a1ca6600bfcbab7c7c91ccb085ac7fbbcd70e008a98742e7847f4f7bcef",
        strip_prefix = "rand_chacha-0.1.1",
        build_file = Label("//cargo/remote:rand_chacha-0.1.1.BUILD")
    )

    _new_http_archive(
        name = "raze__rand_core__0_3_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_core/rand_core-0.3.1.crate",
        type = "tar.gz",
        sha256 = "7a6fdeb83b075e8266dcc8762c22776f6877a63111121f5f8c7411e5be7eed4b",
        strip_prefix = "rand_core-0.3.1",
        build_file = Label("//cargo/remote:rand_core-0.3.1.BUILD")
    )

    _new_http_archive(
        name = "raze__rand_core__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_core/rand_core-0.4.0.crate",
        type = "tar.gz",
        sha256 = "d0e7a549d590831370895ab7ba4ea0c1b6b011d106b5ff2da6eee112615e6dc0",
        strip_prefix = "rand_core-0.4.0",
        build_file = Label("//cargo/remote:rand_core-0.4.0.BUILD")
    )

    _new_http_archive(
        name = "raze__rand_hc__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_hc/rand_hc-0.1.0.crate",
        type = "tar.gz",
        sha256 = "7b40677c7be09ae76218dc623efbf7b18e34bced3f38883af07bb75630a21bc4",
        strip_prefix = "rand_hc-0.1.0",
        build_file = Label("//cargo/remote:rand_hc-0.1.0.BUILD")
    )

    _new_http_archive(
        name = "raze__rand_isaac__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_isaac/rand_isaac-0.1.1.crate",
        type = "tar.gz",
        sha256 = "ded997c9d5f13925be2a6fd7e66bf1872597f759fd9dd93513dd7e92e5a5ee08",
        strip_prefix = "rand_isaac-0.1.1",
        build_file = Label("//cargo/remote:rand_isaac-0.1.1.BUILD")
    )

    _new_http_archive(
        name = "raze__rand_jitter__0_1_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_jitter/rand_jitter-0.1.4.crate",
        type = "tar.gz",
        sha256 = "1166d5c91dc97b88d1decc3285bb0a99ed84b05cfd0bc2341bdf2d43fc41e39b",
        strip_prefix = "rand_jitter-0.1.4",
        build_file = Label("//cargo/remote:rand_jitter-0.1.4.BUILD")
    )

    _new_http_archive(
        name = "raze__rand_os__0_1_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_os/rand_os-0.1.3.crate",
        type = "tar.gz",
        sha256 = "7b75f676a1e053fc562eafbb47838d67c84801e38fc1ba459e8f180deabd5071",
        strip_prefix = "rand_os-0.1.3",
        build_file = Label("//cargo/remote:rand_os-0.1.3.BUILD")
    )

    _new_http_archive(
        name = "raze__rand_pcg__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_pcg/rand_pcg-0.1.2.crate",
        type = "tar.gz",
        sha256 = "abf9b09b01790cfe0364f52bf32995ea3c39f4d2dd011eac241d2914146d0b44",
        strip_prefix = "rand_pcg-0.1.2",
        build_file = Label("//cargo/remote:rand_pcg-0.1.2.BUILD")
    )

    _new_http_archive(
        name = "raze__rand_xorshift__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_xorshift/rand_xorshift-0.1.1.crate",
        type = "tar.gz",
        sha256 = "cbf7e9e623549b0e21f6e97cf8ecf247c1a8fd2e8a992ae265314300b2455d5c",
        strip_prefix = "rand_xorshift-0.1.1",
        build_file = Label("//cargo/remote:rand_xorshift-0.1.1.BUILD")
    )

    _new_http_archive(
        name = "raze__rawpointer__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rawpointer/rawpointer-0.1.0.crate",
        type = "tar.gz",
        sha256 = "ebac11a9d2e11f2af219b8b8d833b76b1ea0e054aa0e8d8e9e4cbde353bdf019",
        strip_prefix = "rawpointer-0.1.0",
        build_file = Label("//cargo/remote:rawpointer-0.1.0.BUILD")
    )

    _new_http_archive(
        name = "raze__rdrand__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rdrand/rdrand-0.4.0.crate",
        type = "tar.gz",
        sha256 = "678054eb77286b51581ba43620cc911abf02758c91f93f479767aed0f90458b2",
        strip_prefix = "rdrand-0.4.0",
        build_file = Label("//cargo/remote:rdrand-0.4.0.BUILD")
    )

    _new_http_archive(
        name = "raze__typenum__1_10_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/typenum/typenum-1.10.0.crate",
        type = "tar.gz",
        sha256 = "612d636f949607bdf9b123b4a6f6d966dedf3ff669f7f045890d3a4a73948169",
        strip_prefix = "typenum-1.10.0",
        build_file = Label("//cargo/remote:typenum-1.10.0.BUILD")
    )

    _new_http_archive(
        name = "raze__winapi__0_3_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi/winapi-0.3.7.crate",
        type = "tar.gz",
        sha256 = "f10e386af2b13e47c89e7236a7a14a086791a2b88ebad6df9bf42040195cf770",
        strip_prefix = "winapi-0.3.7",
        build_file = Label("//cargo/remote:winapi-0.3.7.BUILD")
    )

    _new_http_archive(
        name = "raze__winapi_i686_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-i686-pc-windows-gnu/winapi-i686-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        sha256 = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6",
        strip_prefix = "winapi-i686-pc-windows-gnu-0.4.0",
        build_file = Label("//cargo/remote:winapi-i686-pc-windows-gnu-0.4.0.BUILD")
    )

    _new_http_archive(
        name = "raze__winapi_x86_64_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-x86_64-pc-windows-gnu/winapi-x86_64-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        sha256 = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f",
        strip_prefix = "winapi-x86_64-pc-windows-gnu-0.4.0",
        build_file = Label("//cargo/remote:winapi-x86_64-pc-windows-gnu-0.4.0.BUILD")
    )

