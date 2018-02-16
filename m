Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr10042.outbound.protection.outlook.com ([40.107.1.42]:47788
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967661AbeBPM4k (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Feb 2018 07:56:40 -0500
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>
Subject: Re: [PATCH] staging: iio/meter: add name to function definition
 arguments
Date: Fri, 16 Feb 2018 12:56:36 +0000
Message-ID: <1518785796.9517.25.camel@nxp.com>
References: <20180216125041.qfvg7xtpulc54tk6@smtp.gmail.com>
In-Reply-To: <20180216125041.qfvg7xtpulc54tk6@smtp.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SGkgUm9kcmlnbywNCg0KSSB0aGluayB0aGlzIGlzIGEgbmljZSBmaW5kaW5nLiBPbmUgY29tbWVu
dCBpbmxpbmU6DQoNCk9uIFZpLCAyMDE4LTAyLTE2IGF0IDEwOjUwIC0wMjAwLCByb2RyaWdvc2lx
dWVpcmEgd3JvdGU6DQo+IFRoaXMgcGF0Y2ggZml4ZXMgdGhlIGNoZWNrcGF0Y2gucGwgd2Fybmlu
ZzoNCj4gDQo+IGRyaXZlcnMvc3RhZ2luZy9paW8vbWV0ZXIvYWRlNzg1NC5oOjE1NzogV0FSTklO
RzogZnVuY3Rpb24gZGVmaW5pdGlvbg0KPiBhcmd1bWVudCAnc3RydWN0IGRldmljZSAqJyBzaG91
bGQgYWxzbyBoYXZlIGFuIGlkZW50aWZpZXIgbmFtZS4uLg0KPsKgDQo+ICsJaW50ICgqcmVhZF9y
ZWdfMzIpKHN0cnVjdCBkZXZpY2UgKmRldiwgdTE2IHJlZ19hZGRyZXNzLCB1MzIgKnZhbCk7DQo+
ICsJaW50ICgqd3JpdGVfcmVnXzgpKHN0cnVjdCBkZXZpY2UgKmRldiwgdTE2IHJlZ19hZGRyZXNz
LCB1OCB2YWx1ZSk7DQoNCg0KQW55IHBhcnRpY3VsYXIgcmVhc29uIGZvciB1c2luZyB2YWwgdnMg
dmFsdWU/IEkgZ2V0IHRoYXQgb25lIGlzIGEgcG9pbnRlcg0KYW5kIGFub3RoZXIgYSBwbGFpbiB0
eXBlLCBidXQgSSB0aGluayB0aGUgbmFtZSBzaG91bGQgYmUgdGhlIHNhbWUuDQoNCnRoYW5rcywN
CkRhbmllbC4NCg0K
