ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('disc-crafting:getInventory', function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    local itemsObject = {}
    for k, esxItem in ipairs(player.getInventory()) do
        if esxItem.count > 0 then
            local item = {
                id = esxItem.name,
                itemId = esxItem.name,
                qty = esxItem.count,
                label = esxItem.label,
            }
            table.insert(itemsObject, item)
        end
    end

    cb(player.identifier, itemsObject)
end)

function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

RegisterServerEvent('disc-crafting:craft')
AddEventHandler('disc-crafting:craft', function(bench, craftingData)
    for k, recipeName in pairs(bench.recipes) do
        local recipe = Config.Recipes[recipeName]
        if recipe.fuzzy then

        else
            if #recipe.items ~= #craftingData then
                return
            end

            for i = 1, #recipe.items, 1 do
                if recipe.items[i] ~= craftingData[i].itemId then
                    return
                end
            end

            local player = ESX.GetPlayerFromId(source)
            for k, v in ipairs(recipe.items) do
                player.removeInventoryItem(v, 1)
            end
            player.addInventoryItem(recipe.item, recipe.count)
            TriggerClientEvent('disc-crafting:crafted', source)
        end
    end
end)