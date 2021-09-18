# Hummerspoon window resize setting
[Hammerspoon](http://www.hammerspoon.org/)

## How to
1. Install [Hammerspoon](http://www.hammerspoon.org/)
2. Clone this repository anywhere you want.
3. Check init.lua and change it as need.
4. Run `symlink.sh`. It will make symlink to `~/.hammerspoon/init.lua`
5. Run Hammerspoon (or click [Reload Config] on Hammerspoon window).

## Example of settings in init.lua
- `ctrl + option + ←` : Bring the focused window to the left half of the screen.
- `ctrl + option + →` : Bring the focused window to the right half of the screen.
- `ctrl + option + ↑` : Bring the focused window to the top half of the screen.
- `ctrl + option + ↓` : Bring the focused window to the down half of the screen.
- `ctrl + option + return` : Maximize the size of the focused window.

## Motivation
I am trying to reproduce the key binding for screen resizing that [magnet.app](https://magnet.crowdcafe.com/) can do for mac user.