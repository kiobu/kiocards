function kdc:PlayerCanUseDoor(player, door)
    print("Function ran!");
    if (Clockwork.entity:GetOwner(door) and !Clockwork.player:HasDoorAccess(player, door)) then
        print("Uncaught.");
		return false;
	end;
	
    if (Clockwork.entity:IsDoorFalse(door)) then
        print("Uncaught false door.");
		return false;
    end;
    
    local clearance = door:GetNetworkedString("Clearance");

    if (!clearance or clearance == '') then
        print("No clearance for this door.");
    else
        local pass = false;
        for i = 0,5,1 do 
            if (player:HasItemByID("kiocard_clearance_"..i) && i >= tonumber(clearance)) then
                print("Player has clearance.");
                pass = true;
                break;
            else
                print("Player does not have clearance.");
                pass = false;
            end;
        end;
        print("Returning val"..tostring(pass));
        if (!pass) then
            door:Fire("setanimation","close")
            return false;
        else 
            return true
        end;
    end;
end;

-- A function to save the door data.
function kdc:SaveDoorClearances()
    local doorData = {};
    for k,v in pairs(Clockwork.entity:GetDoorEntities()) do
        local dclearance = v:GetNetworkedString("Clearance");

        if (dclearance and dclearance != "") then
            local tab = {
                door = v:EntIndex(),
                clearance = dclearance,
            };
            table.insert(doorData, tab);
        end;
    end;

    if (!file.Exists("kiocards", "data")) then
        file.CreateDir("kiocards")
    end;
    file.Write("kiocards/"..game.GetMap()..".txt", util.TableToKeyValues(doorData));
    MsgC(Color(0, 255, 0, 255), "[Kiocards] Door clearances saved.\n")
end;

-- A function to load the door data.
function kdc:LoadDoorClearances()
    MsgC(Color(255, 255, 0, 255), "[Kiocards] Loading door clearances...\n")
    local doors = {};
	if (file.Exists("kiocards/"..game.GetMap()..".txt", "data")) then
        local tab = util.KeyValuesToTable(file.Read("kiocards/"..game.GetMap()..".txt"));
        for k,v in pairs(tab) do
            kdc:SetDoorClearance(Entity(v.door), v.clearance);
        end;
        MsgC(Color(0, 255, 0, 255), "[Kiocards] Door clearances have been loaded.\n")
    else 
        MsgC(Color(127, 255, 127, 255), "[Kiocards] No door clearances were found for this map.\n")
    end;
end;

function kdc:AcceptInput(ent, input, activator, caller)
    print("Input", ent, input, activator, caller)
    if (!Clockwork.entity:IsDoor(ent)) then
      return;
    end;
    print(1)
    if (input != "Toggle") then
      return;
    end;
    print(2)
    if (!IsValid(activator) or !activator:IsPlayer()) then
      return;
    end;
    print(3)
    if (!IsValid(caller) or caller:GetClass() != "func_button") then
      return;
    end;
    print(4)
    local contactEntity = ent;
    
    for k, v in pairs(ent:GetChildren()) do
      print(5)
      if (v:GetClass() == "prop_dynamic") then
        contactEntity = v;
        print(6, contactEntity)
        break;
      end;
    end;
    
    if (!kdc:PlayerCanUseDoor(activator, contactEntity)) then
      print(7)
      return false;
    end;
end;