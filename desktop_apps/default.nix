{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  home.file.".local/share/applications/school-zen.desktop".text = ''
  [Desktop Entry]
  Version=1.0
  Type=Application
  Name=Zen (School)
  Exec=${inputs.zen-browser.packages."x86_64-linux".default}/bin/zen -P school
  Terminal=false
  '';
  home.file.".local/share/applications/wolfram.desktop".text = ''
  [Desktop Entry]
  Version=1.0
  Type=Application
  Name= Wolfram Notebook
  Exec=${pkgs.mathematica}/bin/wolframnb
  Terminal=false
  '';
}
