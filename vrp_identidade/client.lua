-----------------------------------------------------------------------------------------------------------------------------------------
-- VRP
-----------------------------------------------------------------------------------------------------------------------------------------
local Tunnel = module("vrp","lib/Tunnel")
local Proxy = module("vrp","lib/Proxy")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONEXÃO
-----------------------------------------------------------------------------------------------------------------------------------------
vRP = Proxy.getInterface("vRP")
vSERVER = Tunnel.getInterface("vrp_identidade")
-----------------------------------------------------------------------------------------------------------------------------------------
-- IDENTIDADE
-----------------------------------------------------------------------------------------------------------------------------------------
local css = [[
	.clear {
		clear: both;
	}
	.div_registro {
		background: rgba(15,15,15,0.7);
		color: #999;
		bottom: 9%;
		right: 2.2%;
		position: absolute;
		padding: 20px 30px;
		font-family: Arial;
		line-height: 30px;
		border-left: 3px solid #1a90f0;
		letter-spacing: 1.7px;
		border-radius: 5px;
	}
	.div_registro b {
		color: cian;
		padding: 0 4px 0 0;
	}
]]


local identity = false

RegisterCommand('ident',function(source,args)
	if identity then
		vRP._removeDiv("registro")
		identity = false
	else
		local nome,sobrenome,user_id,kills,deaths,kd,coins,adm,vip = vSERVER.Identidade()

		local bVip = ""
		local bAdmin = ""

		if vip ~= "" then
			bVip = "<br><b>Status: </b>"..vip 
		else
			bVip = "<br><b>Status: </b>Jogador"
		end

		if adm ~= "" then
			bAdmin = "<br><b>Admin: </b>"..adm 
		end

		vRP._setDiv("registro",css,nome.." "..sobrenome.." <b>#"..user_id.."</b><br><b>Kills: </b>"..kills.."</b><br><b>Deaths: </b> "..deaths.."</b><br><b>Kd: </b>"..tonumber(kd).."</b><br><b>Coins: </b>"..coins..bAdmin..bVip)
		identity = true
	end
end)

RegisterKeyMapping('ident', 'Abrir identidade', 'keyboard', 'f11')