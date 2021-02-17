Citizen.CreateThread(function()
    local isDead = false 
    local hasBeenDead = false 
    local diedAt 
    
    while true do
        Citizen.Wait(0)

        local player = PlayerId()
        if NetworkIsPlayerActive(player) then
            local ped = PlayerPedId()
            if IsPedFatallyInjured(ped) and not isDead then
                isDead = true 
                if not diedAt then
                    diedAt = GetGameTimer() 
                end

                local killer,killerWeapon = NetworkGetEntityKillerOfPlayer(player)
                local killerEntityType = GetEntityType(killer)
                local killerType = -1

                local killerId = GetPlayerByEntityID(killer)
                if killer ~= ped and killerId ~= nil and NetworkIsPlayerActive(killerId) then
                    killerId = GetPlayerServerId(killerId)
                else
                    killerId = -1 
                end

                local coords = GetEntityCoords(ped)
                local distance = #(coords - vector3(1775.44,3706.6,34.27))
                local distance2 = #(coords - vector3(1006.75,2366.65,55.57))
                local distance3 = #(coords - vector3(-1736.51,162.28,64.38))
                local distance4 = #(coords - vector3(-2058.71,3093.54,32.82))

                if killer == ped or killer == -1  then
                    hasBeenDead = true
                elseif distance <= 353.533 then -- Pistol Zone
                    TriggerServerEvent('smash-common:killed',"sucesso",killerId,{ killerType = killerType, weaponhash = killerWeapon, killerinveh = false, killervehseat = 0, killervehname = "", killerpos = {table.unpack(GetEntityCoords(ped))}})
                    hasBeenDead = true
                elseif distance2 <= 298.865234375 then -- Fuzil Zone
                    TriggerServerEvent('smash-common:killed',"negado",killerId,{ killerType = killerType, weaponhash = killerWeapon, killerinveh = false, killervehseat = 0, killervehname = "", killerpos = {table.unpack(GetEntityCoords(ped))}})
                    hasBeenDead = true
                elseif distance3 <= 150.00 then -- FFA Zone
                    TriggerServerEvent('smash-common:killed',"aviso",killerId,{ killerType = killerType, weaponhash = killerWeapon, killerinveh = false, killervehseat = 0, killervehname = "", killerpos = {table.unpack(GetEntityCoords(ped))}})
                    hasBeenDead = true
                elseif distance4 <= 130.00 then -- GUN GAME
                    TriggerServerEvent('gunGame:init',killerId,{ killerType = killerType, weaponhash = killerWeapon, killerinveh = false, killervehseat = 0, killervehname = "", killerpos = {table.unpack(GetEntityCoords(ped))}})
                    hasBeenDead = true
                else
                    hasBeenDead = true
                end
            elseif not IsPedFatallyInjured(ped) then 
                isDead = false 
                diedAt = false
            end
        end
    end
end)

function GetPlayerByEntityID(id)
	for i=0,300 do
		if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
	end
	return nil
end