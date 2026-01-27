{
  config,
  pkgs,
  zen-browser,
  ...
}:
{
  home.packages = with pkgs; [ 
    vscode
    moonlight-qt
  ];
  xdg.mimeApps.enable = false;
  xdg.mimeApps.defaultApplications = { "application/pdf" = ["sioyek.desktop"];};
}
