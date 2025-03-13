
QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('Angelicxs-BedRest:sendbed')
AddEventHandler('Angelicxs-BedRest:sendbed', function(serverID, time)
    local src = source
    local Player = nil  
    Player = QBCore.Functions.GetPlayer(serverID)
    if not Player then
        TriggerClientEvent('QBCore:Notify', src, Config.Lang['no_player'], 'error')
    else
        TriggerClientEvent('Angelicxs-BedRest:bedrest', serverID, time)
        TriggerClientEvent('QBCore:Notify', src, Config.Lang['player_sent']..' '..tostring(time/60)..' '..Config.Lang['minutes'], 'success')
    end
end)