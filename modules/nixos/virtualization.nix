{ config, pkgs, lib, ... }:

{
  # Enable virtualisation
  virtualisation.docker = {
    enable = true;
    rootless = {
      enable = true;
      setSocketVariable = true;
      daemon.settings = {
        dns = [ "1.1.1.1" ];
      };
    };
    daemon.settings = {
      dns = [
        "1.1.1.1"
        "8.8.8.8"
      ];
    };
  };

  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "saketh" ];

  environment.systemPackages = with pkgs; [
    virtiofsd
    quickemu
  ];
}
