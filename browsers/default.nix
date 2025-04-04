{lib, config, pkgs, ...}:

{
  programs.firefox = {
    enable = false;
    
    profiles.work = {
      settings = {
        "full-screen-api.ignore-widgets" = true;
      };
      userChrome = "";
      isDefault = true;
    };
    
    profiles.school = {
      settings = {
        "full-screen-api.ignore-widgets" = true;
      };
      userChrome = "";
      id = 1;
    };
  };
}
