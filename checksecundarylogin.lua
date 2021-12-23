local username_true = {}
local username = globals.get_username()
username_true['thunderzeraa'] = true
username_true['Ruz'] = true
username_true['GammaYTB'] = true
username_true['Cabrons'] = true

local function sendtrue()
    if username_true[username] == true then
      return true
    else
      return false
    end
end

return sendtrue()
