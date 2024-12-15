ESX = nil
ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

if not Config.UseServerTimer then
    Citizen.CreateThread(function()
        while true do
            Wait(Config.Intervall * 60000)
            TriggerServerEvent('tg_taxsystem:handleTaxes')
        end
    end)
end

RegisterNetEvent('tg_taxsystem:tg_shownotification')
AddEventHandler('tg_taxsystem:tg_shownotification', function(message, subtitle)
    tg_shownotification(message, subtitle)
end)

function tg_shownotification(message, subtitle)
    local textureDict = "TG_Textures"
    RequestStreamedTextureDict(textureDict, true)

    while not HasStreamedTextureDictLoaded(textureDict) do
        Wait(0)
    end

    BeginTextCommandThefeedPost("STRING")
    AddTextComponentSubstringPlayerName(subtitle)
    EndTextCommandThefeedPostMessagetext(textureDict, "TG_Logo", false, 9, "TG Steuern", message)

    SetStreamedTextureDictAsNoLongerNeeded(textureDict)
end