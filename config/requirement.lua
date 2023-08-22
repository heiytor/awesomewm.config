pcall(require, "luaroks.loader")

-- Standard lib
Gears         = require("gears")
Awful         = require("awful")
Hotkeys_popup = require("awful.hotkeys_popup")
require("awful.autofocus")

-- Wibox and layout
Wibox = require("wibox")

-- Theme
Beautiful = require("beautiful")

-- Notifications
Naughty = require("naughty")

-- Object management
Menubar = require("menubar")
Ruled   = require("ruled")

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Error handling
-----------------------------------------------------------------------
-----------------------------------------------------------------------

Naughty.connect_signal("request::display_error", function(message, startup)
    Naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
