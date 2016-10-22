
local myname, ns = ...


local WORK_ORDER_TEXTURE = "Interface\\GossipFrame\\workorderGossipIcon"


local function GetButton(index)
	local name = "GossipTitleButton".. index
	return _G[name], _G[name.. "GossipIcon"]
end


local button_item_ids = {}
local function OnEnter(self)
	ns.ShowTooltip(self, button_item_ids[self])
end


function ns.UpdateButton(index, item_id)
	local button, icon = GetButton(index)
	local _, _, _, _, texture = GetItemInfoInstant(item_id)

	button:SetText(ns.GetButtonText(item_id))
	icon:SetTexture(texture)
	GossipResize(button)

	button_item_ids[button] = item_id
	button:SetScript("OnEnter", OnEnter)
	button:SetScript("OnLeave", GameTooltip_Hide)
end


function ns.RemoveTooltips()
	for button in pairs(button_item_ids) do
		button:SetScript("OnEnter", nil)
		button:SetScript("OnLeave", nil)
		button_item_ids[button] = nil
	end
end
