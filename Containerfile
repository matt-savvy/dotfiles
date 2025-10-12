FROM registry.fedoraproject.org/fedora-toolbox:42

RUN sudo dnf --assumeyes update

COPY .zshrc ~/.zshrc
RUN sudo dnf --assumeyes install zsh
RUN sudo dnf --assumeyes install fd rg fzf tldr xclip
RUN sudo dnf --assumeyes install kitty
RUN sudo dnf --assumeyes install fuse fuse-libs libglvnd-egl libglvnd-opengl libglvnd-glx harfbuzz fontconfig fribidi libthai libappindicator-gtk3

RUN curl -L -o devpod "https://github.com/loft-sh/devpod/releases/latest/download/devpod-linux-amd64" && sudo install -c -m 0755 devpod /usr/local/bin && rm -f devpod

RUN sudo dnf --assumeyes install elixir

RUN sudo dnf --assumeyes install neovim

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
