{
  description = "Nixos Flake for development";

  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixos";
  };

  outputs = { self, nixos, home-manager }: {

    # nix build '.#devvm'
    devvm = let system = "x86_64-linux";
    in import "${nixos}/nixos/lib/make-disk-image.nix" {
      pkgs = nixos.legacyPackages."${system}";
      lib = nixos.lib;
      config = (nixos.lib.nixosSystem {
        inherit system;
        modules = [ 
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
	  }
          ./devvm-master.nix
	  (import ./testvm.nix "dan")
        ];
      }).config;
      format = "qcow2";
      diskSize = 4096;
      name = "devvm";
    };
  };
}
