local ICON_DIR = os.getenv("HOME") .. '/.config/awesome/bar/widgets/volume/icons/'

local widget = {}

function widget.get_widget(widgets_args)
    local args = widgets_args or {}

    local main_color = args.main_color or Beautiful.fg_normal
    local mute_color = args.mute_color or Beautiful.fg_urgent
    local bg_color = args.bg_color or '#ffffff11'
    local width = args.width or 50
    local margins = args.margins or 10
    local shape = args.shape or 'bar'
    local with_icon = args.with_icon == true and true or false

    local bar = Wibox.widget {
        {
            {
                id = "icon",
                image = ICON_DIR .. 'audio-volume-high-symbolic.svg',
                resize = false,
                widget = Wibox.widget.imagebox,
            },
            valign = 'center',
            visible = with_icon,
            layout = Wibox.container.place,
        },
        {
            id = 'bar',
            max_value = 100,
            forced_width = width,
            color = main_color,
            margins = { top = margins, bottom = margins },
            background_color = bg_color,
            shape = Gears.shape[shape],
            widget = Wibox.widget.progressbar,
        },
        spacing = 4,
        layout = Wibox.layout.fixed.horizontal,
        set_volume_level = function(self, new_value)
            self:get_children_by_id('bar')[1]:set_value(tonumber(new_value))
        end,
        mute = function(self)
            self:get_children_by_id('bar')[1]:set_color(mute_color)
        end,
        unmute = function(self)
            self:get_children_by_id('bar')[1]:set_color(main_color)
        end
    }

    return bar
end

return widget
