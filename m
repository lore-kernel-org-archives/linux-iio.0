Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:3911 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752163AbdCQBZO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 16 Mar 2017 21:25:14 -0400
From: "Song, Hongyan" <hongyan.song@intel.com>
To: Bastien Nocera <hadess@hadess.net>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
CC: "jikos@kernel.org" <jikos@kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
Subject: RE: [PATCH] iio: hid: hid-sensor-accel-3d: Add second ACC sensor
 support
Date: Fri, 17 Mar 2017 01:21:29 +0000
Message-ID: <AE3E3DFA698D6144A7445C92D1D41E2F10BE185E@SHSMSX103.ccr.corp.intel.com>
References: <1489659652-35608-1-git-send-email-hongyan.song@intel.com>
 <1489665702.18490.12.camel@hadess.net>
In-Reply-To: <1489665702.18490.12.camel@hadess.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SGksDQoJVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLiBCdXQgSSBhbSBub3Qgc3VyZSB3aGF0IHlv
dXIgInR5cGUiIG1lYW4uDQpJZiB5b3UgbWVhbiAic2Vuc29yIHR5cGUiLCBJIGV4cG9zZSBpdCBh
cyBzZWNvbmQgQUNDLCB0aGUgc2Vuc29yIHR5cGUgaXMgdGhlIHNhbWUgd2l0aCB0aGUgZXhpc3Qg
QUNDLA0KSXQgY2Fubm90IGJlIHVzZWQgYXMgYSBkaXN0aW5jdGlvbi4NCklmIHlvdSBtZWFuIHRo
ZSAiY29ubmVjdGlvbiB0eXBlIiBJIHVzZWQgaW4gdGhlIHBhdGNoLCAiY29ubmVjdGlvbiB0eXBl
IiBpcyBvbmx5IGRlZmluZWQgaW4gSElEIGRyaXZlciwNCkl0IGlzIG5vdCBhIGNvbW1vbiBwcm9w
ZXJ0eSBpbiBJSU8uIFNvIG5vdCBnb29kIHRvIGV4cG9zZSBpdCBvdXQuDQoNCg0KQlINClNvbmcg
SG9uZ3lhbiAgDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBCYXN0aWVuIE5v
Y2VyYSBbbWFpbHRvOmhhZGVzc0BoYWRlc3MubmV0XSANClNlbnQ6IFRodXJzZGF5LCBNYXJjaCAx
NiwgMjAxNyA4OjAyIFBNDQpUbzogU29uZywgSG9uZ3lhbiA8aG9uZ3lhbi5zb25nQGludGVsLmNv
bT47IGxpbnV4LWlucHV0QHZnZXIua2VybmVsLm9yZzsgbGludXgtaWlvQHZnZXIua2VybmVsLm9y
Zw0KQ2M6IGppa29zQGtlcm5lbC5vcmc7IGppYzIzQGtlcm5lbC5vcmc7IFBhbmRydXZhZGEsIFNy
aW5pdmFzIDxzcmluaXZhcy5wYW5kcnV2YWRhQGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFU
Q0hdIGlpbzogaGlkOiBoaWQtc2Vuc29yLWFjY2VsLTNkOiBBZGQgc2Vjb25kIEFDQyBzZW5zb3Ig
c3VwcG9ydA0KDQpPbiBUaHUsIDIwMTctMDMtMTYgYXQgMTg6MjAgKzA4MDAsIFNvbmcgSG9uZ3lh
biB3cm90ZToNCj4gQXMgYWNjZWxlcm9tZXRlciBzZW5zb3IgYmVjb21lcyBtb3JlIGFuZCBtb3Jl
IHBvcHVsYXIsIHRoZXJlIGFyZSBtb3JlIA0KPiB1c2VyIHNjZW5hcmlvcyBoYXZlIGJlZW4gZGV2
ZWxvcGVkLCAiSGluZ2UiIGlzIGEgdmVyeSBpbXBvcnRhbnQgDQo+IHVzZWNhc2Ugd2hpY2ggbmVl
ZHMgdHdvIGFjY2VsZXJvbWV0ZXIgc2Vuc29ycyB0byBjYWxjdWxhdGUgdGhlIA0KPiBpbmNsdWRl
ZCBhbmdsZSBvZiBrZXlib2FyZCBhbmQgc2NyZWVuLg0KPiBJbiB0aGlzIGNhc2UsIHR3byBhY2Nl
bGVyb21ldGVyIHNlbnNvcnMgd2lsbCBiZSBleHBvc2VkLiBDdXJyZW50bHksIA0KPiBJSU8gaW50
ZXJmYWNlIGhhc24ndCBvdGhlciB3YXkgdG8gZGlzdGluZ3Vpc2ggdHdvIHNlbnNvcnMgd2l0aCBz
YW1lIA0KPiBzZW5zb3IgdHlwZSwgZXhjZXB0IHNlbnNvciBuYW1lLiBTbyBhIG5ldyBzZW5zb3Ig
bmFtZSAiYWNjZWxfMm5kXzNkIg0KPiBpcyBhZGRlZCBmb3Igc2Vjb25kYXJ5IGFjY2VsZXJvbWV0
ZXIgc2Vuc29yLg0KPiANCj4gSW4gSElEIGxldmVsLCBjb25uZWN0aW9uIHR5cGUgaXMgYSBnb29k
IGNvbW1vbiBwcm9wZXJ0eSB0byANCj4gZGlmZmVyZW50aWF0ZSB0d28gc2Vuc29ycyB3aXRoIHNh
bWUgc2Vuc29yIHR5cGUuDQoNCkkndmUgYmVlbiB0b2xkIGluIHRoZSBwYXN0IG5vdCB0byByZWx5
IG9uIGRldmljZSBuYW1lcyBpbiBpaW8tc2Vuc29yLSBwcm94eSwgYW5kIHRoaXMgd291bGQgZ28g
YWdhaW5zdCB0aGlzIGFkdmljZS4NCg0KQXMgeW91IGhhdmUgYSAidHlwZSIgdG8gZXhwb3J0LCB3
aHkgbm90IGV4cG9ydCB0aGF0IGluc3RlYWQ/DQo=
