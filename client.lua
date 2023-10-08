local vipplayerssaved = {}
local cooldownactive = false
local cooldownactive2 = false
local cooldownactive3 = false
local spawnLocations = {
  { x = -1919.1498, y = 2052.7629, z = 140.7356},
  { x = -1921.4058, y = 2044.5853, z = 140.7352},
  { x = -1923.0010, y = 2036.4047, z = 140.7352}
}

local spawnLocations2 = {
  { x = -1897.8069, y = 2018.1476, z = 140.8549},
  { x = -1909.6173, y = 2030.2595, z = 140.7396}
}


Config = {
  DrawMarker = 10,
	VIPservers = {
    {
      Position = vector3(-1882.62, 2062.65, 160),
      vipRadius = 50.0,
			Blip = {
				Enabled = true,
				Color = 9,
				Label = 'VIP Place',
				Sprite = 493,
				Scale = 1.0
			}
		},
		-- {
		-- 	Position = vector4(-1212.63, -330.78, 37.59, 210),
		-- 	Blip = {
		-- 		Enabled = true,
		-- 		Color = 69,
		-- 		Label = 'VIP SERVERS',
		-- 		Sprite = 108,
		-- 		Scale = 0.7
		-- 	}
		-- },
	}
}

AddEventHandler('onResourceStart', function(resourceName)
--CreateThread(function ()
lib.callback('One-Code:Check4', source, function(text)
  if text == "DOESNT HAVE IT" then
    print("Doesn't Have VIP")
  else
    lib.callback('One-Code:Check5', source, function(text2)
      print(text2)
      end)
    end
  end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function(xPlayer)
--CreateThread(function ()
  lib.callback('One-Code:Check4', source, function(text)
    if text == "DOESNT HAVE IT" then
      print("Doesn't Have VIP")
    else
      lib.callback('One-Code:Check5', source, function(text2)
        print(text2)
      end)
    end
  end)
end)


AddEventHandler('onResourceStart', function(resourceName)
  if (GetCurrentResourceName() ~= resourceName) then return end
  for i = 1, #Config.VIPservers do
    if type(Config.VIPservers[i].Blip) == 'table' and Config.VIPservers[i].Blip.Enabled then
        local position = Config.VIPservers[i].Position
        local bInfo = Config.VIPservers[i].Blip
        local blip = AddBlipForCoord(position.x, position.y, position.z)
        SetBlipSprite(blip, bInfo.Sprite)
        SetBlipScale(blip, bInfo.Scale)
        SetBlipColour(blip, bInfo.Color)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentSubstringPlayerName(bInfo.Label)
        EndTextCommandSetBlipName(blip)
    end
  end
end)

function IsPlayerInVipRadius(playerId)
  for i = 1, #Config.VIPservers do
    if type(Config.VIPservers[i].Blip) == 'table' and Config.VIPservers[i].Blip.Enabled then
    local playerPed = GetPlayerPed(-1)
    local playerCoords = GetEntityCoords(playerPed)
    local distance = #(playerCoords - Config.VIPservers[i].Position)
    return distance <= Config.VIPservers[i].vipRadius
    end
  end
end

RegisterCommand("GIVEVIP", function(source, args)
  lib.callback('One-Code:Check3', source, function(response)
    if not response == "Data inserted successfully" then
      lib.notify({
        title = 'VIP',
        description = 'Nepavyko',
        type = 'ban'
      })
    else
      lib.notify({
        title = 'VIP',
        description = 'Pavyko',
        type = 'ban'
      })
    end
  end, tonumber(args[1]), tonumber(args[2]))
end)

RegisterCommand("VIP", function()
  if IsPlayerInVipRadius(source) then
    lib.callback('One-Code:Check4', source, function(granted, expires, leftDays)
      if granted == "DOESNT HAVE IT" then
          lib.showMenu('VIP_MENU2')
      else
        lib.showMenu('VIP_MENU')
        end
      end)
      else
        lib.showMenu('VIP_MENU3')
        lib.notify({
            title = 'VIP',
            description = 'Jūs esate per toli VIP serverių kad jūms veiktų lentelė',
            type = 'ban'
        })
    end
end)


lib.registerMenu({
  id = 'VIP_MENU',
  title = 'VIP MENU',
  position = 'top-right',
  options = {
      {label = 'Pasigydymas', description = 'Jūs pagydys pilnai', icon = 'bandage'},
      {label = 'Mašinos Tvarkymas', description = 'Sutvarkys jūsų mašina tiek varikli, tiek kėbulą', icon = 'screwdriver-wrench'},
      {label = 'VIP Ginklų parduotuvė', description = 'VIP Ginklų parduotuvė', icon = 'shop'},
      {label = 'Spawner', description = 'VIP Mašinos bei sraigtasparnio atspawninimas', icon = 'warehouse'},
      {label = 'Expires', description = 'Peržiurėkite jūsų vip informacija', icon = 'clock'},
  }
}, function(selected, scrollIndex, args)
    if selected == 1 then
      if cooldownactive2 then
        lib.notify({
          title = 'VIP',
          description = "You can't heal yet.",
          type = 'ban'
        })
        return
      end
      SetEntityHealth(GetPlayerPed(-1), 200)
      cooldownHeal()
    elseif selected == 2 then
      RepairVehicleInDriverSeat()
    elseif selected == 3 then
      lib.showMenu('VIP_MENU_GUNSHOP')
    elseif selected == 4 then
      lib.showMenu('VIP_MENU_SPAWNER')
    elseif selected == 5 then
      showexpiredate()
    end
end)

lib.registerMenu({
  id = 'VIP_MENU2',
  title = 'VIP MENU',
  position = 'top-left',
  options = {
      {label = 'Įspėjimas', description = 'Jūs esate per toli VIP serverinės', icon = 'warning'},
      {label = 'Laikotarpis', description = 'Peržiurėkite jūsų vip informacija', icon = 'clock'},
  }
}, function(selected, scrollIndex, args)
    if selected == 1 then
      lib.showMenu('VIP_MENU2')
    elseif selected == 2 then
      showexpiredate()
    end
end)


lib.registerMenu({
  id = 'VIP_MENU3',
  title = 'VIP MENU',
  position = 'top-right',
  options = {
      {label = 'Warning!', description = 'You are too far away from the servers for full access.', icon = 'warning'},
      {label = 'Expires', description = 'Peržiurėkite jūsų vip informacija', icon = 'clock'},
  }
}, function(selected, scrollIndex, args)
    if selected == 1 then
      lib.showMenu('VIP_MENU2')
    elseif selected == 2 then
      showexpiredate()
    end
end)


lib.registerMenu({
  id = 'VIP_MENU_SPAWNER',
  title = 'VIP MENU',
  position = 'top-right',
  options = {
      {label = 'Informacija', description = 'Pasirinkite automobili kurį norite atsispawninti', icon = 'info'},
      {label = 'Atsispawninti Sraigtasparni', description = 'Atsispawninti VIP Sraigtasparni', icon = 'helicopter'},
      {label = 'Atsispawninti Mašiną', description = 'Atsispawninti VIP Automobili', icon = 'car'},
  }
}, function(selected, scrollIndex, args)
    if selected == 1 then
      lib.showMenu('VIP_MENU_SPAWNER')
    elseif selected == 2 then
      SpawnVehicle("supervolito", spawnLocations2)
    elseif selected == 3 then
      SpawnVehicle("tailgater2", spawnLocations)
    end
end)


function showexpiredate()
  lib.callback('One-Code:Check4', source, function(granted, expires, leftDays)
    if granted == "DOESNT HAVE IT" then
      expires = 0
      leftDays = 0
    end
    lib.registerMenu({
      id = 'VIP_MENU_TIMER',
      title = 'VIP MENU',
      position = 'top-right',
      options = {
          {label = 'Buvo suteikta ' ..granted.."", icon = 'clock'},
          {label = 'Galioja iki ' .. expires.."", icon = 'clock'},
          {label = 'VIP statusas pasibaigs '..leftDays..' Days', icon = 'clock'},
      }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
          lib.showMenu('VIP_MENU_TIMER')
        elseif selected == 2 then
          lib.showMenu('VIP_MENU_TIMER')
        elseif selected == 3 then
          lib.showMenu('VIP_MENU_TIMER')
        end
    end)
    lib.registerMenu({
      id = 'VIP_MENU_TIMER2',
      title = 'VIP MENU',
      position = 'top-right',
      options = {
          {label = 'You don\'t have VIP', icon = 'clock'},
      }
    }, function(selected, scrollIndex, args)
        if selected == 1 then
          lib.showMenu('VIP_MENU_TIMER2')
        end
    end)
       if granted == "DOESNT HAVE IT" then
        lib.showMenu('VIP_MENU_TIMER2')
       else
        lib.showMenu('VIP_MENU_TIMER')
      end
  end)
end


lib.registerMenu({
  id = 'VIP_MENU_GUNSHOP',
  title = 'VIP MENU',
  position = 'top-right',
  options = {
      {label = 'Pistoletas DP9', description = '30000$', icon = 'gun'},
      {label = 'Pistoletas WM 29', description = '30000$', icon = 'gun'},
      {label = 'Pistoletas Browning', description = '30000$', icon = 'gun'},
      {label = 'Pistoletas Glock', description = '50000$', icon = 'gun'},
      {label = 'Automatas AK-47', description = '300000$', icon = 'gun'},
      {label = 'Automatas M4', description = '350000$', icon = 'gun'},
      {label = 'Automatukas Uzi', description = '65000$', icon = 'gun'},
      {label = 'Automatukas SMG', description = '42500$', icon = 'gun'},
      {label = 'Automatukas Kovinis SMG', description = '80000$', icon = 'gun'},
      {label = 'Automatukas TommyGun', description = '100000$', icon = 'gun'},
      {label = 'Automatas Aug', description = '500000$', icon = 'gun'},
      {label = 'Kulkos', description = 'Paspausk ir numes i kita puslapi kur gali kulkas pirkti', icon = 'box-open'},
  }
}, function(selected, scrollIndex, args)
    if selected == 1 then
      ConfirmPurchase("Pistoletas DP9", "30000", "weapon_dp9", 1)
    elseif selected == 2 then
      ConfirmPurchase("Pistoletas WM 29", "30000", "weapon_pistolxm3", 1)
    elseif selected == 3 then
      ConfirmPurchase("Pistoletas Browning", "30000", "weapon_browning", 1)
    elseif selected == 4 then
      ConfirmPurchase("Pistoletas Glock", "50000", "weapon_glock", 1)
    elseif selected == 5 then
      ConfirmPurchase("Automatas AK-47", "300000", "weapon_assaultrifle", 1)
    elseif selected == 6 then
      ConfirmPurchase("Automatas M4", "350000", "weapon_m4", 1)
    elseif selected == 7 then
      ConfirmPurchase(" AutomatukasUzi", "65000", "WEAPON_MICROSMG2", 1)
    elseif selected == 8 then
      ConfirmPurchase("Automatukas SMG", "42500", "weapon_smg", 1)
    elseif selected == 9 then
      ConfirmPurchase("Automatukas Kovinis SMG", "80000", "Combatpdw", 1)
    elseif selected == 10 then
      ConfirmPurchase("Automatukas TommyGun", "100000", "weapon_gusenberg", 1)
    elseif selected == 11 then
      ConfirmPurchase("Automatas Aug", "500000", "weapon_militaryrifle", 1)
    elseif selected == 12 then
      lib.showMenu('VIP_MENU_GUNSHOP2')
    end
end)

  lib.registerMenu({
    id = 'VIP_MENU_GUNSHOP2',
    title = 'VIP MENU',
    position = 'top-right',
    options = {
        {label = '9mm', icon = 'box-open'},
        {label = 'Rifle', icon = 'box-open'},
        {label = 'Rifle2', icon = 'box-open'},
    }
  }, function(selected, scrollIndex, args)
      if selected == 1 then
        local input = lib.inputDialog('Kiek nori?', {'Numeris'})
 
        if not input then return end
        ConfirmPurchase("9mm", tonumber(input[1]) * 10, "ammo-9", tonumber(input[1]))
      elseif selected == 2 then
        local input = lib.inputDialog('Kiek nori?', {''})
 
        if not input then return end
        ConfirmPurchase("Rifle", tonumber(input[1]) * 10, "ammo-rifle", tonumber(input[1]))
      elseif selected == 3 then
        local input = lib.inputDialog('Kiek nori?', {''})
 
        if not input then return end
        ConfirmPurchase("Rifle 2", tonumber(input[1]) * 10, "ammo-rifle2", tonumber(input[1]))
      end
  end)



function ConfirmPurchase(GunName, Price, GunModel, Count)
  local alert = lib.alertDialog({
    header = 'VIP Shop Purchase',
    content = 'Confirm Purchase of '..GunName..' For '..Price..'',
    centered = true,
    cancel = true
  })

  if alert == "confirm" then
    
lib.registerMenu({
  id = 'VIP_MENU_PAYMENT_METHOD',
  title = 'VIP MENU',
  position = 'top-right',
  options = {
      {label = 'Pay using Bank', icon = 'building-columns'},
      {label = 'Pay using Cash', icon = 'money-bill'},
  }
}, function(selected, scrollIndex, args)
    if selected == 1 then
      lib.callback('One-Code:Check', source, function(response)
        if not response then
          local alert = lib.alertDialog({
            header = 'VIP Shop Payment Failed',
            content = "You don't have enough money for it you want to try diffrent payment method?",
            centered = true,
            cancel = true
        })
            if alert == "confirm" then
              lib.showMenu('VIP_MENU_PAYMENT_METHOD')
            else
              return
            end
          else
            lib.callback('One-Code:Check2', source, function(response)
              if not response then
                lib.notify({
                  title = 'VIP',
                  description = 'You can\'t carry it',
                  type = 'ban'
                })
              end
            end, GunModel, Count)
          end
        end, "bank", Price)
    elseif selected == 2 then
      lib.callback('One-Code:Check', source, function(response)
        if not response then
          local alert = lib.alertDialog({
            header = 'VIP Shop Payment Failed',
            content = "You don't have enough money for it you want to try diffrent payment method?",
            centered = true,
            cancel = true
        })
            if alert == "confirm" then
              lib.showMenu('VIP_MENU_PAYMENT_METHOD')
            else
              return
            end
          else
            lib.callback('One-Code:Check2', source, function(response)
              if not response then
                lib.notify({
                  title = 'VIP',
                  description = 'You can\'t carry it',
                  type = 'ban'
                })
              end
            end, GunModel, Count)
          end
      end, "money", Price)
    end
end)
    lib.showMenu('VIP_MENU_PAYMENT_METHOD')
    else
      lib.notify({
        title = 'VIP',
        description = 'Purchase of '..GunName..' for '..Price..' was canceled',
        type = 'ban'
      })
    end
end

Citizen.CreateThread(function()
  Wait(5000)
  while true do
    lib.callback('One-Code:Check6', false, function(response)
      vipplayerssaved = response  
      print("Data recieved from server side!")
    end)
    Wait(300000)
  end
end)

Citizen.CreateThread(function()
  local sleep = 500
  while true do
    Citizen.Wait(sleep)
      local localPlayerId = PlayerId()
      local x1, y1, z1 = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

      for id = 0, 256 do
          if id ~= localPlayerId and NetworkIsPlayerActive(id) then
              local ped = GetPlayerPed(id)
              local x2, y2, z2 = table.unpack(GetEntityCoords(ped, true))
              local distance = math.floor(GetDistanceBetweenCoords(x1, y1, z1, x2, y2, z2, true))
              local takeaway = 0.95
              z2 = z2 + 1.1

              if distance < 10 and IsEntityVisible(ped) then
                sleep = 500
                  if NetworkIsPlayerTalking(id) then
                    sleep = 0
                      local serverId = GetPlayerServerId(id)
                      DrawMarker(0, x2, y2, z2 - 0.0, 0, 0, 10, 0, 0, 0, 0.1, 0.1, 0.1, 55, 160, 205, 105, 1, 1, 2, 0, 0, 0, 0)
                      if IsPlayerVIP(serverId) then
                          DrawText3D(x2, y2, z2 + 0.2, "VIP Narys("..serverId..")", 255, 215, 0, 255)
                      end
                  end
              end
          end
      end
  end
end)

function IsPlayerVIP(serverId)
  for _, id in ipairs(vipplayerssaved) do
      if id == serverId then
          return true
      end
  end
  return false
end

function DrawText3D(x, y, z, text, r, g, b, a)
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local px, py, pz = table.unpack(GetGameplayCamCoord())
  local scale = 0.4

  if onScreen then
      SetTextScale(scale, scale)
      SetTextFont(4)
      SetTextProportional(1)
      SetTextColour(r, g, b, a)
      SetTextOutline()
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x, _y)
  end
end

function cooldownVehicle()
  cooldownactive = true
  Wait(1200000)
  cooldownactive = false
end

function cooldownHeal()
  cooldownactive2 = true
  Wait(600000)
  cooldownactive2 = false
end

function cooldownRepair()
  cooldownactive3 = true
  Wait(600000)
  cooldownactive3 = false
end

function SpawnVehicle(modelHash, spawnLocationsfunc)
  if cooldownactive then
    lib.notify({
      title = 'VIP',
      description = "You can't spawn another vehicle yet.",
      type = 'ban'
    })
    return
  end

  local spawnAllowed = false

  for _, coords in ipairs(spawnLocationsfunc) do
    local vehicles = ESX.Game.GetVehicles()
    local isOccupied = false

    for _, vehicle in ipairs(vehicles) do
      local distance = GetDistanceBetweenCoords(coords.x, coords.y, coords.z, GetEntityCoords(vehicle))
      if distance < 5.0 then
        isOccupied = true
        break
      end
    end

    if not isOccupied then
      spawnAllowed = true
      local spawnCoords = coords
      local vehicle = ESX.Game.SpawnVehicle(modelHash, spawnCoords, 260.78)
      SetEntityAsMissionEntity(vehicle, true, true)
      cooldownVehicle()
      lib.notify({
        title = 'VIP',
        description = "Vehicle spawned!",
        type = 'ban'
      })
      break
    end
  end

  if not spawnAllowed then
    lib.notify({
      title = 'VIP',
      description = "Cannot spawn vehicle. All locations are occupied.",
      type = 'ban'
    })
  end
end




function RepairVehicleInDriverSeat()
  if cooldownactive3 then
    lib.notify({
      title = 'VIP',
      description = "You can't repair the vehicle yet.",
      type = 'ban'
    })
    return
  end
  if not IsPlayerInVipRadius(source) then return lib.notify({
    title = 'VIP',
    description = 'You must be in the server zone!',
    type = 'ban'
  }) end
  local playerPed = GetPlayerPed(-1)
  if IsPedInAnyVehicle(playerPed, false) then
    if lib.progressCircle({
      duration = 10000,
      position = 'bottom',
      useWhileDead = false,
      canCancel = true,
    }) then
      local vehicle = GetVehiclePedIsIn(playerPed, false)
      if GetPedInVehicleSeat(vehicle, -1) == playerPed then
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
        SetVehicleEngineOn(vehicle, true, true)
        SetVehicleDirtLevel(vehicle, 0)
        if IsThisModelABike(GetEntityModel(vehicle)) or IsThisModelAQuadbike(GetEntityModel(vehicle)) then
          SetVehicleOilLevel(vehicle, 100.0)
        end
        cooldownRepair()
      lib.notify({
        title = 'VIP',
        description = 'Vehicle repaired!',
        type = 'ban'
      })
    else
      lib.notify({
            title = 'VIP',
            description = 'You must be in the driver\'s seat to repair the vehicle.',
            type = 'ban'
          })
        end
      else
         lib.notify({
        title = 'VIP',
        description = 'Action was canceled',
        type = 'ban'
    }) end
      else
        lib.notify({
          title = 'VIP',
          description = 'You must be inside a vehicle to repair it.',
          type = 'ban'
        })
  end
end
