let homeDir = "/home/dan";
in
{ config, pkgs, ... }:

{

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  imports =
    [ ./lam-hardware-configuaration.nix
      (import ../../homely.nix "dan")
      (import ../../dev.nix "dan")
      (import ../../desktop.nix)
      (import ./lam.nix "dan")
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  system.stateVersion = "20.03"; # Do not change without checking docs
}
