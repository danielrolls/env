{lib, ...}:
{
  networking = {
    hostName = "lam"; 
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/c6f074cc-ba18-4c58-911e-376c24127eff";
    options = ["nofail"];
  };

  services.xserver = {
    libinput.enable = true; # Enable touchpad support.
    videoDrivers = [ "modesetting" ];
    useGlamor = true;
  };

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  swapDevices = lib.mkForce [];
}

