# User specific environment and startup programs

if [[ ! -f ~/.dotfiles.upd ]]; then
    touch ~/.dotfiles.upd
else
    one_day_ago=$(date -d 'now - 1 minute' +%s)
    last_upgrade_time=$(date -r ~/.dotfiles.upd +%s)

    if (( last_upgrade_time <= one_day_ago )); then
        echo "== Updating .dotfiles =="

        cd ~/.dotfiles
        git pull

        tar -cf - -C ~/.dotfiles --exclude-backups --exclude-vcs . | tar -xpf - -C ~ >/dev/null 2>&1

        touch ~/.dotfiles.upd

        exec bash
    fi
fi

if ! which oh-my-posh >/dev/null 2>&1 ; then
    winget install JanDeDobbeleer.OhMyPosh
fi

PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH

LESS="-iR"
export LESS

LS_COMMON="-ksFGh --classify --color=auto --show-control-chars"
LS_COMMON="$LS_COMMON -I NTUSER.DAT\* -I ntuser.dat\* -I ntuser.ini"
export LS_COMMON

# Source the ~/.bashrc file if it exists
if [ -f ~/.bashrc ] ; then
    . ~/.bashrc
fi

if which oh-my-posh >/dev/null 2>&1 ; then
	# free-ukraine, iterm2, powerlevel10k_rainbow, quick-term, slimfat
	eval "$(oh-my-posh init bash --config quick-term)"
fi
