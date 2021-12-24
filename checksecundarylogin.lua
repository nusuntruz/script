local username_true = {}
local username = globals.get_username()
username_true['thunderzeraa'] = true
username_true['Ruz'] = true
username_true['GammaYTB'] = true
username_true['Cabrons'] = true
username_true['S2W'] = true
username_true['ph1losophy'] = true
username_true['QuentY_'] = true

freeday = false
local function sendtrue()
    if username_true[username] == true or freeday == true then
      return true
    else
      return false
    end
end

return sendtrue()
