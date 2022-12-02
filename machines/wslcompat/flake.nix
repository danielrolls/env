{
  description = "Nixos Flake for wslcompat";

  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixos";
  };

  outputs = { self, nixos, home-manager }: {

    nixosConfigurations."wslcompat" = nixos.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
	}
        ./wslcompat-master.nix
      ];
    };
  };
}
