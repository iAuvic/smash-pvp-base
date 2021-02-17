-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cL = {}
Tunnel.bindInterface("coreLobby",cL)
cSERVER = Tunnel.getInterface("coreLobby")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local handle
local toggleFly = false
local inLobby = false
-----------------------------------------------------------------------------------------------------------------------------------------
-- LOBBYCOMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('lobby',function()
    local ped = PlayerPedId()

    local playerPed = GetPlayerPed(-1)
    RemoveAllPedWeapons(playerPed,false)

    SetEntityCoords(ped,-1851.58,-1233.75,13.03+0.001,250.02+0.0001,1,0,0,1)

    local handle = RegisterPedheadshot(PlayerPedId())
    Wait(200)

    ShowNotificatioCrewRankup("Lobby Manager:","Seja bem-vindo novamente ao Lobby.",GetPedheadshotTxdString(handle),GetPedheadshotTxdString(handle))

    TriggerEvent("smash-common:disableFFA")
    TriggerEvent("gunGame:playerLeave")

    FreezeEntityPosition(ped,false)
    SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
    TriggerEvent("smash-base:initScripts",true)
    SetEntityHealth(ped,399)
    SetTimeout(3000,function()
        TriggerEvent("smash-base:initScripts",false)
    end)

    if cSERVER.checkParticle() then
        teleportEffect()
    end    
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAIRCOMMAND
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('sair',function()
    local ped = PlayerPedId()
    
    local playerPed = GetPlayerPed(-1)
    RemoveAllPedWeapons(playerPed,false)

    SetEntityCoords(ped,-1851.58,-1233.75,13.03+0.001,250.02+0.0001,1,0,0,1)

    local handle = RegisterPedheadshot(PlayerPedId())
    Wait(200)
    ShowNotificatioCrewRankup("Lobby Manager:","Seja bem-vindo novamente ao Lobby.",GetPedheadshotTxdString(handle),GetPedheadshotTxdString(handle))

    if cSERVER.checkParticle() then
        teleportEffect()
    end
    FreezeEntityPosition(ped,false)
    TriggerEvent("smash-common:disableFFA")
    TriggerEvent("gunGame:playerLeave")
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local particles = {
    { "scr_clown_death","scr_rcbarry2" },
    { "scr_alien_disintegrate","scr_rcbarry1" },
    { "scr_alien_teleport","scr_rcbarry1" },
    { "scr_alien_impact_bul","scr_rcbarry1" },
    { "scr_clown_appears","scr_rcbarry1" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- TELEPORTEFFECT
-----------------------------------------------------------------------------------------------------------------------------------------
function teleportEffect()
    local random = math.random(#particles)
    local dict = tostring(particles[random][2])
    local particle = tostring(particles[random][1])
    Citizen.CreateThread(function()
        RequestNamedPtfxAsset(dict)
        while not HasNamedPtfxAssetLoaded(dict) do
             Citizen.Wait(0)
        end
        local nped = GetPlayerPed(GetPlayerFromServerId(nsource))
        local particleEffect = 0
        UseParticleFxAssetNextCall(dict)
        particleEffect = StartParticleFxLoopedOnEntity(particle, nped, 0.0, 0.0, 0.0, 0.1, 0.0, 0.0, 1.0, false, false, false)
    end)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- FLY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand('fly',function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    local distance = #(coords - vector3(-1824.97,-1214.26,13.02))
    if distance <= 40 then
        if cSERVER.checkVip() then 
            toggleNoclip()
        end
    else
        TriggerEvent("ONotify","Você está muito longe do ~r~Lobby")
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- TOGGLENOCLIP
-----------------------------------------------------------------------------------------------------------------------------------------
function toggleNoclip()
	toggleFly = not toggleFly
	local ped = PlayerPedId()
    if toggleFly then
		SetEntityInvincible(ped,true)
    else
		SetEntityInvincible(ped,false)
	end
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATETHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while true do
		local timeDistance = 500
		if toggleFly then
			timeDistance = 4
			local ped = PlayerPedId()
			local x,y,z = table.unpack(GetEntityCoords(ped))
			local dx,dy,dz = vRP.getCamDirection()
			local speed = 0.3

            SetEntityVelocity(ped,0.0001,0.0001,0.0001)
            
			if IsControlPressed(1,32) then
				x = x+speed*dx
				y = y+speed*dy
				z = z+speed*dz
			end

			if IsControlPressed(1,269) then
				x = x-speed*dx
				y = y-speed*dy
				z = z-speed*dz
			end

			SetEntityCoordsNoOffset(ped,x,y,z,true,true,true)
		end
		Citizen.Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADCONTROLLER
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 1000

        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        local distance = #(coords - vector3(-1824.97,-1214.26,13.02))
        if distance <= 150 then
            timeDistance = 4
            inLobby = true
            DisplayRadar(true)
            drawTxt('~y~[LOBBY]~w~ Você está protegido.', 4,0.5,0.93,0.50,255,255,255,180)
            SetEntityInvincible(ped,true)
        else
            if inLobby then 
                SetEntityInvincible(ped,false)
                DisplayRadar(false)
                timeDistance = 4
                if toggleFly then 
                    print('[smash-common] Removed user flight')
                    toggleNoclip() 
                end
                
                inLobby = false
                print('[smash-common] Left lobby')
            end
                    
        end


        Citizen.Wait(timeDistance) 
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTROLSPAWNZONE
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        if inLobby then
            timeDistance = 4
            SetCurrentPedWeapon(ped,GetHashKey("WEAPON_UNARMED"),true)
            
            DisableControlAction(1, 37, true)
            DisableControlAction(0, 37, true)
            DisableControlAction(2, 37, true)
            DisableControlAction(1, 45, true)
            DisableControlAction(2, 80, true)
            DisableControlAction(2, 140, true)
            DisableControlAction(2, 250, true)
            DisableControlAction(2, 263, true)
            DisableControlAction(2, 310, true)
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 143, true)
            DisableControlAction(0, 24, true)
            DisableControlAction(0, 25, true)
            DisableControlAction(0, 47, true)
            DisableControlAction(0, 58, true)
            DisablePlayerFiring(ped,true)
            DisableControlAction(0, 106, true) 
        end
        Citizen.Wait(timeDistance) 
    end
end)