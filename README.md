# Vex Swift

This repository is an experiment with using Swift to develop on the VEX V5 platform.

## Environment setup

Install Swiftly, then run `swiftly install` in this directory. Swiftly will automatically pick up the `.swift-version` and use the right compiler in this directory.

Install swift-v5 from the vexide GitHub, then run `swift v5 install` in this directory. This will install the ARM Toolchain for Embedded. Once the download finishes, swift-v5 will tell you where it installed the toolchain. Symlink that directory to `./llvm-toolchain`.

The path will be different on different operating systems, but here is what it looks like on macOS:

```shell
ln -s "$HOME/Library/Application Support/dev.vexide.swift-v5/llvm-toolchains/20.1.0" llvm-toolchain
```

## Build command

```shell
swift build -c release --triple armv7-none-none-eabi --toolset toolset.json
```

The ELF output is located at: `./.build/release/VexSwiftApp`.

## Big one-liner that does all the things™

```shell
swift build -c release --triple armv7-none-none-eabi --toolset toolset.json && llvm-objcopy -O binary ./.build/release/VexSwiftApp ./.build/release/VexSwiftApp.bin && cargo v5 run --file=./.build/release/VexSwiftApp.bin --slot=1
```