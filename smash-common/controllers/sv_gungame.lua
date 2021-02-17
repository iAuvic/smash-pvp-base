-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
gG = {}
Tunnel.bindInterface("coreGungame",gG)
gunClient = Tunnel.getInterface("coreGungame")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local maxLobby = 2
local qtdNoLobby = 0
local statusJogoPronto = false
local userInALobby = {}
local kill = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOBBYMANAGER
-----------------------------------------------------------------------------------------------------------------------------------------
function gG.lobbyManager(manager)
    local source = source 
    local user_id = vRP.getUserId(source)

    if manager == "remove" then
        kill[user_id] = nil
        userInALobby[user_id] = false
        qtdNoLobby = qtdNoLobby - 1
        TriggerClientEvent("gunGame:qtdNoLobby",-1,qtdNoLobby)
    end

    if manager == "add" then
        if qtdNoLobby >= maxLobby then
            return 
        else
            qtdNoLobby = qtdNoLobby + 1
            userInALobby[user_id] = true
            TriggerClientEvent("gunGame:qtdNoLobby",-1,qtdNoLobby)

            if qtdNoLobby >= maxLobby then
                TriggerClientEvent("gunGame:jogoPronto",-1,true)
                statusJogoPronto = true
            end
        end        
    end

    if manager == "podeEntrar" then
        if qtdNoLobby < maxLobby then
            return true 
        else
            return false
        end
    end

end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KILLED
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterServerEvent('gunGame:init')
AddEventHandler('gunGame:init',function(killedBy,data)
    local source = source
    local user_id = vRP.getUserId(source)
    local killerId = vRP.getUserId(killedBy)
    local killerSrc = vRP.getUserSource(killerId)

    Wait(200)
    if userInALobby[killerId] and userInALobby[user_id] then 
        if kill[killerId] == nil then kill[killerId] = 0 end 

        kill[killerId] = kill[killerId] + 1


        local identityK = vRP.getUserIdentity(killerId)

        
        TriggerClientEvent("NotifyKill",killerSrc,"aviso",identityK["name"].." "..identityK["firstname"],"está com",kill[killerId].." kills.",3000)
        
        local players = vRPC.getNearestPlayers(killerSrc,370)
        for k,v in pairs(players) do
            TriggerClientEvent("NotifyKill",k,"aviso",identityK["name"].." "..identityK["firstname"],"está com",kill[killerId].." kills.",3000)
        end

        TriggerClientEvent('gunGame:initC',killerSrc)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SETWINNER
-----------------------------------------------------------------------------------------------------------------------------------------
function gG.setWinner()
    local source = source 
    local user_id = vRP.getUserId(source)

    local identity = vRP.getUserIdentity(user_id)

    kill = {}
    qtdNoLobby = 0
    userInALobby = {}
    TriggerClientEvent("gunGame:jogoPronto",-1,false)
    statusJogoPronto = false
    TriggerClientEvent("gunGame:qtdNoLobby",-1,qtdNoLobby)
    TriggerClientEvent("gunGame:forceStopPartida",-1)


    TriggerClientEvent("ONotify",-1,"~g~[GunGame]: ~w~"..identity["name"].." "..identity["firstname"].." ~g~ganhou ~w~uma partida.")
    vRP.execute("vRP/addCoins",{ coins = 10000, user_id = user_id })
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
    if statusJogoPronto then
        TriggerClientEvent("gunGame:jogoPronto",source,true)
    else
        TriggerClientEvent("gunGame:jogoPronto",source,false)
    end

    TriggerClientEvent("gunGame:qtdNoLobby",source,qtdNoLobby)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
    TriggerClientEvent("gunGame:playerLeave",source)
end)

function gG.checkPerm()
    local src = source
    local user = vRP.getUserId(src)

    if vRP.hasPermission(user,"Vip") then
        return true
    else
        return false
    end
end