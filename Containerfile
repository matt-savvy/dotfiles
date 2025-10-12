FROM registry.fedoraproject.org/fedora-toolbox:42

RUN sudo dnf --assumeyes update

COPY .zshrc ~/.zshrc
RUN sudo dnf --assumeyes install zsh
RUN sudo dnf --assumeyes install fd rg fzf tldr xclip

RUN sudo dnf --assumeyes install elixir

RUN sudo dnf --assumeyes install neovim

RUN sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
