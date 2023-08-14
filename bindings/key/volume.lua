-- "amixer" binary is in "alsa-plugins" package.

awful.keyboard.append_global_keybindings({
    awful.key({ MODKEY,           }, "]", function() awful.spawn("amixer -D pulse sset Master 5%-") end,
              {description = "Decrease volume", group = "volume"}),
    awful.key({ MODKEY,           }, "[", function() awful.spawn("amixer -D pulse sset Master 5%+") end,
              {description = "Increase volume", group = "volume"}),
    awful.key({ MODKEY,           }, "/", function() awful.spawn("amixer -D pulse sset Master toggle", false) end,
              { description = "Mute volume", group = "Volume" }),
})
