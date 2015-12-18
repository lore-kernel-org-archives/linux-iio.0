Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:54331 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932264AbbLRQ6z (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Fri, 18 Dec 2015 11:58:55 -0500
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "nish.aravamudan@gmail.com" <nish.aravamudan@gmail.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"cmo@melexis.com" <cmo@melexis.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
	"jikos@kernel.org" <jikos@kernel.org>,
	"Shevchenko, Andriy" <andriy.shevchenko@intel.com>
Subject: Re: iio/hid-sensor-accel-3d: no output from /dev/iio:device*?
Date: Fri, 18 Dec 2015 16:58:53 +0000
Message-ID: <1450457824.3958.9.camel@intel.com>
References: <CAOhV88ODTazDA2jmn9DP5idMmXXQa9jKB9Ur_aWTD_3WYZM1fw@mail.gmail.com>
	 <1450399868.5427.11.camel@linux.intel.com>
	 <1450400312.5427.15.camel@intel.com>
	 <CAOhV88OinTE31-qp1vh-4XHT-TqMTTOYwHiLk0yptg0prwetjw@mail.gmail.com>
	 <1450400953.5427.18.camel@intel.com>
	 <CAOhV88Oqj+JrPsHqZmtmydUftSA9sUuCDErUOaAG_Erk+uDr1g@mail.gmail.com>
	 <1450406943.3885.3.camel@intel.com>
	 <CAOhV88MH4pyX1j8qutc47vjpwQcb9bEUFTyocLtNH5JnVve+6A@mail.gmail.com>
In-Reply-To: <CAOhV88MH4pyX1j8qutc47vjpwQcb9bEUFTyocLtNH5JnVve+6A@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gVGh1LCAyMDE1LTEyLTE3IGF0IDE5OjA2IC0wODAwLCBOaXNoIEFyYXZhbXVkYW4gd3JvdGU6
DQo+IE9uIFRodSwgRGVjIDE3LCAyMDE1IGF0IDY6NTAgUE0sIFBhbmRydXZhZGEsIFNyaW5pdmFz
DQo+IDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT4gd3JvdGU6DQo+ID4gT24gVGh1LCAy
MDE1LTEyLTE3IGF0IDE4OjMzIC0wODAwLCBOaXNoIEFyYXZhbXVkYW4gd3JvdGU6DQo+ID4gPiBP
biBUaHUsIERlYyAxNywgMjAxNSBhdCA1OjExIFBNLCBQYW5kcnV2YWRhLCBTcmluaXZhcw0KPiA+
ID4gPHNyaW5pdmFzLnBhbmRydXZhZGFAaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+ID4gT24gVGh1
LCAyMDE1LTEyLTE3IGF0IDE3OjA4IC0wODAwLCBOaXNoIEFyYXZhbXVkYW4gd3JvdGU6DQo+ID4g
PiA+ID4gT24gVGh1LCBEZWMgMTcsIDIwMTUgYXQgNTowMCBQTSwgUGFuZHJ1dmFkYSwgU3Jpbml2
YXMNCj4gPiA+ID4gPiA8c3Jpbml2YXMucGFuZHJ1dmFkYUBpbnRlbC5jb20+IHdyb3RlOg0KPiA+
ID4gPiA+ID4gSGkgQW5keSwNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gQXMgcGVyIE5pc2gg
dGhlc2UgcGF0Y2hlcyBhcmUgaW1wYWN0aW5nIHNlbnNvcnMgb24gWW9nYS4NCj4gPiA+ID4gPiA+
IGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE1LzExLzMwLzQ0MQ0KPiA+ID4gPiA+IA0KPiA+ID4g
PiA+IFRvIGJlIGNsZWFyLCB3aXRob3V0IHRoYXQgc2VyaWVzLCB0aGUgdG91Y2hwYWQgYW5kDQo+
ID4gPiA+ID4gdG91Y2hzY3JlZW4gb24NCj4gPiA+ID4gPiB0aGUNCj4gPiA+ID4gPiBZb2dhIDkw
MCBkb24ndCB3b3JrIGF0IGFsbC4gU28gdGhleSBhcmUgbmVjZXNzYXJ5IGZvcg0KPiA+ID4gPiA+
IGZ1bmN0aW9uaW5nLiBJDQo+ID4gPiA+ID4gZG9uJ3Qga25vdyAoSSB3aWxsIHRlc3QgaXQgbm93
KSwgaWYgcmVtb3ZpbmcgdGhlIHNlcmllcyBtYWtlcw0KPiA+ID4gPiA+IHRoZQ0KPiA+ID4gPiA+
IElJTw0KPiA+ID4gPiA+IHNlbnNvcnMgd29yayBwcm9wZXJseSBpbiAvZGV2Ly4NCj4gPiA+ID4g
VGhpcyBpcyBpbXBvcnRhbnQgdG8ga25vdyBiZWZvcmUgd2UgdGFrZSBBbmR5J3MgdGltZS4NCj4g
PiA+IA0KPiA+ID4gSXQgc2VlbXMgbGlrZSBBbmR5J3MgcGF0Y2hlcyBhcmUgbm90IHRoZSBwcm9i
bGVtLiBUaGF0IGlzLCB3aXRoDQo+ID4gPiBzdG9jaw0KPiA+ID4gNC40LXJjNSwgdGhlIGFjY2Vs
ZXJvbW1ldGVyIC9kZXYgZmlsZXMgc3RpbGwgZG8gbm90IHVwZGF0ZS4NCj4gPiA+IA0KPiA+IENh
biB5b3Ugbm90IHVzZSByYXcgdmFsdWVzIGJ5IHBvbGxpbmcgZnJvbSB1c2VyIHNwYWNlPyBTZW5k
IG1lDQo+ID4gcmVwb3J0IGRlc2NyaXB0aW9uLiBJdCBzaG91bGQgYmUgaW4NCj4gPiAvc3lzL2tl
cm5lbC9kZWJ1Zy9oaWQvICJ5b3VyIGRldmljZSBpZCIgL3JlZGVzYy4NCj4gDQo+IFRoZSB1bmRl
cmx5aW5nIGlzc3VlIGlzIHRoYXQgaWlvLXNlbnNvci1wcm94eSByZWxpZXMgb24gdmFsdWVzIGZy
b20NCj4gdGhlIGNvcnJlc3BvbmRpbmcgL2RldiBub2RlcyB0byBhdXRvbWF0aWNhbGx5IHJvdGF0
ZSB0aGUgc2NyZWVuLCBldGMuDQo+IGluIHRoZSBkZXNrdG9wIGVudmlyb25tZW50Lg0KPiANCj4g
QXR0YWNoZWQgZHVlIHRvIGl0cyBzaXplLg0KPiANCj4gPiBBbHNvIGRldmljZSBpZCAoInlvdXIg
ZGV2aWNlIGlkIikgYWJvdmUuDQo+IA0KPiAwMDE4OjA0OEQ6ODM5Ni4wMDAyDQpTZW50IGEgcGF0
Y2gsIHRyeSBhbmQgc2VlIGlmIHRoaXMgd29ya3MuDQoNClRoYW5rcywNClNyaW5pdmFzDQoNCj4g
DQo+IC1OaXNo
