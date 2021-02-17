-----------------------------------------------------------------------------------------------------------------------------------------
-- CONNECTION
-----------------------------------------------------------------------------------------------------------------------------------------
cO = {}
Tunnel.bindInterface("coreOptions",cO)
oSERVER = Tunnel.getInterface("coreOptions")
-----------------------------------------------------------------------------------------------------------------------------------------
-- MASK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setMask')
AddEventHandler('setMask',function(model,color)
    local ped = PlayerPedId()
    if model == nil then
        SetPedComponentVariation(ped,1,0,0,2)
    end

    SetPedComponentVariation(ped,1,parseInt(model),parseInt(color),2)
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BLUSA
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setBlusa')
AddEventHandler('setBlusa',function(model,color)
    local ped = PlayerPedId()
    if model == nil then
        model = 15
    end

    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(ped,8,parseInt(model),parseInt(color),2)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        SetPedComponentVariation(ped,8,parseInt(model),parseInt(color),2)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- VEST
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setVest')
AddEventHandler('setVest',function(model,color)
    local ped = PlayerPedId()
    if not model then
        SetPedComponentVariation(ped,9,0,0,2)
    end

    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(ped,9,parseInt(model),parseInt(color),2)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        SetPedComponentVariation(ped,9,parseInt(model),parseInt(color),2)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- JACKET
---------------------------------------------------------t/--------------------------------------------------------------------------------
RegisterNetEvent('setJacket')
AddEventHandler('setJacket',function(model,color)
    local ped = PlayerPedId()
    if model == nil then 
        model = 15 
    end

    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(ped,11,parseInt(model),parseInt(color),2)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        SetPedComponentVariation(ped,11,parseInt(model),parseInt(color),2)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- BACKPACK
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setBackpack')
AddEventHandler('setBackpack',function(model,color)
    local ped = PlayerPedId()
    if not model then
        SetPedComponentVariation(ped,5,15,0,2)
    end

    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(ped,5,parseInt(model),parseInt(color),2)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        SetPedComponentVariation(ped,5,parseInt(model),parseInt(color),2)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HANDS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setHands')
AddEventHandler('setHands',function(model,color)
    local ped = PlayerPedId()
    if not model then
        SetPedComponentVariation(ped,3,15,0,2)
    end

    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(ped,3,parseInt(model),parseInt(color),2)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        SetPedComponentVariation(ped,3,parseInt(model),parseInt(color),2)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- LEGS
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setLegs')
AddEventHandler('setLegs',function(model,color)
    local ped = PlayerPedId()
    if not model then
        if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
            SetPedComponentVariation(ped,4,18,0,2)
        else
            SetPedComponentVariation(ped,4,15,0,2)
        end
    end

    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(ped,4,parseInt(model),parseInt(color),2)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        SetPedComponentVariation(ped,4,parseInt(model),parseInt(color),2)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ACESSORIES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setAcessories')
AddEventHandler('setAcessories',function(model,color)
    local ped = PlayerPedId()
    if not model then
        SetPedComponentVariation(ped,7,0,0,2)
        return
    end

    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(ped,7,parseInt(model),parseInt(color),2)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        SetPedComponentVariation(ped,7,parseInt(model),parseInt(color),2)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- SHOES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setShoes')
AddEventHandler('setShoes',function(model,color)
    local ped = PlayerPedId()
    if not model then
        if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
            SetPedComponentVariation(ped,6,34,0,2)
        elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
            SetPedComponentVariation(ped,6,35,0,2)
        end
        return
    end

    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SetPedComponentVariation(ped,6,parseInt(model),parseInt(color),2)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        SetPedComponentVariation(ped,6,parseInt(model),parseInt(color),2)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- HAT
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setHat')
AddEventHandler('setHat',function(model,color)
    local ped = PlayerPedId()
    if not model then
        ClearPedProp(ped,0)
        return
    end

    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SetPedPropIndex(ped,0,parseInt(model),parseInt(color),2)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        SetPedPropIndex(ped,0,parseInt(model),parseInt(color),2)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- GLASSES
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterNetEvent('setGlasses')
AddEventHandler('setGlasses',function(model,color)
    local ped = PlayerPedId()
    if not model then
		ClearPedProp(ped,1)
        return
    end

    if GetEntityModel(ped) == GetHashKey("mp_m_freemode_01") then
        SetPedPropIndex(ped,1,parseInt(model),parseInt(color),2)
    elseif GetEntityModel(ped) == GetHashKey("mp_f_freemode_01") then
        SetPedPropIndex(ped,1,parseInt(model),parseInt(color),2)
    end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ENERGETIC
-----------------------------------------------------------------------------------------------------------------------------------------
local isEnergetic = false

RegisterNetEvent('smash-common:eNergetic')
AddEventHandler('smash-common:eNergetic',function(status)
	isEnergetic = status
	if isEnergetic then
		SetRunSprintMultiplierForPlayer(PlayerId(),1.20)
	else
		SetRunSprintMultiplierForPlayer(PlayerId(),1.0)
	end
end)

CreateThread(function()
	while true do
		local timeDistance = 500
		if isEnergetic then
			timeDistance = 4
			RestorePlayerStamina(PlayerId(),1.0)
		end
		Wait(timeDistance)
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- COR
-----------------------------------------------------------------------------------------------------------------------------------------
RegisterCommand("cor",function(source,args)
	local tint = parseInt(args[1])
	if oSERVER.checkBooster() then
		if tint >= 0 then
            SetPedWeaponTintIndex(PlayerPedId(),GetSelectedPedWeapon(PlayerPedId()),tint)
        end
	end
end)
-----------------------------------------------------------------------------------------------------------------------------------------
-- ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
local attachs = {
    ["961495388"] = { -- ASSAULTRIFLE_MK2
        ["components"] = {
            ["grip"] = { "COMPONENT_AT_AR_AFGRIP_02" }, 
            ["lan"] = { "COMPONENT_AT_AR_FLSH" }, 
            ["pente"] = { "COMPONENT_ASSAULTRIFLE_MK2_CLIP_02" },
            ["simples"] = { "COMPONENT_AT_SIGHTS" },             
            ["completa"] = { "COMPONENT_AT_SCOPE_MEDIUM_MK2" }, 
            ["tracante"] = { "COMPONENT_ASSAULTRIFLE_MK2_CLIP_TRACER" }, 
        },
    },

    ["-2084633992"] = { -- CARBINERIFLE
        ["components"] = {
            ["grip"] = { "COMPONENT_AT_AR_AFGRIP" }, 
            ["lan"] = { "COMPONENT_AT_AR_FLSH" }, 
            ["pente"] = { "COMPONENT_CARBINERIFLE_CLIP_02" },
            ["completa"] = { "COMPONENT_AT_SCOPE_MEDIUM" }, 
        },
    },
    ["-86904375"] = { -- CARBINERIFLE_MK2
        ["components"] = {
            ["grip"] = { "COMPONENT_AT_AR_AFGRIP_02" }, 
            ["lan"] = { "COMPONENT_AT_AR_FLSH" },
            ["pente"] = { "COMPONENT_CARBINERIFLE_MK2_CLIP_02" },
            ["completa"] = { "COMPONENT_AT_SCOPE_MEDIUM_MK2" }, 
            ["simples"] = { "COMPONENT_AT_SIGHTS" }, 
            ["tracante"] = { "COMPONENT_CARBINERIFLE_MK2_CLIP_TRACER" }, 
        },
    },
    ["-1768145561"] = { -- SPECIALCARBINE_MK2
        ["components"] = {
            ["grip"] = { "COMPONENT_AT_AR_AFGRIP_02" }, 
            ["lan"] = { "COMPONENT_AT_AR_FLSH" },
            ["completa"] = { "COMPONENT_AT_SCOPE_MEDIUM_MK2" },
            ["pente"] = { "COMPONENT_SPECIALCARBINE_MK2_CLIP_02" }, 
            ["simples"] = { "COMPONENT_AT_AR_FLSH" },             
            ["tracante"] = { "COMPONENT_SPECIALCARBINE_MK2_CLIP_TRACER" }, 
        },
    },
    ["-619010992"] = { -- MACHINEPISTOL
        ["components"] = {
            ["pente"] = { "COMPONENT_MACHINEPISTOL_CLIP_02" },
        },
    },
    ["736523883"] = { -- SMG
        ["components"] = {
            ["lan"] = { "COMPONENT_AT_AR_FLSH" }, 
            ["grip"] = { "COMPONENT_AT_SCOPE_MACRO_02" }, 
            ["pente"] = { "COMPONENT_SMG_CLIP_02" },
        },
    },
    ["2024373456"] = { -- SMG_MK2
        ["components"] = {
            ["lan"] = { "COMPONENT_AT_AR_FLSH" }, 
            ["simples"] = { "COMPONENT_AT_SCOPE_SMALL_SMG_MK2" }, 
            ["pente"] = { "COMPONENT_SMG_MK2_CLIP_02" },
            ["completa"] = { "COMPONENT_AT_SIGHTS_SMG" }, 
            ["tracante"] = { "COMPONENT_SMG_MK2_CLIP_TRACER" }, 
        },
    },

    ["-1075685676"] = { -- PISTOL_MK2
        ["components"] = {
            ["lan"] = { "COMPONENT_AT_PI_FLSH_02" }, 
            ["compensador"] = { "COMPONENT_AT_PI_COMP" }, 
            ["pente"] = { "COMPONENT_PISTOL_MK2_CLIP_02" }, 
            ["completa"] = { "COMPONENT_AT_PI_RAIL" }, 
            ["tracante"] = { "COMPONENT_PISTOL_MK2_CLIP_TRACER" }, 
        },
    },

    ["1593441988"] = { -- COMBATPISTOL
        ["components"] = {
            ["lan"] = { "COMPONENT_AT_PI_FLSH" }, 
            ["pente"] = { "COMPONENT_COMBATPISTOL_CLIP_02" },
        },
    },

    ["-1076751822"] = { -- SNSPISTOL
        ["components"] = {
            ["pente"] = { "COMPONENT_SNSPISTOL_CLIP_02" }, 
        },
    },

    ["-771403250"] = { -- HEAVYPISTOL
        ["components"] = {
            ["pente"] = { "COMPONENT_HEAVYPISTOL_CLIP_02" }, 
            ["lan"] = { "COMPONENT_AT_PI_FLSH" }, 
        },
    },    
}

RegisterCommand("attachs",function(source,args)
    local ped = PlayerPedId()
    
    if not args[1] then
        return 
    end    

    local compName = string.lower(args[1])
    local wUse = GetSelectedPedWeapon(ped)

    if not attachs[tostring(wUse)] then
        TriggerEvent("ONotify","A arma que você está não possui ~g~Attachs~w~.")
        return 
    end 

    if args[1] == "todos" then
        if oSERVER.checkAttach("todos") then
            for k,v in pairs(attachs[tostring(wUse)]["components"]) do 
                GiveWeaponComponentToPed(ped,wUse,GetHashKey(attachs[tostring(wUse)]["components"][tostring(k)][1]))
            end
        end
        return
    end    

    if not attachs[tostring(wUse)]["components"][tostring(compName)] then
        TriggerEvent("ONotify","Este componente não ~g~existe~w~.")
        return 
    end

    if oSERVER.checkAttach(tostring(compName)) then
        GiveWeaponComponentToPed(ped,wUse,GetHashKey(attachs[tostring(wUse)]["components"][tostring(compName)][1]))
    end
end)    


RegisterKeyMapping("armas","Pegar armas","keyboard","f1")
RegisterKeyMapping("use energetico","Usar energetico","keyboard","f2")

RegisterCommand("fps",function(source,args)
    if args[1] == "on" then
        SetTimecycleModifier("cinema")
        TriggerEvent("Notify","sucesso","Boost de fps ligado!")
    elseif args[1] == "off" then
        SetTimecycleModifier("default")
        TriggerEvent("Notify","sucesso","Boost de fps desligado!")
    end
end)