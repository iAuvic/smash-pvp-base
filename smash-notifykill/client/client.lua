RegisterNetEvent('NotifyKill')
AddEventHandler('NotifyKill',function(css,mensagem,type,mensagem2,timer)
	SendNUIMessage({ css = css, mensagem = mensagem, type = type, mensagem2 = mensagem2, timer = timer })
end)