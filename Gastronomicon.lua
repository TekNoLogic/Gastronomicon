
local myname, ns = ...


local HookedButtons = {} -- [button] = true
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

				buttonIcon:SetTexture(ingredientIcon)
				button:SetText(ns.GetRecipeTooltipLine(recipe_id))
				GossipResize(button)
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
	end
end)
f:RegisterEvent('GOSSIP_SHOW')
f:RegisterEvent('GOSSIP_CLOSED')
