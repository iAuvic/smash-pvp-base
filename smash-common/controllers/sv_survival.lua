-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cS = {}
Tunnel.bindInterface("coreSurvival",cS)
sCLIENT = Tunnel.getInterface("coreSurvival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- GOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('god',function(source,args,rawCommand)
    local user_id = vRP.getUserId(source)
	local identity = vRP.getUserIdentity(user_id)
    if vRP.hasPermission(user_id,"SupportTeam") then
        if args[1] then
            local nplayer = vRP.getUserSource(parseInt(args[1]))
            if nplayer then
                sCLIENT.killGod(nplayer)
                vRPC.setHealth(nplayer,400)
            end
        else
            sCLIENT.killGod(source)
			vRPC.setHealth(source,400)
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPAWNPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
function cS.respawnServer()
    local source = source 
	vRPC.setHealth(source,400)
end