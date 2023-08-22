Ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    Ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = Awful.client.focus.filter,
            raise     = true,
            screen    = Awful.screen.preferred,
            placement = Awful.placement.no_overlap+Awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    Ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    Ruled.client.append_rule {
        rule       = { class = "discord"     },
        properties = { screen = 1, tag = "5" }
    }
end)
