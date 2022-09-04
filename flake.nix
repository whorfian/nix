{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-22.05;
    home-manager = {
      url = github:nix-community/home-manager/release-22.05;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = { self, nixpkgs, ... }@attrs: {
    nixosConfigurations.whorf = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [ ./configuration.nix ];
    };
  };
}

# inputs.fup.lib.mkFlake {
#     inherit self inputs;
#     supportedSystems = [ "x86_64-linux" ];
#     channelsConfig.allowUnfree = true;
#     hosts.whorf.modules = [ ./configuration.nix ];
# };

# homeConfigurations.whorf = home-manager.lib.homeManagerConfiguration {
#   system = "x86_64-linux";
#   # configuration = ./home.nix;
#   extraModules = [
#     ./home.nix
#   ];
# };