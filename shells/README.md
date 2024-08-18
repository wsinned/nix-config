# Base shell files for dev shells

## Updates

These shells have pinned nixpkgs, to guarantee deterministic versions. Last updated: 16/8/24.
To update to a later version from the stable channel, look up latest commit from the current stable release branch, e.g. [Branch release-24.05](https://github.com/NixOS/nixpkgs/tree/release-24.05)

## Usage

Copy the file corresponding to the project dev language to your project directory and rename it to `shell.nix`.
Add any additional dependencies needed.

Currently supported Languages are:

- Rust: [rust.nix](rust.nix)
- Python: [python.nix](python.nix)
