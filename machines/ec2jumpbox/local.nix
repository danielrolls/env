{ config, pkgs, ... }:

{
  nix.extraOptions = "experimental-features = nix-command flakes";
  users.extraUsers.dan.extraGroups = [ "wheel" ];
  security.sudo.wheelNeedsPassword = false;
}
