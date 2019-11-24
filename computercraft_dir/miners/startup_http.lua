-- startup_http

-- Turtle startup, call http, download something

local sExample = http.get("http://example.com/") --Get contents of page
write(sExample.readAll()) --Read and print contents of page
sExample.close() --Just in case