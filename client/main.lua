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
		Wait(Config.Intervall * 60000)

		if Config.EKS then
			local salary = ESX.PlayerData.job.grade_salary

			if salary ~= nil then
				local proc = 1 - (Config.EKSP * 0.01)
				local eks = ESX.Math.Round(salary * proc)

				ESX.ShowAdvancedNotification("Steuer", "~r~Einkommenssteuer", "Dir wurden ~g~"..eks.."~s~ abgezogen.", "CHAR_MP_MORS_MUTUAL", 9, true, 200)
				TriggerServerEvent('tg_taxsystem:tax', eks)
			end
		end

		if Config.FZS then
			ESX.TriggerServerCallback('tg_taxsystem:getcarcount', function (cars)
				if cars ~= nil then
					local fzs = ESX.Math.Round(cars * Config.FZSP)

					ESX.ShowAdvancedNotification("Steuer", "~r~Fahrzeugsteuer", "Dir wurden ~g~"..fzs.."~s~ für "..cars.." Fahrzeug(e) abgezogen.", "CHAR_MP_MORS_MUTUAL", 9, true, 200)
					TriggerServerEvent('tg_taxsystem:tax', fzs)
				end
			end)
		end

		if Config.VS then
			ESX.TriggerServerCallback('tg_taxsystem:getbankmoney', function (bankmoney)
				if bankmoney ~= nil then
					local vs = ESX.Math.Round(bankmoney * (Config.VSP * 0.01))

					ESX.ShowAdvancedNotification("Steuer", "~r~Vermögenssteuer", "Dir wurden ~g~"..vs.."~s~ abgezogen.", "CHAR_MP_MORS_MUTUAL", 9, true, 200)
					TriggerServerEvent('tg_taxsystem:tax', vs)
				end
			end)
		end
	end
end)