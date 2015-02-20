Return-Path: <srinivas.pandruvada@intel.com>
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, "Tirdea, Irina"
	<irina.tirdea@intel.com>, "jic23@kernel.org" <jic23@kernel.org>, "Reus,
 Adriana" <adriana.reus@intel.com>
Subject: Re: [PATCH 2/2] iio: accel: kxcjk-1013: optimize i2c transfers in
 trigger handler
Date: Fri, 20 Feb 2015 15:27:43 +0000
Message-ID: <1424446063.2916.17.camel@spandruv-mobl2>
References: <1424110909-16878-1-git-send-email-irina.tirdea@intel.com>
	  <1424110909-16878-3-git-send-email-irina.tirdea@intel.com>
	  <alpine.DEB.2.02.1502162014280.26763@pmeerw.net>
	  <1F3AC3675D538145B1661F571FE1805F19A20D9C@irsmsx105.ger.corp.intel.com>
	 <1424444331.2916.2.camel@spandruv-mobl2>
	 <alpine.DEB.2.02.1502201621430.2739@pmeerw.net>
In-Reply-To: <alpine.DEB.2.02.1502201621430.2739@pmeerw.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

T24gRnJpLCAyMDE1LTAyLTIwIGF0IDE2OjIzICswMTAwLCBQZXRlciBNZWVyd2FsZCB3cm90ZToN
Cj4gPiA+ID4gPiArDQo+ID4gPiA+ID4gKwkJdmFsdWVzW2ldID0gZGF0YSAmIDB4RkY7DQo+ID4g
PiA+ID4gKwkJdmFsdWVzW2krMV0gPSBkYXRhID4+IDg7DQo+ID4gPiA+IA0KPiA+ID4gPiB0aGlz
IGlzIGluY29ycmVjdDsgaXQgZm9yY2VzIHRoZSBkYXRhIHRvIGJlIGxpdHRsZSBlbmRpYW4sIGhv
d2V2ZXIsIHRoZQ0KPiA+ID4gPiBlbmRpYW5uZXNzIChhcyBzcGVjaWZpZWQgaW4gdGhlIGRyaXZl
cidzIC5zY2FuX3R5cGUpIGlzIElJT19DUFUgLS0gdGhlDQo+ID4gPiA+IGNvZGUgYnJlYWtzIGZv
ciBiaWctZW5kaWFuIENQVXMNCj4gPiA+ID4gDQo+ID4gPiA+IHNpbmNlIF9yZWFkX2kyY19ibG9j
a19kYXRhKCkgY2FuJ3QgZG8gZW5kaWFubmVzcyBjb252ZXJzaW9uIChhbmQgdGhlIGNoaXANCj4g
PiA+ID4gZG9lcyBpMmMgZW5kaWFubmVzcywgaS5lLiBsaXR0bGUtZW5kaWFuKSwgdGhlIC5zY2Fu
X3R5cGUgc2hvdWxkIGJlY29tZQ0KPiA+ID4gPiBJSU9fTEUgYW5kIGFib3ZlIGNvZGUgaXMgY29y
cmVjdCBhZ2FpbiBidXQgc3RpbGwgdWdseSA6KQ0KPiA+ID4gPiANCj4gPiA+ID4gYm90dG9tIGxp
bmU6IGNoYW5nZSAuc2Nhbl90eXBlIHRvIElJT19MRQ0KPiA+ID4gPiANCj4gPiA+IEdvb2QgcG9p
bnQuIENoYW5naW5nIHRoZSBlbmRpYW5lc3MgdG8gSUlPX0xFIGlzIGNvcnJlY3QgZm9yIGVpdGhl
ciBreGNqazEwMTNfcmVhZF9ibG9ja19kYXRhIG9yIGkyY19zbWJ1c19yZWFkX2kyY19ibG9ja19k
YXRhLg0KPiA+ID4gV2lsbCBmaXggdGhpcyBpbiB0aGUgbmV4dCB2ZXJzaW9uLiBUaGFua3MgZm9y
IGNhdGNoaW5nIHRoaXMhDQo+ID4gPiANCj4gPiBJIGRvbid0IHRoaW5rIGNoYW5naW5nIHRvIElJ
T19MRSBpcyBnb29kIGlkZWEgYXMgd2hlbiBpMmNfcmVhZF9ib2NrLi4NCj4gPiB0aGVuIHRoZSBz
Y2FuIHR5cGUgd2lsbCBiZSBDUFUuIFNvIGJldHRlciB0byBmaXggZW5kaWFubmVzcyBpbiB0aGlz
DQo+ID4gZnVuY3Rpb24uDQo+IA0KPiB0aGUgY2hpcCBoYXMgbGl0dGxlLWVuZGlhbiBkYXRhIHJl
Z2lzdGVyczsgaTJjX3JlYWRfYmxvY2soKSBqdXN0IHRyYW5zZmVycyANCj4gdGhlIGRhdGEgKG5v
IGVuZGlhbm5lc3MgY29udmVyc2lvbiksIHNvIHRoZSBkYXRhIHdpbGwgc3RpbGwgYmUgDQo+IGxp
dHRsZS1lbmRpYW4NCllvdSBhcmUgcmlnaHQuDQo+IA0KPiBwLg0KPiANCg0K
