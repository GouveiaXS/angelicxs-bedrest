QBcore = nil
PlayerJob = nil
PlayerData = nil


CreateThread(function()
    QBCore = exports['qb-core']:GetCoreObject()

    CreateThread(function ()
        while true do
            PlayerData = QBCore.Functions.GetPlayerData()
            if PlayerData.citizenid ~= nil then
                PlayerJob = PlayerData.job.name
                break
            end
            Wait(100)
        end
    end)
    RegisterNetEvent('QBCore:Client:OnJobUpdate', function(job)
        PlayerJob = job.name
    end)
end)

RegisterCommand(Config.CommandName, function(source, args) 
    if PlayerJob == Config.JobName then
        if tonumber(args[1]) then
            TriggerEvent('Angelicxs-BedRest:valueinput', tonumber(args[1]))
        else
            QBCore.Functions.Notify(Config.Lang['server_id'], 'error')
        end
    else
        QBCore.Functions.Notify(Config.Lang['wrong_job'], 'error')
    end
end)

exports['qb-target']:AddGlobalPlayer({
    options = {{
        icon = "fa-regular fa-bed",
        label = Config.Lang['bed_rest_3eye'],
        action = function(entity)
            local spot = GetEntityCoords(entity)
            local play, dist = QBCore.Functions.GetClosestPlayer(spot)
            local id = GetPlayerServerId(play)
            TriggerEvent('Angelicxs-BedRest:valueinput', id)
        end,
        job = Config.JobName,
    }},
    distance = 2.5,
})

RegisterNetEvent('Angelicxs-BedRest:valueinput', function(serverID)
    local time = 0
    local info = exports['qb-input']:ShowInput({
        header = Config.Lang['bed_rest'],
        submitText = Config.Lang['submit'], 
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'time',
                text = Config.Lang['time'], 
            },
        }
    })    
    if info then
        if tonumber(info.time) > 0 then
            time = tonumber(info.time)
        else
            QBCore.Functions.Notify(Config.Lang['zero_error'], 'error')
        end
    end
    if time <= Config.MinTime then
        time = Config.MinTime
    elseif time >= Config.MaxTime then
        time = Config.MaxTime
    end
    time = time*60
    TriggerServerEvent('Angelicxs-BedRest:sendbed', serverID, time)
end)

RegisterNetEvent('Angelicxs-BedRest:bedrest', function(time)
    local length = time
    local ped = PlayerPedId()
    DoScreenFadeOut(1000)
    while not IsScreenFadedOut() do Wait (100) end
    SetEntityCoords(ped, Config.Spot.x, Config.Spot.y, Config.Spot.z)
    SetEntityHeading(ped, Config.Spot.w)
    DoScreenFadeIn(1000)
    SetEntityMaxHealth(ped, 200)
    SetEntityHealth(ped, 200)
    ClearPedBloodDamage(ped)
    ResetPedMovementClipset(ped, 0.0)
    SetPlayerSprint(ped, true)
    TriggerServerEvent('hud:server:RelieveStress', 100)
    TriggerServerEvent("hospital:server:SetDeathStatus", false)
    TriggerServerEvent("hospital:server:SetLaststandStatus", false)
    TriggerEvent('hospital:client:HealInjuries', 'full')
    QBCore.Functions.Notify(Config.Lang['bed_rest_player']..' '..tostring(time/60)..' '..Config.Lang['minutes'], 'primary')
    local dist = 0
    while true do
        Wait(1000)
        dist = #(GetEntityCoords(ped)-vector3(Config.Spot.x, Config.Spot.y, Config.Spot.z))
        length = length - 1
        if dist >= Config.Distance then
            QBCore.Functions.Notify(Config.Lang['reset'], 'primary')
            DoScreenFadeOut(1000)
            while not IsScreenFadedOut() do Wait (100) end
            SetEntityCoords(ped, Config.Spot.x, Config.Spot.y, Config.Spot.z)
            DoScreenFadeIn(1000)
        end
        if length <= 0 then
            break
        end
    end
    QBCore.Functions.Notify(Config.Lang['cured'], 'success')
end)