FROM registry.fedoraproject.org/fedora-toolbox:42

RUN sudo dnf --assumeyes update
RUN sudo dnf --assumeyes install fuse
RUN sudo dnf --assumeyes install fd rg fzf tldr xclip

RUN sudo dnf --assumeyes install elixir
