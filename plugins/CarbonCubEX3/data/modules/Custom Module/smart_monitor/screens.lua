-- MAIN.V
-- green  - 12.6-15.0v
-- yellow - 10.8-12.5v / 15.1-15.7
-- red    - 10.7v or below / 15.8v or above
-- when screen is red, it will flash until acknowledged

-- BACK.V
-- Dedicated to the ignition backup battery
-- Should be about 0.2v lower than main buse when alternator is charging main battery
-- green  - 12.4v or higher
-- yellow - 10.8-12.4v
-- red    - 10.7v or lower 
-- when screen is red, it will flash until acknowledged

-- L.IGN
-- Green when L.IGN is on
-- RED when L.IGN is off
-- when screen is red, it will flash for 5 seconds or until acknowledged

-- R.IGN
-- Green when R.IGN is on
-- RED when R.IGN is off
-- when screen is red, it will flash for 5 seconds or until acknowledged

-- BAK UP \ IN USE
-- yellow - flash for 5 seconds or until acknowledged
-- green - bottom line reads CHRGE when battery switch is in normal and charging

-------------
-- SCREENS --
-------------

function screen_mainv(phase)
    current_voltage = get(voltage, 1)

    active_bg = green
    if current_voltage < 12.6 or current_voltage > 15 then
        active_bg = yellow
    end
    if current_voltage < 10.7 or current_voltage > 15.8 then
        active_bg = red
    end

    sasl.gl.drawRectangle(0, 0, 282, 202, active_bg)
    sasl.gl.drawText(font_regular, 140, 102, "MAIN.V", 64, true, false, TEXT_ALIGN_CENTER, black)
    sasl.gl.drawText(font_regular, 140, 42, round2(current_voltage, 2), 64, true, false, TEXT_ALIGN_CENTER, black)    
end

function screen_backv(phase)
    current_voltage = get(voltage, 2)

    active_bg = green
    if current_voltage < 12.6 or current_voltage > 15 then
        active_bg = yellow
    end
    if current_voltage < 10.7 or current_voltage > 15.8 then
        active_bg = red
    end

    sasl.gl.drawRectangle(0, 0, 282, 202, active_bg)
    sasl.gl.drawText(font_regular, 140, 102, "BACK.V", 64, true, false, TEXT_ALIGN_CENTER, black)
    sasl.gl.drawText(font_regular, 140, 42, round2(current_voltage, 2), 64, true, false, TEXT_ALIGN_CENTER, black)    
end

function screen_l_ign()
    -- 1 or 3
    ignition = get(globalPropertyia("sim/cockpit2/engine/actuators/ignition_on"), 1)

    bg = {}
    bg[0] = red
    bg[1] = green
    bg[2] = red
    bg[3] = green
    bg[4] = green

    status = {}
    status[0] = "OFF"
    status[1] = "ON"
    status[2] = "OFF"
    status[3] = "ON"
    status[4] = "OFF"

    sasl.gl.drawRectangle(0, 0, 282, 202, bg[ignition])
    sasl.gl.drawText(font_regular, 140, 102, "L.IGN", 64, true, false, TEXT_ALIGN_CENTER, black)
    sasl.gl.drawText(font_regular, 140, 42, status[ignition], 64, true, false, TEXT_ALIGN_CENTER, black)    
end

function screen_r_ign()
    -- 2 or 3
    ignition = get(globalPropertyiae("sim/cockpit2/engine/actuators/ignition_on", 1))

    bg = {}
    bg[0] = red
    bg[1] = red
    bg[2] = green
    bg[3] = green
    bg[4] = green

    status = {}
    status[0] = "OFF"
    status[1] = "OFF"
    status[2] = "ON"
    status[3] = "ON"
    status[4] = "OFF"

    sasl.gl.drawRectangle(0, 0, 282, 202, bg[ignition])
    sasl.gl.drawText(font_regular, 140, 102, "R.IGN", 64, true, false, TEXT_ALIGN_CENTER, black)
    sasl.gl.drawText(font_regular, 140, 42, status[ignition], 64, true, false, TEXT_ALIGN_CENTER, black)
end

function screen_backup()
    backup_battery = get(sim_backup_battery)
    ignition = globalPropertyiae("sim/cockpit2/engine/actuators/ignition_on", 0)

    active_bg = red
    status = "OFF"

    if backup_battery == 1 then
        active_bg = green
        status = "IN USE"
    end

    sasl.gl.drawRectangle(0, 0, 282, 202, active_bg)
    sasl.gl.drawText(font_regular, 140, 102, "BAK UP", 64, true, false, TEXT_ALIGN_CENTER, black)
    sasl.gl.drawText(font_regular, 140, 42, status, 64, true, false, TEXT_ALIGN_CENTER, black) 
end