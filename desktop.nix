userName:
{ config, lib, pkgs, ... }:

{
  users.users."${userName}" = {
    extraGroups = [ "wheel" "audio" "networkmanager" "libvirtd" "docker"]; 
  };
  sound.enable = true;

  hardware.pulseaudio.enable = true;

  services = {
    printing = {
      enable = true;
      stateless = true;
    };
    
    avahi = {
      enable = true;
      nssmdns = true;
      openFirewall = true;
    };

    xserver = {
      enable = true;
      layout = "gb";

      displayManager.defaultSession = "xfce";
      desktopManager.xfce.enable = true;
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

  services.printing.drivers = [pkgs.splix]; # samsung printer drivers
}

