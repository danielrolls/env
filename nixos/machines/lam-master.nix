let homeDir = "/home/dan";
in
{ config, pkgs, ... }:

{
  imports =
    [ ./lam-hardware-configuaration.nix
      <home-manager/nixos>
      (import ../homely.nix "dan")
      (import ../dev.nix "dan")
      (import ../desktop.nix)
      (import ./lam.nix "dan")
    ];

  system.stateVersion = "20.03"; # Do not change without checking docs
}
