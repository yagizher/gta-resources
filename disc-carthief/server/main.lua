ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local activity = 0
local activitySource = 0
local isCooldownActive = 0

RegisterServerEvent('esx_carthief:pay')
AddEventHandler('esx_carthief:pay', function(payment)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.addAccountMoney('black_money',tonumber(payment))
	isCooldownActive = 1
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if isCooldownActive == 1 then 
			Citizen.Wait(Config.CooldownTime * 60 * 1000)
			isCooldownActive = 0
		end
	end
end)

ESX.RegisterServerCallback('esx_carthief:anycops',function(source, cb)
  local anycops = 0
  local playerList = GetPlayers()
  for i=1, #playerList, 1 do
    local _source = playerList[i]
    local xPlayer = ESX.GetPlayerFromId(_source)
    local playerjob = xPlayer.job.name
    if playerjob == 'police' then
      anycops = anycops + 1
    end
  end
  cb(anycops)
end)

ESX.RegisterServerCallback('esx_carthief:isActive',function(source, cb)
  cb(activity, isCooldownActive)
end)

ESX.RegisterUsableItem('jammer', function(source)
	TriggerClientEvent('esx_carthief:jammerActive', source)
end)

RegisterServerEvent('esx_carthief:registerActivity')
AddEventHandler('esx_carthief:registerActivity', function(value)
	activity = value
	if value == 1 then
		activitySource = source
		--Send notification to cops
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				TriggerClientEvent('esx_carthief:setcopnotification', xPlayers[i])
			end
		end
	else
		activitySource = 0
		isCooldownActive = 1
	end
end)

RegisterServerEvent('esx_carthief:alertcops')
AddEventHandler('esx_carthief:alertcops', function(cx,cy,cz)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx_carthief:setcopblip', xPlayers[i], cx,cy,cz)
		end
	end
end)

RegisterServerEvent('esx_carthief:activatedJammerCops')
AddEventHandler('esx_carthief:activatedJammerCops', function(cx,cy,cz)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx_carthief:activatedJammerCops', xPlayers[i], cx,cy,cz)
		end
	end
end)

RegisterServerEvent('esx_carthief:removeJammer')
AddEventHandler('esx_carthief:removeJammer', function()
	local player = ESX.GetPlayerFromId(source)
	player.removeInventoryItem('jammer', 1)
end)

ESX.RegisterServerCallback('esx_carthief:buyJammer',function(source, cb)
	local player = ESX.GetPlayerFromId(source)
	local playersJammers = player.getInventoryItem('jammer')
	if playersJammers.count >= playersJammers.limit then
		cb(0)
	elseif player.getAccount('black_money').money >= Config.JammerPrice then
		player.removeAccountMoney('black_money', Config.JammerPrice)
		player.addInventoryItem('jammer', 1)
		cb(1)
	else
		cb(-1)
	end
end)


RegisterServerEvent('esx_carthief:stopalertcops')
AddEventHandler('esx_carthief:stopalertcops', function()
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx_carthief:removecopblip', xPlayers[i])
		end
	end
end)

AddEventHandler('playerDropped', function ()
	local _source = source
	if _source == activitySource then
		--Remove blip for all cops
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				TriggerClientEvent('esx_carthief:removecopblip', xPlayers[i])
			end
		end
		--Set activity to 0
		activity = 0
		activitySource = 0
		isCooldownActive = 1
	end
end)