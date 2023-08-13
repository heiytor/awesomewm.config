local GAP_LENGHT = 4 

beautiful.useless_gap       = GAP_LENGHT
beautiful.gap_single_client = true

---- No borders when rearranging only 1 non-floating or maximized client
-- screen.connect_signal("arrange", function (s)
--   local only_one = #s.tiled_clients == 1
--     for _, c in pairs(s.clients) do
--       if only_one and not c.floating or c.maximized then
--         c.border_width = 0
--       else
--         c.border_width = 1
--       end
--     end
-- end)
