{
  config,
  lib,
  pkgs,
  ...
}:

# ============================================================
#  nginx reverse proxy  +  Tailscale  +  HTTPS (Let's Encrypt)
# ============================================================
#
#  How it works
#  ────────────
#  1. Tailscale brings this host into your tailnet and (optionally)
#     enables MagicDNS so you get a stable *.ts.net hostname.
#  2. ACME / Let's Encrypt issues a TLS certificate for that hostname
#     using the Tailscale DNS-01 challenge provider (tsnet) — no
#     open port 80 needed.
#  3. nginx listens on 443 (HTTPS) and proxies upstream services.
#
#  Quick start
#  ───────────
#  1. Set the variables in the "CONFIG — edit these" section.
#  2. Add this file to your NixOS configuration:
#       imports = [ ./nginx-tailscale-proxy.nix ];
#  3. nixos-rebuild switch
#  4. Authenticate Tailscale:  sudo tailscale up
#
#  Requirements
#  ────────────
#  • NixOS 24.05 +
#  • Tailscale account with MagicDNS + HTTPS enabled in the admin panel
#    (Settings → DNS → Enable HTTPS Certificates)
# ============================================================

let
  # ──────────────────────────────────────────────────────────
  #  CONFIG — edit these
  # ──────────────────────────────────────────────────────────

  # Your Tailscale MagicDNS hostname, e.g. "myhost.tail1234.ts.net"
  # Run `tailscale status` after `tailscale up` to find it.
  tailscaleHostname = "fw-laptop-backup-drive.tapir-bleak.ts.net";

  # ──────────────────────────────────────────────────────────
  #  END CONFIG
  # ──────────────────────────────────────────────────────────

in
{
  # Open the Tailscale UDP port in the firewall
  networking.firewall = {
    # Allow Tailscale traffic
    allowedUDPPorts = [ config.services.tailscale.port ];
    # Allow HTTPS only on the Tailscale interface (tsX)
    # Remove "tailscale0" restriction if you also want LAN/WAN access.
    interfaces.tailscale0.allowedTCPPorts = [ 443 ];
    # If you DO want WAN HTTPS too, use:
    # allowedTCPPorts = [ 443 ];
  };

  # ── nginx ────────────────────────────────────────────────
  security.acme = {
    acceptTerms = true;
    defaults.email = "me@saketh.dev";
  };
  services.nginx = {
    enable = true;
    # recommendedOptimisation = true;
    # recommendedGzipSettings = true;
    # recommendedProxySettings = true;
    virtualHosts = {
      "${tailscaleHostname}" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          extraConfig = ''
            default_type text/html
            200 '<html><body>It works</body></html>'
          '';
        };
      };
    };

  };
}
