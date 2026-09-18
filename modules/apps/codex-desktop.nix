{ inputs, ... }:

{
  imports = [ inputs.codex-desktop-linux.nixosModules.default ];

  programs.codexDesktopLinux = {
    enable = true;

    # OpenAI does not yet support Computer Use in its Linux preview. This
    # explicitly enables the community Linux implementation packaged by
    # ilysenko/codex-desktop-linux.
    computerUseUi.enable = true;
  };
}
