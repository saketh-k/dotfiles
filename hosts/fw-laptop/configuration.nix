{ config, pkgs, lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../services
    ../../modules
    ../../modules/nixos/core.nix
    ../../modules/nixos/desktop.nix
    ../../modules/nixos/hardware.nix
    ../../modules/nixos/virtualization.nix
    ../../modules/nixos/users.nix
  ];

  networking.hostName = "fw-laptop";
}
