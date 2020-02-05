# Hyperion: Research utilities, production performance

<p align="center">
    <a href="https://buildkite.com/valkyrie-robotics/hyperion-project">
        <img src="https://badge.buildkite.com/a432c39e8c1b80512beda6660ea667eb0c44405e2e2a8c34b0.svg?branch=master"
             alt="build status (master)" />
    </a>
</p>

<p align="center"><i>"But as with so many things in our lives, the reason for doing something is not
the important thing. It is the fact of doing that remains."</i><p><p align="center">&mdash; Dan Simmons, <i>Hyperion</i> (1989)</p>

## Table of Contents
- [About Hyperion](#about-hyperion)
- [Building Hyperion](#about-hyperion)

## About Hyperion

Hyperion is a real-time general purpose robotics framework built in Rust.

## Building Hyperion
Currently Hyperion is only supported within a monolithic repository structure.
Eventually it may support being included in other repositories, but for the
moment any project build with Hyperion must be a subfolder of a cloned version
of Hyperion, i.e

```
+ hyperion
  + execution/
  + math/
  + your_project/
  ...
```

Hyperion can be built on most modern Linux platforms. Currently only two
platforms are supported through Bazel:

+ `//tools/platforms:bionic-linux-x86_64`
+ `//tools/platforms:disco-linux-x86_64`

These can be switched between via Bazel flags `--host_platform=` and
`--target_platforms=`. The differentiating feature between these two platforms
as far as I can tell currently is whether or not Clang is built against
`libtinfo6` or `libtinfo5`. For example, the Ubuntu Disco toolchain works on
Arch Linux kernel version 5.0.8.

All unit tests in the project can be tested via `bazel test //...`.
