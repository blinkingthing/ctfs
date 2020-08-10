debugc("++++++++++++++++++++++++++++++++++++++++")
function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

local function has_value (tab, val)
    for i, v in ipairs(tab) do
        if v == val then
            return true
        end
    end

    return false
end

--current room
room = getPlayerRoom()
debugc("current roomID : "..room)
--currentexits
exits = {}
exits = getRoomExits(getPlayerRoom())
debugc("number of exits : "..tablelength(exits))
--checking exits array
--for k, v in pairs(exits) do
--debugc(k)
--debugc(v)
--end

--debugc("current exits : "..exits[1])

function addToSet(set, key)
    set[key] = {}
end

function setContains(set, key)
    return set[key] ~= nil
end

--add current room to checkedlist if it isn't there
--include exits and visit count
if checked[room] == nil then
  checked[room] = {}
  checked[room]["exits"] = {}
  checked[room]["exits_tried"] = {}
  checked[room]["visits"] = 0
  --determine direction you entered from based on directionheaded
  if directionheaded == "north" then
    checked[room]["entrance"] = "south"
  elseif directionheaded == "northeast" then
    checked[room]["entrance"] = "southwest"
  elseif directionheaded == "east" then
    checked[room]["entrance"] = "west"
  elseif directionheaded == "southeast" then
    checked[room]["entrance"] = "northwest"
  elseif directionheaded == "south" then
    checked[room]["entrance"] = "north"
  elseif directionheaded == "southwest" then
    checked[room]["entrance"] = "northeast"
  elseif directionheaded == "west" then
    checked[room]["entrance"] = "east"
  elseif directionheaded == "northwest" then
    checked[room]["entrance"] = "southeast"
  elseif directionheaded == "up" then
    checked[room]["entrance"] = "down"
  elseif directionheaded == "down" then
    checked[room]["entrance"] = "up"
  end
  debugc("Room's original enterance is "..checked[room]["entrance"])
  
  i = 0
  for k, v in pairs(exits) do
    i=i+1
    checked[room]["exits"][i] = k
    debugc("direction #"..i..": "..k)
  end
end

--check visit count.. if less than number of directions, try next direction
checked[room]["visits"] = checked[room]["visits"] + 1
debugc("i've been to this room "..checked[room]["visits"].." time(s)")
debugc("i have tried"..tablelength(checked[room]["exits_tried"]).." exit(s)")
debugc("i have "..tablelength(checked[room]["exits"]).." exit(s) to try")
--check exits against exits_tried and determine which way to go
for index, value in ipairs(checked[room]["exits"]) do
  --make sure to exit from directionentered last
  if value == checked[room]["entrance"] and tablelength(checked[room]["exits"]) == 1 then
        send(value)
      else
  --if entrance dir comes up, but you haven't tried all exits. skip
  if value == checked[room]["entrance"] and tablelength(checked[room]["exits_tried"]) < tablelength(checked[room]["exits"])-1 then
    debugc("can't backtrack, haven't explored fully")
  else
    if value == checked[room]["entrance"] and tablelength(checked[room]["exits_tried"]) == tablelength(checked[room]["exits"]) then
      debugc("backtracking")
      send (checked[room]["entrance"])
    else
      
      --if value isn't direction entered do normal thing. 
      debugc("checking if I've used exit : "..value)
      if has_value(checked[room]["exits_tried"], value) then
        debugc("Already visited "..value)
      else
        debugc("Need to visit "..value)
        --add need to visit direction to exits_tried, and head that way, and break the for loop
        table.insert(checked[room]["exits_tried"], value)
        debugc("headed :"..value)
        send(value) 
        --set direction headed, to determine direction you came from at beginning of loop
        directionheaded = value
        break
        end
      end
    end
  end
end

debugc('rooms checked = '..tablelength(checked))

send("compass")
send("l")
