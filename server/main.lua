ESX = nil
ESX = exports["es_extended"]:getSharedObject()

RegisterServerEvent('tg_taxsystem:handleTaxes')
AddEventHandler('tg_taxsystem:handleTaxes', function(playerId)
    local _source = playerId or source
    local xPlayer = ESX.GetPlayerFromId(playerId)

    if not xPlayer then
        print("^0[^1ERROR^0] ^1tg_taxsystem^0: Spieler nicht gefunden oder ungültige Spieler-ID:", _source)
        return
    end

    if Config.EKS then
        local salary = xPlayer.job.grade_salary
        if salary then
            local proc = 1 - (Config.EKSP * 0.01)
            local eks = ESX.Math.Round(salary * proc)
            xPlayer.removeAccountMoney(Config.Account, eks)
            NotifyClient(_source, "tax_earning", eks)
            DistributeTaxes(eks)
        end
    end

    if Config.FZS then
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
            ['@owner'] = xPlayer.identifier
        }, function(vehicles)
            local vehicleCount = #vehicles
            local fzs = ESX.Math.Round(vehicleCount * Config.FZSP)
            xPlayer.removeAccountMoney(Config.Account, fzs)
            NotifyClient(_source, "tax_vehicle", fzs, vehicleCount)
            DistributeTaxes(fzs)
        end)
    end

    if Config.VS then
        local bankmoney = xPlayer.getAccount(Config.Account).money
        if bankmoney >= Config.VSPmin then
            local vs = ESX.Math.Round(bankmoney * (Config.VSP * 0.01))
            xPlayer.removeAccountMoney(Config.Account, vs)
            NotifyClient(_source, "tax_rich", vs)
            DistributeTaxes(vs)
        end
    end
end)

function DistributeTaxes(amount)
    if Config.Reciever and Config.Reciever ~= "" then
        TriggerEvent('esx_addonaccount:getSharedAccount', Config.Reciever, function(account)
            account.addMoney(amount)
        end)
        if Config.Debug then
            print("^0[^3DEBUG^0] Steuern verteilt: ^2" .. amount .. "^0 an " .. Config.Reciever)
        end
    end
end

function NotifyClient(source, steuertyp, amount, extra)
    local entityType = ""
    
    if steuertyp == "tax_property" then
        entityType = " "..tg_translate('extra_property')
    elseif steuertyp == "tax_vehicle" then
        entityType = " "..tg_translate('extra_vehicle')
    end

    local extraInfo = extra and (tg_translate('extra_info') .. extra .. entityType) or ""
    
    TriggerClientEvent('tg_taxsystem:tg_shownotification', source, "~r~" .. tg_translate(steuertyp), tg_translate("tax_info", amount, extraInfo))
end

if Config.UseServerTimer then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(Config.Intervall * 60000)
            local players = ESX.GetPlayers()
            for _, playerId in ipairs(players) do
                if ESX.GetPlayerFromId(playerId) then
                    TriggerEvent('tg_taxsystem:handleTaxes', playerId)
                else
                    print('^0[^1ERROR^0] ^1tg_taxsystem^0: Ungültige Spieler-ID beim Timer:', playerId)
                end
            end
        end
    end)
end