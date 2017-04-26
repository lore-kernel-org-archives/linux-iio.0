Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga03-in.huawei.com ([45.249.212.189]:5896 "EHLO
        dggrg03-dlp.huawei.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2998257AbdDZK3U (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 06:29:20 -0400
From: "weiyongjun (A)" <weiyongjun1@huawei.com>
To: Lee Jones <lee.jones@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>,
        Wei Yongjun <weiyj.lk@gmail.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        Marek Vasut <marex@denx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH -next] iio: adc: mxs-lradc: Fix return value check in
 mxs_lradc_adc_probe()
Date: Wed, 26 Apr 2017 10:28:00 +0000
Message-ID: <6AADFAC011213A4C87B956458587ADB47C88D8@SZXEMI508-MBX.china.huawei.com>
References: <20170425033612.27251-1-weiyj.lk@gmail.com>
 <bff84930-f0d3-fb7f-cdd4-fd1a970ce6b6@kernel.org>
 <20170426084958.7myimjuloft4fhxb@dell>
 <6AADFAC011213A4C87B956458587ADB47C87B2@SZXEMI508-MBX.china.huawei.com>
 <20170426100708.vtv7uijpdp3emmn5@dell>
In-Reply-To: <20170426100708.vtv7uijpdp3emmn5@dell>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

PiANCj4gT24gV2VkLCAyNiBBcHIgMjAxNywgd2VpeW9uZ2p1biAoQSkgd3JvdGU6DQo+IA0KPiA+
ID4NCj4gPiA+IE9uIFdlZCwgMjYgQXByIDIwMTcsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+
ID4gPg0KPiA+ID4gPiBPbiAyNS8wNC8xNyAwNDozNiwgV2VpIFlvbmdqdW4gd3JvdGU6DQo+ID4g
PiA+ID4gRnJvbTogV2VpIFlvbmdqdW4gPHdlaXlvbmdqdW4xQGh1YXdlaS5jb20+DQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiBJbiBjYXNlIG9mIGVycm9yLCB0aGUgZnVuY3Rpb24gZGV2bV9pb3JlbWFw
KCkgcmV0dXJucyBOVUxMIHBvaW50ZXINCj4gPiA+ID4gPiBub3QgRVJSX1BUUigpLiBUaGUgSVNf
RVJSKCkgdGVzdCBpbiB0aGUgcmV0dXJuIHZhbHVlIGNoZWNrIHNob3VsZA0KPiA+ID4gPiA+IGJl
IHJlcGxhY2VkIHdpdGggTlVMTCB0ZXN0Lg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogV2VpIFlvbmdqdW4gPHdlaXlvbmdqdW4xQGh1YXdlaS5jb20+DQo+ID4gPiA+IEFja2Vk
LWJ5OiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0KPiA+ID4gPg0KPiA+ID4g
PiBMZWUsIGRvIHlvdSB3YW50IHRvIHBpY2sgdGhpcyB1cD8gIElmIG5vdCBJJ2xsIHNjb29wIGl0
IHVwIGFmdGVyIHRoZSBtZXJnZQ0KPiA+ID4gPiB3aW5kb3cgaGFzIHVud291bmQgYXMgYSBmaXgu
ICBOZWVkcyB0byBiZSBvbiB0b3Agb2YgdGhlIHNlcmllczoNCj4gPiA+ID4gW1BBVENIIHYxNSAw
LzVdIG14cy1scmFkYzogU3BsaXQgZHJpdmVyIGludG8gTUZEDQo+ID4gPg0KPiA+ID4gSSdtIGlu
Y2xpbmVkIHRvIGFncmVlIHdpdGggRG1pdHJ5Og0KPiA+ID4NCj4gPiA+IGh0dHBzOi8vd3d3LnNw
aW5pY3MubmV0L2xpc3RzL2xpbnV4LWlucHV0L21zZzUxMDYxLmh0bWwNCj4gPg0KPiA+IE5vdCBz
dXJlIHdlIGNhbiB1c2UgZGV2bV9pb3JlbWFwX3Jlc291cmNlKCksIGlmIGl0IGlzIHNhZmUsIEkg
d2lsbA0KPiA+IHNlbmQgdjIgdmVyc2lvbiBwYXRjaCB0byB1c2UgZGV2bV9pb3JlbWFwX3Jlc291
cmNlKCkgaW5zdGVhZC4NCj4gDQo+IFdoYXQgbWFrZXMgeW91IHRoaW5rIGl0IG1pZ2h0IG5vdCBi
ZSBzYWZlPw0KDQoNCkxhc3QgdGltZSwgd2hlbiBJIGZpeCB0aGUgc2FtZSBpc3N1ZSBmb3Igb3Ro
ZXIgZHJpdmVyLCBhbmQgY2F1c2UgcHJvYmxlbS4gU28gSSBhbQ0Kbm90IHN1cmUgd2hldGhlciB3
ZSBjYW4gY29udmVydCB0byB1c2UgZGV2bV9pb3JlbWFwX3Jlc291cmNlLg0KDQo9PT09DQpTb21l
IHBpbmN0cmxzIHNoYXJlIG1lbW9yeSByZWdpb25zLCBhbmQgZGV2bV9pb3JlbWFwX3Jlc291cmNl
IGRvZXMgbm90DQphbGxvdyB0byBzaGFyZSByZXNvdXJjZXMsIGluIG9wcG9zaXRpb24gdG8gZGV2
bV9pb3JlbWFwLg0KVGhpcyBwYXRjaCByZXN0b3JlcyBiYWNrIHVzYWdlIG9mIGRldm1faW9yZW1h
cCBmdW5jdGlvbiwgYnV0IHdpdGggcHJvcGVyDQplcnJvciBoYW5kbGluZyBhbmQgbG9nZ2luZy4N
Cj09PT0NCg0KaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMvbGludXgtc2Ftc3VuZy1zb2Mv
bXNnNTgzNjYuaHRtbA0KDQoNClJlZ2FyZHMsDQpZb25nanVuIFdlaQ0K
