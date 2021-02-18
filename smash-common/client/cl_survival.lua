-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cS = {}
Tunnel.bindInterface("coreSurvival",cS)
sSERVER = Tunnel.getInterface("coreSurvival")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local deadPlayer = false
local canDie = true
local deadTimers = 4
-----------------------------------------------------------------------------------------------------------------------------------------
-- CANDIE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('smash-common:canDie')
AddEventHandler('smash-common:canDie',function(status)
	canDie = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEADPLAYER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		local ped = PlayerPedId()
		if GetEntityHealth(ped) <= 101 and deadTimers >= 0 then
			timeDistance = 4
            if not deadPlayer then
                
				local x,y,z = table.unpack(GetEntityCoords(ped))
                NetworkResurrectLocalPlayer(x,y,z,true,true,false)
                
				deadTimers = 4
				deadPlayer = true
				vRP.updateHealth(101)
				SetEntityHealth(ped,101)
                SetEntityInvincible(ped,false)
                
				if IsPedInAnyVehicle(ped) then
					TaskLeaveVehicle(ped,GetVehiclePedIsIn(ped),4160)
                end
			else
				if deadTimers > 0 then
					drawTxt("AGUARDE ~b~"..deadTimers.." ~w~PARA RESPAWNAR",4,0.5,0.93,0.50,255,255,255,255)
				else
					drawTxt("PRESSIONE ~b~E ~w~PARA RESPAWNAR",4,0.5,0.87,0.50,255,255,255,255)

					if IsControlJustPressed(0,38) then -- E
						if canDie then
							TriggerEvent("respawnPlayer")
						end						
					end
				end
				SetEntityHealth(ped,101)
				BlockWeaponWheelThisFrame()
				DisablePlayerFiring(PlayerId(),true)
				DisableControlAction(0,21,true)
				DisableControlAction(0,22,true)
				DisableControlAction(0,23,true)
				DisableControlAction(0,24,true)
				DisableControlAction(0,25,true)
				DisableControlAction(0,29,true)
				DisableControlAction(0,32,true)
				DisableControlAction(0,33,true)
				DisableControlAction(0,34,true)
				DisableControlAction(0,35,true)
				DisableControlAction(0,47,true)
				DisableControlAction(0,56,true)
				DisableControlAction(0,58,true)
				DisableControlAction(0,73,true)
				DisableControlAction(0,75,true)
				DisableControlAction(0,137,true)
				DisableControlAction(0,140,true)
				DisableControlAction(0,141,true)
				DisableControlAction(0,142,true)
				DisableControlAction(0,143,true)
				DisableControlAction(0,166,true)
				DisableControlAction(0,167,true)
				DisableControlAction(0,168,true)
				DisableControlAction(0,169,true)
				DisableControlAction(0,170,true)
				DisableControlAction(0,177,true)
				DisableControlAction(0,182,true)
				DisableControlAction(0,187,true)
				DisableControlAction(0,188,true)
				DisableControlAction(0,189,true)
				DisableControlAction(0,190,true)
				DisableControlAction(0,243,true)
				DisableControlAction(0,257,true)
				DisableControlAction(0,263,true)
				DisableControlAction(0,264,true)
				DisableControlAction(0,268,true)
				DisableControlAction(0,269,true)
				DisableControlAction(0,270,true)
				DisableControlAction(0,271,true)
				DisableControlAction(0,288,true)
				DisableControlAction(0,289,true)
				DisableControlAction(0,311,true)
				DisableControlAction(0,344,true)
				SetPedToRagdoll(ped,2000,2000,0,0,0,0)
			end
		end
		
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HEALTHRECHARGE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		SetPlayerHealthRechargeMultiplier(PlayerId(),0)
		Citizen.Wait(100)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEADTIMERS
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if deadPlayer and deadTimers > 0 then
			deadTimers = deadTimers - 1
		end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWTXT
-----------------------------------------------------------------------------------------------------------------------------------------
function drawTxt(text,font,x,y,scale,r,g,b,a)
	SetTextFont(font)
	SetTextScale(scale,scale)
	SetTextColour(r,g,b,a)
	SetTextOutline()
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x,y)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ISINCOMA
-----------------------------------------------------------------------------------------------------------------------------------------
function cS.isInComa()
	return deadPlayer
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- NETWORKRESSURECTION
-----------------------------------------------------------------------------------------------------------------------------------------
function cS.killGod()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	NetworkResurrectLocalPlayer(x,y,z,true,true,false)
	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	SetEntityHealth(ped,102)
	ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- KILLGOD
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('smash-common:killGod')
AddEventHandler('smash-common:killGod',function()
	local ped = PlayerPedId()
	local x,y,z = table.unpack(GetEntityCoords(ped))

	NetworkResurrectLocalPlayer(x,y,z,true,true,false)
	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	SetEntityHealth(ped,102)
	ClearPedTasks(ped)
	ClearPedSecondaryTask(ped)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
----------------------------------------------------------------------------------------------------------------------------------------
local spawn01 = 1
local spawn02 = 1
local pistolSpawnPoint = {
	{ x,y,z },
}
local fuzilSpawnPoint = {
	{ 1006.42,2373.05,55.57 },
	{ 1066.88,2336.77,49.65 },
	{ 1128.37,2334.54,50.24 },
	{ 1154.65,2373.6,53.87 },
	{ 1152.56,2336.59,58.41 },
	{ 1149.58,2322.0,57.45 },
	{ 1096.58,2265.68,47.26 },
	{ 1086.08,2240.61,44.83 },
	{ 1005.8,2261.62,47.08 },
	{ 1008.51,2241.47,47.26 },
	{ 1029.96,2214.7,50.79 },
	{ 1071.34,2178.98,48.23 },
	{ 1072.51,2172.75,48.34 },
	{ 1070.88,2168.7,50.51 },
	{ 1074.72,2149.31,55.47 },
	{ 1092.77,2140.62,57.7 },
	{ 1084.65,2130.38,53.32 },
	{ 1085.58,2100.19,55.87 },	
	{ 1123.48,2081.87,55.43 },
	{ 1131.79,2094.87,55.77 },
	{ 1136.8,2096.03,55.8 },
	{ 1142.7,2090.05,55.8 },
	{ 1128.99,2125.25,55.55 },
	{ 1112.08,2188.9,46.43 },
	{ 1030.71,2436.45,45.07 },
	{ 907.77,2347.86,52.16 },
	{ 959.24,2294.72,47.66 },
	{ 1152.45,2317.88,67.84 },
	{ 1153.42,2383.35,68.25 },
	{ 1044.24,2515.25,45.78 },	
	{ 1045.75,2524.06,45.18 },
	{ 1021.61,2527.24,45.49 },
	{ 986.35,2516.55,54.47 },
	{ 861.19,2424.14,54.08 },
	{ 847.33,2387.81,54.18 },
	{ 847.33,2387.81,54.18 },
	{ 864.49,2354.21,51.6 },
	{ 910.36,2289.86,45.83 },
	{ 992.1,2235.23,51.49 },
	{ 1131.27,2171.98,79.26 },
	{ 1064.01,2536.75,54.45 },
	{ 1150.53,2233.81,54.52 },
	{ 1052.94,2160.41,49.01 },
	{ 860.06,2164.41,52.29 },
	{ 848.15,2503.41,68.35 },
	{ 1138.52,2126.21,55.7 },
	{ 1025.81,2440.13,58.38 },
	{ 1062.79,2294.26,79.92 },
	{ 953.03,2292.67,56.71 },
	{ 772.69,2520.24,74.58 },
	{ 1028.76,2529.45,47.48 },
	{ 904.19,2331.34,50.39 },
	{ 1010.58,2460.02,49.57 },
	{ 1020.48,2458.57,49.57 },
	{ 1029.54,2455.42,45.91 },
	{ 1133.18,2128.02,55.74 },
	{ 1108.73,2136.77,53.39 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- RESPAWNPLAYER
----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("respawnPlayer")
AddEventHandler("respawnPlayer",function()
	local ped = PlayerPedId()

	deadTimers = 4
	deadPlayer = false

	ClearPedBloodDamage(ped)
	SetEntityInvincible(ped,false)
	TriggerEvent("smash-base:initScripts",true)
	SetEntityHealth(ped,399)
	SetTimeout(3000,function()
		TriggerEvent("smash-base:initScripts",false)
	end)
	sSERVER.respawnServer()
	ClearPedTasksImmediately(ped)

	local coords = GetEntityCoords(ped)

	local distance = #(coords - vector3(1775.44,3706.6,34.27))
	if distance <= 353.533 then
		local x,y,z = table.unpack(GetEntityCoords(ped,true))
		SetTimeout(10,function()
			spawn01 = math.random(#pistolSpawnPoint)
			SetEntityCoords(ped,pistolSpawnPoint[spawn01][1],pistolSpawnPoint[spawn01][2],pistolSpawnPoint[spawn01][3]+0.001,0,0,1)
		end)
	end

	local distance2 = #(coords - vector3(1006.75,2366.65,55.57))
    if distance2 <= 298.865234375 then
		local x,y,z = table.unpack(GetEntityCoords(ped,true))
		SetTimeout(10,function()
			spawn02 = math.random(#fuzilSpawnPoint)
			print(fuzilSpawnPoint[spawn02][1],fuzilSpawnPoint[spawn02][2],fuzilSpawnPoint[spawn02][3])
			SetEntityCoords(ped,fuzilSpawnPoint[spawn02][1],fuzilSpawnPoint[spawn02][2],fuzilSpawnPoint[spawn02][3]+0.001,0,0,1)
		end)
	end
end)