IsInBoot = false
InVehicle = nil

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

function GetInBoot()
    local vehicle = ESX.Game.GetClosestVehicle()
    local playerPed = GetPlayerPed(-1)
    local px, py, pz = table.unpack(GetEntityCoords(playerPed))
    local vx, vy, vz = table.unpack(GetEntityCoords(vehicle))
    if GetDistanceBetweenCoords(px, py, pz, vx, vy, vz, true) > 3.0 or IsPedInAnyVehicle(playerPed) then
        return
    end
    if Config.MustHaveBoot and not DoesVehicleHaveDoor(vehicle, 5) then
        exports['mythic_notify']:DoHudText('error', 'This car does not have a boot')
        return
    end
    if DoesEntityExist(vehicle) then
        SetEntityVisible(playerPed, false)
        IsInBoot = true
        InVehicle = vehicle
        TriggerBootAnimation()
    end
end

function TriggerBootAnimation()
    Citizen.CreateThread(function()
        SetVehicleDoorOpen(InVehicle, 5, false, true)
        Citizen.Wait(500)
        SetVehicleDoorShut(InVehicle, 5, true)
    end)
end

function GetOutOfBoot()
    if not IsInBoot then
        exports['mythic_notify']:DoHudText('error', 'You are not in a boot')
        return
    end
    if DoesEntityExist(InVehicle) then
        local playerPed = GetPlayerPed(-1)
        SetEntityVisible(playerPed, true)
        IsInBoot = false
        InVehicle = false
        TriggerBootAnimation()
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = GetPlayerPed(-1)
        if IsInBoot then
            local boneIndex = GetEntityBoneIndexByName(InVehicle, 'boot')
            AttachEntityToEntity(playerPed, InVehicle, boneIndex, 0.0, 0.0, 0.5, 0.0, 0.0, 0.0, true, false, true, 2, false)
        else
            DetachEntity(playerPed, true, false)
        end
    end
end)

RegisterCommand("getin", function(src, args, raw)
    GetInBoot()
end)

RegisterCommand("getout", function(src, args, raw)
    GetOutOfBoot()
end)