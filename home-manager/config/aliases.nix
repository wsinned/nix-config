{
  home.shellAliases = {
  
    # misc aliases
    ls = "ls -F --color=auto --show-control-chars";
    ll = "ls -lh";
    la = "ls -alh";
    v = "nvim";
    vs = "code";

    # git aliases
    g = "git";
    s = "git status -sbu";
    l = "git log --pretty=format:'%Cgreen%h%d %Creset%s %Cred%an, %Cgreen%ar%Creset' --graph";
    ci = "git commit";
    ga = "git add --all";


    # nix aliases
    nix-gens = "nix profile history --profile /nix/var/nix/profiles/system";


    thisWeek = "take-note --thisWeek $args";
    nextWeek = "take-note --nextWeek $args";
    lastWeek = "take-note --lastWeek $args";
  
  };
}

