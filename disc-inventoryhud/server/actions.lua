ESX.RegisterServerCallback('disc-inventoryhud:UseItemFromSlot', function(source, cb, slot)
    local player = ESX.GetPlayerFromId(source)
    InvType['player'].getInventory(player.identifier, function(inventory)
        if inventory[tostring(slot)] then
            local esxItem = player.getInventoryItem(inventory[tostring(slot)].name)
            if esxItem.usable then
                cb(createDisplayItem(inventory[tostring(slot)], esxItem, slot))
                return
            end
        end
        cb(nil)
    end)
end)
