{ config, lib, pkgs, ... }:

{

  environment.systemPackages = with pkgs; [
    vlc
    bash-completion
    cryptsetup
    signal-desktop
    usbutils
    file
    zim
  ];

  services.printing = {
    enable = true;
  };

  sound.enable = true;

  
  hardware.pulseaudio = {
    enable = true;
  };


  services.xserver = {
    enable = true;
    layout = "gb";

    displayManager.gdm.enable = true;
    desktopManager.gnome3.enable = true;
  };

  programs.geary.enable = false;
  programs.steam.enable = true;

  environment.gnome3.excludePackages = map (x: pkgs.gnome3."${x}") [
   "epiphany"
   "geary"
   "gnome-software"
   "gnome-maps"
   "gedit"
   "gnome-contacts"
   "gnome-photos"
   "gnome-weather"
  ];
  
  users.users.dan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "networkmanager" ]; 
  };

  home-manager.users.dan = { pkgs, ... }: {
    home.packages = with pkgs; [ 
      xournalpp
      keepassxc
    ];

    programs = {
      chromium.enable = true;
    };
  };


}
