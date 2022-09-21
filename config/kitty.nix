{ a }: {
  enable = true;
  theme = a.style.kitty-theme;
  # keybindings = "";
  settings = {
    font_size = "18.0";
    font_family = a.style.mono-font;
    bold_font = "auto";
    italic_font = "auto";
    bold_italic_font = "auto";
    allow_remote_control = true;
    startup_session = "startup.conf";
    confirm_os_window_close = "0";
  };
}
