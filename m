Return-Path: <SRS0=YFRY=DQ=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Crt Mori' <cmo@melexis.com>, Peter Zijlstra <peterz@infradead.org>
CC: Jonathan Cameron <jic23@kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>,
	Rusty Russell <rusty@rustcorp.com.au>, Ian Abbott <abbotti@mev.co.uk>, "Larry
 Finger" <Larry.Finger@lwfinger.net>, Niklas Soderlund
	<niklas.soderlund+renesas@ragnatech.se>, Thomas Gleixner
	<tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada
	<yamada.masahiro@socionext.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Joe Perches <joe@perches.com>
Subject: RE: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
Date: Wed, 20 Dec 2017 16:46:25 +0000
Message-ID: <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com>
References: <20171220142001.18161-1-cmo@melexis.com>
 <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
 <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
 <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
In-Reply-To: <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

RnJvbTogQ3J0IE1vcmkNCj4gU2VudDogMjAgRGVjZW1iZXIgMjAxNyAxNjoxNw0KPiANCj4gT24g
MjAgRGVjZW1iZXIgMjAxNyBhdCAxNzowMCwgUGV0ZXIgWmlqbHN0cmEgPHBldGVyekBpbmZyYWRl
YWQub3JnPiB3cm90ZToNCj4gPiBPbiBXZWQsIERlYyAyMCwgMjAxNyBhdCAwMjozOToyNlBNICsw
MDAwLCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4NCj4gPj4gV2l0aCBtaW5vciBjaGFuZ2VzIGl0
IG91Z2h0IHRvIGJlIHBvc3NpYmxlIHRvIHJlbW92ZSBtb3N0IG9mIHRoZQ0KPiA+PiA2NGJpdCBh
cml0aG1ldGljIGFuZCBzaGlmdHMuDQo+ID4+DQo+ID4+IElmIHlvdSBjYXJlIGFib3V0IHBlcmZv
cm1hbmNlIHRoZW4gdXNpbmcgMzIgYml0IG1hdGhzIHdpbGwgYmUgbXVjaCBmYXN0ZXIuDQo+ID4N
Cj4gPiBTb21lLCB1NjQgYWRkL3N1Yi9zaGlmdCBpc24ndCBleGFjdGx5IGV4cGVuc2l2ZSwgYnV0
IHllcywgSSBhbHNvDQo+ID4gaW5kaWNhdGVkIHRoYXQgaW1wcm92ZW1lbnQgaXMgcG9zc2libGUu
IEF0IHRoZSB2ZXJ5IGxlYXN0IHkgY2FuIGJlIG1hZGUNCj4gPiBhIHUzMiBJIHN1cHBvc2UuDQo+
IA0KPiBPSywgaXMgdGhlcmUgYW55IG1vcmUgZWFzeSBvcHRpbWl6YXRpb25zIHlvdSBzZWU/DQoN
CkkgdGhpbmsgdGhpcyB2ZXJzaW9uIHdvcmtzLg0KSXQgZG9lc24ndCBoYXZlIHRoZSBvcHRpbWlz
YXRpb24gZm9yIHNtYWxsIHZhbHVlcy4NCg0KdW5zaWduZWQgaW50IHNxcnQ2NCh1bnNpZ25lZCBs
b25nIGxvbmcgeCkNCnsNCiAgICAgICAgdW5zaWduZWQgaW50IHhfaGkgPSB4ID4+IDMyOw0KDQog
ICAgICAgIHVuc2lnbmVkIGludCBiID0gMDsNCiAgICAgICAgdW5zaWduZWQgaW50IHkgPSAwOw0K
ICAgICAgICB1bnNpZ25lZCBpbnQgaTsNCg0KICAgICAgICBmb3IgKGkgPSAwOyBpIDwgMzI7IGkr
Kykgew0KICAgICAgICAgICAgICAgIGIgPDw9IDI7DQogICAgICAgICAgICAgICAgYiB8PSB4X2hp
ID4+IDMwOw0KICAgICAgICAgICAgICAgIHhfaGkgPDw9IDI7DQogICAgICAgICAgICAgICAgaWYg
KGkgPT0gMTUpDQogICAgICAgICAgICAgICAgICAgICAgICB4X2hpID0geDsNCiAgICAgICAgICAg
ICAgICB5IDw8PSAxOw0KICAgICAgICAgICAgICAgIGlmIChiID4geSkNCiAgICAgICAgICAgICAg
ICAgICAgICAgIGIgLT0gKyt5Ow0KICAgICAgICB9DQogICAgICAgIHJldHVybiB5Ow0KfQ0KDQpQ
dXQgaXQgdGhyb3VnaCBjYyAtTzMgLW0zMiAtYyAtbyBzcXJ0NjQubyBzcXJ0NjQuYyBhbmQgdGhl
biBvYmpkdW1wIHNxcnQ2NC5vDQphbmQgY29tcGFyZSB0byB0aGF0IG9mIHlvdXIgdmVyc2lvbi4N
Cg0KCURhdmlkDQoNCg==
