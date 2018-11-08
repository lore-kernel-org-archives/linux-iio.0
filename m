Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-cys01nam02on0088.outbound.protection.outlook.com ([104.47.37.88]:61664
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726162AbeKHRTr (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Nov 2018 12:19:47 -0500
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "renatogeh@gmail.com" <renatogeh@gmail.com>,
        "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>
Subject: Re: [PATCH 3/3] staging: iio: ad7780: generates pattern_mask from
 PAT bits
Date: Thu, 8 Nov 2018 07:45:25 +0000
Message-ID: <75e7843ec80a3adc9f4b7ea0a7f0b33c3d518093.camel@analog.com>
References: <cover.1541615978.git.giuliano.belinassi@usp.br>
         <f7925df556f37f48ae0b1707239aff5a108fea1d.1541615978.git.giuliano.belinassi@usp.br>
In-Reply-To: <f7925df556f37f48ae0b1707239aff5a108fea1d.1541615978.git.giuliano.belinassi@usp.br>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTA3IGF0IDE2OjUwIC0wMjAwLCBHaXVsaWFubyBCZWxpbmFzc2kgd3Jv
dGU6DQo+IFByZXZpb3VzbHksIGFsbCBwYXR0ZXJuX21hc2tzIGluIHRoZSBjaGlwX2luZm8gdGFi
bGUgd2VyZSBoYXJkY29kZWQuIE5vdw0KPiB0aGV5DQo+IGFyZSBnZW5lcmF0ZWQgdXNpbmcgdGhl
IFBBVCBtYWNyb3MsIGFzIGRlc2NyaWJlZCBpbiB0aGUgZGF0YXNoZWV0cy4NCj4gDQoNCkkgbGlr
ZSB0aGlzIGNoYW5nZSA6KQ0KSSBvbmx5IGhhdmUgbml0cGlja3MuDQpTZWUgaW5saW5lLg0KDQoN
Cj4gU2lnbmVkLW9mZi1ieTogR2l1bGlhbm8gQmVsaW5hc3NpIDxnaXVsaWFuby5iZWxpbmFzc2lA
dXNwLmJyPg0KPiAtLS0NCj4gIGRyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jIHwgMTAg
KysrKysrLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlv
bnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAu
Yw0KPiBiL2RyaXZlcnMvc3RhZ2luZy9paW8vYWRjL2FkNzc4MC5jDQo+IGluZGV4IDBhNDczYWFl
NTJmMi4uZmE5ZTA0N2I1MTkxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlvL2Fk
Yy9hZDc3ODAuYw0KPiArKysgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc3ODAuYw0KPiBA
QCAtMzEsNiArMzEsOCBAQA0KPiAgI2RlZmluZSBBRDc3ODBfUEFUMQlCSVQoMSkNCj4gICNkZWZp
bmUgQUQ3NzgwX1BBVDAJQklUKDApDQo+ICANCj4gKyNkZWZpbmUgQUQ3MTcwX1BBVDIJQklUKDIp
DQo+ICsNCj4gIHN0cnVjdCBhZDc3ODBfY2hpcF9pbmZvIHsNCj4gIAlzdHJ1Y3QgaWlvX2NoYW5f
c3BlYwljaGFubmVsOw0KPiAgCXVuc2lnbmVkIGludAkJcGF0dGVybl9tYXNrOw0KPiBAQCAtMTM3
LDI1ICsxMzksMjUgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhZDc3ODBfY2hpcF9pbmZvDQo+IGFk
Nzc4MF9jaGlwX2luZm9fdGJsW10gPSB7DQo+ICAJW0lEX0FENzE3MF0gPSB7DQo+ICAJCS5jaGFu
bmVsID0gQUQ3NzgwX0NIQU5ORUwoMTIsIDI0KSwNCj4gIAkJLnBhdHRlcm4gPSAweDUsDQo+IC0J
CS5wYXR0ZXJuX21hc2sgPSAweDcsDQo+ICsJCS5wYXR0ZXJuX21hc2sgPSBBRDc3ODBfUEFUMCB8
IEFENzc4MF9QQVQxIHwgQUQ3MTcwX1BBVDIsDQoNCklmIHlvdSBhcmUgdXBkYXRpbmcgdGhlc2Ug
cGF0dGVybiBtYXNrcywgeW91IHNob3VsZCB1cGRhdGUgdGhlIGRlZmF1bHQNCnBhdHRlcm5zIGFz
IHdlbGwgd2l0aCB0aGUgbWFjcm9zIHRvIGJlIGNvbnNpc3RlbnQuDQoNCkFuZCB0byBiZSBhIGJp
dCBtb3JlIGNvbXBhY3QsIHlvdSBjb3VsZCBkZWZpbmU6DQoNCiNkZWZpbmUgQUQ3MTcwX1BBVFRF
Uk5fTUFTSwkoQUQ3NzgwX1BBVDAgfCBBRDc3ODBfUEFUMSB8IEFENzE3MF9QQVQyKQ0KI2QNCmVm
aW5lIEFENzc4MF9QQVRURVJOX01BU0sJKEFENzc4MF9QQVQwIHwgQUQ3NzgwX1BBVDEpDQoNCiNk
ZWZpbmUgQUQ3MTcwX1BBVFRFUk4JCShBRDc3ODBfUEFUMSB8IEFENzE3MF9QQVQyKQ0KI2RlZmlu
ZSBBRDc3ODBfUEFUVEVSTgkJKEFENzc4MF9QQVQwKQ0KDQpUaGVuIHlvdSBjYW4gYXNzaWduIEFE
NzE3MF9QQVRURVJOW19NQVNLXSB0byBBRDcxNzAvQUQ3MTcxICYgDQpBRDc3ODBfUEFUVEVSTltf
TUFTS10gdG8gQUQ3NzgwL0FENzc4MS4NCg0KPiAgCQkuaXNfYWQ3Nzh4ID0gZmFsc2UsDQo+ICAJ
fSwNCj4gIAlbSURfQUQ3MTcxXSA9IHsNCj4gIAkJLmNoYW5uZWwgPSBBRDc3ODBfQ0hBTk5FTCgx
NiwgMjQpLA0KPiAgCQkucGF0dGVybiA9IDB4NSwNCj4gLQkJLnBhdHRlcm5fbWFzayA9IDB4NywN
Cj4gKwkJLnBhdHRlcm5fbWFzayA9IEFENzc4MF9QQVQwIHwgQUQ3NzgwX1BBVDEgfCBBRDcxNzBf
UEFUMiwNCj4gIAkJLmlzX2FkNzc4eCA9IGZhbHNlLA0KPiAgCX0sDQo+ICAJW0lEX0FENzc4MF0g
PSB7DQo+ICAJCS5jaGFubmVsID0gQUQ3NzgwX0NIQU5ORUwoMjQsIDMyKSwNCj4gIAkJLnBhdHRl
cm4gPSAweDEsDQo+IC0JCS5wYXR0ZXJuX21hc2sgPSAweDMsDQo+ICsJCS5wYXR0ZXJuX21hc2sg
PSBBRDc3ODBfUEFUMCB8IEFENzc4MF9QQVQxLA0KPiAgCQkuaXNfYWQ3Nzh4ID0gdHJ1ZSwNCj4g
IAl9LA0KPiAgCVtJRF9BRDc3ODFdID0gew0KPiAgCQkuY2hhbm5lbCA9IEFENzc4MF9DSEFOTkVM
KDIwLCAzMiksDQo+ICAJCS5wYXR0ZXJuID0gMHgxLA0KPiAtCQkucGF0dGVybl9tYXNrID0gMHgz
LA0KPiArCQkucGF0dGVybl9tYXNrID0gQUQ3NzgwX1BBVDAgfCBBRDc3ODBfUEFUMSwNCj4gIAkJ
LmlzX2FkNzc4eCA9IHRydWUsDQo+ICAJfSwNCj4gIH07DQo=
