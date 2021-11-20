userName:
{ config, lib, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users."${userName}" = { pkgs, ... }: {

    programs = {

      git = {
        enable = true;
        userName = "Daniel Rolls";
        userEmail = "daniel.rolls.27@googlemail.com";
      };

      vscode = {
        enable = true;
        package = pkgs.vscodium;    # You can skip this if you want to use the unfree version
        extensions = with pkgs.vscode-extensions; [
          vscodevim.vim
          haskell.haskell
        ];
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
