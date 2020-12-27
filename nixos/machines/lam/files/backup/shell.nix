{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  name = "backup";
  buildInputs = [ pkgs.borgbackup ];
  # shellHook
}
