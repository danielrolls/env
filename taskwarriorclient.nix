userName:
{ pkgs, ... }:

{
  home-manager.users."${userName}" = { ... }: {
    programs = {
      taskwarrior = {
        enable = true;
        package  = pkgs.taskwarrior3;
        colorTheme = "light-256";
        config = {
          urgency = {
            uda.priority = {
              L.coefficient = -1.0;
              M.coefficient = 5; # + 1.1
              H.coefficient = 10; # + 4
            };
            user.tag."in".coefficient = 30;
          };
          uda.details = {
            type = "string";
            label = "Details";
          };
          report = {
            next.filter = "-chase -WAITING status:pending limit:page";
            chase = {
              description = "Tasks to chase up";
              columns = "id,start.age,entry.age,depends,priority,project,recur,scheduled.countdown,due.relative,until.remaining,description,urgency";
              filter = "+chase -WAITING status:pending limit:page";
              labels = "ID,Active,Age,Deps,P,Project,Recur,S,Due,Until,Description,Urg";
              sort = "urgency-";
            };
          };
        };
      };

      bash.shellAliases = {
        "in" = "clear; task add +in";
        next = "clear; task add +next";
        tasks = "task sync ; task";
      };
    };
  };
}
