
local myname, ns = ...


local SOME_AVAILABLE = "%d [%s] x%d"
local NONE_AVAILABLE = "|cff6600000 [%s] x%d|r"
local ALL_DISCOVERED = "|cff660000All discovered [%s]"


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


local function HasUndiscovered(item_id)
	local recipes = ns.recipes[item_id]
	if not recipes then return false end

	for _,recipe_id in pairs(recipes) do
		if not ns.IsDiscovered(recipe_id) then return true end
	end
end


function ns.GetButtonText(item_id)
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
