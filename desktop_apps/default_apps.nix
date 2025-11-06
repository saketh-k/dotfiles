{config,pkgs,...}:
{
  xdg.mimeApps.enable = false;
  xdg.mimeApps.defaultApplications = { "application/pdf" = ["sioyek.desktop"];};
}
