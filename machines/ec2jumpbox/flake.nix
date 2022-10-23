{
  description = "AWS Jumpbox";

  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-21.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-21.11";
      inputs.nixpkgs.follows = "nixos";
    };
  };

  outputs = { self, nixos, home-manager }: {
    nixosConfigurations."ec2jumpbox" = nixos.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
	}
	"${nixos}/nixos/modules/virtualisation/amazon-image.nix"
        ((import ../../homely.nix) "dan")
        ./local.nix
      ];
      
    };
  };
}
