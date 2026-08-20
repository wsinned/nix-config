# modules/desktop/noctalia.nix
{ inputs, ... }:

{
  home-manager.users.wsinned = {
    imports = [
      inputs.noctalia.homeModules.default
    ];

    programs.noctalia = {
      enable = true;
      systemd.enable = true;
    };
  };
}
