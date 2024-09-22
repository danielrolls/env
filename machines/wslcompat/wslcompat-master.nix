{shellify, ...}:
{ lib, pkgs, config, modulesPath, ... }:

with lib;
let
  defaultUser = "dro25";
  syschdemd = import ./syschdemd.nix { inherit lib pkgs config defaultUser; };
in
{
  imports = [
    "${modulesPath}/profiles/minimal.nix"
    ((import ../../homely.nix) defaultUser)
    ((import ../../dev.nix) defaultUser)
  ];

  nixpkgs.config.allowUnfreePredicate = pk: true;

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

  home-manager.users."dro25" = {

    home.stateVersion = "22.05";
 
    programs.taskwarrior = {
      dataLocation = "/mnt/c/Users/dro25/OneDrive\ -\ Sky/scarlethomeshare/taskwarrior";

      colorTheme = lib.mkForce "dark-256";
    };
    programs.vscode.enable = lib.mkForce false;
  };

  environment.systemPackages = [
    shellify.packages.x86_64-linux.default
  ];

  #virtualisation.docker.enable = true;

  environment.noXlibs = lib.mkForce false;

  # WSL is closer to a container than anything else
  boot.isContainer = true;

  environment.etc.hosts.enable = false;
  environment.etc."resolv.conf".enable = false;

  networking.dhcpcd.enable = false;

  users.users.${defaultUser} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
  };

  users.users.root = {
    shell = "${syschdemd}/bin/syschdemd";
    # Otherwise WSL fails to login as root with "initgroups failed 5"
    extraGroups = [ "root" ];
  };

  security.sudo.wheelNeedsPassword = false;

  # Disable systemd units that don't make sense on WSL
  systemd.services = {
    "serial-getty@ttyS0".enable = false;
    "serial-getty@hvc0".enable = false;
    "getty@tty1".enable = false;
    "autovt@".enable = false;
  };

  systemd.services.firewall.enable = false;
  systemd.services.systemd-resolved.enable = false;
  systemd.services.systemd-udevd.enable = false;

  # Don't allow emergency mode, because we don't have a console.
  systemd.enableEmergencyMode = false;
}
