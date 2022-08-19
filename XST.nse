local http = require "http"
local nmap = require "nmap"
local shortport = require "shortport"
local stdnse = require "stdnse"
local table = require "table"
categories = {"vuln", "discovery", "safe"}
portrule = shortport.http
local validate = function(response, response_headers)
local output_lines = {}
if ( not(response) ) then
return
end
if not(response:match("HTTP/1.[01] 200") or response:match("TRACE / HTTP/1.[01]")) then
return
else
output_lines[ #output_lines+1 ] = "Celah XST [Cross Site Tracing] ditemukan"
end
if nmap.verbosity() >= 2 then
output_lines[ #output_lines+1 ]= "Headers:"
for _, value in pairs(response_headers) do
output_lines [ #output_lines+1 ] = value
end
end
if #output_lines > 0 then
return table.concat(output_lines, "\n")
end
end
action = function(host, port)
local path = stdnse.get_script_args("http-trace.path") or "/"
local req = http.generic_request(host, port, "TRACE", path)
if (req.status == 301 or req.status == 302) and req.header["location"] then
req = http.generic_request(host, port, "TRACE", req.header["location"])
end
return validate(req.body, req.rawheader)
end
