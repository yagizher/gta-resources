ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj)
            ESX = obj
        end)
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

Citizen.CreateThread(function()
    Citizen.Wait(0)
    for k, v in pairs(Config.Teleporters) do
        local marker = {
            name = v.name .. '_teleporter',
            type = 1,
            coords = v.coords,
            colour = v.colour,
            size = vector3(2.0, 2.0, 2.0),
            msg = 'Press ~INPUT_CONTEXT~ to Teleport to ' .. v.name,
            action = function()
                Teleport(v)
            end,
            shouldDraw = function()
                return ESX.PlayerData.job.name == v.job or v.job == 'all'
            end
        }
        TriggerEvent('disc-base:registerMarker', marker)
    end
end)

function Teleport(teleporter)
    local entity = GetPlayerPed(-1)
    if teleporter.allowVehicles and IsPedSittingInAnyVehicle(entity) then
        entity = GetVehiclePedIsIn(entity)
        if not ESX.Game.IsSpawnPointClear(teleporter.destination, 3.0) then
            exports['mythic_notify']:DoHudText('error', 'Teleport Destination Blocked for Vehicle')
            return
        end
    end
    local x, y, z = table.unpack(teleporter.destination)
    SetEntityCoords(entity, x, y, z, 0, 0, 0, false)
    SetEntityHeading(entity, teleporter.heading)
    exports['mythic_notify']:DoHudText('success', 'Teleported!')
    TriggerEvent('disc-base:hasExitedMarker')
end