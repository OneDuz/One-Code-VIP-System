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
