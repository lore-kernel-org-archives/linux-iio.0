Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga02-in.huawei.com ([45.249.212.188]:5390 "EHLO
        dggrg02-dlp.huawei.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1435291AbdDZJAt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 26 Apr 2017 05:00:49 -0400
From: "weiyongjun (A)" <weiyongjun1@huawei.com>
To: Lee Jones <lee.jones@linaro.org>,
        Jonathan Cameron <jic23@kernel.org>
CC: Wei Yongjun <weiyj.lk@gmail.com>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        "Marek Vasut" <marex@denx.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH -next] iio: adc: mxs-lradc: Fix return value check in
 mxs_lradc_adc_probe()
Date: Wed, 26 Apr 2017 08:58:26 +0000
Message-ID: <6AADFAC011213A4C87B956458587ADB47C87B2@SZXEMI508-MBX.china.huawei.com>
References: <20170425033612.27251-1-weiyj.lk@gmail.com>
 <bff84930-f0d3-fb7f-cdd4-fd1a970ce6b6@kernel.org>
 <20170426084958.7myimjuloft4fhxb@dell>
In-Reply-To: <20170426084958.7myimjuloft4fhxb@dell>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

PiANCj4gT24gV2VkLCAyNiBBcHIgMjAxNywgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gDQo+
ID4gT24gMjUvMDQvMTcgMDQ6MzYsIFdlaSBZb25nanVuIHdyb3RlOg0KPiA+ID4gRnJvbTogV2Vp
IFlvbmdqdW4gPHdlaXlvbmdqdW4xQGh1YXdlaS5jb20+DQo+ID4gPg0KPiA+ID4gSW4gY2FzZSBv
ZiBlcnJvciwgdGhlIGZ1bmN0aW9uIGRldm1faW9yZW1hcCgpIHJldHVybnMgTlVMTCBwb2ludGVy
DQo+ID4gPiBub3QgRVJSX1BUUigpLiBUaGUgSVNfRVJSKCkgdGVzdCBpbiB0aGUgcmV0dXJuIHZh
bHVlIGNoZWNrIHNob3VsZA0KPiA+ID4gYmUgcmVwbGFjZWQgd2l0aCBOVUxMIHRlc3QuDQo+ID4g
Pg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogV2VpIFlvbmdqdW4gPHdlaXlvbmdqdW4xQGh1YXdlaS5j
b20+DQo+ID4gQWNrZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPGppYzIzQGtlcm5lbC5vcmc+DQo+
ID4NCj4gPiBMZWUsIGRvIHlvdSB3YW50IHRvIHBpY2sgdGhpcyB1cD8gIElmIG5vdCBJJ2xsIHNj
b29wIGl0IHVwIGFmdGVyIHRoZSBtZXJnZQ0KPiA+IHdpbmRvdyBoYXMgdW53b3VuZCBhcyBhIGZp
eC4gIE5lZWRzIHRvIGJlIG9uIHRvcCBvZiB0aGUgc2VyaWVzOg0KPiA+IFtQQVRDSCB2MTUgMC81
XSBteHMtbHJhZGM6IFNwbGl0IGRyaXZlciBpbnRvIE1GRA0KPiANCj4gSSdtIGluY2xpbmVkIHRv
IGFncmVlIHdpdGggRG1pdHJ5Og0KPiANCj4gaHR0cHM6Ly93d3cuc3Bpbmljcy5uZXQvbGlzdHMv
bGludXgtaW5wdXQvbXNnNTEwNjEuaHRtbA0KDQpOb3Qgc3VyZSB3ZSBjYW4gdXNlIGRldm1faW9y
ZW1hcF9yZXNvdXJjZSgpLCBpZiBpdCBpcyBzYWZlLCBJIHdpbGwNCnNlbmQgdjIgdmVyc2lvbiBw
YXRjaCB0byB1c2UgZGV2bV9pb3JlbWFwX3Jlc291cmNlKCkgaW5zdGVhZC4NCg0KPiANCj4gPiA+
IC0tLQ0KPiA+ID4gIGRyaXZlcnMvaWlvL2FkYy9teHMtbHJhZGMtYWRjLmMgfCA0ICsrLS0NCj4g
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvbXhzLWxyYWRjLWFkYy5jIGIv
ZHJpdmVycy9paW8vYWRjL214cy1scmFkYy0NCj4gYWRjLmMNCj4gPiA+IGluZGV4IGIwYzdkOGUu
LjQ5M2UyYTIgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvbXhzLWxyYWRjLWFk
Yy5jDQo+ID4gPiArKysgYi9kcml2ZXJzL2lpby9hZGMvbXhzLWxyYWRjLWFkYy5jDQo+ID4gPiBA
QCAtNzE5LDggKzcxOSw4IEBAIHN0YXRpYyBpbnQgbXhzX2xyYWRjX2FkY19wcm9iZShzdHJ1Y3QN
Cj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ID4NCj4gPiA+ICAJaW9yZXMgPSBwbGF0Zm9y
bV9nZXRfcmVzb3VyY2UocGRldiwgSU9SRVNPVVJDRV9NRU0sIDApOw0KPiA+ID4gIAlhZGMtPmJh
c2UgPSBkZXZtX2lvcmVtYXAoZGV2LCBpb3Jlcy0+c3RhcnQsIHJlc291cmNlX3NpemUoaW9yZXMp
KTsNCj4gPiA+IC0JaWYgKElTX0VSUihhZGMtPmJhc2UpKQ0KPiA+ID4gLQkJcmV0dXJuIFBUUl9F
UlIoYWRjLT5iYXNlKTsNCj4gPiA+ICsJaWYgKCFhZGMtPmJhc2UpDQo+ID4gPiArCQlyZXR1cm4g
LUVOT01FTTsNCj4gPiA+DQo+ID4gPiAgCWluaXRfY29tcGxldGlvbigmYWRjLT5jb21wbGV0aW9u
KTsNCj4gPiA+ICAJc3Bpbl9sb2NrX2luaXQoJmFkYy0+bG9jayk7DQo+ID4gPg0KPiA+DQo+IA0K
PiAtLQ0KPiBMZWUgSm9uZXMNCj4gTGluYXJvIFNUTWljcm9lbGVjdHJvbmljcyBMYW5kaW5nIFRl
YW0gTGVhZA0KPiBMaW5hcm8ub3JnIOKUgiBPcGVuIHNvdXJjZSBzb2Z0d2FyZSBmb3IgQVJNIFNv
Q3MNCj4gRm9sbG93IExpbmFybzogRmFjZWJvb2sgfCBUd2l0dGVyIHwgQmxvZw0K
