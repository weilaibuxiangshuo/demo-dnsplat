#!/usr/bin/lua
local resolver = require "resty.dns.resolver"
local cjson = require "cjson"
local r, err = resolver:new{
    nameservers = { "114.114.114.114" }
}
--uri=cjson.encode(ngx.req.get_headers()["host"])
local uri=ngx.req.get_headers()["host"]
local uuiipp=tostring(uri)
if(string.sub(uuiipp,1,3)=="www") then
    hhkk=uuiipp
else
    hhkk="www."..uuiipp
end
--ngx.print(hhkk)
guize=string.match(hhkk,"[%w]+[^%w][%w]+[^%w][%w]+[^%w][%w]+")
--ngx.print(guize)
if (not (tostring(guize)=="nil")) then
   -- ngx.print("403")
    ngx.exit(403)
end
local ans, err = r:tcp_query(hhkk, CNAME)
if(not (cjson.encode(err)=="null")) then
    ngx.exit(403)
end
shu_total={}
record_total={}
for key ,value in ipairs(ans) do
    local mmhh=cjson.encode(value["cname"])
    local mmuu=cjson.encode(value["name"])
    if(not (mmhh=="null")) then
        table.insert(shu_total,mmhh)
    end
    if(not (mmuu=="null")) then
        table.insert(shu_total,mmuu)
    end
end
local aa={}
for key,val in pairs(shu_total) do
aa[val]=true
end
for key,val in pairs(aa) do
table.insert(record_total,key)
end
sum_total={
{"ccc.uuu.com","http://www.baidu.com"},
}
for key,val in pairs(sum_total) do
    for kk,jj in pairs(record_total) do
        if('"'..val[1]..'"'==jj) then
            --ngx.print(jj)
            -- ngx.print(val[2])
            ngx.redirect(val[2])
        end
    end
end

local shuju=cjson.encode(ans)
--ngx.print (shuju)
local shuju1=cjson.encode(err)
--ngx.print (shuju1)

