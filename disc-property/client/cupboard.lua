function OpenCupboard(room)
    ESX.TriggerServerCallback('disc-property:getPropertyInventoryFor', function(data)

        if data == nil then
            TriggerServerEvent('disc-property:createPropertyInventoryFor', room)
            data = {}
        end

        data.inventory_name = room

        if data.blackMoney == nil then
            data.blackMoney = 0
        end
        if data.items == nil then
            data.items = {}
        end
        if data.weapons == nil then
            data.weapons = {}
        end

        TriggerEvent('esx_inventoryhud:openDiscPropertyInventory', data)
    end, room)
end
