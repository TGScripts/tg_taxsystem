function GetCurrentVersion()
    local version = GetResourceMetadata(GetCurrentResourceName(), "version")
    if version == nil then
        print("^1ERROR: Version konnte nicht aus dem fxmanifest.lua ausgelesen werden!^0")
        return "0.0.0"
    end
    return version
end

function compareVersions(version1, version2)
    local v1Parts = {}
    local v2Parts = {}
    
    for part in string.gmatch(version1, "%d+") do
        table.insert(v1Parts, tonumber(part))
    end
    for part in string.gmatch(version2, "%d+") do
        table.insert(v2Parts, tonumber(part))
    end
    
    for i = 1, math.min(#v1Parts, #v2Parts) do
        if v1Parts[i] < v2Parts[i] then
            return -1
        elseif v1Parts[i] > v2Parts[i] then
            return 1
        end
    end
    
    if #v1Parts < #v2Parts then
        return -1
    elseif #v1Parts > #v2Parts then
        return 1
    end

    return 0
end

Citizen.CreateThread(function()
    local versionRepoUrl = "https://raw.githubusercontent.com/TGScripts/tg_script_versions/main/versions.json"
    local resourceName = "Tax System Script (" .. GetCurrentResourceName() .. ")"
    local scriptName = "tg_taxsystem"

    function checkVersion(err, responseText, headers)
        local curVersion = GetCurrentVersion()

        if Config.Debug then
            print("[^3DEBUG^0] ^5Aktuelle Version des Scripts: " .. curVersion .. "^0")
        end

        if err ~= 200 then
            printError("Fehler beim Abrufen der Versionsdaten. HTTP-Status: " .. tostring(err))
            return
        end
        
        if not responseText or responseText == "" then
            printError("Die Versionsdaten sind leer oder ungültig.")
            return
        end

        local allVersions = json.decode(responseText)
        if allVersions and allVersions[scriptName] then
            local newVersion = allVersions[scriptName]
            
            if Config.Debug then
                print("[^3DEBUG^0] ^5Neue Version aus JSON: " .. newVersion .. "^0")
            end

            local compareResult = compareVersions(curVersion, newVersion)

            if compareResult == -1 then
                printVersionInfo("veraltet", curVersion, newVersion)
            elseif compareResult == 1 then
                printVersionInfo("übersprungen", curVersion, newVersion)
            else
                printVersionInfo("aktuell", curVersion, newVersion)
            end
        else
            printError("Die Versionsnummer für das Script '" .. scriptName .. "' konnte nicht gefunden werden!")
        end
    end

    function printVersionInfo(status, curVersion, newVersion)
        print('^4.-------------------------------------------------------------------------------------------------------------------.')
        print('^4|^0                                            TG Tax System Script                                                   ^4|')
        print('^4|^0                                    <Made by Tiger (Discord: lets_tiger)>                                          ^4|')
        print('^4|-------------------------------------------------------------------------------------------------------------------|')

        if status == "veraltet" then
            print("^4|▶ ^0[^1ERROR^0] ^1" .. resourceName .. " ist veraltet! Bitte updaten: https://github.com/TGScripts/tg_taxsystem       ^4|")
            print("^4|▶ ^0[^5INFO^0] Deine Version: [^1" .. curVersion .. "^0]                                                              ^4|")
            print("^4|▶ ^0[^5INFO^0] Neuste Version: [^2" .. newVersion .. "^0]                                                             ^4|")
        elseif status == "übersprungen" then
            print("^4|▶ ^0[^1ERROR^0] ^1Du hast einige Versionen des " .. resourceName .. " übersprungen! Bitte die neueste Version herunterladen.")
            print("^4|▶ ^0[^5INFO^0] Deine Version: [^1" .. curVersion .. "^0]                                                                                    ^4|")
            print("^4|▶ ^0[^5INFO^0] Neuste Version: [^2" .. newVersion .. "^0]                                                                                     ^4|")
        elseif status == "aktuell" then
            print("^4|▶ ^0[^5INFO^0] Du hast die aktuellste Version vom " .. resourceName .. ", viel Spaß!                           ^4|")
            print("^4|▶ ^0[^5INFO^0] Deine Version: [^2" .. curVersion .. "^0]                                                                                    ^4|")
            print("^4|▶ ^0[^5INFO^0] Neuste Version: [^2" .. newVersion .. "^0]                                                                                   ^4|")
        end

        print('^4`-------------------------------------------------------------------------------------------------------------------´^0')
    end

    function printError(msg)
        print('^4.-------------------------------------------------------------------------------------------------------------------.')
        print('^4|^0                                            TG Tax System Script                                                   ^4|')
        print('^4|^0                                    <Made by Tiger (Discord: lets_tiger)>                                          ^4|')
        print('^4|-------------------------------------------------------------------------------------------------------------------|')
        print("^4|▶ ^0[^1ERROR^0] ^1" .. msg)
        print('^4`-------------------------------------------------------------------------------------------------------------------´^0')
    end

    PerformHttpRequest(versionRepoUrl, checkVersion, "GET")
end)

CreateThread(function()
    Citizen.Wait(2100)
end)