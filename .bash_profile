# User specific environment and startup programs

if [[ ! -f $HOME/.config/bash-updates/dotfiles.upd ]]; then
    mkdir -p $HOME/.config/bash-updates
    touch $HOME/.config/bash-updates/dotfiles.upd
else
    before_time=$(date -d 'now - 1 day' +%s)
    last_upgrade_time=$(date -r $HOME/.config/bash-updates/dotfiles.upd +%s)

    if (( last_upgrade_time <= before_time )); then
        echo "== Updating .dotfiles =="

        (cd $HOME/.dotfiles && git pull)

        tar -cf - -C $HOME/.dotfiles --exclude-backups --exclude-vcs . | tar -xpf - -C $HOME >/dev/null 2>&1

        touch $HOME/.config/bash-updates/dotfiles.upd

        exec bash -i -l
    fi
fi

if ! which oh-my-posh >/dev/null 2>&1 ; then
    winget install JanDeDobbeleer.OhMyPosh
fi

if ! which eza >/dev/null 2>&1 ; then
	winget install eza-community.eza
fi

if ! which z >/dev/null 2>&1 ; then
    winget install ajeetdsouza.zoxide
fi

if ! which fzf >/dev/null 2>&1 ; then
    winget install fzf
fi

if [[ ! -f $HOME/.config/bash-updates/tools.upd ]]; then
    mkdir -p $HOME/.config/bash-updates
    touch $HOME/.config/bash-updates/tools.upd
else
    before_time=$(date -d 'now - 7 day' +%s)
    last_upgrade_time=$(date -r $HOME/.config/bash-updates/tools.upd +%s)

    if (( last_upgrade_time <= before_time )); then
        echo "== Updating CLI tools =="
        winget update JanDeDobbeleer.OhMyPosh eza-community.eza ajeetdsouza.zoxide fzf
        touch $HOME/.config/bash-updates/tools.upd
    fi
fi

##

PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH

LESS="-iR"
export LESS

LS_COMMON="-kFGhA --classify --color=auto --show-control-chars"
LS_COMMON="$LS_COMMON -I NTUSER.DAT\* -I ntuser.dat\* -I ntuser.ini"
export LS_COMMON

# Source $HOME/.bash_user for custom setup that for user specific stuff
if [[ -f $HOME/.bash_user ]]; then
    . $HOME/.bash_user
fi

# Source the $HOME/.bashrc file if it exists
if [[ -f $HOME/.bashrc ]]; then
    . $HOME/.bashrc
fi

if which zoxide >/dev/null 2>&1 ; then
    eval "$(zoxide init --cmd cd bash)"
fi

if which oh-my-posh >/dev/null 2>&1 ; then
    if [[ -f $HOME/.config/quick-term-custom.json ]]; then
        # this version adds hostname to the prompt
    	eval "$(oh-my-posh init bash --config $HOME/.config/quick-term-custom.json)"
    else
    	eval "$(oh-my-posh init bash --config quick-term)"
    fi
fi
