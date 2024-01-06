----------------
-- Right Screens
----------------

function screen_additional_indicators()
    -- fuel remaining
    local fuel_remaining = round2(get(sim_fuel, 1)+get(sim_fuel, 2), 2)
    sasl.gl.drawWideLine(570, 440, 1020, 440, 14, green)
    sasl.gl.drawWideLine(570, 440, 660, 440, 14, yellow)
    sasl.gl.drawWideLine(661, 433, 661, 447, 3, black)
    indicator_triangle(440, 570, 1020, 0, 44, fuel_remaining)
    sasl.gl.drawText(font_regular, 570, 380, "F REM", 46, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, 930, 373, fuel_remaining, 56, false, false, TEXT_ALIGN_RIGHT, green)
    sasl.gl.drawText(font_regular, 940, 373, "Gal", 32, false, false, TEXT_ALIGN_LEFT, white)

    -- oil pressure
    local oilp = round2(get(sim_oil_pressure_psi, 1), 2)
    sasl.gl.drawWideLine(570, 320, 1020, 320, 14, red)
    sasl.gl.drawWideLine(620, 320, 970, 320, 14, yellow)
    sasl.gl.drawWideLine(800, 320, 900, 320, 14, green)
    indicator_triangle(320, 570, 1020, 0, 200, oilp)
    sasl.gl.drawText(font_regular, 570, 260, "OIL P", 46, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, 930, 253, oilp, 56, false, false, TEXT_ALIGN_RIGHT, green)
    sasl.gl.drawText(font_regular, 940, 253, "PSI", 32, false, false, TEXT_ALIGN_LEFT, white)

    -- oil temperature
    local oilt = math.floor(get(sim_oil_temperature_deg_C, 1))
    sasl.gl.drawWideLine(570, 193, 1020, 193, 14, red)
    sasl.gl.drawWideLine(620, 193, 800, 193, 14, yellow)
    sasl.gl.drawWideLine(800, 193, 970, 193, 14, green)
    indicator_triangle(194, 570, 1020, 0, 200, oilt)
    sasl.gl.drawText(font_regular, 570, 133, "OIL T", 46, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, 930, 127, oilt, 56, false, false, TEXT_ALIGN_RIGHT, green)
    sasl.gl.drawText(font_regular, 940, 127, "°F", 32, false, false, TEXT_ALIGN_LEFT, white)

end

function screen_secondary_indicators()
    -- fuel remaining
    local fuel_remaining = round2(get(sim_fuel, 1)+get(sim_fuel, 2), 2)
    sasl.gl.drawWideLine(570, 385, 1020, 385, 14, green)
    sasl.gl.drawWideLine(570, 385, 660, 385, 14, yellow)
    sasl.gl.drawWideLine(661, 433, 661, 447, 3, black)
    indicator_triangle(385, 570, 1020, 0, 44, fuel_remaining)
    sasl.gl.drawText(font_regular, 570, 330, "F REM", 46, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, 930, 323, fuel_remaining, 56, false, false, TEXT_ALIGN_RIGHT, green)
    sasl.gl.drawText(font_regular, 940, 323, "Gal", 32, false, false, TEXT_ALIGN_LEFT, white)

    -- volts
    local volts = round2(get(sim_voltage), 2)
    sasl.gl.drawWideLine(570, 280, 1020, 280, 14, red)
    sasl.gl.drawWideLine(620, 280, 800, 280, 14, yellow)
    sasl.gl.drawWideLine(800, 280, 970, 280, 14, green)
    indicator_triangle(280, 570, 1020, 0, 28, volts)
    sasl.gl.drawText(font_regular, 570, 225, "VOLTS", 46, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, 930, 218, volts, 56, false, false, TEXT_ALIGN_RIGHT, green)
    sasl.gl.drawText(font_regular, 940, 218, "Volts", 32, false, false, TEXT_ALIGN_LEFT, white)

    -- oat
    local oat = math.floor(get(sim_outside_air_temp_degf))
    sasl.gl.drawWideLine(570, 175, 1020, 175, 14, green)
    indicator_triangle(175, 570, 1020, -30, 120, oat)
    sasl.gl.drawText(font_regular, 570, 123, "OAT", 46, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, 930, 117, oat, 56, false, false, TEXT_ALIGN_RIGHT, green)
    sasl.gl.drawText(font_regular, 940, 117, "°F", 32, false, false, TEXT_ALIGN_LEFT, white)

end