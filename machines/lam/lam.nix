userName:
{lib, pkgs, ...}:
{
  imports =
    [ (import ../../homely.nix "dan")
      (import ../../dev.nix "dan")
      (import ../../desktop.nix "dan")
    ];

  networking = {
    hostName = "lam"; 
    networkmanager = {
      enable = true;
      unmanaged = [ "interface-name:ve-*" ]; # needed for containers
    };
    interfaces.wlo1.useDHCP = true;
    useDHCP = false; # As of 21.11, the manual recommends setting this to false and specifying it on individual interfaces
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/c6f074cc-ba18-4c58-911e-376c24127eff";
    options = ["nofail"];
  };

  services.xserver.libinput.enable = true; # Enable touchpad support.

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  swapDevices = lib.mkForce [];
 
  hardware.sensor.iio.enable = true;

  home-manager.users."${userName}".programs.neovim.extraConfig =  "let g:vimwiki_list = [{'path': '/data/wiki/', 'syntax': 'markdown', 'ext': '.md'}]"; 
}

