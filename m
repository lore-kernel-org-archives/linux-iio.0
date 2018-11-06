Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr710071.outbound.protection.outlook.com ([40.107.71.71]:63168
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729160AbeKFSt4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Nov 2018 13:49:56 -0500
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v4 2/2] staging: iio: ad7780: remove unnecessary stashed
 voltage value
Date: Tue, 6 Nov 2018 09:25:27 +0000
Message-ID: <f36da3b8962d463a68e53e29563b3c9bff2e0ddf.camel@analog.com>
References: <cover.1541444377.git.renatogeh@gmail.com>
         <3920d49d888f63b600a4d2f2600921ed2900a470.1541444377.git.renatogeh@gmail.com>
In-Reply-To: <3920d49d888f63b600a4d2f2600921ed2900a470.1541444377.git.renatogeh@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE4LTExLTA1IGF0IDE3OjE2IC0wMjAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gVGhpcyBwYXRjaCByZW1vdmVzIHRoZSB1bm5lY2Vzc2FyeSBmaWVsZCBpbnRfdnJlZl9tdiBp
biBhZDc3ODBfc3RhdGUNCj4gcmVmZXJyaW5nIHRvIHRoZSBkZXZpY2UncyB2b2x0YWdlLg0KPiAN
Cg0KTG9va3MgZ29vZCBmcm9tIG15IHNpZGUuDQoNCkFsZXgNCg0KPiBTaWduZWQtb2ZmLWJ5OiBS
ZW5hdG8gTHVpIEdlaCA8cmVuYXRvZ2VoQGdtYWlsLmNvbT4NCj4gLS0tDQo+IENoYW5nZXMgaW4g
djM6DQo+IAktIHJlbW92ZWQgdW5uZWNlc3NhcnkgaW50X3ZyZWZfbXYgZnJvbSBhZDc3ODBfc3Rh
dGUNCj4gQ2hhbmdlcyBpbiB2NDoNCj4gCS0gcmVtb3ZlZCB2b2x0YWdlIHJlYWRpbmcgb24gcHJv
YmUNCj4gDQo+ICBkcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYyB8IDkgKy0tLS0tLS0t
DQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDggZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gYi9kcml2
ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBpbmRleCBjN2NiMDVjZWRiYmMuLjUyYTkx
NDM2MDU3NCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMN
Cj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gQEAgLTQyLDcgKzQy
LDYgQEAgc3RydWN0IGFkNzc4MF9zdGF0ZSB7DQo+ICAJc3RydWN0IHJlZ3VsYXRvcgkJKnJlZzsN
Cj4gIAlzdHJ1Y3QgZ3Bpb19kZXNjCQkqcG93ZXJkb3duX2dwaW87DQo+ICAJdW5zaWduZWQgaW50
CWdhaW47DQo+IC0JdTE2CQkJCWludF92cmVmX212Ow0KPiAgDQo+ICAJc3RydWN0IGFkX3NpZ21h
X2RlbHRhIHNkOw0KPiAgfTsNCj4gQEAgLTE2NSw3ICsxNjQsNyBAQCBzdGF0aWMgaW50IGFkNzc4
MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgew0KPiAgCXN0cnVjdCBhZDc3ODBf
c3RhdGUgKnN0Ow0KPiAgCXN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXY7DQo+IC0JaW50IHJldCwg
dm9sdGFnZV91diA9IDA7DQo+ICsJaW50IHJldDsNCj4gIA0KPiAgCWluZGlvX2RldiA9IGRldm1f
aWlvX2RldmljZV9hbGxvYygmc3BpLT5kZXYsIHNpemVvZigqc3QpKTsNCj4gIAlpZiAoIWluZGlv
X2RldikNCj4gQEAgLTE4NSwxNiArMTg0LDEwIEBAIHN0YXRpYyBpbnQgYWQ3NzgwX3Byb2JlKHN0
cnVjdCBzcGlfZGV2aWNlICpzcGkpDQo+ICAJCWRldl9lcnIoJnNwaS0+ZGV2LCAiRmFpbGVkIHRv
IGVuYWJsZSBzcGVjaWZpZWQgQVZkZA0KPiBzdXBwbHlcbiIpOw0KPiAgCQlyZXR1cm4gcmV0Ow0K
PiAgCX0NCj4gLQl2b2x0YWdlX3V2ID0gcmVndWxhdG9yX2dldF92b2x0YWdlKHN0LT5yZWcpOw0K
PiAgDQo+ICAJc3QtPmNoaXBfaW5mbyA9DQo+ICAJCSZhZDc3ODBfY2hpcF9pbmZvX3RibFtzcGlf
Z2V0X2RldmljZV9pZChzcGkpLT5kcml2ZXJfZGF0YV07DQo+ICANCj4gLQlpZiAodm9sdGFnZV91
dikNCj4gLQkJc3QtPmludF92cmVmX212ID0gdm9sdGFnZV91diAvIDEwMDA7DQo+IC0JZWxzZQ0K
PiAtCQlkZXZfd2Fybigmc3BpLT5kZXYsICJSZWZlcmVuY2Ugdm9sdGFnZSB1bnNwZWNpZmllZFxu
Iik7DQo+IC0NCj4gIAlzcGlfc2V0X2RydmRhdGEoc3BpLCBpbmRpb19kZXYpOw0KPiAgDQo+ICAJ
aW5kaW9fZGV2LT5kZXYucGFyZW50ID0gJnNwaS0+ZGV2Ow0K
