{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./sway
    ./fonts.nix
    ./extras.nix
    ./tmux
    ./youtube.nix
    ./wofi
  ];

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "saketh";
  home.homeDirectory = "/home/saketh";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    obsidian
    tmux
    playerctl
    fira-code
    fira-mono
    dejavu_fonts
    cascadia-code
    xorg.xmodmap

    #vpn
    openvpn
    openconnect
    vpnc

    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Git configuraation
  programs.git = {
    enable = true;
    userName = lib.mkDefault "Saketh Karumuri";
    userEmail = lib.mkDefault "skarumuri1@gmail.com";
  };

  # Alacrity configuration
  programs.alacritty = {
    enable = true;
    settings = {
      selection.save_to_clipboard = true;
      shell.program = "tmux";
      #  font.bold = {
      #    family = "FiraMono";
      #  };
      #  font.bold_italic = {
      #    family = "FiraMono";
      #  };
      #  font.italic = {
      #    family = "FiraMono";
      #  };
      font.size = 12;
      import = [pkgs.alacritty-theme.tokyo_night];
      font.normal = {
        family = "Fira Code";
      };
    };
  };

  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      wake_desk = "wol 18:C0:4D:88:D7:08";
    };
  };

  programs = {
    kitty.enable = true;
    fastfetch.enable = true;
    gh.enable = true;
  };

  nixpkgs.config.allowUnfree = true;
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/saketh/etc/profile.d/hm-session-vars.sh
  #

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
