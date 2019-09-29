ESX.RegisterServerCallback('disc-property:getInventory', function(source, cb)
    local player = ESX.GetPlayerFromId(source)
    cb({
        items = player.inventory,
        blackMoney = player.getAccount('black_money').money,
        money = player.getMoney(),
        weapons = player.loadout
    })
end)

ESX.RegisterServerCallback('disc-property:getPropertyInventoryFor', function(source, cb, name)
    MySQL.Async.fetchAll('SELECT data FROM disc_property_inventory WHERE inventory_name = @name', {
        ['@name'] = name
    }, function(results)
        if #results == 0 then
            cb(nil)
        else
            cb(json.decode(results[1].data))
        end
    end)
end)

RegisterServerEvent('disc-property:createPropertyInventoryFor')
AddEventHandler('disc-property:createPropertyInventoryFor', function(name)
    MySQL.Async.execute(
            [[
                INSERT INTO disc_property_inventory (inventory_name, data) VALUES (@name, '{}')
            ]], {
                ['@name'] = name
            })
end)

RegisterServerEvent('disc-property:putItemInPropertyFor')
AddEventHandler('disc-property:putItemInPropertyFor', function(name, item, count)
    local source = source
    MySQL.Async.fetchAll('SELECT * FROM disc_property_inventory WHERE inventory_name = @name', {
        ['@name'] = name
    }, function(results)
        local data = json.decode(results[1].data)
        local found = false

        if data[item.type] == nil then
            data[item.type] = {}
        end

        for k, v in pairs(data[item.type]) do
            if v.name == item.name then
                data[item.type][k].count = data[item.type][k].count + count
                found = true
            end
        end
        if not found then
            table.insert(data[item.type], {
                name = item.name,
                count = count
            })
        end
        MySQL.Async.execute('UPDATE disc_property_inventory SET data = @data WHERE inventory_name = @name', {
            ['@data'] = json.encode(data),
            ['@name'] = name
        }, function()
            local player = ESX.GetPlayerFromId(source)
            if item.type == 'item_standard' then
                player.removeInventoryItem(item.name, count)
            elseif item.type == 'item_weapon' then
                player.removeWeapon(item.name)
            elseif item.type == 'item_account' then
                player.removeAccountMoney(item.name, count)
            elseif item.type == 'item_money' then
                player.removeMoney(count)
            end
            TriggerClientEvent('esx_inventoryhud:refreshDiscPropertyInventory', source)
        end)
    end)
end)

RegisterServerEvent('disc-property:takeItemFromProperty')
AddEventHandler('disc-property:takeItemFromProperty', function(name, item, count)
    local source = source
    MySQL.Async.fetchAll('SELECT * FROM disc_property_inventory WHERE inventory_name = @name', {
        ['@name'] = name
    }, function(results)
        local data = json.decode(results[1].data)

        for k, v in pairs(data[item.type]) do
            if v.name == item.name then
                data[item.type][k].count = data[item.type][k].count - count
            end
        end
        MySQL.Async.execute('UPDATE disc_property_inventory SET data = @data WHERE inventory_name = @name', {
            ['@data'] = json.encode(data),
            ['@name'] = name
        }, function()
            local player = ESX.GetPlayerFromId(source)
            if item.type == 'item_standard' then
                player.addInventoryItem(item.name, count)
            elseif item.type == 'item_weapon' then
                player.addWeapon(item.name, count)
            elseif item.type == 'item_account' then
                player.addAccountMoney(item.name, count)
            elseif item.type == 'item_money' then
                player.addMoney(count)
            end
            TriggerClientEvent('esx_inventoryhud:refreshDiscPropertyInventory', source)
        end)
    end)
end)