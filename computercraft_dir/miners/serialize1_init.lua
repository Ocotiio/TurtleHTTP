-- arguments

facing_north = false
facing_south = false
facing_east = false
facing_west = false


local tArgs = { ... }
if #tArgs ~= 4 then
    print( "Usage: serialize1_init_x x y z nsew" )
    print( "Input turtle's x y z nsew" )
    return
end

local x_arg = tonumber( tArgs[1] )

local y_arg = tonumber( tArgs[2] )

local z_arg = tonumber( tArgs[3] )

if tArgs[4] == 'n' then
    nsew_arg = 'north'
    facing_north = true
end

if tArgs[4] == 'e' then
    nsew_arg = 'east'
    facing_east = true
end

if tArgs[4] == 'w' then
    nsew_arg = 'west'
    facing_west = true
end

if tArgs[4] == 's' then
    nsew_arg = 'south'
    facing_south = true
end


-- pre init coordinations

x_srlize = x_arg
y_srlize = y_arg
z_srlize = z_arg


-- serialize phase 1

local trtPS0 = {                        -- INPUT table trtPS0!
    x_srl = x_srlize,
    y_srl = y_srlize,
    z_srl = z_srlize,
    facing_n_srl = facing_north,
    facing_s_srl = facing_south,
    facing_e_srl = facing_east,
    facing_w_srl = facing_west,
  }

--textutils.serialize( trtPS0 )           -- Serialize trtPS0!

--print( textutils.serialize( trtPS0 ) )  -- print the serialized trtPS0, cuz y'know! -- -- --

local w = fs.open("trtPos.txt", "w")    -- file write portion!
    w.writeLine(trtPS0.x_srl)
    w.writeLine(trtPS0.y_srl)
    w.writeLine(trtPS0.z_srl)
    w.writeLine(trtPS0.facing_n_srl)
    w.writeLine(trtPS0.facing_s_srl)
    w.writeLine(trtPS0.facing_e_srl)
    w.writeLine(trtPS0.facing_w_srl)
    w.close()


-- unseralize phase 2

local r = fs.open("trtPos.txt", "r")    -- file read portion!!
    x_unsrl = r.readLine()    
    y_unsrl = r.readLine()    
    z_unsrl = r.readLine()
    n_unsrl = r.readLine()
    s_unsrl = r.readLine()
    e_unsrl = r.readLine()
    w_unsrl = r.readLine()
    r.close()


--print(x_unsrl)                          -- print out retrieved data
--print(y_unsrl)
--print(z_unsrl)
--print(n_unsrl)
--print(s_unsrl)
--print(e_unsrl)
--print(w_unsrl)

local trtPS1 = {                        -- new table trtPS1
    x_srl = x_unsrl,
    y_srl = y_unsrl,
    z_srl = z_unsrl,
    facing_n_srl = n_unsrl,
    facing_s_srl = s_unsrl,
    facing_e_srl = e_unsrl,
    facing_w_srl = w_unsrl,
}

print(nsew_arg)

--print(trtPS1.x_srl)                     -- trtPS1.x_srl ... syntax demonstration

print( textutils.serialize( trtPS1 ) )    -- print the serialized trtPS1, cuz y'know! -- -- --