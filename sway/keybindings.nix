{ config, pkgs, lib, ... }:
let
  modifier = config.wayland.windowManager.sway.config.modifier;


in {
  config.wayland.windowManager.sway.config.keybindings=lib.mkOptionDefault{
    
    # Volume CTL
    "XF86AudioRaiseVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ +5%";
    "XF86AudioLowerVolume" = "exec --no-startup-id pactl set-sink-volume @DEFAULT_SINK@ -5%";
    "XF86AudioMute" = "exec --no-startup-id pactl set-sink-mute @DEFAULT_SINK@ toggle";

    # Brightness CTL
    "XF86MonBrightnessUp" = "exec_always light -A 10";
    "XF86MonBrightnessDown" = "exec_always light -U 10";

    # Music CTL
    "XF86AudioPlay" = "exec playerctl play-pause";
    "XF86AudioNext" = "exec playerctl next";
    "XF86AudioPrev" = "exec playerctl previous";
    "XF86AudioStop" = "exec playerctl stop";
    
    # Screenshot
    "Print" = "exec grim -g \"\$(slurp)\" - | wl-copy";

    # Sticky
    "${modifier}+Shift+S" = "sticky toggle";
    };
}
