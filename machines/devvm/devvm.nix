userName:
{modulesPath, ...}:
{
  imports =
    [ (modulesPath + "/profiles/qemu-guest.nix")
      (import ../../homely.nix "dan")
      (import ../../dev.nix "dan")
    ];

  home-manager.users."${userName}".programs.neovim.extraConfig =  "let g:vimwiki_list = [{'path': '/data/wiki/', 'syntax': 'markdown', 'ext': '.md'}]"; 

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

  users.users.dan = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "networkmanager"]; 
  };

}

