fx_version 'cerulean'
games { 'gta5' }

client_script 'client.lua'



ui_page{
    'ui/index.html'
}

files {
    'ui/*.*',
    'ui/**/*.*',
}

shared_scripts {
  '@qb-core/shared/locale.lua',
  'locales/en.lua',
  'locales/*.lua',
  'config.lua',
}


