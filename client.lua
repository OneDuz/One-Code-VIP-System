Config = {
  DrawMarker = 10,
	VIPservers = {
    {
      Position = vector3(-1882.62, 2062.65, 160),
      vipRadius = 50.0,
			Blip = {
				Enabled = true,
				Color = 9,
				Label = 'VIP SERVER#1',
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


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded',function()
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
        description = 'Failed',
        type = 'ban'
      })
    else
      lib.notify({
        title = 'VIP',
        description = 'Worked',
        type = 'ban'
      })
    end
  end, tonumber(args[1]), tonumber(args[2]))
end)

RegisterCommand("VIP", function()
  if IsPlayerInVipRadius(source) then
    lib.callback('One-Code:Check4', source, function(granted, expires, leftDays)
      if granted == "DOESNT HAVE IT" then
          lib.showContext('VIP_MENU2')
      else
        lib.showContext('VIP_MENU')
        end
      end)
        TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "You are within the VIP radius.")
      else
        TriggerEvent("chatMessage", "SYSTEM", {255, 0, 0}, "You are not within the VIP radius.")
        lib.showContext('VIP_MENU3')
        lib.notify({
            title = 'VIP',
            description = 'You are too far away from the servers for full access.',
            type = 'ban'
        })
    end
end)

lib.registerContext({
  id = 'VIP_MENU2',
  title = 'VIP Menu',
  options = {
    {
      title = 'Heal',
      description = 'Will heal you fully and make you feel great!',
      icon = 'bandage',
      disabled = true,
      onSelect = function()
        print("Pressed the button!")
      end,
    },
    {
      title = 'Vehicle Repair',
      description = 'Will fix your vehicle fully body, engine everything!',
      icon = 'screwdriver-wrench',
      disabled = true,
      onSelect = function()
        print("Pressed the button!")
      end,
    },
    {
      title = 'Gun Shop',
      description = 'VIP Weapon shop',
      icon = 'shop',
      disabled = true,
      onSelect = function()
        lib.showContext('VIP_MENU_GUNSHOP')
      end,
    },
    {
      title = 'Spawner',
      description = 'Free vehicle/helicopter spawner',
      icon = 'warehouse',
      disabled = true,
      onSelect = function()
        print("Pressed the button!")
      end,
    },
    {
      title = 'Expires',
      description = 'Check when your VIP status expires',
      icon = 'clock',
      onSelect = function()
        showexpiredate()
      end,
    },
  }
})

lib.registerContext({
  id = 'VIP_MENU3',
  title = 'VIP Menu',
  options = {
    {
      title = 'Warning!',
      description = 'You are too far away from the servers for full access.',
    },
    {
      title = 'Heal',
      description = 'Will heal you fully and make you feel great!',
      icon = 'bandage',
      disabled = true,
      onSelect = function()
        print("Pressed the button!")
      end,
    },
    {
      title = 'Vehicle Repair',
      description = 'Will fix your vehicle fully body, engine everything!',
      icon = 'screwdriver-wrench',
      disabled = true,
      onSelect = function()
        print("Pressed the button!")
      end,
    },
    {
      title = 'Gun Shop',
      description = 'VIP Weapon shop',
      icon = 'shop',
      disabled = true,
      onSelect = function()
        lib.showContext('VIP_MENU_GUNSHOP')
      end,
    },
    {
      title = 'Spawner',
      description = 'Free vehicle/helicopter spawner',
      icon = 'warehouse',
      disabled = true,
      onSelect = function()
        print("Pressed the button!")
      end,
    },
    {
      title = 'Expires',
      description = 'Check when your VIP status expires',
      icon = 'clock',
      onSelect = function()
        showexpiredate()
      end,
    },
  }
})

lib.registerContext({
    id = 'VIP_MENU',
    title = 'VIP Menu',
    options = {
      {
        title = 'Heal',
        description = 'Will heal you fully and make you feel great!',
        icon = 'bandage',
        onSelect = function()
          print("Pressed the button!")
        end,
      },
      {
        title = 'Vehicle Repair',
        description = 'Will fix your vehicle fully body, engine everything!',
        icon = 'screwdriver-wrench',
        onSelect = function()
          print("Pressed the button!")
        end,
      },
      {
        title = 'Gun Shop',
        description = 'VIP Weapon shop',
        icon = 'shop',
        onSelect = function()
          lib.showContext('VIP_MENU_GUNSHOP')
        end,
      },
      {
        title = 'Spawner',
        description = 'Free vehicle/helicopter spawner',
        icon = 'warehouse',
        onSelect = function()
          print("Pressed the button!")
        end,
      },
      {
        title = 'Expires',
        description = 'Check when your VIP status expires',
        icon = 'clock',
        onSelect = function()
          showexpiredate()
        end,
      },
    }
  })

function showexpiredate()
  lib.callback('One-Code:Check4', source, function(granted, expires, leftDays)
    if granted == "DOESNT HAVE IT" then
      expires = 0
      leftDays = 0
    end
    lib.registerContext({
      id = 'VIP_MENU_TIMER',
      title = 'VIP Menu',
      options = {
        {
          title = 'Granted at ' .. granted,
          icon = 'clock',
         },
        {
          title = 'Expires at ' .. expires,
           icon = 'clock',
         },
         {
           title = 'Expires in '..leftDays..' Days',
           icon = 'clock',
         }
       }
     })
     lib.registerContext({
       id = 'VIP_MENU_TIMER2',
       title = 'VIP Menu',
        options = {
         {
          title = 'You don\'t have VIP',
          icon = 'clock',
        },
      }
    })
       if granted == "DOESNT HAVE IT" then
        lib.showContext('VIP_MENU_TIMER2')
       else
        lib.showContext('VIP_MENU_TIMER')
      end
  end)
end

-- GUN SHOP WHERE BUY WEAPONS
  lib.registerContext({
    id = 'VIP_MENU_GUNSHOP',
    title = 'VIP Menu',
    options = {
      {
        title = 'Pistoletas DP9',
        -- description = 'Assault Rifle',
        image = 'https://cdn.discordapp.com/attachments/1143997699914465452/1155224587097866422/WEAPON_DP9.png',
        icon = 'gun',
        onSelect = function()
          ConfirmPurchase("Pistoletas DP9", "15000", "weapon_dp9")
        end,
        metadata = {
          {label = 'Price', value = '15,000'},
        },
      },
      {
        title = 'Pistoletas WM 29',
        -- description = 'Assault Rifle',
        image = 'https://cdn.discordapp.com/attachments/1143997699914465452/1155225591046492231/weapon_pistol.png',
        icon = 'gun',
        onSelect = function()
          ConfirmPurchase("Pistoletas WM 29", "15000", "weapon_assaultrifle")
        end,
        metadata = {
          {label = 'Price', value = '15,000'},
        },
      },
      {
        title = 'Pistoletas Browning',
        -- description = 'Assault Rifle',
        image = 'https://cdn.discordapp.com/attachments/1143997699914465452/1155226076436512888/weapon_browning.png',
        icon = 'gun',
        onSelect = function()
          ConfirmPurchase("Pistoletas Browning", "15000", "weapon_assaultrifle")
        end,
        metadata = {
          {label = 'Price', value = '15,000'},
        },
      },
      {
        title = 'Pistoletas Glock',
        -- description = 'Assault Rifle',
        image = 'https://cdn.discordapp.com/attachments/1143997699914465452/1155226166358200430/weapon_glock.png',
        icon = 'gun',
        onSelect = function()
          ConfirmPurchase("Pistoletas Glock", "20000", "weapon_assaultrifle")
        end,
        metadata = {
          {label = 'Price', value = '20,000'},
        },
      },
      {
        title = 'AK-47',
        -- description = 'Assault Rifle',
        image = 'https://cdn.discordapp.com/attachments/1143997699914465452/1155223097914445884/weapon_assaultrifle.png',
        icon = 'gun',
        onSelect = function()
          ConfirmPurchase("AK-47", "150000", "weapon_assaultrifle")
        end,
        metadata = {
          {label = 'Price', value = '150,000'},
        },
      },
      {
        title = 'M4',
        -- description = 'Assault Rifle',
        image = 'https://cdn.discordapp.com/attachments/1143997699914465452/1155226282011922524/weapon_carbinerifle.png',
        icon = 'gun',
        onSelect = function()
          ConfirmPurchase("M4", "200000", "weapon_assaultrifle")
        end,
        metadata = {
          {label = 'Price', value = '200,000'},
        },
      },
      {
        title = 'Uzi',
        -- description = 'Assault Rifle',
        image = 'https://cdn.discordapp.com/attachments/1143997699914465452/1155226584786153533/weapon_microsmg.png',
        icon = 'gun',
        onSelect = function()
          ConfirmPurchase("Uzi", "65000", "weapon_assaultrifle")
        end,
        metadata = {
          {label = 'Price', value = '65,000'},
        },
      },
      {
        title = 'SMG',
        -- description = 'Assault Rifle',
        image = 'https://cdn.discordapp.com/attachments/1143997699914465452/1155226724133507222/weapon_smg.png',
        icon = 'gun',
        onSelect = function()
          ConfirmPurchase("SMG", "42500", "weapon_assaultrifle")
        end,
        metadata = {
          {label = 'Price', value = '42,500'},
        },
      },
      -- {
      --   title = 'Gun name',
      --   -- description = 'Assault Rifle',
      --   -- image = 'https://cdn.discordapp.com/attachments/1143997699914465452/1155012367604789288/image.png',
      --   icon = 'circle',
      --   onSelect = function()
      --     ConfirmPurchase("Gun name", "Price", "Weapon Spawn weapon_assaultrifle")
      --   end,
      --   metadata = {
      --     {label = 'Price', value = '0'},
      --   },
      -- },
    }
  })


function ConfirmPurchase(GunName, Price, GunModel)
  lib.registerContext({
    id = 'VIP_MENU_CONFIRM',
    title = 'VIP Menu',
    options = {
      {
        title = 'Confirm Purchase of '..GunName..' For '..Price..'',
        -- description = ''..GunName..' For '..Price..'',
        -- image = 'https://cdn.discordapp.com/attachments/1143997699914465452/1155012367604789288/image.png',
        icon = 'circle',
        onSelect = function()
          
        end,
      },
      {
        title = 'Cancel Purchase',
        -- description = 'Assault Rifle',
        -- image = 'https://cdn.discordapp.com/attachments/1143997699914465452/1155012367604789288/image.png',
        icon = 'circle',
        onSelect = function()
          
        end,
      }
    }
  })
  --lib.showContext('VIP_MENU_CONFIRM')


  local alert = lib.alertDialog({
    header = 'VIP Shop Purchase',
    content = 'Confirm Purchase of '..GunName..' For '..Price..'',
    centered = true,
    cancel = true
})
  if alert == "confirm" then
    lib.registerContext({
      id = 'VIP_MENU_PAYMENT_METHOD',
      title = 'VIP Shop Payment Method',
      options = {
        {
          title = 'Pay with Bank',
          icon = 'circle',
          onSelect = function()
            lib.callback('One-Code:Check', source, function(response)
            if not response then
              local alert = lib.alertDialog({
                header = 'VIP Shop Payment Failed',
                content = "You don't have enough money for it you want to try diffrent payment method?",
                centered = true,
                cancel = true
            })
                if alert == "confirm" then
                  lib.showContext('VIP_MENU_PAYMENT_METHOD')
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
                end, GunModel)
              end
            end, "bank", Price)
          end,
        },
        {
          title = 'Pay with Cash',
          icon = 'circle',
          onSelect = function()
            lib.callback('One-Code:Check', source, function(response)
              if not response then
                local alert = lib.alertDialog({
                  header = 'VIP Shop Payment Failed',
                  content = "You don't have enough money for it you want to try diffrent payment method?",
                  centered = true,
                  cancel = true
              })
                  if alert == "confirm" then
                    lib.showContext('VIP_MENU_PAYMENT_METHOD')
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
                  end, GunModel)
                end
            end, "money", Price)
          end,
        }
      }
    })
    lib.showContext('VIP_MENU_PAYMENT_METHOD')
    else
      lib.notify({
        title = 'VIP',
        description = 'Purchase of '..GunName..' for '..Price..' was canceled',
        type = 'ban'
      })
    end
end