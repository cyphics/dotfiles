#!/bin/bash

pkill polybar

sleep 1;

#export MONITOR=DVI-I-1
#polybar --reload -c ~/.config/polybar/config top &
#polybar --reload -c ~/.config/polybar/config top&
#polybar --reload -c ~/.config/polybar/config bottom&
#exit
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
      MONITOR=$m polybar --reload -c ~/.config/polybar/config top &
      MONITOR=$m polybar --reload -c ~/.config/polybar/config bottom &
  done
else
    polybar --reload i3wmthemer_bar
fi
#polybar i3wmthemer_bar &
