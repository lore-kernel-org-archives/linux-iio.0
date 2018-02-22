Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0060.outbound.protection.outlook.com ([104.47.2.60]:63216
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751657AbeBVHxh (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 22 Feb 2018 02:53:37 -0500
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "daniel.baluta@gmail.com" <daniel.baluta@gmail.com>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
Subject: Re: [PATCH v2] iio:dummy: Replace S_IWUSR by 0200
Date: Thu, 22 Feb 2018 07:53:33 +0000
Message-ID: <1519286013.13463.59.camel@nxp.com>
References: <20180221192807.qfyhp7z27f6r6p47@smtp.gmail.com>
         <CAEnQRZBq3G+RPq66ObW+CM2A9BOE_tBn-fC++Ksy+O_nEFfz9Q@mail.gmail.com>
         <20180222074318.qsf7x4jnyhvasq5u@mwanda>
In-Reply-To: <20180222074318.qsf7x4jnyhvasq5u@mwanda>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SGkgRGFuLA0KDQpPbiBKbywgMjAxOC0wMi0yMiBhdCAxMDo0MyArMDMwMCwgRGFuIENhcnBlbnRl
ciB3cm90ZToNCj4gT24gV2VkLCBGZWIgMjEsIDIwMTggYXQgMTE6MDE6NTBQTSArMDIwMCwgRGFu
aWVsIEJhbHV0YSB3cm90ZToNCj4gPiANCj4gPiBPbiBXZWQsIEZlYiAyMSwgMjAxOCBhdCA5OjI4
IFBNLCBSb2RyaWdvIFNpcXVlaXJhDQo+ID4gPHJvZHJpZ29zaXF1ZWlyYW1lbG9AZ21haWwuY29t
PiB3cm90ZToNCj4gPiA+IA0KPiA+ID4gVGhpcyBwYXRjaCBmaXhlcyB0aGUgY2hlY2twYXRjaC5w
bCB3YXJuaW5nOg0KPiA+ID4gDQo+ID4gPiBkcml2ZXJzL2lpby9kdW1teS9paW9fZHVtbXlfZXZn
ZW4uYzoxNTE6IFdBUk5JTkc6IFN5bWJvbGljIHBlcm1pc3Npb25zDQo+ID4gPiAnU19JV1VTUicg
YXJlIG5vdCBwcmVmZXJyZWQuIENvbnNpZGVyIHVzaW5nIG9jdGFsIHBlcm1pc3Npb25zICcwMjAw
Jy4NCj4gPiA+IA0KPiA+ID4gLi4uIFdoeSB0aGlzICIuLi4iIDopPw0KPiA+IENvbW1pdCBzdWJq
ZWN0IGNvdWxkIGJlIGRvbmUgYmV0dGVyLiBJdCBpcyBwcmV0dHkgb2J2aW91cyBmcm9tIHRoZSBj
b2RlIHRoYXQNCj4gPiB3ZSBjaGFuZ2UgU19JV1VTUiB3aXRoIDAyMDAuDQo+ID4gDQo+ID4gQmV0
dGVyIG1lc3NhZ2U6DQo+ID4gDQo+ID4gaWlvOmR1bW15OiBGaXggcG9rZV9ldk4gZmlsZSBwZXJt
aXNzaW9ucw0KPiBQbGVhc2Ugc3RvcCB0ZWxsaW5nIHBlb3BsZSB0byBzYXkgIkZpeCIgd2hlbiBp
dCdzIG5vdCBhIGJ1ZyBmaXguLi4NCj4gDQoNCkkgYWdyZWUgd2l0aCB5b3UgdGhhdCBoZXJlICJG
aXgiIGlzIGFuIG92ZXJzdGF0ZW1lbnQuDQoNCj4gQWxzbyB3aG8gY2FyZXM/wqDCoFRoZSBjb21t
aXQgbWVzc2FnZSBpcyBwZXJmZWN0bHkgY2xlYXIuDQoNCkkgZG8gY2FyZSBhYm91dCBuZXdjb21l
cnMgcmVhbGx5IGxlYXJuaW5nIG9uIGhvdyB0byB3cml0ZSBhIHByb3Blcg0KY29tbWl0IG1lc3Nh
Z2UuDQoNClRoZSBjb21taXQgbWVzc3NhZ2Ugc2hvdWxkIHJlYWxseSBzYXkgd2h5IHRoZSBwYXRj
aCBpcyBuZWVkZWQsIG5vIHdoYXQgdGhlIHBhdGNoIGRvZXMuDQoNCkFmdGVyIHNldmVyYWwgdHJp
dmlhbCBwYXRjaGVzIG5ld2NvbWVycyB3aWxsIGdldCBpbnRvIG1vcmUgc2VyaW91cyBzdHVmZiBh
bmQgSSB3b3VsZG4ndA0Kd2FudCB0byBzZWUgYSBwYXRjaCB3aXRoIGNvbW1pdCBtZXNzYWdlIGxp
a2UgdGhpczoNCg0KaWlvOiBDaGFuZ2UgYml0IDEgb2Ygc3RhdHVzIHJlZ2lzdGVyDQoNCmJ1dCBv
bmUgdGhhdCBsb29rcyBsaWtlIHRoaXM6DQoNCmlpbzogU2V0IHBvd2VyIHVwIG9uIGNoaXAgcHJv
YmUNCg0KdGhhbmtzLA0KRGFuaWVsLg0KDQoNCg==
