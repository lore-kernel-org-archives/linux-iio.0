Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta5.messagelabs.com ([195.245.231.142]:61138 "EHLO
	mail1.bemta5.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753555AbbA0QPt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 27 Jan 2015 11:15:49 -0500
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
Subject: RE: [PATCH v6 3/7] iio: Add support for DA9150 GPADC
Date: Tue, 27 Jan 2015 16:15:37 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337AB529E60@SW-EX-MBX01.diasemi.com>
References: <cover.1421854282.git.Adam.Thomson.Opensource@diasemi.com>
 <ae9b56cc8cd15bd72ea1b721ae02b1dde8632dbf.1421854282.git.Adam.Thomson.Opensource@diasemi.com>
 <54BFCE97.4050007@gmail.com>
In-Reply-To: <54BFCE97.4050007@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gSmFudWFyeSAyMSwgMjAxNSAxNjowNywgVmFya2EgQmhhZHJhbSB3cm90ZToNCg0KPiBPbiBX
ZWRuZXNkYXkgMjEgSmFudWFyeSAyMDE1IDA5OjE2IFBNLCBBZGFtIFRob21zb24gd3JvdGU6DQo+
ID4gVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIERBOTE1MCBDaGFyZ2VyICYgRnVlbC1HYXVn
ZSBJQyBHUEFEQy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEFkYW0gVGhvbXNvbiA8QWRhbS5U
aG9tc29uLk9wZW5zb3VyY2VAZGlhc2VtaS5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IEhhcnRtdXQg
S25hYWNrIDxrbmFhY2suaEBnbXguZGU+DQo+ID4gQWNrZWQtYnk6IEpvbmF0aGFuIENhbWVyb24g
PGppYzIzQGtlcm5lbC5vcmc+DQo+IA0KPiAoLi4uKQ0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBp
bnQgZGE5MTUwX2dwYWRjX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4g
K3sNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKwlzdHJ1Y3Qg
ZGE5MTUwICpkYTkxNTAgPSBkZXZfZ2V0X2RydmRhdGEoZGV2LT5wYXJlbnQpOw0KPiA+ICsJc3Ry
dWN0IGRhOTE1MF9ncGFkYyAqZ3BhZGM7DQo+ID4gKwlzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2
Ow0KPiA+ICsJaW50IGlycSwgcmV0Ow0KPiA+ICsNCj4gPiArCWluZGlvX2RldiA9IGRldm1faWlv
X2RldmljZV9hbGxvYygmcGRldi0+ZGV2LCBzaXplb2YoKmdwYWRjKSk7DQo+IA0KPiAgIFlvdSBj
YW4gZGlyZWN0bHkgdXNlICpkZXYqIGluc3RlYWQgb2YgKiZwZGV2LT5kZXYqDQoNClllcyBhZ3Jl
ZWQuIENhbiBmb2xsb3cgdXAgd2l0aCBjaGFuZ2UgZm9yIHRoaXMgYXMgaXQncyBub3QgdXJnZW50
IGFuZCB3b3VsZA0KcmF0aGVyIGxlYXZlIGN1cnJlbnQgcGF0Y2ggc2V0IGFzIGlzLg0K
