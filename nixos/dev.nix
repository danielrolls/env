userName:
{ config, lib, pkgs, ... }:

{
  programs.bash.promptInit = ''
       # Provide a nice prompt if the terminal supports it.
       if [ "$TERM" != "dumb" ] || [ -n "$INSIDE_EMACS" ]; then
         PROMPT_COLOR="1;31m"
         GIT_PS1_SHOWDIRTYSTATE=1
         GIT_PS1_SHOWUNTRACKEDFILES=1
         ((UID)) && PROMPT_COLOR="1;32m"
         red='\[\e[0;31m\]'
         green='\[\e[0;32m\]'
         black='\[\e[0;0m\]'
         if [ -n "$INSIDE_EMACS" ] || [ "$TERM" = "eterm" ] || [ "$TERM" = "eterm-color" ]; then
           # Emacs term mode doesn't support xterm title escape sequence (\e]0;)
           PS1="\n\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "
         else
	   . ${pkgs.git}/share/bash-completion/completions/git-prompt.sh
           PS1="\n\[\033[$PROMPT_COLOR\][\[\e]0;\u@\h: \w\a\]\u@\h:\w"'$(__git_ps1 ":%s")'"]\\$\[\033[0m\] "
         fi
         if test "$TERM" = "xterm"; then
           PS1="\[\033]2;\h:\u:\w\007\]$PS1"
         fi
       fi
  '';

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
