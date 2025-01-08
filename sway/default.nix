{
  config,
  pkgs,
  lib,
  ...
}:
let
  # Create the xmodmap file with your desired key mappings
  xmodmapLayout = pkgs.writeText "xmodmap-file" ''
    ! Map HJKL to arrows when Right Alt is held
    keycode  43 = h H Left
    keycode  44 = j J Down
    keycode  45 = k K Up
    keycode  46 = l L Right

    ! Set Right Control to act as Backspace
    keycode  37 = BackSpace

    ! Remap Caps Lock to Control
    keycode  66 = Control_L

    ! Disable the original Caps Lock functionality
    remove Lock = Caps_Lock
  '';
in
{
  imports = [
    ./keybindings.nix
    ./kanshi.nix
  ];
  xdg.configFile."sway/backgrounds/cloud.png".source = ./backgrounds/cloud.png;
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.swayfx;

    #TODO: When swayfx is fixed renenable config check
    checkConfig = false;

    extraConfig = ''
      blur_radius 3
      blur_passes 1

      blur enable

      gaps inner 3
      gaps outer 3
      corner_radius 10
      '';

    config = rec {
      terminal = "kitty";
      modifier = "Mod4";
      startup = [
        { command = "obsidian --ozone-platform=wayland --enable-features=UseOzonePlatform"; }
        {
          command = "systemctl --user restart kanshi.service";
          always = true;
        }
        {
          command = "gsettings set org.gnome.desktop.interface cursor-theme default 24";
        }
        {
          command = "gsettings set org.gnome.desktop.interface cursor-size \"64\"" ;
        }

      ];
      bars = [
        {
          position = "top";
          command = "waybar";
        }
      ];
      window.border = -1;
      floating.border = -1;
      output = {
        DP-1 = {
          resolution = "3840x2160@30Hz";
        };
        eDP-1 = {
          scale = "3.5";
          background = "backgrounds/cloud.png fill";
        };
        "Samsung Electric Company U32R59x HNMN703160" = {
          scale = "2.6";
        };
      };
      input = {
        "1739:30383:DELL08AF:00_06CB:76AF_Touchpad" = {
          tap = "enabled";
          dwt = "enabled";
          middle_emulation = "enabled";
          natural_scroll = "enabled";
          tap_button_map = "lrm";
        };
        "1267:10548:ELAN2934:00_04F3:2934" = {
          map_to_output = "eDP-1";
        };
      };
      # TODO: Move this color theming block to it's own module/ flake
      colors = {
        # based on win95 theme from: https://github.com/jefrecantuledesma/.config/blob/main/sway/config_files/windows_95#LL294
        focused = {
          background = "#000080";
          border = "#000080";
          childBorder = "#ffffff";
          indicator = "#000080";
          text = "#ffffff";
        };
        focusedInactive = {
          background = "#c0c0c0";
          border = "#c0c0c0";
          childBorder = "#ffffff";
          indicator = "#c0c0c0";
          text = "#ffffff";
        };
        unfocused = {
          background = "#c0c0c0";
          border = "#c0c0c0";
          childBorder = "#ffffff";
          indicator = "#c0c0c0";
          text = "#ffffff";
        };
        urgent = {
          background = "#000080";
          border = "#000080";
          childBorder = "#000080";
          indicator = "#000080";
          text = "#000080";
        };
        placeholder = {
          background = "#000000";
          border = "#0c0c0c";
          childBorder = "#ffffff";
          indicator = "#000000";
          text = "#ffffff";
        };
        background = "c0c0c0";
      };
      seat = {
        "seat0" = {
          xcursor_theme = "default";
        };
      };
      menu = "${pkgs.tofi}/bin/tofi-drun | xargs swaymsg exec --";

    };
  };
  programs.swaylock = {
    enable = false;
    settings = {
      color = "808080";
    };
  };
  services.swayidle = {
    enable = false;
    timeouts = [
      {
        timeout = 60;
        command = "${pkgs.swaylock}/bin/swaylock -fF";
      }
      {
        timeout = 90;
        command = "${pkgs.systemd}/bin/systemctl suspend";
      }
    ];
  };
  home.packages = [
    pkgs.waybar
    pkgs.kanshi
  ];
  programs.waybar = {
    enable = true;
  };
  services.mako = {
    enable = true;
    sort = "-time";
    font = "monospace 14";
    layer = "overlay";
    width = 300;
    height = 110;
    borderSize = 0;
    borderRadius = 5;
    icons = true;
    maxIconSize = 64;
    defaultTimeout = 5000;
    backgroundColor = "#2e344044";
  };
  home.file.".config/waybar/config".text = ''
     // -*- mode: jsonc -*-
    {
        "ipc": true,
        "id": "bar-0",
        "position": "top", // Waybar position (top|bottom|left|right)
        "spacing": 0, // Gaps between modules (4px)
        // Choose the order of the modules
        "modules-left": [
            "sway/workspaces",
            "sway/mode",
        ],
        "modules-center": [
            "sway/window"
        ],
        "modules-right": [
            "pulseaudio",
            "bluetooth",
            "network",
            "temperature",
            "backlight",
            "battery",
            "tray",
            "clock"
        ],
        // Modules configuration
        "sway/window": {
            "format": "{}",
            "rewrite": {
                "(.*)YouTube(*.)": "$1  ",
                "(.*)— Mozilla Firefox": "🌎 $1",
                "(.*)— Zen Browser": "🌎 $1",
                "(.*)Alacritty": " $1"
            }
        },
        "bluetooth": {
            "format": "{icon}",
            "format-connected": "{device_alias}",
            "format-connected-battery": "{device_alias} {device_battery_percentage}%",
            "format-icons": {
                "enabled": "",
                "disabled": "󰂲"
            },
            "on-click": "blueman-manager",
            //"tooltip": true,
            "tooltip-format": "{device_enumerate}"
        },
        "sway/mode": {
            "format": "<span style=\"italic\">{}</span>"
        },
        "sway/scratchpad": {
            "format": "{icon} {count}",
            "show-empty": false,
            "format-icons": ["", ""],
            "tooltip": true,
            "tooltip-format": "{app}: {title}"
        },
        "mpd": {
            "format": "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ⸨{songPosition}|{queueLength}⸩ {volume}% ",
            "format-disconnected": "Disconnected ",
            "format-stopped": "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ",
            "unknown-tag": "N/A",
            "interval": 5,
            "consume-icons": {
                "on": " "
            },
            "random-icons": {
                "off": "<span color=\"#f53c3c\"></span> ",
                "on": " "
            },
            "repeat-icons": {
                "on": " "
            },
            "single-icons": {
                "on": "1 "
            },
            "state-icons": {
                "paused": "",
                "playing": ""
            },
            "tooltip-format": "MPD (connected)",
            "tooltip-format-disconnected": "MPD (disconnected)"
        },
        "idle_inhibitor": {
            "format": "{icon}",
            "format-icons": {
                "activated": "",
                "deactivated": ""
            }
        },
        "tray": {
            // "icon-size": 21,
            "spacing": 10
        },
        "clock": {
            // "timezone": "America/New_York",
            "tooltip-format": "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>",
            "format-alt": "{:%Y-%m-%d}"
        },
        "cpu": {
            "format": "{usage}% ",
            "tooltip": false
        },
        "memory": {
            "format": "{}% "
        },
        "temperature": {
            "thermal-zone": 2,
            "interval": 30,
            "hwmon-path": "/sys/class/hwmon/hwmon6/temp1_input",
            "critical-threshold": 80,
            "format-critical": "{temperatureC}°C {icon}",
            "format": "{temperatureC}° {icon}",
            "format-icons": ["", "", ""]
        },
        "backlight": {
            "device": "eDP-1",
            "format": "{icon}",
            "format-icons": ["", "", "", "", "", "", "", "", ""]
        },
        "battery": {
            "states": {
                "good": 95,
                "warning": 30,
                "critical": 15
            },
            "format": "{capacity}% {icon}",
            "format-full": "{capacity}% {icon}",
            "format-charging": "{capacity}% {icon}",
            "format-plugged": "{capacity}% ",
            "format-alt": "{time} {icon}",
            "format-icons": [" ", " ", " ", " ", " "]
        },
        "power-profiles-daemon": {
          "format": "{icon}",
          "tooltip-format": "Power profile: {profile}\nDriver: {driver}",
          "tooltip": true,
          "format-icons": {
            "default": "",
            "performance": "",
            "balanced": "",
            "power-saver": ""
          }
        },
        "network": {
            // "interface": "wlp2*", // (Optional) To force the use of this interface
            "format-wifi": "{essid} {icon} ",
            "format-ethernet": "{ipaddr}/{cidr} ",
            "tooltip-format": "{ifname} via {gwaddr} ",
            "format-linked": "{ifname} (No IP) ",
            "format-disconnected": "Disconnected 󰤮",
            "format-alt": "{ifname}: {ipaddr}/{cidr}",
            "format-icons": [
            "󰤟","󰤢","󰤥","󰤨"
        ]
        },
        "pulseaudio": {
            "format": "{volume}% {icon}",
            "format-muted": "󰝟 {format_source}",
            "format-source": "",
            "format-source-muted": "",
            "format-icons": {
                "headphone": "",
                "hands-free": "",
                "headset": "",
                "phone": "",
                "portable": "",
                "car": "",
                "default": ["", "", ""]
            },
            "on-click": "pavucontrol"
        },
    } 
  '';
  # TODO: move to it's own theme module for 'win95'
  home.file.".config/waybar/style.css".text = ''
    * {
        border: none;
        border-radius: 0;
        font-family: "Sans Serif", "Font Awesome 5 Free";
        font-size: medium;
        min-height: 0;
    }

    Window#waybar {
        background: #c0c0c0;
        color: #000000;
        box-shadow: 0px 0px 3px 0px #00000;
        border-bottom: solid 1px #404040;

    }

    #scratchpad {
        padding: 5px 10px;
        margin: 5px 3px;
        background: #c0c0c0;
        color: #000000;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
    }

    #workspaces button {
        padding: 5px 10px;
        margin: 5px 3px;
        background: #c0c0c0;
        color: #000000;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;

    }

    #workspaces button:hover {
        box-shadow: 0px 0px 0px;
        text-shadow: none;
        background: #E0E0E0;
    }

    #workspaces button.focused {
        background: #E0E0E0;
        color: #000000;
    }

    #custom-start {
        padding: 5px 5px;
        margin: 5px 3px;
        font-weight: bold;
        background: url('/home/fribbit/.icons/Chicago95-tux/places/scalable/start-here.svg');
        background-position: left;
        background-repeat: no-repeat;
        background-size: contain;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
    }

    #custom-start:hover {
        background: url('/home/fribbit/.icons/Chicago95-tux/places/scalable/start-here.svg');
        background-position: left;
        background-repeat: no-repeat;
        background-size: contain;
        box-shadow: 0px 0px 0px;
        text-shadow: none;
    }

    #custom-start:active {
        background: url('/home/fribbit/.icons/Chicago95-tux/places/scalable/start-here.svg');
        background-position: left;
        background-repeat: no-repeat;
        background-size: contain;
        box-shadow: 0px 0px 0px;
        text-shadow: none;
        background-color: #f0f0f0;
    }

    #window {
        padding: 5px 10px;
        margin: 5px 3px;
        background-color: #c0c0c0;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
    }

    #battery {
        padding: 5px 5px;
        margin: 5px 3px;
        background-color: #c0c0c0;
        color: #000000;
        font-family: "Sans Serif", "Font Awesome 5 Free";
        font-size: medium;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
        background-image: url('/home/fribbit/.icons/Chicago95-tux/devices/scalable/battery.svg');
        background-position: right;
        background-size: 30%;
        background-repeat: no-repeat;
        background-origin: content-box;
    }

    #bluetooth {
        padding: 5px 5px;
        margin: 5px 3px;
        background-color: #c0c0c0;
        color: #000000;
        font-family: "Sans Serif", "Font Awesome 5 Free";
        font-size: medium;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
        background-image: url('/home/fribbit/.icons/Chicago95-tux/status/scalable/sunny.svg');
        background-position: right;
        background-size: 30%;
        background-repeat: no-repeat;
        background-origin: content-box;
        }

    #tray {
        padding: 5px 5px;
        margin: 5px 3px;
        background-color: #c0c0c0;
        color: #000000;
        font-family: "Sans Serif", "Font Awesome 5 Free";
        font-size: medium;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
    }

    #network {
        padding: 5px 5px;
        margin: 5px 3px;
        background-color: #c0c0c0;
        color: #000000;
        font-family: "Sans Serif", "Font Awesome 5 Free";
        font-size: medium;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
        }

    #backlight {
        padding: 5px 5px;
        margin: 5px 3px;
        background-color: #c0c0c0;
        color: #000000;
        font-family: "Sans Serif", "Font Awesome 5 Free";
        font-size: medium;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
        background-image: url('/home/fribbit/.icons/Chicago95-tux/status/scalable/sunny.svg');
        background-position: right;
        background-size: 30%;
        background-repeat: no-repeat;
        background-origin: content-box;
    }

    #wireplumber {
        padding: 5px 5px;
        margin: 5px 3px;
        background-color: #c0c0c0;
        color: #000000;
        font-family: "Sans Serif", "Font Awesome 5 Free";
        font-size: medium;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
        background-image: url('/home/fribbit/.icons/Chicago95-tux/status/scalable/audio-volume-high.svg');
        background-position: right;
        background-size: 30%;
        background-repeat: no-repeat;
        background-origin: content-box;
    }

    #pulseaudio {
        padding: 5px 5px;
        margin: 5px 3px;
        background-color: #c0c0c0;
        color: #000000;
        font-family: "Sans Serif", "Font Awesome 5 Free";
        font-size: medium;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
        background-image: url('/home/fribbit/.icons/Chicago95-tux/status/scalable/audio-volume-high.svg');
        background-position: right;
        background-size: 30%;
        background-repeat: no-repeat;
        background-origin: content-box;
    }

    #memory {
        padding: 5px 5px;
        margin: 5px 3px;
        background-color: #c0c0c0;
        color: #000000;
        font-family: "Sans Serif", "Font Awesome 5 Free";
        font-size: medium;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
        background-image: url('/home/fribbit/.icons/Chicago95-tux/devices/scalable/computer-laptop.svg');
        background-position: right;
        background-size: 30%;
        background-repeat: no-repeat;
        background-origin: content-box;
    }

    #cpu {
        padding: 5px 5px;
        margin: 5px 3px;
        background-color: #c0c0c0;
        color: #000000;
        font-family: "Sans Serif", "Font Awesome 5 Free";
        font-size: medium;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
        background-image: url('/home/fribbit/.icons/Chicago95-tux/devices/scalable/processor.svg');
        background-position: right;
        background-size: 30%;
        background-repeat: no-repeat;
        background-origin: content-box;
    }

    #temperature {
        padding: 5px 5px;
        margin: 5px 3px;
        background-color: #c0c0c0;
        color: #000000;
        font-family: "Sans Serif", "Font Awesome 5 Free";
        font-size: medium;
        border-left: 1px solid #ffffff;
        border-top: 1px solid #ffffff;
        border-bottom: 1px solid #404040;
        box-shadow: 1px 1px 1px 0px #000000;
        background-image: url('/home/fribbit/.icons/Chicago95-tux/status/scalable/weather-few-clouds.svg');
        background-position: right;
        background-size: 30%;
        background-repeat: no-repeat;
        background-origin: content-box;
    }

    #clock {
        padding: 5px 5px;
        margin: 5px 3px;
        background-color: #b0b0b0;
        color: #000000;
        font-family: "Sans Serif", "Font Awesome 5 Free";
        font-size: medium;
        border-left: 0.5px solid #000000;
        border-top: 1px solid #000000;
        border-bottom: 1px solid #ffffff;
        border-right: 1px solid #ffffff;
        box-shadow: -1px -0.5px 0px 0px #000000;
        background-image: url("/home/fribbit/.icons/Chicago95-tux/apps/scalable/clock.svg");
        background-position: right;
        background-size: 13%;
        background-repeat: no-repeat;
        background-origin: content-box;
    }

    /*#battery button:hover,*/

    /*#pulseaudio:hover {
        background-color: #E0E0E0;
        box-shadow: 0px 0px 0px;
    }*/
  '';
}
