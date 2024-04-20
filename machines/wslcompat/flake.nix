{
  description = "Nixos Flake for wslcompat";

  inputs = {
    nixos.url = "github:nixos/nixpkgs/nixos-23.11";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixos";
    shellify.url = "github:danielrolls/shellify";
  };

  outputs = { self, nixos, nixos-wsl, home-manager, shellify }:
  {

    nixosConfigurations."wslcompat" = nixos.lib.nixosSystem {
      system = "x86_64-linux";

      modules = [
        nixos-wsl.nixosModules.default
        {
          #system.stateVersion = "23.11";
          wsl.enable = true;
          #wsl.defaultUser =  <enter user here>
        }

        home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
        }
        (import ./wslcompat-master.nix {inherit shellify;})
      ];
    };
  };
}
