local T, C, L, G = unpack(select(2, ...))

-- Communicate to other players through our AddOn
local Version = tonumber(GetAddOnMetadata("Tukui", "Version"))
local SendAddonMessage = SendAddonMessage
local tonumber = tonumber

-- Need this localized
local Outdated = L.UI_Outdated

local CheckVersion = function(self, event, prefix, message, channel, sender)
	if event == "CHAT_MSG_ADDON" then
		if (prefix ~= "TukuiVersion") or (sender == UnitName("player")) then 
			return
		end
		
		if (tonumber(message) > Version) then -- We recieved a higher version, we're outdated. :(
			print("|cffad2424"..Outdated.."|r")
			self:UnregisterEvent("CHAT_MSG_ADDON")
		end
	else
		SendAddonMessage("TukuiVersion", Version, "RAID") -- Tell everyone what version we use.
	end
end

local TukuiVersion = CreateFrame("Frame")
TukuiVersion:RegisterEvent("PLAYER_ENTERING_WORLD")
TukuiVersion:RegisterEvent("GROUP_ROSTER_UPDATE")
TukuiVersion:RegisterEvent("CHAT_MSG_ADDON")
TukuiVersion:SetScript("OnEvent", CheckVersion)

RegisterAddonMessagePrefix("TukuiVersion")
