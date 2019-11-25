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
    print( "Usage: transitSerialize4 +x +y +z" )
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
x_transit = tonumber( tArgs[1] )  -- transit_x from Argument 1.
y_transit = tonumber( tArgs[2] )  -- transit_y from Argument 2.
z_transit = tonumber( tArgs[3] )  -- transit_x from Argument 3.


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


-- Make vectors .. wait, this is for (XYZ reposition)
--vector_x = x_srl - x_transit
--vector_y = y_srl - y_transit
--vector_z = z_srl - z_transit

--print(vector_x)
--print(vector_y)
--print(vector_z)

-- direction booleans, set to false before checking for the true
facing_north = false
facing_south = false
facing_east = false
facing_west = false
nsew_arg0 = trtPS1.nsew_arg

-- check direction, set appropriate facing_dir boolean to true
if trtPS1.facing_n_srl == true or trtPS1.facing_n_srl == 'true' then
    nsew_arg0 = 'north'
    facing_north = true                 -- north = -Z
elseif trtPS1.facing_e_srl == true or trtPS1.facing_e_srl == 'true' then
    nsew_arg0 = 'east'
    facing_east = true                  -- east = +X
elseif trtPS1.facing_w_srl == true or trtPS1.facing_w_srl == 'true' then
    nsew_arg0 = 'west'
    facing_west = true                  -- west = -X
elseif trtPS1.facing_s_srl == true or trtPS1.facing_s_srl == 'true' then
    nsew_arg0 = 'south'
    facing_south = true                 -- south = +Z
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




x_ctr = x_transit
y_ctr = y_transit
z_ctr = z_transit

-- print(x_ctr)
-- print(y_ctr)
-- print(z_ctr)
-- print(facing_east)
-- print(facing_north)
-- print(facing_west)
-- print(facing_south)


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
        print("x negative")
        print(x_ctr)
        while x_ctr > 0 do            -- x_transit = x_ctr is positive
            x_ctr = advance(x_ctr, false)           -- dirBool = false, to make x go down
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
        print("x positive")
        print(x_ctr)
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
        print("z negative")
        print(z_ctr)
        while z_ctr > 0 do                -- z_transit = z_ctr is positive
            z_ctr = advance(z_ctr, false)           -- dirBool = false, to make z go down
            trtPS1.z_srl = trtPS1.z_srl + 1
        end
    end
end

while z_ctr < 0 do                   -- -Z north
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
        facing_south = true
    end
    if facing_north then
        print("z positive")
        print(z_ctr)
        while z_ctr < 0 do                -- z_transit = z_ctr is positive
            z_ctr = advance(z_ctr, true)           -- dirBool = false, to make z go down
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





trtPS1.facing_n_srl = facing_north
trtPS1.facing_s_srl = facing_south
trtPS1.facing_e_srl = facing_east
trtPS1.facing_w_srl = facing_west

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