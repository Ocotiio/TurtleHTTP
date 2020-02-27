-- local sExample = http.get("https://raw.githubusercontent.com/Ocotiio/TurtleHTTP/master/trtPos.txt")

-- https://raw.githubusercontent.com/Ocotiio/TurtleHTTP/master/_listdir/cc_dir_miners_list.json

-- os.loadAPI('/API/json.lua')
-- print(json)

json = require("/API/json")


miners_list_json = "https://raw.githubusercontent.com/Ocotiio/TurtleHTTP/master/_listdir/cc_dir_miners_list.json"

local origin_list = http.get(miners_list_json).readAll()

tbl = json.parse(origin_list)
print(tbl)
print(tbl['0'])

print('for _ in pairs(tbl)')
for _ in pairs(tbl) do
    print(_, tbl[_])
    print("https://raw.githubusercontent.com/Ocotiio/TurtleHTTP/master/computercraft_dir/miners/"..tbl[_])
    local file_n = http.get("https://raw.githubusercontent.com/Ocotiio/TurtleHTTP/master/computercraft_dir/miners/"..tbl[_]).readAll()
    if file_n then
            f = fs.open(tbl[_], "w")
            f.write(file_n)
            f.close()
            print("File '"..tbl[_].."' downloaded.")
        else
            error("Could not download file!")
        end
    end