{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.whorf = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs // {
        user = "whorf";
        email = "whorf@whorf.dev";
        version = "22.11";
        style = (import ./config/style.nix) { lib = self.lib; };
      };
      modules = [
        ./config/configuration.nix
        hyprland.nixosModules.default
        { programs.hyprland.enable = true; }
        # home-manager.nixosModule
      ];
    };
  };
}
