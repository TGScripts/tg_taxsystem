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

Citizen.CreateThread(function()
	while true do
		Wait(0)
		Wait(Config.Intervall * 60000)
		if Config.EKS then
			local sal = ESX.PlayerData.job.grade_salary
			if sal ~= nil then
				local proc = 1 - (Config.EKSP * 0.01)
				local eks = ESX.Math.Round(sal * proc)
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), Config.Reciver, '~r~Einkommenssteuer', eks)
			end
		end
		if Config.FZS then
			ESX.TriggerServerCallback('tg_taxsystem:getcarcount', function (cars)
				if cars ~= nil then
					local fzs = ESX.Math.Round(cars * Config.FZSP)
					TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), Config.Reciver, '~r~Fahrzeugsteuer ~s~('..cars..' Fahrzeug/e)', fzs)
				end
			end)
		end
		if Config.GS then
			ESX.TriggerServerCallback('tg_taxsystem:getpropertycount', function (properties)
				if properties ~= nil then
					local gsa = ESX.Math.Round(properties * Config.GSA)
					TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), Config.Reciver, '~r~Grundsteuer ~s~('..properties..' Grundstück/e)', gsa)
				end
			end)
		end
		if Config.VS then
			ESX.TriggerServerCallback('tg_taxsystem:getbankmoney', function (bm)
				if bm ~= nil then
					local amount = ESX.Math.Round(bm * (Config.VSP * 0.01))
					TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(PlayerId()), Config.Reciver, '~r~Vermögenssteuer', amount)
				end
			end)
		end
	end
end)