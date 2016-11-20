
local myname, ns = ...


local subtexts = {}


local function GetSubtext(button)
	if subtexts[button] then return subtexts[button] end

	local subtext = button:CreateFontString(nil, nil, "QuestFontNormalSmall")
	subtext:SetPoint("RIGHT", -20, 0)
	subtexts[button] = subtext

	ns.RegisterEvent(subtext, "GOSSIP_CLOSED", subtext.Hide)

	return subtext
end


function ns.SetSubtext(button, text)
	local subtext = GetSubtext(button)
	subtext:SetText(text)
	subtext:Show()
end
