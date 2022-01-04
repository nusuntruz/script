local username_true = {}
local username = globals.get_username()
username_true['thunderzeraa'] = true
username_true['Ruzule'] = true
username_true['GammaYTB'] = true
username_true['Cabrons'] = true
username_true['S2W'] = true
username_true['ph1losophy'] = true
username_true['QuentY_'] = true
username_true['spidey4'] = true
username_true['snekROmonoro'] = true
username_true['Andy22'] = true
username_true['Ignacy'] = true
username_true['Valeriu'] = true
username_true['DeadEye'] = true
username_true['Comezo'] = true
username_true['PolskiPycek69'] = true
username_true['Tokssan'] = true
username_true['Cyguss'] = true


local function sendtrue()
    if username_true[username] == true then
      return true
    else
      return false
    end
end

return sendtrue()
