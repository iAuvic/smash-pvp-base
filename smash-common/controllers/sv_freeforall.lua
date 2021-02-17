-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cFFA = {}
Tunnel.bindInterface("coreFFA",cFFA)
ffaClient = Tunnel.getInterface("coreFFA")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTIPANTSARENA
-----------------------------------------------------------------------------------------------------------------------------------------
local partArena = {}
local array = {}
local playerArena = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPARTICIPANTS
-----------------------------------------------------------------------------------------------------------------------------------------
function cFFA.checkParticipants(arena)
    local source = source 
    local user_id = vRP.getUserId(source)

    if partArena[arena] == nil then
        partArena[arena] = 0
    end

    if partArena[arena] < 10 then
        partArena[arena] = partArena[arena] + 1
        array[user_id] = true
        playerArena[user_id] = arena
        TriggerClientEvent("ffaUpdate",-1,partArena[arena])
        return true 
    else
        if vRP.hasPermission(user_id,"Vip") then
            if partArena[arena] < 12 then
                partArena[arena] = partArena[arena] + 1
                array[user_id] = true
                playerArena[user_id] = arena
                TriggerClientEvent("ffaUpdate",-1,partArena[arena])
                return true
            else
                return false
            end
        else
            return false
        end
        
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GETOUTARENA
-----------------------------------------------------------------------------------------------------------------------------------------1
function cFFA.outArena(arena)
    if partArena[arena] == nil then
        partArena[arena] = 0
    end
    
    if array[user_id] then
        array[user_id] = false 
        playerArena[user_id] = {}
    end
    
    partArena[arena] = partArena[arena] - 1
    if partArena[arena] < 0 then 
        partArena[arena] = 0 
    end

    TriggerClientEvent("ffaUpdate",-1,partArena[arena])
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source)
    TriggerClientEvent("ffaUpdate",source,partArena[1]) -- update arena 1
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerLeave",function(user_id,source)
	if array[user_id] then
        array[user_id] = false
        
        local arena = playerArena[user_id]
        partArena[arena] = partArena[arena] - 1
        if partArena[arena] < 0 then 
            partArena[arena] = 0 
        end
        
        playerArena[user_id] = {}
        TriggerClientEvent("ffaUpdate",-1,partArena[arena])
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDEBUG
-----------------------------------------------------------------------------------------------------------------------------------------
CreateThread(function()
	Wait(1000)
	TriggerClientEvent("ffaUpdate",-1,partArena[1]) -- update arena 1
end)