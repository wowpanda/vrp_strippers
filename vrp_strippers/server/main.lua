-- Server Config
local places = {
  {
    Strippers = {},
    state = "false",
    price = 1000
  },
  {
    Strippers = {},
    state = "false",
    price = 2000
  }
}

local Proxy = module("vrp", "lib/Proxy")
vRP = Proxy.getInterface("vRP")

RegisterNetEvent("unicorn:startPublicShow")
AddEventHandler("unicorn:startPublicShow", function(id)
  local user_id = vRP.getUserId({source})
  if places[id].state == "false" then
    if vRP.tryPayment({user_id, places[id].price}) then
      TriggerClientEvent("unicorn:startDance", source, id)
      TriggerClientEvent("client:notification", source, "Danseuses payées ~g~("..tostring(places[id].price).."$)")
    else
      TriggerClientEvent("client:notification", source, "~r~Pas assez d'argent ("..tostring(places[id].price).."$)")
    end
  elseif places[id].state == "dancing" then
    TriggerClientEvent("unicorn:alreadyDancing", source, id, places[id].Strippers)
  elseif places[id].state == "spawning" or places[id].state == "dispawning" then
    TriggerClientEvent("client:notification", source, "~r~Veuillez patienter...")
  end
end)

RegisterNetEvent("unicorn:stopPublicShow")
AddEventHandler("unicorn:stopPublicShow", function(id)
  if places[id].state == "false" then
    TriggerClientEvent("client:notification", source, "~r~Il n'y a pas de danseuses")
  elseif places[id].state == "spawning" then
    TriggerClientEvent("client:notification", source, "~r~Vous venez à peine de les appeler")
  elseif places[id].state == "dispawning" then
    TriggerClientEvent("client:notification", source, "~r~Elles sont en train de partir")
  elseif places[id].state == "dancing" then
    for k, v in pairs(GetPlayers()) do
      TriggerClientEvent("unicorn:deleteStrippers", v, id, places[id].Strippers)
    end
    TriggerClientEvent("client:notification", source, "~g~Danseuses renvoyées")
    places[id].state = "dispawning"
  end
end)

RegisterNetEvent("unicorn:addStrippers")
AddEventHandler("unicorn:addStrippers", function(id, st)
  places[id].Strippers = st
end)

RegisterNetEvent("unicorn:setDancing")
AddEventHandler("unicorn:setDancing", function(id, p1)
  places[id].state = p1
end)
