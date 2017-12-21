Return-Path: <SRS0=EQoT=DR=ACULAB.COM=David.Laight@kernel.org>
From: David Laight <David.Laight@ACULAB.COM>
To: 'Crt Mori' <cmo@melexis.com>
CC: Peter Zijlstra <peterz@infradead.org>, Jonathan Cameron
	<jic23@kernel.org>, Ingo Molnar <mingo@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Kees Cook <keescook@chromium.org>, Rusty Russell
	<rusty@rustcorp.com.au>, Ian Abbott <abbotti@mev.co.uk>, Larry Finger
	<Larry.Finger@lwfinger.net>, Niklas Soderlund
	<niklas.soderlund+renesas@ragnatech.se>, Thomas Gleixner
	<tglx@linutronix.de>, Krzysztof Kozlowski <krzk@kernel.org>, Masahiro Yamada
	<yamada.masahiro@socionext.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, Joe Perches <joe@perches.com>
Subject: RE: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
Date: Thu, 21 Dec 2017 10:59:19 +0000
Message-ID: <d595eac5b5744a3a96cda44d96b08b53@AcuMS.aculab.com>
References: <20171220142001.18161-1-cmo@melexis.com>
 <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
 <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
 <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
 <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com>
 <CAKv63utKNW2--ZnkoJ0z++68764cX_S9xS9Gst_vj7eDsFAZrg@mail.gmail.com>
In-Reply-To: <CAKv63utKNW2--ZnkoJ0z++68764cX_S9xS9Gst_vj7eDsFAZrg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

RnJvbTogQ3J0IE1vcmkNCj4gU2VudDogMjAgRGVjZW1iZXIgMjAxNyAxNzozMA0KPiA+PiBPSywg
aXMgdGhlcmUgYW55IG1vcmUgZWFzeSBvcHRpbWl6YXRpb25zIHlvdSBzZWU/DQo+ID4NCj4gPiBJ
IHRoaW5rIHRoaXMgdmVyc2lvbiB3b3Jrcy4NCj4gPiBJdCBkb2Vzbid0IGhhdmUgdGhlIG9wdGlt
aXNhdGlvbiBmb3Igc21hbGwgdmFsdWVzLg0KPiA+DQo+ID4gdW5zaWduZWQgaW50IHNxcnQ2NCh1
bnNpZ25lZCBsb25nIGxvbmcgeCkNCj4gPiB7DQo+ID4gICAgICAgICB1bnNpZ25lZCBpbnQgeF9o
aSA9IHggPj4gMzI7DQo+ID4NCj4gPiAgICAgICAgIHVuc2lnbmVkIGludCBiID0gMDsNCj4gPiAg
ICAgICAgIHVuc2lnbmVkIGludCB5ID0gMDsNCj4gPiAgICAgICAgIHVuc2lnbmVkIGludCBpOw0K
PiA+DQo+ID4gICAgICAgICBmb3IgKGkgPSAwOyBpIDwgMzI7IGkrKykgew0KPiA+ICAgICAgICAg
ICAgICAgICBiIDw8PSAyOw0KPiA+ICAgICAgICAgICAgICAgICBiIHw9IHhfaGkgPj4gMzA7DQo+
ID4gICAgICAgICAgICAgICAgIHhfaGkgPDw9IDI7DQo+ID4gICAgICAgICAgICAgICAgIGlmIChp
ID09IDE1KQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHhfaGkgPSB4Ow0KPiA+ICAgICAg
ICAgICAgICAgICB5IDw8PSAxOw0KPiA+ICAgICAgICAgICAgICAgICBpZiAoYiA+IHkpDQo+ID4g
ICAgICAgICAgICAgICAgICAgICAgICAgYiAtPSArK3k7DQo+ID4gICAgICAgICB9DQo+ID4gICAg
ICAgICByZXR1cm4geTsNCj4gPiB9DQouLg0KPiANCj4gSSBkaWQgYSBxdWljayBydW4gdGhyb3Vn
aCB1bml0IHRlc3RzIGZvciB0aGUgc2Vuc29yIGFuZCB0aGUgcmVzdWx0cw0KPiBhcmUgd2F5IG9m
Zi4gT24gdGhlIHNlbnNvciBJIGhhZCB0byBjb252ZXJ0IGRvdWJsZSBjYWxjdWxhdGlvbnMgdG8N
Cj4gaW50ZWdlciBjYWxjdWxhdGlvbnMgYW5kIHRhcmdldCB3YXMgdG8gZ2V0IGVuZCByZXN1bHQg
d2l0aGluIDAuMDIgZGVnQw0KPiAod2l0aCBwcmV2aW91cyBhcHByb3hpbWF0ZSBzcXJ0IGltcGxl
bWVudGF0aW9uKSBpbiBzZW5zb3Igd29ya2luZw0KPiByYW5nZS4gVGhpcyBub3cgZ2V0cyBpbnRv
IDMgZGVnQyBkZWx0YSBhdCBsZWFzdCBhbmQgc29tZSBhcmUgd2F5IG9mZi4NCj4gSXQgbWlnaHQg
YmUgb2ZmIGJlY2F1c2Ugb2Ygc29tZSBzY2FsaW5nIG9uIHRoZSBvdGhlciBoYW5kIGR1cmluZyB0
aGUNCj4gZXF1YXRpb24gKG5vdCBleGFjdGx5IGNvbXBhcmluZyBzcXJ0IGltcGxlbWVudGF0aW9u
cyBoZXJlKS4NCg0KSSBkaWRuJ3QgZ2V0IGl0IHF1aXRlIHJpZ2h0Li4uDQpUaGUgbGFzdCBmZXcg
bGluZXMgbmVlZCB0byBiZToNCgkJaWYgKGIgPiB5KSB7CQ0KCQkJYiAtPSArK3k7DQoJCQl5Kys7
DQoJCX0NCgl9DQoJcmV0dXJuIHkgPj4gMTsNCn0NCg0KQWx0aG91Z2ggdGhhdCB0aGVuIGZhaWxz
IGZvciBpbnB1dHMgbGFyZ2VyIHRoYW4gMl42Mi4NCg0KCURhdmlkDQoNCgkNCg==
