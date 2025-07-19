{ shellify, nixos-unstable, ...}:
let homeDir = "/home/dan";
    unstablePkgs = nixos-unstable.legacyPackages.x86_64-linux;
in
{ config, pkgs, ... }:

{

  imports =
    [ ./lam-hardware-configuaration.nix
      (import ./lam.nix "dan")
    ];

    nixpkgs.config.allowUnfreePredicate = pk: builtins.elem (lib.getName pk) [
      "claude-code"
      "cursor"
      "vscode"
      "vscode-extension-github-copilot"
    ];
  fileSystems."/run/ram" =
    { device = "tmpfs";
      fsType = "tmpfs";
      options = [ "size=1M" ];
    };

  nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';

  environment.systemPackages = [
    pkgs.sops
    pkgs.age
    unstablePkgs.aws-spend-summary
    #haskellUpdates.legacyPackages.x86_64-linux.shellify
    # shellify.packages.x86_64-linux.default
    pkgs.niv
  ];

  sops.defaultSopsFile = ./mysopsdata.yaml;

  sops.secrets."taskwarrior_creds/key" = {
    name = "taskwarrior_creds/private.key.pem";
    owner = "dan";
  };
  sops.secrets."taskwarrior_creds/private_cert" = {
    name = "taskwarrior_creds/private_cert.pem";
    owner = "dan";
  };
  sops.secrets."taskwarrior_creds/ca_cert" = {
    name = "taskwarrior_creds/ca_cert.pem";
    owner = "dan";
  };

  home-manager.users.dan = { ... }:
    let secretBase = "/run/secrets/taskwarrior_creds/";
    in {

    home.stateVersion = "22.11";

    programs = {
      taskwarrior.config.taskd = {
        ca = secretBase + "ca_cert.pem";
        certificate = secretBase + "private_cert.pem";
        key = secretBase + "private.key.pem";
      };
    };

  };

  system.stateVersion = "20.03"; # Do not change without checking docs

  services.printing.drivers = [pkgs.splix]; # samsung printer drivers

  hardware.printers.ensurePrinters = [
    {
      name = "sparrow-chick";
      location = "Home";
      deviceUri = "ipp://192.168.0.30/printers/sparrow";
      model = "everywhere"; # Samsung ML-2240, 2.0.0
      ppdOptions.PageSize = "A4";
    }
  ];
}
