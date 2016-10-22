
local myname, ns = ...


function ns.IsDiscovered(recipe_id)
	if not ns.GetRecipeName(recipe_id) then return false end
	if ns.GetRecipeLearned(recipe_id) then return true end
end


function ns.CanBeDiscovered(recipe_id)
	if not ns.GetRecipeName(recipe_id) then return end
	if ns.IsDiscovered(recipe_id) then return false end

	if not ns.requisites[recipe_id] then return true end

	for _,requisite_id in pairs(ns.requisites[recipe_id]) do
		if not ns.GetRecipeName(requisite_id) then return false end
		if not ns.GetRecipeLearned(requisite_id) then return false end
	end

	return true
end
