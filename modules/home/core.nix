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

  home.stateVersion = "24.05"; # Please read the comment before changing.

  home.packages = with pkgs; [
    neovim
    playerctl
    xorg.xmodmap
    zoom-us
    zk
    agenix-cli
    gcr
  ];

  age = {
  };

  services.gnome-keyring.enable = true;

  programs = {
    # Version Control tools
    gh.enable = true;
    git = {
      enable = true;
      settings.user = {
        name = "Saketh Karumuri";
        email = "skarumur@uci.edu";
      };
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
