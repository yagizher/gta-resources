ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

RegisterServerEvent('disc-identification:showIdTo')
AddEventHandler('disc-identification:showIdTo', function(target)
    local player = ESX.GetPlayerFromId(source)
    MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, job FROM users WHERE identifier = @owner', {
        ['@owner'] = player.identifier
    }, function(result)
        if #result == 1 then
            TriggerClientEvent('disc-identification:showId', target, result[1])
        end
    end)
end)

ESX.RegisterUsableItem('idcard', function(source)
    TriggerClientEvent('disc-identification:idcard', source)
end)