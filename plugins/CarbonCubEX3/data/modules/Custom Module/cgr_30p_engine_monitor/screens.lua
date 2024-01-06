----------
-- Screens
----------

function main_screen()
    -- lines
    sasl.gl.drawWideLine(535, 0, 535, 490, 2, white)
    sasl.gl.drawWideLine(0, 95, 1050, 95, 2, white)
    sasl.gl.drawWideLine(0, 490, 1050, 490, 2, white)
    
    egt_cht_screen()
    screen_additional_indicators()
end

function secondary_screen()
    -- lines
    sasl.gl.drawWideLine(535, 0, 535, 425, 2, white)
    sasl.gl.drawWideLine(0, 95, 1050, 95, 2, white)
    sasl.gl.drawWideLine(0, 490, 1050, 490, 2, white)
    sasl.gl.drawWideLine(100, 425, 950, 425, 2, white)
    sasl.gl.drawWideLine(100, 425, 100, 490, 2, white)
    sasl.gl.drawWideLine(383, 425, 383, 490, 2, white)
    sasl.gl.drawWideLine(667, 425, 667, 490, 2, white)
    sasl.gl.drawWideLine(950, 425, 950, 490, 2, white)

    times_screen()
    screen_secondary_indicators()
end

function gps_screen()

end