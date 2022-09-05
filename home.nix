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
