local terminal = "alacritty"
local browser = "firefox"

Awful.keyboard.append_global_keybindings({
	Awful.key({ MODKEY }, "t", function()
		Awful.spawn(terminal)
	end, { description = "open a terminal", group = "launcher" }),

	Awful.key({ MODKEY }, "f", function()
		Awful.spawn(terminal .. " -e ranger")
	end, { description = "open a file manager", group = "launcher" }),

	Awful.key({ MODKEY }, "b", function()
		Awful.spawn(browser)
	end, { description = "Open a browser", group = "launcher" }),

	Awful.key({ MODKEY }, "p", function()
		Awful.spawn(AWESOME_DIR .. "scripts/rofi_show_drun")
	end, { description = "Show 'run' script", group = "launcher" }),

	Awful.key({ MODKEY }, "w", function()
		Awful.spawn(AWESOME_DIR .. "scripts/rofi_show_window")
	end, { description = "Show 'window' script", group = "launcher" }),

	Awful.key({}, "Print", function()
		Awful.spawn("flameshot gui")
	end, { description = "Printscreen", group = "Commands" }),
})
