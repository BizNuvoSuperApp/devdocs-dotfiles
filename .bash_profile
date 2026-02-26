# User specific environment and startup programs

_checkUpdateNeeded() {
    local dir=$HOME/update-lock-timestamps
    local file=$dir/${1}.tz

    if [[ ! -f $file ]]; then
        mkdir -p $dir
        touch $file
        return 0
    fi

    local timeArg=${2:-1d}
    local time=${timeArg::-1}
    local timeType=${timeArg:(-1)}

    case "$timeType" in
    "m") time=$(($time * 60)) ;;
    "h") time=$(($time * 3600)) ;;
    "d") time=$(($time * 86400)) ;;
    "*") return 1 ;;
    esac

    local currentTime=$(date +%s)
    local fileTime=$(stat -c %Y $file)

    if (($currentTime - $fileTime > $time)); then
        touch $file
        return 0
    fi

    return 1
}

if _checkUpdateNeeded dotfiles; then
    echo "== Updating .dotfiles =="
    (cd $HOME/.dotfiles && git pull)
    tar -cf - -C $HOME/.dotfiles --exclude-backups --exclude-vcs . | tar -xpf - -C $HOME >/dev/null 2>&1
    exec bash -i -l
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

if _checkUpdateNeeded tools; then 
    echo "== Updating CLI tools =="
    winget update JanDeDobbeleer.OhMyPosh eza-community.eza ajeetdsouza.zoxide fzf
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
    if [[ -n $POSH_PROMPT_CUSTOM && -f $POSH_PROMPT_CUSTOM ]]; then
    	eval "$(oh-my-posh init bash --config $POSH_PROMPT_CUSTOM)"
    else
    	eval "$(oh-my-posh init bash --config quick-term)"
    fi
fi

unset -f _checkUpdateNeeded
