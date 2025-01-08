{
  config,
  pkgs,
  lib,
  ...
}:
# Tofi configuration
{
  xdg.configFile."tofi/config".source = config.lib.file.mkOutOfStoreSymlink /home/saketh/dotfiles/tofi/config;
  home.packages = with pkgs; [
    fixedsys-excelsior
  ];
  programs = {
    tofi = {
      enable = true;
    };
  };
}
