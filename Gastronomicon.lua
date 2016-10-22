
local myname, ns = ...


local HookedButtons = {} -- [button] = true
local LocalizedIngredientList = {} -- [itemID] = {itemName, itemLink}
local TooltipInfo = {} -- [button] = {[i] = 'recipe name?'}


local f = CreateFrame('frame')


local IsNomi = false -- Are we currently interacting with Nomi?
local function DecorateNomi()
	wipe(TooltipInfo)
	local i = 0
	for j = 1, #ns.ingredient_order do
		local ingredientItemID = ns.ingredient_order[j]
		local count = GetItemCount(ingredientItemID, true) or 0
		local _, _, _, _, ingredientIcon = GetItemInfoInstant(ingredientItemID)
		if count >= 5 then -- we have enough of an ingredient for nomi to display it
			i = i + 1
			local buttonName = 'GossipTitleButton' .. i
			local button = _G[buttonName]
			local buttonIcon = _G[buttonName .. 'GossipIcon'] -- check that the icon is for a work order, otherwise we might overwrite a quest button or something
			if button and button:IsShown() and buttonIcon and buttonIcon:GetTexture():lower() == 'interface\\gossipframe\\workordergossipicon' then
				if not HookedButtons[button] then
					button:HookScript('OnEnter', function(self)
						if not IsNomi then return end
						if TooltipInfo[self] and #TooltipInfo[self] > 0 then
							GameTooltip:SetOwner(self, 'ANCHOR_RIGHT')
							GameTooltip:AddLine('Potential Recipes')
							table.sort(TooltipInfo[self])
							for _, name in pairs(TooltipInfo[self]) do
								GameTooltip:AddLine(name)
							end
							GameTooltip:Show()
						end
					end)
					button:HookScript("OnLeave", GameTooltip_Hide)
					HookedButtons[button] = i
				end

				local ingredient, recipeList = LocalizedIngredientList[ingredientItemID], ns.recipes[ingredientItemID]
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
										if not TooltipInfo[button] then
											TooltipInfo[button] = {}
										end
										local rank = ns.GetRecipeRank(recipeID)
										local icon = ns.GetRecipeIcon(recipeID)
										local name = ns.GetRecipeName(recipeID)
										local fname = format('|T%d:16|t |cffcccccc%s %d', icon, name, rank)
										tinsert(TooltipInfo[button], fname)
										break
									end
								end
							end
							if learnable then
								canLearn = canLearn + 1
								if not TooltipInfo[button] then
									TooltipInfo[button] = {}
								end
								local rank = ns.GetRecipeRank(recipeID)
								local icon = ns.GetRecipeIcon(recipeID)
								local name = ns.GetRecipeName(recipeID)
								local fname = format("|T%d:16|t %s %d", icon, name, rank)
								tinsert(TooltipInfo[button], fname)
							end
						end
					end
					--buttonIcon:SetTexture(ingredientIcon)
					if unlearned ~= 0 then
						if canLearn ~= 0 then
							button:SetFormattedText('|T%d:16|t %d [%s] x%d', ingredientIcon, canLearn, ingredientName, count)
						else
							-- button:SetText('|cff660000' .. canLearn .. ' [' .. ingredientName .. ']')
							button:SetFormattedText('|T%d:16|t |cff660000%d [%s] x%d|r', ingredientIcon, canLearn, ingredientName, count)
						end
					else
						button:SetFormattedText('|cff660000No more |T%d:16|t [%s]', ingredientIcon, ingredientName)
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
