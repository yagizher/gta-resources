fx_version 'adamant'

game 'gta5'

description 'Disc Vehicles'

version '1.0.0'

client_scripts {
    'client/*.lua',
    'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/*.lua'
}
