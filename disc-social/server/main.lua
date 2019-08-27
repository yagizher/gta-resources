for k, v in pairs(Config.Socials) do
    RegisterCommand(v.command, function(src, args, raw)
        TriggerClientEvent('chat:addMessage', src, 'Social: ' .. v.social .. ': ' .. v.response)
    end)
end