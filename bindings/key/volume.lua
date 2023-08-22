-- "amixer" binary is in "alsa-plugins" package.

Awful.keyboard.append_global_keybindings({
    Awful.key({ MODKEY,           }, "]", function() Awful.spawn("amixer -D pulse sset Master 5%-") end,
              {description = "Decrease volume", group = "volume"}),
    Awful.key({ MODKEY,           }, "[", function() Awful.spawn("amixer -D pulse sset Master 5%+") end,
              {description = "Increase volume", group = "volume"}),
    Awful.key({ MODKEY,           }, "/", function() Awful.spawn("amixer -D pulse sset Master toggle", false) end,
              { description = "Mute volume", group = "Volume" }),
})
