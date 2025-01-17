
local wezterm = require 'wezterm'
local config = wezterm.config_builder()

config.front_end = "WebGpu"

config.webgpu_power_preference = "HighPerformance"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 12.0
config.window_background_opacity = 0.7

-- Keybindings

config.leader = { key="Space", mods="CTRL" }
config.keys = {
  {
    key="|",
    mods="LEADER|SHIFT",
    action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}},
  },
  {
    key="c",
    mods="LEADER",
    action={CopyTo="Clipboard"}
  },
  {
    key="v",
    mods="LEADER",
    action={PasteFrom="Clipboard"}
  },
}


return config
