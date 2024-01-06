------------------
-- Primary Screens
------------------

function primary_mp()
    -- local fuel_flow_gph = fuel_flow(get(cc_fuel_flow_kg_sec, 1))
    sasl.gl.drawText(font_regular, 285, 540, round2(get(sim_MPR_in_hg, 1), 2), 100, false, false, TEXT_ALIGN_CENTER, green)
    sasl.gl.drawText(font_regular, 285, 650, "MP", 55, false, false, TEXT_ALIGN_CENTER, white)
    sasl.gl.drawArc(300, 500, 220, 240, 35, 110, green)
end

function primary_rpm()
    local rpm = math.floor(get(sim_prop_speed_rpm, 1))
    if (rpm < 0) then
        rpm = 0
    end
    sasl.gl.drawText(font_regular, 785, 540, rpm, 100, false, false, TEXT_ALIGN_CENTER, green)
    sasl.gl.drawText(font_regular, 785, 650, "RPM", 55, false, false, TEXT_ALIGN_CENTER, white)
    sasl.gl.drawArc(770, 500, 220, 240, 35, 110, green)
end