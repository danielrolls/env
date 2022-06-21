userName:
{ config, lib, pkgs, ... }:

{
  users.users."${userName}" = {
    extraGroups = [ "wheel" "audio" "networkmanager" "libvirtd"]; 
  };
  sound.enable = true;

  hardware.pulseaudio.enable = true;

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
  ];

  programs.geary.enable = false;

  environment.gnome.excludePackages = map (x: pkgs.gnome3."${x}") [
   "epiphany"
   "five-or-more"
   "geary"
   "gedit"
   "gnome-contacts"
   "gnome-mahjongg"
   "gnome-maps"
   "gnome-robots"
   "gnome-software"
   "gnome-sudoku"
   "gnome-tetravex"
   "gnome-weather"
   "gnome-chess"
   "hitori"
   "swell-foop"
   "tali"
  ];

  virtualisation.libvirtd.enable = true;

  home-manager.users."${userName}" = { pkgs, ... }: {
    home.packages = with pkgs; [ 
      avidemux
      keepassxc
      xournalpp
    ];

    programs = {
      chromium.enable = true;
      firefox.enable = true;
    };

    dconf.settings = {
      "org/gnome/settings-daemon/plugins/media-keys".home = ["<Super>e"];
    };
  };
}

