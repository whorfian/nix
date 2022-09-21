# Credit: https://github.com/sherubthakur/dotfiles
{ lib }:
let transparentify = color: "#99${lib.strings.removePrefix "#" color}";
in rec {
  kitty-theme = "One Dark";
  bat-theme = "base16";

  mono-font = "SourceCodePro Nerd Font";
  sans-font = "SourceSansPro Nerd Font";
  serif-font = "SourceSerifPro Nerd Font";

  bg-primary = black;
  bg-primary-bright = bright-black;
  bg-primary-transparent-argb = transparentify bg-primary;
  bg-primary-bright-transparent-argb = transparentify bg-primary-bright;
  fg-primary = white;
  fg-primary-bright = bright-white;

  accent-primary = green;
  accent-secondary = blue;
  accent-tertiary = magenta;

  alert = red;
  warning = yellow;

  black = "#282C34";
  red = "#E06C75";
  green = "#98C379";
  yellow = "#d19a66";
  blue = "#61AFEF";
  magenta = "#C678DD";
  cyan = "#56b6c2";
  white = "#ABB2BF";
  grey = "#404247";
  bright-black = "#3e4451";
  bright-red = "#be5046";
  bright-green = "#98C379";
  bright-yellow = "#E5C07B";
  bright-blue = "#61AFEF";
  bright-magenta = "#C678DD";
  bright-cyan = "#56b6c2";
  bright-white = "#e6efff";
  light-grey = "#57595e";
}
