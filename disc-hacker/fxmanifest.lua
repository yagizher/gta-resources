fx_version 'adamant'

game 'gta5'

description 'Disc Hacker'

version '1.0.0'

client_scripts {
    'config.lua',
    'client/*.lua'
}

server_scripts {
    'config.lua',
    'server/*.lua',
    "@mysql-async/lib/MySQL.lua"
}

ui_page "web/html/index.html"

files {
    "web/html/main.js",
    "web/html/index.html"
}
