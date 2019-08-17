ESX = nil
inAnimation = false
isLockPicking = false

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

RegisterNetEvent('disc-lockpick:lockpick')
AddEventHandler('disc-lockpick:lockpick', function(withTool)
    if isLockPicking then
        return
    end

    isLockPicking = true
    local tool = Config.Tools[withTool]
    local playerPed = GetPlayerPed(-1)
    local veh, distance = ESX.Game.GetClosestVehicle()
    local count = 1
    if tool.use then
        count = 1
    else
        count = 0
    end

    if distance < 2.0 then
        if count > 1 then
            ESX.TriggerServerCallback('disc-base:takePlayerItem', function(took)
                if not took then
                    exports['mythic_notify']:DoHudText('error', 'You do not have the correct tool')
                    return
                end
                LockPick(playerPed, veh, tool)
            end, tool.itemName, count)
        else
            LockPick(playerPed, veh, tool)
        end
    end
end)

function LockPick(playerPed, veh, tool)
    Citizen.CreateThread(function()

        TaskStartScenarioInPlace(playerPed, tool.animation, 0, true)
        inAnimation = true
        Citizen.Wait(tool.time)

        inAnimation = false
        ClearPedTasksImmediately(playerPed)
        PlayVehicleDoorOpenSound(veh, 0)
        SetVehicleDoorsLockedForAllPlayers(veh, false)
        SetVehicleDoorsLocked(veh, 1)
        isLockPicking = false
    end)
end

Citizen.CreateThread(function()
    while true do
        if inAnimation then
            Citizen.Wait(0)
            DisableAllControlActions(0)
        else
            Citizen.Wait(500)
        end
    end
end)