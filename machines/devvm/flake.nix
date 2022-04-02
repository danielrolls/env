{
  description = "Nixos Flake for development";

  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-21.11";
    home-manager.url = "github:nix-community/home-manager/release-21.11";
    home-manager.inputs.nixpkgs.follows = "nixos";
  };

  outputs = { self, nixos, home-manager }: {

    devvm = import ./make-devvm-image.nix {
      inherit self;
      inherit nixos;
      inherit home-manager;
      modules = [
        ( {nix, ...}: {

          # Binary Cache for Haskell.nix
          nix.binaryCachePublicKeys = [
            "hydra.iohk.io:f/Ea+s+dFdN+3Y/G+FDgSq+a5NEWhJGzdjvKNGv0/EQ="
          ];
          nix.binaryCaches = [
            "https://hydra.iohk.io"
          ];

          fileSystems."/mnt/share" = { 
              device = "hostshare";
              fsType = "9p";
              options = [ "trans=virtio" "version=9p2000.L" ];
          };

	})
      ];
      diskSize = 16384;
    };

  };
}
