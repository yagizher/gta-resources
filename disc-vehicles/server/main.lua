ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

ESX.RegisterUsableItem('lockpick', function(source)
    TriggerClientEvent('disc-vehicles:useLockpick', source)
end)