userName:
{ config, lib, pkgs, ... }:

{
  users.users."${userName}" = {
    extraGroups = [ "wheel" "audio" "networkmanager" "libvirtd" "docker"]; 
  };

  services = {
    printing = {
      enable = true;
      stateless = true;
    };
    
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };

    xserver = {
      enable = true;
      xkb.layout = "gb";

      desktopManager.xfce.enable = true;
    };

    gnome.games.enable = true;
  };

  environment.gnome.excludePackages = (map (x: pkgs."${x}") [
   "epiphany"
   "five-or-more"
   "geary"
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
  ]) ++
  [
   pkgs.gnome-2048
  ];

  environment.systemPackages = with pkgs; [
    vlc
    bash-completion
    cryptsetup
    signal-desktop
    usbutils
    file
    pinentry-gtk2 # for gpg
  ];

  virtualisation.libvirtd.enable = true;

  home-manager.users."${userName}" = { pkgs, ... }: {
    home.packages = with pkgs; [ 
      #avidemux
      keepassxc
      xournalpp
    ];

    programs = {
      chromium.enable = true;
      firefox.enable = true;
      gpg = {
        enable = true;
      };
    };

    dconf.settings = {
      "org/gnome/settings-daemon/plugins/media-keys".home = ["<Super>e"];
    };
  };

}

