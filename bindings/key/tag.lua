awful.keyboard.append_global_keybindings({
    awful.key({ MODKEY, "Control" }, "h",   awful.tag.viewprev,
              {description = "View previous tag", group = "tag"}),
    awful.key({ MODKEY, "Control" }, "l",  awful.tag.viewnext,
              {description = "View next tag", group = "tag"}),
    -- awful.key({ MODKEY,           }, "Escape", awful.tag.history.restore,
    --           {description = "go back", group = "tag"}),

    awful.key {
        modifiers   = { MODKEY },
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
        modifiers = { MODKEY, "Shift" },
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
