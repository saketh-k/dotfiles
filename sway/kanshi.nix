
# Home Dock:
# Output DP-2: "LG Electronics LG IPS FULLHD " : 1920x1080
# Output DP-1: 'Samsung Electric Company U32R59x HNMN703160' : 3840x2160
{
  services.kanshi = {
    enable =true;
    #enable sway target for kanshi, this might be wrong
    systemdTarget = "sway-session.target";
    #systemdTarget = "";

    settings = [
      { profile = {
          name = "undocked";
          outputs = [
            { criteria = "eDP-1"; status = "enable";}
          ];
        };
      }
      { profile = {
          name = "sj_home_office";
          outputs = [
            { 
              criteria = "eDP-1";
              status = "disable";
            }
            { 
              criteria = "Samsung Electric Company C24F390 H4ZNA02125";
              status = "enable";
            }
          ];
        };
      }
      { profile = { 
          name = "irvine_home";
          outputs = [
            { 
              criteria = "eDP-1";
              status = "disable";
            }
            # { 
            #   criteria = "Samsung Electric Company U32R59x HNMN703160";
            #   status = "enable";
            #   mode = "3840x2160"; # (67.5 / 40)*1/1.7 = approx 1?
            #   scale = 2.05;
            #   position =  "1920,0";
            # }
            {
              criteria = "Samsung Electric Company LC34G55T HNTX802621";
              scale = 1.0;
              position = "1080,0";
            }
          ];
        };
      }
      {
        profile = {
          name = "irvine_lab";
          outputs = [
            {
              criteria = "eDP-1";
              status = "disable";
            }
            { 
              criteria = "Samsung Electric Company U32R59x HNMN703160";
              status = "enable";
              mode = "3840x2160"; # (67.5 / 40)*1/1.7 = approx 1?
              scale = 2.05;
              position =  "1920,0";
              transform = "normal";
            }
      ];
        };
      }
    ];
  };
}
