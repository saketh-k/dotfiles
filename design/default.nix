{lib, config, pkgs, ...}:
{
  home.packages = with pkgs; [
    #orca-slicer
    dejavu_fonts
    openscad

  ]; }
