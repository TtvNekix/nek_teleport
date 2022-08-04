ShowFloatingHelpNotification = function(msg, coords)
	AddTextEntry('aFloatingHelpNotification', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('aFloatingHelpNotification')
	EndTextCommandDisplayHelp(2, false, false, -1)
end

CreateThread(function()
    while true do
        local msec = 1000
        local playerPed = PlayerPedId()
        local pedCoords = GetEntityCoords(playerPed)
        local isInVeh = GetVehiclePedIsIn(playerPed, false)
        local inVeh = IsPedInAnyVehicle(playerPed)

        for k, v in pairs(Config['TP']['Zones']) do
            local distance = Vdist(pedCoords, v['x1'], v['y1'], v['z1'])
            local distance2 = Vdist(pedCoords, v['x2'], v['y2'], v['z2'])

            -- RGB Options
            local markerR1 = v['red1'] or 255
            local markerG1 = v['green1'] or 0
            local markerB1 = v['blue1'] or 0
            --
            local markerR2 = v['red2'] or 255
            local markerG2 = v['green2'] or 0
            local markerB2 = v['blue2'] or 0
            --

            -- Type Options
            local a1, a2, a3
            local b1, b2, b3
            local typeA = v['typeMarker1'] or 1
            local typeB = v['typeMarker2'] or 1

            if inVeh then
                a1 = 3.5
                a2 = 3.5
                a3 = 0.1
            elseif not inVeh then
                a1 = 1.0
                a2 = 1.0
                a3 = 0.1
            end
            --
            if inVeh then
                b1 = 3.5
                b2 = 3.5
                b3 = 0.1
            elseif not inVeh then
                b1 = 1.0
                b2 = 1.0
                b3 = 0.1
            end
            --

            if distance < 10 then
                msec = 0
                DrawMarker(typeA, vector3(v['x1'], v['y1'], v['z1'] - 1.0), 0, 0, 0, 0, 0, 0, a1, a2, a3, markerR1, markerG1, markerB1, 200, 0, 0, 0, 0)
                if distance < 1.25 then
                    ShowFloatingHelpNotification(v['label1'], vector3(v['x1'], v['y1'], v['z1'] + 1.0))
                    if IsControlJustPressed(0, 38) then
                        DoScreenFadeOut(500)
                        Wait(500)
                        SetPedCoordsKeepVehicle(playerPed, v['x2'], v['y2'], v['z2'])
                        DoScreenFadeIn(500)
                    end
                end
            elseif distance2 < 10 then
                msec = 0
                DrawMarker(typeB, vector3(v['x2'], v['y2'], v['z2'] - 1.0), 0, 0, 0, 0, 0, 0, b1, b2, b3, markerR2, markerG2, markerB2, 200, 0, 0, 0, 0)
                if distance2 < 1.25 then
                    ShowFloatingHelpNotification(v['label2'], vector3(v['x2'], v['y2'], v['z2'] + 1.0))
                    if IsControlJustPressed(0, 38) then
                        DoScreenFadeOut(500)
                        Wait(500)
                        SetPedCoordsKeepVehicle(playerPed, v['x1'], v['y1'], v['z1'])
                        DoScreenFadeIn(500)
                    end
                end
            end
        end

        Wait(msec)
    end
end)