resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

client_scripts {
    'config/config.lua',
    'config/configcolours.lua',
    'client/main.lua',
    'client/vehicles.lua',
    'client/crimes.lua',
    'utils/utils.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config/config.lua',
    'server/main.lua',
    'server/vehicles.lua',
    'server/crimes.lua',
    'utils/utils.lua',
}

ui_page "html/html/index.html"

files {
    "html/html/main.js",
    "html/html/index.html"
}
