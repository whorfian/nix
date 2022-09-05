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
        # bspwm.enable = true;
        i3 = {
          enable = false;
          config = { modifier = "Mod4"; };
        };
        bspwm = { 
          enable = true; 
          extraConfig = ''
#bspc monitor --reset-desktops 1 2 3 4 5 6 
          '';
        };
      };
    };
  };
}
