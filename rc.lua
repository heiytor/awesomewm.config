require("config") -- Configure enviroment

local THEME_DIR = os.getenv("HOME") .. "/.config/awesome/themes"
Beautiful.init(THEME_DIR .. "/dark/theme.lua")

require("signals")
require("bar")
require("bindings")
require("gaps")
require("startup")
