ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterServerCallback('disc-mdt:searchCivilians', function(source, cb, search)
    MySQL.Async.fetchAll('SELECT * FROM users WHERE lower(firstname) LIKE lower(@name)', {
        ['@name'] = '%' .. search .. '%'
    }, function(results)
        cb(results)
    end)
end)

