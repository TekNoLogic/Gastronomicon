
local myname, ns = ...


local   AVAILABLE = "|T%d:16|t %s (Rank %d)"
local UNAVAILABLE = "|T%d:16|t |cffcccccc%s (Rank %d)"


local function AvailableToDiscover(recipe_id)
	if not ns.requisites[recipe_id] then return true end

	for _,requisite_id in pairs(ns.requisites[recipe_id]) do
		if not ns.GetRecipeName(requisite_id) then return false end
		if not ns.GetRecipeLearned(requisite_id) then return false end
	end

	return true
end


function ns.GetRecipeTooltipLine(recipe_id)
	if not ns.GetRecipeName(recipe_id) then return end
	if ns.GetRecipeLearned(recipe_id) then return end

	local str = AvailableToDiscover(recipe_id) and AVAILABLE or UNAVAILABLE
	local rank = ns.GetRecipeRank(recipe_id)
	local icon = ns.GetRecipeIcon(recipe_id)
	local name = ns.GetRecipeName(recipe_id)
	return str:format(icon, name, rank)
end
