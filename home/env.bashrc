alias tasks='task sync ; task'

. $(dirname "${BASH_SOURCE[0]}")/git-prompt.sh
red='\[\e[0;31m\]'
green='\[\e[0;32m\]'
black='\[\e[0;0m\]'
PS1="$red[${green}$(hostname)$red]:[${green}\W${red}]"'$(__git_ps1 "\[\e[0;31m\]:[\[\e[0;32m\]%s\[\e[0;31m\]]")'" ${black}$ "
