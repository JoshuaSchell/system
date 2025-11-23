{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    #---Editors---
    helix
    neovim
    vim

    #---Dev Tools---
    bun
    go
    lazydocker
    lazygit
    ollama
    pixi
    pnpm
    ripgrep
    rustup

    #---LSPs---
    cmake-language-server
    gopls
    lua-language-server
    nixd
    lldb

    #---System---
    bat
    btop
    cmake
    eza
    fastfetch
    fd
    fzf
    jupyter
    oh-my-posh
    opencode

    #---VCS---
    gh
    git
  ];
}
