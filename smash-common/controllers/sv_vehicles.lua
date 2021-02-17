-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cV = {}
Tunnel.bindInterface("coreVeh",cV)
vehClient = Tunnel.getInterface("coreVeh")
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYDELETE
-----------------------------------------------------------------------------------------------------------------------------------------
function cV.tryDelete(vehId)
	local source = source
	vehClient.syncVehicle(-1,vehId)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- TRYPAYMENT
-----------------------------------------------------------------------------------------------------------------------------------------
function cV.tryPayment(value)
	local source = source
	local user_id = vRP.getUserId(source)
	if user_id then
		local query = vRP.query("vRP/getInfos",{ user_id = user_id })
		if query[1] then
			if query[1]["coins"] >= parseInt(value) then
				vRP.execute("vRP/removeCoins",{ user_id = user_id, coins = parseInt(value) }) 
				TriggerClientEvent("ONotify",source,"Você fez um pagamento de ~b~$"..vRP.format(value).." coins ~w~em troca de um veículo.")
				return true 
			else
				TriggerClientEvent("ONotify",source,"Você não possui ~r~$"..vRP.format(value).." coins~w~.")
				return false
			end
		end
	end
end