{
  description = "Nixos Flake for Lam";

  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixos";
    sops-nix.url = github:Mic92/sops-nix;
    sops-nix.inputs.nixpkgs.follows = "nixos";
  };

  outputs = { self, nixos, home-manager, sops-nix }: {

    nixosConfigurations."lam" = nixos.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
	}
	sops-nix.nixosModules.sops
        ./lam-master.nix
      ];
    };
  };
}
