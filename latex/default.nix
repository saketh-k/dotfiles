{lib, config, pkgs, ...}:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-medium
      amsmath cancel texlive-scripts;
  });
in
{
  home.packages = with pkgs; [
  tex
  sioyek
  ];
}
