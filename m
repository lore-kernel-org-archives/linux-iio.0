Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:59230 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752494AbbASQ4u (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 19 Jan 2015 11:56:50 -0500
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "Baluta, Daniel" <daniel.baluta@intel.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"jic23@kernel.org" <jic23@kernel.org>,
	"Purdila, Octavian" <octavian.purdila@intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"Westerberg, Mika" <mika.westerberg@intel.com>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"beomho.seo@samsung.com" <beomho.seo@samsung.com>,
	"gwendal@chromium.org" <gwendal@chromium.org>
Subject: Re: [RFC PATCH] iio: ak8975: Make sure chipset is always initialized
Date: Mon, 19 Jan 2015 16:56:45 +0000
Message-ID: <1421686560.4459.400.camel@spandruv-desktop.jf.intel.com>
References: <1418923002-901-1-git-send-email-daniel.baluta@intel.com>
	 <5494A3D6.60607@gmx.de>
	 <CAEnQRZABxH5MuWEnS=RHmQqGUN0QhFTtXxnM1uyrLxvP2a-Rmg@mail.gmail.com>
	 <1419110796.2843.6.camel@spandruv-hsb-test>
	 <1419110952.2843.8.camel@spandruv-hsb-test>
	 <CAEnQRZC_SR_p2oYq9EpDDfBi2nCAAWvYmf0tR7V7WPZRZEp79g@mail.gmail.com>
	 <1421685827.4459.397.camel@spandruv-desktop.jf.intel.com>
	 <CAEnQRZAfRJ+-1x_ZgRAC2Kkr2js4EQB1xA6gTJ5n0uCAZS4y2g@mail.gmail.com>
In-Reply-To: <CAEnQRZAfRJ+-1x_ZgRAC2Kkr2js4EQB1xA6gTJ5n0uCAZS4y2g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE1LTAxLTE5IGF0IDE4OjQ5ICswMjAwLCBEYW5pZWwgQmFsdXRhIHdyb3RlOiAN
Cj4gT24gTW9uLCBKYW4gMTksIDIwMTUgYXQgNjo0NCBQTSwgUGFuZHJ1dmFkYSwgU3Jpbml2YXMN
Cj4gPHNyaW5pdmFzLnBhbmRydXZhZGFAaW50ZWwuY29tPiB3cm90ZToNCj4gPiBPbiBNb24sIDIw
MTUtMDEtMTkgYXQgMTY6NDAgKzAyMDAsIERhbmllbCBCYWx1dGEgd3JvdGU6DQo+ID4+IEhlbGxv
LA0KPiA+Pg0KPiA+PiBPbiBTYXQsIERlYyAyMCwgMjAxNCBhdCAxMToyOSBQTSwgUGFuZHJ1dmFk
YSwgU3Jpbml2YXMNCj4gPj4gPHNyaW5pdmFzLnBhbmRydXZhZGFAaW50ZWwuY29tPiB3cm90ZToN
Cj4gPj4gPiArTWlrYQ0KPiA+PiA+DQo+ID4+ID4gT24gU2F0LCAyMDE0LTEyLTIwIGF0IDEzOjI2
IC0wODAwLCBTcmluaXZhcyBQYW5kcnV2YWRhIHdyb3RlOg0KPiA+PiA+PiBPbiBTYXQsIDIwMTQt
MTItMjAgYXQgMDA6MjUgKzAyMDAsIERhbmllbCBCYWx1dGEgd3JvdGU6DQo+ID4+ID4+ID4gT24g
U2F0LCBEZWMgMjAsIDIwMTQgYXQgMTI6MTYgQU0sIEhhcnRtdXQgS25hYWNrIDxrbmFhY2suaEBn
bXguZGU+IHdyb3RlOg0KPiA+PiA+PiA+ID4gRGFuaWVsIEJhbHV0YSBzY2hyaWViIGFtIDE4LjEy
LjIwMTQgdW0gMTg6MTY6DQo+ID4+ID4+ID4gPj4gV2hlbiB1c2luZyBBQ1BJLCBpZiBhY3BpX21h
dGNoX2RldmljZSBmYWlscyB0aGVuIGNoaXBzZXQgZW51bSB3aWxsIGJlDQo+ID4+ID4+ID4gPj4g
dW5pbml0aWFsaXplZCBhbmQgJmFrX2RlZl9hcnJheVtjaGlwc2V0XSB3aWxsIHBvaW50IHRvIHNv
bWUgYmFkIGFkZHJlc3MuDQo+ID4+ID4+ID4gPj4NCj4gPj4gPj4gSSBhbSBtaXNzaW5nIHNvbWV0
aGluZy4gWW91IGFyZSBlbnVtZXJhdGVkIG92ZXIgaTJjIGRldmljZSwgd2hpY2ggd2FzDQo+ID4+
ID4+IGNyZWF0ZWQgZnJvbSBBQ1BJIFBOUCByZXNvdXJjZS4gVGhlcmUgaXMgYSB2YWxpZCBoYW5k
bGUgb3IgYW5kIHRoZQ0KPiA+PiA+PiBkZXZpY2UgaGFzIGFuIEFDUEkgY29tcGFuaW9uIGF0IHRo
ZSBsZWFzdC4gSWYgdGhpcyBmYWlsaW5nLCBJIGhhdmUgdG8NCj4gPj4gPj4gY2hlY2sgdGhlIGNv
ZGUgZm9yIGFjcGkgaTJjLg0KPiA+PiA+PiBDYW4geW91IGNoZWNrIHdoeSB0aGlzIGNoZWNrIGZh
aWxlZD8gV2UgbWF5IGhhdmUgYnVnIGluIGkyYyBoYW5kbGluZy4NCj4gPj4NCj4gPj4gWW91IGFy
ZSByaWdodCBhYm91dCB0aGlzLiBVbmRlciBub3JtYWwgY2lyY3Vtc3RhbmNlcywgaWYgcHJvYmUg
aXMgY2FsbGVkDQo+ID4+IHRoZW4gYWNwaV9tYXRjaF9kZXZpY2Ugd2lsbCBub3QgZmFpbC4gSSBl
dmVuIHRyaWVkIHRvIHJlbW92ZSB0aGUNCj4gPj4gZGV2aWNlIGFmdGVyIHByb2JlDQo+ID4+IGJ1
dCBiZWZvcmUgYWNwaV9tYXRjaF9kZXZpY2UsIGFueWhvdyBhY3BpX21hdGNoX2RldmljZSB3YXMg
c3RpbGwgc3VjY2Vzc2Z1bCA6KQ0KPiA+Pg0KPiA+PiBUaGlzIGlzIG1vcmUgYSBtYXR0ZXIgb2Yg
Y29kZSBjb3JyZWN0bmVzcy4NCj4gPj4NCj4gPj4gSW4gYWs4OTc1X21hdGNoX2FjcGlfZGV2aWNl
IHdlIGhhdmU6DQo+ID4+DQo+ID4+IMK7ICAgICAgIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9p
ZCAqaWQ7DQo+ID4+DQo+ID4+IMK7ICAgICAgIGlkID0gYWNwaV9tYXRjaF9kZXZpY2UoZGV2LT5k
cml2ZXItPmFjcGlfbWF0Y2hfdGFibGUsIGRldik7DQo+ID4+IMK7ICAgICAgIGlmICghaWQpDQo+
ID4+IMK7ICAgICAgIMK7ICAgICAgIHJldHVybiBOVUxMOw0KPiA+PiDCuyAgICAgICAqY2hpcHNl
dCA9IChpbnQpaWQtPmRyaXZlcl9kYXRhOw0KPiA+Pg0KPiA+PiBDb21waWxlciBjb21wbGFpbnMg
b24gdGhlIGZhY3QgdGhhdCBjaGlwc2V0IG1pZ2h0IGJlIHVuaW5pdGlhbGl6ZWQNCj4gPj4gaWYg
dGhpcyByZXR1cm5zIE5VTEwsIGFuZCB3ZSBzaG91bGRuJ3QgaWdub3JlIHRoaXMgd2FybmluZyBl
dmVuIHRoaXMgY2FzZQ0KPiA+PiB3aWxsIG5ldmVyIGhhcHBlbi4NCj4gPj4NCj4gPiBXaWxsIHRo
aXMgZml4Pw0KPiA+IGRhdGEtPmNoaXBzZXQgPSBBSzg5NzU7DQo+ID4gYmVmb3JlDQo+ID4gYWs4
OTc1X21hdGNoX2FjcGlfZGV2aWNlKCZjbGllbnQtPmRldiwgJmRhdGEtPmNoaXBzZXQpOw0KPiA+
DQo+IA0KPiBZZXMsIHRoaXMgaXMgZG9uZSBpbiB0aGUgb3JpZ2luYWwgcGF0Y2g6DQo+IA0KPiAr
ICAgICAgICpjaGlwc2V0ID0gQUtfTUFYX1RZUEU7DQpTaW5jZSBkYXRhIG1lbW9yeSBpcyBub3Qg
emVybyBhbGxvY2VkLCBvdGhlciBtZW1iZXIgb2YgZGF0YSBhcmUgYW55d2F5DQppbml0aWFsaXpl
ZCwgc28gYWRkaW5nIHRoaXMgYWxzbyBtYXkgYmUgYmV0dGVyLiANCj4gDQo+IC4uIGFuZCBmaXhl
cyB0aGUgd2FybmluZy4NCj4gDQo+IERhbmllbC4NCg0K
