local shopSecondaryInventory = {
    type = 'shop',
    owner = ''
}

Citizen.CreateThread(function()
	for k,v in pairs(Config.Shops) do
		for i = 1, #v.coords, 1 do
			local blip = AddBlipForCoord(v.coords[i].x, v.coords[i].y, v.coords[i].z)
			SetBlipSprite (blip, 52)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.0)
			SetBlipColour (blip, 2)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(k)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

Citizen.CreateThread(function()
    for k, v in pairs(Config.Shops) do
        for val, coords in pairs(v.coords) do
            local marker = {
                name = k .. val,
                coords = coords,
                type = v.markerType or 1,
                colour = v.markerColour or { r = 55, b = 255, g = 55 },
                size = v.size or vector3(0.5, 0.5, 1.0),
                action = function()
                    shopSecondaryInventory.owner = k
                    openInventory(shopSecondaryInventory)
                end,
                shouldDraw = function()
                    return ESX.PlayerData.job.name == v.job or v.job == 'all'
                end,
                msg = v.msg or 'Press ~INPUT_CONTEXT~ to open Shop',
            }
            TriggerEvent('disc-base:registerMarker', marker)
        end
    end
end)
