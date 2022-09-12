{ user, email }: {
  useGlobalPkgs = true;
  users."${user}" = {
    programs = {
      git = {
        enable = true;
        userName = "${user}";
        userEmail = "${email}";
        extraConfig = { init.defaultBranch = "master"; };
        aliases = {
          c = "commit -am";
          s = "status";
          a = "add .";
          i = "init";
          d = "diff";
          p = "push origin master";
        };
      };
      kitty = {
        enable = true;
        settings = {
          font_size = "18.0";
          font_family = "FiraCode Nerd Font";
          bold_font = "auto";
          italic_font = "auto";
          bold_italic_font = "auto";
          theme = "One Dark";
          keybindings = "";

        };
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
