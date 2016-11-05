Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:53205 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752918AbcKEQgb (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 5 Nov 2016 12:36:31 -0400
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "Song, Hongyan" <hongyan.song@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>
Subject: Re: [PATCH] iio: hid-sensor-attributes: Check
 sample_frequency/hysteresis write data legitimacy
Date: Sat, 5 Nov 2016 16:36:28 +0000
Message-ID: <1478363785.3242.0.camel@intel.com>
References: <1478133948-16089-1-git-send-email-hongyan.song@intel.com>
         <1478282145.14557.14.camel@intel.com>
         <3b9b5b27-31ee-dfb7-deef-a93e83399324@kernel.org>
In-Reply-To: <3b9b5b27-31ee-dfb7-deef-a93e83399324@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gU2F0LCAyMDE2LTExLTA1IGF0IDE2OjMyICswMDAwLCBKb25hdGhhbiBDYW1lcm9uIHdyb3Rl
Og0KPiBPbiAwNC8xMS8xNiAxNzo1NSwgUGFuZHJ1dmFkYSwgU3Jpbml2YXMgd3JvdGU6DQo+ID4g
DQo+ID4gT24gVGh1LCAyMDE2LTExLTAzIGF0IDAwOjQ1ICswMDAwLCBTb25nIEhvbmd5YW4gd3Jv
dGU6DQo+ID4gPiANCj4gPiA+IA0KPiA+ID4gTmVpdGhlciBzYW1wbGUgZnJlcXVlbmN5IHZhbHVl
IG5vciBoeXN0ZXJlc2lzIHZhbHVlIGNhbiBiZSBzZXQgdG8NCj4gPiA+IGJlDQo+ID4gPiBhDQo+
ID4gPiBuZWdhdGl2ZSBudW1iZXIsIGNoZWNrIGFuZCByZXR1cm4gIkludmFsaWQgYXJndW1lbnQi
IGlmIHRoZXkgYXJlDQo+ID4gPiBuZWdhdGl2ZS4NCj4gPiA+IA0KPiA+ID4gSWYgbm90IGRvIHRo
aXMgY2hhbmdlLCBzYW1wbGVfZnJlcXVlbmN5IHdpbGwgYmUgc2V0IGludG8gc29tZQ0KPiA+ID4g
dW5rbm93bg0KPiA+ID4gdmFsdWUsIHJlYWQgaHlzdGVyZXNpcyB2YWx1ZSBhZnRlciB3cml0ZSBu
ZWdhdGl2ZSBudW1iZXIgd2lsbA0KPiA+ID4gcmV0dXJuDQo+ID4gPiAiSW52YWxpZCBhcmd1bWVu
dCIuDQo+ID4gPiANCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNvbmcgSG9uZ3lhbiA8aG9uZ3lhbi5z
b25nQGludGVsLmNvbT4NCj4gPiBBY2tlZC1ieTogU3Jpbml2YXMgUGFuZHJ1dmFkYSA8c3Jpbml2
YXMucGFuZHJ1dmFkYUBsaW51eC5pbnRlbC5jb20+DQo+IEZyb20gdGhlIGRlc2NyaXB0aW9uIEkn
bSByZWFkaW5nIHRoaXMgYXMgYSBtaW5vciBpc3N1ZSBhbmQgbm90IGENCj4gcmVncmVzc2lvbiAo
aXQgbmV2ZXIgd29ya2VkIHJpZ2h0KS7CoMKgQXMgc3VjaCB3aXRoIExpbnVzIGdldHRpbmcNCj4g
aXJyaXRhdGVkIGFib3V0IGZpeGVzIGZvciBzdHVmZiB0aGF0IGhhcyBiZWVuIGxvbmcgYnJva2Vu
IEknbQ0KPiBnb2luZyB0byB0YWtlIHRoaXMgdGhlIHNsb3cgcm91dGUgKGkuZS4gbmV4dCBtZXJn
ZSB3aW5kb3cpLg0KPiANClRoaXMgaXMgZmluZS4gVGhpcyBpcyBub3QgdXJnZW50IGZpeC4NCg0K
VGhhbmtzLA0KU3Jpbml2YXMNCg0KDQoNCj4gQXBwbGllZCB0byB0aGUgdG9ncmVnIGJyYW5jaCBv
ZiBpaW8uZ2l0LiBXaWxsIGJlIGluaXRpYWxseSBwdXNoZWQgb3V0DQo+IGFzIHRlc3RpbmcgZm9y
IHRoZSBhdXRvYnVpbGRlcnMgdG8gcGxheSB3aXRoIGl0Lg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
Sm9uYXRoYW4NCj4gPiANCj4gPiANCj4gPiA+IA0KPiA+ID4gDQo+ID4gPiAtLS0NCj4gPiA+IMKg
ZHJpdmVycy9paW8vY29tbW9uL2hpZC1zZW5zb3JzL2hpZC1zZW5zb3ItYXR0cmlidXRlcy5jIHwg
NSArKysrLQ0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gPiANCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9jb21tb24vaGlk
LXNlbnNvcnMvaGlkLXNlbnNvci0NCj4gPiA+IGF0dHJpYnV0ZXMuYw0KPiA+ID4gYi9kcml2ZXJz
L2lpby9jb21tb24vaGlkLXNlbnNvcnMvaGlkLXNlbnNvci1hdHRyaWJ1dGVzLmMNCj4gPiA+IGlu
ZGV4IGRjMzNjMWQuLjQ1MDlmODQ3NSAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMvaWlvL2Nv
bW1vbi9oaWQtc2Vuc29ycy9oaWQtc2Vuc29yLWF0dHJpYnV0ZXMuYw0KPiA+ID4gKysrIGIvZHJp
dmVycy9paW8vY29tbW9uL2hpZC1zZW5zb3JzL2hpZC1zZW5zb3ItYXR0cmlidXRlcy5jDQo+ID4g
PiBAQCAtMjAxLDcgKzIwMSw3IEBAIGludCBoaWRfc2Vuc29yX3dyaXRlX3NhbXBfZnJlcV92YWx1
ZShzdHJ1Y3QNCj4gPiA+IGhpZF9zZW5zb3JfY29tbW9uICpzdCwNCj4gPiA+IMKgCWludCByZXQ7
DQo+ID4gPiDCoA0KPiA+ID4gwqAJaWYgKHZhbDEgPCAwIHx8IHZhbDIgPCAwKQ0KPiA+ID4gLQkJ
cmV0ID0gLUVJTlZBTDsNCj4gPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+ID4gwqANCj4gPiA+
IMKgCXZhbHVlID0gdmFsMSAqIHBvd18xMCg2KSArIHZhbDI7DQo+ID4gPiDCoAlpZiAodmFsdWUp
IHsNCj4gPiA+IEBAIC0yNTAsNiArMjUwLDkgQEAgaW50IGhpZF9zZW5zb3Jfd3JpdGVfcmF3X2h5
c3RfdmFsdWUoc3RydWN0DQo+ID4gPiBoaWRfc2Vuc29yX2NvbW1vbiAqc3QsDQo+ID4gPiDCoAlz
MzIgdmFsdWU7DQo+ID4gPiDCoAlpbnQgcmV0Ow0KPiA+ID4gwqANCj4gPiA+ICsJaWYgKHZhbDEg
PCAwIHx8IHZhbDIgPCAwKQ0KPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4gPiArDQo+ID4g
PiDCoAl2YWx1ZSA9IGNvbnZlcnRfdG9fdnRmX2Zvcm1hdChzdC0+c2Vuc2l0aXZpdHkuc2l6ZSwN
Cj4gPiA+IMKgCQkJCXN0LT5zZW5zaXRpdml0eS51bml0X2V4cG8sDQo+ID4gPiDCoAkJCQl2YWwx
LA0KPiA+ID4gdmFsMik7Tu+/ve+/ve+/ve+/ve+/vXLvv73vv71577+977+977+9Yu+/vVjvv73v
v73Hp3bvv71e77+9Kd66ey5u77+9K++/ve+/ve+/ve+/vXvvv73vv70qIu+/ve+/vV5u77+9cu+/
ve+/ve+/vXrvv70a77+977+9aO+/ve+/ve+/ve+/vSYNCj4gPiA+IO+/ve+/vR7vv71H77+977+9
77+9aO+/vQMo77+96ZqO77+93aJqIu+/ve+/vRrvv70bbe+/ve+/ve+/ve+/ve+/vXrvv73elu+/
ve+/ve+/vWbvv73vv73vv71o77+977+977+9fu+/vW1tbD09DQo+IA==
