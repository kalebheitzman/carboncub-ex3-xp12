---------------
-- Left Screens
---------------

-- EGT CHT Screen
function egt_cht_screen()
    -- egt/cht scan
    sasl.gl.drawText(font_regular, 45, 445, "EGT/CHT", 40, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, 45, 330, "EGT", 35, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, 45, 220, "CHT", 35, false, false, TEXT_ALIGN_LEFT, white)

    -- redlines
    sasl.gl.drawWideLine(105, 339, 520, 339, 2, white)
    sasl.gl.drawWideLine(105, 229, 520, 229, 2, red)

    -- engines
    egt_cht_bars(1, 165)
    egt_cht_bars(2, 255)
    egt_cht_bars(3, 345)
    egt_cht_bars(4, 435)
end

-- egt cht bars
function egt_cht_bars(engine, x)
    -- screen indicator
    sasl.gl.drawTriangle(12, 470, 32, 455, 12, 440, blue)

    -- base
    local base = 95

    -- egt
    local egt_h = 339
    local egt_max = 3000
    local egt = c_to_f(get(sim_EGT_CYL_deg_C, engine))
    local egt_ratio = (egt+base)/egt_max
    local egt_bar_h = math.floor(egt_h*egt_ratio)
    sasl.gl.drawWideLine(x-10, base, x-10, egt_bar_h, 28, blue)

    -- cht
    local cht_h = 229
    local cht_max = 600
    local cht = c_to_f(get(sim_CHT_CYL_deg_C, engine))
    local cht_ratio = (cht+base)/cht_max
    local cht_bar_h = math.floor(cht_h*cht_ratio)
    sasl.gl.drawWideLine(x+30, base, x+30, cht_bar_h, 20, green)

    -- selected cyl
    if (engine == get(cc_engine_sel_cyl)) then
        sasl.gl.drawFrame(x-8, 370, 38, 38, white)
    end

    -- engine no
    sasl.gl.drawText(font_regular, x, 380, engine, 36, false, false, TEXT_ALIGN_LEFT, white)
end

function times_screen()
    -- flight time
    sasl.gl.drawText(font_regular, 70, 350, "FLT", 40, false, false, TEXT_ALIGN_LEFT, white)

    -- local time
    sasl.gl.drawText(font_regular, 70, 245, "LOCAL", 35, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, 500, 245, format_time(sim_local_hours, sim_local_minutes, sim_local_seconds), 40, false, false, TEXT_ALIGN_RIGHT, green)

    -- zulu time
    sasl.gl.drawText(font_regular, 70, 143, "ZULU", 35, false, false, TEXT_ALIGN_LEFT, white)
    sasl.gl.drawText(font_regular, 500, 143, format_time(sim_zulu_hours, sim_zulu_minutes, sim_zulu_seconds), 40, false, false, TEXT_ALIGN_RIGHT, green)

end