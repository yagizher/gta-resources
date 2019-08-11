ESX = nil
dragStatus = {}
dragStatus.isDragged = false
isInVehicle = false
InVehicle = nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)


Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
        if IsControlJustReleased(0, 110) then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			local targetPed = GetPlayerPed(closestPlayer)
			local isInCar = IsPedSittingInAnyVehicle(PlayerPedId())
            if closestPlayer ~= -1 and closestDistance <= 3.0 and not isInCar and IsPedDeadOrDying(targetPed) then
                TriggerServerEvent('dragme:drag', GetPlayerServerId(closestPlayer))
            end
        elseif IsControlJustReleased(0, 109) then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			local targetPed = GetPlayerPed(closestPlayer)
			local isInCar = IsPedSittingInAnyVehicle(PlayerPedId())
			if closestPlayer ~= -1 and closestDistance <= 3.0 and not isInCar and IsPedDeadOrDying(targetPed) then
				local vehicle = ESX.Game.GetClosestVehicle()
				if DoesVehicleHaveDoor(vehicle, 5) then
					TriggerServerEvent('dragme:putInVehicle', GetPlayerServerId(closestPlayer))
				else
					exports['mythic_notify']:DoHudText('error', 'This car does not have a boot.')
				end
            end
        elseif IsControlJustReleased(0, 108) then
            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			local targetPed = GetPlayerPed(closestPlayer)
			local isInCar = IsPedSittingInAnyVehicle(PlayerPedId())
            if closestPlayer ~= -1 and closestDistance <= 3.0 and not isInCar and IsPedDeadOrDying(targetPed) then
                TriggerServerEvent('dragme:OutVehicle', GetPlayerServerId(closestPlayer))
			end
        end
    end
end)


RegisterNetEvent('dragme:drag')
AddEventHandler('dragme:drag', function(draggerId)
	dragStatus.isDragged = not dragStatus.isDragged
	dragStatus.draggerId = draggerId
	isInVehicle = false
	vehicle = nil
end)

RegisterNetEvent('dragme:detach')
AddEventHandler('dragme:detach', function()
	dragStatus.isDragged = false
	isInVehicle = false
	vehicle = nil
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(0)

        if IsControlJustReleased(0, 179) and not isInVehicle then
			playerPed = PlayerPedId()
            dragStatus.isDragged = false
            DetachEntity(playerPed, true, false)
        end

		if not isInVehicle then
			SetEntityVisible(GetPlayerPed(-1), true)
		end

		if true then
			playerPed = PlayerPedId()

			if not IsPedDeadOrDying(playerPed) then
				isInVehicle = false
			end

			if dragStatus.isDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(dragStatus.draggerId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) and not IsPedSittingInAnyVehicle(playerPed) and IsPedDeadOrDying(playerPed) and not isInVehicle then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					dragStatus.isDragged = false
					DetachEntity(playerPed, true, false)
				end
			elseif isInVehicle then
				local boneIndex = GetEntityBoneIndexByName(InVehicle, 'boot')
				AttachEntityToEntity(playerPed, InVehicle, boneIndex, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, true, true, 2, true)
			else
				isInVehicle = false
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('dragme:putInVehicle')
AddEventHandler('dragme:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			SetEntityVisible(GetPlayerPed(-1), false)
			dragStatus.isDragged = false
			SetCarBootOpen(vehicle)
			isInVehicle = true
			InVehicle = vehicle
		end
	end
end)

RegisterNetEvent('dragme:OutVehicle')
AddEventHandler('dragme:OutVehicle', function()
	SetEntityVisible(GetPlayerPed(-1), true)
	isInVehicle = false
	vehicle = nil
	SetCarBootOpen(vehicle)
end)


