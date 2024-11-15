{
  config,
  pkgs,
  ...
}:
let
  tokyo-night-theme = pkgs.tmuxPlugins.mkTmuxPlugin 
    {
      name = "tmux-tokyo-night";
      pluginName = "tmux-tokyo-night";
      src = pkgs.fetchFromGitHub {
        owner = "saketh-k";
        repo = "tmuxTokyoNight";
        rev = "3710b80caf309b3ed0fb7615ae868d6c109b0ad6";
        sha256 = "sha256-NTAXXXJ/B2FoQVlmtWmrVtf9EjO7BcaCFYPGRoculDE=";
      };
    };
in
{
  programs.tmux = {
    enable = true;
    mouse = true;
    baseIndex = 1;
    terminal = "tmux-256color";
    prefix = "C-space";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      vim-tmux-navigator
      #nord
      {
        plugin = tokyo-night-theme;
        extraConfig = ''
            set -g @theme_right_separator ''
            set -g @theme_left_separator ''
          '';
      }
      jump
      resurrect
      battery
      better-mouse-mode
      #tmuxPlugins.tpm
    ];
    escapeTime = 0;
    historyLimit = 50000;
    keyMode = "vi";
    extraConfig = ''
      set -g mouse on
      set -g display-time 4000
      set -g status-interval 5
      set -g set-clipboard on
      set -g @theme_right_separator ''
      set -g @theme_left_separator ''
    '';
  };
}
