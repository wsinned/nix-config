{ inputs, pkgs, ... }:

{

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    # colorscheme = "slate";
    
    globals = {
      mapleader = " ";
      maplocalleader = " ";
    };

    clipboard = {
      # Use system clipboard
      register = "unnamedplus";

      providers.wl-copy.enable = true;
    };

    opts = {

      # Line numbers
      relativenumber = true; # Relative line numbers
      number = true; # Display the absolute line number of the current line

      splitbelow = true; # A new window is put below the current one
      splitright = true; # A new window is put right of the current one

      swapfile = false; # Disable the swap file
      fileencoding = "utf-8"; # File-content encoding for the current buffer
      termguicolors = true; # Enables 24-bit RGB color in the |TUI|
      spell = false; # Highlight spelling mistakes (local to window)
      wrap = false; # Prevent text from wrapping

      # Tab options
      tabstop = 2; # Number of spaces a <Tab> in the text stands for (local to buffer)
      shiftwidth = 2; # Number of spaces used for each step of (auto)indent (local to buffer)
      expandtab = true; # Expand <Tab> to spaces in Insert mode (local to buffer)
      autoindent = true; # Do clever autoindenting
    };

    plugins.neo-tree = {
      enable = true;
      enableGitStatus = true;

    };

    plugins.lazygit.enable = true;
    plugins.which-key.enable = true;
    plugins.nvim-autopairs.enable = true;

    colorschemes = {
      gruvbox = {
        enable = false;
        settings = {
          transparent_mode = true;
        };
      };
      tokyonight = {
        enable = true;
        settings = {
          style = "night";
          transparent = true;
        };
      };
    };

    keymaps = [
      {
        mode = ["n"];
        key = "<leader>e";
        action = "<cmd>Neotree toggle<cr>";
        options = {desc = "Open/Close Neotree";};
      }
      {
        mode = "n";
        key = "<leader>gg";
        action = "<cmd>LazyGit<CR>";
        options = {desc = "LazyGit (root dir)";};
      }
      {
        mode = "n";
        key = "<C-c>";
        action = ":b#<CR>";
        options = {desc = "back and forth between the two most recent files";};
      }
      {
        mode = "n";
        key = "<leader>h";
        action = "<C-w>h";
        options = {desc = "Navigate to left window";};
      }
      {
        mode = "n";
        key = "<leader>l";
        action = "<C-w>l";
        options = {desc = "Navigate to right window";};
      }
      {
        mode = "n";
        key = "<leader>w";
        action = ":WhichKey<CR>";
        options = {desc = "Opens WhichKey to explain mappings.";};
      }
      {
        mode = "n";
        key = "<leader>b";
        action = ":Neotree toggle focus buffers right<CR>";
        options = {desc = "Toggles a focused window of open buffers on the right";};
      }
    ];

  };

  # programs.neovim = {
  #   enable = true;
  #   viAlias = true;
  #   vimAlias = true;
  #   extraConfig = '' 
  #     set number relativenumber
  #     colorscheme slate
  #   '';
  #   plugins = with pkgs.vimPlugins; [
  #     neo-tree-nvim # File-browser
  #     lazygit-nvim
  #   ];
  # };
}
