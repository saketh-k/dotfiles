{ config, pkgs, ... }:

# Import some common debugging packages often included with busy box separately
# in order to get help commands etc.
{

  imports = [ ./tmux.nix ];

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

  programs.autojump = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

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
    };
    shellAbbrs = {
      hms = "home-manager switch --flake ~/dotfiles";
      snrbs = "sudo nix-rebuild switch --flake ~/nixos-config#fw-server";
    };
    shellInit = ''
      set ZK_NOTEBOOK_DIR /home/saketh/zk
    '';
    binds = {
      "alt-y" = {
        command = "\"y\"";
        repaint = true;
      };
    };
    functions = {
      n = ''
        if test "$argv" = "."
          nvim .
        else set dir (zoxide query -i $argv); and nvim $dir;
        end
      '';
      starship_transient_prompt_func = ''
        set -l last_exit $status
        starship module time
        starship module custom.separator
      '';
      #starship module character --status=$last_exit
    };
    generateCompletions = true;
  };

  home.sessionVariables = {
    EDITOR = "~/.config/nvim/result/bin/nvim";
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableTransience = true;
  };
  home.file.".config/starship.toml".source =
    config.lib.file.mkOutOfStoreSymlink /home/saketh/dotfiles/term/starship.toml;

  programs.ssh = {
    enable = true;
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
        identityAgent = "~/.1password/agent.sock";
        addKeysToAgent = "yes";
      };
    };
    enableDefaultConfig = false;
  };

  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
    options = [ "--cmd cd" ];
    enableFishIntegration = true;
  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    attachExistingSession = true;
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

  # Weird hack for nvim
  xdg.configFile = {
    "nvim/parser" = {
      source =
        let
          parsers = pkgs.symlinkJoin {
            name = "treesitter-parsers";
            paths = pkgs.vimPlugins.nvim-treesitter.withAllGrammars.dependencies;
          };
        in
        "${parsers}/parser";
    };
  };

  home.file.".config/foot/foot.ini".source =
    config.lib.file.mkOutOfStoreSymlink /home/saketh/dotfiles/term/foot.ini;
}
