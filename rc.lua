require("config") -- Configure enviroment

local THEME_DIRECTORY = os.getenv("HOME") .. "/.config/awesome/themes"
local theme           = THEME_DIRECTORY .. "/dark/theme.lua"
Beautiful.init(theme)

require("signals")
require("bar")
require("bindings")
require("gaps")
require("startup")
