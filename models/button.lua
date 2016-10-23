
local myname, ns = ...


local RED = " |c".. DIM_RED_FONT_COLOR:GenerateHexColor()
local SOME_AVAILABLE = " %d [%s] x%d"
local NONE_AVAILABLE = RED.. "0 [%s] x%d|r"
local ALL_DISCOVERED = RED.. "All discovered [%s]"
local WORK_ORDER_TEXTURE = "Interface\\GossipFrame\\workorderGossipIcon"


local function HasUndiscovered(item_id)
	local recipes = ns.recipes[item_id]
	if not recipes then return false end

	for _,recipe_id in pairs(recipes) do
		if not ns.IsDiscovered(recipe_id) then return true end
	end
end


local function NumDiscoverable(item_id)
	local recipes = ns.recipes[item_id]
	if not recipes then return 0 end

	local discoverable = 0
	for _,recipe_id in pairs(recipes) do
		if ns.CanBeDiscovered(recipe_id) then
			discoverable = discoverable + 1
		end
	end

	return discoverable
end


local function GetButton(index)
	local name = "GossipTitleButton".. index
	return _G[name], _G[name.. "GossipIcon"]
end


local function GetText(item_id)
	local recipes = ns.recipes[item_id]
	if not recipes then return end

	local discoverable = NumDiscoverable(item_id)
	local name = GetItemInfo(item_id)
	local count = GetItemCount(item_id, true) or 0

	if discoverable > 0 then
		return string.format(SOME_AVAILABLE, discoverable, name, count)
	elseif HasUndiscovered(item_id) then
		return string.format(NONE_AVAILABLE, name, count)
	else
		return string.format(ALL_DISCOVERED, name)
	end
end


local button_item_ids = {}
local function OnEnter(self)
	ns.ShowTooltip(self, button_item_ids[self])
end


function ns.UpdateButton(index, item_id)
	local button, icon = GetButton(index)
	local _, _, _, _, texture = GetItemInfoInstant(item_id)

	button:SetText(GetText(item_id))
	icon:SetTexture(texture)
	GossipResize(button)

	button_item_ids[button] = item_id
	button:SetScript("OnEnter", OnEnter)
	button:SetScript("OnLeave", GameTooltip_Hide)
end


function ns.GOSSIP_CLOSED()
	for button in pairs(button_item_ids) do
		button:SetScript("OnEnter", nil)
		button:SetScript("OnLeave", nil)
		button_item_ids[button] = nil
	end
end


ns.RegisterEvent("GOSSIP_CLOSED")
