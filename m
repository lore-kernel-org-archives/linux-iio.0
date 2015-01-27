Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta14.messagelabs.com ([193.109.254.107]:34176 "EHLO
	mail1.bemta14.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932436AbbA0QQi (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jan 2015 11:16:38 -0500
From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
To: Varka Bhadram <varkabhadram@gmail.com>,
	"Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	"Dmitry Eremin-Solenikov" <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	"Mark Rutland" <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	Grant Likely <grant.likely@linaro.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Joe Perches <joe@perches.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH v6 5/7] power: Add support for DA9150 Charger
Date: Tue, 27 Jan 2015 16:16:31 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB529E6E@SW-EX-MBX01.diasemi.com>
References: <cover.1421854282.git.Adam.Thomson.Opensource@diasemi.com>
 <d9c5c61443e266880cab3cbe7502142439fe9886.1421854282.git.Adam.Thomson.Opensource@diasemi.com>
 <54BFD072.8000707@gmail.com>
In-Reply-To: <54BFD072.8000707@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gSmFudWFyeSAyMSwgMjAxNSAxNjoxNSwgVmFya2EgQmhhZHJhbSB3cm90ZToNCg0KPiBPbiBX
ZWRuZXNkYXkgMjEgSmFudWFyeSAyMDE1IDA5OjE2IFBNLCBBZGFtIFRob21zb24gd3JvdGU6DQo+
ID4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIERBOTE1MCBDaGFyZ2VyICYgRnVlbC1HYXVn
ZSBJQyBDaGFyZ2VyLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogQWRhbSBUaG9tc29uIDxBZGFt
LlRob21zb24uT3BlbnNvdXJjZUBkaWFzZW1pLmNvbT4NCj4gPiAtLS0NCj4gDQo+ICguLi4pDQo+
IA0KPiA+ICtzdGF0aWMgaW50IGRhOTE1MF9jaGFyZ2VyX3JlZ2lzdGVyX2lycShzdHJ1Y3QgcGxh
dGZvcm1fZGV2aWNlICpwZGV2LA0KPiA+ICsJCQkJICAgICAgIGlycV9oYW5kbGVyX3QgaGFuZGxl
ciwNCj4gPiArCQkJCSAgICAgICBjb25zdCBjaGFyICppcnFfbmFtZSkNCj4gPiArew0KPiA+ICsJ
c3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiArCXN0cnVjdCBkYTkxNTBfY2hh
cmdlciAqY2hhcmdlciA9IHBsYXRmb3JtX2dldF9kcnZkYXRhKHBkZXYpOw0KPiA+ICsJaW50IGly
cSwgcmV0Ow0KPiA+ICsNCj4gPiArCWlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKHBkZXYs
IGlycV9uYW1lKTsNCj4gPiArCWlmIChpcnEgPCAwKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJG
YWlsZWQgdG8gZ2V0IElSUSBDSEdfU1RBVFVTOiAlZFxuIiwgaXJxKTsNCj4gPiArCQlyZXR1cm4g
aXJxOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldCA9IHJlcXVlc3RfdGhyZWFkZWRfaXJxKGly
cSwgTlVMTCwgaGFuZGxlciwgSVJRRl9PTkVTSE9ULCBpcnFfbmFtZSwNCj4gPiArCQkJCSAgIGNo
YXJnZXIpOw0KPiANCj4gV2h5IGRvbiB5b3UgdXNlIGRldm1fKiBBUEkuLj8NCg0KQXMgbWVudGlv
bmVkIGluIHByZXZpb3VzIGRpc2N1c3Npb25zLCB0aGUgb3JkZXIgb2YgdGlkeSB1cCBpcyBpbXBv
cnRhbnQgc28gDQpkZXZtXyogZnVuY3Rpb25zIGNhbm5vdCBiZSB1c2VkIGhlcmUuDQoNCj4gDQo+
ID4gKwlpZiAocmV0KQ0KPiA+ICsJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIHJlcXVlc3QgSVJR
ICVkOiAlZFxuIiwgaXJxLCByZXQpOw0KPiA+ICsNCj4gPiArCXJldHVybiByZXQ7DQo+ID4gK30N
Cj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGRhOTE1MF9jaGFyZ2VyX3VucmVnaXN0ZXJfaXJxKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ID4gKwkJCQkJICBjb25zdCBjaGFyICppcnFf
bmFtZSkNCj4gPiArew0KPiA+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4g
PiArCXN0cnVjdCBkYTkxNTBfY2hhcmdlciAqY2hhcmdlciA9IHBsYXRmb3JtX2dldF9kcnZkYXRh
KHBkZXYpOw0KPiA+ICsJaW50IGlycTsNCj4gPiArDQo+ID4gKwlpcnEgPSBwbGF0Zm9ybV9nZXRf
aXJxX2J5bmFtZShwZGV2LCBpcnFfbmFtZSk7DQo+ID4gKwlpZiAoaXJxIDwgMCkgew0KPiA+ICsJ
CWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGdldCBJUlEgQ0hHX1NUQVRVUzogJWRcbiIsIGlycSk7
DQo+ID4gKwkJcmV0dXJuOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiArCWZyZWVfaXJxKGlycSwgY2hh
cmdlcik7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgZGE5MTUwX2NoYXJnZXJfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiArew0KPiA+ICsJc3RydWN0IGRl
dmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gPiArCXN0cnVjdCBkYTkxNTAgKmRhOTE1MCA9IGRl
dl9nZXRfZHJ2ZGF0YShkZXYtPnBhcmVudCk7DQo+ID4gKwlzdHJ1Y3QgZGE5MTUwX2NoYXJnZXIg
KmNoYXJnZXI7DQo+ID4gKwlzdHJ1Y3QgcG93ZXJfc3VwcGx5ICp1c2IsICpiYXR0ZXJ5Ow0KPiA+
ICsJdTggcmVnOw0KPiA+ICsJaW50IHJldDsNCj4gPiArDQo+ID4gKwljaGFyZ2VyID0gZGV2bV9r
emFsbG9jKGRldiwgc2l6ZW9mKHN0cnVjdCBkYTkxNTBfY2hhcmdlciksIEdGUF9LRVJORUwpOw0K
PiA+ICsJaWYgKGNoYXJnZXIgPT0gTlVMTCkNCj4gPiArCQlyZXR1cm4gLUVOT01FTTsNCj4gDQo+
IHNpemVvZihzdHJ1Y3QgZGE5MTUwX2NoYXJnZXIpIGNhbiBiZSByZXBsYWNlZCB3aXRoIHNpemVv
ZigqY2hhcmdlcikuLi4NCj4gDQo+ICohKiBvcGVyYXRvciBjYW4gYmUgdXNlZCBpbiBjb21wYXJp
c29uIHdpdGggTlVMTC4uLg0KPiANCg0KWWVzLCBidXQgZnVuY3Rpb25hbGx5IG5vIGRpZmZlcmVu
dC4gQ2FuIG1heWJlIGNoYW5nZSB0aGlzIGFyb3VuZCBsYXRlciwgYnV0DQp3b3VsZCBsaWtlIHRv
IGF2b2lkIGNoYW5naW5nIGN1cnJlbnQgcGF0Y2ggc2V0IHJpZ2h0IG5vdy4NCg==
