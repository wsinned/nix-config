{ pkgs, ... }:

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
    ];

    userSettings = {
      vim_mode = true;
      relative_line_numbers = "enabled";

      languages.Nix = {
        language_servers = [
          "nixd"
          "!nil"
          "rust"
        ];
        formatter = "language_server";
        format_on_save = "on";
      };

      lsp = {
        rust-analyzer = {
          binary = {
            # path = lib.getExe pkgs.rust-analyzer;
            path_lookup = true;
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
