--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "Level 1 Card";
ITEM.uniqueID = "kiocard_clearance_1"; -- Do not change.
ITEM.model = "models/hunter/plates/plate025.mdl";
ITEM.weight = 0.8;
ITEM.access = "X";
ITEM.category = "Clearance";
ITEM.description = "A small keycard.";

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) 
end;

ITEM:Register();