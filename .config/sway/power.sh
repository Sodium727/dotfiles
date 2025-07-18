#!/usr/bin/env bash

printf "Lock\nLogout\nSuspend\nReboot\nPoweroff" | \
  tofi --prompt-text="Power Menu" \
       --font /usr/share/fonts/TTF/JetBrainsMonoNerdFont-Regular.ttf \
       --num-results 5 \
       --hint-font false \
       --ascii-input true \
       --width 50% \
       --anchor center \
       --height 333 | \
  while read -r choice; do
    case "$choice" in
      "Lock")     swaylock -i ~/.config/sway/bg/lockscreen.jpg ;;
      "Logout")   swaymsg exit ;;
      "Suspend")  systemctl suspend ;;
      "Reboot")   systemctl reboot ;;
      "Poweroff") systemctl poweroff ;;
    esac
  done

