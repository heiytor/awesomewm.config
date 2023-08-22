-- Create a taglist
function taglist(s)
    return Awful.widget.taglist {
        screen  = s,
        filter  = Awful.widget.taglist.filter.all,
        buttons = {
            Awful.button({ }, 1, function(t) t:view_only() end),
            Awful.button({ MODKEY }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            Awful.button({ }, 3, Awful.tag.viewtoggle),
            Awful.button({ MODKEY }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            Awful.button({ }, 4, function(t) Awful.tag.viewprev(t.screen) end),
            Awful.button({ }, 5, function(t) Awful.tag.viewnext(t.screen) end),
        }
    }
end

return taglist
