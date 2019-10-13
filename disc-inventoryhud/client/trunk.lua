local trunkSecondaryInventory = {
    type = 'trunk',
    owner = 'XYZ123'
}

local openVehicle

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if IsControlJustReleased(0, Config.TrunkOpenControl) then
            local vehicle = ESX.Game.GetVehicleInDirection()
            if DoesEntityExist(vehicle) then
                local locked = GetVehicleDoorLockStatus(vehicle) == 2
                local hasBoot = DoesVehicleHaveDoor(vehicle, 5)
                if not locked and hasBoot then
                    local boneIndex = GetEntityBoneIndexByName(vehicle, 'boot')
                    local vehicleCoords = GetWorldPositionOfEntityBone(vehicle, boneIndex)
                    local playerCoords = GetEntityCoords(GetPlayerPed(-1))
                    local distance = GetDistanceBetweenCoords(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, playerCoords.x, playerCoords.y, playerCoords.z, true)
                    if distance < 2 then
                        trunkSecondaryInventory.owner = GetVehicleNumberPlateText(vehicle)
                        openVehicle = vehicle
                        SetVehicleDoorOpen(openVehicle, 5, false)
                        openInventory(trunkSecondaryInventory)
                    end
                end
            end
        end
    end
end
)

RegisterNUICallback('NUIFocusOff', function()
    if openVehicle ~= nil then
        SetVehicleDoorShut(openVehicle, 5, false)
        openVehicle = nil
    end
end)