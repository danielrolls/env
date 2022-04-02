{userName}:
{modulesPath, ...}:
{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
      (import ../../homely.nix "${userName}")
      (import ../../dev.nix "${userName}")
    ];

  # Bootloader
  boot.growPartition = true;
  boot.kernelParams = [ "console=ttyS0" ];
  boot.loader.grub.device = "/dev/vda";
  boot.loader.timeout = 0;

  fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
      autoResize = true;
  };

  users.users."${userName}".extraGroups = [ "wheel" ]; 
  networking.firewall.enable = false;

  services.openssh = {
    enable = true;
  };

}

