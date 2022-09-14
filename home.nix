{ a }: {
  useGlobalPkgs = true;
  users."${a.user}" = {
    programs = {
      git = (import ./git.nix) { inherit a; };
      zsh = (import ./zsh.nix) { inherit a; };
      kitty = (import ./kitty.nix) { inherit a; };
      neovim = (import ./neovim/neovim.nix) { inherit a; };
      fzf = {
        enable = true;
        enableZshIntegration = true;
      };
      direnv = {
        enable = true;
        nix-direnv.enable = true;
      };
      bat = {
        enable = true;
        config.theme = a.cs.bat;
      };
    };
    services = {
      sxhkd = {
        enable = true;
        extraConfig = builtins.readFile sxhkd/sxhkdrc;
      };
    };
    xsession = {
      windowManager = {
        bspwm = {
          enable = true;
          extraConfig = builtins.readFile bspwm/bspwmrc;
        };
      };
    };
  };
}
