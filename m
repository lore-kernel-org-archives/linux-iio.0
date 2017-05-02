Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:5841 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbdEBBqt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 1 May 2017 21:46:49 -0400
From: "weiyongjun (A)" <weiyongjun1@huawei.com>
To: =?utf-8?B?S3NlbmlqYSBTdGFub2pldmnEhw==?=
        <ksenija.stanojevic@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lee Jones <lee.jones@linaro.org>
CC: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Marek Vasut <marex@denx.de>, Lee Jones <lee.jones@linaro.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH -next v2] iio: adc: mxs-lradc: Fix return value check in
 mxs_lradc_adc_probe()
Date: Tue, 2 May 2017 01:43:11 +0000
Message-ID: <6AADFAC011213A4C87B956458587ADB47CFF8A@SZXEMI508-MBX.china.huawei.com>
References: <20170425033612.27251-1-weiyj.lk@gmail.com>
 <20170427151413.23843-1-weiyj.lk@gmail.com>
 <1fffc4ab-8952-1252-8e84-6e9b6583dfc3@kernel.org>
 <CAL7P5j+rw0VoQkKgM=ZvNtEdfKtuEqUyJmRyfdtZfjKQfysCLw@mail.gmail.com>
In-Reply-To: <CAL7P5j+rw0VoQkKgM=ZvNtEdfKtuEqUyJmRyfdtZfjKQfysCLw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SGkgTGVlLA0KDQo+IA0KPiBIaSBXZWksDQo+IA0KPiBPbiBTdW4sIEFwciAzMCwgMjAxNyBhdCA2
OjMxIFBNLCBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0KPiB3cm90ZToNCj4g
PiBPbiAyNy8wNC8xNyAxNjoxNCwgV2VpIFlvbmdqdW4gd3JvdGU6DQo+ID4+IEZyb206IFdlaSBZ
b25nanVuIDx3ZWl5b25nanVuMUBodWF3ZWkuY29tPg0KPiA+Pg0KPiA+PiBJbiBjYXNlIG9mIGVy
cm9yLCB0aGUgZnVuY3Rpb24gZGV2bV9pb3JlbWFwKCkgcmV0dXJucyBOVUxMIHBvaW50ZXIgbm90
DQo+ID4+IEVSUl9QVFIoKS4gVXNlIGRldm1faW9yZW1hcF9yZXNvdXJjZSgpIGluc3RlYWQgb2Yg
ZGV2bV9pb3JlbWFwKCkuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFdlaSBZb25nanVuIDx3
ZWl5b25nanVuMUBodWF3ZWkuY29tPg0KPiA+IEknbGwgYmUgd2FudGluZyBhIHRlc3RlZC1ieSBm
b3IgdGhpcyBvbmUuDQo+ID4NCj4gPiBUaGFua3MsDQo+ID4NCj4gPiBKb25hdGhhbg0KPiA+PiAt
LS0NCj4gPj4gdjEgLT4gdjI6IHVzZSBkZXZtX2lvcmVtYXBfcmVzb3VyY2UoKQ0KPiA+PiAtLS0N
Cj4gDQo+IA0KPiBJIHRlc3RlZCB5b3VyIHBhdGNoIG9uIGkubXgyOCBhbmQgaXQgY2F1c2VzIHBy
b2JlIGZhaWx1cmUuIEhlcmUncyBkbWVzZw0KPiBvdXRwdXQ6DQo+IA0KPiBbICAgIDMuMDY1OTU5
XSBteHMtbHJhZGMtYWRjIG14cy1scmFkYy1hZGM6IGNhbid0IHJlcXVlc3QgcmVnaW9uIGZvcg0K
PiByZXNvdXJjZSBbbWVtIDB4ODAwNTAwMDAtMHg4MDA1MWZmZl0NCj4gWyAgICAzLjA3NTUzN10g
bXhzLWxyYWRjLWFkYzogcHJvYmUgb2YgbXhzLWxyYWRjLWFkYyBmYWlsZWQgd2l0aCBlcnJvciAt
MTYNCg0KDQpJdCBzZWVtcyB0aGF0IG14cy1scmFkYyBkZXZpY2VzIHNoYXJlIG1lbW9yeSByZWdp
b25zLCBhbmQgZGV2bV9pb3JlbWFwX3Jlc291cmNlDQpkb2VzIG5vdCBhbGxvdyB0byBzaGFyZSBy
ZXNvdXJjZXMgd2Ugc2hvdWxkIHN0aWxsIHVzZSBkZXZtX2lvcmVtYXAoKS4NCg0KDQpSZWdhcmRz
LA0KWW9uZ2p1biBXZWkgDQo=
