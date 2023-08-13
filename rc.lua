require("config") -- Configure enviroment

local THEME_DIRECTORY = HOME .. "/.config/awesome/themes"
local theme           = THEME_DIRECTORY .. "/dark/theme.lua"
beautiful.init(theme)

require("signals")
require("bar")
require("bindings")
require("gaps")
require("startup")
