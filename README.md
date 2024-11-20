# Dotfiles

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

## Nix / Home Manager

- install nix if needed
- install home manager
- symlink nixfiles/home.nix
- install https://github.com/nix-community/nixGL

### TODO
Fix symlink / creation instructions


```
rm ~/.config/home-manager/home.nix
# for personal
ln -s ~/dev/dotfiles/nixfiles/personal.nix ~/.config/home-manager/home.nix
# for work
ln -s ~/dev/dotfiles/nixfiles/thescore.nix ~/.config/home-manager/home.nix
```

```
# for nixos - after sourcing the configuration
gsettings reset org.gnome.desktop.input-sources xkb-options
gsettings reset org.gnome.desktop.input-sources sources
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
