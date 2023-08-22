local file_manager = "ranger"
local terminal = "alacritty"
local browser = "firefox"
local editor = "nvim"

local editor_cmd = terminal .. " -e " .. editor

Awful.keyboard.append_global_keybindings({
    Awful.key({ MODKEY,           }, "t", function () Awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    Awful.key({ MODKEY,           }, "f", function () Awful.spawn(terminal .. " -e ranger") end,
              {description = "open a file manager", group = "launcher"}),
    Awful.key({ MODKEY,           }, "b", function () Awful.spawn(browser) end,
              {description = "Open a browser", group = "launcher"}),
    -- awful.key({ MODKEY },            "r",     function () awful.screen.focused().mypromptbox:run() end,
    --           {description = "run prompt", group = "launcher"}),
    Awful.key({ MODKEY            }, "p", function() Awful.spawn("/home/heitor/.config/scripts/rofi_show_drun") end,
              {description = "Show 'run' script", group = "launcher"}),
    Awful.key({ MODKEY            }, "w", function() Awful.spawn("/home/heitor/.config/scripts/rofi_show_window") end,
              {description = "Show 'window' script", group = "launcher"}),
    Awful.key({                   }, "Print", function() Awful.spawn("flameshot gui") end,
              { description = "Printscreen", group = "Commands" }),
})
