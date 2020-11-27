{ config, lib, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.dan = { pkgs, ... }: {

    programs = {

      git = {
        enable = true;
        userName = "Daniel Rolls";
        userEmail = "daniel.rolls.27@googlemail.com";
      };

    };

    home.packages = with pkgs; [
      stack
    ];

    
    home.file = {

      ".haskeline".text = ''
        maxHistorySize: Nothing
        historyDuplicates: IgnoreConsecutive
        editMode: Vi
      '';

      ".stack/config.yaml".text = ''
        templates:
          params:
            author-email: daniel.rolls.27@googlemail.com
            author-name: Daniel Rolls
            github-username: danielrolls
      '';

    };

  };

}
