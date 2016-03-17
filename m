Return-Path: <lucas.demarchi@intel.com>
From: "De Marchi, Lucas" <lucas.demarchi@intel.com>
To: "Baluta, Daniel" <daniel.baluta@intel.com>, "mranostay@gmail.com"
	<mranostay@gmail.com>, "GGao@invensense.com" <GGao@invensense.com>
CC: "lars@metafoo.de" <lars@metafoo.de>, "knaack.h@gmx.de" <knaack.h@gmx.de>,
	"jic23@kernel.org" <jic23@kernel.org>, "cmo@melexis.com" <cmo@melexis.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "adi.reus@gmail.com"
	<adi.reus@gmail.com>, "srinivas.pandruvada@linux.intel.com"
	<srinivas.pandruvada@linux.intel.com>, "pmeerw@pmeerw.net"
	<pmeerw@pmeerw.net>, "Ranostay, Matt" <matt.ranostay@intel.com>
Subject: Re: [PATCH 3/3] iio: imu: mpu6050: Add support for auxiliary I2C
 master
Date: Thu, 17 Mar 2016 21:15:39 +0000
Message-ID: <1458249337.3601.18.camel@intel.com>
References: <1458232366-12773-1-git-send-email-daniel.baluta@intel.com>
	 <1458232366-12773-4-git-send-email-daniel.baluta@intel.com>
	 <CAKzfze-ZqYC0xaWj9K0GRfEECvSQeZddPviOc=iDDHfwoU1PnQ@mail.gmail.com>
	 <DM3PR1201MB10729BD22D8500F45BE0E2B3AF8B0@DM3PR1201MB1072.namprd12.prod.outlook.com>
In-Reply-To: <DM3PR1201MB10729BD22D8500F45BE0E2B3AF8B0@DM3PR1201MB1072.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

SGksDQoNCk9uIFRodSwgMjAxNi0wMy0xNyBhdCAxODoxMSArMDAwMCwgR2UgR2FvIHdyb3RlOg0K
PiBIaSBNYXR0LA0KPiAJSSBhbSBub3Qgc3VyZSBhYm91dCBzbGF2ZSA0LiBJIGFsd2F5cyB1c2Ug
c2xhdmUwfjMuIE1QVTYwNTAgY2FuDQo+IGNvbm5lY3QgdXAgdG8gNCBzbGF2ZXMgYnkgdXNpbmcg
c2xhdmUgMH4zLiBIb3dldmVyLCB3ZSBvbmx5IHVzZSAzIHNsYXZlcy4NCj4gRWFjaCBzbGF2ZSBj
YW4gYmUgY29uZmlndXJlZCBhcyByZWFkIG9yIHdyaXRlIGluZGVwZW5kZW50bHkuIEZvciBleGFt
cGxlLA0KPiBBS004OTczIGNvbXBhc3MgYXMgYSBzbGF2ZSwgSSB1c3VhbGx5IGNvbmZpZ3VyZSBz
bGF2ZTAgYXMgcmVhZCBhbmQgc2xhdmUgMSANCg0KSSBhbHNvIHVzdWFsbHkgdXNlIHNsYXZlcyAw
fjMuIEhvd2V2ZXIgbm93IHlvdSBtZW50aW9uIGl0IGFzIGJlaW5nIDEwMEh6Li4uDQpkb2Vzbid0
IHRoaXMgZGVwZW5kIG9uIGEpIHRoZSByYXRlIGNvbmZpZ3VyZWQgaW4gTVBVIGFuZCBiKSB0aGUg
cGFydCBpdHNlbGYNCihNUFU5MjUwIGhhcyBhIGRpZmZlcmVudCBpbnRlcm5hbCBzYW1wbGluZyBy
YXRlKT8NCg0KPiAJRm9yIHByZXNzdXJlIHNlbnNvciBvciBBTFMobGlnaHQvcHJveGltaXR5IHNl
bnNvciksIHRoZXkgYWxsIGhhdmUNCj4gYXV0b25vbW91cyBtb2RlLiBBcyBsb25nIGFzIHRoZSBz
YW1wbGUgcGVyaW9kIGlzIGxvbmdlciB0aGFuIHRoZSBvdXRwdXQNCj4gcmF0ZSwgdGhlIGRhdGEg
aXMgZ3VhcmFudGVlZCB0byBiZSBuZXcgZGF0YS4NCg0KSSB0aGluayBoaXMgdXNlIG9mIHNsYXZl
NCBpcyBtb3N0bHkgYmVjYXVzZSBvZiB0aGUgaW50ZXJydXB0IHRoYXQgaXMgYXZhaWxhYmUuDQpE
ZXBlbmRpbmcgb24gdGhlIHNlbnNvciB5b3UgYXJlIGNvbm5lY3RpbmcsIHRoZSBzYW1wbGUgcmF0
ZXMgbm90IG1hdGNoaW5nIG1heQ0KYmUgYSBwcm9ibGVtLg0KDQpTdXBwb3NlIHlvdXIgc2Vuc29y
IGlzIGdpdmluZyB5b3UgZGF0YSBhdCAxMjVIei4gVGhpcyBtZWFucyBldmVyeSB+NCBzYW1wbGVz
IHlvdSB3aWxsIGxvb3NlIG9uZSBzYW1wbGUuIMKgVGhlIG90aGVyIGNhc2Ugb2Ygc2Vuc29yIHdp
dGggdXBkYXRlIGF0IDc1SHogaXMgYWxzbyBwcm9ibGVtYXRpYyBzaW5jZSB5b3UgbWF5IGdldCBv
bGQgZGF0YSAtIGFuZCBkZXBlbmRpbmcgb24gdGhlIHNlbnNvciB5b3UgZG9uJ3QgaGF2ZSBhIHdh
eSB0byBrbm93IGlmIHRoZSBkYXRhIGlzIGludmFsaWQuDQoNCldoYXQgYW0gSSBtaXNzaW5nPw0K
DQoNCnRoYW5rcw0KDQpMdWNhcyBEZSBNYXJjaGk=
