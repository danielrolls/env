{ config, lib, pkgs, ... }:

{
  imports = [ <home-manager/nixos> ];

  home-manager.users.dan = { pkgs, ... }: {

    programs = {

      vim = {
        enable = true;
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
      tasks = "task sync ; task";
    };


    programs.direnv.enable = true;

    home.file = {
      ".inputrc".text = "set editing-mode vi";
    };

  };

}
