{
  config,
  pkgs,
  lib,
  ...
}:
# Tofi configuration
{
  programs = {
    tofi = {
      enable = true;
      settings = {
        # font
        font = "JetBrains Mono Medium 10";
      };
    };
  };
}
