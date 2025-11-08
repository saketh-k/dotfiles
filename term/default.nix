{ config, pkgs,lib,... }:

# Import some common debugging packages often included with busy box separately
# in order to get help commands etc.
{
  home.packages = with pkgs; [
    blesh
    unzip
    pkgs.nix-output-monitor
    pkgs.nh
    colorls
    just
    evil-helix
    usbutils
    gparted
    pciutils
    dust
    gitui
  ];

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      wake_desk = "wol 18:C0:4D:88:D7:08"; # Wake up my desktop
      hms = "home-manager switch --flake ~/dotfiles";
      nvim = "/home/saketh/.config/nvim/result/bin/nvim";
      vim = "/home/saketh/.config/nvim/result/bin/nvim";
    };
    initExtra = ''
      ZK_NOTEBOOK_DIR="/home/saketh/zk/"
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
    then
      shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
    fi
    '';
   };

  programs.fish = {
    enable = true;
    shellAliases = {
      nvim = "/home/saketh/.config/nvim/result/bin/nvim";
      vim = "/home/saketh/.config/nvim/result/bin/nvim";
      n = "/home/saketh/.config/nvim/result/bin/nvim";
    };
    shellAbbrs = {
      hms = "home-manager switch --flake ~/dotfiles";
    };
    binds = {
      "alt-y".command = "\"y\"";
    };
  };

  home.sessionVariables = {
      EDITOR="nvim";
  };

  xdg.configFile."wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink /home/saketh/dotfiles/term/wezterm.lua;

  programs.alacritty = {
      enable = lib.mkDefault true;
      settings = {
        selection.save_to_clipboard = true;
        shell.program = "tmux";
        font.size = 12;
        font.normal = {
          family = "Fira Code";
        };
      };
    };

  programs.wezterm = {
    package = pkgs.wezterm;
    enable = true;
    enableBashIntegration = true;

  };

  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = true;
  };
  programs.fastfetch.enable = true;

  programs.ssh = {
    enable = true;
    enableDefaultConfig = false;
    matchBlocks = {
      "rel" = {
        host = "rel";
        hostname = "robotecologymain.ts.saketh.dev";
        user = "robotecologymain";
        forwardAgent = true;
        forwardX11 = true;
        forwardX11Trusted = true;
      };
      "ubnt_home" = {
        host = "ubnt_home";
        hostname = "100.94.160.151";
        user = "saketh";
      };
      "uci_hpc" = {
        host = "uci_hpc";
        hostname = "hpc3.rcic.uci.edu";
        user = "skarumur";
        forwardAgent = true;
        forwardX11 = true;
        forwardX11Trusted = true;
      };
      "win_home" = {
        host = "win_home";
        hostname = "desktop";
        user = "skaru";
        forwardAgent = true;
        forwardX11 = true;
        forwardX11Trusted = true;
      };
      "*" = {
        addKeysToAgent="yes";
      };
    };
    extraConfig = ''
    Host *
        IdentityAgent ~/.1password/agent.sock
      '';
    };

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    shellWrapperName = "y";

    settings = {
      manager = {
        show_hidden = true;
      };
    };
  };
}
