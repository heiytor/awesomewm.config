awful.keyboard.append_global_keybindings({
    awful.key({ MODKEY,           }, "h",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "Focus previous window", group = "window"}
    ),
    awful.key({ MODKEY,           }, "l",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "Focus next window", group = "window"}
    ),
    awful.key({ MODKEY,           }, "Tab",
        function ()
            awful.client.focus.history.previous()
            if client.focus then
                client.focus:raise()
            end
        end,
        {description = "Go back", group = "window"}),

    awful.key({ MODKEY, "Control" }, "n",
              function ()
                  local c = awful.client.restore()
                  -- Focus restored client
                  if c then
                    c:activate { raise = true, context = "key.unminimize" }
                  end
              end,
              {description = "restore minimized", group = "window"}),

    awful.key({ MODKEY, "Shift"   }, "l",     function () awful.tag.incmwfact( 0.05)          end,
              {description = "Decrease master width factor", group = "window"}),
    awful.key({ MODKEY, "Shift"   }, "h",     function () awful.tag.incmwfact(-0.05)          end,
              {description = "Increase master width factor", group = "window"}),

    -- awful.key({ MODKEY, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
    --           {description = "Swap with previous client by index", group = "window"}),
    -- awful.key({ MODKEY, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
    --           {description = "Swap with next client by index", group = "window"}),

    awful.key({ MODKEY,           }, "u", awful.client.urgent.jumpto,
              {description = "Jump to urgent window", group = "window"}),
})

client.connect_signal("request::default_keybindings", function()
    awful.keyboard.append_client_keybindings({
        awful.key({ MODKEY,           }, "c",      function (c) c:kill()                         end,
                {description = "Close window", group = "window"}),

        awful.key({ MODKEY, "Control" }, "space",  awful.client.floating.toggle                     ,
                {description = "Toggle floating", group = "window"}),

        awful.key({ MODKEY,           }, "o",      function (c) c:move_to_screen()               end,
                {description = "Move to screen", group = "window"}),

        awful.key({ MODKEY, "Control" }, "t",      function (c) c.ontop = not c.ontop            end,
                {description = "Toggle keep on top", group = "window"}),

        awful.key({ MODKEY,           }, "n",
            function (c)
                -- The client currently has the input focus, so it cannot be
                -- minimized, since minimized clients can't have the focus.
                c.minimized = true
            end ,
            {description = "Minize a window", group = "window"}),

        awful.key({ MODKEY,           }, "m",
            function (c)
                c.maximized = not c.maximized
                c:raise()
            end ,
            {description = "Maximize or unmaximize a window", group = "window"}),
    })
end)
