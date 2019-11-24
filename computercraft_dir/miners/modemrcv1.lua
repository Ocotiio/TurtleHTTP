-- modemrcv0.lua


-- Move functions

function safety()   -- returns false if detecting a computer, returns true if things are safe
    if turtle.detect() then -- if turtle.detect() is true, then ...
      local success, data = turtle.inspect()  -- data for inspect
      if success then
        if data.name == 'computercraft:turtle_normal' then
          return false
        else if data.name == 'computercraft:turtle_advanced' then
          return false
        else
          return true
        end
      end
    end
    else if turtle.detect() == false then            -- else == turtle.detect is false
      return true
    end
  end
end


function safetyUp()   -- returns false if detecting a computer, returns true if things are safe
  if turtle.detectUp() then -- if turtle.detectUp() is true, then ...
    local success, data = turtle.inspectUp()  -- data for inspect
    if success then
      if data.name == 'computercraft:turtle_normal' then
        return false
      else if data.name == 'computercraft:turtle_advanced' then
        return false
      else
        return true
      end
    end
  else             -- else == turtle.detect is false
    return true
  end
end
end


function safetyDown()   -- returns false if detecting a computer, returns true if things are safe
  if turtle.detectDown() then -- if turtle.detectDown() is true, then ...
    local success, data = turtle.inspectDown()  -- data for inspect
    if success then
      if data.name == 'computercraft:turtle_normal' then
        return false
      else if data.name == 'computercraft:turtle_advanced' then
        return false
      else
        return true
      end
    end
  else             -- else == turtle.detect is false
    return true
  end
end
end

function advance(ctr, dirBool)    -- updated to add some detects() to not smash turtles
  if dirBool then
      dir_k = 1
  end
  if not dirBool then
      dir_k = -1
  end
  if turtle.detect() then
      local success, data = turtle.inspect()  -- data for inspect
      if success then
        if data.name ~= 'computercraft:turtle_normal' then
          if data.name ~= 'computercraft:turtle_advanced' then
          turtle.dig()
          end
        end
      end
  end
    
  if turtle.forward() then
      ctr = ctr + (1 * dir_k)
  else
    turtle.up()
    if turtle.detect() then
      local success, data = turtle.inspect()  -- data for inspect
      if success then
        if data.name ~= 'computercraft:turtle_normal' then
          if data.name ~= 'computercraft:turtle_advanced' then
          turtle.dig()
          end
        end
      end
    end
    if turtle.forward() then
      ctr = ctr + (1 * dir_k)
    end
    if turtle.detect() then
      local success, data = turtle.inspect()  -- data for inspect
      if success then
        if data.name ~= 'computercraft:turtle_normal' then
          if data.name ~= 'computercraft:turtle_advanced' then
          turtle.dig()
          end
        end
      end
    end
    if turtle.forward() then
      ctr = ctr + (1 * dir_k)
    end
    turtle.down()
  end
  return ctr
end

local function tryDigUp()
  while turtle.detectUp() do
      if turtle.digUp() then
      else
          return false
      end
  end
  return true
end

local function tryDigDown()
  while turtle.detectDown() do
      if turtle.digDown() then
      else
          return false
      end
  end
  return true
end


--
--
-- Unserialize Phase

local r = fs.open("trtPos.txt", "r")    -- file read portion!!
    x_unsrl = r.readLine()    
    y_unsrl = r.readLine()    
    z_unsrl = r.readLine()
    n_unsrl = r.readLine()
    s_unsrl = r.readLine()
    e_unsrl = r.readLine()
    w_unsrl = r.readLine()
    nsew_unsrl = r.readLine()
    r.close()


local trtPS1 = {                        -- new table trtPS1
    x_srl = x_unsrl,
    y_srl = y_unsrl,
    z_srl = z_unsrl,
    facing_n_srl = n_unsrl,
    facing_s_srl = s_unsrl,
    facing_e_srl = e_unsrl,
    facing_w_srl = w_unsrl,
    nsew_arg = nsew_unsrl
}

facing_north = false
facing_south = false
facing_east = false
facing_west = false
nsew_arg = trtPS1.nsew_arg

-- check direction, set appropriate facing_dir boolean to true

local function tPS1_compass()                -- compass function, using tPS1.nsew's to check its own booleans... returns nsew
  if trtPS1.facing_n_srl == true or trtPS1.facing_n_srl == 'true' then
      nsew_arg = 'north'
      facing_north = true                 -- north = -Z
      return nsew_arg
  elseif trtPS1.facing_e_srl == true or trtPS1.facing_e_srl == 'true' then
      nsew_arg = 'east'
      facing_east = true                  -- east = +X
      return nsew_arg
  elseif trtPS1.facing_w_srl == true or trtPS1.facing_w_srl == 'true' then
      nsew_arg = 'west'
      facing_west = true                  -- west = -X
      return nsew_arg
  elseif trtPS1.facing_s_srl == true or trtPS1.facing_s_srl == 'true' then
      nsew_arg = 'south'
      facing_south = true                 -- south = +Z
      return nsew_arg
  end
end


tPS1_compass()        -- call tPS compass to set our locations


local function local_compass()                -- compass function, using local booleans to check, print, and return its nsew state
  if facing_north then
      nsew_arg = 'north'
      return nsew_arg
  elseif facing_east then
      nsew_arg = 'east'
      return nsew_arg
  elseif facing_west then
      nsew_arg = 'west'
      return nsew_arg
  elseif facing_south then
      nsew_arg = 'south'
      return nsew_arg
  end
end

--
--
--


local modem = peripheral.wrap("right")
modem.open(3)  -- Open channel 3 so that we can listen on it

local event, modemSide, senderChannel, 
  replyChannel, message, senderDistance = os.pullEvent("modem_message")
  trtPS_recv = message

--
-- local trtPS_recv = {                        -- new table trtPS1
--     x_srl = x_unsrl,
--     y_srl = y_unsrl,
--     z_srl = z_unsrl,
--     facing_n_srl = n_unsrl,
--     facing_s_srl = s_unsrl,
--     facing_e_srl = e_unsrl,
--     facing_w_srl = w_unsrl,
--     nsew_arg = nsew_unsrl
-- }

print("I just received a message on channel: "..senderChannel)
print("I should apparently reply on channel: "..replyChannel)
print("The modem receiving this is located on my "..modemSide.." side")
print(trtPS_recv.x_srl)
-- print("The message was: "..message)
print("The sender is: "..(senderDistance or "an unknown number of").." blocks away from me.")


-- Make vectors of distance

vector_x = trtPS_recv.x_srl - trtPS1.x_srl
vector_y = trtPS_recv.y_srl - trtPS1.y_srl
vector_z = trtPS_recv.z_srl - trtPS1.z_srl

print('Vector X')
print(vector_x)
print('Vector Y')
print(vector_y)
print('Vector Z')
print(vector_z)

-- Counters from vectors

x_ctr = vector_x
y_ctr = vector_y
z_ctr = vector_z

safe = safety()
safeUp = safetyUp()
safeDown = safetyDown()

-- 

while x_ctr > 0 do
  if facing_west then         -- change direction
      turtle.turnRight()
      facing_west = false
      facing_north = true
  end
  if facing_north then
      turtle.turnRight()
      facing_north = false
      facing_east = true
  end
  if facing_south then
      turtle.turnLeft()
      facing_south = false
      facing_east = true
  end
  safe = safety()
  if facing_east then
      print("+x, subtract from")
      print(x_ctr)
      print("safe?")
      print(safe)
      while x_ctr > 0 and safe == true do                      -- x_transit = x_ctr is positive
        x_ctr = advance(x_ctr, false)        -- dirBool = false, to make x go down
        trtPS1.x_srl = trtPS1.x_srl + 1
        safe = safety()
      end
      if safe == false and x_ctr == 1 then
        x_ctr = x_ctr - 1
      end
  end
end

while x_ctr < 0 do
  if facing_east then
      turtle.turnRight()
      facing_east = false
      facing_south = true
  end
  if facing_south then
      turtle.turnRight()
      facing_south = false
      facing_west = true
  end
  if facing_north then
      turtle.turnLeft()
      facing_north = false
      facing_west = true
  end
  safe = safety()
  if facing_west then
      print("-x, add to")
      print(x_ctr)
      print("safe?")
      print(safe)
      while x_ctr < 0 and safe == true do    -- x_transit = x_ctr is negative
        x_ctr = advance(x_ctr, true)    -- dirBool = true, to make x go up
        trtPS1.x_srl = trtPS1.x_srl - 1
        safe = safety()
      end
      if safe == false and x_ctr == -1 then
        x_ctr = x_ctr + 1
      end
  end
end

-- north = -Z -- west = -X
-- south = +Z -- east = +X

while z_ctr > 0 do                   -- +Z south
  if facing_north then
      turtle.turnRight()
      facing_north = false
      facing_east = true
  end
  if facing_east then
      turtle.turnRight()
      facing_east = false
      facing_south = true
  end
  if facing_west then         -- change direction
      turtle.turnLeft()
      facing_west = false
      facing_south = true
  end
  safe = safety()
  if facing_south then
      print("+z, subtract from")
      print(z_ctr)
      print("safe?")
      print(safe)
      while z_ctr > 0 and safe == true do                -- z_transit = z_ctr is positive
          z_ctr = advance(z_ctr, false)           -- dirBool = false, to make z go down
          trtPS1.z_srl = trtPS1.z_srl + 1
          safe = safety()
      end
      if safe == false and z_ctr == 1 then
        z_ctr = z_ctr -1
      end
  end
end


local function face_north()
  if facing_south then
      turtle.turnRight()
      facing_south = false
      facing_west = true
  end
  if facing_west then         -- change direction
      turtle.turnRight()
      facing_west = false
      facing_north = true
  end
  if facing_east then
      turtle.turnLeft()
      facing_east = false
      facing_north = true
  end
end

while z_ctr < 0 do                   -- -Z north
  face_north()
  safe = safety()
  if facing_north then
      print("-z, add to")
      print(z_ctr)
      print("safe?")
      print(safe)
      while z_ctr < 0 and safe == true do                -- z_transit = z_ctr is negative
          z_ctr = advance(z_ctr, true)           -- dirBool = true, to make z go up
          trtPS1.z_srl = trtPS1.z_srl - 1
          safe = safety()
      end
      if safe == false and z_ctr == -1 then
        z_ctr = z_ctr + 1 
      end
  end
end

safeUp = safetyUp()
safeDown = safetyDown()

if y_ctr > 0 then
  while y_ctr > 0 and safeUp == true do
      print("+y, subtract from")
      print(y_ctr)
      print("safe?")
      print(safeUp)
      tryDigUp()
      turtle.up()
      y_ctr = y_ctr - 1
      trtPS1.y_srl = trtPS1.y_srl + 1
      safeUp = safetyUp()
  end
  if safeUp == false and y_ctr == 1 then
    y_ctr = y_ctr - 1
  end
end

if y_ctr < 0 then
  while y_ctr < 0 and safeDown == false do
      print("-y, add from")
      print(y_ctr)
      print("safe?")
      print(safeDown)
      tryDigDown()
      turtle.down()
      y_ctr = y_ctr + 1
      trtPS1.y_srl = trtPS1.y_srl - 1
      safeDown = safetyDown()
  end
  if safeDown == false and y_ctr == - 1 then
    y_ctr = y_ctr + 1
  end
end


print(trtPS1.x_srl)
-- trtPS1.x_srl = x_newpos
-- print(trtPS1.x_srl)

print(trtPS1.y_srl)
-- trtPS1.y_srl = y_newpos
-- print(trtPS1.y_srl)

print(trtPS1.z_srl)
-- trtPS1.z_srl = z_newpos
-- print(trtPS1.z_srl)




trtPS1.facing_n_srl = facing_north
trtPS1.facing_s_srl = facing_south
trtPS1.facing_e_srl = facing_east
trtPS1.facing_w_srl = facing_west
trtPS1.nsew_arg = local_compass()

-- -- --
-- -- --
-- -- --
-- AFTER LOOP


-- Serialize Phase Out
local function save_trtPS()
  local w = fs.open("trtPos.txt", "w")    -- file write portion!
      w.writeLine(trtPS1.x_srl)
      w.writeLine(trtPS1.y_srl)
      w.writeLine(trtPS1.z_srl)
      w.writeLine(trtPS1.facing_n_srl)
      w.writeLine(trtPS1.facing_s_srl)
      w.writeLine(trtPS1.facing_e_srl)
      w.writeLine(trtPS1.facing_w_srl)
      w.writeLine(trtPS1.nsew_arg)
      w.close()
end

save_trtPS()