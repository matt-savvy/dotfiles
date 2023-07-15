if empty(glob('~/.vim/autoload/plug.vim'))
  echo "bootstrapping vim-plug;"
  silent !sh -c 'mkdir -p ~/.vim/autoload/'
  silent !sh -c '
    \ curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source ~/dev/dotfiles/nvim/init.lua
  silent !sh -c 'touch -f ~/.vim/autoload/plug.vim'
endif
