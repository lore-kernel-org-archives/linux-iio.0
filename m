Return-Path: <SRS0=8Wyh=NR=analog.com=alexandru.Ardelean@kernel.org>
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
Subject: Re: [PATCH v4 1/2] staging: iio: ad7780: update voltage on read
Date: Tue, 6 Nov 2018 09:24:44 +0000
Message-ID: <30c1ff317baefde88a0f4d0a002b19010290d16b.camel@analog.com>
References: <cover.1541444377.git.renatogeh@gmail.com>
	 <4b47bd8f4bac2575b72529b37e5ac90bebae2446.1541444377.git.renatogeh@gmail.com>
In-Reply-To: <4b47bd8f4bac2575b72529b37e5ac90bebae2446.1541444377.git.renatogeh@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

T24gTW9uLCAyMDE4LTExLTA1IGF0IDE3OjE0IC0wMjAwLCBSZW5hdG8gTHVpIEdlaCB3cm90ZToN
Cj4gVGhlIGFkNzc4MCBkcml2ZXIgcHJldmlvdXNseSBkaWQgbm90IHJlYWQgdGhlIGNvcnJlY3Qg
ZGV2aWNlIG91dHB1dCwgYXMNCj4gaXQgcmVhZCBhbiBvdXRkYXRlZCB2YWx1ZSBzZXQgYXQgaW5p
dGlhbGl6YXRpb24uIEl0IG5vdyB1cGRhdGVzIGl0cw0KPiB2b2x0YWdlIG9uIHJlYWQuDQo+IA0K
DQpMb29rcyBnb29kIGZyb20gbXkgc2lkZS4NCg0KQWxleA0KDQo+IFNpZ25lZC1vZmYtYnk6IFJl
bmF0byBMdWkgR2VoIDxyZW5hdG9nZWhAZ21haWwuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBpbiB2
MzoNCj4gCS0gcmVtb3ZlZCBpbml0aWFsaXphdGlvbiAoaW50IHZvbHRhZ2VfdXYgPSAwKQ0KPiAJ
LSByZXR1cm5zIGVycm9yIHdoZW4gdm9sdGFnZV91diBpcyBudWxsDQo+IENoYW5nZXMgaW4gdjQ6
DQo+IAktIHJldHVybnMgZXJyb3Igd2hlbiB2b2x0YWdlX3V2IGlzIG5lZ2F0aXZlDQo+IA0KPiAg
ZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMgfCA2ICsrKysrLQ0KPiAgMSBmaWxlIGNo
YW5nZWQsIDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+IGIvZHJpdmVycy9zdGFnaW5nL2lp
by9hZGMvYWQ3NzgwLmMNCj4gaW5kZXggYjY3NDEyZGIwMzE4Li5jN2NiMDVjZWRiYmMgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+ICsrKyBiL2RyaXZl
cnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+IEBAIC04NywxMiArODcsMTYgQEAgc3RhdGlj
IGludCBhZDc3ODBfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwNCj4gIAkJCSAg
IGxvbmcgbSkNCj4gIHsNCj4gIAlzdHJ1Y3QgYWQ3NzgwX3N0YXRlICpzdCA9IGlpb19wcml2KGlu
ZGlvX2Rldik7DQo+ICsJaW50IHZvbHRhZ2VfdXY7DQo+ICANCj4gIAlzd2l0Y2ggKG0pIHsNCj4g
IAljYXNlIElJT19DSEFOX0lORk9fUkFXOg0KPiAgCQlyZXR1cm4gYWRfc2lnbWFfZGVsdGFfc2lu
Z2xlX2NvbnZlcnNpb24oaW5kaW9fZGV2LCBjaGFuLA0KPiB2YWwpOw0KPiAgCWNhc2UgSUlPX0NI
QU5fSU5GT19TQ0FMRToNCj4gLQkJKnZhbCA9IHN0LT5pbnRfdnJlZl9tdiAqIHN0LT5nYWluOw0K
PiArCQl2b2x0YWdlX3V2ID0gcmVndWxhdG9yX2dldF92b2x0YWdlKHN0LT5yZWcpOw0KPiArCQlp
ZiAodm9sdGFnZV91diA8IDApDQo+ICsJCQlyZXR1cm4gdm9sdGFnZV91djsNCj4gKwkJKnZhbCA9
ICh2b2x0YWdlX3V2IC8gMTAwMCkgKiBzdC0+Z2FpbjsNCj4gIAkJKnZhbDIgPSBjaGFuLT5zY2Fu
X3R5cGUucmVhbGJpdHMgLSAxOw0KPiAgCQlyZXR1cm4gSUlPX1ZBTF9GUkFDVElPTkFMX0xPRzI7
DQo+ICAJY2FzZSBJSU9fQ0hBTl9JTkZPX09GRlNFVDoNCg==
