-- Create a tasklist
function tasklist(s)
    return Awful.widget.tasklist {
        screen  = s,
        filter  = Awful.widget.tasklist.filter.currenttags,
        buttons = {
            Awful.button({ }, 1, function (c)
                c:activate { context = "tasklist", action = "toggle_minimization" }
            end),
            Awful.button({ }, 3, function() Awful.menu.client_list { theme = { width = 250 } } end),
            Awful.button({ }, 4, function() Awful.client.focus.byidx(-1) end),
            Awful.button({ }, 5, function() Awful.client.focus.byidx( 1) end),
        }
    }
end

return tasklist
