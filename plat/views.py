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
        "ccc.uuu.com": "http://www.baidu.com",
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
