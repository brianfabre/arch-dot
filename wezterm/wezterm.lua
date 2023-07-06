-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
    config = wezterm.config_builder()
end

-- This is where you actually apply your config choices
config.font_size = 12
config.font = wezterm.font_with_fallback({
    -- "SF Mono",
    -- "Hack",
    "FiraCode Nerd Font Ret",
    -- "Iosevka Nerd Font",
    -- "JetBrains Mono",
    -- "IBM Plex Mono",
    { family = "Symbols Nerd Font Mono", scale = 0.75 },
})
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
config.window_background_opacity = 0.75

-- For example, changing the color scheme:
-- config.color_scheme = "Catppuccin Macchiato"
-- config.color_scheme = "Dracula (Official)"
config.color_scheme = "GitHub Dark"
-- config.color_scheme = "Monokai Remastered"

-- and finally, return the configuration to wezterm
return config
