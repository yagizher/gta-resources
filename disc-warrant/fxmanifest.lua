fx_version 'adamant'

game 'gta5'

description 'Disc Warrant'

version '1.0.0'

client_scripts {
    'config.lua',
    'client/main.lua',
    'utils.lua'
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'config.lua',
    'server/main.lua',
    'utils.lua'
}
