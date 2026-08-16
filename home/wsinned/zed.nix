{ pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
    ];

    extraPackages = with pkgs; [
      nixd
      nixfmt
    ];

    userSettings = {
      languages.Nix = {
        language_servers = [
          "nixd"
          "!nil"
        ];
        formatter = "language_server";
        format_on_save = "on";
      };

      lsp.nixd = {
        binary.path_lookup = true;
        settings.nixd.formatting.command = [ "nixfmt" ];
      };
    };
  };
}
