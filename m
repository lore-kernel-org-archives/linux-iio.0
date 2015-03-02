Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.175]:41526 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751692AbbCBKoG (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 2 Mar 2015 05:44:06 -0500
From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
To: Peter Meerwald <pmeerw@pmeerw.net>,
	"Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Support Opensource <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v7 3/7] iio: Add support for DA9150 GPADC
Date: Mon, 2 Mar 2015 10:44:01 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB53E953@SW-EX-MBX01.diasemi.com>
References: <cover.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
 <a470e47176f2099e6f96a2e83581ff3c0c503362.1424267009.git.Adam.Thomson.Opensource@diasemi.com>
 <alpine.DEB.2.02.1502192016140.27081@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1502192016140.27081@pmeerw.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gSmFudWFyeSAyMSwgMjAxNSAxOToyNiwgUGV0ZXIgTWVlcndhbGQgd3JvdGU6DQoNCj4gPiBU
aGlzIHBhdGNoIGFkZHMgc3VwcG9ydCBmb3IgREE5MTUwIENoYXJnZXIgJiBGdWVsLUdhdWdlIElD
IEdQQURDLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWRhbSBUaG9tc29uIDxBZGFtLlRob21z
b24uT3BlbnNvdXJjZUBkaWFzZW1pLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogSGFydG11dCBLbmFh
Y2sgPGtuYWFjay5oQGdteC5kZT4NCj4gPiBBY2tlZC1ieTogSm9uYXRoYW4gQ2FtZXJvbiA8amlj
MjNAa2VybmVsLm9yZz4NCj4gDQo+IG1pbm9yIG5pdHBpY2tpbmcgKGZvcm1hdHRpbmcpIGJlbG93
DQo+ID4gKy8qIFByaXZhdGUgZGF0YSAqLw0KPiA+ICtzdHJ1Y3QgZGE5MTUwX2dwYWRjIHsNCj4g
PiArCXN0cnVjdCBkYTkxNTAgKmRhOTE1MDsNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldjsNCj4g
PiArDQo+ID4gKwlzdHJ1Y3QgbXV0ZXggbG9jazsNCj4gPiArCXN0cnVjdCBjb21wbGV0aW9uIGNv
bXBsZXRlOw0KPiA+ICt9Ow0KPiA+ICsNCj4gDQo+IGV4dHJhIG5ld2xpbmUNCg0KSGF2ZSBzdWJz
ZXF1ZW50IG1vZHVsZXMgdG8gc3VibWl0LCBzbyB3aGVuIEkgZG8gdGhhdCBJJ2xsIGFsc28gZml4
IHRoZXNlIG1pbm9yDQpmb3JtYXR0aW5nIGRpc2NyZXBhbmNpZXMuDQoNCj4gDQo+ID4gKw0KPiA+
ICtzdGF0aWMgaXJxcmV0dXJuX3QgZGE5MTUwX2dwYWRjX2lycShpbnQgaXJxLCB2b2lkICpkYXRh
KQ0KPiA+ICt7DQo+ID4gKw0KPiANCj4gZXh0cmEgbmV3bGluZQ0KPiANCg0KTm90ZWQuDQoNCj4g
PiArc3RhdGljIGNvbnN0IHN0cnVjdCBpaW9faW5mbyBkYTkxNTBfZ3BhZGNfaW5mbyA9IHsNCj4g
PiArCS5yZWFkX3JhdyA9ICZkYTkxNTBfZ3BhZGNfcmVhZF9yYXcsDQo+ID4gKwkuZHJpdmVyX21v
ZHVsZSA9IFRISVNfTU9EVUxFLA0KPiA+ICt9Ow0KPiA+ICsNCj4gPiArI2RlZmluZSBEQTkxNTBf
R1BBRENfQ0hBTk5FTChfaWQsIF9od19pZCwgX3R5cGUsIGNoYW5faW5mbywJXA0KPiANCj4gYWxs
IG1hY3JvIHBhcmFtZXRlcnMgaGF2ZSBhIF8gcHJlZml4IGV4Y2VwdCBjaGFuX2luZm8NCj4gDQoN
Ck5vdGVkLg0K
