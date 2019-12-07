ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

local isShowing = false

RegisterCommand('mdt', function()
    if not isShowing then
        SendNUIMessage({
            type = 'SET_USER',
            data = {
                player = ESX.GetPlayerData()
            }
        })
        SendNUIMessage({
            type = "APP_SHOW"
        })
        SetNuiFocus(true, true)
        isShowing = true
    else
        SendNUIMessage({
            type = "APP_HIDE"
        })
        SetNuiFocus(false, false)
        isShowing = false
    end
end)

RegisterNUICallback("CloseUI", function(data, cb)
    isShowing = false
    SetNuiFocus(false, false)
end)


function formatVehicle(vehicle)
    vehicle.model = GetDisplayNameFromVehicleModel(vehicle.props.model)
    vehicle.colorPrimary = Config.Colors[tostring(vehicle.props.color1)]
    vehicle.colorSecondary = Config.Colors[tostring(vehicle.props.color2)]
    return vehicle
end

