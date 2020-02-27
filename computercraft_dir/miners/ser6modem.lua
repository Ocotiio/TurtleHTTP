-- ser6modem.lua
-- FUNCTION: Modem transmit script. Takes the Turtle's personal location and transmits its coordinates to a Turtle with 'modemrcv1.lua' running, summoning the receiving Turtle to the transmitted coordinates.


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
--
--


--
--



--
--
local modem = peripheral.wrap("right") -- Wraps the modem on the right side.
modem.transmit(3, 1, trtPS1)