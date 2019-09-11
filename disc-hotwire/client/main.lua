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

RegisterNetEvent('disc-hotwire:hotwire')
AddEventHandler('disc-hotwire:hotwire', function()
    local playerPed = GetPlayerPed(-1)

    if not IsPedInAnyVehicle(playerPed) then
        return
    end

    local veh = GetVehiclePedIsIn(playerPed)

    if GetIsVehicleEngineRunning(veh) or IsVehicleEngineStarting(veh) then
        return
    end

    for i = 0, Config.Stages, 1 do
        exports['mythic_notify']:DoHudText('inform', 'Starting Stage ' .. i)
        Citizen.Wait(Config.HotwireTime)
    end
    exports['mythic_notify']:DoHudText('success', 'Ignition Wired!')
    SetVehicleEngineOn(veh, true, false)
end)
