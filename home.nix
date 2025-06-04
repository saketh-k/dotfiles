{
  config,
  lib,
  pkgs,
  ...
}:
{
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
    neovim
    tmux
    playerctl
    xorg.xmodmap
  ];

  xdg.configFile."wezterm/wezterm.lua".source = config.lib.file.mkOutOfStoreSymlink /home/saketh/dotfiles/wezterm.lua;
  #TODO: Switch this to be a non-relative path
  programs = {
    alacritty = {
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

    wezterm = {
      package = pkgs.wezterm;
      enable = true;
      enableBashIntegration = true;
    };

    kitty = {
      enable = true;
      shellIntegration.enableBashIntegration = true;
    };
    fastfetch.enable = true;

    zoxide.enable = true;
    zoxide.enableBashIntegration = true;

    # Version Control tools
    gh.enable = true;
    git = {
      enable = true;
      userName = lib.mkDefault "Saketh Karumuri";
      userEmail = lib.mkDefault "skarumuri1@gmail.com";
    };
  };

  #nixpkgs.config.allowUnfree = true;
  #nixpkgs.config.allowUnfreePredicate = pkg: 
  #  builtins.elem (pkgs.lib.getName pkg) [
  #    "copilot.vim"
  #  ];
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

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
