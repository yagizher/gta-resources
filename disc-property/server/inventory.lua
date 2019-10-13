Citizen.CreateThread(function()
    --Player
    TriggerEvent('disc-inventoryhud:RegisterInventory', {
        name = 'cupboard',
        label = 'Cupboard',
        slots = 20
    })
end)