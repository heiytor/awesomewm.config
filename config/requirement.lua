pcall(require, "luaroks.loader")

-- Standard lib
gears         = require("gears")
awful         = require("awful")
hotkeys_popup = require("awful.hotkeys_popup")
require("awful.autofocus")

-- Wibox and layout
wibox = require("wibox")

-- Theme
beautiful = require("beautiful")

-- Notifications
naughty = require("naughty")

-- Object management
menubar = require("menubar")
ruled   = require("ruled")

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Error handling
-----------------------------------------------------------------------
-----------------------------------------------------------------------

naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
