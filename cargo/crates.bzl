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
        name = "raze__aho_corasick__0_7_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/aho-corasick/aho-corasick-0.7.6.crate",
        type = "tar.gz",
        sha256 = "58fb5e95d83b38284460a5fda7d6470aa0b8844d283a0b614b8535e880800d2d",
        strip_prefix = "aho-corasick-0.7.6",
        build_file = Label("//cargo/remote:aho-corasick-0.7.6.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__alga__0_9_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/alga/alga-0.9.0.crate",
        type = "tar.gz",
        sha256 = "a033171acc255e6d0c6490e701097632377c2435fdf084a2a4c0cbeb9e1395ac",
        strip_prefix = "alga-0.9.0",
        build_file = Label("//cargo/remote:alga-0.9.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__ansi_term__0_11_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/ansi_term/ansi_term-0.11.0.crate",
        type = "tar.gz",
        sha256 = "ee49baf6cb617b853aa8d93bf420db2383fab46d314482ca2803b40d5fde979b",
        strip_prefix = "ansi_term-0.11.0",
        build_file = Label("//cargo/remote:ansi_term-0.11.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__anyhow__1_0_26",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/anyhow/anyhow-1.0.26.crate",
        type = "tar.gz",
        sha256 = "7825f6833612eb2414095684fcf6c635becf3ce97fe48cf6421321e93bfbd53c",
        strip_prefix = "anyhow-1.0.26",
        build_file = Label("//cargo/remote:anyhow-1.0.26.BUILD.bazel")
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
        name = "raze__atty__0_2_14",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/atty/atty-0.2.14.crate",
        type = "tar.gz",
        sha256 = "d9b39be18770d11421cdb1b9947a45dd3f37e93092cbf377614828a319d5fee8",
        strip_prefix = "atty-0.2.14",
        build_file = Label("//cargo/remote:atty-0.2.14.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__autocfg__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/autocfg/autocfg-0.1.2.crate",
        type = "tar.gz",
        sha256 = "a6d640bee2da49f60a4068a7fae53acde8982514ab7bae8b8cea9e88cbcfd799",
        strip_prefix = "autocfg-0.1.2",
        build_file = Label("//cargo/remote:autocfg-0.1.2.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__backtrace__0_3_42",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/backtrace/backtrace-0.3.42.crate",
        type = "tar.gz",
        sha256 = "b4b1549d804b6c73f4817df2ba073709e96e426f12987127c48e6745568c350b",
        strip_prefix = "backtrace-0.3.42",
        build_file = Label("//cargo/remote:backtrace-0.3.42.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__backtrace_sys__0_1_32",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/backtrace-sys/backtrace-sys-0.1.32.crate",
        type = "tar.gz",
        sha256 = "5d6575f128516de27e3ce99689419835fce9643a9b215a14d2b5b685be018491",
        strip_prefix = "backtrace-sys-0.1.32",
        build_file = Label("//cargo/remote:backtrace-sys-0.1.32.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__bitflags__1_0_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bitflags/bitflags-1.0.4.crate",
        type = "tar.gz",
        sha256 = "228047a76f468627ca71776ecdebd732a3423081fcf5125585bcd7c49886ce12",
        strip_prefix = "bitflags-1.0.4",
        build_file = Label("//cargo/remote:bitflags-1.0.4.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__cast__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cast/cast-0.2.3.crate",
        type = "tar.gz",
        sha256 = "4b9434b9a5aa1450faa3f9cb14ea0e8c53bb5d2b3c1bfd1ab4fc03e9f33fbfb0",
        strip_prefix = "cast-0.2.3",
        build_file = Label("//cargo/remote:cast-0.2.3.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__cc__1_0_50",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cc/cc-1.0.50.crate",
        type = "tar.gz",
        sha256 = "95e28fa049fda1c330bcf9d723be7663a899c4679724b34c81e9f5a326aab8cd",
        strip_prefix = "cc-1.0.50",
        build_file = Label("//cargo/remote:cc-1.0.50.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__cfg_if__0_1_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cfg-if/cfg-if-0.1.7.crate",
        type = "tar.gz",
        sha256 = "11d43355396e872eefb45ce6342e4374ed7bc2b3a502d1b28e36d6e23c05d1f4",
        strip_prefix = "cfg-if-0.1.7",
        build_file = Label("//cargo/remote:cfg-if-0.1.7.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__clap__2_33_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/clap/clap-2.33.0.crate",
        type = "tar.gz",
        sha256 = "5067f5bb2d80ef5d68b4c87db81601f0b75bca627bc2ef76b141d7b846a3c6d9",
        strip_prefix = "clap-2.33.0",
        build_file = Label("//cargo/remote:clap-2.33.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__cloudabi__0_0_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cloudabi/cloudabi-0.0.3.crate",
        type = "tar.gz",
        sha256 = "ddfc5b9aa5d4507acaf872de71051dfd0e309860e88966e1051e462a077aac4f",
        strip_prefix = "cloudabi-0.0.3",
        build_file = Label("//cargo/remote:cloudabi-0.0.3.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__either__1_5_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/either/either-1.5.3.crate",
        type = "tar.gz",
        sha256 = "bb1f6b1ce1c140482ea30ddd3335fc0024ac7ee112895426e0a629a6c20adfe3",
        strip_prefix = "either-1.5.3",
        build_file = Label("//cargo/remote:either-1.5.3.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__env_logger__0_7_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/env_logger/env_logger-0.7.1.crate",
        type = "tar.gz",
        sha256 = "44533bbbb3bb3c1fa17d9f2e4e38bbbaf8396ba82193c4cb1b6445d711445d36",
        strip_prefix = "env_logger-0.7.1",
        build_file = Label("//cargo/remote:env_logger-0.7.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__error_chain__0_12_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/error-chain/error-chain-0.12.1.crate",
        type = "tar.gz",
        sha256 = "3ab49e9dcb602294bc42f9a7dfc9bc6e936fca4418ea300dbfb84fe16de0b7d9",
        strip_prefix = "error-chain-0.12.1",
        build_file = Label("//cargo/remote:error-chain-0.12.1.BUILD.bazel")
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
        name = "raze__generic_array__0_12_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/generic-array/generic-array-0.12.0.crate",
        type = "tar.gz",
        sha256 = "3c0f28c2f5bfb5960175af447a2da7c18900693738343dc896ffbcabd9839592",
        strip_prefix = "generic-array-0.12.0",
        build_file = Label("//cargo/remote:generic-array-0.12.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__hermit_abi__0_1_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/hermit-abi/hermit-abi-0.1.6.crate",
        type = "tar.gz",
        sha256 = "eff2656d88f158ce120947499e971d743c05dbcbed62e5bd2f38f1698bbc3772",
        strip_prefix = "hermit-abi-0.1.6",
        build_file = Label("//cargo/remote:hermit-abi-0.1.6.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__humantime__1_3_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/humantime/humantime-1.3.0.crate",
        type = "tar.gz",
        sha256 = "df004cfca50ef23c36850aaaa59ad52cc70d0e90243c3c7737a4dd32dc7a3c4f",
        strip_prefix = "humantime-1.3.0",
        build_file = Label("//cargo/remote:humantime-1.3.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__inflections__1_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/inflections/inflections-1.1.1.crate",
        type = "tar.gz",
        sha256 = "a257582fdcde896fd96463bf2d40eefea0580021c0712a0e2b028b60b47a837a",
        strip_prefix = "inflections-1.1.1",
        build_file = Label("//cargo/remote:inflections-1.1.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__lazy_static__1_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/lazy_static/lazy_static-1.4.0.crate",
        type = "tar.gz",
        sha256 = "e2abad23fbc42b3700f2f279844dc832adb2b2eb069b2df918f455c4e18cc646",
        strip_prefix = "lazy_static-1.4.0",
        build_file = Label("//cargo/remote:lazy_static-1.4.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__libc__0_2_54",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libc/libc-0.2.54.crate",
        type = "tar.gz",
        sha256 = "c6785aa7dd976f5fbf3b71cfd9cd49d7f783c1ff565a858d71031c6c313aa5c6",
        strip_prefix = "libc-0.2.54",
        build_file = Label("//cargo/remote:libc-0.2.54.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__libm__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libm/libm-0.1.2.crate",
        type = "tar.gz",
        sha256 = "03c0bb6d5ce1b5cc6fd0578ec1cbc18c9d88b5b591a5c7c1d6c6175e266a0819",
        strip_prefix = "libm-0.1.2",
        build_file = Label("//cargo/remote:libm-0.1.2.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__log__0_4_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/log/log-0.4.8.crate",
        type = "tar.gz",
        sha256 = "14b6052be84e6b71ab17edffc2eeabf5c2c3ae1fdb464aae35ac50c67a44e1f7",
        strip_prefix = "log-0.4.8",
        build_file = Label("//cargo/remote:log-0.4.8.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__matrixmultiply__0_2_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/matrixmultiply/matrixmultiply-0.2.2.crate",
        type = "tar.gz",
        sha256 = "dcfed72d871629daa12b25af198f110e8095d7650f5f4c61c5bac28364604f9b",
        strip_prefix = "matrixmultiply-0.2.2",
        build_file = Label("//cargo/remote:matrixmultiply-0.2.2.BUILD.bazel")
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
        name = "raze__memchr__2_3_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/memchr/memchr-2.3.0.crate",
        type = "tar.gz",
        sha256 = "3197e20c7edb283f87c071ddfc7a2cca8f8e0b888c242959846a6fce03c72223",
        strip_prefix = "memchr-2.3.0",
        build_file = Label("//cargo/remote:memchr-2.3.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__nalgebra__0_18_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/nalgebra/nalgebra-0.18.0.crate",
        type = "tar.gz",
        sha256 = "8e12856109b5cb8e2934b5e45e4624839416e1c6c1f7d286711a7a66b79db29d",
        strip_prefix = "nalgebra-0.18.0",
        build_file = Label("//cargo/remote:nalgebra-0.18.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__num_complex__0_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-complex/num-complex-0.2.1.crate",
        type = "tar.gz",
        sha256 = "107b9be86cd2481930688277b675b0114578227f034674726605b8a482d8baf8",
        strip_prefix = "num-complex-0.2.1",
        build_file = Label("//cargo/remote:num-complex-0.2.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__num_traits__0_2_6",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-traits/num-traits-0.2.6.crate",
        type = "tar.gz",
        sha256 = "0b3a5d7cc97d6d30d8b9bc8fa19bf45349ffe46241e8816f50f62f6d6aaabee1",
        strip_prefix = "num-traits-0.2.6",
        build_file = Label("//cargo/remote:num-traits-0.2.6.BUILD.bazel")
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
        name = "raze__quick_error__1_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/quick-error/quick-error-1.2.3.crate",
        type = "tar.gz",
        sha256 = "a1d01941d82fa2ab50be1e79e6714289dd7cde78eba4c074bc5a4374f650dfe0",
        strip_prefix = "quick-error-1.2.3",
        build_file = Label("//cargo/remote:quick-error-1.2.3.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__quote__1_0_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/quote/quote-1.0.2.crate",
        type = "tar.gz",
        sha256 = "053a8c8bcc71fcce321828dc897a98ab9760bef03a4fc36693c231e5b3216cfe",
        strip_prefix = "quote-1.0.2",
        build_file = Label("//cargo/remote:quote-1.0.2.BUILD.bazel")
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
        name = "raze__rand_core__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_core/rand_core-0.4.0.crate",
        type = "tar.gz",
        sha256 = "d0e7a549d590831370895ab7ba4ea0c1b6b011d106b5ff2da6eee112615e6dc0",
        strip_prefix = "rand_core-0.4.0",
        build_file = Label("//cargo/remote:rand_core-0.4.0.BUILD.bazel")
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
        name = "raze__rawpointer__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rawpointer/rawpointer-0.1.0.crate",
        type = "tar.gz",
        sha256 = "ebac11a9d2e11f2af219b8b8d833b76b1ea0e054aa0e8d8e9e4cbde353bdf019",
        strip_prefix = "rawpointer-0.1.0",
        build_file = Label("//cargo/remote:rawpointer-0.1.0.BUILD.bazel")
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
        name = "raze__regex__1_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/regex/regex-1.3.3.crate",
        type = "tar.gz",
        sha256 = "b5508c1941e4e7cb19965abef075d35a9a8b5cdf0846f30b4050e9b55dc55e87",
        strip_prefix = "regex-1.3.3",
        build_file = Label("//cargo/remote:regex-1.3.3.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__regex_syntax__0_6_13",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/regex-syntax/regex-syntax-0.6.13.crate",
        type = "tar.gz",
        sha256 = "e734e891f5b408a29efbf8309e656876276f49ab6a6ac208600b4419bd893d90",
        strip_prefix = "regex-syntax-0.6.13",
        build_file = Label("//cargo/remote:regex-syntax-0.6.13.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rustc_demangle__0_1_16",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rustc-demangle/rustc-demangle-0.1.16.crate",
        type = "tar.gz",
        sha256 = "4c691c0e608126e00913e33f0ccf3727d5fc84573623b8d65b2df340b5201783",
        strip_prefix = "rustc-demangle-0.1.16",
        build_file = Label("//cargo/remote:rustc-demangle-0.1.16.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__rustc_version__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rustc_version/rustc_version-0.2.3.crate",
        type = "tar.gz",
        sha256 = "138e3e0acb6c9fb258b19b67cb8abd63c00679d2851805ea151465464fe9030a",
        strip_prefix = "rustc_version-0.2.3",
        build_file = Label("//cargo/remote:rustc_version-0.2.3.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__semver__0_9_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/semver/semver-0.9.0.crate",
        type = "tar.gz",
        sha256 = "1d7eb9ef2c18661902cc47e535f9bc51b78acd254da71d375c2f6720d9a40403",
        strip_prefix = "semver-0.9.0",
        build_file = Label("//cargo/remote:semver-0.9.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__semver_parser__0_7_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/semver-parser/semver-parser-0.7.0.crate",
        type = "tar.gz",
        sha256 = "388a1df253eca08550bef6c72392cfe7c30914bf41df5269b68cbd6ff8f570a3",
        strip_prefix = "semver-parser-0.7.0",
        build_file = Label("//cargo/remote:semver-parser-0.7.0.BUILD.bazel")
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
        name = "raze__strsim__0_8_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/strsim/strsim-0.8.0.crate",
        type = "tar.gz",
        sha256 = "8ea5119cdb4c55b55d432abb513a0429384878c15dde60cc77b1c99de1a95a6a",
        strip_prefix = "strsim-0.8.0",
        build_file = Label("//cargo/remote:strsim-0.8.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__svd_parser__0_9_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/svd-parser/svd-parser-0.9.0.crate",
        type = "tar.gz",
        sha256 = "b4166295f1efb24fd50c42adc9728f58a30521410c7976bdd3239a33c76f1be2",
        strip_prefix = "svd-parser-0.9.0",
        build_file = Label("//cargo/remote:svd-parser-0.9.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__svd2rust__0_17_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/svd2rust/svd2rust-0.17.0.crate",
        type = "tar.gz",
        sha256 = "a9c9d66a8f1a494b5289c951bfc17fa9bffc78d2a4eab615cdf5162592bda020",
        strip_prefix = "svd2rust-0.17.0",
        build_file = Label("//cargo/remote:svd2rust-0.17.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__syn__1_0_14",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/syn/syn-1.0.14.crate",
        type = "tar.gz",
        sha256 = "af6f3550d8dff9ef7dc34d384ac6f107e5d31c8f57d9f28e0081503f547ac8f5",
        strip_prefix = "syn-1.0.14",
        build_file = Label("//cargo/remote:syn-1.0.14.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__termcolor__1_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/termcolor/termcolor-1.1.0.crate",
        type = "tar.gz",
        sha256 = "bb6bfa289a4d7c5766392812c0a1f4c1ba45afa1ad47803c11e1f407d846d75f",
        strip_prefix = "termcolor-1.1.0",
        build_file = Label("//cargo/remote:termcolor-1.1.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__textwrap__0_11_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/textwrap/textwrap-0.11.0.crate",
        type = "tar.gz",
        sha256 = "d326610f408c7a4eb6f51c37c330e496b08506c9457c9d34287ecc38809fb060",
        strip_prefix = "textwrap-0.11.0",
        build_file = Label("//cargo/remote:textwrap-0.11.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__thiserror__1_0_9",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/thiserror/thiserror-1.0.9.crate",
        type = "tar.gz",
        sha256 = "6f357d1814b33bc2dc221243f8424104bfe72dbe911d5b71b3816a2dff1c977e",
        strip_prefix = "thiserror-1.0.9",
        build_file = Label("//cargo/remote:thiserror-1.0.9.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__thiserror_impl__1_0_9",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/thiserror-impl/thiserror-impl-1.0.9.crate",
        type = "tar.gz",
        sha256 = "eb2e25d25307eb8436894f727aba8f65d07adf02e5b35a13cebed48bd282bfef",
        strip_prefix = "thiserror-impl-1.0.9",
        build_file = Label("//cargo/remote:thiserror-impl-1.0.9.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__thread_local__1_0_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/thread_local/thread_local-1.0.1.crate",
        type = "tar.gz",
        sha256 = "d40c6d1b69745a6ec6fb1ca717914848da4b44ae29d9b3080cbee91d72a69b14",
        strip_prefix = "thread_local-1.0.1",
        build_file = Label("//cargo/remote:thread_local-1.0.1.BUILD.bazel")
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
        name = "raze__unicode_width__0_1_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/unicode-width/unicode-width-0.1.7.crate",
        type = "tar.gz",
        sha256 = "caaa9d531767d1ff2150b9332433f32a24622147e5ebb1f26409d5da67afd479",
        strip_prefix = "unicode-width-0.1.7",
        build_file = Label("//cargo/remote:unicode-width-0.1.7.BUILD.bazel")
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
        name = "raze__vec_map__0_8_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/vec_map/vec_map-0.8.1.crate",
        type = "tar.gz",
        sha256 = "05c78687fb1a80548ae3250346c3db86a80a7cdd77bda190189f2d0a0987c81a",
        strip_prefix = "vec_map-0.8.1",
        build_file = Label("//cargo/remote:vec_map-0.8.1.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__version_check__0_1_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/version_check/version_check-0.1.5.crate",
        type = "tar.gz",
        sha256 = "914b1a6776c4c929a602fafd8bc742e06365d4bcbe48c30f9cca5824f70dc9dd",
        strip_prefix = "version_check-0.1.5",
        build_file = Label("//cargo/remote:version_check-0.1.5.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__winapi__0_3_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi/winapi-0.3.7.crate",
        type = "tar.gz",
        sha256 = "f10e386af2b13e47c89e7236a7a14a086791a2b88ebad6df9bf42040195cf770",
        strip_prefix = "winapi-0.3.7",
        build_file = Label("//cargo/remote:winapi-0.3.7.BUILD.bazel")
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
        name = "raze__winapi_util__0_1_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-util/winapi-util-0.1.3.crate",
        type = "tar.gz",
        sha256 = "4ccfbf554c6ad11084fb7517daca16cfdcaccbdadba4fc336f032a8b12c2ad80",
        strip_prefix = "winapi-util-0.1.3",
        build_file = Label("//cargo/remote:winapi-util-0.1.3.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__winapi_x86_64_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-x86_64-pc-windows-gnu/winapi-x86_64-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        sha256 = "712e227841d057c1ee1cd2fb22fa7e5a5461ae8e48fa2ca79ec42cfc1931183f",
        strip_prefix = "winapi-x86_64-pc-windows-gnu-0.4.0",
        build_file = Label("//cargo/remote:winapi-x86_64-pc-windows-gnu-0.4.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__xml_rs__0_7_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/xml-rs/xml-rs-0.7.0.crate",
        type = "tar.gz",
        sha256 = "3c1cb601d29fe2c2ac60a2b2e5e293994d87a1f6fa9687a31a15270f909be9c2",
        strip_prefix = "xml-rs-0.7.0",
        build_file = Label("//cargo/remote:xml-rs-0.7.0.BUILD.bazel")
    )

    _new_http_archive(
        name = "raze__xmltree__0_8_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/xmltree/xmltree-0.8.0.crate",
        type = "tar.gz",
        sha256 = "ff8eaee9d17062850f1e6163b509947969242990ee59a35801af437abe041e70",
        strip_prefix = "xmltree-0.8.0",
        build_file = Label("//cargo/remote:xmltree-0.8.0.BUILD.bazel")
    )

