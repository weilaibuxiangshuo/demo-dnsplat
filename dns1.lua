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
{"kehu30.npjq3g.com","http://www.18ab.cc"},
{"kehu37.uomko9.com","https://www.071515.com"},
{"halin877.nx7aun.com","https://www.amjsty.com"},
{"20190321.g4v94e.com","https://www.01338.com"},
{"3415459394.xbpdj2.com","http://yyyy.dnstiao.com"},
{"xhh899.ay3un5.com","http://ymty.dns66666.com"},
{"kkk.ppvnv56.me","http://ymty.dns66666.com"},
{"kehu32.mvgf8n.com","http://www.2004655.com"},
{"3014002271.f8rdgu.com","http://www.www848585.com"},
{"1426955253.nx7aun.com","http://www.c67783.com"},
{"1426955253.f8rdgu.com","http://www.ziuxcyhwuqyhrfiwhsnf.com"},
{"1426955253.qehl2q.com","http://www.c67783.com"},
{"3014002271.qehl2q.com","http://www.51gongbao.com/app/gongbao.html"},
{"3270065774.ryu6q.com","http://www.4591jc.com"},
{"3557886598001.pye3q.com","http://www.1786900.com"},
{"3557886598002.pye3q.com","http://www.980868.com"},
{"3557886598003.pye3q.com","http://www.1008929.com"},
{"qqcom.tip7g.com","http://ymty.dns66666.com"},
{"2017032701.uomko9.com","http://www.1366891.com"},
{"2028564679.g4v94e.com","https://www.1909955.com"},
{"tencent.xhh327.com","https://www.meishij.net"},
{"3464729339.xbpdj2.com","http://www.58166.com"},
{"3464729339.ryu6q.com","http://103.233.9.26"},
{"3270065774.ncu8j.com","http://www.1123zz.com"},
{"1783830454.ncu8j.com","http://daka3d.com/yidong/dake.html"},
{"3014002271.u3khfd.com","http://www.jurong168.com/app/suzhou.html"},
{"hai.pp2cc7j.me","http://www.163.com"},
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

