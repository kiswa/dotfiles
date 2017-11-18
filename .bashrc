#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

complete -cf sudo

alias ls='ls -lh --color=auto --group-directories-first'
alias web='cd ~/Projects/Web/'
alias pacu='pacaur -Syu'
alias rmt='ssh 192.168.2.111'

function parse_git_branch {
    ref=$(git rev-parse --abbrev-ref HEAD 2> /dev/null) || return
    echo -n "("${ref}") "

    stash=$(git stash list 2> /dev/null | wc -l) || return
    if [ "$stash" != "0" ] ; then
        echo "("${stash}") "
    fi
}

# For regular users, this gives a nice two-tone green
PS1='\[\e[1;32m\]\u\[\e[m\]\[\e[0;32m\]@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] $(parse_git_branch)\[\e[1;32m\]\$\[\e[m\] \[\e[0;37m\]'

# For root, this provides a visual difference (two-tone red)
if (( $EUID == 0 )); then
    PS1='\[\e[1;31m\]\u\[\e[m\]\[\e[0;31m\]@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] $(parse_git_branch)\[\e[1;31m\]\$\[\e[m\] \[\e[0;37m\]'
fi

GOPATH="$HOME/.go"
export GOPATH

PATH="$GOPATH/bin:$PATH"

PATH="/usr/bin/core_perl:$PATH"

PATH="`ruby -e 'print Gem.user_dir'`/bin:$PATH"
PATH="$HOME/bin/:$PATH"

export EDITOR="vim"
unset SSH_ASKPASS # Keeps windows from opening when pushing git repo

# On a headless VM, use fbterm to allow 256-color display
#[ -n "$FBTERM" ] && export TERM=fbterm
