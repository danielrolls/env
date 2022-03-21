{ pkgs ? import <nixpkgs> {} }:
  pkgs.mkShell {
    nativeBuildInputs = [ pkgs.virt-manager pkgs.virt-viewer pkgs.libosinfo];
}
