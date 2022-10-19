{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05"; #/nixos-22.05 /nixos-release
    home-manager = {
      url = "github:nix-community/home-manager/release-22.05"; #/release-22.05 /
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # hyprland = {
    #   url = "github:hyprwm/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
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
        version = "22.05";
        style = (import ./config/style.nix) { lib = self.lib; };
      };
      modules = [
        ./config/configuration.nix
        # hyprland.nixosModules.default
        # { programs.hyprland.enable = true; }
        # home-manager.nixosModule.home-manager ({ home-manager = })
      ];
    };
  };
}
