# nix-config

Repo for Nix Flakes based configuration of NixOS (and possibly standalone Nix later on).

## Getting started

Grab the latest NixOS installer for your preferred desktop environment, e.g. Gnome https://channels.nixos.org/nixos-23.11/latest-nixos-gnome-x86_64-linux.iso
- Note: I had trouble getting past Stage 1 of the boot on this installer with my old Dell E6230, and ended up using a slightly older build of the installer.

Install the OS as usual. There aren't too many options apart from region and disk partitioning. I choose to encrypt my disk.

Once booted into the fresh OS, open Console and do the following `sudo nano /etc/nixos/configuration.nix`

Add the following directly after the "imports" section:

```bash
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
```

Save and exit nano, then activate the changes with:

```bash
  sudo nixos-rebuild switch
```

Now that flakes are enabled, we can install a temporary copy of Git and clone the repo with the config.

```bash
  nix shell nixpkgs#git
```

Nix will download Git and dependencies and then open a new shell session with it avaiable/

```bash
  git clone https://github.com/wsinned/nix-config
```

This will clone the config repo into your home folder. 
If this is a reinstall of an existing machine, check the details in hosts. 
You may need to update hardware-configuration.nix for any new disk identifiers.

## Background

This configuration was inspired by [Nix Starter Config](https://github.com/Misterio77/nix-starter-configs) and [Misterio77's personal config](https://github.com/misterio77/nix-config)

