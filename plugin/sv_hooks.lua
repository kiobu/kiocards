function kdc:ClockworkInitPostEntity()
	kdc:LoadDoorClearances()
end;

function Clockwork:PlayerUseDoor(player, door)
	print("Door used.");
end;