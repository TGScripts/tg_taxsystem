function GetCurrentVersion()
	return GetResourceMetadata( GetCurrentResourceName(), "version" )
end

Citizen.CreateThread( function()
    updatePath = "/LetsTiger/tg_taxsystem"
    resourceName = "Tax System Script ("..GetCurrentResourceName()..")"
    
    function checkVersion(err,responseText, headers)
        curVersion = GetResourceMetadata(GetCurrentResourceName(), "version")
        newVersion = tonumber(responseText)

        if curVersion ~= responseText and tonumber(curVersion) < tonumber(responseText) then
            rio = true
            responseText = responseText
            curVersion = curVersion
            updatePath = updatePath
        elseif tonumber(curVersion) > tonumber(responseText) then
            svs = true
        else
            utd = true
        end
    end
    
    PerformHttpRequest("https://raw.githubusercontent.com"..updatePath.."/master/version", checkVersion, "GET")
end)

function Resourcestart()
    print('^4.-------------------------------------------------------------------------------------------------------------------.')
    print('^4|^0                                              Tax System Script                                                    ^4|')
    print('^4|^0                                       <Made by Tiger (Lets_Tiger#4159)>                                           ^4|')
    print('^4|-------------------------------------------------------------------------------------------------------------------|')

    if rio then
        print("^4|▶ ^0[^1ERROR^0] ^1"..resourceName.." ist veraltet! Bitte updaten: https://github.com/LetsTiger/tg_taxsystem/      ^4|")
        print("^4|▶ ^0[^5INFO^0] Deine Version: [^1"..curVersion.."^0]                                                              ^4|")
        print("^4|▶ ^0[^5INFO^0] Neuste Version: [^2"..newVersion.."^0]                                                             ^4|")
    elseif svs then
        print("^4|▶ ^0[^1ERROR^0] ^1Irgendwie hast du ein paar Versionen vom "..resourceName.." übersprungen oder Github ist offline, wenn Github noch online ist bitte die neueste Version herunterladen.")
        print("^4|▶ ^0[^5INFO^0] Deine Version: [^1"..curVersion.."^0]                                                              ^4|")
        print("^4|▶ ^0[^5INFO^0] Neuste Version: [^2"..newVersion.."^0]                                                             ^4|")
    elseif utd then
        print("^4|▶ ^0[^5INFO^0] Du hast die aktuellste Version vom "..resourceName..", viel Spaß!                       ^4|")
        print("^4|▶ ^0[^5INFO^0] Deine Version: [^2"..curVersion.."^0]                                                                                      ^4|")
        print("^4|▶ ^0[^5INFO^0] Neuste Version: [^2"..newVersion.."^0]                                                                                     ^4|")
    else
        print("^4|▶ ^0[^1ERROR^0] ^1Es ist etwas schiefgelaufen bitte kontaktiere den Ersteller!")
    end

    print('^4`-------------------------------------------------------------------------------------------------------------------´^0')
end

CreateThread(function()
    Citizen.Wait(2100)
    Resourcestart()
end)