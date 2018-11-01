Return-Path: <SRS0=thGR=NM=analog.com=alexandru.Ardelean@kernel.org>
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"jic23@kernel.org" <jic23@kernel.org>, "Hennerich, Michael"
	<Michael.Hennerich@analog.com>, "renatogeh@gmail.com" <renatogeh@gmail.com>,
	"giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>, "pmeerw@pmeerw.net"
	<pmeerw@pmeerw.net>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 3/3] staging: iio: ad7780: remove unnecessary stashed
 voltage value
Date: Thu, 1 Nov 2018 15:28:19 +0000
Message-ID: <8e33078437ba3153305c5d31aba54412a786a9bb.camel@analog.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
	 <d6b6aeda46121f59a53b43599bf0200580d7a79d.1541082656.git.renatogeh@gmail.com>
In-Reply-To: <d6b6aeda46121f59a53b43599bf0200580d7a79d.1541082656.git.renatogeh@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

T24gVGh1LCAyMDE4LTExLTAxIGF0IDExOjQzIC0wMzAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gVGhpcyBwYXRjaCByZW1vdmVzIHRoZSB1bm5lY2Vzc2FyeSBmaWVsZCBpbnRfdnJlZl9tdiBp
biBhZDc3ODBfc3RhdGUNCj4gcmVmZXJyaW5nIHRvIHRoZSBkZXZpY2UncyB2b2x0YWdlLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUmVuYXRvIEx1aSBHZWggPHJlbmF0b2dlaEBnbWFpbC5jb20+DQo+
IC0tLQ0KPiBDaGFuZ2VzIGluIHYzOg0KPiAJLSByZW1vdmVkIHVubmVjZXNzYXJ5IGludF92cmVm
X212IGZyb20gYWQ3NzgwX3N0YXRlDQo+IA0KPiAgZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3
NzgwLmMgfCA1ICstLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDQgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3
NzgwLmMNCj4gYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBpbmRleCBmMmEx
MWU5NDI0Y2QuLmYyNTAzNzBlZmNmNyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9zdGFnaW5nL2lp
by9hZGMvYWQ3NzgwLmMNCj4gKysrIGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMN
Cj4gQEAgLTQyLDcgKzQyLDYgQEAgc3RydWN0IGFkNzc4MF9zdGF0ZSB7DQo+ICAJc3RydWN0IHJl
Z3VsYXRvcgkJKnJlZzsNCj4gIAlzdHJ1Y3QgZ3Bpb19kZXNjCQkqcG93ZXJkb3duX2dwaW87DQo+
ICAJdW5zaWduZWQgaW50CWdhaW47DQo+IC0JdTE2CQkJCWludF92cmVmX212Ow0KPiAgDQo+ICAJ
c3RydWN0IGFkX3NpZ21hX2RlbHRhIHNkOw0KPiAgfTsNCj4gQEAgLTE5MCw5ICsxODksNyBAQCBz
dGF0aWMgaW50IGFkNzc4MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAgCXN0LT5j
aGlwX2luZm8gPQ0KPiAgCQkmYWQ3NzgwX2NoaXBfaW5mb190Ymxbc3BpX2dldF9kZXZpY2VfaWQo
c3BpKS0+ZHJpdmVyX2RhdGFdOw0KPiAgDQo+IC0JaWYgKHZvbHRhZ2VfdXYpDQo+IC0JCXN0LT5p
bnRfdnJlZl9tdiA9IHZvbHRhZ2VfdXYgLyAxMDAwOw0KPiAtCWVsc2UNCj4gKwlpZiAoIXZvbHRh
Z2VfdXYpDQo+ICAJCWRldl93YXJuKCZzcGktPmRldiwgIlJlZmVyZW5jZSB2b2x0YWdlIHVuc3Bl
Y2lmaWVkXG4iKTsNCg0KSSB0aGluayB5b3UgY291bGQgcmVtb3ZlIHRoaXMgYWx0b2dldGhlciwg
YW5kIGFsc28gcmVtb3ZlIHRoZSBlbnRpcmUNCmB2b2x0YWdlX3V2ID0gcmVndWxhdG9yX2dldF92
b2x0YWdlKHN0LT5yZWcpO2AgYXNzaWdubWVudC4NCg0KSXQgZG9lc24ndCBtYWtlIG11Y2ggc2Vu
c2UgdG8gcmVhZCB0aGUgdm9sdGFnZSBoZXJlLCBzaW5jZSBpdCB3b24ndCBiZSB1c2VkDQppbiB0
aGUgcHJvYmUgcGFydCBhbnltb3JlLg0KDQo+ICANCj4gIAlzcGlfc2V0X2RydmRhdGEoc3BpLCBp
bmRpb19kZXYpOw0K
