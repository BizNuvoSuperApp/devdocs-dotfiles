# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Bash shell settings
# Typing a directory name just by itself will automatically change into that directory.
shopt -s autocd

# Automatically fix directory name typos when changing directory.
shopt -s cdspell

# Automatically expand directory globs and fix directory name typos whilst completing. 
# Note, this works in conjuction with the cdspell option listed above.
shopt -s direxpand dirspell

# Enable the ** globstar recursive pattern in file and directory expansions.
# For example, ls **/*.txt will list all text files in the current directory hierarchy.
shopt -s globstar

# Ignore lines which begin with a <space> and match previous entries.
# Erase duplicate entries in history file.
HISTCONTROL=ignoreboth:erasedups

# Ignore saving short- and other listed commands to the history file.
HISTIGNORE=?:??:history

# The maximum number of lines in the history file.
HISTFILESIZE=99999

# The number of entries to save in the history file.
HISTSIZE=99999

# Set Bash to save each command to history, right after it has been executed.
PROMPT_COMMAND='history -a'

# Save multi-line commands in one history entry.
shopt -s cmdhist

# Append commands to the history file, instead of overwriting it.
# History substitution are not immediately passed to the shell parser.
shopt -s histappend histverify

# Git aliases
alias gs='git status -sb'
alias gcc='git checkout'
alias gcm='git checkout main'
alias gaa='git add --all'
alias gc='git commit -m $2'
alias push='git push'
alias gpo='git push origin'
alias pull='git pull'
alias clone='git clone'
alias stash='git stash'
alias pop='git stash pop'
alias ga='git add'
alias gb='git branch'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias gm='git merge'

# Bash aliases
alias ..='cd ..'
alias ...='cd ../../'

alias ls="command ls $LS_COMMON"

alias l="eza -AF --color=always --git --icons=auto --show-symlinks --ignore-glob 'NTUSER.DAT*|ntuser.dat*|.git'"
alias ll="l --long --header --time-style=long-iso"
alias lls="ll --sort=size"
alias llt="ll --sort=time"
alias tree="ll --tree --level"

alias mkdir='mkdir -p'
alias rm='rm -v'

# Biznuvo aliases
alias cdr="cd c:/repos"
alias cdm="cd c:/repos/biznuvo-server-v2"

alias cdd="cd c:/opt/biznuvo/apps/designer"
alias cdo="cd c:/opt/biznuvo/apps/operations"

alias tfd="tail -F C:/opt/biznuvo/logs/designer/app.log"
alias tfo="tail -F C:/opt/biznuvo/logs/operations/app.log"

alias lfd="less c:/opt/biznuvo/logs/designer/app.log"
alias lfo="less c:/opt/biznuvo/logs/operations/app.log"

alias cdt="cd c:/opt/tomcat"

updatedot () {
    tar -cf - -C ~/.dotfiles --exclude-backups --exclude-vcs . | tar -xpf - -C ~ >/dev/null 2>&1
    exec bash -i -l
}

# ssh-copy-id command doesn't exist on windows, so create a version that will
ssh-copy-id () {
    ssh $1 "mkdir -p ~/.ssh; cat >> ~/.ssh/authorized_keys" < ~/.ssh/id_ed25519.pub
}

# Source user specific aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
