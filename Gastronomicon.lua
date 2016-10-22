
local myname, ns = ...


local HookedButtons = {} -- [button] = true
local LocalizedIngredientList = {} -- [itemID] = {itemName, itemLink}
local button_item_ids = {}

local f = CreateFrame('frame')


local IsNomi = false -- Are we currently interacting with Nomi?
local function DecorateNomi()
	local i = 0
	for _,item_id in ipairs(ns.ingredient_order) do
		local count = GetItemCount(item_id, true) or 0
		local _, _, _, _, ingredientIcon = GetItemInfoInstant(item_id)
		if count >= 5 then -- we have enough of an ingredient for nomi to display it
			i = i + 1
			local buttonName = 'GossipTitleButton' .. i
			local button = _G[buttonName]
			local buttonIcon = _G[buttonName .. 'GossipIcon'] -- check that the icon is for a work order, otherwise we might overwrite a quest button or something
			if button and button:IsShown() and buttonIcon and buttonIcon:GetTexture():lower() == 'interface\\gossipframe\\workordergossipicon' then
				if not HookedButtons[button] then
					button:HookScript("OnEnter", function(self)
						if not IsNomi then return end
						ns.ShowTooltip(self, button_item_ids[self])
					end)
					button:HookScript("OnLeave", GameTooltip_Hide)
					HookedButtons[button] = i
				end

				button_item_ids[button] = item_id

				local ingredient, recipeList = LocalizedIngredientList[item_id], ns.recipes[item_id]
				if ingredient and recipeList then -- and recipes then
					local unlearned = 0
					local canLearn = 0
					local ingredientName, ingredientLink = ingredient[1], ingredient[2]
					for _, recipeID in pairs(recipeList) do
						if ns.GetRecipeName(recipeID) and not ns.GetRecipeLearned(recipeID) then
							unlearned = unlearned + 1
							local learnable = true
							if ns.requisites[recipeID] then
								for _, requisiteID in pairs(ns.requisites[recipeID]) do
									-- we must know all requisites to be able to receive this item
									if ns.GetRecipeName(requisiteID) and not ns.GetRecipeLearned(requisiteID) then
										-- we're missing one of the requisites, can't make this
										learnable = false
										break
									end
								end
							end
							if learnable then
								canLearn = canLearn + 1
							end
						end
					end
					buttonIcon:SetTexture(ingredientIcon)
					if unlearned ~= 0 then
						if canLearn ~= 0 then
							button:SetFormattedText('%d [%s] x%d', canLearn, ingredientName, count)
						else
							-- button:SetText('|cff660000' .. canLearn .. ' [' .. ingredientName .. ']')
							button:SetFormattedText('|cff660000%d [%s] x%d|r', canLearn, ingredientName, count)
						end
					else
						button:SetFormattedText('|cff660000No more [%s]', ingredientName)
					end
					GossipResize(button)
				end
			else
				break
			end
		end
	end
end

f:SetScript('OnEvent', function(self, event, ...)
	if event == 'GOSSIP_SHOW' then
		local guid = UnitGUID('npc')
		if guid then
			local _, _, _, _, _, npcID = strsplit('-', guid)
			if npcID == '101846' then -- Nomi
				IsNomi = true
				DecorateNomi()
			end
		end
	elseif event == 'GOSSIP_CLOSED' then
		IsNomi = false
	elseif event == 'GET_ITEM_INFO_RECEIVED' then
		local itemID = ...
		if ns.recipes[itemID] then
			local itemName, itemLink = GetItemInfo(itemID)
			LocalizedIngredientList[itemID] = {itemName, itemLink}
		end
	elseif event == 'PLAYER_LOGIN' then
		for itemID, recipes in pairs(ns.recipes) do
			local itemName, itemLink = GetItemInfo(itemID)
			if itemName and itemLink then
				LocalizedIngredientList[itemID] = {itemName, itemLink}
			end
		end
	end
end)
f:RegisterEvent('GOSSIP_SHOW')
f:RegisterEvent('GOSSIP_CLOSED')
f:RegisterEvent('GET_ITEM_INFO_RECEIVED')
f:RegisterEvent('PLAYER_LOGIN')
