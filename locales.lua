Locales = {}

function tg_translate(str, ...)
    if Config.Debug then
        print('Current Locale:', Config.Locale)
        print('Requested Key:', str)
        
        if not Locales[Config.Locale] then
            print(('Locale [%s] does not exist'):format(Config.Locale))
            return ('Locale [%s] not found'):format(Config.Locale)
        end
    end

    local translation = Locales[Config.Locale][str]
    if not translation then
        print(('Key [%s] not found in Locale [%s]'):format(str, Config.Locale))
        return ('Translation [%s] not found'):format(str)
    end

    return string.format(translation, ...)
end

function LoadLocale(locale)
    if not Locales[locale] then
        print(('Locale [%s] not found. Ensure it is included in fxmanifest.lua'):format(locale))
        return false
    end
    return true
end
