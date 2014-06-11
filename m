Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail1.bemta3.messagelabs.com ([195.245.230.162]:6110 "EHLO
	mail1.bemta3.messagelabs.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755742AbaFKQ4u (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 11 Jun 2014 12:56:50 -0400
From: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
To: Jonathan Cameron <jic23@kernel.org>,
	"Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>,
	Lee Jones <lee.jones@linaro.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Ian Campbell" <ijc+devicetree@hellion.org.uk>,
	Kumar Gala <galak@codeaurora.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Support Opensource" <Support.Opensource@diasemi.com>
Subject: RE: [PATCH 4/8] iio: Add support for DA9150 GPADC
Date: Wed, 11 Jun 2014 16:56:44 +0000
Message-ID: <2E89032DDAA8B9408CB92943514A0337A56F5455@SW-EX-MBX01.diasemi.com>
References: <cover.1402484954.git.Adam.Thomson.Opensource@diasemi.com>
 <3c1a7551c7deaeccdca731fa95f4349c57e04249.1402484954.git.Adam.Thomson.Opensource@diasemi.com>
 <ba29cc7f-7586-430c-8947-763510e04212@email.android.com>
In-Reply-To: <ba29cc7f-7586-430c-8947-763510e04212@email.android.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gSnVuZSAxMSwgMjAxNCAxNzozNSwgSm9uYXRob24gQ2FtZXJvbiB3cm90ZToNCg0KPiBIaSBB
ZGFtLiBTaWxseSBxdWVzdGlvbiBidXQgd2hhdCBhcmUgdGhlIF8gY2hhbm5lbHM/DQo+IA0KPiBJ
IGhhdmUgcHV0IGluIGEgcGVyaGFwcyBvcHRpbWlzdGljIGRhdGEgc2hlZXQgcmVxdWVzdCB2aWEg
dGhlIHdlYnNpdGUsIHRocm93aW5nIGluDQo+IHlvdXIgbmFtZS4gSG9wZSB5b3UgZG9uJ3QgbWlu
ZCENCj4gDQo+IEpvbmF0aGFuDQoNCkhpIEpvbmF0aG9uLiBTb21lIG9mIHRoZSBfY2hhbm5lbHMg
YXJlIGEgZGlmZmVyZW50IHJlcHJlc2VudGF0aW9uIG9mIHRoZSByZWFkaW5nDQooZS5nLiBkaWZm
ZXJlbnQgc2NhbGUgLSBvbmUgd291bGQgYmUgMC02ViByYW5nZSwgYW5kIG9uZSB3b3VsZCBiZSAw
LTIxViBmb3INCmV4YW1wbGUpLiBPdGhlcnMgcHJvdmlkZSBpZGVudGljYWwgcmVhZGluZ3MgdG8g
dGhlIG5vbiBfY2hhbm5lbCBidXQgaGF2ZSBsZWZ0DQp0aG9zZSBpbiB0byBrZWVwIHRoZSBjaGFu
bmVsIG51bWJlcmluZyBzYW5lIGFuZCBlYXN5IHRvIHJlZmVyZW5jZS4NCg0KTm8gcHJvYmxlbSBy
ZWdhcmRpbmcgdGhlIHJlcXVlc3QuDQo=
