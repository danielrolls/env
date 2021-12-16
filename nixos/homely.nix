userName:
{ config, lib, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  time.timeZone = "Europe/London";

  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nixFlakes" ''
      exec ${pkgs.nixUnstable}/bin/nix --experimental-features "nix-command flakes" "$@"
    '')
    (neovim.override {
      vimAlias = true;
      withNodeJs = true;
      configure = {
        packages.myPlugins = with pkgs.vimPlugins; {
          start = [
                    coc-nvim
                    haskell-vim
                    ghcid
                    vim-hindent
                    coc-json
                    coc-vimlsp
                    vimwiki
                  ];
          opt = [];
        };
        #customRC = "inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : \\\"\\<C-g>u\\<CR>\\<c-r>=coc#on_enter()\\<CR>\" ";
      };
    }
  )
  ];

  home-manager.users."${userName}" = { pkgs, ... }: {
    programs = {

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
