Return-Path: <SRS0=Z5pt=N6=analog.com=alexandru.Ardelean@kernel.org>
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>, "robh+dt@kernel.org"
	<robh+dt@kernel.org>, "knaack.h@gmx.de" <knaack.h@gmx.de>, "jic23@kernel.org"
	<jic23@kernel.org>, "Hennerich, Michael" <Michael.Hennerich@analog.com>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "matheus.bernardino@usp.br"
	<matheus.bernardino@usp.br>, "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "victorcolombo@gmail.com" <victorcolombo@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] staging:iio:ad2s90: Add device tree support
Date: Mon, 19 Nov 2018 08:09:21 +0000
Message-ID: <f250fa3a01b51d59979e7a2e3e42cc34d02aa52e.camel@analog.com>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
	 <20181118042540.12697-2-matheus.bernardino@usp.br>
In-Reply-To: <20181118042540.12697-2-matheus.bernardino@usp.br>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

T24gU3VuLCAyMDE4LTExLTE4IGF0IDAyOjI1IC0wMjAwLCBNYXRoZXVzIFRhdmFyZXMgd3JvdGU6
DQo+IFRoaXMgcGF0Y2ggYWRkcyBkZXZpY2UgdHJlZSBzdXBwb3J0IHRvIGFkMnM5MCB3aXRoIHN0
YW5kYXJkDQo+IGRldmljZSB0cmVlIGlkIHRhYmxlLg0KPiANCg0KSGV5LA0KDQpDb21tZW50IGlu
bGluZQ0KDQo+IFNpZ25lZC1vZmYtYnk6IE1hdGhldXMgVGF2YXJlcyA8bWF0aGV1cy5iZXJuYXJk
aW5vQHVzcC5icj4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6DQo+ICAtIG5vbmUNCj4gDQo+ICBk
cml2ZXJzL3N0YWdpbmcvaWlvL3Jlc29sdmVyL2FkMnM5MC5jIHwgNyArKysrKysrDQo+ICAxIGZp
bGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9z
dGFnaW5nL2lpby9yZXNvbHZlci9hZDJzOTAuYw0KPiBiL2RyaXZlcnMvc3RhZ2luZy9paW8vcmVz
b2x2ZXIvYWQyczkwLmMNCj4gaW5kZXggM2UyNTdhYzQ2ZjdhLi42ZmZiYWM2NmI4MzcgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vcmVzb2x2ZXIvYWQyczkwLmMNCj4gKysrIGIv
ZHJpdmVycy9zdGFnaW5nL2lpby9yZXNvbHZlci9hZDJzOTAuYw0KPiBAQCAtMTA3LDYgKzEwNywx
MiBAQCBzdGF0aWMgaW50IGFkMnM5MF9wcm9iZShzdHJ1Y3Qgc3BpX2RldmljZSAqc3BpKQ0KPiAg
CXJldHVybiBkZXZtX2lpb19kZXZpY2VfcmVnaXN0ZXIoaW5kaW9fZGV2LT5kZXYucGFyZW50LCBp
bmRpb19kZXYpOw0KPiAgfQ0KPiAgDQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBhZDJzOTBfb2ZfbWF0Y2hbXSA9IHsNCj4gKwl7IC5jb21wYXRpYmxlID0gImFkaSxhZDJzOTAi
LCB9LA0KPiArCXt9DQo+ICt9Ow0KPiArTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYWQyczkwX29m
X21hdGNoKTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIGFkMnM5
MF9pZFtdID0gew0KPiAgCXsgImFkMnM5MCIgfSwNCj4gIAl7fQ0KPiBAQCAtMTE2LDYgKzEyMiw3
IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUoc3BpLCBhZDJzOTBfaWQpOw0KPiAgc3RhdGljIHN0cnVj
dCBzcGlfZHJpdmVyIGFkMnM5MF9kcml2ZXIgPSB7DQo+ICAJLmRyaXZlciA9IHsNCj4gIAkJLm5h
bWUgPSAiYWQyczkwIiwNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKGFkMnM5
MF9vZl9tYXRjaCksDQoNCkkgdGhpbmsgeW91IG5lZWQgdG8gcmVtb3ZlIHRoZSBvZl9tYXRjaF9w
dHIoKS4NClRoZXJlIHdhcyBhIGNvbW1lbnQgZnJvbSBKb25hdGhhbiBvbiBhbm90aGVyIHRocmVh
ZCBhYm91dCB0aGlzLg0KU2VlOg0KICAgaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRj
aC8xMDY4Mjk2My8NCg0KU28sIA0KKwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRyKGFk
MnM5MF9vZl9tYXRjaCksDQoNCmJlY29tZXMNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gYWQyczkw
X29mX21hdGNoLA0KDQo+ICAJfSwNCj4gIAkucHJvYmUgPSBhZDJzOTBfcHJvYmUsDQo+ICAJLmlk
X3RhYmxlID0gYWQyczkwX2lkLA0K
