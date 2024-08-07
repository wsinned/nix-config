{
  programs.kitty = {
    enable = true;
    font.name = "MesloLGS NF";
    font.size = 14;
    shellIntegration.enableZshIntegration = true;
    keybindings = {
      "f1" =  "launch --cwd=current";
    };
    settings = {
      enabled_layouts = "tall:bias=70;full_size=1;mirrored=false";
    };
  };
}
