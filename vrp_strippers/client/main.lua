-- Util --
RegisterNetEvent("client:notification")
AddEventHandler("client:notification", function(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end)

-- Loops --
Citizen.CreateThread(function()
  while true do
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
  	for k, v in pairs(config.places) do
  		DrawMarker(1, v.startPos.x, v.startPos.y, v.startPos.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 153, 0, 0, 50, false, true, 2, nil, nil, false)
  		DrawMarker(1, v.stopPos.x, v.stopPos.y, v.stopPos.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 153, 0, 0, 50, false, true, 2, nil, nil, false)
  		if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.startPos.x, v.startPos.y, v.startPos.z, true) < 1.0 then
  		  SetTextComponentFormat("STRING")
  		  AddTextComponentString("Appuyez sur ~INPUT_CONTEXT~ pour payer les danseuses.")
  		  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  		  if IsControlJustReleased(1, 51) then
          TriggerServerEvent("unicorn:startPublicShow", v.id)
  		  end
  		elseif GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.stopPos.x, v.stopPos.y, v.stopPos.z, true) < 1.0 then
  		  SetTextComponentFormat("STRING")
  		  AddTextComponentString("Appuyez sur ~INPUT_CONTEXT~ pour renvoyer les danseuses.")
  		  DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  		  if IsControlJustReleased(1, 51) then
          TriggerServerEvent("unicorn:stopPublicShow", v.id)
  		  end
  		end
  	end
    Citizen.Wait(0)
  end
end)

-- Events --
RegisterNetEvent("unicorn:startDance")
AddEventHandler("unicorn:startDance", function(id)
  TriggerServerEvent("unicorn:setDancing", id, "spawning")
  local hash = config.places[id].hash
  for i,v in ipairs(hash) do
    local i = 0
    while not HasModelLoaded(v) and i < 5 do
      RequestModel(v)
      Wait(1000)
      i = i + 1
    end
  end
  RequestAnimDict(config.dic)
  while (not HasAnimDictLoaded(config.dic)) do Citizen.Wait(1) end

  Strippers = {}
  for k,v in pairs(config.places[id].positions) do
    local ran = math.random(1, #hash)
    local stripper = CreatePed(5, hash[ran], v.x, v.y, v.z, v.a, true, true)
    SetPedArmour(stripper, 0)
    SetPedMaxHealth(stripper, 200)
    SetPedDiesWhenInjured(ped, false)
    TaskPlayAnim(stripper,config.dic,config.dance, 8.0, 0.0, -1, 1, 0, 0, 1, 0)
    local nid = PedToNet(stripper)
    table.insert(Strippers, nid)
    Wait(1000)
  end
  TriggerServerEvent("unicorn:addStrippers", id, Strippers)
  TriggerServerEvent("unicorn:setDancing", id, "dancing")
end)

RegisterNetEvent("unicorn:alreadyDancing")
AddEventHandler("unicorn:alreadyDancing", function(id, str)
  local exist = false
  for i,v in ipairs(str) do
    local cid = NetToPed(v)
    if DoesEntityExist(cid) then
      exist = true
    end
  end
  if not exist then
    TriggerServerEvent("unicorn:setDancing", id, "false")
    TriggerServerEvent("unicorn:startPublicShow", id)
  else
    TriggerEvent("client:notification", "~r~Des danseuses sont déjà présentes")
  end
end)

RegisterNetEvent("unicorn:deleteStrippers")
AddEventHandler("unicorn:deleteStrippers", function(id, dancers)
  if dancers then
    for k, v in pairs(dancers) do
      local cid = NetToPed(v)
      StopAnimTask(cid, config.dic, config.dance, 1.0)
      TaskGoToCoordAnyMeans(cid, config.places[id].dispawnPos.x, config.places[id].dispawnPos.y, config.places[id].dispawnPos.z, 1.0, 0.0, 0.0, 786603, 0xbf800000)
    end
    Wait(config.places[id].dispawnTime)
    for k, v in pairs(dancers) do
      local cid = NetToPed(v)
      DeleteEntity(cid)
    end
    TriggerServerEvent("unicorn:setDancing", id, "false")
  end
end)
