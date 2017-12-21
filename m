Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out6.electric.net ([192.162.217.185]:50644 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751867AbdLULmn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 Dec 2017 06:42:43 -0500
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
Date: Thu, 21 Dec 2017 11:43:00 +0000
Message-ID: <95b9b2b52554410a85a9f10c7f5e8b13@AcuMS.aculab.com>
References: <20171220142001.18161-1-cmo@melexis.com>
 <1c1d0ffa8ee140bf9adbc78f1559b1e8@AcuMS.aculab.com>
 <20171220160001.manjff26gfbjccsw@hirez.programming.kicks-ass.net>
 <CAKv63uuL9+xzF7KruhYwSY68-M0=aJSvJOr5Y0vVBiX8ebqfeg@mail.gmail.com>
 <c3462afd27d14c8684ee33ef6623a31a@AcuMS.aculab.com>
 <CAKv63utKNW2--ZnkoJ0z++68764cX_S9xS9Gst_vj7eDsFAZrg@mail.gmail.com>
In-Reply-To: <CAKv63utKNW2--ZnkoJ0z++68764cX_S9xS9Gst_vj7eDsFAZrg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

RnJvbTogQ3J0IE1vcmkNCj4gU2VudDogMjAgRGVjZW1iZXIgMjAxNyAxNzozMA0KPiBJIGRpZCBh
IHF1aWNrIHJ1biB0aHJvdWdoIHVuaXQgdGVzdHMgZm9yIHRoZSBzZW5zb3IgYW5kIHRoZSByZXN1
bHRzDQo+IGFyZSB3YXkgb2ZmDQo+IC4uLg0KDQpUcnkgdGhpcyB2ZXJzaW9uIGluc3RlYWQ6DQp1
bnNpZ25lZCBpbnQgc3FydDY0KHVuc2lnbmVkIGxvbmcgbG9uZyB4X2luKQ0Kew0KICAgICAgICB1
bnNpZ25lZCBpbnQgeCA9IHhfaW4gPj4gMzI7DQoNCiAgICAgICAgdW5zaWduZWQgaW50IGIgPSAw
Ow0KICAgICAgICB1bnNpZ25lZCBpbnQgeSA9IDA7DQogICAgICAgIHVuc2lnbmVkIGludCBpOw0K
DQogICAgICAgIGkgPSAzMTsNCiAgICAgICAgaWYgKCF4KSB7DQogICAgICAgICAgICAgICAgeCA9
IHhfaW47DQogICAgICAgICAgICAgICAgaSA9IDE1Ow0KICAgICAgICB9DQogICAgICAgIGlmICgh
KHggJiAweGZmZmYwMDAwKSkgew0KICAgICAgICAgICAgICAgIHggPDw9IDE2Ow0KICAgICAgICAg
ICAgICAgIGkgLT0gODsNCiAgICAgICAgfQ0KICAgICAgICBpZiAoISh4ICYgMHhmZjAwMDAwMCkp
IHsNCiAgICAgICAgICAgICAgICB4IDw8PSA4Ow0KICAgICAgICAgICAgICAgIGkgLT0gNDsNCiAg
ICAgICAgfQ0KICAgICAgICBpZiAoISh4ICYgMHhmMDAwMDAwMCkpIHsNCiAgICAgICAgICAgICAg
ICB4IDw8PSA0Ow0KICAgICAgICAgICAgICAgIGkgLT0gMjsNCiAgICAgICAgfQ0KDQogICAgICAg
IGRvIHsNCiAgICAgICAgICAgICAgICBiIDw8PSAyOw0KICAgICAgICAgICAgICAgIGIgfD0geCA+
PiAzMDsNCiAgICAgICAgICAgICAgICB4IDw8PSAyOw0KICAgICAgICAgICAgICAgIGlmIChpID09
IDE2KQ0KICAgICAgICAgICAgICAgICAgICAgICAgeCA9IHhfaW47DQogICAgICAgICAgICAgICAg
eSA8PD0gMTsNCiAgICAgICAgICAgICAgICBpZiAoYiA+IHkpIHsNCiAgICAgICAgICAgICAgICAg
ICAgICAgIGIgLT0gKyt5Ow0KICAgICAgICAgICAgICAgICAgICAgICAgeSsrOw0KICAgICAgICAg
ICAgICAgIH0NCiAgICAgICAgfSB3aGlsZSAoLS1pKTsNCg0KICAgICAgICAvKiAnYicgYmVjb21l
cyAzMyBiaXRzIGlmIHRoZSBpbnB1dCBpcyBncmVhdGVyIHRoYW4gMl42MiAqLw0KICAgICAgICBi
IDw8PSAxOw0KICAgICAgICBiIHw9IHggPj4gMzE7DQogICAgICAgIGlmIChiID4geSB8fCAoYiA9
PSB5ICYmIHggJiAoMXUgPDwgMzApKSkNCiAgICAgICAgICAgICAgICB5IHw9IDE7DQoNCiAgICAg
ICAgcmV0dXJuIHk7DQp9DQoNCkkndmUgdGVzdGVkIHRoYXQgb25lIHdpdGggbW9yZSB2YWx1ZXMu
DQoNCglEYXZpZA0KDQo=
