
local myname, ns = ...


local function OnGossipShow()
  if not ns.IsNomi() then return end
  ns.SendMessage("_NOMI_OPENED")
end


ns.RegisterEvent("GOSSIP_SHOW", OnGossipShow)
