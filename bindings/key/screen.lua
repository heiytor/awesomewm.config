Awful.keyboard.append_global_keybindings({
    Awful.key({ MODKEY, "Control" }, "j", function() Awful.screen.focus_relative( 1) end,
              {description = "Focus next screen", group = "screen"}),
    Awful.key({ MODKEY, "Control" }, "k", function() Awful.screen.focus_relative(-1) end,
              {description = "Focus previous screen", group = "screen"}),
})
