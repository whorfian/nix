{ a }: {
  enable = true;
  settings = {
    font_size = "18.0";
    font_family = "FiraCode Nerd Font";
    bold_font = "auto";
    italic_font = "auto";
    bold_italic_font = "auto";
    allow_remote_control = true;


    # theme = "One Dark";
    # theme = a.cs.kitty; # kitty can't even read this? 
    # keybindings = "";

    foreground = "${a.cs.fg-primary}";
    background = "${a.cs.bg-primary}";
    color0 = "${a.cs.black}";
    color1 = "${a.cs.red}";
    color2 = "${a.cs.green}";
    color3 = "${a.cs.yellow}";
    color4 = "${a.cs.blue}";
    color5 = "${a.cs.magenta}";
    color6 = "${a.cs.cyan}";
    color7 = "${a.cs.white}";
    color8 = "${a.cs.bright-black}";
    color9 = "${a.cs.bright-red}";
    color10 = "${a.cs.bright-green}";
    color11 = "${a.cs.bright-yellow}";
    color12 = "${a.cs.bright-blue}";
    color13 = "${a.cs.bright-magenta}";
    color14 = "${a.cs.bright-cyan}";
    color15 = "${a.cs.bright-white}";
  };
}
