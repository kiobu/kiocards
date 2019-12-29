function kdc:PlayFailureSound(door)
    sound.Play("Resource/warning.wav", door:GetPos())
end;

function kdc:PlayerCanUseDoor(player, door)
    if (Clockwork.entity:GetOwner(door) and !Clockwork.player:HasDoorAccess(player, door)) then
		return false;
	end;
	
    if (Clockwork.entity:IsDoorFalse(door)) then
		return false;
    end;
    
    local clearance = door:GetNetworkedString("Clearance");

    if (!clearance or clearance == '') then
    else
        local pass = false;
        for i = 0,5,1 do 
            if (player:HasItemByID("kiocard_clearance_"..i) && i >= tonumber(clearance)) then
                pass = true;
                break;
            else
                pass = false;
            end;
        end;
        if (!pass) then
            kdc:PlayFailureSound(door)
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

-- Called when an entity fires an event to this entity.
    -- Prevents button doors from opening without proper clearance.
function kdc:AcceptInput(ent, input, activator, caller)
    if (!Clockwork.entity:IsDoor(ent)) then
      return;
    end;
    
    if (input != "Toggle") then
      return;
    end;
    
    if (!IsValid(activator) or !activator:IsPlayer()) then
      return;
    end;
    
    if (!IsValid(caller) or caller:GetClass() != "func_button") then
      return;
    end;
    
    local contactEntity = ent;
    
    for k, v in pairs(ent:GetChildren()) do
      if (v:GetClass() == "prop_dynamic") then
        contactEntity = v;
        
        break;
      end;
    end;
    
    if (kdc:PlayerCanUseDoor(activator, contactEntity) == false) then
      return true;
    end;
end;