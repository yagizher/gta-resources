ESX = nil
InvType = {
    ['unknown'] = { slots = 1, label = 'Unknown' },
}

RegisterServerEvent('disc-inventoryhud:RegisterInventory')
AddEventHandler('disc-inventoryhud:RegisterInventory', function(inventory)
    if inventory.name == nil then
        print('Requires inv name')
        return
    end

    if inventory.slots == nil then
        inventory.slots = 4
    end

    InvType[inventory.name] = inventory
end)

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterCommand('ensureInv', function(source)
    ensureInventories(source)
end)

function ensureInventories(source)
    local player = ESX.GetPlayerFromId(source)
    ensurePlayerInventory(player)
    TriggerClientEvent('disc-inventoryhud:refreshInventory', source)
end

RegisterCommand('test', function(source, args, raw)
    local str = 'x123y123z123'
    print(getCoordsFromOwner(str))
end)






