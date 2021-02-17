fx_version 'cerulean'
game { 'gta5' }

author 'Pk'
version '1.0'
description 'Desenvolvido para Smash-PvP por Pk (download: https://github.com/OLucasPk/smash-pvp-base#smash-pvp-base)'

client_scripts {
	"@vrp/lib/utils.lua",
	"common/Main.lua",
	"common/*.lua",
	"client/*.lua"
}

server_scripts {
	"@vrp/lib/utils.lua",
	"common/Main.lua",
	"common/*.lua",
	"controllers/*.lua"
}