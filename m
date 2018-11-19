Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr710054.outbound.protection.outlook.com ([40.107.71.54]:7500
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726784AbeKSSl4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Nov 2018 13:41:56 -0500
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matheus.bernardino@usp.br" <matheus.bernardino@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "victorcolombo@gmail.com" <victorcolombo@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/7] staging:iio:ad2s90: Add max frequency check at
 probe
Date: Mon, 19 Nov 2018 08:18:53 +0000
Message-ID: <8d86411bf3267e9d4c72f725d3da87ac4bace203.camel@analog.com>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
         <20181118042540.12697-4-matheus.bernardino@usp.br>
In-Reply-To: <20181118042540.12697-4-matheus.bernardino@usp.br>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE4LTExLTE4IGF0IDAyOjI1IC0wMjAwLCBNYXRoZXVzIFRhdmFyZXMgd3JvdGU6
DQo+IEZyb206IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVsZWFuQGFuYWxvZy5j
b20+DQo+IA0KPiBUaGlzIHBhdGNoIGFkZHMgYSBtYXggZnJlcXVlbmN5IGNoZWNrIGF0IHRoZSBi
ZWdpbm5pbmcgb2YgYWQyczkwX3Byb2JlDQo+IGZ1bmN0aW9uIHNvIHRoYXQgd2hlbiBpdCBpcyBz
ZXQgdG8gYSB2YWx1ZSBhYm92ZSAwLjgzTWh6LCBkZXZfZXJyIGlzDQo+IGNhbGxlZCB3aXRoIGFu
IGFwcHJvcHJpYXRlIG1lc3NhZ2UgYW5kIC1FSU5WQUwgaXMgcmV0dXJuZWQuDQo+IA0KPiBUaGUg
ZGVmaW5lZCBsaW1pdCBpcyAwLjgzTWh6IGluc3RlYWQgb2YgMk1oeiwgd2hpY2ggaXMgdGhlIGNo
aXAncyBtYXgNCj4gZnJlcXVlbmN5IGFzIHNwZWNpZmllZCBpbiB0aGUgZGF0YXNoZWV0LCBiZWNh
dXNlLCBhcyBhbHNvIHNwZWNpZmllZCBpbg0KPiB0aGUgZGF0YXNoZWV0LCBhIDYwMG5zIGRlbGF5
IGlzIGV4cGVjdGVkIGJldHdlZW4gdGhlIGFwcGxpY2F0aW9uIG9mIGENCj4gbG9naWMgTE8gdG8g
Q1MgYW5kIHRoZSBhcHBsaWNhdGlvbiBvZiBTQ0xLLiBTaW5jZSB0aGUgZGVsYXkgaXMgbm90DQo+
IGltcGxlbWVudGVkIGluIHRoZSBzcGkgY29kZSwgdG8gc2F0aXNmeSBpdCwgU0NMSydzIHBlcmlv
ZCBzaG91bGQgYmUgYXQNCj4gbW9zdCAyICogNjAwbnMsIHNvIHRoZSBtYXggZnJlcXVlbmN5IHNo
b3VsZCBiZSAxIC8gKDIgKiA2ZS03KSwgd2hpY2gNCj4gZ2l2ZXMgcm91Z2hseSA4MzAwMDBIei4N
Cj4gDQo+IFNpZ25lZC1vZmYtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFyZGVs
ZWFuQGFuYWxvZy5jb20+DQoNCkkgdGhpbmsgeW91IGNhbiB1c2UgIlN1Z2dlc3RlZC1ieToiIGlu
c3RlYWQuDQpCdXQgdGhpcyBpcyBhbHNvIGZpbmUuDQoNCj4gU2lnbmVkLW9mZi1ieTogTWF0aGV1
cyBUYXZhcmVzIDxtYXRoZXVzLmJlcm5hcmRpbm9AdXNwLmJyPg0KPiAtLS0NCj4gQ2hhbmdlcyBp
biB2MjoNCj4gIC0gQ29ycmVjdGx5IGNyZWRpdCBBbGV4YW5kcnUgYXMgdGhlIHBhdGNoJ3MgYXV0
aG9yDQo+IA0KPiAgZHJpdmVycy9zdGFnaW5nL2lpby9yZXNvbHZlci9hZDJzOTAuYyB8IDEyICsr
KysrKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKykNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL3Jlc29sdmVyL2FkMnM5MC5jDQo+IGIvZHJp
dmVycy9zdGFnaW5nL2lpby9yZXNvbHZlci9hZDJzOTAuYw0KPiBpbmRleCA5MTNkNmZhZDJkNGQu
LmZlOTBmMjA1NmJmZiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2lpby9yZXNvbHZl
ci9hZDJzOTAuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL3Jlc29sdmVyL2FkMnM5MC5j
DQo+IEBAIC0xOSw2ICsxOSwxMiBAQA0KPiAgI2luY2x1ZGUgPGxpbnV4L2lpby9paW8uaD4NCj4g
ICNpbmNsdWRlIDxsaW51eC9paW8vc3lzZnMuaD4NCj4gIA0KPiArLyoNCj4gKyAqIEFsdGhvdWdo
IGNoaXAncyBtYXggZnJlcXVlbmN5IGlzIDJNaHosIGl0IG5lZWRzIDYwMG5zIGJldHdlZW4gQ1Mg
YW5kDQo+IHRoZQ0KPiArICogZmlyc3QgZmFsbGluZyBlZGdlIG9mIFNDTEssIHNvIGZyZXF1ZW5j
eSBzaG91bGQgYmUgYXQgbW9zdCAxIC8gKDIgKg0KPiA2ZS03KQ0KPiArICovDQo+ICsjZGVmaW5l
IEFEMlM5MF9NQVhfU1BJX0ZSRVFfSFogIDgzMDAwMA0KPiArDQo+ICBzdHJ1Y3QgYWQyczkwX3N0
YXRlIHsNCj4gIAlzdHJ1Y3QgbXV0ZXggbG9jazsNCj4gIAlzdHJ1Y3Qgc3BpX2RldmljZSAqc2Rl
djsNCj4gQEAgLTc4LDYgKzg0LDEyIEBAIHN0YXRpYyBpbnQgYWQyczkwX3Byb2JlKHN0cnVjdCBz
cGlfZGV2aWNlICpzcGkpDQo+ICAJc3RydWN0IGlpb19kZXYgKmluZGlvX2RldjsNCj4gIAlzdHJ1
Y3QgYWQyczkwX3N0YXRlICpzdDsNCj4gIA0KPiArCWlmIChzcGktPm1heF9zcGVlZF9oeiA+IEFE
MlM5MF9NQVhfU1BJX0ZSRVFfSFopIHsNCj4gKwkJZGV2X2Vycigmc3BpLT5kZXYsICJTUEkgQ0xL
LCAlZCBIeiBleGNlZWRzICVkIEh6XG4iLA0KPiArCQkJc3BpLT5tYXhfc3BlZWRfaHosIEFEMlM5
MF9NQVhfU1BJX0ZSRVFfSFopOw0KPiArCQlyZXR1cm4gLUVJTlZBTDsNCj4gKwl9DQo+ICsNCj4g
IAlpbmRpb19kZXYgPSBkZXZtX2lpb19kZXZpY2VfYWxsb2MoJnNwaS0+ZGV2LCBzaXplb2YoKnN0
KSk7DQo+ICAJaWYgKCFpbmRpb19kZXYpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0K
