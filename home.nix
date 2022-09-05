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
        # keybindings = {
        #   # "super + {b,e,t,d}" = " 
        #   "super + t" = "kitty";
        # };
        extraConfig = ''
super + t
  kitty
super + e
  kitty -e nvim
super + b
  google-chrome-stable
super + d
  discord
super + r
  rofi -show run  
super + w
  rofi -show window
# close and kill
super + {_,shift + }q
  bspc node -{c,k}
# focus or send to the given desktop
super + {_,shift + }{1-9,0}
  bspc {desktop --focus,node --to-desktop} {1-9,10}
super + f
  bspc node --state ~fullscreen
super + Escape
	pkill -usr1 -x sxhkd
        '';
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
