nums = {}
ops = {}
string =""
blank =""
product = ""
quotient = ""
sum = ""
difference = ""

nums[1] = matches[2]
nums[2] = matches[4]
nums[3] = matches[6]
nums[4] = matches[8]
nums[5] = matches[10]
nums[6] = matches[12]
nums[7] = matches[14]
ops[1] = matches[3]
ops[2] = matches[5]
ops[3] = matches[7]
ops[4] = matches[9]
ops[5] = matches[11]
ops[6] = matches[13]
ops[7] = ""

function buildEquation()
  string = ""
  
  for index, value in ipairs(nums) do
    if tonumber(value) == nil then x = index
    end
  end

  for index, value in ipairs(nums) do
    if index == x then 
      string = string .. "x"
      blank = index
    else
      string = string .. value
    end
    string = string .. ops[index]
  end
end


function cryptoMine()

buildEquation()


--debugc("blank is " .. blank)
--debugc("equation is : " .. string)
--debugc("multiplicaiton")

for index, value in ipairs(ops) do
  if value == "*" then
    if tonumber(nums[index]) ~= nil and tonumber(nums[index+1]) ~= nil then
    product = nums[index] * nums[index+1]
    nums[index] = product
    table.remove(nums, index+1)
    table.remove(ops, index)
    end
  end
end



buildEquation()

--debugc ("product = " .. product)
--debugc ("new equation is : " .. string)

--if x is in position 1
if tonumber(nums[1]) == nil then
  --common denominator 
  denom = nums[3] * nums[5]
  --debugc("denom = " .. denom)
  atop = nums[2] * nums[5]
  btop = nums[4] * nums[3]
  rightside = nums[6] * denom

--new equation
  string = ""
  string = string .. "x*" .. atop .. ops[3] .. btop .. "=" .. rightside

  --debugc("new equation : " .. string)

--check last op for - or + 

  if ops[3] == "-" then
    needsdivision = rightside + btop
    needsrounding = needsdivision / atop
    --debugc("needs rounding : " .. needsrounding)
    rounded = math.floor(needsrounding+0.5)
    --debugc("rounded = " .. rounded)
    send("crypto " .. rounded)
  else
    send("crypto")
  end
--x is in position 2
elseif tonumber(nums[2]) == nil then
  --debugc('pos2')
--first op is '/'
  if ops[1] == "/" then
  denom = nums[4]
  topa = nums[1] * denom
  topb = nums[3]
  righta = nums[5] * denom
  newrighta = topb + righta
  needsrounding = topa / newrighta
  rounded = math.floor(needsrounding+0.5)
  --debugc("rounded = " .. rounded)
  send("crypto " .. rounded)
--first op is '*'
  elseif ops[1] == "*" then
     --common denominator 
    denom = nums[3] * nums[5]
    --debugc("denom = " .. denom)
    atop = nums[1] * nums[5]
    btop = nums[4] * nums[3]
    rightside = nums[6] * denom
    --check last op for - or + 
       if ops[3] == "-" then
          needsdivision = rightside + btop
          needsrounding = needsdivision / atop
          rounded = math.floor(needsrounding+0.5)
          --debugc("checkme")
          --debugc("rounded = " .. rounded)
          send("crypto " .. rounded)
      end
  end
elseif tonumber(nums[3]) == nil then
  --debugc("pos 3")
  --common denominator 
  denom = nums[2] * nums[5]
  --debugc("denom = " .. denom)
  atop = nums[1] * nums[5]
  btop = nums[4] * nums[2]
  rightside = nums[6] * denom
  needsdivision = rightside - atop
  needsrounding = needsdivision / btop
  --debugc("needs rounding : " .. needsrounding)
  rounded = math.floor(needsrounding+0.5)
  inverted = rounded * -1
  --debugc("check me")
  --debugc("inverted = " .. inverted)
  send("crypto " .. inverted)
elseif tonumber(nums[4]) == nil then
  --debugc("pos 4")
  denom = nums[2]
  topa = nums[1]
  topb = nums[3] * denom
  righta = nums[5] * denom
  newrighta = righta - topa
  needsrounding = topb / newrighta
  rounded = math.floor(needsrounding+0.5)
  inverted = rounded * -1
  --debugc("inverted = " .. inverted)
  --debugc("checkme")
  send("crypto " .. inverted)
elseif tonumber(nums[5]) == nil then
  --debugc("pos 5")
  whole1 = nums[3]
  whole2 = nums[6]
  combinedwhole = whole1 + whole2
  rightside = nums[7] - combinedwhole
  invertedright = rightside * -1
  denom = nums[2]
  topa = nums[1]
  topb = invertedright * denom
  newright = nums[4] * denom
  combinedleft = topa + topb
  needsrounding = combinedleft / newright
  rounded = math.floor(needsrounding+0.5)
  --debugc("rounded = " .. rounded)
  --debugc("checkme")
  send("crypto " .. rounded)
  --elseif tonumber(nums[5]) == nil then
  --debugc("pos 6")
--if in unwanted position, resend crypto
else
    send ("crypto")
end
end

cryptoMine()

