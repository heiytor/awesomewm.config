Awful.keyboard.append_global_keybindings({
	Awful.key({ MODKEY }, "s", Hotkeys_popup.show_help, { description = "Show keybings", group = "awesome" }),
	Awful.key({ MODKEY }, "r", awesome.restart, { description = "Reload", group = "awesome" }),
	Awful.key({ MODKEY, "Control" }, "q", awesome.quit, { description = "Quit", group = "awesome" }),
	Awful.key({ MODKEY }, "x", function()
		Awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = Awful.screen.focused().mypromptbox.widget,
			exe_callback = Awful.util.eval,
			history_path = Awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
})
