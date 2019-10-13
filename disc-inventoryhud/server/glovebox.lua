Citizen.CreateThread(function()
    --Player
    TriggerEvent('disc-inventoryhud:RegisterInventory', {
        name = 'glovebox',
        label = 'Glove Box',
        slots = 5,
        getInventory = function(identifier, cb)
            getInventory(identifier, 'glovebox', cb)
        end,
        saveInventory = function(identifier, inventory)
            if table.length(inventory) > 0 then
                saveInventory(identifier, 'glovebox', inventory)
            else
                deleteInventory(identifier, 'glovebox')
            end
        end,
        getDisplayInventory = function(identifier, cb, source)
            getDisplayInventory(identifier, 'glovebox', cb, source)
        end
    })
end)