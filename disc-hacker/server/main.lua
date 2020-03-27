ESX = nil
local CopsConnected  = 0

TriggerEvent('esx:getSharedObject', function(obj)
    ESX = obj
end)

function CountCops()

    local xPlayers = ESX.GetPlayers()

    CopsConnected = 0

    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            CopsConnected = CopsConnected + 1
        end
    end

    SetTimeout(120 * 1000, CountCops)
end

ESX.RegisterUsableItem('hacktool', function(source)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayers = ESX.GetPlayers()
        local cops = 0
        for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
                cops = cops + 1
            end
        end

        if cops >= 2 then

    TriggerClientEvent('disc-hacker:OpenTool', source)
        else
    TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Not enough cops'}, 20000)
     end
end)

RegisterServerEvent('disc-hacker:sendCommand')
AddEventHandler('disc-hacker:sendCommand', function(data)
    if data.app == 'root' then
        TriggerClientEvent('disc-hacker:addLine', source, data.code .. ' is not a valid root command')
    elseif data.app == 'atm' then
        StartATMHack(source, data)
    end
end)

function StartBruteForce(src, max, endFunction, procFunction, continueFunction)
    Citizen.CreateThread(function()
        TriggerClientEvent('disc-hacker:startHack', src, 'bruteforce')
        local target = math.random(max)
        local atTarget = false
        while not atTarget and continueFunction() do
            procFunction()
            local aim = math.random(max)
            if aim == target then
                atTarget = true
                endFunction()
                TriggerClientEvent('disc-hacker:success', src, aim)
            end
            Citizen.Wait(Config.BruteForce.ThreadSleep)
        end
    end)
end
