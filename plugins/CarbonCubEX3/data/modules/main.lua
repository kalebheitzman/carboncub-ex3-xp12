-- Global settings
sasl.logInfo("Loading the Carbon Cub EX3 by Jamfire Studio...")

sasl.options.setAircraftPanelRendering(true)
sasl.options.set3DRendering(false)
sasl.options.setInteractivity(true)
sasl.options.setRenderingMode2D(SASL_RENDER_2D_DEFAULT)
sasl.options.setPanelRenderingMode(SASL_RENDER_PANEL_DEFAULT)
panel2d = true
panelWidth2d = 4096
panelHeight2d = 4096
panelWidth3d = 4096
panelHeight3d = 4096

size = {4096, 4096}

globalShowInteractiveAreas = true

-- shared sim datarefs
sim_main_battery = globalPropertyiae("sim/cockpit2/electrical/battery_on", 1)
sim_backup_battery = globalPropertyiae("sim/cockpit2/electrical/battery_on", 2)

-- components
components = {fuel_selector {}, lights {}, hatches {}, electrical {}, -- digital instruments
smart_monitor {
    position = {2980, 2919, 282, 202}
}, cgr_30p_engine_monitor {
    position = {115, 119, 1077, 811}
}, garmin_aera_796 {
    position = {117, 2370, 2704, 1659}
}, trig_tt21_mode_s_xpdr {
    position = {2980, 3322, 453, 244}
}, trig_ty91_vhf_radio {
    position = {2980, 3767, 453, 244}
}, avitab {}}

-- draw all components
function draw()
    drawAll(components)
end

-- local popup = contextWindow {
--     name        = "Garmin aera 796",
--     position    = { 50, 50, 2704, 1659 },
--     noResize    = false,
--     visible     = false,
--     vrAuto      = true,
--     components  = {
--         garmin_aera_796 {
--             position = { 0, 0, 2704, 1659 },
--         }
--     }
-- }

-- show_hide = function()
--     popup:setIsVisible(not popup:isVisible())
-- end

-- local status = true

-- change_menu = function()
--     status = not status
--     sasl.enableMenuItem(cc_menu_main, menu_action, status and 1 or 0)
--     sasl.setMenuItemName(cc_menu_main, menu_option, status and "Disable show/hide" or "Enable show/hide")
--     sasl.setMenuItemState(cc_menu_main, menu_option, status and MENU_CHECKED or MENU_UNCHECKED)
-- end

-- -- plugin menu
-- cc_menu_top  = sasl.appendMenuItem(AIRCRAFT_MENU_ID, "Carbon Cub EX-3")
-- cc_menu_main = sasl.createMenu("", AIRCRAFT_MENU_ID, cc_menu_top)
-- menu_option = sasl.appendMenuItem(cc_menu_main, "Enable show/hide", change_menu)
-- sasl.appendMenuSeparator(cc_menu_main)
-- menu_action = sasl.appendMenuItem(cc_menu_main, "Show/hide popup", show_hide)
-- change_menu()
