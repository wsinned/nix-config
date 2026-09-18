{ ... }:

{
  services.syncthing = {
    enable = true;
    user = "wsinned";
    group = "users";
    dataDir = "/home/wsinned";
    configDir = "/home/wsinned/.config/syncthing";
    guiAddress = "127.0.0.1:8384";
    openDefaultPorts = true;

    # Keep device IDs, folders and secrets outside the Nix store for now.
    overrideDevices = false;
    overrideFolders = false;
  };
}
