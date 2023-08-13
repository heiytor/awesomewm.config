pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")

-- Widget and layout library
local wibox = require("wibox")

-- Theme handling library
local beautiful = require("beautiful")

-- Notification library
local naughty = require("naughty")

-- Declarative object management
local ruled         = require("ruled")
local menubar       = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

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

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Local constants and variables
-----------------------------------------------------------------------
-----------------------------------------------------------------------

local THEME_DIRECTORY = "/home/heitor/.config/awesome/themes"

local theme        = THEME_DIRECTORY .. "/default/theme.lua"
local browser      = "firefox"
local terminal     = "alacritty"
local editor       = "nvim"
local editor_cmd   = terminal .. " -e " .. editor
local modkey       = "Mod4"
local file_manager = "ranger"

beautiful.init(theme)

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Menu
-----------------------------------------------------------------------
-----------------------------------------------------------------------

-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

menubar.utils.terminal = terminal -- Set the terminal for applications that require it

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Layouts
-----------------------------------------------------------------------
-----------------------------------------------------------------------

tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        -- awful.layout.suit.floating,
        awful.layout.suit.tile,
        -- awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.spiral.dwindle,
        awful.layout.suit.max,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
    })
end)

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Wibar
-----------------------------------------------------------------------
-----------------------------------------------------------------------

local separator_widget = wibox.widget.textbox("   ")

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- Create a textclock widget
mytextclock = wibox.widget.textclock()

screen.connect_signal("request::desktop_decoration", function(s)
    -- Each screen has its own tag table.
    awful.tag({ "1", "2", "3", "4" , "5" }, s, awful.layout.layouts[1])

    -- Create a promptbox for each screen
    s.mypromptbox = awful.widget.prompt()

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox {
        screen  = s,
        buttons = {
            awful.button({ }, 1, function () awful.layout.inc( 1) end),
            awful.button({ }, 3, function () awful.layout.inc(-1) end),
            awful.button({ }, 4, function () awful.layout.inc(-1) end),
            awful.button({ }, 5, function () awful.layout.inc( 1) end),
        }
    }

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = {
            awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
            awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
            awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
        }
    }

    -- Create the wibox
    s.mywibox = awful.wibar {
        position = "bottom",
        screen   = s,
        widget   = {
            layout = wibox.layout.align.horizontal,
             -- Left widgets
	     {
		layout = wibox.layout.fixed.horizontal,
                s.mylayoutbox,
		separator_widget,
                s.mytaglist,
		separator_widget,
                -- s.mypromptbox,
            },
	    -- Middle widget
            s.mytasklist,
            -- Right widgets
	    {
                layout = wibox.layout.fixed.horizontal,
		separator_widget,
                wibox.widget.systray(),
		separator_widget,
                mytextclock,
            },
        }
    }
end)

-- }}}

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Mouse Bindings
-----------------------------------------------------------------------
-----------------------------------------------------------------------

awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})

client.connect_signal("request::default_mousebindings", function()
    awful.mouse.append_client_mousebindings({
        awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        awful.button({ modkey }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        awful.button({ modkey }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)

-----------------------------------------------------------------------
-----------------------------------------------------------------------
-- Key Bindings
-----------------------------------------------------------------------
-----------------------------------------------------------------------

--------------------
-- Group "awesome"
--------------------
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="Show keybings", group="awesome"}),
    -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
    --           {description = "Show menu", group = "awesome"}),
    awful.key({ modkey,           }, "r", awesome.restart,
              {description = "Reload", group = "awesome"}),
    awful.key({ modkey, "Control" }, "q", awesome.quit,
              {description = "Quit", group = "awesome"}),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"}),
})

---------------------
-- Group "launcher"
---------------------
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "t", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey,           }, "f", function () awful.spawn(terminal .. " -e ranger") end,
              {description = "open a file manager", group = "launcher"}),
    awful.key({ modkey,           }, "b", function () awful.spawn(browser) end,
              {description = "Open a browser", group = "launcher"}),
    -- awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
    --           {description = "run prompt", group = "launcher"}),
    awful.key({ modkey            }, "p", function() awful.spawn("/home/heitor/.config/scripts/rofi_show_drun") end,
              {description = "Show 'run' script", group = "launcher"}),
    awful.key({ modkey            }, "w", function() awful.spawn("/home/heitor/.config/scripts/rofi_show_window") end,
              {description = "Show 'window' script", group = "launcher"}),
    awful.key({                   }, "Print", function() awful.spawn("flameshot gui") end,
              { description = "Printscreen", group = "Commands" }),
})

----------------
-- Group "tag"
----------------
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Control" }, "h",   awful.tag.viewprev,
              {description = "View previous tag", group = "tag"}),
    awful.key({ modkey, "Control" }, "l",  awful.tag.viewnext,
              {description = "View next tag", group = "tag"}),
    -- awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
    --           {description = "go back", group = "tag"}),

    awful.key {
        modifiers   = { modkey },
        keygroup    = "numrow",
        description = "View tag[n]",
        group       = "tag",
        on_press    = function (index)
            local screen = awful.screen.focused()
            local tag = screen.tags[index]
            if tag then
                tag:view_only()
            end
        end,
    },

    awful.key {
        modifiers = { modkey, "Shift" },
        keygroup    = "numrow",
        description = "Move focused window to tag[n]",
        group       = "tag",
        on_press    = function (index)
            if client.focus then
                local tag = client.focus.screen.tags[index]
                if tag then
                    client.focus:move_to_tag(tag)
                end
            end
        end,
    },
})

-------------------
-- Group "window"
-------------------
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "h",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "Focus previous window", group = "window"}
    ),
    awful.key({ modkey,           }, "l",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "Focus next window", group = "window"}
    ),
    awful.key({ modkey,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "Go back", group = "window"}),

    awful.key({ modkey, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                  end
              end,
              {description = "restore minimized", group = "window"}),

    awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "Decrease master width factor", group = "window"}),
    awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "Increase master width factor", group = "window"}),

    -- awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
    --           {description = "Swap with previous client by index", group = "window"}),
    -- awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
    --           {description = "Swap with next client by index", group = "window"}),

    awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
              {description = "Jump to urgent window", group = "window"}),
})

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ modkey,           }, "c",      function (c) c:kill()                         end,
                {description = "Close window", group = "window"}),

        awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
                {description = "Toggle floating", group = "window"}),

        awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "Move to screen", group = "window"}),

        awful.key({ modkey, "Control" }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "Toggle keep on top", group = "window"}),

        awful.key({ modkey,           }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "Minize a window", group = "window"}),

        awful.key({ modkey,           }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "Maximize or unmaximize a window", group = "window"}),
    })
end)

-------------------
-- Group "screen"
-------------------
awful.keyboard.append_global_keybindings({
    awful.key({ modkey, "Control" }, "j", function() awful.screen.focus_relative( 1) end,
              {description = "Focus next screen", group = "screen"}),
    awful.key({ modkey, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
              {description = "Focus previous screen", group = "screen"}),
})

-------------------
-- Group "volume"
-------------------

-- "amixer" binary is in "alsa-plugins" package.
awful.keyboard.append_global_keybindings({
    awful.key({ modkey,           }, "[", function() awful.spawn("amixer -D pulse sset Master 5%-") end,
              {description = "Decrease volume", group = "volume"}),
    awful.key({ modkey,           }, "]", function() awful.spawn("amixer -D pulse sset Master 5%+") end,
              {description = "Increase volume", group = "volume"}),
    awful.key({ modkey,           }, "/", function() awful.spawn("amixer -D pulse sset Master toggle", false) end,
        { description = "Mute volume", group = "Volume" }),
})

--------------------------------------------------------------
--------------------------------------------------------------
--- Rules
--------------------------------------------------------------
--------------------------------------------------------------

ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- ruled.client.append_rule {
    --     rule       = { class = "Firefox"     },
    --     properties = { screen = 1, tag = "2" }
    -- }
end)

--------------------------------------------------------------
--------------------------------------------------------------
--- Notifications
--------------------------------------------------------------
--------------------------------------------------------------

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)

--------------------------------------------------------------
--------------------------------------------------------------
--- GAPS
--------------------------------------------------------------
--------------------------------------------------------------

beautiful.useless_gap       = 4
-- beautiful.gap_single_client = false

---- No borders when rearranging only 1 non-floating or maximized client
-- screen.connect_signal("arrange", function (s)
--   local only_one = #s.tiled_clients == 1
--     for _, c in pairs(s.clients) do
--       if only_one and not c.floating or c.maximized then
--         c.border_width = 0
--       else
--         c.border_width = 1 
--       end
--     end
-- end)

--------------------------------------------------------------
--------------------------------------------------------------
--- STARTUP
--------------------------------------------------------------
--------------------------------------------------------------

awful.spawn.with_shell("setxkbmap -model abnt2 -layout br")
awful.spawn.with_shell("feh --bg-scale /home/heitor/Wallpapers/black-water.jpg")
awful.spawn.with_shell("picom")
awful.spawn.with_shell("flameshot")
