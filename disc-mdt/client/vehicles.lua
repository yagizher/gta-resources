RegisterNUICallback("SearchVehicles", function(data, cb)
    local model = GetHashKey(data.search:upper())
    local vehicleName = GetDisplayNameFromVehicleModel(-1008861746)
    print(vehicleName)
    ESX.TriggerServerCallback("disc-mdt:searchVehicles", function(vehicles)
        local formatVehicles = {}
        for k, v in ipairs(vehicles) do
            v.props = json.decode(v.vehicle)
            print(v.props.plate)
            table.insert(formatVehicles, formatVehicle(v))
        end

        SendNUIMessage({
            type = "SET_VEHICLES",
            data = {
                vehicles = formatVehicles
            }
        })
    end, data.search, model)
    cb('OK')
end)