
-----------------
-- GPS Buttons --
-----------------

defineProperty("action", function() logInfo("Default action *****************************************") end)

onMouseDown = function(component, x, y, button, parentX, parentY)
    if button == MB_LEFT then
        if x > 0 and x < 300 and y > 50 and y < 273 then
            logInfo("BACK clicked")
        end

        if x > 0 and x < 300 and y > 351 and y < 610 then
            logInfo("MENU clicked")
        end

        if x > 0 and x < 300 and y > 611 and y < 981 then
            logInfo("DIRECT clicked")
        end

        if x > 0 and x < 300 and y > 982 and y < 1350 then
            logInfo("NRST clicked")
        end
    end
	-- get(action)
	return true
end

onMouseEnter = function()
    logInfo("mouse entered")
end

function draw()
    -- sasl.gl.drawRectangle(2390, 1205, 200, 300, green)
    local image = sasl.gl.loadImage("garmin_aera_796/images/nrst.png")
    sasl.gl.drawTexture(image, 110, 1140, 47, 164)

    -- sasl.gl.drawRectangle(2390, 848, 200, 300, green)
    local image = sasl.gl.loadImage("garmin_aera_796/images/direct.png")
    sasl.gl.drawTexture(image, 110, 758, 65, 147)

    -- sasl.gl.drawRectangle(2390, 489, 200, 300, green)
    local image = sasl.gl.loadImage("garmin_aera_796/images/menu.png")
    sasl.gl.drawTexture(image, 110, 465, 55, 66)

    -- sasl.gl.drawRectangle(2390, 130, 200, 300, green)
    local image = sasl.gl.loadImage("garmin_aera_796/images/back.png")
    sasl.gl.drawTexture(image, 110, 110, 77, 88)

    -- size check
    -- sasl.gl.drawRectangle(2345, 130, 210, 1375, red)
end
