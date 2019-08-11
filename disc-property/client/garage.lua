function OpenGarage(property)

    local options = {}
    if IsPedInAnyVehicle(GetPlayerPed(-1)) then
        table.insert(options, {
            label = 'Store Vehicle'
        })
    else
        table.insert(options, {
            label = 'Take Vehicle'
        })
    end

    local menu = {
        name = 'garage',
        title = 'Garage',
        options = options
    }

    TriggerEvent('disc-base:openMenu', menu)
end