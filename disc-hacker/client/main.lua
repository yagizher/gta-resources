local PlayerHasProp = false

RegisterNetEvent('disc-hacker:success')
AddEventHandler('disc-hacker:success', function(code)
    SendNUIMessage({
        type = "SUCCESS",
        data = {
            code = code
        }
    })
    stopAnim()
end)

RegisterNetEvent('disc-hacker:failure')
AddEventHandler('disc-hacker:failure', function()
    SendNUIMessage({
        type = "FAILURE",
    })
    stopAnim()
end)

RegisterNetEvent('disc-hacker:notACmd')
AddEventHandler('disc-hacker:notACmd', function()
    SendNUIMessage({
        type = "NOT_A_CMD"
    })
end)

RegisterNetEvent('disc-hacker:addLine')
AddEventHandler('disc-hacker:addLine', function(line)
    SendNUIMessage({
        type = "ADD_LINE",
        data = {
            line = line
        }
    })
end)

RegisterNUICallback('Command', function(data, cb)
    data.coords = GetEntityCoords(PlayerPedId())
    local atm, atmDistance, atmCoords = FindNearestATM()
    data.atmCoords = atmCoords
    TriggerServerEvent('disc-hacker:sendCommand', data)
    cb('OK')
end)

RegisterNetEvent('disc-hacker:OpenTool')
AddEventHandler('disc-hacker:OpenTool', function()
    SendNUIMessage({
        type = "APP_SHOW"
    })
    SetNuiFocus(true, true)
end)

RegisterNUICallback('Close', function(data, cb)
    SetNuiFocus(false, false)
    cb('OK')
end)


RegisterNetEvent('disc-hacker:startHack')
AddEventHandler('disc-hacker:startHack', function(t)
    SendNUIMessage({
        type = "START_HACK",
        data = {
            hackType = t
        }
    })
    startAnim()
end)

RegisterNetEvent('disc-hacker:distanceCheck')
AddEventHandler('disc-hacker:distanceCheck', function(coords, maxDistance, event)
    local pedCoords = GetEntityCoords(PlayerPedId())
    local distance = #(coords - pedCoords)
    if distance > maxDistance then
        TriggerServerEvent('disc-hacker:' .. event)
        stopAnim()
    end
end)


local temp = false
function startAnim()
    Citizen.CreateThread(function()
    
      if not temp then
           RequestAnimDict("amb@world_human_tourist_map@male@base")
              while not HasAnimDictLoaded("amb@world_human_tourist_map@male@base") do
                Citizen.Wait(0)
              end
          attachObject()
          TaskPlayAnim(GetPlayerPed(-1), "amb@world_human_tourist_map@male@base", "base" ,8.0, -8.0, -1, 50, 0, false, false, false)
          temp = true
      end
    end)
end

function attachObject()
    tab = CreateObject(GetHashKey("prop_cs_tablet"), 0, 0, 0, true, true, true)
    --AttachEntityToEntity(tab, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.17, 0.10, -0.13, 20.0, 180.0, 180.0, true, true, false, true, 1, true)
    PlayerHasProp = true
end

function stopAnim()
    temp = false
    tab = CreateObject(GetHashKey("prop_cs_tablet"), 0, 0, 0, true, true, true)
    StopAnimTask(GetPlayerPed(-1), "amb@world_human_tourist_map@male@base", "base" ,8.0, -8.0, -1, 50, 0, false, false, false)
    DeleteEntity(tab)
    PlayerHasProp = false
end
