function OpenCupboard(room)
    TriggerEvent('disc-inventoryhud:openInventory', {
        type = _U('cupboard'),
        owner = room
    })
end
