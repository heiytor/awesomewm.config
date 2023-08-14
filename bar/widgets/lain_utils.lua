local lain = require("lain")

local cpu = lain.widget.cpu({
    settings = function()
        widget:set_markup(
            "<span color=\"#FFA500\"> CPU " .. cpu_now.usage .. "% </span>"
        )
    end
})

local mem = lain.widget.mem({
    settings = function()
        widget:set_markup(
            "<span color=\"#FF69B4\"> MEM " .. mem_now.perc .. "% </span>"
        )
    end
})

local cpu_tmp = lain.widget.temp({
    settings = function()
        widget:set_markup(
            "<span color=\"#FFA500\">" .. coretemp_now .. "°C </span>"
        )
    end
})

local fs_root = lain.widget.fs({
    settings = function()
        widget:set_markup(
            "<span color=\"#00CC00\">" ..
            "/: " ..
            fs_now["/"].percentage ..
            "% (" ..
            string.format("%.0f", fs_now["/"].free) .. " " ..
            fs_now["/"].units ..
            " left) " ..
            "</span>"
        )
    end
})

local fs_home = lain.widget.fs({
    settings = function()
        widget:set_markup(
            "<span color=\"#00CC00\">" ..
            "/home: " ..
            fs_now["/home"].percentage ..
            "% (" ..
            string.format("%.0f", fs_now["/home"].free) .. " " ..
            fs_now["/home"].units ..
            " left)" ..
            "</span>"
        )
    end
})

return {
    fs_home = fs_home,
    fs_root = fs_root,
    cpu_tmp = cpu_tmp,
    cpu     = cpu,
    mem     = mem,
}

