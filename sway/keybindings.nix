{ config, pkgs, lib, ... }:

{
  config.wayland.windowManager.sway.config.keybindings=lib.mkOptionDefault{
    "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
    "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
    "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";
    "XF86MonBrightnessUp" = "exec_always light -A 10";
    "XF86MonBrightnessDown" = "exec_always light -U 10";
    "XF86AudioPlay" = "exec playerctl play-pause";
    "XF86AudioNext" = "exec playerctl next";
    "XF86AudioPrev" = "exec playerctl previous";
    "XF86AudioStop" = "exec playerctl stop";
    "Print" = "exec grim -g \"\$(slurp)\" - | wl-copy";
    "Mod4+Shift+S" = "sticky toggle";
    };
}
