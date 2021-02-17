-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cFFA = {}
Tunnel.bindInterface("coreFFA",cFFA)
ffaServer = Tunnel.getInterface("coreFFA")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
local arenaId = 0 
local intoArena = false 
local arenas = {
    [1] = {
        center = { -1736.51,162.28,64.38 },
        enter = { -1814.21,-1213.12,13.02 },
        spawns = {
            { -1737.6,182.47,64.38 },
            { -1748.8,178.48,64.37 },
            { -1758.18,171.12,64.38 },
            { -1739.14,131.9,64.51 },
            { -1708.22,150.11,64.39 },
            { -1713.46,170.43,64.16 },
            { -1730.36,197.58,64.16 }
        },
    },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- MAINTHREAD
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 500
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        
        if not intoArena then
            for k,v in pairs(arenas) do
                local distance = #(coords - vector3(v["enter"][1],v["enter"][2],v["enter"][3]))
                if distance <= 1.5 then
                    timeDistance = 4 
                    if IsControlJustPressed(0,38) then
                        if ffaServer.checkParticipants(k) then
                            intoArena = true
                            arenaId = k
                            TriggerEvent("smash-base:initScripts",true)
                            SetEntityHealth(ped,399)
                            SetTimeout(3000,function()
                                TriggerEvent("smash-base:initScripts",false)
                            end)
                            
                            local spawn = math.random(#v["spawns"])
                            SetEntityCoords(ped,v["spawns"][spawn][1],v["spawns"][spawn][2],v["spawns"][spawn][3]-0.96)
                            TriggerEvent("ONotify","~g~[FFA] ~w~Você entrou no modo de jogo FFA, se divirta!")
                        else
                            TriggerEvent("ONotify","~g~[FFA] ~w~Você entrou no modo de jogo FFA, se divirta!")
                        end
                    end
                end

                local distance2 = #(coords - vector3(v["center"][1],v["center"][2],v["center"][3]))
                if distance2 <= 150 then
                    TriggerEvent("ONotify","~r~[FFA] ~w~Você está muito próximo de uma arena~w~")
                    ExecuteCommand("lobby") 
                end
            end
        end


        if intoArena then
            manageWeapons()
            
            if arenaId == nil then 
                return
            end


            local distance = #(coords - vector3(arenas[arenaId]["center"][1],arenas[arenaId]["center"][2],arenas[arenaId]["center"][3]))
            if distance > 76 then
                Citizen.Wait(1000) -- debug
                if intoArena and distance > 76 then -- debug
                    SetEntityCoords(ped,arenas[arenaId]["center"][1],arenas[arenaId]["center"][2],arenas[arenaId]["center"][3]-0.96)
                end
            end

            if GetEntityHealth(ped) <= 101 then
                local spawn = math.random(#arenas[arenaId]["spawns"])
                local coords2 = GetEntityCoords(ped)
                TriggerEvent("smash-common:killGod")
                TriggerEvent("smash-base:initScripts",true)
                SetEntityHealth(ped,399)
                SetTimeout(3000,function()
                    TriggerEvent("smash-base:initScripts",false)
                end)
                SetEntityCoords(ped,arenas[arenaId]["spawns"][spawn][1],arenas[arenaId]["spawns"][spawn][2],arenas[arenaId]["spawns"][spawn][3]-0.96)
                SetCurrentPedWeapon(ped,GetHashKey("WEAPON_PISTOL_MK2"),true)
            end
        end

        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SAIRARENA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("smash-common:disableFFA")
AddEventHandler("smash-common:disableFFA",function()
    if intoArena then
        ffaServer.outArena(arenaId)
        arenaId = 0
        intoArena = false
        Citizen.Wait(1000)
        intoArena = false
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MANAGEWEAPONS
-----------------------------------------------------------------------------------------------------------------------------------------
function manageWeapons()
    local playerPed = GetPlayerPed(-1)
    RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_ASSAULTRIFLE"));
	RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_MACHINEPISTOL"));
	RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_SMG"));
	RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_SMG_MK2"));
	RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_MICROSMG"));
	RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_ASSAULTSMG"));
	RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_COMBATPDW"));
	RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_SPECIALCARBINE"));
	RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_SPECIALCARBINE_MK2"));
    RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_ASSAULTRIFLE_MK2"));
    RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_ASSAULTRIFLE"));
	RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_CARBINERIFLE_MK2"));
	RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_CARBINERIFLE"));
	RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_PUMPSHOTGUN_MK2"));
	RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_SAWNOFFSHOTGUN"));

	GiveWeaponToPed(playerPed,GetHashKey("WEAPON_PISTOL_MK2"),-1,true)
	SetPedAmmo(playerPed,GetHashKey("WEAPON_PISTOL_MK2"),-1)
	GiveWeaponToPed(playerPed,GetHashKey("WEAPON_HEAVYPISTOL"),250,true)
	GiveWeaponToPed(playerPed,GetHashKey("WEAPON_SNSPISTOL"),250,true)
	GiveWeaponToPed(playerPed,GetHashKey("WEAPON_COMBATPISTOL"),250,true)
	RestorePlayerStamina(PlayerId(),1.0)
    ClearPedProp(playerPed,0)
end