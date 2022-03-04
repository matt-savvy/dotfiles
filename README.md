# Dotfiles

## Terminal Setup
- terminal
    - settings
        - font: SF Mono reg 14
		- theme: One Dark.terminal
        - advanced: uncheck audible bell
        - window: columns 120, rows 40
	- create new github auth token https://github.com/settings/tokens
		- expiration one year from now
		- scope: repo
	- from dev dir, git clone https://github.com/matt-savvy/dotfiles

### Symlink vimrc
From ~/dev/dotfiles

```
ln -s $(pwd)/.vim/vimrc ~/.vim/vimrc
```

### Symlink .gitconfig and .gitignore
From ~/dev/dotfiles

```
ln -s $(pwd)/git/.gitconfig ~/.gitconfig
ln -s $(pwd)/git/.gitignore ~/.gitignore
```
    - install homebrew
    - install oh-my-zsh
    - add zshrc (if needed)
    - brew install tldr
    - brew install mit-scheme
    - brew install ngrok
    - brew install rg
    - brew install gh
    - install nvm
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
        - nvm install 16 (or latest stable version)
    - install npm-merge-driver
        - npx npm-merge-driver install --global

