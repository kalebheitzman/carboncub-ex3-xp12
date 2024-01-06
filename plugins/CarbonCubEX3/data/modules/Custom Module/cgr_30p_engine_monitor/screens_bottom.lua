-----------------
-- Bottom Screens
-----------------

function bottom_egt_screen()
    sasl.gl.drawText(font_regular, 165, 30, "EGT:", 46, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, 455, 23, c_to_f(get(sim_EGT_CYL_deg_C, get(cc_engine_sel_cyl))), 70, false, false, TEXT_ALIGN_RIGHT, blue)
    sasl.gl.drawText(font_regular, 500, 30, "°F", 40, false, false, TEXT_ALIGN_RIGHT, white)
end

function bottom_cht_screen()
    sasl.gl.drawText(font_regular, 570, 30, "CHT:", 46, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, 865, 23, c_to_f(get(sim_CHT_CYL_deg_C, get(cc_engine_sel_cyl))), 70, false, false, TEXT_ALIGN_RIGHT, green)
    sasl.gl.drawText(font_regular, 910, 30, "°F", 40, false, false, TEXT_ALIGN_RIGHT, white)
end