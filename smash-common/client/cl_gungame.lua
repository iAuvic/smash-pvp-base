-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
gG = {}
Tunnel.bindInterface("coreGungame",gG)
gunServer = Tunnel.getInterface("coreGungame")
-----------------------------------------------------------------------------------------------------------------------------------------
-- VARIABLES
-----------------------------------------------------------------------------------------------------------------------------------------
-- local estaNoLobby
local intoLobby = false
local jogoPronto = false
local qtdNoLobby = 0
local setouCoordPevepe = false
local qtdMatouIndividual = 0
local pegouArmaX = {}
local qualArmaOJogadorEsta = nil
-----------------------------------------------------------------------------------------------------------------------------------------
-- WEAPON_LIST
-----------------------------------------------------------------------------------------------------------------------------------------
local weaponList = {
    [0] = { "WEAPON_SNSPISTOL" },
    [1] = { "WEAPON_HEAVYPISTOL" },
    [2] = { "WEAPON_COMBATPISTOL" },
    [3] = { "WEAPON_PISTOL_MK2" },
    [4] = { "WEAPON_MICROSMG" },
    [5] = { "WEAPON_SMG" },
    [6] = { "WEAPON_SMG_MK2" },
    [7] = { "WEAPON_COMBATPDW" },
    [8] = { "WEAPON_MACHINEPISTOL" },
    [9] = { "WEAPON_ASSAULTRIFLE" },
    [10] = { "WEAPON_ASSAULTRIFLE_MK2" },
    [11] = { "WEAPON_CARBINERIFLE" },
    [12] = { "WEAPON_CARBINERIFLE_MK2" },
    [13] = { "WEAPON_SPECIALCARBINE_MK2" },
    [14] = { "WEAPON_MG" },
    [15] = { "WEAPON_COMBATMG" },
    [16] = { "WEAPON_COMBATMG_MK2" },
    [17] = { "WEAPON_HEAVYSNIPER" },
    [18] = { "WEAPON_SNIPERRIFLE" },
    [19] = { "WEAPON_KNIFE" },
}
-----------------------------------------------------------------------------------------------------------------------------------------
-- THREADLOBBY
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        local timeDistance = 1000

        local distance = #(coords - vector3(-2058.66,3093.44,32.82))
        if distance <= 300.00 then 
            timeDistance = 4
            DrawMarker(1,-2058.66,3093.44,32.82-0.3,0,0,0,0.0,0,0,100.0,100.0,100.0,34,139,34,100,0,0,0,0)
        end

        if not intoLobby then

            -- /* Evento de proximidade (Fora de arena)
            local distance2 = #(coords - vector3(-2058.66,3093.44,32.82))
            if distance <= 300.00 and not intoLobby then 
                timeDistance = 4
                Citizen.Wait(1000)
                if not intoLobby and distance <= 300.00 then
                    TriggerEvent("ONotify","~r~[GunGame] ~w~Você está muito próximo de uma arena~w~")
                    ExecuteCommand("lobby") 
                end
            end


            -- /* Evento de entrada
            local distance = #(coords - vector3(-1820.31,-1220.05,13.02))
            if distance <= 2 then 
                timeDistance = 4
                if IsControlJustPressed(0,38) then
                    if not jogoPronto then

                        if not gunServer.checkPerm() then
                            TriggerEvent("ONotify","~r~[GunGame]: ~w~Esta ação exige acesso restrito.")
                            return
                        end

                        if gunServer.lobbyManager("podeEntrar") then
                            DoScreenFadeOut(1000)
                            Citizen.Wait(1000)

                            SetEntityCoords(ped,-2058.66,3093.44)
                            SetEntityHeading(ped,328.28)

                            Citizen.Wait(2000)
                            FreezeEntityPosition(ped,true)
                            gunServer.lobbyManager("add")
                            intoLobby = true

                            Citizen.Wait(1000)
                            DoScreenFadeIn(1000)
                        else
                            TriggerEvent("ONotify","~r~[GunGame]: ~w~Este lobby está cheio.")
                        end
                    else
                        TriggerEvent("ONotify","~r~[GunGame]: ~w~Este jogo já foi iniciado.")
                    end
                end
            end

        end 

        -- /* Já dentro do lobby
        if intoLobby then
            timeDistance = 4
            
            -- /* Evento de distância (dentro do lobby)
            local distance = #(coords - vector3(-2058.63,3093.53,32.82))
            if distance > 85 then
                Citizen.Wait(1000) -- debug
                if intoLobby and distance > 100 then -- debug
                    SetEntityCoords(ped,-2058.63,3093.53,32.82)
                end
            end



            -- /* Aguardando jogadores
            if not jogoPronto then
                TriggerEvent("ONotify","~b~[GunGame]:~w~ Aguardando jogadores... ~b~["..qtdNoLobby.."/2]~w~") -- // Mudar parametro de 2
                SetEntityInvincible(ped,true)
            end

            -- /* Iniciar jogo
            if jogoPronto then
                SetEntityInvincible(ped,false)

                if not setouCoordPevepe then
                    FreezeEntityPosition(ped,false)
                    TriggerEvent("ONotify","~b~[GunGame]: ~w~O dano foi ativado, boa sorte jogadores!~w~")
                    setouCoordPevepe = true
                end

                -- /* Manejo de kills e armas
                if setouCoordPevepe then              
                    timeDistance = 1
                    RestorePlayerStamina(PlayerId(),1.0)
                    ClearPedProp(playerPed,0)

                    if qtdMatouIndividual == 20 then 
                        Citizen.Wait(1000)
                        gunServer.setWinner()
                        SetEntityCoords(ped,-1845.24,-1228.58,13.03)
                        goto finish
                    end

                    if weaponList[qtdMatouIndividual] then 
                        if not pegouArmaX[qtdMatouIndividual] then
                            manageGuns(weaponList[qtdMatouIndividual][1])
                            qualArmaOJogadorEsta = weaponList[qtdMatouIndividual][1]
                            pegouArmaX[qtdMatouIndividual] = true
                        end
                    end
                    

                    if GetEntityHealth(ped) <= 101 then
                        Citizen.Wait(1000)
                        TriggerEvent("smash-common:killGod")
                        TriggerEvent("smash-base:initScripts",true)
                        SetEntityHealth(ped,399)
                        SetTimeout(3000,function()
                            TriggerEvent("smash-base:initScripts",false)
                        end)

                        -- local spawn = math.random(#arenas[arenaId]["spawns"])
                        -- local coords2 = GetEntityCoords(ped)
                        -- SetEntityCoords(ped,arenas[arenaId]["spawns"][spawn][1],arenas[arenaId]["spawns"][spawn][2],arenas[arenaId]["spawns"][spawn][3]-0.96)
                        SetCurrentPedWeapon(ped,GetHashKey(qualArmaOJogadorEsta),true)
                    end        





                end                    
            end

            
        end
        ::finish::

        Citizen.Wait(timeDistance)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JOGOPRONTO
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gunGame:jogoPronto")
AddEventHandler("gunGame:jogoPronto",function(status)
    jogoPronto = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- QTDNOLOBBY
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gunGame:qtdNoLobby")
AddEventHandler("gunGame:qtdNoLobby",function(status)
    qtdNoLobby = status
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITCLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gunGame:initC")
AddEventHandler("gunGame:initC",function(killerId,data)
    if qtdMatouIndividual == nil then 
        qtdMatouIndividual = 0 
    end

    qtdMatouIndividual = qtdMatouIndividual + 1
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- INITCLIENT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gunGame:forceStopPartida")
AddEventHandler("gunGame:forceStopPartida",function()
    intoLobby = false
    jogoPronto = false
    qtdMatouIndividual = 0
    pegouArmaX = {}
    setouCoordPevepe = false        
    qualArmaOJogadorEsta = nil
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- PLAYERLEAVE
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent("gunGame:playerLeave")
AddEventHandler("gunGame:playerLeave",function()
    jogoPronto = false
    qtdMatouIndividual = 0
    pegouArmaX = {}
    setouCoordPevepe = false        
    qualArmaOJogadorEsta = nil
    if intoLobby then
        gunServer.lobbyManager("remove")
    end 
    intoLobby = false
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- MANAGEGUNS
-----------------------------------------------------------------------------------------------------------------------------------------
function manageGuns(weapon)
    local playerPed = GetPlayerPed(-1)
    RemoveAllPedWeapons(playerPed,false)

	GiveWeaponToPed(playerPed,GetHashKey(weapon),-1,true)
    SetPedAmmo(playerPed,GetHashKey(weapon),-1)    
    SetCurrentPedWeapon(playerPed,GetHashKey(weapon),true)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- CONTROLWEAPONIN
-----------------------------------------------------------------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        local timeDistance = 1000
        local ped = PlayerPedId()
        if intoLobby then
            timeDistance = 4

            DisableControlAction(1, 37, true) -- TAB
            DisableControlAction(0, 37, true) -- TAB
            DisableControlAction(2, 37, true) -- TAB

            -- DisableControlAction(1, 45, true) -- R
            -- DisableControlAction(2, 80, true) -- R
            -- DisableControlAction(2, 140, true) -- R

            -- DisableControlAction(2, 250, true)  -- R
            -- DisableControlAction(2, 263, true)  -- R
            -- DisableControlAction(2, 310, true)  -- R
            -- DisableControlAction(1, 140, true)  -- R
            -- DisableControlAction(1, 143, true)
            -- DisableControlAction(0, 47, true)
            -- DisableControlAction(0, 58, true)
        end
        Citizen.Wait(timeDistance) 
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        if not setouCoordPevepe then 
            local playerPed = GetPlayerPed(-1)
            RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_MG"));
            RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_COMBATMG"));
            RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_COMBATMG_MK2"));
            RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_HEAVYSNIPER"));
            RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_SNIPERRIFLE"));
            RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_RPG"));
            RemoveWeaponFromPed(playerPed,GetHashKey("WEAPON_KNIFE"));
        end
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- DEBUG's (FREEZE)
-----------------------------------------------------------------------------------------------------------------------------------------
--RegisterCommand('un-freeze',function()
--    FreezeEntityPosition(PlayerPedId(),false)
--end)
--
--RegisterCommand("get-infos",function()
--    print("1",intoLobby)
--    print("2",jogoPronto)
--    print("3",qtdMatouIndividual)
--    print("4",setouCoordPevepe)
--    print("5",qualArmaOJogadorEsta)
--end)
--
--RegisterCommand('set-false',function()
--    intoLobby = false
--end)