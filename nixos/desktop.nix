{ config, lib, pkgs, ... }:

{
  users.users.dan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "networkmanager" ]; 
  };
  sound.enable = true;

  hardware.pulseaudio = {
    enable = true;
  };

  services = {
    printing.enable = true;
    
    xserver = {
      enable = true;
      layout = "gb";

      displayManager.gdm.enable = true;
      displayManager.gdm.wayland = true;
      desktopManager.gnome.enable = true;
    };

    gnome.games.enable = true;
  };

  environment.systemPackages = with pkgs; [
    vlc
    bash-completion
    cryptsetup
    signal-desktop
    usbutils
    file
    zim
  ];

  programs.geary.enable = false;

  environment.gnome.excludePackages = map (x: pkgs.gnome3."${x}") [
   "epiphany"
   "geary"
   "gnome-software"
   "gnome-maps"
   "gedit"
   "gnome-contacts"
   "gnome-photos"
   "gnome-weather"
  ];

  home-manager.users.dan = { pkgs, ... }: {
    home.packages = with pkgs; [ 
      xournalpp
      keepassxc
    ];

    programs = {
      chromium.enable = true;
      firefox.enable = true;
    };
  };
}

