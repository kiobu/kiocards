function kdc:ClockworkInitPostEntity()
	kdc:LoadDoorClearances()
end;

function kdc:PlayerUseDoor(...)
	print("Door used.", ...);
end;