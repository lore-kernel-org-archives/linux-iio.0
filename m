Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0064.outbound.protection.outlook.com ([104.47.2.64]:40992
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753332AbeCFNEe (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Mar 2018 08:04:34 -0500
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "michael.hennerich@analog.com" <michael.hennerich@analog.com>
CC: "lars@metafoo.de" <lars@metafoo.de>,
        "21cnbao@gmail.com" <21cnbao@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: Work plan to move meter out of staging
Date: Tue, 6 Mar 2018 13:04:31 +0000
Message-ID: <1520341471.12790.35.camel@nxp.com>
References: <20180305140224.dgh3rcywgxgxsxbx@smtp.gmail.com>
         <1520259685.12790.12.camel@nxp.com>
         <e876642e-0286-9602-884f-00f026d6873f@metafoo.de>
         <f8f972b2-837d-b242-6fa3-40bf21952b0b@analog.com>
         <20180306123628.sawzr3k7ek3rkz46@smtp.gmail.com>
In-Reply-To: <20180306123628.sawzr3k7ek3rkz46@smtp.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gTWEsIDIwMTgtMDMtMDYgYXQgMDk6MzYgLTAzMDAsIFJvZHJpZ28gU2lxdWVpcmEgd3JvdGU6
DQo+IEhpLA0KPiANCj4gPiANCj4gPiBPbiAwNS4wMy4yMDE4IDE3OjMwLCBMYXJzLVBldGVyIENs
YXVzZW4gd3JvdGU6DQo+ID4gSW4gZ2VuZXJhbCBJIHRoaW5rIHRoaXMgaXMgYSBncmVhdCBpZGVh
LCBob3dldmVyIGxvb2tpbmcgYXQgaXQgZnJvbSBhDQo+ID4gZGlmZmVyZW50IGFuZ2xlIC0NCj4g
PiBNb3N0IG9mIHRoZSBzdXBwb3J0ZWQgbWV0ZXJpbmcgY2lyY3VpdHMgYXJlIGFscmVhZHkgbWFy
a2VkIGFzIG5vdA0KPiA+IHJlY29tbWVuZGVkIGZvciBuZXcgZGVzaWducy4NCj4gPiBXaGlsZSBB
bmFsb2cgRGV2aWNlcyBoYXZlIGEgdmVyeSBzdHJvbmcgcHJvZHVjdCBwb3J0Zm9saW8gaW4gdGhl
IE1ldGVyaW5nIElDDQo+ID4gc3BhY2UsIGFsbCBvZiB0aGUgcGFydHMgaW4NCj4gPiBzdGFnaW5n
L2lpby9tZXRlciBhcmUgZnJvbSAyMDExIGFuZCBiZWZvcmUgYW5kIGhhdmUgYWxyZWFkeSBzZWVu
IG11bHRpcGxlDQo+ID4gcHJvZHVjdCBpdGVyYXRpb25zIHNpbmNlIHRoZW4uDQo+ID4gQSBtYWpv
ciByZXdvcmsgb2YgdGhlc2UgZHJpdmVycyBtaWdodCByZXF1aXJlIHRlc3RpbmcsIHVuZm9ydHVu
YXRlbHkgdGhlc2UNCj4gPiBkcml2ZXJzIHdlcmUgZGV2ZWxvcGVkIGJ5IGEgZGlmZmVyZW50IHRl
YW0gd2hpY2ggbm93IHB1cnN1ZXMgZGlmZmVyZW50DQo+ID4gcmVzcG9uc2liaWxpdGllcy4NCj4g
PiBTbyBJIHdvbuKAmXQgYmUgYWJsZSB0byB0ZXN0IHRoZW0gYWdhaW4sIGFuZCB0aGVyZWZvcmUg
SeKAmW0gYWxzbyBhIGJpdCBoZXNpdGFudA0KPiA+IHRvIGxpZnQgdGhlbSBvdXQgb2Ygc3RhZ2lu
Zy4NCj4gSSBoYXZlIHNlZW4geW91ciBtZXNzYWdlIGEgZmV3IG1pbnV0ZXMgYWdvLCBqdXN0IGFm
dGVyIEkgc2VudCBhIHBhdGNoDQo+IHNlcmllcyB0aGF0IHJlbW92ZXMgY2hlY2twYXRjaCBwcm9i
bGVtcyBmcm9tIG1ldGVyIG1vZHVsZS4gQW55d2F5LCBhZnRlcg0KPiB5b3VyIGNvbW1lbnRzLCBJ
IGJlbGlldmUgdGhhdCBpcyBhIGJldHRlciBpZGVhIHRvIHdvcmsgb24gYW5vdGhlciBtb2R1bGUN
Cj4gaW4gdGhlIHN0YWdpbmcuIElzIHRoYXQgb2sgRGFuaWVsPw0KDQpIaSwNCg0KSSB0aGluayBp
dCBpcyBzdGlsbCBhIGdvb2QgaWRlYSB0byBtYWtlIHRoZSBjaGVja3BhdGNoIGNoYW5nZXMgaW4g
dGhlIG1ldGVyIGRpcmVjdG9yeQ0KZnJvbSBzdGFnaW5nLsKgDQo+IA0KPiBKdXN0IGZvciBjdXJp
b3NpdHksIHdoYXQgaXMgdGhlIHByb2Nlc3MgdG8gcmVtb3ZlIG1ldGVyIGZyb20gc3RhZ2luZz8N
Cg0KTWFrZSBzdXJlIHdlIHVzZSB0aGUgc3RhbmRhcmQgSUlPIGludGVyZmFjZXMsIGdvb2QgcXVh
bGl0eSBjb2RlIGFuZCBnb29kIHRlc3RpbmcgOikuDQoNCnRoYW5rcywNCkRhbmllbC4=
