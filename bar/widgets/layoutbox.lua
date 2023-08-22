-- Create an imagebox widget which will contain an icon indicating which layout we're using.
-- We need one layoutbox per screen.
function layoutbox(s)
    return Awful.widget.layoutbox {
        screen  = s,
        buttons = {
            Awful.button({ }, 1, function () Awful.layout.inc( 1) end),
            Awful.button({ }, 3, function () Awful.layout.inc(-1) end),
            Awful.button({ }, 4, function () Awful.layout.inc(-1) end),
            Awful.button({ }, 5, function () Awful.layout.inc( 1) end),
        }
    }
end

return layoutbox
