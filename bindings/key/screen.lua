awful.keyboard.append_global_keybindings({
    awful.key({ MODKEY, "Control" }, "j", function() awful.screen.focus_relative( 1) end,
              {description = "Focus next screen", group = "screen"}),
    awful.key({ MODKEY, "Control" }, "k", function() awful.screen.focus_relative(-1) end,
              {description = "Focus previous screen", group = "screen"}),
})
