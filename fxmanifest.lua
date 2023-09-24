fx_version "adamant"
game "gta5"
lua54 "yes"

shared_scripts {
    "@es_extended/imports.lua",
    "@ox_lib/init.lua",
}

server_scripts {
    "server.lua",
    "@oxmysql/lib/MySQL.lua",
}

client_scripts {
    "client.lua"
}



-- ui_page 'html/tablet.html'

-- files {
--     'html/tablet.html',
--     'html/tablet.js',
--     'html/style.css',
-- }
