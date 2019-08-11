function OpenCupboard(room)

    local options = {
        { label = 'Take Items' },
        { label = 'Store Items' }
    }

    local menu = {
        name = 'cupboard',
        title = 'Cupboard',
        options = options
    }
    TriggerEvent('disc-base:openMenu', menu)
end