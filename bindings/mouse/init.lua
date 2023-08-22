Awful.mouse.append_global_mousebindings({
    Awful.button({ }, 3, function () mymainmenu:toggle() end),
    Awful.button({ }, 4, Awful.tag.viewprev),
    Awful.button({ }, 5, Awful.tag.viewnext),
})

client.connect_signal("request::default_mousebindings", function()
    Awful.mouse.append_client_mousebindings({
        Awful.button({ }, 1, function (c)
            c:activate { context = "mouse_click" }
        end),
        Awful.button({ MODKEY }, 1, function (c)
            c:activate { context = "mouse_click", action = "mouse_move"  }
        end),
        Awful.button({ MODKEY }, 3, function (c)
            c:activate { context = "mouse_click", action = "mouse_resize"}
        end),
    })
end)
