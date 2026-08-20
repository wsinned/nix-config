{ lib, pkgs, ... }:

{
  programs.zed-editor = {
    enable = true;

    extensions = [
      "nix"
      "rust"
      "toml"
    ];

    extraPackages = with pkgs; [
      nixd
      nixfmt
      rust-analyzer
      rustc
      cargo
    ];

    userSettings = {
      vim_mode = true;
      relative_line_numbers = "enabled";
      load_direnv = "shell_hook";

      terminal = {
        shell = {
          program = "/run/current-system/sw/bin/fish";
        };
      };

      languages.Nix = {
        language_servers = [
          "nixd"
          "!nil"
        ];
        formatter = "language_server";
        format_on_save = "on";
      };

      lsp = {
        rust-analyzer = {
          binary = {
            path = lib.getExe pkgs.rust-analyzer;
          };
        };

        nix = {
          binary = {
            path_lookup = true;
          };
        };

        nixd = {
          binary.path_lookup = true;
          settings.nixd.formatting.command = [ "nixfmt" ];
        };

      };
    };
  };
}
