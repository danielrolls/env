userName:
{modulesPath, ...}:
{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
      (import ../../homely.nix "dan")
      (import ../../dev.nix "dan")
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

}

