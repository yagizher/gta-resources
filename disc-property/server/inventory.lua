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
    MySQL.Async.fetchAll('SELECT * FROM disc_property_inventory WHERE inventory_name = @name', {
        ['@name'] = name
    }, function(results)
        cb(results[1])
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
    MySQL.Async.fetchAll('SELECT * FROM disc_property_inventory WHERE inventory_name = @name', {
        ['@name'] = name
    }, function(results)
        local data = results[1]
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
        })
    end)
end)