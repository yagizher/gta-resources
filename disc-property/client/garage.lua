function OpenGarage(property)

    local options = {}
    local playerPed = GetPlayerPed(-1)
    if IsPedInAnyVehicle(playerPed) then
        table.insert(options, {
            label = 'Store Vehicle',
            action = function()
                StoreVehicle(GetVehiclePedIsIn(playerPed), property.name)
                ESX.UI.Menu.CloseAll()
            end
        })

        local menu = {
            name = 'garage',
            title = 'Garage',
            options = options
        }

        TriggerEvent('disc-base:openMenu', menu)
    else
        ESX.TriggerServerCallback('disc-property:getStoredVehicles', function(results)
            for k, v in pairs(results) do
                local props = json.decode(v.props)
                local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
                local label = ('%s - <span style="color:blue;">%s</span>'):format(vehicleName, props.plate)
                table.insert(options, {
                    label = label,
                    action = function()
                        SpawnVehicle(property.garage.coords, property.garage.heading, props)
                        ESX.UI.Menu.CloseAll()
                    end
                })
            end
            local menu = {
                name = 'garage',
                title = 'Garage',
                options = options
            }
            TriggerEvent('disc-base:openMenu', menu)
        end, property.name)
    end

end

function StoreVehicle(vehicle, propertyName)
    local props = ESX.Game.GetVehicleProperties(vehicle)

    ESX.TriggerServerCallback('disc-property:storeVehicle', function(stored)
        if stored then
            local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
            local label = ('%s - <span style="color:blue;">%s</span>'):format(vehicleName, props.plate)
            ESX.Game.DeleteVehicle(vehicle)
            exports['mythic_notify']:DoHudText('success', 'Storing ' .. label)
        else
            exports['mythic_notify']:DoHudText('error', 'Failed to Store Vehicle')
        end
    end, propertyName, props)
end

function SpawnVehicle(garageCoords, heading, props)
    local playerPed = GetPlayerPed(-1)
    local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
    local label = ('%s - <span style="color:blue;">%s</span>'):format(vehicleName, props.plate)
    ESX.Game.SpawnVehicle(props.model, garageCoords, heading, function(vehicle)
        ESX.Game.SetVehicleProperties(vehicle, props)
        TriggerServerEvent('disc-property:spawnVehicle', props.plate)
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        exports['mythic_notify']:DoHudText('success', 'Spawned ' .. label)
    end)
end