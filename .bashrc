#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

complete -cf sudo

alias ls='ls --color=auto'
PS1='\[\e[1;32m\]\u\[\e[m\]\[\e[0;32m\]@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[0;37m\]'
# For root, use this so there is a visual difference
# PS1='\[\e[1;31m\]\u\[\e[m\]\[\e[0;31m\]@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;31m\]\$\[\e[m\] \[\e[0;37m\]'

HOME="$(getent passwd $USER | awk -F ':' '{print $6}')"

PATH="`ruby -e 'print Gem.user_dir'`/bin:$PATH"
PATH="$HOME/bin/:$PATH"

EDITOR="/usr/bin/vim"
unset SSH_ASKPASS # Keeps windows from opening when pushing git repo

# On a headless VM, use fbterm to allow 256-color display
#[ -n "$FBTERM" ] && export TERM=fbterm
