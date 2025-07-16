# dotfiles
Configuration files (for Arch Linux).

# Introduction
So uhh... It's simple, just copy everything and put them in the correct directories of your Arch Linux machine.
The goal is to make a functional, performant setup. Thus, there is zero composition (no eyes-candy!).

# Prerequisites
One way to install the all the following stuff is to run the `setup-arch.sh` file included. But read through (and edit) it carefully to make sure it's up to your liking!!
In case you want to install stuff manually...
- [neovim](https://github.com/neovim/neovim) (text editor), uses the [NvChad](https://github.com/NvChad/NvChad) configurations
- [yay](https://github.com/Jguer/yay) (to install stuff from the [AUR](https://aur.archlinux.org/)) (you can also use [paru](https://github.com/Morganamilo/paru))
- [tofi](https://github.com/philj56/tofi) (an app launcher similar to [rofi](https://github.com/davatorium/rofi) and [wofi](https://github.com/SimplyCEO/wofi)) (also used for clipboard display)
- [sway](https://github.com/swaywm/sway) (and swaybg, swaylock, swayidle)
- [cliphist](https://github.com/sentriz/cliphist) (the clipboard manager)
- swaync (notification daemon) + [catppuccin theme](https://github.com/catppuccin/swaync)
- [grim](https://github.com/emersion/grim) and [slurp](https://github.com/emersion/slurp) (take screenshots)
- [alacritty](https://github.com/alacritty/alacritty) (terminal emulator)
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) (need to install [zsh](https://www.zsh.org/) shell first)
- [nnn](https://github.com/jarun/nnn) (TUI file manager)
- [JetBrainsMono](https://github.com/JetBrains/JetBrainsMono), or the [Nerd Font](https://github.com/ryanoasis/nerd-fonts) version.
### Optional
- [fcitx5](https://github.com/fcitx/fcitx5) (for keyboard language)
- [thunar](https://github.com/neilbrown/thunar) (GUI file manager). Use it when drag-drop files is needed

# Usage
Make sure to back up your current configurations.
- Simply copy everything in `.config/` to your own `~/.config` directory.

# Sway keybinds (just read `.config/sway/config` lol)
- The Modifier key (notated as `Mod`) here is the Windows key.

- `Mod` + `Shift` + `S` : Screenshot (choose area, then it goes to clipboard).
- `Mod` + `V`: Open clipboard history (in tofi)
- `Mod` + `E`: Open file manager (thunar)
- `Mod` + `L`: Lock screen (swaylock)
- `Mod` + `T` or `Mod` + `Enter`: Open terminal (alacritty)
- `Mod` + `Space`: Open app launcher (tofi-drun)

# Wallpaper
To change backgrounds, edit `.config/sway/config`, at a line which may look like:
```
output * bg /home/dat/.config/sway/bg/wallpaper.jpg fill
```
Or use [swaybg](https://github.com/swaywm/swaybg)
The procedure is similar if you want to change lock screen background (edit all the lines in `.config/sway/config` that contains the `swaylock` command)

# The `setup-arch.sh` script
It is meant for personal use, though you can always give it a run (make sure to read it carefully). It is recommended to run it on a fresh installation of Arch Linux.
