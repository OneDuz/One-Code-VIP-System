local VIPPlayers = {}

lib.callback.register('One-Code:Check', function(source, Type, Amount)
    local xPlayer = ESX.GetPlayerFromId(source)
    if tonumber(Amount) <= tonumber(xPlayer.getAccount(Type).money) then
        xPlayer.setAccountMoney(Type, xPlayer.getAccount(Type).money - Amount)
        return true
    else
        return false
    end
end)

lib.callback.register('One-Code:Check2', function(source, Model)
    if exports.ox_inventory:CanCarryItem(source, Model, 1) then
        exports.ox_inventory:AddItem(source, Model, 1)
        return true
    else
        return false
    end
end)

lib.callback.register('One-Code:Check3', function(source, target, data1)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xTarget = ESX.GetPlayerFromId(target)
    if not xPlayer.getGroup() == "admin" or not xPlayer.getGroup() == "superadmin" then return false end

    local currentDate = os.date('*t')
    local expires = os.time({
        year = currentDate.year,
        month = currentDate.month + data1,
        day = currentDate.day,
        hour = currentDate.hour,
        min = currentDate.min,
        sec = currentDate.sec
    })

    local daysLeft = math.floor((expires - os.time()) / (24 * 3600))

    TriggerClientEvent('ox_lib:notify', target, {
        title = 'VIP',
        description = 'You got VIP for '..daysLeft..' day\'s',
        type = 'success'
    })
    table.insert(VIPPlayers, target)
    MySQL.Async.execute('INSERT INTO `onecodesvip` (license, Granted, Expires, LeftDays) VALUES (?, ?, ?, ?)', {
        xPlayer.getIdentifier(),
        os.time(),
        expires,
        daysLeft
    }, function(rowsChanged)
        if rowsChanged > 0 then
            print('Data inserted successfully')
            return 'Data inserted successfully'
        else
            print('Failed to insert data')
            return 'Failed to insert data'
        end
    end)
end)

lib.callback.register('One-Code:Check4', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local granted, expires, leftDays

    MySQL.query('SELECT license, Granted, Expires, LeftDays FROM onecodesvip WHERE license = ?', {xPlayer.getIdentifier()},
    function(result)
        if result[1] then
            license = result[1].license
            granted = result[1].Granted
            expires = result[1].Expires
            leftDays = result[1].LeftDays
            print('License:', license)
            print('Granted:', granted)
            print('Expires:', expires)
            print('LeftDays:', leftDays)
        else
            print('No record found for identifier:', xPlayer.identifier)
            granted, expires, leftDays = false, false, false
        end
    end)
    Citizen.Wait(500)
    if not granted or not expires or not leftDays then
        return "DOESNT HAVE IT"
    else
        return os.date("Month %m Day %d Year %Y", granted), os.date("Month %m Day %d Year %Y", expires), leftDays
    end
end)

lib.callback.register('One-Code:Check5', function(source)
    table.insert(VIPPlayers, source)
    return "Player Saved As VIP"
end)

AddEventHandler('playerDropped', function(reason)
    table.remove(VIPPlayers, source)
end)


AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
while true do
    MySQL.query('SELECT license, Granted, Expires, LeftDays FROM onecodesvip', {},
    function(results)
        for _, result in ipairs(results) do
            local license = result.license
            local granted = result.Granted
            local expires = result.Expires
            local leftDays = result.LeftDays
            local currentDate = os.time()
            local expirationDate = os.time({year = os.date('%Y', expires), month = os.date('%m', expires), day = os.date('%d', expires)})
            local daysLeft = math.floor((expirationDate - currentDate) / (24 * 3600))
            MySQL.Async.execute('UPDATE onecodesvip SET LeftDays = ? WHERE license = ?', {daysLeft, license}, function(rowsChanged)
                if rowsChanged > 0 then
                    print('LeftDays updated successfully for license:', license)
                    if daysLeft <= 0 then
                        MySQL.Async.execute('DELETE FROM onecodesvip WHERE license = ?', {license}, function(rowsDeleted)
                            if rowsDeleted > 0 then
                                print('Data deleted successfully for license:', license)
                            else
                                print('Failed to delete data for license:', license)
                            end
                        end)
                    end
                else
                    print('Failed to update LeftDays for license:', license)
                end
            end)
        end
    end)
        Wait(60 * 60 * 1000)
    end
end)
