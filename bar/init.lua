local TAGS = { "1", "2", "3", "4", "5" }

local w_layoutbox = require("bar.widgets.layoutbox")
local w_tasklist  = require("bar.widgets.tasklist")
local w_taglist   = require("bar.widgets.taglist")
local w_utils     = require("bar.widgets.utils")

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag(TAGS, s, awful.layout.layouts[1])

    s.mylayoutbox = w_layoutbox(s)
    s.mytasklist  = w_tasklist(s)
    s.mytaglist   = w_taglist(s)

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "bottom",
        screen   = s,
        widget   = {
            layout = wibox.layout.align.horizontal,
	        { -- Left widgets
                layout = wibox.layout.fixed.horizontal,
                s.mylayoutbox,
                w_utils.separator,
                s.mytaglist,
                w_utils.separator,
            },
              -- Middle widget
            s.mytasklist,
            { -- Right widgets
                layout = wibox.layout.fixed.horizontal,
                w_utils.separator,
                wibox.widget.systray(),
                w_utils.separator,
                w_utils.textclock,
            },
        }
    }
end)
