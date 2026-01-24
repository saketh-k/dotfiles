{ config, pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    base16-schemes
  ];
  stylix.enable = true;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";
  stylix.autoEnable = true;
  stylix.targets.yazi.colors.enable = true;
  stylix.targets.zellij.colors.enable = true;
  stylix.targets.gtk.colors.enable = true;
  stylix.targets.gitui.colors.enable = true;
  stylix.targets.tofi.colors.enable = true;
  stylix.targets.wofi.colors.enable = true;
  # stylix.targets.waybar.fonts.enable = false;
  stylix.targets.waybar = {
    addCss = false;
  };
  stylix.targets.starship.colors.enable = false;
  stylix.targets.mako.fonts.enable = false;
  stylix.targets.sway.enable = false;
  stylix.targets.alacritty.fonts.enable = false;
  stylix.targets.hyprlock.enable = false;
  stylix.targets.spotify-player.enable = false;

}
