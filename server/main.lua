ESX = nil
ESX = exports["es_extended"]:getSharedObject()

ESX.RegisterServerCallback('tg_taxsystem:getcarcount', function (source, cb)
    local _source = source
    local xPlayer     = ESX.GetPlayerFromId(_source)
    MySQL.Async.fetchAll('SELECT COUNT(*) AS COUNTER FROM owned_vehicles WHERE owner = @owner AND job LIKE "civ"', 
    {
        ['@owner'] = xPlayer.identifier
    }, 
    function (result)
        local count = result[1].COUNTER
        if count > 0 then
            cb(count)
        else
            cb(nil)
        end
    end)
end)

ESX.RegisterServerCallback('tg_taxsystem:getbankmoney', function (source, cb)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local bm = xPlayer.getAccount('bank').money
    if bm >= Config.VSPmin then
        cb(bm)
    else
        cb(nil)
    end
end)