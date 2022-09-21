{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim.url = "github:neovim/neovim?dir=contrib";
  };
  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.whorf = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs // {
        user = "whorf";
        email = "whorf@whorf.dev";
        version = "22.05";
        style = (import ./config/style.nix) { lib = self.lib; };
      };
      modules = [ ./config/configuration.nix ];
    };
  };
}


# kitty
# make a session that just opens up a bunch of abduco sessions with names and colors
# set-tab-title
# set-tab-color

# kitty @ focus-tab -m title:$(kitty @ ls |\
#  jq -r '.[0].tabs[].title' |\
#  rofi -dmenu)