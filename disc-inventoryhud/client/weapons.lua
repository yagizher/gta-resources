local currentWeapon

RegisterNetEvent('disc-inventoryhud:useWeapon')
AddEventHandler('disc-inventoryhud:useWeapon', function(weapon)
    if currentWeapon == weapon then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        return
    elseif currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
    end
    currentWeapon = weapon
    GiveWeapon(currentWeapon)
end)

RegisterNetEvent('disc-inventoryhud:removeCurrentWeapon')
AddEventHandler('disc-inventoryhud:removeCurrentWeapon', function()
    if currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
    end
end)

function RemoveWeapon(weapon)
    local playerPed = GetPlayerPed(-1)
    local hash = GetHashKey(weapon)
    local ammoCount = GetAmmoInPedWeapon(playerPed, hash)
    TriggerServerEvent('disc-inventoryhud:updateAmmoCount', hash, ammoCount)
    RemoveWeaponFromPed(playerPed, hash)
end

function GiveWeapon(weapon)
    local playerPed = GetPlayerPed(-1)
    local hash = GetHashKey(weapon)
    ESX.TriggerServerCallback('disc-inventoryhud:getAmmoCount', function(ammoCount)
        GiveWeaponToPed(playerPed, hash, 1, false, true)
        SetPedAmmo(playerPed, hash, ammoCount)
    end, hash)
end
