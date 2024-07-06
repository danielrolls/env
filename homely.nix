userName:
{ pkgs, ... }:

{
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  users.users."${userName}" = {
    isNormalUser = true;
  };

  home-manager.users."${userName}" = { pkgs, ... }: {
    programs = {

      neovim = {
        enable = true;
	vimAlias = true;
	withNodeJs = true;
	plugins = with pkgs.vimPlugins; [  
           vim-nix
           vimwiki
	];
      };

      direnv.enable = true;
      bash.enable = true;

    };

    home = {
      sessionVariables = {
        EDITOR = "vim";
      };
      file = {
        ".inputrc".text = "set editing-mode vi";
      };
    };

  };
}
