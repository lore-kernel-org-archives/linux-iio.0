Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.164]:48858 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751030AbaLHNXR (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 8 Dec 2014 08:23:17 -0500
From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
To: Hartmut Knaack <knaack.h@gmx.de>,
	"Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	"David Woodhouse" <dwmw2@infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"Grant Likely" <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Joe Perches" <joe@perches.com>,
	"linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v4 3/8] iio: Add support for DA9150 GPADC
Date: Mon, 8 Dec 2014 13:23:07 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB52290B@SW-EX-MBX01.diasemi.com>
References: <cover.1416938054.git.Adam.Thomson.Opensource@diasemi.com>
 <377be6cf23ba23dac0b21fe2a449307ec5bac63a.1416938054.git.Adam.Thomson.Opensource@diasemi.com>
 <5480E7F4.7090808@gmx.de>
In-Reply-To: <5480E7F4.7090808@gmx.de>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gRGVjZW1iZXIgMDQsIDIwMTQgMjM6MDIsIEhhcnRtdXQgS25hYWNrIHdyb3RlOg0KDQo+ID4g
KwlpbmRpb19kZXYgPSBkZXZtX2lpb19kZXZpY2VfYWxsb2MoJnBkZXYtPmRldiwNCj4gPiArCQkJ
CQkgIHNpemVvZihzdHJ1Y3QgZGE5MTUwX2dwYWRjKSk7DQo+IEJUVzogSWYgeW91IHVzZSBzaXpl
b2YoKmdwYWRjKSBpbnN0ZWFkIChsaWtlIGl0IGlzIHVzdWFsbHkgZG9uZSBhcyB3ZWxsKSwNCj4g
aXQgd2lsbCBwZXJmZWN0bHkgZml0IGluIG9uZSBsaW5lLg0KDQpJIHByZWZlcnJlZCB0byBiZSBl
eHBsaWNpdCB0aGF0IHRoZSBpdGVtIGlzIGEgc3RydWN0LCBidXQgcmVhbGx5IG5vdCB0aGF0IGZ1
c3NlZA0KZWl0aGVyIHdheS4gQWxzbyBoYXZlIGJlZW4gYXNrZWQgcHJldmlvdXNseSBpbiBhIHNl
cGFyYXRlIGRyaXZlciB0byBtYWtlIHRoZQ0Kc2FtZSBtb2QgeW91IG1lbnRpb24gc28gd2lsbCB1
cGRhdGUgYWNjb3JkaW5nbHkuDQoNCj4gPiArCXJldCA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9p
cnEoZGV2LCBpcnEsIE5VTEwsIGRhOTE1MF9ncGFkY19pcnEsDQo+ID4gKwkJCQkJSVJRRl9PTkVT
SE9ULCAiR1BBREMiLCBncGFkYyk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2Vycihk
ZXYsICJGYWlsZWQgdG8gcmVxdWVzdCBJUlEgJWQ6ICVkXG4iLCBpcnEsIHJldCk7DQo+ID4gKwkJ
Z290byBpaW9fbWFwX3VucmVnOw0KPiBZb3UgbmVlZCB0byByZXR1cm4gcmV0IGhlcmUsIG5vIGp1
bXAgdG8gZXJyb3Igb3V0IHBhdGguDQoNClllcywgdGhhbmtzLiBBbm5veWVkIEkgbWlzc2VkIHRo
YXQgaW4gdGhlIHJlLWZhY3Rvci4gV2lsbCBmaXggaXQuDQo=
