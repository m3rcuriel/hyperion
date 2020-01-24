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
        name = "raze__alga__0_9_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/alga/alga-0.9.2.crate",
        type = "tar.gz",
        sha256 = "658f9468113d34781f6ca9d014d174c74b73de870f1e0e3ad32079bbab253b19",
        strip_prefix = "alga-0.9.2",
        build_file = Label("//cargo/remote:alga-0.9.2.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__approx__0_3_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/approx/approx-0.3.2.crate",
        type = "tar.gz",
        sha256 = "f0e60b75072ecd4168020818c0107f2857bb6c4e64252d8d3983f6263b40a5c3",
        strip_prefix = "approx-0.3.2",
        build_file = Label("//cargo/remote:approx-0.3.2.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__autocfg__0_1_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/autocfg/autocfg-0.1.7.crate",
        type = "tar.gz",
        sha256 = "1d49d90015b3c36167a20fe2810c5cd875ad504b39cff3d4eae7977e6b7c1cb2",
        strip_prefix = "autocfg-0.1.7",
        build_file = Label("//cargo/remote:autocfg-0.1.7.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__autocfg__1_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/autocfg/autocfg-1.0.0.crate",
        type = "tar.gz",
        sha256 = "f8aac770f1885fd7e387acedd76065302551364496e46b3dd00860b2f8359b9d",
        strip_prefix = "autocfg-1.0.0",
        build_file = Label("//cargo/remote:autocfg-1.0.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__bitflags__1_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bitflags/bitflags-1.2.1.crate",
        type = "tar.gz",
        sha256 = "cf1de2fe8c75bc145a2f577add951f8134889b4795d47466a54a5c846d691693",
        strip_prefix = "bitflags-1.2.1",
        build_file = Label("//cargo/remote:bitflags-1.2.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__cloudabi__0_0_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cloudabi/cloudabi-0.0.3.crate",
        type = "tar.gz",
        sha256 = "ddfc5b9aa5d4507acaf872de71051dfd0e309860e88966e1051e462a077aac4f",
        strip_prefix = "cloudabi-0.0.3",
        build_file = Label("//cargo/remote:cloudabi-0.0.3.BUILD.bazel")
    )

    _new_git_repository(
        name = "raze__fixedvec__0_2_3",
        remote = "https://github.com/m3rcuriel/fixedvec-rs",
        commit = "c111bd0b1adc5e0cb3858e9aa94dbfdae74906c3",
        build_file = Label("//cargo/remote:fixedvec-0.2.3.BUILD.bazel"),
        init_submodules = True
    )

    _new_git_repository(
        name = "raze__flatbuffers__0_6_0",
        remote = "https://github.com/m3rcuriel/flatbuffers",
        commit = "8e0f36371ee14352524daa66979470635555b640",
        build_file = Label("//cargo/remote:flatbuffers-0.6.0.BUILD.bazel"),
        init_submodules = True
    )

    _new_http_archive(
        name = "raze__fuchsia_cprng__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/fuchsia-cprng/fuchsia-cprng-0.1.1.crate",
        type = "tar.gz",
        sha256 = "a06f77d526c1a601b7c4cdd98f54b5eaabffc14d5f2f0296febdc7f357c6d3ba",
        strip_prefix = "fuchsia-cprng-0.1.1",
        build_file = Label("//cargo/remote:fuchsia-cprng-0.1.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__generic_array__0_12_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/generic-array/generic-array-0.12.3.crate",
        type = "tar.gz",
        sha256 = "c68f0274ae0e023facc3c97b2e00f076be70e254bc851d972503b328db79b2ec",
        strip_prefix = "generic-array-0.12.3",
        build_file = Label("//cargo/remote:generic-array-0.12.3.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__libc__0_2_66",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libc/libc-0.2.66.crate",
        type = "tar.gz",
        sha256 = "d515b1f41455adea1313a4a2ac8a8a477634fbae63cc6100e3aebb207ce61558",
        strip_prefix = "libc-0.2.66",
        build_file = Label("//cargo/remote:libc-0.2.66.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__libm__0_1_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libm/libm-0.1.4.crate",
        type = "tar.gz",
        sha256 = "7fc7aa29613bd6a620df431842069224d8bc9011086b1db4c0e0cd47fa03ec9a",
        strip_prefix = "libm-0.1.4",
        build_file = Label("//cargo/remote:libm-0.1.4.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__matrixmultiply__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/matrixmultiply/matrixmultiply-0.2.3.crate",
        type = "tar.gz",
        sha256 = "d4f7ec66360130972f34830bfad9ef05c6610a43938a467bcc9ab9369ab3478f",
        strip_prefix = "matrixmultiply-0.2.3",
        build_file = Label("//cargo/remote:matrixmultiply-0.2.3.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__maybe_uninit__2_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/maybe-uninit/maybe-uninit-2.0.0.crate",
        type = "tar.gz",
        sha256 = "60302e4db3a61da70c0cb7991976248362f30319e88850c487b9b95bbf059e00",
        strip_prefix = "maybe-uninit-2.0.0",
        build_file = Label("//cargo/remote:maybe-uninit-2.0.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__nalgebra__0_18_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/nalgebra/nalgebra-0.18.1.crate",
        type = "tar.gz",
        sha256 = "aaa9fddbc34c8c35dd2108515587b8ce0cab396f17977b8c738568e4edb521a2",
        strip_prefix = "nalgebra-0.18.1",
        build_file = Label("//cargo/remote:nalgebra-0.18.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__num_complex__0_2_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-complex/num-complex-0.2.4.crate",
        type = "tar.gz",
        sha256 = "b6b19411a9719e753aff12e5187b74d60d3dc449ec3f4dc21e3989c3f554bc95",
        strip_prefix = "num-complex-0.2.4",
        build_file = Label("//cargo/remote:num-complex-0.2.4.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__num_integer__0_1_42",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-integer/num-integer-0.1.42.crate",
        type = "tar.gz",
        sha256 = "3f6ea62e9d81a77cd3ee9a2a5b9b609447857f3d358704331e4ef39eb247fcba",
        strip_prefix = "num-integer-0.1.42",
        build_file = Label("//cargo/remote:num-integer-0.1.42.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__num_rational__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-rational/num-rational-0.2.3.crate",
        type = "tar.gz",
        sha256 = "da4dc79f9e6c81bef96148c8f6b8e72ad4541caa4a24373e900a36da07de03a3",
        strip_prefix = "num-rational-0.2.3",
        build_file = Label("//cargo/remote:num-rational-0.2.3.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__num_traits__0_2_11",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-traits/num-traits-0.2.11.crate",
        type = "tar.gz",
        sha256 = "c62be47e61d1842b9170f0fdeec8eba98e60e90e5446449a0545e5152acd7096",
        strip_prefix = "num-traits-0.2.11",
        build_file = Label("//cargo/remote:num-traits-0.2.11.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__proc_macro2__1_0_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/proc-macro2/proc-macro2-1.0.8.crate",
        type = "tar.gz",
        sha256 = "3acb317c6ff86a4e579dfa00fc5e6cca91ecbb4e7eb2df0468805b674eb88548",
        strip_prefix = "proc-macro2-1.0.8",
        build_file = Label("//cargo/remote:proc-macro2-1.0.8.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rand__0_6_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand/rand-0.6.5.crate",
        type = "tar.gz",
        sha256 = "6d71dacdc3c88c1fde3885a3be3fbab9f35724e6ce99467f7d9c5026132184ca",
        strip_prefix = "rand-0.6.5",
        build_file = Label("//cargo/remote:rand-0.6.5.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rand_chacha__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_chacha/rand_chacha-0.1.1.crate",
        type = "tar.gz",
        sha256 = "556d3a1ca6600bfcbab7c7c91ccb085ac7fbbcd70e008a98742e7847f4f7bcef",
        strip_prefix = "rand_chacha-0.1.1",
        build_file = Label("//cargo/remote:rand_chacha-0.1.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rand_core__0_3_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_core/rand_core-0.3.1.crate",
        type = "tar.gz",
        sha256 = "7a6fdeb83b075e8266dcc8762c22776f6877a63111121f5f8c7411e5be7eed4b",
        strip_prefix = "rand_core-0.3.1",
        build_file = Label("//cargo/remote:rand_core-0.3.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rand_core__0_4_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_core/rand_core-0.4.2.crate",
        type = "tar.gz",
        sha256 = "9c33a3c44ca05fa6f1807d8e6743f3824e8509beca625669633be0acbdf509dc",
        strip_prefix = "rand_core-0.4.2",
        build_file = Label("//cargo/remote:rand_core-0.4.2.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rand_hc__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_hc/rand_hc-0.1.0.crate",
        type = "tar.gz",
        sha256 = "7b40677c7be09ae76218dc623efbf7b18e34bced3f38883af07bb75630a21bc4",
        strip_prefix = "rand_hc-0.1.0",
        build_file = Label("//cargo/remote:rand_hc-0.1.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rand_isaac__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_isaac/rand_isaac-0.1.1.crate",
        type = "tar.gz",
        sha256 = "ded997c9d5f13925be2a6fd7e66bf1872597f759fd9dd93513dd7e92e5a5ee08",
        strip_prefix = "rand_isaac-0.1.1",
        build_file = Label("//cargo/remote:rand_isaac-0.1.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rand_jitter__0_1_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_jitter/rand_jitter-0.1.4.crate",
        type = "tar.gz",
        sha256 = "1166d5c91dc97b88d1decc3285bb0a99ed84b05cfd0bc2341bdf2d43fc41e39b",
        strip_prefix = "rand_jitter-0.1.4",
        build_file = Label("//cargo/remote:rand_jitter-0.1.4.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rand_os__0_1_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_os/rand_os-0.1.3.crate",
        type = "tar.gz",
        sha256 = "7b75f676a1e053fc562eafbb47838d67c84801e38fc1ba459e8f180deabd5071",
        strip_prefix = "rand_os-0.1.3",
        build_file = Label("//cargo/remote:rand_os-0.1.3.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rand_pcg__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_pcg/rand_pcg-0.1.2.crate",
        type = "tar.gz",
        sha256 = "abf9b09b01790cfe0364f52bf32995ea3c39f4d2dd011eac241d2914146d0b44",
        strip_prefix = "rand_pcg-0.1.2",
        build_file = Label("//cargo/remote:rand_pcg-0.1.2.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rand_xorshift__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_xorshift/rand_xorshift-0.1.1.crate",
        type = "tar.gz",
        sha256 = "cbf7e9e623549b0e21f6e97cf8ecf247c1a8fd2e8a992ae265314300b2455d5c",
        strip_prefix = "rand_xorshift-0.1.1",
        build_file = Label("//cargo/remote:rand_xorshift-0.1.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rawpointer__0_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rawpointer/rawpointer-0.2.1.crate",
        type = "tar.gz",
        sha256 = "60a357793950651c4ed0f3f52338f53b2f809f32d83a07f72909fa13e4c6c1e3",
        strip_prefix = "rawpointer-0.2.1",
        build_file = Label("//cargo/remote:rawpointer-0.2.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rdrand__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rdrand/rdrand-0.4.0.crate",
        type = "tar.gz",
        sha256 = "678054eb77286b51581ba43620cc911abf02758c91f93f479767aed0f90458b2",
        strip_prefix = "rdrand-0.4.0",
        build_file = Label("//cargo/remote:rdrand-0.4.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__smallvec__0_6_13",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/smallvec/smallvec-0.6.13.crate",
        type = "tar.gz",
        sha256 = "f7b0758c52e15a8b5e3691eae6cc559f08eee9406e548a4477ba4e67770a82b6",
        strip_prefix = "smallvec-0.6.13",
        build_file = Label("//cargo/remote:smallvec-0.6.13.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__typenum__1_10_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/typenum/typenum-1.10.0.crate",
        type = "tar.gz",
        sha256 = "612d636f949607bdf9b123b4a6f6d966dedf3ff669f7f045890d3a4a73948169",
        strip_prefix = "typenum-1.10.0",
        build_file = Label("//cargo/remote:typenum-1.10.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__unicode_xid__0_2_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/unicode-xid/unicode-xid-0.2.0.crate",
        type = "tar.gz",
        sha256 = "826e7639553986605ec5979c7dd957c7895e93eabed50ab2ffa7f6128a75097c",
        strip_prefix = "unicode-xid-0.2.0",
        build_file = Label("//cargo/remote:unicode-xid-0.2.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__winapi__0_3_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi/winapi-0.3.8.crate",
        type = "tar.gz",
        sha256 = "8093091eeb260906a183e6ae1abdba2ef5ef2257a21801128899c3fc699229c6",
        strip_prefix = "winapi-0.3.8",
        build_file = Label("//cargo/remote:winapi-0.3.8.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__winapi_i686_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-i686-pc-windows-gnu/winapi-i686-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        sha256 = "ac3b87c63620426dd9b991e5ce0329eff545bccbbb34f3be09ff6fb6ab51b7b6",
        strip_prefix = "winapi-i686-pc-windows-gnu-0.4.0",
        build_file = Label("//cargo/remote:winapi-i686-pc-windows-gnu-0.4.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__winapi_x86_64_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-x86_64-pc-windows-gnu/winapi-x86_64-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        sha256 = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f",
        strip_prefix = "winapi-x86_64-pc-windows-gnu-0.4.0",
        build_file = Label("//cargo/remote:winapi-x86_64-pc-windows-gnu-0.4.0.BUILD.bazel")
    )

