-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
local cfg = module("vrp","cfg/groups")
vRP = Proxy.getInterface("vRP")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
oRP = {}
Tunnel.bindInterface("vrp_identidade",oRP)
Proxy.addInterface("vrp_identidade",oRP)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIAVEIS
-----------------------------------------------------------------------------------------------------------------------------------------
local groups = cfg.groups


function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end

function oRP.Identidade()
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local identity = vRP.getUserIdentity(user_id)
		if identity then
			local query = vRP.query("vRP/getInfos",{ user_id = user_id })
			local adm = oRP.getUserGroupByType(user_id,"Admin")
			local vip = oRP.getUserGroupByType(user_id,"Vip")
			if query[1] then
				local kd = round(query[1]["kd"],2)
				return identity["name"],identity["firstname"],identity["user_id"],query[1]["kills"],query[1]["deaths"],kd,query[1]["coins"],adm,vip
			end
		end
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- GROUPS
-----------------------------------------------------------------------------------------------------------------------------------------
function oRP.getUserGroupByType(user_id,gtype)
	local user_groups = vRP.getUserGroups(user_id)
	for k,v in pairs(user_groups) do
		local kgroup = groups[k]
		if kgroup then
			if kgroup._config and kgroup._config.gtype and kgroup._config.gtype == gtype then
				return kgroup._config.title
			end
		end
	end
	return ""
end

