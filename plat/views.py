# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.shortcuts import render,HttpResponse,redirect
from django.utils.deprecation import MiddlewareMixin
from django.core.exceptions import PermissionDenied
from django.views import View
import dns.resolver
import time


MAX_REQUEST_PER_SECOND=2
class Md1(MiddlewareMixin):
    def process_request(self, request):
        now = time.time()
        request_queue = request.session.get('request_queue', [])
        if len(request_queue) < MAX_REQUEST_PER_SECOND:
            request_queue.append(now)
            request.session['request_queue'] = request_queue
        else:
            time1 = request_queue[0]
            if (now - time1) < 3:
                raise PermissionDenied()
            request_queue.append(time.time())
            request.session['request_queue'] = request_queue[1:]


def shuju(url):
    url_dict = {
        "kehu30.npjq3g.com": "http://www.18ab.cc",
        "kehu37.uomko9.com": "http://www.795969.com",
        "halin877.nx7aun.com": "http://www.amjsty.com",
        "20190321.g4v94e.com": "https://www.01338.com",
        "3415459394.xbpdj2.com": "http://yyyy.dnstiao.com",
        "xhh899.ay3un5.com": "http://ymty.dns66666.com",
        "kkk.ppvnv56.me": "http://ymty.dns66666.com",
        "kehu32.mvgf8n.com": "http://www.2004655.com",
        "3014002271.f8rdgu.com": "http://www.www876262.com",
        "1426955253.nx7aun.com": "http://www.c67783.com",
        "1426955253.f8rdgu.com": "http://www.ziuxcyhwuqyhrfiwhsnf.com",
        "1426955253.qehl2q.com": "http://www.c67783.com",
        "3014002271.qehl2q.com": "http://www.51gongbao.com/app/gongbao.html",
        "3270065774.ryu6q.com": "http://www.4591jc.com",
        "3557886598001.pye3q.com": "http://www.1786900.com",
        "3557886598002.pye3q.com": "http://www.980868.com",
        "3557886598003.pye3q.com": "http://www.1008929.com",
        "qqcom.tip7g.com":"http://ymty.dns66666.com",
        "2017032701.uomko9.com": "http://www.1366891.com",
        "3014002271.g4v94e.com": "http://www.jurong168.com/app/suzhou.html",
        "tencent.xhh327.com": "https://www.meishij.net",
        "3464729339.xbpdj2.com": "http://www.58166.com",
        "3464729339.ryu6q.com": "http://103.233.9.26",
        "3270065774.ncu8j.com": "http://www.1123zz.com",
        "1783830454.ncu8j.com": "http://daka3d.com/yidong/dake.html",
    }
    cc_list = []
    for cc, aa in url_dict.items():
        cc_list.append(str(cc))
    for mm in url:
        if mm in cc_list:
            return url_dict[mm]


class IndexView(MiddlewareMixin):
    def process_request(self, request):
        domain = request.META.get('HTTP_HOST', 'unknown')
        # domain="www.baidu.com"
        list_url = domain.strip().split('.')
        if list_url[0] != "www":
            domain = "www." + domain
        try:
            A = dns.resolver.query(domain, 'A')
        except Exception as e:
            return HttpResponse(status=403)
        else:
            global record_list
            record_list = []
            for ii in A.response.answer:
                record_list.append(str(ii[0])[0:-1])
            mmpp = shuju(record_list)
        return redirect(mmpp)
