fx_version 'cerulean'
games { 'gta5' }

author 'Tiger (Lets_Tiger#4159)'
description 'Tax System'
version '1.1'

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'server/main.lua',
	'server/version_check.lua',
}

client_scripts {
	'config.lua',
	'client/main.lua',
}