local file_manager = "ranger"
local terminal = "alacritty"
local browser = "firefox"
local editor = "nvim"

local editor_cmd = terminal .. " -e " .. editor

awful.keyboard.append_global_keybindings({
    awful.key({ MODKEY,           }, "t", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ MODKEY,           }, "f", function () awful.spawn(terminal .. " -e ranger") end,
              {description = "open a file manager", group = "launcher"}),
    awful.key({ MODKEY,           }, "b", function () awful.spawn(browser) end,
              {description = "Open a browser", group = "launcher"}),
    -- awful.key({ MODKEY },            "r",     function () awful.screen.focused().mypromptbox:run() end,
    --           {description = "run prompt", group = "launcher"}),
    awful.key({ MODKEY            }, "p", function() awful.spawn("/home/heitor/.config/scripts/rofi_show_drun") end,
              {description = "Show 'run' script", group = "launcher"}),
    awful.key({ MODKEY            }, "w", function() awful.spawn("/home/heitor/.config/scripts/rofi_show_window") end,
              {description = "Show 'window' script", group = "launcher"}),
    awful.key({                   }, "Print", function() awful.spawn("flameshot gui") end,
              { description = "Printscreen", group = "Commands" }),
})
