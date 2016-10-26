
local myname, ns = ...


function ns.IsDiscovered(recipe_id)
	if not ns.GetRecipeName(recipe_id) then return false end
	if ns.GetRecipeLearned(recipe_id) then return true end
end


function ns.CanBeDiscovered(recipe_id)
	if not ns.GetRecipeName(recipe_id) then return end
	if ns.IsDiscovered(recipe_id) then return false end

	local previous_id = ns.GetRecipePreviousRecipeID(recipe_id)
	if previous_id then
		if not ns.GetRecipeLearned(previous_id) then return false end
	end

	local requisite_id = ns.requisites[recipe_id]
	if not requisite_id then return true end
	if not ns.GetRecipeName(requisite_id) then return false end
	if not ns.GetRecipeLearned(requisite_id) then return false end

	return true
end
