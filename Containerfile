FROM registry.fedoraproject.org/fedora-toolbox:42

RUN sudo dnf --assumeyes update

RUN sudo dnf --assumeyes install zsh
RUN sudo dnf --assumeyes install fd rg fzf tldr xclip
RUN sudo dnf --assumeyes install kitty
RUN sudo dnf --assumeyes install fuse fuse-libs libglvnd-egl libglvnd-opengl libglvnd-glx harfbuzz fontconfig fribidi libthai libappindicator-gtk3

RUN sudo dnf --assumeyes install elixir
RUN sudo dnf --assumeyes install caddy

RUN sudo dnf --assumeyes install neovim
