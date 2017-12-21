Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out4.electric.net ([192.162.216.194]:64984 "EHLO
        smtp-out4.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752543AbdLUN4j (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Dec 2017 08:56:39 -0500
From: David Laight <David.Laight@ACULAB.COM>
To: 'Crt Mori' <cmo@melexis.com>
CC: Peter Zijlstra <peterz@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        Ian Abbott <abbotti@mev.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Niklas Soderlund <niklas.soderlund+renesas@ragnatech.se>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        Joe Perches <joe@perches.com>
Subject: RE: [PATCH v10 1/3] lib: Add strongly typed 64bit int_sqrt
Date: Thu, 21 Dec 2017 13:56:55 +0000
Message-ID: <b743750a1bd64ed2bf800cec9da9afff@AcuMS.aculab.com>
References: <20171220142001.18161-1-cmo@melexis.com>
 <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
 <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
 <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
 <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com>
 <CAKv63utKNW2--ZnkoJ0z++68764cX_S9xS9Gst_vj7eDsFAZrg@mail.gmail.com>
 <95b9b2b52554410a85a9f10c7f5e8b13@AcuMS.aculab.com>
 <CAKv63usT8GU-51AmMLJb3hD3CHxf1M5KTQvYhK+0UVMT13Nbag@mail.gmail.com>
In-Reply-To: <CAKv63usT8GU-51AmMLJb3hD3CHxf1M5KTQvYhK+0UVMT13Nbag@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

RnJvbTogQ3J0IE1vcmkNCj4gU2VudDogMjEgRGVjZW1iZXIgMjAxNyAxMzoxOA0KLi4uDQo+ID4g
ICAgICAgICB1bnNpZ25lZCBpbnQgaTsNCj4gDQo+IGkgY2FuIGJlIHU4LiBBbmQgSSB3aWxsIHN0
aWxsIHVzZSBleHBsaWNpdCB0eXBpbmcuDQoNCnU4IHdpbGwgYWRkIGV4dHJhIGNvZGUsIHVuc2ln
bmVkIGludCBpcyBnb29kLg0KJ3gnIG5lZWRzIHRvIGJlIHUzMiwgJ3knIGFuZCAnYicgY291bGQg
YmUgbGFyZ2VyLg0KDQpJIHdhcyB0ZXN0aW5nIGluIHVzZXJzcGFjZS4NCg0KLi4uDQo+IFRoaXMg
cGFydCBhYm92ZSBsb29rcyBsaWtlIEZMUw0KSXQgYWxzbyBkb2VzIHRoZSByZXN0IG9mIHRoZSBy
ZXF1aXJlZCBzaGlmdHMuDQoNCi4uLg0KPiBUaGlzIG9uZSBpbmRlZWQgd29ya3MuIEkgZGlkIHNv
bWUgbW9yZSB0ZXN0aW5nIHRoaXMgbW9ybmluZyBhbmQgSSBhbQ0KPiBmaW5lIHdpdGggZWl0aGVy
Lg0KPiANCj4gU28gcXVlc3Rpb24gaXM6IERvIEkgbWFrZSBjaGFuZ2UgYXMgcGVyIERhdmlkJ3Mg
c3VnZ2VzdGlvbiB3aXRoIGhpcw0KPiBzaWduLW9mZiwgb3IgbGVhdmUgdGhlIHZlcnNpb24gaXQg
d2FzIGJlZm9yZSB0aGUgY2hhbmdlPw0KDQpJZiB5b3UgZ2VuZXJhdGUgdGhlIGFjdHVhbCBwYXRj
aCBJIGNhbiBhZGQgYW4gYXBwcm9wcmlhdGUgc2lnbi1vZmYNCihvciB3aGF0ZXZlciBpcyBuZWVk
ZWQpLg0KDQoJRGF2aWQNCg0K
