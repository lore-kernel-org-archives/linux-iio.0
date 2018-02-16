Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0064.outbound.protection.outlook.com ([104.47.2.64]:24480
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1032862AbeBPN5U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 16 Feb 2018 08:57:20 -0500
From: Daniel Baluta <daniel.baluta@nxp.com>
To: "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "rodrigosiqueiramelo@gmail.com" <rodrigosiqueiramelo@gmail.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] iio: apply coding-style into ms5611_probe function
Date: Fri, 16 Feb 2018 13:57:17 +0000
Message-ID: <1518789437.9517.32.camel@nxp.com>
References: <20180216133841.3yt4ip3tbck7ihdm@smtp.gmail.com>
In-Reply-To: <20180216133841.3yt4ip3tbck7ihdm@smtp.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

SGkgUm9kcmlnbywNCg0KTW9zdGx5IGxvb2tpbmcgZ29vZC4gRmV3IGNvbW1lbnRzLg0KDQpQbGVh
c2UgcmVhZDoNCg0KaHR0cHM6Ly9jaHJpcy5iZWFtcy5pby9wb3N0cy9naXQtY29tbWl0Lw0KDQox
KSBDYXBpdGFsaXplIHRoZSBmaXJzdCBsZXR0ZXIgb2YgY29tbWl0DQoyKSBVc2UgcHJlZml4IHRh
Z3MgdG8gaW5kaWNhdGUgdGhlIGRyaXZlciB0aGF0IGlzIGNoYW5nZWQuIEhlcmUgaWlvOnByZXNz
dXJlOm1zNTYxMS4NCg0KSWYgbm90IHN1cmUgd2hhdCBwcmVmaXggdGFncyB0byB1c2UgcGxlYXNl
IHVzZSBnaXQgbG9nIGZpbGUuYyBhbmQgc2VlIHRoZSB0YWdzIHVzZWQgYnkgcHJldmlvdXMgY29t
bWl0cy4NCklmIG5vdCBjbGVhciBmcm9tIHByZXZpb3VzIGNvbW1pdHMgYmUgY3JlYXRpdmUhIDop
DQoNCjMpIEEgYmV0dGVyIHZlcmIgZGVzY3JpYmluZyB0aGUgY2hhbmdlIHdvdWxkIGJlIEZpeCBp
bnN0ZWFkIG9mIEFwcGx5Lg0KDQpTbywgdGhlIGNvbW1pdCBzdWJqZWN0IHNob3VsZCBiZToNCg0K
aWlvOnByZXNzdXJlOm1zNTYxMTogRml4IGNvZGluZyBzdHlsZSBpbiBwcm9iZSBmdW5jdGlvbg0K
DQo0KSBQbGVhc2UgY29ycmVjdCBhbGwgdGhlIG9jY3VyZW5jZXMgb2YgdGhlIHNhbWUgY29kaW5n
IHN0eWxlIGVycm9yIChub3Qgc3VyZSBpZiBoZXJlIGlzIHRoZSBjYXNlKS4NCg0KT3RoZXIgdGhh
biB0aGF0IGl0IGxvb2tzIGdvb2QgdG8gbWUuIFBsZWFzZSBzZW5kIHYyLg0KDQpEbyBub3QgZm9y
Z2V0IHRvIGFkZCB1bmRlciB0aGUgc2Npc3NvciBsaW5lIG9mIHRoZSBuZXcgcGF0Y2ggYSBzbWFs
bCBjaGFuZ2Vsb2cgZG9jdW1lbnRpbmcgd2hhdA0KaGFzIGNoYW5nZWQgc2luY2UgdjEuDQoNCg0K
DQpPbiBWaSwgMjAxOC0wMi0xNiBhdCAxMTozOCAtMDIwMCwgcm9kcmlnb3NpcXVlaXJhIHdyb3Rl
Og0KPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBjaGVja3BhdGNoLnBsIHdhcm5pbmcgYW5kIGVycm9y
Og0KPiANCj4gaWlvL3ByZXNzdXJlL21zNTYxMS5oOjY2OiBFUlJPUjogY29kZSBpbmRlbnQgc2hv
dWxkIHVzZSB0YWJzIHdoZXJlIHBvc3NpYmxlDQo+IGlpby9wcmVzc3VyZS9tczU2MTEuaDo2Njog
V0FSTklORzogcGxlYXNlLCBubyBzcGFjZXMgYXQgdGhlIHN0YXJ0IG9mIGEgbGluZQ0KPiBpaW8v
cHJlc3N1cmUvbXM1NjExLmg6NjY6IEVSUk9SOiAiZm9vKiBiYXIiIHNob3VsZCBiZSAiZm9vICpi
YXIiDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2RyaWdvIFNpcXVlaXJhIDxyb2RyaWdvc2lxdWVp
cmFtZWxvQGdtYWlsLmNvbT4NCj4gLS0tDQo+IA0KDQpeIHRoaXMgaXMgdGhlIHNjaXNzb3IgbGlu
ZS4NCg0KdGhhbmtzLA0KRGFuaWVsLg==
