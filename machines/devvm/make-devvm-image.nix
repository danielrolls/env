let system = "x86_64-linux";
in
{self, nixos, home-manager, modules, diskSize ? 4096, ...}: import "${nixos}/nixos/lib/make-disk-image.nix" {
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
         ] ++ modules;
     }).config;
     format = "qcow2";
     inherit diskSize;
     name = "devvm";
  }
