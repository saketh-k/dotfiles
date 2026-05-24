{config, pkgs,lib,...}:
{
  programs.waybar = {
    enable = true;
    style = lib.mkAfter (lib.readFile ./waybar/style.css);
  };
}
