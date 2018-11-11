Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr70109.outbound.protection.outlook.com ([40.107.7.109]:30688
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728773AbeKLCig (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 21:38:36 -0500
From: Peter Rosin <peda@axentia.se>
To: Jonathan Cameron <jic23@kernel.org>
CC: Chris Coffey <cmc@babblebit.net>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Slawomir Stepien <sst@poczta.fm>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH] iio: potentiometer: Add driver for Microchip
 MCP41xxx/42xxx
Date: Sun, 11 Nov 2018 16:49:28 +0000
Message-ID: <1d5f47e8-b69c-e40f-9b4f-7423ee485747@axentia.se>
References: <20181106113130.9612-1-cmc@babblebit.net>
 <6f3ead94-b1ed-900d-b675-3822d67dbfd7@axentia.se>
 <20181111145530.2463b9c3@archlinux>
In-Reply-To: <20181111145530.2463b9c3@archlinux>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gMjAxOC0xMS0xMSAxNTo1NSwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gT24gVHVlLCA2
IE5vdiAyMDE4IDE2OjM3OjExICswMDAwDQo+IFBldGVyIFJvc2luIDxwZWRhQGF4ZW50aWEuc2U+
IHdyb3RlOg0KPiANCj4+IEhpIQ0KPj4NCj4+IFNvbWUgY29tbWVudHMgaW5saW5lLi4uDQo+IEEg
ZmV3IGFkZGl0aW9ucyBmcm9tIG1lLg0KDQoqc25pcCoNCg0KPj4+ICsJZGF0YSA9IGlpb19wcml2
KGluZGlvX2Rldik7DQo+Pj4gKwlzcGlfc2V0X2RydmRhdGEoc3BpLCBpbmRpb19kZXYpOw0KPj4+
ICsJZGF0YS0+c3BpID0gc3BpOw0KPj4+ICsJZGF0YS0+Y2ZnID0gJm1jcDQxMDEwX2NmZ1tkZXZp
ZF07ICANCj4+DQo+PiBJJ20gbWlzc2luZyBhICJvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEoZGV2
KSIgY2FsbCBzb21ld2hlcmUgaW4gaGVyZSwgc2VlIGUuZy4gdGhlDQo+PiBtYXg1NDgxLmMgZmls
ZSBpbiB0aGlzIGRpcmVjdG9yeS4gWWVzLCB0aGF0J3MgbWlzc2luZyBmcm9tIHRoZSBtY3A0MTMx
IGRyaXZlciBhcw0KPj4gd2VsbCwgYnV0IHRoYXQncyBub3QgYSB2YWxpZCByZWFzb24gZm9yIG5v
dCBkb2luZyBpdCBoZXJlIEFGQUlDVC4uLg0KPiBJZiB5b3Ugd2FudCB0byB1c2UgdGhlIGRhdGEg
ZWxlbWVudHMgZnJvbSB0aGUgZGV2aWNldHJlZSBiaW5kaW5ncyB5b3UnbGwgbmVlZA0KPiB0byBk
byB0aGF0LiAgSG93ZXZlciwgdGhlcmUgaXMgYW4gb2RkIHBhdGggdGhhdCBhY3R1YWxseSBtZWFu
cyBpdCB3aWxsIGZhbGwgYmFjaw0KPiB0byBnZXR0aW5nIHRoZSByaWdodCB0aGluZyBhcyB5b3Ug
aGF2ZSBpdCBoZXJlLg0KPiBzcGlfZ2V0X2RldmljZV9pZCBjYWxscyBzcGlfbWF0Y2hfaWQgd2hp
Y2ggY29tcGFyZXMgdGhlIHNkZXYtPm1vZGFsaWFzDQo+IHdpdGggdGhlIGlkIHRhYmxlIG5hbWVz
LiAgbW9kYWxpYXMgaGFzIGJlZW4gY2FyZWZ1bGx5IGNvbnN0cnVjdGVkDQo+IHRvIGJlIHRoZSB0
ZXh0IGFmdGVyIHRoZSBjb21tYSBvbmx5IGFuZCBhcyBzdWNoIHRoaXMgd29ya3MgYXMgaXMuDQo+
IA0KPiBQZXJoYXBzIGl0J3MgbmVhdGVyIHRob3VnaCB0byBqdXN0IHVzZSB0aGUgZGV2aWNldHJl
ZSBhY2Nlc3MgZnVuY3Rpb25zLg0KDQpJc24ndCB0aGF0IHBhcnQgYWJvdXQgbm90IGxvb2tpbmcg
YXQgdGhlIHZlbmRvci1wYXJ0IG9mIHRoZSBEVC1jb21wYXRpYmxlIHNsaWdodGx5DQpmcmFnaWxl
PyBPciB3aWxsIG1vZGFsaWFzL2NoaXAtbnVtYmVyIGNsYXNoZXMgYmUgZGV0ZWN0ZWQgYnkgc29t
ZXRoaW5nPw0KDQpDaGVlcnMsDQpQZXRlcg0K
