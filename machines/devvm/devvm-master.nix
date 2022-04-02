let userName = "dan";
in
{ config, pkgs, ... }:

{

  imports =
    [ (import ./devvm.nix {inherit userName;})
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

}
