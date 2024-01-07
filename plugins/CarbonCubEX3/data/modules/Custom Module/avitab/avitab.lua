include("datarefs.lua")
include("commands.lua")

avi_left = 140
avi_bottom = 2185
avi_width = 2653
avi_height = 1990

onModuleInit = function()

    logInfo("load avitab")

    set(avi_panel_left, avi_left)
    set(avi_panel_bottom, avi_bottom)
    set(avi_panel_width, avi_width)
    set(avi_panel_height, avi_height)

    set(avi_panel_enabled, 0)
end
