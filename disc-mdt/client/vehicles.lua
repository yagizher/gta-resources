RegisterNUICallback("SearchVehicles", function(data, cb)
    local model = GetHashKey(data.search:upper())
    local vehicleName = GetDisplayNameFromVehicleModel(-1008861746)
    print(vehicleName)
    ESX.TriggerServerCallback("disc-mdt:searchVehicles", function(vehicles)
        local formatVehicles = {}
        for k, v in ipairs(vehicles) do
            v.props = json.decode(v.vehicle)
            table.insert(formatVehicles, formatVehicle(v))
        end

        SendNUIMessage({
            type = "SET_VEHICLES",
            data = {
                vehicles = formatVehicles
            }
        })
        cb('OK')
    end, data.search, model)
end)

RegisterNUICallback('SetVehicleImage', function(data, cb)
    ESX.TriggerServerCallback('disc-mdt:setVehicleImage', function(done)
        cb('OK')
    end, data)
end)