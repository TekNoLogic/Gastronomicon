
local myname, ns = ...


local f = CreateFrame("frame")
f:SetScript("OnEvent", function(self, event, ...)
	ns.RemoveTooltips()
end)
f:RegisterEvent("GOSSIP_CLOSED")
