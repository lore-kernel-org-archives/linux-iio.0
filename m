Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:26304 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932778AbcKGRRw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 7 Nov 2016 12:17:52 -0500
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: "Song, Hongyan" <hongyan.song@intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] hid: hid-sensor-hub: clear memory to avoid random data
Date: Mon, 7 Nov 2016 17:17:50 +0000
Message-ID: <1478539068.13259.11.camel@intel.com>
References: <1478480644-9160-1-git-send-email-hongyan.song@intel.com>
In-Reply-To: <1478480644-9160-1-git-send-email-hongyan.song@intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gTW9uLCAyMDE2LTExLTA3IGF0IDAxOjA0ICswMDAwLCBTb25nIEhvbmd5YW4gd3JvdGU6DQo+
IEluaXRpYWxpemUgdXNlciBidWZmZXIgd2l0aCAwcy4gVGhpcyB3aWxsIGF2b2lkIHJhbmRvbSBk
YXRhIGluIHRoZQ0KPiBidWZmZXIsDQo+IHdoZW4gdGhlIHVzZXIgYnVmZmVyIHNpemUgaXMgYmln
Z2VyIHRoYW4gdGhlIGFjdHVhbCByZXBvcnQgc2l6ZS4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNv
bmcgSG9uZ3lhbiA8aG9uZ3lhbi5zb25nQGludGVsLmNvbT4NCj4gLS0tDQo+IMKgZHJpdmVycy9o
aWQvaGlkLXNlbnNvci1odWIuYyB8IDEgKw0KPiDCoDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaGlkL2hpZC1zZW5zb3ItaHViLmMgYi9k
cml2ZXJzL2hpZC9oaWQtc2Vuc29yLQ0KPiBodWIuYw0KPiBpbmRleCA2NThhNjA3Li45ODA5OTJj
IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2hpZC9oaWQtc2Vuc29yLWh1Yi5jDQo+ICsrKyBiL2Ry
aXZlcnMvaGlkL2hpZC1zZW5zb3ItaHViLmMNCj4gQEAgLTIxMiw2ICsyMTIsNyBAQCBpbnQgc2Vu
c29yX2h1Yl9zZXRfZmVhdHVyZShzdHJ1Y3QNCj4gaGlkX3NlbnNvcl9odWJfZGV2aWNlICpoc2Rl
diwgdTMyIHJlcG9ydF9pZCwNCj4gwqAJX19zMzIgdmFsdWU7DQo+IMKgCWludCByZXQgPSAwOw0K
PiDCoA0KSSB0aGluayB5b3Ugd2FudGVkIHRoaXMgY2hhbmdlIGluwqBzZW5zb3JfaHViX2dldF9m
ZWF0dXJlDQpub3TCoHNlbnNvcl9odWJfc2V0X2ZlYXR1cmUoKS4NCg0KPiArCW1lbXNldChidWZm
ZXIsIDAsIGJ1ZmZlcl9zaXplKTsNCj4gwqAJbXV0ZXhfbG9jaygmZGF0YS0+bXV0ZXgpOw0KPiDC
oAlyZXBvcnQgPSBzZW5zb3JfaHViX3JlcG9ydChyZXBvcnRfaWQsIGhzZGV2LT5oZGV2LA0KPiBI
SURfRkVBVFVSRV9SRVBPUlQpOw0KPiDCoAlpZiAoIXJlcG9ydCB8fCAoZmllbGRfaW5kZXggPj0g
cmVwb3J0LT5tYXhmaWVsZCkpIHs=
