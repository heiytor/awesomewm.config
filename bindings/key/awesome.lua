awful.keyboard.append_global_keybindings({
    awful.key({ MODKEY,           }, "s",      hotkeys_popup.show_help,
              {description="Show keybings", group="awesome"}),
    -- awful.key({ MODKEY,           }, "w", function () mymainmenu:show() end,
    --           {description = "Show menu", group = "awesome"}),
    awful.key({ MODKEY,           }, "r", awesome.restart,
              {description = "Reload", group = "awesome"}),
    awful.key({ MODKEY, "Control" }, "q", awesome.quit,
              {description = "Quit", group = "awesome"}),
    awful.key({ MODKEY            }, "x",
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
