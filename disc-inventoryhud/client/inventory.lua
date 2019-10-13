secondInventory = nil

RegisterNUICallback('MoveToEmpty', function(data)
    TriggerServerEvent('disc-inventoryhud:MoveToEmpty', data)
end)

RegisterNUICallback('EmptySplitStack', function(data)
    TriggerServerEvent('disc-inventoryhud:EmptySplitStack', data)
end)

RegisterNUICallback('SplitStack', function(data)
    TriggerServerEvent('disc-inventoryhud:SplitStack', data)
end)

RegisterNUICallback('CombineStack', function(data)
    TriggerServerEvent('disc-inventoryhud:CombineStack', data)
end)

RegisterNUICallback('SwapItems', function(data)
    TriggerServerEvent('disc-inventoryhud:SwapItems', data)
end)

RegisterNUICallback('GiveItem', function(data)
    TriggerServerEvent('disc-inventoryhud:notifyImpendingRemoval', data.item, data.number)
    TriggerServerEvent('disc-inventoryhud:GiveItem', data)
end)

RegisterNUICallback('GiveCash', function(data)
    TriggerServerEvent('disc-inventoryhud:GiveCash', data)
end)

RegisterNUICallback('GetNearPlayers', function(data)

    if data.action == 'give' then
        SendNUIMessage({
            action = "nearPlayersGive",
            players = GetNeareastPlayers(),
            item = data.item
        })
    end

    if data.action == 'pay' then
        SendNUIMessage({
            action = "nearPlayersPay",
            players = GetNeareastPlayers(),
        })
    end
end)

function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 2.0)

    local players_clean = {}
    local found_players = false

    for i = 1, #players, 1 do
        if players[i] ~= PlayerId() then
            found_players = true
            table.insert(players_clean, { label = GetPlayerName(players[i]), player = GetPlayerServerId(players[i]) })
        end
    end
    return players_clean
end

RegisterNetEvent('disc-inventoryhud:refreshInventory')
AddEventHandler('disc-inventoryhud:refreshInventory', function()
    refreshPlayerInventory()
    if secondInventory ~= nil then
        refreshSecondaryInventory()
    end
end)

function refreshPlayerInventory()
    ESX.TriggerServerCallback('disc-inventoryhud:getPlayerInventory', function(data)
        SendNUIMessage(
                { action = "setItems",
                  itemList = data.inventory,
                  invOwner = data.invId,
                  invTier = data.invTier,
                  money = {
                      cash = data.cash,
                      bank = data.bank,
                  }
                }
        )
        TriggerServerEvent('disc-inventoryhud:openInventory', {
            type = 'player',
            owner = ESX.GetPlayerData().identifier
        })
    end, 'player', ESX.GetPlayerData().identifier)
end

function refreshSecondaryInventory()
    ESX.TriggerServerCallback('disc-inventoryhud:getSecondaryInventory', function(data)
        SendNUIMessage(
                { action = "setSecondInventoryItems",
                  itemList = data.inventory,
                  invOwner = data.invId,
                  invTier = data.invTier,
                }
        )
        TriggerServerEvent('disc-inventoryhud:openInventory', secondInventory)
    end, secondInventory.type, secondInventory.owner)
end

function closeInventory()
    isInInventory = false
    SendNUIMessage({ action = "hide" })
    SetNuiFocus(false, false)
    TriggerServerEvent('disc-inventoryhud:closeInventory', {
        type = 'player',
        owner = ESX.GetPlayerData().identifier
    })
    if secondInventory ~= nil then
        TriggerServerEvent('disc-inventoryhud:closeInventory', secondInventory)
    end
end

function openInventory(_secondInventory)
    isInInventory = true
    refreshPlayerInventory()
    SendNUIMessage({
        action = "display",
        type = "normal"
    })
    if _secondInventory ~= nil then
        secondInventory = _secondInventory
        refreshSecondaryInventory()
        SendNUIMessage({
            action = "display",
            type = 'secondary'
        })
    end
    SetNuiFocus(true, true)
end