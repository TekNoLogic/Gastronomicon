
local myname, ns = ...


local KEYS = {
	learned = true,
}


local data = {}
for key in pairs(KEYS) do data[key] = {} end


function ns.SaveRecipe(info)
	local id = info.recipeID
	for key in pairs(KEYS) do data[key][id] = info[key] end
end


for key in pairs(KEYS) do
	local titleized = string.upper(string.sub(key, 1,1)).. string.sub(key, 2)
	ns["GetRecipe"..titleized] = function(recipe_id)
		return data[key][recipe_id]
	end
end
