RegisterNetEvent('disc-mdt:addNotification')
AddEventHandler('disc-mdt:addNotification', function(data)
    SendNUIMessage('ADD_NOTIFICATION', {
        data = data
    })
end)