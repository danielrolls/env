{
  networking = {
    hostName = "lam"; 
  };

  fileSystems."/data" = {
    device = "/dev/disk/by-uuid/c6f074cc-ba18-4c58-911e-376c24127eff";
    options = ["nofail"];
  };

}

