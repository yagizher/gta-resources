ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterUsableItem('lockpick', function(source)
    TriggerClientEvent('disc-lockpick:lockpick', source, 'lockpick')
end)

ESX.RegisterUsableItem('blowtorch', function(source)
    TriggerClientEvent('disc-lockpick:lockpick', source, 'blowtorch')
end)