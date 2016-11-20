
local myname, ns = ...


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

	local name = GetItemInfo(item_id)
	if HasUndiscovered(item_id) then
		local count = GetItemCount(item_id, true) or 0
		local in_bag = (GetItemCount(item_id) or 0) > 0 and "→" or ""
		return string.format(" %s%s (x%d)", in_bag, name, count)
	else
		return " ".. name
	end
end


local function GetSubtext(item_id)
	local recipes = ns.recipes[item_id]
	if not recipes then return end

	local discoverable = NumDiscoverable(item_id)
	if discoverable > 0 then
		return discoverable.. " discoverable"
	end
end


local button_item_ids = {}
local function OnEnter(self)
	ns.ShowTooltip(self, button_item_ids[self])
end


local function OnGossipClosed(self)
	self:SetScript("OnEnter", nil)
	self:SetScript("OnLeave", nil)
	button_item_ids[self] = nil
end


function ns.UpdateButton(index, item_id)
	local button, icon = GetButton(index)
	local _, _, _, _, texture = GetItemInfoInstant(item_id)

	button:SetText(GetText(item_id))
	ns.SetSubtext(button, GetSubtext(item_id))
	icon:SetTexture(texture)

	button_item_ids[button] = item_id
	button:SetScript("OnEnter", OnEnter)
	button:SetScript("OnLeave", GameTooltip_Hide)

	ns.RegisterCallback(button, "GOSSIP_CLOSED", OnGossipClosed)
end
