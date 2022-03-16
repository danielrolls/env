let homeDir = "/home/dan";
in
{ config, pkgs, ... }:

{

  imports =
    [ (import ./devvm.nix "dan")
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

}
