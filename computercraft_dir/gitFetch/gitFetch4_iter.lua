-- json pre-loading
library_file = "https://gist.githubusercontent.com/Ocotiio/99cbd1b0743b8f2fa405a0eb8cc25ead/raw/7f69cc2cea38bf68298ed3dbfc39d197d53c80de/json.lua"
library_file_content = http.get(library_file).readAll()
output = fs.open("json.lua", "w")
output.write(library_file_content)
output.close()
 
json = require("json")

-- gitFetch 
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