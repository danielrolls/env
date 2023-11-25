{
  description = "Nixos Flake for Lam";

  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-23.11";
    #haskellUpdates.url = "github:nixos/nixpkgs/haskell-updates";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixos";
    shellify.url = "github:danielrolls/shellify";
    shellify.inputs.nixpkgs.follows = "nixos";
    sops-nix.url = github:Mic92/sops-nix;
    sops-nix.inputs.nixpkgs.follows = "nixos";
    secret.url = path:/data/danlamnixosagekey;
    secret.flake = false;
  };

  outputs = { self, nixos, home-manager, shellify, sops-nix, secret}: {

    nixosConfigurations."lam" = nixos.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
	}
	sops-nix.nixosModules.sops
        (import ./lam-master.nix {inherit secret shellify;})
      ];
    };
  };
}
