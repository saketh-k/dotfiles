{ config, pkgs, lib, ... }:

{
  # Define a user account.
  users.users.saketh = {
    isNormalUser = true;
    description = "Saketh k";
    extraGroups = [
      "dialout"
      "networkmanager"
      "wheel"
      "video"
      "docker"
      "input"
      "uinput"
    ];
  };

  users.groups.immich = { };
  users.users.immich.group = "immich";
  users.users.immich.isNormalUser = true;
  users.users.immich.extraGroups = [
    "video"
    "render"
  ];

  # Allow "wheel" group to be trusted-users:
  security.sudo.wheelNeedsPassword = false;
  nix.settings.trusted-users = [ "@wheel" ];

  programs.steam.enable = true;
  programs.wireshark = {
    enable = true;
    package = pkgs.wireshark;
    dumpcap.enable = true;
    usbmon.enable = true;
  };
  users.groups.wireshark.members = [ "saketh" ];

  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "saketh" ];
  };

  # Enable zen browser support for 1password
  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        zen
      '';
      mode = "0755";
    };
  };

  environment.systemPackages = with pkgs; [
    wine
    (lutris.override {
      extraPkgs = pkgs: [
        wine
      ];
    })
  ];
}
