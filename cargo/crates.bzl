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
        name = "raze__aho_corasick__0_7_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/aho-corasick/aho-corasick-0.7.8.crate",
        type = "tar.gz",
        strip_prefix = "aho-corasick-0.7.8",

        build_file = Label("//cargo/remote:aho-corasick-0.7.8.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__alga__0_9_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/alga/alga-0.9.2.crate",
        type = "tar.gz",
        strip_prefix = "alga-0.9.2",

        build_file = Label("//cargo/remote:alga-0.9.2.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__aligned__0_3_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/aligned/aligned-0.3.2.crate",
        type = "tar.gz",
        strip_prefix = "aligned-0.3.2",

        build_file = Label("//cargo/remote:aligned-0.3.2.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__ansi_term__0_11_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/ansi_term/ansi_term-0.11.0.crate",
        type = "tar.gz",
        strip_prefix = "ansi_term-0.11.0",

        build_file = Label("//cargo/remote:ansi_term-0.11.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__anyhow__1_0_26",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/anyhow/anyhow-1.0.26.crate",
        type = "tar.gz",
        strip_prefix = "anyhow-1.0.26",

        build_file = Label("//cargo/remote:anyhow-1.0.26.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__approx__0_3_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/approx/approx-0.3.2.crate",
        type = "tar.gz",
        strip_prefix = "approx-0.3.2",

        build_file = Label("//cargo/remote:approx-0.3.2.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__as_slice__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/as-slice/as-slice-0.1.0.crate",
        type = "tar.gz",
        strip_prefix = "as-slice-0.1.0",

        build_file = Label("//cargo/remote:as-slice-0.1.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__atty__0_2_14",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/atty/atty-0.2.14.crate",
        type = "tar.gz",
        strip_prefix = "atty-0.2.14",

        build_file = Label("//cargo/remote:atty-0.2.14.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__autocfg__0_1_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/autocfg/autocfg-0.1.7.crate",
        type = "tar.gz",
        strip_prefix = "autocfg-0.1.7",

        build_file = Label("//cargo/remote:autocfg-0.1.7.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__autocfg__1_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/autocfg/autocfg-1.0.0.crate",
        type = "tar.gz",
        strip_prefix = "autocfg-1.0.0",

        build_file = Label("//cargo/remote:autocfg-1.0.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__backtrace__0_3_44",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/backtrace/backtrace-0.3.44.crate",
        type = "tar.gz",
        strip_prefix = "backtrace-0.3.44",

        build_file = Label("//cargo/remote:backtrace-0.3.44.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__backtrace_sys__0_1_32",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/backtrace-sys/backtrace-sys-0.1.32.crate",
        type = "tar.gz",
        strip_prefix = "backtrace-sys-0.1.32",

        build_file = Label("//cargo/remote:backtrace-sys-0.1.32.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__bare_metal__0_2_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bare-metal/bare-metal-0.2.5.crate",
        type = "tar.gz",
        strip_prefix = "bare-metal-0.2.5",

        build_file = Label("//cargo/remote:bare-metal-0.2.5.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__bitflags__1_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/bitflags/bitflags-1.2.1.crate",
        type = "tar.gz",
        strip_prefix = "bitflags-1.2.1",

        build_file = Label("//cargo/remote:bitflags-1.2.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__cast__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cast/cast-0.2.3.crate",
        type = "tar.gz",
        strip_prefix = "cast-0.2.3",

        build_file = Label("//cargo/remote:cast-0.2.3.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__cc__1_0_50",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cc/cc-1.0.50.crate",
        type = "tar.gz",
        strip_prefix = "cc-1.0.50",

        build_file = Label("//cargo/remote:cc-1.0.50.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__cfg_if__0_1_10",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cfg-if/cfg-if-0.1.10.crate",
        type = "tar.gz",
        strip_prefix = "cfg-if-0.1.10",

        build_file = Label("//cargo/remote:cfg-if-0.1.10.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__clap__2_33_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/clap/clap-2.33.0.crate",
        type = "tar.gz",
        strip_prefix = "clap-2.33.0",

        build_file = Label("//cargo/remote:clap-2.33.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__cloudabi__0_0_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cloudabi/cloudabi-0.0.3.crate",
        type = "tar.gz",
        strip_prefix = "cloudabi-0.0.3",

        build_file = Label("//cargo/remote:cloudabi-0.0.3.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__cortex_m__0_6_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/cortex-m/cortex-m-0.6.2.crate",
        type = "tar.gz",
        strip_prefix = "cortex-m-0.6.2",

        build_file = Label("//cargo/remote:cortex-m-0.6.2.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__either__1_5_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/either/either-1.5.3.crate",
        type = "tar.gz",
        strip_prefix = "either-1.5.3",

        build_file = Label("//cargo/remote:either-1.5.3.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__env_logger__0_7_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/env_logger/env_logger-0.7.1.crate",
        type = "tar.gz",
        strip_prefix = "env_logger-0.7.1",

        build_file = Label("//cargo/remote:env_logger-0.7.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__error_chain__0_12_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/error-chain/error-chain-0.12.2.crate",
        type = "tar.gz",
        strip_prefix = "error-chain-0.12.2",

        build_file = Label("//cargo/remote:error-chain-0.12.2.BUILD.bazel"),
    )

    _new_git_repository(
        name = "raze__fixedvec__0_2_3",
        remote = "https://github.com/m3rcuriel/fixedvec-rs",
        commit = "c111bd0b1adc5e0cb3858e9aa94dbfdae74906c3",
        build_file = Label("//cargo/remote:fixedvec-0.2.3.BUILD.bazel"),
        init_submodules = True,
)

    _new_git_repository(
        name = "raze__flatbuffers__0_6_0",
        remote = "https://github.com/m3rcuriel/flatbuffers",
        commit = "8e0f36371ee14352524daa66979470635555b640",
        build_file = Label("//cargo/remote:flatbuffers-0.6.0.BUILD.bazel"),
        init_submodules = True,
)

    _new_http_archive(
        name = "raze__fuchsia_cprng__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/fuchsia-cprng/fuchsia-cprng-0.1.1.crate",
        type = "tar.gz",
        strip_prefix = "fuchsia-cprng-0.1.1",

        build_file = Label("//cargo/remote:fuchsia-cprng-0.1.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__generic_array__0_12_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/generic-array/generic-array-0.12.3.crate",
        type = "tar.gz",
        strip_prefix = "generic-array-0.12.3",

        build_file = Label("//cargo/remote:generic-array-0.12.3.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__hermit_abi__0_1_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/hermit-abi/hermit-abi-0.1.8.crate",
        type = "tar.gz",
        strip_prefix = "hermit-abi-0.1.8",

        build_file = Label("//cargo/remote:hermit-abi-0.1.8.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__humantime__1_3_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/humantime/humantime-1.3.0.crate",
        type = "tar.gz",
        strip_prefix = "humantime-1.3.0",

        build_file = Label("//cargo/remote:humantime-1.3.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__inflections__1_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/inflections/inflections-1.1.1.crate",
        type = "tar.gz",
        strip_prefix = "inflections-1.1.1",

        build_file = Label("//cargo/remote:inflections-1.1.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__lazy_static__1_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/lazy_static/lazy_static-1.4.0.crate",
        type = "tar.gz",
        strip_prefix = "lazy_static-1.4.0",

        build_file = Label("//cargo/remote:lazy_static-1.4.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__libc__0_2_67",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libc/libc-0.2.67.crate",
        type = "tar.gz",
        strip_prefix = "libc-0.2.67",

        build_file = Label("//cargo/remote:libc-0.2.67.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__libm__0_1_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/libm/libm-0.1.4.crate",
        type = "tar.gz",
        strip_prefix = "libm-0.1.4",

        build_file = Label("//cargo/remote:libm-0.1.4.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__log__0_4_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/log/log-0.4.8.crate",
        type = "tar.gz",
        strip_prefix = "log-0.4.8",

        build_file = Label("//cargo/remote:log-0.4.8.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__matrixmultiply__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/matrixmultiply/matrixmultiply-0.2.3.crate",
        type = "tar.gz",
        strip_prefix = "matrixmultiply-0.2.3",

        build_file = Label("//cargo/remote:matrixmultiply-0.2.3.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__maybe_uninit__2_0_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/maybe-uninit/maybe-uninit-2.0.0.crate",
        type = "tar.gz",
        strip_prefix = "maybe-uninit-2.0.0",

        build_file = Label("//cargo/remote:maybe-uninit-2.0.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__memchr__2_3_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/memchr/memchr-2.3.3.crate",
        type = "tar.gz",
        strip_prefix = "memchr-2.3.3",

        build_file = Label("//cargo/remote:memchr-2.3.3.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__nalgebra__0_18_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/nalgebra/nalgebra-0.18.1.crate",
        type = "tar.gz",
        strip_prefix = "nalgebra-0.18.1",

        build_file = Label("//cargo/remote:nalgebra-0.18.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__num_complex__0_2_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-complex/num-complex-0.2.4.crate",
        type = "tar.gz",
        strip_prefix = "num-complex-0.2.4",

        build_file = Label("//cargo/remote:num-complex-0.2.4.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__num_integer__0_1_42",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-integer/num-integer-0.1.42.crate",
        type = "tar.gz",
        strip_prefix = "num-integer-0.1.42",

        build_file = Label("//cargo/remote:num-integer-0.1.42.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__num_rational__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-rational/num-rational-0.2.3.crate",
        type = "tar.gz",
        strip_prefix = "num-rational-0.2.3",

        build_file = Label("//cargo/remote:num-rational-0.2.3.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__num_traits__0_2_11",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/num-traits/num-traits-0.2.11.crate",
        type = "tar.gz",
        strip_prefix = "num-traits-0.2.11",

        build_file = Label("//cargo/remote:num-traits-0.2.11.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__proc_macro2__1_0_9",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/proc-macro2/proc-macro2-1.0.9.crate",
        type = "tar.gz",
        strip_prefix = "proc-macro2-1.0.9",

        build_file = Label("//cargo/remote:proc-macro2-1.0.9.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__quick_error__1_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/quick-error/quick-error-1.2.3.crate",
        type = "tar.gz",
        strip_prefix = "quick-error-1.2.3",

        build_file = Label("//cargo/remote:quick-error-1.2.3.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__quote__1_0_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/quote/quote-1.0.2.crate",
        type = "tar.gz",
        strip_prefix = "quote-1.0.2",

        build_file = Label("//cargo/remote:quote-1.0.2.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rand__0_6_5",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand/rand-0.6.5.crate",
        type = "tar.gz",
        strip_prefix = "rand-0.6.5",

        build_file = Label("//cargo/remote:rand-0.6.5.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rand_chacha__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_chacha/rand_chacha-0.1.1.crate",
        type = "tar.gz",
        strip_prefix = "rand_chacha-0.1.1",

        build_file = Label("//cargo/remote:rand_chacha-0.1.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rand_core__0_3_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_core/rand_core-0.3.1.crate",
        type = "tar.gz",
        strip_prefix = "rand_core-0.3.1",

        build_file = Label("//cargo/remote:rand_core-0.3.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rand_core__0_4_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_core/rand_core-0.4.2.crate",
        type = "tar.gz",
        strip_prefix = "rand_core-0.4.2",

        build_file = Label("//cargo/remote:rand_core-0.4.2.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rand_hc__0_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_hc/rand_hc-0.1.0.crate",
        type = "tar.gz",
        strip_prefix = "rand_hc-0.1.0",

        build_file = Label("//cargo/remote:rand_hc-0.1.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rand_isaac__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_isaac/rand_isaac-0.1.1.crate",
        type = "tar.gz",
        strip_prefix = "rand_isaac-0.1.1",

        build_file = Label("//cargo/remote:rand_isaac-0.1.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rand_jitter__0_1_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_jitter/rand_jitter-0.1.4.crate",
        type = "tar.gz",
        strip_prefix = "rand_jitter-0.1.4",

        build_file = Label("//cargo/remote:rand_jitter-0.1.4.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rand_os__0_1_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_os/rand_os-0.1.3.crate",
        type = "tar.gz",
        strip_prefix = "rand_os-0.1.3",

        build_file = Label("//cargo/remote:rand_os-0.1.3.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rand_pcg__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_pcg/rand_pcg-0.1.2.crate",
        type = "tar.gz",
        strip_prefix = "rand_pcg-0.1.2",

        build_file = Label("//cargo/remote:rand_pcg-0.1.2.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rand_xorshift__0_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rand_xorshift/rand_xorshift-0.1.1.crate",
        type = "tar.gz",
        strip_prefix = "rand_xorshift-0.1.1",

        build_file = Label("//cargo/remote:rand_xorshift-0.1.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rawpointer__0_2_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rawpointer/rawpointer-0.2.1.crate",
        type = "tar.gz",
        strip_prefix = "rawpointer-0.2.1",

        build_file = Label("//cargo/remote:rawpointer-0.2.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rdrand__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rdrand/rdrand-0.4.0.crate",
        type = "tar.gz",
        strip_prefix = "rdrand-0.4.0",

        build_file = Label("//cargo/remote:rdrand-0.4.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__regex__1_3_4",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/regex/regex-1.3.4.crate",
        type = "tar.gz",
        strip_prefix = "regex-1.3.4",

        build_file = Label("//cargo/remote:regex-1.3.4.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__regex_syntax__0_6_14",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/regex-syntax/regex-syntax-0.6.14.crate",
        type = "tar.gz",
        strip_prefix = "regex-syntax-0.6.14",

        build_file = Label("//cargo/remote:regex-syntax-0.6.14.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rustc_demangle__0_1_16",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rustc-demangle/rustc-demangle-0.1.16.crate",
        type = "tar.gz",
        strip_prefix = "rustc-demangle-0.1.16",

        build_file = Label("//cargo/remote:rustc-demangle-0.1.16.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__rustc_version__0_2_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/rustc_version/rustc_version-0.2.3.crate",
        type = "tar.gz",
        strip_prefix = "rustc_version-0.2.3",

        build_file = Label("//cargo/remote:rustc_version-0.2.3.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__semver__0_9_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/semver/semver-0.9.0.crate",
        type = "tar.gz",
        strip_prefix = "semver-0.9.0",

        build_file = Label("//cargo/remote:semver-0.9.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__semver_parser__0_7_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/semver-parser/semver-parser-0.7.0.crate",
        type = "tar.gz",
        strip_prefix = "semver-parser-0.7.0",

        build_file = Label("//cargo/remote:semver-parser-0.7.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__smallvec__0_6_13",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/smallvec/smallvec-0.6.13.crate",
        type = "tar.gz",
        strip_prefix = "smallvec-0.6.13",

        build_file = Label("//cargo/remote:smallvec-0.6.13.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__stable_deref_trait__1_1_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/stable_deref_trait/stable_deref_trait-1.1.1.crate",
        type = "tar.gz",
        strip_prefix = "stable_deref_trait-1.1.1",

        build_file = Label("//cargo/remote:stable_deref_trait-1.1.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__strsim__0_8_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/strsim/strsim-0.8.0.crate",
        type = "tar.gz",
        strip_prefix = "strsim-0.8.0",

        build_file = Label("//cargo/remote:strsim-0.8.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__svd_parser__0_9_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/svd-parser/svd-parser-0.9.0.crate",
        type = "tar.gz",
        strip_prefix = "svd-parser-0.9.0",

        build_file = Label("//cargo/remote:svd-parser-0.9.0.BUILD.bazel"),
    )

    _new_git_repository(
        name = "raze__svd2rust__0_17_0",
        remote = "https://github.com/rust-embedded/svd2rust",
        commit = "67a0df0b49f504877ece6ed8091b49ebb8b724e6",
        build_file = Label("//cargo/remote:svd2rust-0.17.0.BUILD.bazel"),
        init_submodules = True,
)

    _new_http_archive(
        name = "raze__syn__1_0_16",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/syn/syn-1.0.16.crate",
        type = "tar.gz",
        strip_prefix = "syn-1.0.16",

        build_file = Label("//cargo/remote:syn-1.0.16.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__termcolor__1_1_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/termcolor/termcolor-1.1.0.crate",
        type = "tar.gz",
        strip_prefix = "termcolor-1.1.0",

        build_file = Label("//cargo/remote:termcolor-1.1.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__textwrap__0_11_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/textwrap/textwrap-0.11.0.crate",
        type = "tar.gz",
        strip_prefix = "textwrap-0.11.0",

        build_file = Label("//cargo/remote:textwrap-0.11.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__thiserror__1_0_11",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/thiserror/thiserror-1.0.11.crate",
        type = "tar.gz",
        strip_prefix = "thiserror-1.0.11",

        build_file = Label("//cargo/remote:thiserror-1.0.11.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__thiserror_impl__1_0_11",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/thiserror-impl/thiserror-impl-1.0.11.crate",
        type = "tar.gz",
        strip_prefix = "thiserror-impl-1.0.11",

        build_file = Label("//cargo/remote:thiserror-impl-1.0.11.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__thread_local__1_0_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/thread_local/thread_local-1.0.1.crate",
        type = "tar.gz",
        strip_prefix = "thread_local-1.0.1",

        build_file = Label("//cargo/remote:thread_local-1.0.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__typenum__1_10_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/typenum/typenum-1.10.0.crate",
        type = "tar.gz",
        strip_prefix = "typenum-1.10.0",

        build_file = Label("//cargo/remote:typenum-1.10.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__unicode_width__0_1_7",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/unicode-width/unicode-width-0.1.7.crate",
        type = "tar.gz",
        strip_prefix = "unicode-width-0.1.7",

        build_file = Label("//cargo/remote:unicode-width-0.1.7.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__unicode_xid__0_2_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/unicode-xid/unicode-xid-0.2.0.crate",
        type = "tar.gz",
        strip_prefix = "unicode-xid-0.2.0",

        build_file = Label("//cargo/remote:unicode-xid-0.2.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__vcell__0_1_2",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/vcell/vcell-0.1.2.crate",
        type = "tar.gz",
        strip_prefix = "vcell-0.1.2",

        build_file = Label("//cargo/remote:vcell-0.1.2.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__vec_map__0_8_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/vec_map/vec_map-0.8.1.crate",
        type = "tar.gz",
        strip_prefix = "vec_map-0.8.1",

        build_file = Label("//cargo/remote:vec_map-0.8.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__version_check__0_9_1",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/version_check/version_check-0.9.1.crate",
        type = "tar.gz",
        strip_prefix = "version_check-0.9.1",

        build_file = Label("//cargo/remote:version_check-0.9.1.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__volatile_register__0_2_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/volatile-register/volatile-register-0.2.0.crate",
        type = "tar.gz",
        strip_prefix = "volatile-register-0.2.0",

        build_file = Label("//cargo/remote:volatile-register-0.2.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__winapi__0_3_8",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi/winapi-0.3.8.crate",
        type = "tar.gz",
        strip_prefix = "winapi-0.3.8",

        build_file = Label("//cargo/remote:winapi-0.3.8.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__winapi_i686_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-i686-pc-windows-gnu/winapi-i686-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        strip_prefix = "winapi-i686-pc-windows-gnu-0.4.0",

        build_file = Label("//cargo/remote:winapi-i686-pc-windows-gnu-0.4.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__winapi_util__0_1_3",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-util/winapi-util-0.1.3.crate",
        type = "tar.gz",
        strip_prefix = "winapi-util-0.1.3",

        build_file = Label("//cargo/remote:winapi-util-0.1.3.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__winapi_x86_64_pc_windows_gnu__0_4_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/winapi-x86_64-pc-windows-gnu/winapi-x86_64-pc-windows-gnu-0.4.0.crate",
        type = "tar.gz",
        strip_prefix = "winapi-x86_64-pc-windows-gnu-0.4.0",

        build_file = Label("//cargo/remote:winapi-x86_64-pc-windows-gnu-0.4.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__xml_rs__0_7_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/xml-rs/xml-rs-0.7.0.crate",
        type = "tar.gz",
        strip_prefix = "xml-rs-0.7.0",

        build_file = Label("//cargo/remote:xml-rs-0.7.0.BUILD.bazel"),
    )

    _new_http_archive(
        name = "raze__xmltree__0_8_0",
        url = "https://crates-io.s3-us-west-1.amazonaws.com/crates/xmltree/xmltree-0.8.0.crate",
        type = "tar.gz",
        strip_prefix = "xmltree-0.8.0",

        build_file = Label("//cargo/remote:xmltree-0.8.0.BUILD.bazel"),
    )

