
local myname, ns = ...


local   AVAILABLE = ITEM_QUALITY_COLORS[1].hex
local UNAVAILABLE = ITEM_QUALITY_COLORS[0].hex
local LINE = "|T%d:16|t %s%s (Rank %d)"


local function GetLine(recipe_id)
	if not ns.GetRecipeName(recipe_id) then return end
	if ns.GetRecipeLearned(recipe_id) then return end

	local previous_id = ns.GetRecipePreviousRecipeID(recipe_id)
	if previous_id then
		if not ns.GetRecipeLearned(previous_id) then return end
	end

	local color = ns.CanBeDiscovered(recipe_id) and AVAILABLE or UNAVAILABLE
	local rank = ns.GetRecipeRank(recipe_id)
	local icon = ns.GetRecipeIcon(recipe_id)
	local name = ns.GetRecipeName(recipe_id)
	return LINE:format(icon, color, name, rank)
end


function ns.ShowTooltip(frame, item_id)
	local recipes = ns.recipes[item_id]
	if not recipes then return end

	GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
	GameTooltip:AddLine("Discoverable recipes")

	for _,recipe_id in pairs(recipes) do
		local recipe = GetLine(recipe_id)
		if recipe then GameTooltip:AddLine(recipe) end
	end

	GameTooltip:Show()
end
