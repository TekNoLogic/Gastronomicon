
local myname, ns = ...


local KEYS = {
	icon = true,
	learned = true,
	name = true,
	nextRecipeID = true,
	previousRecipeID = true,
}


GastronomiconDBPC = {}
for key in pairs(KEYS) do GastronomiconDBPC[key] = {} end


function ns.SaveRecipe(info)
	local id = info.recipeID
	for key in pairs(KEYS) do GastronomiconDBPC[key][id] = info[key] end
end


for key in pairs(KEYS) do
	local titleized = string.upper(string.sub(key, 1,1)).. string.sub(key, 2)
	ns["GetRecipe"..titleized] = function(recipe_id)
		return GastronomiconDBPC[key][recipe_id]
	end
end


function ns.GetRecipeRank(id)
	if not GastronomiconDBPC.nextRecipeID[id] then return 3 end
	if GastronomiconDBPC.previousRecipeID[id] then return 2 end
	return 1
end
