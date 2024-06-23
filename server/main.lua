ESX = nil
ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('tg_taxsystem:getcarcount', function (source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
            ['@owner'] = xPlayer.identifier
        }, function(vehicles)
            local vehicleCount = #vehicles
            
            if Config.Debug then
                print("^0[^3DEBUG^0] ^1tg_taxsystem^0-getcarcount: Identifier: ^3"..xPlayer.identifier.."^0 - ID: ^3".._source.."^0 - Cars: ^3"..vehicleCount.."^0.")
            end

            cb(vehicleCount)
        end)
    end
end)

ESX.RegisterServerCallback('tg_taxsystem:getbankmoney', function (source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local bankmoney = xPlayer.getAccount(Config.Account).money

    if bankmoney >= Config.VSPmin then
        if Config.Debug == true then
            print("^0[^3DEBUG^0] ^1tg_taxsystem^0-getbankmoney^0: Identifier: ^3"..xPlayer.identifier.."^0 - ID: ^3".._source.."^0 - Bankmoney: ^3"..bankmoney.."^0 - VerSt.: ^3", bankmoney >= Config.VSPmin, "^0.")
        end

        cb(bankmoney)
    else
        cb(nil)
    end
end)

RegisterServerEvent('tg_taxsystem:tax')
AddEventHandler('tg_taxsystem:tax', function(amount)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        xPlayer.removeAccountMoney(Config.Account, amount)

        if Config.Reciever ~= "" then
            TriggerEvent('esx_addonaccount:getSharedAccount', Config.Reciever, function(account)
                account.addMoney(amount)
            end)
            if Config.Debug == true then
                print("^0[^3DEBUG^0] ^1tg_taxsystem^0: Removed ^2"..amount.."^0 from ID: ^4"..source.."^0 and added it to: ^4"..Config.Reciever.."^0")
            end
        else
            if Config.Debug == true then
                print("^0[^3DEBUG^0] ^1tg_taxsystem^0: Removed ^2"..amount.."^0 from ID: ^4"..source.."^0")
            end
        end
    else
        print('^0[^1ERROR^0] ^1tg_taxsystem^0: Player not found or invalid player ID:', source)
    end
end)