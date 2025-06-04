{ config, pkgs,... }:

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
    '';
   };

  home.sessionVariables = {
      EDITOR="nvim";
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
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
