@echo off

winget update --accept-package-agreements --accept-source-agreements --disable-interactivity \
    7zip.7zip \
    Notepad++.Notepad++ \
    SublimeHQ.SublimeText.4 \
    WinMerge.WinMerge \
    appmakes.Typora \
    PuTTY.PuTTY \
    MikeFarah.yq \
    ajeetdsouza.zoxide \
    charmbracelet.gum \
    eza-community.eza \
    junegunn.fzf \
    sharkdp.fd \
    sxyazi.yazi \
    JanDeDobbeleer.OhMyPosh \
    Microsoft.WindowsTerminal

timeout /t 10
