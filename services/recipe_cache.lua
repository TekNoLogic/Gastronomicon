
local myname, ns = ...


local COOKING_ID = 185


local function CacheData()
	if C_TradeSkillUI.GetTradeSkillLine() ~= COOKING_ID then return end

	local ids = C_TradeSkillUI.GetAllRecipeIDs()
	for _,id in pairs(ids) do
		local data = C_TradeSkillUI.GetRecipeInfo(id)
		if data and ns.IsLegionCategory(data.categoryID) then
			ns.SaveRecipe(data)
		end
	end
end


local listener = CreateFrame("Frame")
listener:SetScript("OnEvent", CacheData)
listener:RegisterEvent("TRADE_SKILL_LIST_UPDATE")
