
local myname, ns = ...


local legion_categories = {
	[475] = true, -- The root category "Food of the Broken Isles"
}


local function Index(t, i)
	local data = C_TradeSkillUI.GetCategoryInfo(i)
	if not data then return end

	local v

	local parent = data.parentCategoryID
	if parent then
		v = not not legion_categories[parent] -- force this to be a boolean
	else
		v = false
	end
	
	t[i] = v
	return v
end


setmetatable(legion_categories, {__index = Index})


function ns.IsLegionCategory(id)
	return legion_categories[id]
end
