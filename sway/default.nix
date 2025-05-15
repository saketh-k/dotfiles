{
  config,
  pkgs,
  pkgs-unstable,
  lib,
  ...
}:
{
  imports = [
    ./keybindings.nix
    ./kanshi.nix
    ./hyprlock.nix
  ];
  xdg.configFile."sway/backgrounds/cloud.png".source = ./backgrounds/cloud.png;
  xdg.configFile."sway/backgrounds/forest.png".source = ./backgrounds/forest.png;
  wayland.windowManager.sway = {
    enable = true;
    package = pkgs-unstable.swayfx;

    #TODO: When swayfx is fixed renenable config check
    checkConfig = false;

    extraConfig = ''
      blur_radius 3
      blur_passes 1

      blur enable

      gaps inner 3
      gaps outer 3
      corner_radius 10
      smart_borders on
      for_window [class=".*"] border none
      '';

    config = {
      terminal = "wezterm";
      modifier = "Mod4";
      startup = [
        #{ command = "obsidian --ozone-platform=wayland --enable-features=UseOzonePlatform"; }
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
          mode = "invisible";
        }
      ];
      window.border = 0;
      floating.border = 0;
      output = {
        DP-1 = {
          resolution = "3840x2160@30Hz";
          background = "backgrounds/forest.png fill";
        };
        eDP-1 = {
          scale = "2";
          adaptive_sync = "enable"; background = "backgrounds/forest.png fill";
        };
        "Samsung Electric Company U32R59x HNMN703160" = {
          background = "backgrounds/forest.png fill";
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
    focused = {
        background = "#2e3440";  
        border = "#81a1c1";     
        childBorder = "#eceff4";
        indicator = "#81a1c1"; 
        text = "#eceff4";     
    };
    focusedInactive = {
        background = "#3b4252"; 
        border = "#5e81ac";    
        childBorder = "#d8dee9";
        indicator = "#5e81ac"; 
        text = "#d8dee9";     
    };
    unfocused = {
        background = "#3b4252";
        border = "#5e81ac";   
        childBorder = "#d8dee9";
        indicator = "#5e81ac"; 
        text = "#d8dee9";     
    };
    urgent = {
        background = "#bf616a";
        border = "#bf616a";   
        childBorder = "#bf616a";
        indicator = "#bf616a"; 
        text = "#ffffff";     
    };
    placeholder = {
        background = "#2e3440";
        border = "#4c566a";   
        childBorder = "#eceff4"; 
        indicator = "#4c566a";  
        text = "#eceff4";      
    };
    background = "#d8dee9";  
};
      seat = {
        "seat0" = {
          xcursor_theme = "default";
        };
      };
      menu = "${pkgs.tofi}/bin/tofi-drun | xargs swaymsg exec --";

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
    settings = {
    sort = "-time";
    font = "monospace 14";
    layer = "overlay";
    width = 300;
    height = 110;
    border-size = 0;
    border-radius = 5;
    icons = true;
    max-icon-size = 64;
    default-timeout = 5000;
    background-color = "#2e344044"; };
  };
  home.file.".config/waybar/style.css".source = config.lib.file.mkOutOfStoreSymlink /home/saketh/dotfiles/sway/waybar/style.css;
  home.file.".config/waybar/config".source = config.lib.file.mkOutOfStoreSymlink /home/saketh/dotfiles/sway/waybar/config;
}
