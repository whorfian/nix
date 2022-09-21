{ a }: {
  useGlobalPkgs = true;
  users."${a.user}" = {
    # home.file.".config/nvim/init.lua".source = ./nvim/init.lua;
    xdg.configFile.nvim = {
      source = ./nvim;
      recursive = true;
    };
    home.file.".config/kitty/startup.conf".source = ./kitty-startup.conf;
    programs = {
      git = (import ./git.nix) { inherit a; };
      zsh = (import ./zsh.nix) { inherit a; };
      kitty = (import ./kitty.nix) { inherit a; };
      neovim = (import ./nvim.nix) { inherit a; };
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
        config.theme = a.style.bat-theme;
      };
    };
    services = {
      sxhkd = {
        enable = true;
        extraConfig = builtins.readFile ./sxhkdrc;
      };
    };
    xsession = {
      windowManager = {
        bspwm = {
          enable = true;
          extraConfig = builtins.readFile ./bspwmrc;
        };
      };
    };
  };
}
