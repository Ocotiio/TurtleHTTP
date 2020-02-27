-- FUNCTION: Read the trtPos.txt file and output the x, y, z, and direction.

-- unseralize phase 
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

--
            -- print(x_unsrl)                               -- print out retrieved data
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

--
            -- print(trtPS1.x_srl)                          -- print out retrieved data
            -- print(trtPS1.y_srl)
            -- print(trtPS1.z_srl)
            -- print(trtPS1.facing_n_srl)
            -- print(trtPS1.facing_s_srl)
            -- print(trtPS1.facing_e_srl)
            -- print(trtPS1.facing_w_srl)

-- direction booleans, set to false before checking for the true
facing_north = trtPS1.facing_n_srl
facing_south = trtPS1.facing_s_srl
facing_east = trtPS1.facing_e_srl
facing_west = trtPS1.facing_w_srl
nsew_arg0 = trtPS1.nsew_arg                    -- from serialize1_1_init

-- check direction, set appropriate facing_dir boolean to true

-- check trtPS1

-- if trtPS1.facing_n_srl == true then
--     nsew_arg = 'north'
--     facing_north = true
-- elseif trtPS1.facing_e_srl == true then
--     nsew_arg = 'east'
--     facing_east = true
-- elseif trtPS1.facing_w_srl == true then
--     nsew_arg = 'west'
--     facing_west = true
-- elseif trtPS1.facing_s_srl == true then
--     nsew_arg = 'south'
--     facing_south = true
-- end

print('BEGIN')
print(trtPS1.x_srl,trtPS1.y_srl,trtPS1.z_srl,nsew_arg0)     -- print out start

-- -- --
-- -- --
-- -- --
--
--
--
-- TURTLE MOVES IN LOOP --
-- LOOP --
-- LOOP --
-- LOOP --
-- LOOP --
-- LOOP --
-- LOOP --
-- LOOP --
-- LOOP --
-- LOOP --
-- LOOP --
-- LOOP --
-- LOOP --
--
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