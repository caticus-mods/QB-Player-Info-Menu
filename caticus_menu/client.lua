QBCore = exports['qb-core']:GetCoreObject()
local display = false

function SetDisplay(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

RegisterCommand("caticus", function()
    SetDisplay(not display)
end, false)

RegisterNUICallback("exit", function(data)
    SetDisplay(false)
end)

RegisterNUICallback("action", function(data, cb)
    local player = QBCore.Functions.GetPlayerData()

    if data.action then
        print("NUI Action Received: " .. data.action)

        if data.action == "job" then
            local job = player.job.label
            TriggerEvent('QBCore:Notify', "Your job: " .. job, 'primary')
        elseif data.action == "bank" then
            local bankBalance = player.money["bank"]
            TriggerEvent('QBCore:Notify', "Bank balance: $" .. bankBalance, 'primary')
        elseif data.action == "cash" then
            local cash = player.money["cash"]
            TriggerEvent('QBCore:Notify', "Cash on hand: $" .. cash, 'primary')
        elseif data.action == "gang" then
    
            local gang = player.gang.label
            TriggerEvent('QBCore:Notify', "Your gang: " .. gang, 'primary')
        elseif data.action == "id" then
            local id = GetPlayerServerId(PlayerId())
            local name = player.charinfo.firstname .. " " .. player.charinfo.lastname
            local dob = player.charinfo.birthdate
            local sex = player.charinfo.gender
            -- Add more fields as needed

            local idInfo = "ID: " .. id .. ", Name: " .. name .. ", DOB: " .. dob .. ", Sex: " .. sex
            TriggerEvent('QBCore:Notify', idInfo, 'primary')
        end
    end
    cb('ok') 
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if display then
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 18, true)
            DisableControlAction(0, 322, true)
            DisableControlAction(0, 106, true)
        end
    end
end)
