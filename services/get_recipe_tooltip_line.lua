
local myname, ns = ...


local   AVAILABLE = "|T%d:16|t %s (Rank %d)"
local UNAVAILABLE = "|T%d:16|t |cffcccccc%s (Rank %d)"


function ns.GetRecipeTooltipLine(recipe_id)
	if not ns.GetRecipeName(recipe_id) then return end
	if ns.GetRecipeLearned(recipe_id) then return end

	local previous_id = ns.GetRecipePreviousRecipeID(recipe_id)
	if previous_id then
		if not ns.GetRecipeLearned(previous_id) then return end
	end

	local str = ns.CanBeDiscovered(recipe_id) and AVAILABLE or UNAVAILABLE
	local rank = ns.GetRecipeRank(recipe_id)
	local icon = ns.GetRecipeIcon(recipe_id)
	local name = ns.GetRecipeName(recipe_id)
	return str:format(icon, name, rank)
end
