
local myname, ns = ...


function ns.ShowTooltip(frame, item_id)
	local recipes = ns.recipes[item_id]
	if not recipes then return end

	GameTooltip:SetOwner(frame, "ANCHOR_RIGHT")
	GameTooltip:AddLine("Discoverable recipes")

	for _,recipe_id in pairs(recipes) do
		local recipe = ns.GetRecipeTooltipLine(recipe_id)
		if recipe then GameTooltip:AddLine(recipe) end
	end

	GameTooltip:Show()
end
