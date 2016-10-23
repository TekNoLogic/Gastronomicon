
local myname, ns = ...


local subtexts = {}


local function GetSubtext(button)
	if subtexts[button] then return subtexts[button] end

	local subtext = button:CreateFontString(nil, nil, "QuestFontNormalSmall")
	subtext:SetPoint("RIGHT", -20, 0)
	subtexts[button] = subtext

	return subtext
end


function ns.SetSubtext(button, text)
	local subtext = GetSubtext(button)
	subtext:SetText(text)
	subtext:Show()
end


function ns.HideSubtexts()
	for subtext in pairs(subtexts) do subtext:Hide() end
end
