{ config, pkgs, lib, ... }:

{
  # Bootloader.
  boot.loader = {
    efi = {
      canTouchEfiVariables = true;
    };
    grub = {
      enable = lib.mkDefault true;
      efiSupport = true;
      device = "nodev";
      useOSProber = true;
      gfxpayloadEfi = "keep";
      theme = (
        pkgs.sleek-grub-theme.override {
          withStyle = "dark";
          withBanner = "Select NixOS Generation";
        }
      );
      fontSize = 32;
      configurationLimit = 4;
    };
  };

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
  networking.openconnect.package = pkgs.openconnect;

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.plugins = [ pkgs.networkmanager-openconnect ];
  networking.useDHCP = lib.mkDefault true;
  networking.dhcpcd.enable = false;
  networking.resolvconf.dnsExtensionMechanism = false;
  systemd.network.wait-online.enable = false;
  boot.initrd.systemd.network.wait-online.enable = false;

  # enable resolved
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNSOverTLS = false;
      DNSSEC = false;
      Domains = [ "~." ];
      FallbackDNS = [
        "1.1.1.1"
        "1.0.0.1"
      ];
    };
  };

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";
  # hack for windows being weird with time
  time.hardwareClockInLocalTime = true;

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocales = [ "te_IN/UTF-8" ];

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "te_IN";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "te_IN";
  };

  # Enable flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.extraOptions = ''
    builders-use-substitutes = true
  '';
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";
  nix.buildMachines = [
    {
      hostName = "100.69.224.31";
      system = "x86_64-linux";
      protocol = "ssh-ng";
      sshUser = "remotebuild";
      sshKey = "/root/.ssh/remotebuild";
      maxJobs = 32;
      speedFactor = 2;
      supportedFeatures = [
        "benchmark"
        "big-parallel"
        "kvm"
        "nixos-test"
      ];
      publicHostKey = "bIqsh3BoaFdNdizKcjlYbbz18S6mB5FdXw3gohXqcfI";
    }
  ];
  nix.settings = {
    builders-use-substitutes = true;
  };

  programs.ssh.extraConfig = ''
    Host durga
      HostName durga.saketh.dev
      User root
      Port 22
      IdentitiesOnly yes
      IdentityFile ~/.ssh/id_ed25519
  '';

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Enable Tailscale
  services.tailscale.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.allowUnfreePredicate = _: true;

  environment.systemPackages = with pkgs; [
    vim
    wget
    sleek-grub-theme
    openconnect
  ];

  system.stateVersion = "24.05";
}
