PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH

LESS="-iR"
export LESS

LS_COMMON="-kFGhA --classify --color=auto --show-control-chars"
LS_COMMON="$LS_COMMON -I NTUSER.DAT\* -I ntuser.dat\* -I ntuser.ini"
export LS_COMMON

if chk-update dotfiles; then
    printf "== Updating .dotfiles ==\n"
    (cd $HOME/.dotfiles && git pull)
    tar -cf - -C $HOME/.dotfiles --exclude-backups --exclude-vcs . | tar -xpf - -C $HOME >/dev/null 2>&1
    chk-update -u dotfiles
    exec bash -i -l
fi

chk-winget JanDeDobbeleer.OhMyPosh oh-my-posh
chk-winget sxyazi.yazi yazi
chk-winget eza-community.eza eza
chk-winget ajeetdsouza.zoxide zoxide
chk-winget junegunn.fzf fzf
chk-winget sharkdp.fd fd

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
