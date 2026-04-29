#!/bin/bash
sleep 1
wl-mirror eDP-1 &
sleep 2
/usr/bin/swaymsg '[app_id="at.yrlf.wl_mirror"] move output HDMI-A-1'
/usr/bin/swaymsg '[app_id="at.yrlf.wl_mirror"] fullscreen enable'
