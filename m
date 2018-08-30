Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from eu-smtp-delivery-211.mimecast.com ([207.82.80.211]:26631 "EHLO
        eu-smtp-delivery-211.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727117AbeH3Tgy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 30 Aug 2018 15:36:54 -0400
From: David Laight <David.Laight@ACULAB.COM>
To: 'Miguel Ojeda' <miguel.ojeda.sandonis@gmail.com>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
CC: Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Hartmut Knaack" <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "Jiri Slaby" <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Date: Thu, 30 Aug 2018 15:35:39 +0000
Message-ID: <34ad57ec954c481d87ef6af58453ee9f@AcuMS.aculab.com>
References: <20180820234341.5271-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-1-jmkrzyszt@gmail.com>
 <20180829204900.19390-2-jmkrzyszt@gmail.com>
 <CANiq72kJT15ELkYr2U5r4-pvGunQFLmZ5dhdZLnjmM7NWBnkNQ@mail.gmail.com>
In-Reply-To: <CANiq72kJT15ELkYr2U5r4-pvGunQFLmZ5dhdZLnjmM7NWBnkNQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

RnJvbTogTWlndWVsIE9qZWRhDQo+IFNlbnQ6IDMwIEF1Z3VzdCAyMDE4IDEyOjExDQouLi4NCj4g
PiArICAgICAgIHVuc2lnbmVkIGxvbmcgdmFsdWVfYml0bWFwWzFdOyAgLyogZm9yIERBVEFbMC03
XSwgUlMsIFJXICovDQo+IA0KPiAoSSByZWFkIHlvdXIgY29tbWVudHMgaW4gdGhlIG90aGVyIGVt
YWlsKQ0KPiANCj4gSSBzdGlsbCBmaW5kIHRoaXMgb2RkLCBidXQgaWYgZXZlcnlvbmUgaXMgZ29p
bmcgdG8gaGF2ZSB0aGlzIGNoYW5nZQ0KPiBkb25lIGxpa2UgdGhpcywgY29uc2lzdGVuY3kgaXMg
YmV0dGVyLg0KDQpNYXliZSB0aGVyZSBvdWdodCB0byBiZSBhIGRlZmluZSBzbyB5b3UgY2FuIGRv
Og0KCURFRklORV9CSVRNQVAodmFsdWVfYml0bWFwLCAzMik7DQoNCldoaWxlIGl0IG1pZ2h0IGp1
c3QgZ2VuZXJhdGUgYW4gdW5zaWduZWQgbG9uZyBbXSB0aGVyZSBpcyBwcm9iYWJseQ0Kc2NvcGUg
Zm9yIHN0cm9uZ2VyIHR5cGluZy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBM
YWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBU
LCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==
