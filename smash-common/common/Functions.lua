-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWSIMPLE
-----------------------------------------------------------------------------------------------------------------------------------------
function drawSimple(x,y,z,text,weight)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35,0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 200)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / weight
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWCOMPLEX
-----------------------------------------------------------------------------------------------------------------------------------------
function drawComplex(x,y,z,text,tmh)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35,0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 200)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / tmh
    DrawRect(_x,_y+0.025, 0.015+ factor, 0.055, 41, 11, 41, 68)
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- DRAWCARS
-----------------------------------------------------------------------------------------------------------------------------------------
function drawCars(x,y,z,text,tmh)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoords())

    SetTextScale(0.30,0.30)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 200)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / tmh
    DrawRect(_x,_y+0.025, 0.015+ factor, 0.095, 41, 11, 41, 68)
end