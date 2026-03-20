{
  config,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    vscode
    moonlight-qt
    sioyek

  ];
  xdg.mimeApps.enable = false;
  xdg.mimeApps.defaultApplications = {
    "application/pdf" = [ "sioyek.desktop" ];
  };
}
