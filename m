Return-Path: <Robin.Getz@analog.com>
From: "Getz, Robin" <Robin.Getz@analog.com>
To: Lee Jones <lee.jones@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
	"arnd@arndb.de" <arnd@arndb.de>, "linus.walleij@linaro.org"
	<linus.walleij@linaro.org>, "denis.ciocca@st.com" <denis.ciocca@st.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH 27/38] iio: pressure-core: st: Give some indication if
 device probing was successful
Date: Fri, 13 Sep 2013 20:57:51 +0000
Message-ID: <FEAE1C531EE4684EBDD22603EC8BE59931CAB11B@NWD2MBX7.ad.analog.com>
References: <1378817379-8238-1-git-send-email-lee.jones@linaro.org>
 <1378817379-8238-28-git-send-email-lee.jones@linaro.org>
 <43055af7-991f-4122-b308-a3dcddbbb72a@email.android.com>
 <20130911071053.GD11227@lee--X1> <52301963.5030006@metafoo.de>
 <20130911072955.GG11227@lee--X1>
In-Reply-To: <20130911072955.GG11227@lee--X1>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

T24gV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTEsIDIwMTMgMzozMCBBTSBMZWUgSm9uZXMgd3JvdGU6
DQo+IE9uIFdlZCwgMTEgU2VwIDIwMTMsIExhcnMtUGV0ZXIgQ2xhdXNlbiB3cm90ZToNCj4gPiBP
biAwOS8xMS8yMDEzIDA5OjEwIEFNLCBMZWUgSm9uZXMgd3JvdGU6DQo+ID4gPk9uIFR1ZSwgMTAg
U2VwIDIwMTMsIEpvbmF0aGFuIENhbWVyb24gd3JvdGU6DQo+ID4gPj5MZWUgSm9uZXMgPGxlZS5q
b25lc0BsaW5hcm8ub3JnPiB3cm90ZToNCj4gPiBTaWxlbmNlIG1lYW5zIGV2ZXJ5dGhpbmcgaXMg
Z29vZCwgYSBtZXNzYWdlIG1lYW5zIHRoZXJlIGlzIGFuIGVycm9yLg0KPiA+IElmIGV2ZXJ5IGRl
dmljZSB0aGF0IGdldHMgcHJvYmVkIHdvdWxkIHNwaXQgb3V0IGEgbWVzc2FnZSB0aGUgbG9nDQo+
ID4gd291bGQgYmUgc2Nyb2xsaW5nIGZvcmV2ZXIgYW5kIHlvdSB3b3VsZG4ndCBiZSBhYmxlIHRv
IHNlZSB0aGUgZXJyb3INCj4gPiBtZXNzYWdlcy4NCj4gDQo+IE9ubHkgaWYgeW91IHByaW50IG91
dCBldmVyeSByZWd1bGF0b3IsIGNsb2NrLCBHUElPIHBpbiBhbmQgdGhpbmdzIG9mIHRoaXMgbmF0
dXJlLg0KPiBLZXkgaGFyZHdhcmUgYmxvY2tzIHN1Y2ggYXM7IFNELCBGbGFzaCwgVVNCLCBFdGgs
IEhETUksIEF1ZGlvLCBVQVJULCBHUElPIGFuZA0KPiBJMkMgY29udHJvbGxlcnMgYW5kIFNlbnNv
cnMgSSB0aGluayBkZXNlcnZlIGEgb25lIGxpbmUgIkknbSBoZXJlIGFuZCB3b3JraW5nIg0KPiBt
ZXNzYWdlLg0KDQpJbiBtYW55IGVtYmVkZGVkIHN5c3RlbXMgLS0gdGhlcmUgYXJlIGxvdHMgYW5k
IGxvdHMgb2YgSUlPIGRldmljZXMsIGFuZCBJJ20gbm90IHN1cmUgDQpJIHdvdWxkIGNvbnNpZGVy
IHZlcnkgbWFueSAia2V5Ii4gSXQgcmVhbGx5IGRlcGVuZHMgb24gdGhlIGJvYXJkLg0KDQpUbyBt
ZSBpdCdzIGEgbWF0dGVyIG9mIGJvb3QgdGltZS4gRXZlbiBtZW1jcHkgdG8gbXNnYnVmIHRha2Vz
IHRpbWUuDQpTb21ldGltZXMgdW5uZWNlc3NhcnkgdGltZS4NCg0KPiBJJ2xsIG5vdCBmaWdodCB0
aGlzIGZvciB0b28gbG9uZy4gVGhpcyBpcyBiYXNlZCBteSBleHBlcmllbmNlIGFzIGEgdXNlci4g
SSB0cmllZCB0bw0KPiBsb29rIGF0IHRoZSBib290bG9nIGZvciB0aGUgc2Vuc29ycyBJJ2QganVz
dCBlbmFibGVkIGFuZCB0aGVyZSB3YXMgbm90aGluZy4gU29tZQ0KPiBvZiB0aGVtIGhhZCBwcm9i
ZWQsIHNvbWUgaGFkbid0IGFuZCB0aGVyZSB3YXMgbm8gY2xlYXIgd2F5IHRvIGRpc3Rpbmd1aXNo
DQo+IGJldHdlZW4gdGhlbSB3aXRob3V0IGRpZ2dpbmcgaW50byBzeXNmcy4NCg0KZWNobyAid29y
a2luZzoiDQpjYXQgL3N5cy9idXMvaWlvL2RldmljZXMvKi9uYW1lDQoNCmlzbid0IHRvbyBtdWNo
IGRpZ2dpbmcuIElmIHlvdSByZWFsbHkgd2FudCB0byBkbyB0aGF0IG9uIHlvdXIgbWFjaGluZSAt
IGRvIHNvIGluIHJjLmxvY2FsDQoNCmZvciBtYW55IG90aGVyIHN1YnN5c3RlbXMsIGl0J3MganVz
dCBub3QgdGhhdCBlYXN5LCBhbmQgcHJpbnRpbmcgZnJvbSB0aGUgZHJpdmVyIGlzIG5lY2Vzc2Fy
eS4NCg0KLVJvYmluDQo=
