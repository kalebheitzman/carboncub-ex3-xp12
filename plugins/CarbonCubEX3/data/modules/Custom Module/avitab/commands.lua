-- commands
avi_app_charts = sasl.findCommand("AviTab/app_charts")
avi_app_airports = sasl.findCommand("AviTab/app_airports")
avi_app_routes = sasl.findCommand("AviTab/app_routes")
avi_app_maps = sasl.findCommand("AviTab/app_maps")
avi_app_navigraph = sasl.findCommand("AviTab/app_navigraph")
avi_app_plane_manual = sasl.findCommand("AviTab/app_plane_manual")
avi_app_notes = sasl.findCommand("AviTab/app_notes")
avi_app_about = sasl.findCommand("AviTab/app_about")

-- tablet visibility
function toggle_avitab_handler(phase)
    if phase == SASL_COMMAND_BEGIN then
        if get(avi_panel_enabled) == 1 then
            set(avi_panel_enabled, 0)
        else
            set(avi_panel_enabled, 1)
        end
    end
    return 1
end

-- command handlers
toggle_avitab = sasl.createCommand("cc_ex3/avitab/toggle_avitab", "Toggle tablet visibility")

-- register command handlers
sasl.registerCommandHandler(toggle_avitab, 0, toggle_avitab_handler)
