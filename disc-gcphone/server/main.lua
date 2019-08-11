ESX                       = nil
local PhoneNumbers        = {}


TriggerEvent('esx:getSharedObject', function(obj)
  ESX = obj
end)

AddEventHandler('esx_phone:registerNumber', function(number, type, sharePos, hasDispatch, hideNumber, hidePosIfAnon)
    PhoneNumbers[number] = {
        type = type,
        rNumber = getPhoneRandomNumber()
    }
end)


function getPhoneRandomNumber()
    local numBase0 = math.random(100,999)
    local numBase1 = math.random(0,9999)
    local num = string.format("%03d-%04d", numBase0, numBase1 )
	return num
end


RegisterServerEvent('disc-gcphone:sendRandomMessage')
AddEventHandler('disc-gcphone:sendRandomMessage', function(number, message, serverId)
    TriggerEvent('gcPhone:_internalAddMessage', getPhoneRandomNumber(), number, message, 0, function (smsMess)
        TriggerClientEvent("gcPhone:receiveMessage", serverId, smsMess)
    end)
end)

RegisterServerEvent('disc-gcphone:sendMessageFrom')
AddEventHandler('disc-gcphone:sendMessageFrom', function(from, number, message, serverId)
    TriggerEvent('gcPhone:_internalAddMessage', from, number, message, 0, function (smsMess)
        TriggerClientEvent("gcPhone:receiveMessage", serverId, smsMess)
    end)
end)