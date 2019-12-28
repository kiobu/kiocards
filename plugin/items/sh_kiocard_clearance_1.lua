--[[
	© CloudSixteen.com do not share, re-distribute or modify
	without permission of its author (kurozael@gmail.com).
--]]

local ITEM = Clockwork.item:New();

ITEM.name = "Level 1 Card";
ITEM.uniqueID = "kiocard_clearance_1";
ITEM.model = "models/gibs/shield_scanner_gib1.mdl";
ITEM.weight = 0.8;
ITEM.access = "X";
ITEM.category = "Clearance";
ITEM.description = "A small keycard.";

-- Called when a player attempts to pick up the item.
function ITEM:CanPickup(player, quickUse, itemEntity)
	if (!Clockwork.player:HasFlags(player, "X")) then
		Clockwork.player:GiveFlags(player, "X")
	end;
end;

-- Called when a player drops the item.
function ITEM:OnDrop(player, position) 
	if (Clockwork.player:HasFlags(player, "X")) then
		Clockwork.player:TakeFlags(player, "X")
	end;
end;

ITEM:Register();