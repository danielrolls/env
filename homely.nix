userName:
{ config, lib, pkgs, ... }:

{
  time.timeZone = "Europe/London";
  i18n.defaultLocale = "en_GB.UTF-8";
  console.keyMap = "uk";

  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixFlakes}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
  ];

  users.users."${userName}" = {
    isNormalUser = true;
  };

  home-manager.users."${userName}" = { pkgs, ... }: {
    programs = {

      neovim = {
        enable = true;
	vimAlias = true;
	withNodeJs = true;
	#coc.enable = true;
	coc.settings = {
            "languageserver" = {
              "haskell" = {
                "command" = "haskell-language-server-wrapper";
                "args" = ["--lsp"];
                "rootPatterns" = ["*.cabal" "stack.yaml" "cabal.project" "package.yaml" "hie.yaml"];
                "filetypes" = ["haskell" "lhaskell"];
              };
            };
          };

	plugins = with pkgs.vimPlugins; [  
           # coc-nvim
           haskell-vim
           # ghcid
           coc-json
           coc-vimlsp
           vimwiki
	];
      };

      bash.enable = true;

      taskwarrior = {
        enable = true;
        colorTheme = "light-256";
        config = {
          urgency.uda.priority = {
            L.coefficient = -1.0;
            M.coefficient = 5; # + 1.1
            H.coefficient = 10; # + 4
          };
          urgency.user.tag."in".coefficient = 30;
          uda.details = {
            type = "string";
            label = "Details";
          };
          report = {
            next.filter = "-chase status:pending limit:page";
            chase = {
              description = "Tasks to chase up";
              columns = "id,start.age,entry.age,depends,priority,project,recur,scheduled.countdown,due.relative,until.remaining,description,urgency";
              filter = "+chase status:pending limit:page";
              labels = "ID,Active,Age,Deps,P,Project,Recur,S,Due,Until,Description,Urg";
              sort = "urgency-";
            };
          };
        };
      };
    };

    
    home.sessionVariables = {
      EDITOR = "vim";
    };

    programs.bash.shellAliases = {
      "in" = "clear; task add +in";
      next = "clear; task add +next";
      tasks = "task sync ; task";
    };


    programs.direnv.enable = true;

    home.file = {
      ".inputrc".text = "set editing-mode vi";
    };

  };

  services.printing.drivers = [pkgs.splix]; # samsung printer drivers

}
