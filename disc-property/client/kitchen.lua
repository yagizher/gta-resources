function OpenKitchen(property)

    local options = {
        { label = 'Take Food' },
        { label = 'Store Food' },
    }

    if IsPlayerOwnerOf(property) then
        table.insert(options, { label = 'Manage Property', action = function()
            ShowManageProperty(property)
        end })
    end

    local menu = {
        name = 'kitchen',
        title = 'Kitchen',
        options = options
    }

    TriggerEvent('disc-base:openMenu', menu)
end
