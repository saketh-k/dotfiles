{
  config,
  pkgs,
  lib,
  ...
}:
# Tofi configuration
{
  xdg.configFile."tofi/config".source = config.lib.file.mkOutOfStoreSymlink /home/saketh/dotfiles/tofi/config;
  programs = {
    tofi = {
      enable = true;
    };
  };
}
