-- gps local init

facing_north = false
facing_south = false
facing_east = false
facing_west = false
nsew_arg0 = ''

-- gps_compass() ... returns nsew_arg = 'west','east','north','south'

local function gps_compass()        
    x_gps, y_gps, z_gps = gps.locate(5)
    x_store = x_gps
    y_store = y_gps
    z_store = z_gps
    turtle.forward()
    x_gps, y_gps, z_gps = gps.locate(5)
    if x_store ~= x_gps then
        print("moved x")
        if x_store > x_gps then
            print ("facing neg x, west")
            nsew_arg = 'west'
            return nsew_arg
        end
        if x_store < x_gps then
            print ("facing pos x, east")
            nsew_arg = 'east'
            return nsew_arg
        end
    end
    if z_store ~= z_gps then
        if z_store > z_gps then
            print ("facing neg z, north")
            nsew_arg = 'north'
            return nsew_arg
        end
        if z_store < z_gps then
            print ("facing pos z, south")
            nsew_arg = 'south'
            return nsew_arg
        end
    end
    if x_store == x_gps and z_store == z_gps then
        print("didn't move")
        return None
    end
end

-- advance() function

local function advance()
    if turtle.detect() then
        turtle.dig()
    end
    turtle.forward()
end

-- try up try down functions 

local function tryDigUp()
    while turtle.detectUp() do
        if turtle.digUp() then
            sleep(0.1)
        else
            return false
        end
    end
    return true
end

local function tryDigDown()
    while turtle.detectDown() do
        if turtle.digDown() then
            sleep(0.1)
        else
            return false
        end
    end
    return true
end


-- LOOP BEGIN

print("Man I am so lost right now!")

nsew_arg0 = gps_compass()

if nsew_arg0 == 'east' then
    facing_east = true
elseif nsew_arg0 == 'west' then
    facing_west = true
elseif nsew_arg0 == 'north' then
    facing_north = true
elseif nsew_arg0 == 'south' then
    facing_south = true
end



local x_0, y_0, z_0 = gps.locate(5)

if not x_0 then --If gps.locate didn't work, it won't return anything. So check to see if it did.
  print("Failed to get my location!")
else
  print("I am at (" .. x_0 .. ", " .. y_0 .. ", " .. z_0 .. ")") --This prints 'I am at (1, 2, 3)' or whatever your coordinates are
end



local trtPS1 = {                        -- new table trtPS1
    x_srl = x_0,
    y_srl = y_0,
    z_srl = z_0,
    facing_n_srl = facing_north,
    facing_s_srl = facing_south,
    facing_e_srl = facing_east,
    facing_w_srl = facing_west,
    nsew_arg = nsew_arg0
}


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