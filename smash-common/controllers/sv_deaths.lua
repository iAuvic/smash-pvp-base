-----------------------------------------------------------------------------------------------------------------------------------------
-- KILLED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('smash-common:killed')
AddEventHandler('smash-common:killed',function(notify,killedBy,data)
    local source = source
    local user_id = vRP.getUserId(source)
    local killerId = vRP.getUserId(killedBy)
    local killerSrc = vRP.getUserSource(killerId)

    Wait(200)
    local identityK = vRP.getUserIdentity(killerId)
    local identityV = vRP.getUserIdentity(user_id)
    
    local amountPayment = 500

    if vRP.hasPermission(killerId,"Vip") then
        amountPayment = amountPayment + parseInt(amountPayment * 0.50)

        local randomPhrases = { "destruiu","obliterou","amassou","engui$$ou","imbicou","aniquilou","matou","sabugou","jantou","finalizou","explodiu","quebrou","exilou","deportou" }
        local random = math.random(#randomPhrases)

        TriggerClientEvent("NotifyKill",killerSrc,notify,identityK["name"].." "..identityK["firstname"],randomPhrases[random],identityV["name"].." "..identityV["firstname"],3000)

        local players = vRPC.getNearestPlayers(killerSrc,370)
        for k,v in pairs(players) do
            TriggerClientEvent("NotifyKill",k,notify,identityK["name"].." "..identityK["firstname"],randomPhrases[random],identityV["name"].." "..identityV["firstname"],3000)
        end
    else
        TriggerClientEvent("NotifyKill",killerSrc,notify,identityK["name"].." "..identityK["firstname"],"matou",identityV["name"].." "..identityV["firstname"],3000)
        
        local players = vRPC.getNearestPlayers(killerSrc,370)
        for k,v in pairs(players) do
            TriggerClientEvent("NotifyKill",k,notify,identityK["name"].." "..identityK["firstname"],"matou",identityV["name"].." "..identityV["firstname"],3000)
        end
    end        

    vRP.execute("vRP/updKills",{ user_id = killerId })
    vRP.execute("vRP/updDeaths",{ user_id = user_id })
    vRP.execute("vRP/addCoins",{ coins = amountPayment, user_id = killerId })

    local query01 = vRP.query("vRP/getInfos",{ user_id = user_id })
    if query01[1] then
        vRP.execute("vRP/updKd",{ user_id = user_id, kd = query01[1]["kills"] / query01[1]["deaths"] })


        if query01[1]["coins"] > 0 then
            vRP.execute("vRP/removeCoins",{ coins = 100, user_id = user_id })
        else
            vRP.execute("vRP/setCoins",{ user_id = user_id })
        end        
    end

    local query02 = vRP.query("vRP/getInfos",{ user_id = killerId })
    if query02[1] then
        vRP.execute("vRP/updKd",{ user_id = killerId, kd = query02[1]["kills"] / query02[1]["deaths"] })
    end

end)