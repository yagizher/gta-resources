RegisterNetEvent('disc-vehicles:useLockpick')
AddEventHandler('disc-vehicles:useLockpick', function()
    local playerPed = PlayerPedId()
    if IsPedInAnyVehicle(playerPed) then
        local vehicle = GetVehiclePedIsIn(playerPed)
        TrackVehicle(vehicle, false, GetIsVehicleEngineRunning(vehicle))
        if not vehicles[vehicle].state then
            exports['mythic_notify']:SendAlert('inform', 'Starting Hotwire')
            ESX.Streaming.RequestAnimDict('anim@amb@clubhouse@tutorial@bkr_tut_ig3@', function()
                TaskPlayAnim(playerPed, 'anim@amb@clubhouse@tutorial@bkr_tut_ig3@', 'machinic_loop_mechandplayer', 8.0, -8, -1, 49, 0, 0, 0, 0)
            end)
            Citizen.Wait(Config.HotWireTime)
            ClearPedSecondaryTask(playerPed)
            vehicles[vehicle].state = true
            exports['mythic_notify']:SendAlert('success', 'Hotwire completed')
        end
    else
        local vehicle = ESX.Game.GetVehicleInDirection()
        if vehicle then
            TrackVehicle(vehicle)
            Citizen.Wait(100)
            if not vehicles[vehicle].key then
                LockPick(playerPed, vehicle)
            end
        end
    end
end)

function LockPick(playerPed, veh)
    Citizen.CreateThread(function()
        ESX.Streaming.RequestAnimDict('missheistfbisetup1', function()
            TaskPlayAnim(playerPed, 'missheistfbisetup1', 'unlock_loop_janitor', 8.0, -8, -1, 49, 0, 0, 0, 0)
        end)
        inAnimation = true
        Citizen.Wait(Config.LockpickTime)
        ClearPedTasksImmediately(playerPed)
        PlayVehicleDoorOpenSound(veh, 0)
        ToggleLock(veh)
        isLockPicking = false
        exports['mythic_notify']:SendAlert('success', 'Door is open!')
    end)
end