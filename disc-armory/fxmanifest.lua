fx_version 'adamant'

game 'gta5'

description 'Disc Armory'

version '1.1.0'

client_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'config.weapons.lua',
    'client/main.lua',
    'locales/cs.lua',
    'locales/en.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/main.lua',
}
