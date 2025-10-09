# Dotfiles

## Fedora

- gnome-tweaks
    - caps lock to ctrl
    - touchpad natural scroll direction

- nvim
    - download appimage, chmod u+x and move to ~/.local/bin/nvim
    - plugins
        - mkdir ~/.local/share/nvim/site/pack
        - cd ~/.local/share/nvim/site/pack
        mkdir vim-better-whitespace && git clone git@github.com:ntpeters/vim-better-whitespace vim-better-whitespace/start/vim-better-whitespace
        mkdir plenary && git clone git@github.com:nvim-lua/plenary.nvim plenary/start/plenary
        mkdir telescope && git clone git@github.com:nvim-telescope/telescope.nvim telescope/start/telescope
        mkdir telescope-fzy-native && git clone git@github.com:nvim-telescope/telescope-fzy-native.nvim telescope-fzy-native/start/telescope-fzy-native
            - cd deps/fzy-lua-native
            - git submodule init
            - git submodule update

        mkdir vim-elixir && git clone git@github.com:elixir-editors/vim-elixir vim-elixir/start/vim-elixir
        mkdir nightfox && git clone git@github.com:EdenEast/nightfox.nvim nightfox/start/nightfox

        mkdir vim-grepper && git clone git@github.com:mhinz/vim-grepper vim-grepper/start/vim-grepper

        mkdir vim-surround && git clone git@github.com:tpope/vim-surround vim-surround/start/vim-surround
        mkdir vim-repeat && git clone git@github.com:tpope/vim-repeat vim-repeat/start/vim-repeat
        mkdir vim-fugitive && git clone git@github.com:tpope/vim-fugitive vim-fugitive/start/vim-fugitive

    - setup LSP
        - elixir-ls needs to be installed elsewhere.

        # TODO update this path
        mkdir -p elixir-ls/start/elixir-ls && wget https://github.com/elixir-lsp/elixir-ls/releases/download/v0.29.3/elixir-ls-v0.29.3.zip && \
            unzip elixir-ls-v0.29.3.zip -d elixir-ls && rm elixir-ls-v0.29.3.zip

        wget https://github.com/elixir-lang/expert/releases/download/nightly/expert_linux_amd64 && chmod u+x expert_linux_amd64 && mv expert_linux_amd64 expert

      # Quickstart configs for Nvim LSP
      nvim-lspconfig


- ssh-key

### flatpaks

- brave
- gnome-tweaks




## Terminal Setup
- terminal
    - settings
        - font: SF Mono reg 14
		- theme: One Dark.terminal
        - advanced: uncheck audible bell
        - window: columns 120, rows 40
	- create new github auth token (classic token) https://github.com/settings/tokens
		- expiration one year from now
		- scope: repo, user:read
        - git push, enter username, paste token as password
	- from dev dir, git clone https://github.com/matt-savvy/dotfiles

- gnome keyboard shortcuts
    - launchers
        - disable super+T
    - custom shortcuts
        - add kitty as shortcut
            nixGL kitty

## Nix Configs

### For NixOS

```sh
$ mkdir ~/dev && cd ~/dev
$ nix-shell -p git vim
[nix-shell ...] $ git clone https://github.com/matt-savvy/dotfiles
# $HOSTNAME thinkpad-x13 or thinkpad-x260
$ sudo nixos-rebuild switch --flake ~/dev/dotfiles/nixfiles#$HOSTNAME --verbose --show-trace
```

Then, after after sourcing the configuration:

```sh
gsettings reset org.gnome.desktop.input-sources xkb-options
gsettings reset org.gnome.desktop.input-sources sources
```

Reboot.

### For Home Manager Only

- install nix

```sh
# initial generation
nix run --extra-experimental-features nix-command --extra-experimental-features flakes home-manager/release-25.05 -- switch --flake ~/dev/dotfiles/nixfiles

# future generations no longer need the flags
home-manager switch --flake ~/dev/dotfiles/nixfiles
```

Periodically run
```sh
nix-env --delete-generations +5
nix-collect-garbage
```

## Misc
Add custom author gitconfig for work projects if needed. E.g.

```
git config --local user.name "Matt Savoia"
git config --local user.email matt@work.com
```

- install ngrok
    - `NIXPKGS_ALLOW_UNFREE=1 nix-env -iA nixpkgs.ngrok`


## Mac Setup (misc)
- create ~/dev dir

- settings

```
       > trackpad > uncheck scroll direction: natural
                  > uncheck force click and haptic feedback
	   > keyboard > map caps lock to ctrl
	   > general > appearance > auto
	   > show scrollbars always
	   > desktop > montery graphic (auto)
           > screensaver > disable
	> dock
		> automatically hide dock
		> uncheck show recent apps in Dock
	> menubar / control center
		> show wifi
		> show bluetooth
		> show airdrop
		> focus when active
		> screen mirroring when active
		> display when active
		> uncheck sound
		> uncheck now playing
		> battery show percentage
		> clock use 24hr clock
		> uncheck spotlight
    > spotlight
        > uncheck all but applications
    > notifications
        > uncheck all but brave, calendar
            > calendar: allow time sensitive alerts
        > do not allow when the display is sleeping
        > do not disturb > add app : calendar, do not share focus status
    > internet accounts
        >
    > security
        > require password immediately
    > sound
        > uncheck play sound
        > uncheck play interface effects
        > reduce alert volume to 50%
    > keyboard
        > text
            > remove omw
            > uncheck spelling
            > uncheck caps
            > uncheck period double space
            > uncheck smart quotes
        > disable dictation
    > sharing
        > enable file sharing for public folder
> messages
    > sign out
> face time
    > sign out

> widgets
    > clear all
```

- show hidden files in finder
```
defaults write com.apple.Finder AppleShowAllFiles true
killall Finder
```

- download brave
	- set as default browser
	- enter sync chain
		- bookmarks, extensions, history, settings, addresses
	- login to bitwarden


- install livereload
    https://apps.apple.com/us/app/livereload/id482898991?mt=12
- install bitwarden
    https://apps.apple.com/app/bitwarden/id1352778147
- install firefox
    - settings
        - disable shortcuts, pocket, recent activity
- install spotify
    - settings
        - disable autoplay
        - disable show announcements for new releases
        - disable see what your friends are playing
- install marp
    - https://marp.app/
- install VLC
- clear everything from dock except finder, terminal, brave, spotify, calendar
    - remove downloads folder, may need to have something in it

- use `colima start` to fire up the colima/docker daemon
