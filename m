Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-co1nam03on0074.outbound.protection.outlook.com ([104.47.40.74]:6616
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728627AbeKBAF4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 1 Nov 2018 20:05:56 -0400
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@usp.br" <giuliano.belinassi@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH v3 1/3] staging: iio: ad7780: fix offset read value
Date: Thu, 1 Nov 2018 15:02:32 +0000
Message-ID: <17254fcab5fb927e31ba6eac2194b0aeb9456cf0.camel@analog.com>
References: <cover.1541082656.git.renatogeh@gmail.com>
         <2191be4d531651db39682178ec0660eeb5697439.1541082656.git.renatogeh@gmail.com>
In-Reply-To: <2191be4d531651db39682178ec0660eeb5697439.1541082656.git.renatogeh@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

R29vZCBjYXRjaC4NCg0KQWNrZWQtYnk6IEFsZXhhbmRydSBBcmRlbGVhbiA8YWxleGFuZHJ1LmFy
ZGVsZWFuQGFuYWxvZy5jb20+DQoNCk9uIFRodSwgMjAxOC0xMS0wMSBhdCAxMTo0MyAtMDMwMCwg
UmVuYXRvIEx1aSBHZWggd3JvdGU6DQo+IFZhcmlhYmxlIHZhbCBzdWJ0cmFjdGVkIGFuIHVuaW5p
dGlhbGl6ZWQgdmFsdWUgb24gSUlPX0NIQU5fSU5GT19PRkZTRVQuDQo+IFRoaXMgd2FzIGZpeGVk
IGJ5IGFzc2lnbmluZyB0aGUgY29ycmVjdCB2YWx1ZSBpbnN0ZWFkLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogUmVuYXRvIEx1aSBHZWggPHJlbmF0b2dlaEBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJp
dmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBiL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2Fk
Nzc4MC5jDQo+IGluZGV4IGI2NzQxMmRiMDMxOC4uOTFlMDE2ZDUzNGVkIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdp
bmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBAQCAtOTYsNyArOTYsNyBAQCBzdGF0aWMgaW50IGFkNzc4
MF9yZWFkX3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPiAgCQkqdmFsMiA9IGNoYW4t
PnNjYW5fdHlwZS5yZWFsYml0cyAtIDE7DQo+ICAJCXJldHVybiBJSU9fVkFMX0ZSQUNUSU9OQUxf
TE9HMjsNCj4gIAljYXNlIElJT19DSEFOX0lORk9fT0ZGU0VUOg0KPiAtCQkqdmFsIC09ICgxIDw8
IChjaGFuLT5zY2FuX3R5cGUucmVhbGJpdHMgLSAxKSk7DQo+ICsJCSp2YWwgPSAtKDEgPDwgKGNo
YW4tPnNjYW5fdHlwZS5yZWFsYml0cyAtIDEpKTsNCj4gIAkJcmV0dXJuIElJT19WQUxfSU5UOw0K
PiAgCX0NCj4gIA0K
