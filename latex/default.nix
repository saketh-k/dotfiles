{lib, config, pkgs, ...}:

{
  home.packages = with pkgs; [
  texLiveMedium
  sioyek
  ];
}
