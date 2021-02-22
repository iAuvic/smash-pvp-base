-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cO = {}
Tunnel.bindInterface("coreOptions",cO)
oCLIENT = Tunnel.getInterface("coreOptions")

local is_a_booster = {}
-----------------------------------------------------------------------------------------------------------------------------------------
-- PARTICULAS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('particulas',function(source,args,rawCmd)
    local user_id = vRP.getUserId(source)
    if user_id then
        if args[1] == "on" then
            vRP.execute("vRP/updParticles",{ particles = 1, user_id = user_id })
            TriggerClientEvent("ONotify",source,"Sistema de particulas ~g~ativado.")
        elseif args[1] == "off" then 
            vRP.execute("vRP/updParticles",{ particles = 0, user_id = user_id })
            TriggerClientEvent("ONotify",source,"Sistema de particulas ~r~desativado.")
        end 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MASK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mascara',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Vip") then
        TriggerClientEvent("setMask",source,args[1],args[2])
    end   
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLUSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('blusa',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Vip") then
        TriggerClientEvent("setBlusa",source,args[1],args[2])
    end   
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COLETE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('colete',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Vip") then
        TriggerClientEvent("setVest",source,args[1],args[2])
    end   
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JAQUETA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('jaqueta',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Vip") then
        TriggerClientEvent("setJacket",source,args[1],args[2])
    end   
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('maos',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Vip") then
        TriggerClientEvent("setHands",source,args[1],args[2])
    end   
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CALCA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('calca',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Vip") then
        TriggerClientEvent("setLegs",source,args[1],args[2])
    end   
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sapatos',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Vip") then
        TriggerClientEvent("setShoes",source,args[1],args[2])
    end   
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('chapeu',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Vip") then
        TriggerClientEvent("setHat",source,args[1],args[2])
    end   
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('oculos',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Vip") then
        TriggerClientEvent("setGlasses",source,args[1],args[2])
    end   
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MOCHILA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('mochila',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Vip") then
        TriggerClientEvent("setBackpack",source,args[1],args[2])
    end   
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACESSORIOS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('acessorios',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
    if vRP.hasPermission(user_id,"Vip") then
        TriggerClientEvent("setAcessories",source,args[1],args[2])
    end   
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RANK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('rank',function(source,args,rawCmd)
    local rows = vRP.query("vRP/getRank",{})

    for i=1,5 do
        local user_id = rows[i]["user_id"]
        local identity = vRP.getUserIdentity(user_id)
        local user_kd = round(rows[i]["kd"],2)
        local user_coins = rows[i]["coins"]
        local user_kills = rows[i]["kills"]
        local user_deaths = rows[i]["deaths"]
        TriggerClientEvent("ONotify",source,"~g~<b>1°</b>: ~w~"..identity["name"].." "..identity["firstname"].." ~w~| ~g~Kills: ~w~"..user_kills.." ~w~| ~g~Deaths: ~w~"..user_deaths.." | ~g~Kd:~w~ "..user_kd)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- USE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('use',function(source,args,rawCmd)
    if args[1] == nil then
        return 
    end

    local user_id = vRP.getUserId(source)
    if user_id then
        if args[1] == 'energetico' then
            TriggerClientEvent('smash-common:eNergetic',source,true)
            TriggerClientEvent("ONotify",source,"Você utilizou um ~g~Energetico")
            SetTimeout(60000,function()
                TriggerClientEvent('smash-common:eNergetic',source,false)
                TriggerClientEvent("ONotify",source,"O efeito ~g~Energetico~w~ passou.")
            end)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ID
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('id',function(source,rawCommand)	
	local nplayer = vRPC.getNearestPlayer(source,2)
	local nuser_id = vRP.getUserId(nplayer)
	if nuser_id then
		local identity = vRP.getUserIdentity(nuser_id)
		vRPC.setDiv(source,"completerg",".div_completerg { background-color: rgba(0,0,0,0.60); font-size: 12px; font-family: sans-serif; color: #fff; width: 220px; padding: 20px 20px 5px; bottom: 8%; right: 2.5%; position: absolute; border-radius: 5px; border: 1px solid rgba(255,255,255,0.2); letter-spacing: 0.5px; } .local { width: 220px; padding-bottom: 15px; float: left; } .local2 { width: 100px; padding-bottom: 15px; float: left; } .local b, .local2 b { color: #ffffff; }","<div class=\"local\"><b>Proximidade:</b> "..identity["name"].." "..identity["firstname"].." ("..vRP.format(identity.user_id).." )</div>")
        
        SetTimeout(5000,function()
            vRPC.removeDiv(source,"completerg")
        end)		
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ROUND
-----------------------------------------------------------------------------------------------------------------------------------------
function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKVIP
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.checkBooster()
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then
        if is_a_booster[user_id] or vRP.hasPermission(user_id,'Vip') then
            return true
        else
            TriggerClientEvent("ONotify",source,"Você não possui acesso a isto.")
            return false
        end
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKATTACH
-----------------------------------------------------------------------------------------------------------------------------------------
function cO.checkAttach(type)
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then
        local attachs = vRP.query("vRP/getAttachs",{ user_id = user_id })

        if type == "lan" then
            type = "lanterna"
        elseif type == "completa" then 
            type = "miraA" 
        elseif type == "simples" then 
            type = "miraS"
        end

        if type ~= "todos" then
            if attachs[1][type] == 1 then
                return true
            else
                return false
            end
        else
            if attachs[1]["grip"] == 1 and attachs[1]["lanterna"] == 1 and attachs[1]["compensador"] == 1 and attachs[1]["silenciador"] == 1 and attachs[1]["pente"] == 1 and attachs[1]["miraS"] == 1 and attachs[1]["miraA"] == 1 and attachs[1]["tracante"] == 1 then 
                return true 
            else
                return false
            end
        end
    end
end


AddEventHandler("vRP:playerJoin",function(user_id,source)
    if exports["discord_perms"]:IsRolePresent(source,"Booster") then
        print('^2BOOSTER >^7 [ID]: '..vRP.format(user_id)..' reveived the permission.')
        is_a_booster[user_id] = true
    else
        is_a_booster[user_id] = false
    end
end)
