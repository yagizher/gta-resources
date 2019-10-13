local shopSecondaryInventory = {
    type = 'shop',
    owner = ''
}

Citizen.CreateThread(function()
    print('Working')
    for k, v in pairs(Config.Shops) do
        local marker = {
            name = k,
            type = 1,
            coords = v.coords,
            colour = { r = 55, b = 255, g = 55 },
            size = vector3(0.5, 0.5, 1.0),
            action = function()
                shopSecondaryInventory.owner = k
                openInventory(shopSecondaryInventory)
            end,
            msg = 'Press ~INPUT_CONTEXT~ to open Shop',
        }
        TriggerEvent('disc-base:registerMarker', marker)
    end
end)
