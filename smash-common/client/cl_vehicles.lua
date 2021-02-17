-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cV = {}
Tunnel.bindInterface("coreVeh",cV)
vehServer = Tunnel.getInterface("coreVeh")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local vehs = {
    { -1867.32,-1205.01,13.02,228.02,"polmav",1500 },
    { -1870.36,-1208.59,13.02,232.43,"t20",500 },
    { -1872.87,-1211.86,13.02,232.43,"entityxf",500 },

    { -1818.85,-1235.31,13.02,117.77,"zentorno",500 },
    { -1818.71,-1244.74,13.02,48.43,"xa21",500 },
    { -1821.93,-1247.99,13.02,25.76,"turismor",500 },
    { -1816.94,-1240.07,13.02,89.30,"visione",500 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEHSPAWN
-----------------------------------------------------------------------------------------------------------------------------------------
local vehSpawn = {
    { -1585.33,-928.73,15.43 },
    { -1506.0,-392.19,40.25 },
    { -956.22,-158.11,37.88 },
    { -339.25,647.87,171.33 },
    { -7.9,-1140.15,27.77 },
    { 157.74,-1021.56,29.39 },
    { -36.79,6339.28,31.3 },
    { 2511.65,2761.81,45.88 },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAINTHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    Citizen.Wait(1000)
    spawnVehicles()

    while true do
        local timeDistance = 1000

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for k,v in pairs(vehs) do -- Criação dos draws dos veículos
            local distance = #(coords - vector3(v[1],v[2],v[3]))
            if distance <= 3 then
                timeDistance = 4
                drawCars(v[1],v[2],v[3],"~r~[NOME]:~w~ "..v[5].."\n~r~[VALOR]:~w~ "..v[6].." coins\n~r~[E]~w~ Spawn",600)
                if distance <= 3 then
                    if IsControlJustPressed(0,38) then
                        if vehServer.tryPayment(v[6]) then
                            spawnVehicles2(v[5])
                        end
                    end 
                end
            end
        end


        Citizen.Wait(timeDistance) 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADDELETEVEH
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)

        local veh = GetPlayersLastVehicle(PlayerPedId(),1)
        local peddriver = GetPedInVehicleSeat(veh,-1)

        if not IsPedSittingInVehicle(peddriver,veh) then
            if IsEntityAVehicle(veh) then
                vehServer.tryDelete(VehToNet(veh))
            end
        end

        local playerPed = GetPlayerPed(-1)
        local playerPos = GetEntityCoords(GetPlayerPed(PlayerId()))

        local distance = #(playerPos - vector3(1775.44,3706.6,34.27))
        local distance2 = #(playerPos - vector3(1006.75,2366.65,55.57))
        local distance3 = #(playerPos - vector3(-1822.36,-1212.59,13.03))
        
        if (IsPedInAnyVehicle(playerPed, false)) then
            if distance <= 353.533 or distance2 <= 298.865234375 or distance3 <= 150.533 then
                vehServer.tryDelete(VehToNet(veh))
            end
        end

    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEH
-----------------------------------------------------------------------------------------------------------------------------------------
function spawnVehicles()
    for k,v in pairs(vehs) do
        local hash = GetHashKey(v[5])
        
        RequestModel(hash)
        while not HasModelLoaded(hash) do
            RequestModel(hash)
            Citizen.Wait(10)
        end

        local vehId = CreateVehicle(hash,v[1],v[2],v[3],v[4],false,false)
        SetVehicleOnGroundProperly(vehId)
        SetVehicleDoorsLocked(vehId,2)
        SetVehicleDirtLevel(vehId,0.0)
        SetEntityAsMissionEntity(vehId,true,true)
        SetVehicleNumberPlateText(vehId,"LOBBY00"..k)
        Citizen.Wait(2000)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SPAWNVEH²
-----------------------------------------------------------------------------------------------------------------------------------------
function spawnVehicles2(hash)
    local mhash = GetHashKey(hash)

    RequestModel(mhash)
    while not HasModelLoaded(mhash) do
        RequestModel(mhash)
        Citizen.Wait(10)
    end

    local random = math.random(#vehSpawn)

    if HasModelLoaded(mhash) then
        local ped = PlayerPedId()
        local nveh = CreateVehicle(mhash,vehSpawn[random][1],vehSpawn[random][2],vehSpawn[random][3],GetEntityHeading(ped),true,false)

        SetEntityInvincible(nveh,false)
        SetVehicleOnGroundProperly(nveh)
        SetEntityAsMissionEntity(nveh,true,true)

        SetPedIntoVehicle(ped,nveh,-1)

        SetVehicleFuelLevel(nveh,100.0)

        SetModelAsNoLongerNeeded(mhash)
    end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- SYNCVEHICLE
-----------------------------------------------------------------------------------------------------------------------------------------
function cV.syncVehicle(index)
	if NetworkDoesNetworkIdExist(index) then
		local v = NetToEnt(index)
		if DoesEntityExist(v) then
			SetEntityAsMissionEntity(v,false,false)
			DeleteEntity(v)
		end
	end
end