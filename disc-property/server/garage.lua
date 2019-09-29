ESX.RegisterServerCallback('disc-property:storeVehicle', function(source, cb, propertyName, props)
    MySQL.Async.execute('INSERT INTO disc_property_garage_vehicles (name, plate, props) VALUES (@name, @plate, @props)', {
        ['@name'] = propertyName,
        ['@plate'] = props.plate,
        ['@props'] = json.encode(props)
    }, function()
        cb(true)
    end)
end)

ESX.RegisterServerCallback('disc-property:getStoredVehicles', function(source, cb, propertyName)
    MySQL.Async.fetchAll('SELECT * FROM disc_property_garage_vehicles WHERE name = @name', {
        ['@name'] = propertyName
    }, function(results)
        cb(results)
    end)
end)

RegisterServerEvent('disc-property:spawnVehicle')
AddEventHandler('disc-property:spawnVehicle', function(plate)
    MySQL.Async.execute('DELETE FROM disc_property_garage_vehicles where plate = @plate', {
        ['@plate'] = plate,
    })
end)
