{ shellify, ...}:
let homeDir = "/home/dan";
in
{ config, pkgs, ... }:

{

  imports =
    [ ./lam-hardware-configuaration.nix
      (import ./lam.nix "dan")
    ];

  nix.extraOptions = ''
      experimental-features = nix-command flakes
    '';

  environment.systemPackages = [
    pkgs.shellify
    #haskellUpdates.legacyPackages.x86_64-linux.shellify
    # shellify.packages.x86_64-linux.default
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

    programs.taskwarrior.config.taskd = {
      server = "taskwarrior.inthe.am:53589";
      credentials = "inthe_am/daniel.rolls.27/2dc1a8f3-aa4a-46d2-aff0-3f81a44f3f8c";
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
