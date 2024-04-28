{ inputs, pkgs, config, ... }:

{
  home.packages = [
    pkgs.unstable.protontricks
  ];

  # …
}
