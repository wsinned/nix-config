# nix-config

NixOS 26.05 configuration for `dw-apollo` and `dw-dell-01`, using Niri on
Wayland and Home Manager for the shared user environment.

## Hosts and modules

Both hosts import the shared core, Niri desktop, development tools and
`wsinned` Home Manager profile. Hardware configuration, bootloader settings,
hostname and state version remain explicit in each host.

`dw-apollo` additionally imports:

- gaming support;
- Intel graphics, VA-API and laptop power policy from its platform module;
- `take-note` and `autonumlock` from flake inputs.

## Dotfiles

Application configuration remains in the separate
[`tech-notes`](https://github.com/wsinned/tech-notes) repository. Home Manager
creates out-of-store symlinks to that checkout, so the files:

- remain editable;
- are not duplicated in this repository or the Nix store;
- can be shared by NixOS and non-NixOS machines;
- can have a lifecycle independent from the operating-system configuration.

Clone both repositories at their standard locations before activating:

```bash
git clone https://github.com/wsinned/nix-config ~/nix-config
git clone https://github.com/wsinned/tech-notes ~/tech-notes
```

The shared desktop configuration currently links Niri, Waybar, Mako, Foot,
swaylock, Vicinae, Wallust, Yazi, Neovim and the common scripts directory.
Machine-specific behaviour remains in the NixOS host module or a hostname-based
dotfile fragment. Niri selects monitor configuration from
`.config/niri/outputs/<hostname>.kdl`, keeping Apollo and Dell output settings
separate while the rest of the desktop configuration stays shared.

## Install

During a fresh installation, replace the target host's committed hardware
profile with the profile generated for the actual disk layout. For example, for
`dw-dell-01`:

```bash
sudo nixos-generate-config --root /mnt
cp /mnt/etc/nixos/hardware-configuration.nix \
  ~/nix-config/hosts/dw-dell-01/hardware-configuration.nix
```

Then install the selected host:

```bash
sudo nixos-install --flake ~/nix-config#dw-dell-01
```

Use `#dw-apollo` instead when installing Apollo.

After the first boot, join the machine to the tailnet interactively:

```bash
sudo tailscale up
```

The configuration deliberately does not commit a reusable Tailscale auth key.
For unattended provisioning, supply an ephemeral or pre-authorised key at
deployment time through a secrets mechanism rather than the Nix store.

## Test changes

```bash
nix flake check --no-build
sudo nixos-rebuild dry-build --flake .#dw-apollo
sudo nixos-rebuild test --flake .#dw-apollo
sudo nixos-rebuild switch --flake .#dw-apollo
```

Replace `dw-apollo` with `dw-dell-01` to target Dell.

Update pinned inputs deliberately:

```bash
nix flake update
nix flake check --no-build
```

## Nix Architecture

The existing diagram documents the Dell configuration path:

![dw-dell-01 configuration diagram](./dw-dell-01-configuration-diagram.png)
