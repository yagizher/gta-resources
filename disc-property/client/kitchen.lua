function OpenKitchen(property)

    local options = {
        { label = 'Take Food' },
        { label = 'Store Food' },
        { label = 'Give Keys' },
        { label = 'Take Keys' }
    }

    local menu = {
        name = 'kitchen',
        title = 'Kitchen',
        options = options
    }

    TriggerEvent('disc-base:openMenu', menu)
end
