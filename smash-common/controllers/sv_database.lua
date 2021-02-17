-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES - GLOBAL
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("vRP/getInfos","SELECT * FROM vrp_infos WHERE user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES - STREAKS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("vRP/updKills","UPDATE vrp_infos SET kills = kills + 1 WHERE user_id = @user_id")
vRP._prepare("vRP/updKd","UPDATE vrp_infos SET kd = @kd WHERE user_id = @user_id")
vRP._prepare("vRP/updDeaths","UPDATE vrp_infos SET deaths = deaths + 1 WHERE user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES - CONFIGS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("vRP/updParticles","UPDATE vrp_infos SET particles = @particles WHERE user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES - COINS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("vRP/createAccountCoins","INSERT INTO vrp_infos(user_id,kills,deaths,coins,kd,particles) VALUES(@user_id,@kills,@deaths,@coins,@kd,@particles)")
vRP._prepare("vRP/setCoins","UPDATE vrp_infos SET coins = 0 WHERE user_id = @user_id")
vRP._prepare("vRP/addCoins","UPDATE vrp_infos SET coins = coins + @coins WHERE user_id = @user_id")
vRP._prepare("vRP/removeCoins","UPDATE vrp_infos SET coins = coins - @coins WHERE user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES - RANK
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("vRP/getRank","SELECT * FROM vrp_infos ORDER BY kills DESC")
-----------------------------------------------------------------------------------------------------------------------------------------
-- PREPARES - ATTACHS
-----------------------------------------------------------------------------------------------------------------------------------------
vRP._prepare("vRP/getAttachs","SELECT * FROM vrp_attachs WHERE user_id = @user_id")
vRP._prepare("vRP/createAttach","INSERT INTO vrp_attachs(user_id,grip,lanterna,compensador,silenciador,pente,miraS,miraA,tracante) VALUES(@user_id,@grip,@lanterna,@compensador,@silenciador,@pente,@miraS,@miraA,@tracante)")
vRP._prepare("vRP/addgrip","UPDATE vrp_attachs SET grip = 1 WHERE user_id = @user_id")
vRP._prepare("vRP/addlanterna","UPDATE vrp_attachs SET lanterna = 1 WHERE user_id = @user_id")
vRP._prepare("vRP/addcompensador","UPDATE vrp_attachs SET compensador = 1 WHERE user_id = @user_id")
vRP._prepare("vRP/addsilenciador","UPDATE vrp_attachs SET silenciador = 1 WHERE user_id = @user_id")
vRP._prepare("vRP/addpente","UPDATE vrp_attachs SET pente = 1 WHERE user_id = @user_id")
vRP._prepare("vRP/addmiraS","UPDATE vrp_attachs SET miraS = 1 WHERE user_id = @user_id")
vRP._prepare("vRP/addmiraA","UPDATE vrp_attachs SET miraA = 1 WHERE user_id = @user_id")
-----------------------------------------------------------------------------------------------------------------------------------------
-- CREATE
-----------------------------------------------------------------------------------------------------------------------------------------
AddEventHandler("vRP:playerSpawn",function(user_id,source,first_spawn)
    if user_id ~= nil then 
        local query = vRP.query("vRP/getInfos",{ user_id = user_id })
        if not query[1] then
            vRP.execute("vRP/createAccountCoins",{ user_id = user_id, kills = 0, deaths = 0, coins = 1000, kd = 0.0, particles = 1 })
        end

        local attachs = vRP.query("vRP/getAttachs",{ user_id = user_id })
        if not attachs[1] then
            vRP.execute("vRP/createAttach",{ user_id = user_id, grip = 0, lanterna = 0, compensador = 0, silenciador = 0, pente = 0, miraS = 0, miraA = 0, tracante = 0 })
        end
    end
end)