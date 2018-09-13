Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bl2nam02on0042.outbound.protection.outlook.com ([104.47.38.42]:15706
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726308AbeIMNuB (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 13 Sep 2018 09:50:01 -0400
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "jic23@kernel.org" <jic23@kernel.org>
CC: "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH] staging:iio:ad7606: fix voltage scales
Date: Thu, 13 Sep 2018 08:41:27 +0000
Message-ID: <6a2ed577a24798468ea1308375ec96afcd3e7bf1.camel@analog.com>
References: <20180913073920.16089-1-alexandru.ardelean@analog.com>
In-Reply-To: <20180913073920.16089-1-alexandru.ardelean@analog.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE4LTA5LTEzIGF0IDEwOjM5ICswMzAwLCBBbGV4YW5kcnUgQXJkZWxlYW4gd3Jv
dGU6DQo+IEZpeGVzIGNvbW1pdCAxN2JlMmEyOTA1YTZlYzlhYTI3Y2Q1OTUyMTQ5NWUyZjQ5MGQy
YWYwICgic3RhZ2luZzogaWlvOg0KPiBhZDc2MDY6IHJlcGxhY2UgcmFuZ2UvcmFuZ2VfYXZhaWxh
YmxlIHdpdGggY29ycmVzcG9uZGluZyBzY2FsZSIpLg0KPiANCj4gVGhlIEFENzYwNiBkZXZpY2Vz
IGRvbid0IGhhdmUgYSAyLjVWIHZvbHRhZ2UgcmFuZ2UsIHRoZXkgaGF2ZSA1ViAmIDEwVg0KPiB2
b2x0YWdlIHJhbmdlLCB3aGljaCBpcyBzZWxlY3RhYmxlIHZpYSB0aGUgYGdwaW9fcmFuZ2VgIGRl
c2NyaXB0b3IuDQo+IA0KPiBUaGUgc2NhbGVzIGFsc28gc2VlbSB0byBoYXZlIGJlZW4gbWlzY29t
cHV0ZWQsIGJlY2F1c2Ugd2hlbiB0aGV5IHdlcmUNCj4gYXBwbGllZCB0byB0aGUgcmF3IHZhbHVl
cywgdGhlIHJlc3VsdHMgZGlmZmVyIGZyb20gdGhlIGV4cGVjdGVkIHZhbHVlcy4NCj4gQWZ0ZXIg
Y2hlY2tpbmcgdGhlIEFEQyB0cmFuc2ZlciBmdW5jdGlvbiBpbiB0aGUgZGF0YXNoZWV0LCB0aGVz
ZSB3ZXJlDQo+IHJlLWNvbXB1dGVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWxleGFuZHJ1IEFy
ZGVsZWFuIDxhbGV4YW5kcnUuYXJkZWxlYW5AYW5hbG9nLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJz
L3N0YWdpbmcvaWlvL2FkYy9hZDc2MDYuYyB8IDYgKysrKy0tDQo+ICAxIGZpbGUgY2hhbmdlZCwg
NCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc3RhZ2luZy9paW8vYWRjL2FkNzYwNi5jDQo+IGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMv
YWQ3NjA2LmMNCj4gaW5kZXggYzVmZTMwMDMwNzViLi44ZjBlZWJmNzMxNmQgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzYwNi5jDQo+ICsrKyBiL2RyaXZlcnMvc3Rh
Z2luZy9paW8vYWRjL2FkNzYwNi5jDQo+IEBAIC0yNiw5ICsyNiwxMSBAQA0KPiAgDQo+ICAjaW5j
bHVkZSAiYWQ3NjA2LmgiDQo+ICANCj4gLS8qIFNjYWxlcyBhcmUgY29tcHV0ZWQgYXMgMi41LzIq
KjE2IGFuZCA1LzIqKjE2IHJlc3BlY3RpdmVseSAqLw0KPiArLyogU2NhbGVzIGFyZSBjb21wdXRl
ZCBhcyA1MDAwLzIqKjE2IGFuZCAxMDAwMC8yKioxNiByZXNwZWN0aXZlbHksDQpXaWxsIHNlbmQg
YSBWMi4NCk15IGNvbXB1dGF0aW9uIG9mIDMyNzY4IFt3aGljaCBpcyBtZW50aW9uZWQgaW4gdGhl
IGRhdGFzaGVldF0gaXMgYWxzbw0Kd3JvbmcuIFNvLCB0aGlzIGNvbW1lbnQgaXMgd3JvbmcuDQoN
Cj4gKyAqIHNvIHRoYXQgd2hlbiBhcHBsaWVkIHRvIHRoZSByYXcgdmFsdWVzIHRoZXkgcHJvdmlk
ZSBtViB2YWx1ZXMNCj4gKyAqLw0KPiAgc3RhdGljIGNvbnN0IHVuc2lnbmVkIGludCBzY2FsZV9h
dmFpbFsyXVsyXSA9IHsNCj4gLQl7MCwgMzgxNDd9LCB7MCwgNzYyOTR9DQo+ICsJezAsIDE1MjU4
OH0sIHswLCAzMDUxNzZ9DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMgaW50IGFkNzYwNl9yZXNldChz
dHJ1Y3QgYWQ3NjA2X3N0YXRlICpzdCk=
