include("../styles.lua")
include("datarefs.lua")
include("helpers.lua")
include("commands.lua")

----------
-- INIT --
----------

-- set initial transponder code
function onModuleInit()
    local xpdr_t = xpdr_table()
    set(cc_xpdr_digits, xpdr_t)
end

----------
-- DRAW --
----------

function draw()
    cc_avionics = globalPropertyi("sim/cockpit2/switches/avionics_power_on")
    cc_avionics_on = get(cc_avionics)
    main_battery = get(sim_main_battery)
    xdpr_mode = get(cc_xpdr_mode)

    -- xpdr
    transponder_code = globalPropertyi("sim/cockpit2/radios/actuators/transponder_code")
    transponder_mode = globalPropertyi("sim/cockpit2/radios/actuators/transponder_mode")
    transponder_ident = globalPropertyi("sim/cockpit2/radios/indicators/transponder_id")
    transponder_idx = get(transponder_mode)

    -- 0 = off, 1 = stdby, 2 = mode A, 3 = mode C, 4 = GND, 5 = mode S
    local mode = {}
    mode[0] = "OFF"
    mode[1] = "SBY"
    mode[2] = "ON"
    mode[3] = "ON"
    mode[4] = "GND"
    mode[5] = "ALT"

    -- flight id
    local flight_id_v = globalProperty("sim/cockpit2/radios/actuators/flight_id")
    local flight_id_v1 = get(flight_id_v, 1)
    local flight_id_v2 = get(flight_id_v, 2)
    local flight_id_v3 = get(flight_id_v, 3)
    local flight_id_v4 = get(flight_id_v, 4)
    local flight_id_v5 = get(flight_id_v, 5)
    local flight_id_v6 = get(flight_id_v, 6)
    local flight_id_v7 = get(flight_id_v, 7)
    local flight_id_v8 = get(flight_id_v, 8)
    local flight_id = flight_id_v1 .. flight_id_v2 .. flight_id_v3 .. flight_id_v4 .. flight_id_v5 .. flight_id_v6 .. flight_id_v7 .. flight_id_v8

    -- altitude
    local altitude = globalPropertyf("sim/cockpit2/gauges/indicators/altitude_ft_pilot")
    local altitude_v = get(altitude)
    local altitude_s = flight_level(altitude_v)

    if cc_avionics_on == 1 and xdpr_mode > 0 and main_battery == 1 then
        sasl.gl.drawRectangle(0, 0, 453, 244, blue)
        -- sasl.gl.drawText(font_digital, 430, 125, get(transponder_code), 120, true, false, TEXT_ALIGN_RIGHT, black)

        code_number(1)
        code_number(2)
        code_number(3)
        code_number(4)

        sasl.gl.drawText(font_bold, 20, 20, mode[transponder_idx], 60, false, false, TEXT_ALIGN_LEFT, black)
        sasl.gl.drawText(font_bold, 430, 20, altitude_s, 60, false, false, TEXT_ALIGN_RIGHT, black)
        sasl.gl.drawText(font_bold, 430, 80, flight_id, 44, false, false, TEXT_ALIGN_RIGHT, black)

        if get(transponder_ident) == 1 then
            sasl.gl.drawRectangle(10, 143, 60, 50, black)
            sasl.gl.drawText(font_bold, 22, 156, "ID", 34, true, false, TEXT_ALIGN_LEFT, blue)
        end
    end
end

