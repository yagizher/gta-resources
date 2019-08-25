resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
    'config.lua',
    'client/cupboard.lua',
    'client/kitchen.lua',
    'client/garage.lua',
    'client/clothes.lua',
    'client/main.lua',
    'client/property.lua',
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'config.lua',
    'server/main.lua',
    'server/property.lua',
    'server/clothes.lua',
    'server/inventory.lua',
}
