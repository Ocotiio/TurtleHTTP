-- PRE INIT

-- -- -- Transit Set Up
--Requires a turtle.--
if not turtle then
    printError( "Requires a Turtle" )
    return
end

--Program takes 3 arguments.-- -- arguments
local tArgs = { ... }                   -- 3 arguments.
if #tArgs ~= 3 then
    print( "Usage: transitPosSer2 xPos yPos zPos" )
    return
end

-- advance(ctr, dirBool) -- will take 2 arguments: ctr, dirBool. ctr must be x_ctr, y_ctr, or z_ctr. dirBool is a boolean, t = Forward, f = Backward.
                                        -- true = Forward, increment the counter by +1. -- false = Backward, increment the counter by -1.
                                        -- Turtle turn must be done outside this function, tho. Too hard to track NSEW within this.

function advance(ctr, dirBool)    
    if dirBool then
        dir_k = 1
    end
    if not dirBool then
        dir_k = -1
    end
    if turtle.detect() then
        turtle.dig()
    end
    if turtle.forward() then
        ctr = ctr + (1 * dir_k)
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

--Transit arguments/variables
x_newpos = tonumber( tArgs[1] )  -- transit_x from Argument 1.
y_newpos = tonumber( tArgs[2] )  -- transit_y from Argument 2.
z_newpos = tonumber( tArgs[3] )  -- transit_x from Argument 3.


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

-- print(x_unsrl)                          -- print out retrieved data
-- print(y_unsrl)
-- print(z_unsrl)
-- print(n_unsrl)
-- print(s_unsrl)
-- print(e_unsrl)
-- print(w_unsrl)

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

-- print(trtPS1.nsew_arg)

-- Make vectors .. 
vector_x = x_newpos - trtPS1.x_srl
vector_y = y_newpos - trtPS1.y_srl
vector_z = z_newpos - trtPS1.z_srl

--print(vector_x)
--print(vector_y)
--print(vector_z)

-- direction booleans, set to false before checking for the true
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



x_axis = false          -- new bools, possibly?;; currently unused, however
z_axis = false 
local function spin_compass()               -- currently unused
    if facing_north or facing_south then
        z_axis = true
        return z_axis
    elseif facing_east or facing_west then
        x_axis = true
        return x_axis
    end
end 


--print('BEGIN')
----print(nsew_arg)              -- print out direction
--print(trtPS1.x_srl,trtPS1.y_srl,trtPS1.z_srl)     -- print out start
--print(trtPS1.facing_n_srl,trtPS1.facing_s_srl,trtPS1.facing_e_srl,trtPS1.facing_w_srl)

--print( textutils.serialize( trtPS1 ) )    -- print the serialized trtPS1, cuz y'know! -- -- --

-- -- --
-- -- --
-- -- --
--
--
--
-- TURTLE MOVES IN LOOP --




x_ctr = vector_x
y_ctr = vector_y
z_ctr = vector_z

-- print(x_ctr)
-- print(y_ctr)
-- print(z_ctr)
-- print(nsew_arg)

-- -- print(facing_east)
-- -- print(facing_north)
-- -- print(facing_west)
-- -- print(facing_south)


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
    if facing_east then
        -- print("+x, subtract from")
        -- print(x_ctr)
        while x_ctr > 0 do                      -- x_transit = x_ctr is positive
            x_ctr = advance(x_ctr, false)        -- dirBool = false, to make x go down
            trtPS1.x_srl = trtPS1.x_srl + 1
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
    if facing_west then
        -- print("-x, add to")
        -- print(x_ctr)
        while x_ctr < 0 do    -- x_transit = x_ctr is negative
            x_ctr = advance(x_ctr, true)    -- dirBool = true, to make x go up
            trtPS1.x_srl = trtPS1.x_srl - 1
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
    if facing_south then
        -- print("+z, subtract from")
        -- print(z_ctr)
        while z_ctr > 0 do                -- z_transit = z_ctr is positive
            z_ctr = advance(z_ctr, false)           -- dirBool = false, to make z go down
            trtPS1.z_srl = trtPS1.z_srl + 1
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
    if facing_north then
        -- print("-x, add to")
        -- print(z_ctr)
        while z_ctr < 0 do                -- z_transit = z_ctr is negative
            z_ctr = advance(z_ctr, true)           -- dirBool = true, to make z go up
            trtPS1.z_srl = trtPS1.z_srl - 1
        end
    end
end


if y_ctr > 0 then
    while y_ctr > 0 do
        tryDigUp()
        turtle.up()
        y_ctr = y_ctr - 1
        trtPS1.y_srl = trtPS1.y_srl + 1
    end
end

if y_ctr < 0 then
    while y_ctr < 0 do
        tryDigDown()
        turtle.down()
        y_ctr = y_ctr + 1
        trtPS1.y_srl = trtPS1.y_srl - 1
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
--
--
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