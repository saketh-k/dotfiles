local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.front_end = "WebGpu"
config.color_scheme = "gruvbox_material_dark_medium"
config.color_scheme = "Gruvbox dark, medium (base16)"
-- config.enable_wayland = false
--config.freetype_load_target = "Normal"

-- config.colors = {
-- 	tab_bar = {
-- 		background = "#2E3440",
-- 		active_tab = {
-- 			bg_color = "#4C566A",
-- 			fg_color = "#D8DEE9",
-- 		},
-- 		inactive_tab = {
-- 			bg_color = "#3B4252",
-- 			fg_color = "#D8DEE9",
-- 		},
-- 		inactive_tab_hover = {
-- 			bg_color = "#4C566A",
-- 			fg_color = "#D8DEE9",
-- 		},
-- 		new_tab = {
-- 			bg_color = "#3B4252",
-- 			fg_color = "#D8DEE9",
-- 		},
-- 		new_tab_hover = {
-- 			bg_color = "#4C566A",
-- 			fg_color = "#D8DEE9",
-- 		},
-- 	},
-- }
--

config.color_schemes = {
	["gruvbox_material_dark_medium"] = {
		foreground = "#D4BE98",
		background = "#282828",
		cursor_bg = "#D4BE98",
		cursor_border = "#D4BE98",
		cursor_fg = "#282828",
		selection_bg = "#D4BE98",
		selection_fg = "#45403d",

		ansi = { "#282828", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
		brights = { "#eddeb5", "#ea6962", "#a9b665", "#d8a657", "#7daea3", "#d3869b", "#89b482", "#d4be98" },
	},
}

-- config.webgpu_power_preference = "HighPerformance"
-- UI Options
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.font_size = 12.0
config.window_background_opacity = 0.95
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- Keybindings

config.leader = { key = "Space", mods = "CTRL" }
config.keys = {
	{
		key = "|",
		mods = "LEADER|SHIFT",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{
		key = "c",
		mods = "LEADER",
		action = { CopyTo = "Clipboard" },
	},
	{
		key = "v",
		mods = "LEADER",
		action = { PasteFrom = "Clipboard" },
	},
}

return config
