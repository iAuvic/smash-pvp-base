-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cL = {}
Tunnel.bindInterface("coreLobby",cL)
cCLIENT = Tunnel.getInterface("coreLobby")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKPARTICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cL.checkParticle()
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then
        local query = vRP.query("vRP/getInfos",{ user_id = user_id })
        if query[1] then
            if query[1]["particles"] == 1 then 
                return true 
            else
                return false
            end 
        end
    end   
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CHECKVIP
-----------------------------------------------------------------------------------------------------------------------------------------
function cL.checkVip()
    local source = source 
    local user_id = vRP.getUserId(source)
    if user_id then
        return vRP.hasPermission(user_id,"Vip")
    end
end