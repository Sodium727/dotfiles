# dotfiles
Configuration files (of an Arch Linux user).

# Introduction
So uhh... It's simple, just copy everything and put them in the correct directories of your Linux machine.
The goal is to make a functional yet responsive setup. Thus, there is zero composition.

# Prerequisites
- [yay](https://github.com/Jguer/yay) (to install stuff from the [AUR](https://aur.archlinux.org/)) (you can also use [paru](https://github.com/Morganamilo/paru), or build packages from source)
- [tofi](https://github.com/philj56/tofi) (an app launcher similar to [rofi](https://github.com/davatorium/rofi) and [wofi](https://github.com/SimplyCEO/wofi)) (also used for clipboard display)
- [sway](https://github.com/swaywm/sway) (and swaybg, swaylock, swayidle)
- [cliphist](https://github.com/sentriz/cliphist) (the clipboard manager)
- [mako](https://github.com/emersion/mako) (notification deamon)
- [grim](https://github.com/emersion/grim) and [slurp](https://github.com/emersion/slurp) (take screenshots)
- [alacritty](https://github.com/alacritty/alacritty) (terminal)
- [ohmyzsh](https://github.com/ohmyzsh/ohmyzsh) (need to install [zsh](https://www.zsh.org/) shell first)
- [thunar](https://github.com/neilbrown/thunar) (file manager) (currently it's the fastest one I could find)
### Optional
- [waybar](https://github.com/Alexays/Waybar) is optional. Personally I'm comfortable with the status bar Sway provides.
- [fcitx5](https://github.com/fcitx/fcitx5) (for keyboard language)

# Usage
Make sure to back up your current configurations.
- Simply copy everything in `.config/` to your own `~/.config` directory.
- For the `.zshrc`, put it in your home directory `~`

# Keybinds (just read `.config/sway/config` lol)
- The Modifier key (notated as `Mod`) here is the Windows key.

- `Mod` + `Shift` + `S` : Screenshot (choose area, then it goes to clipboard).
- `Mod` + `V`: Open clipboard history (in tofi)
- `Mod` + `E`: Open file manager (thunar)
- `Mod` + `L`: Lock screen (swaylock)
- `Mod` + `T` or `Mod` + `Enter`: Open terminal (alacritty)
- `Mod` + `A`: Open app launcher (tofi-drun)

# Wallpaper
To change it, maybe use [waypaper](https://github.com/anufrievroman/waypaper), or edit the 34th line in `.config/sway/config`, which looks like:
```
output * bg /home/dat/.config/sway/pics/rapi.png fill
```
The procedure is similar if you want to change lock screen background (edit all the lines in `.config/sway/config` that contains the `swaylock` command)

- The rest is just Sway's default keybindinds.

# Neovim
- You might want to run `:Lazy sync` in the first run.
- This setup is copied from various places, and sometimes is buggy/annoying. If possible, maybe contribute your own Neovim configs (lol)?

# SDDM theme.
For the sddm theme (`sddm/sodium-sddm`):
- Copy/move it to `/usr/share/sddm/themes` (you need to install [sddm](https://github.com/sddm/sddm) first for that directory to be generated).
- Append the following content in `/etc/sddm.conf`:
```
[Theme]
  Current=sodium-sddm
