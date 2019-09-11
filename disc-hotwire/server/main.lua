ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterUsableItem('lockpick', function(source)
    TriggerClientEvent('disc-hotwire:hotwire', source)
end)