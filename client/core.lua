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

            if distance < 8 then
                msec = 0
                DrawMarker(1, vector3(v['x1'], v['y1'], v['z1'] - 1.0), 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.1, 255,0,0, 200, 0, 0, 0, 0)
                if distance < 1 then
                    ShowFloatingHelpNotification("Pulsa ~y~E ~w~para ~g~acceder", vector3(v['x1'], v['y1'], v['z1'] + 1.0))
                    if IsControlJustPressed(0, 38) then
                        DoScreenFadeOut(500)
                        Wait(500)
                        SetPedCoordsKeepVehicle(playerPed, v['x2'], v['y2'], v['z2'])
                        DoScreenFadeIn(500)
                    end
                end
            elseif distance2 < 8 then
                msec = 0
                DrawMarker(1, vector3(v['x2'], v['y2'], v['z2'] - 1.0), 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.1, 255,0,0, 200, 0, 0, 0, 0)
                if distance2 < 1 then
                    ShowFloatingHelpNotification("Pulsa ~y~E ~w~para ~g~acceder", vector3(v['x2'], v['y2'], v['z2'] + 1.0))
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