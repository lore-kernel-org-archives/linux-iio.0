Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-dm3nam03on0078.outbound.protection.outlook.com ([104.47.41.78]:1206
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726454AbeKHRMP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 8 Nov 2018 12:12:15 -0500
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
Subject: Re: [PATCH 2/3] staging: iio: ad7780: check if ad778x before gain
 update
Date: Thu, 8 Nov 2018 07:37:59 +0000
Message-ID: <a2395b548ab5dce9b001484bbf4de7994e5e2da2.camel@analog.com>
References: <cover.1541615978.git.giuliano.belinassi@usp.br>
         <2a521e5f036eb74b684f368a6227509cac93fe0d.1541615978.git.giuliano.belinassi@usp.br>
In-Reply-To: <2a521e5f036eb74b684f368a6227509cac93fe0d.1541615978.git.giuliano.belinassi@usp.br>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gV2VkLCAyMDE4LTExLTA3IGF0IDE2OjUwIC0wMjAwLCBHaXVsaWFubyBCZWxpbmFzc2kgd3Jv
dGU6DQo+IE9ubHkgdGhlIGFkNzc4eCBoYXZlIHRoZSAnZ2Fpbicgc3RhdHVzIGJpdC4gQ2hlY2sg
aXQgYmVmb3JlIHVwZGF0aW5nLg0KPiANCg0KVGhpcyBsb29rcyBnb29kLg0KVGhlIG9ubHkgbm90
ZSBpcyB0aGF0IGl0IGNhbiBiZSBzcXVhc2hlZCB3aXRoIHRoZSAxc3QgcGF0Y2ggKHdoaWNoIEkg
bm90ZWQNCm9uIHRoZSAxc3QgcGF0Y2gpLg0KDQo+IFNpZ25lZC1vZmYtYnk6IEdpdWxpYW5vIEJl
bGluYXNzaSA8Z2l1bGlhbm8uYmVsaW5hc3NpQHVzcC5icj4NCj4gLS0tDQo+ICBkcml2ZXJzL3N0
YWdpbmcvaWlvL2FkYy9hZDc3ODAuYyB8IDEwICsrKysrKy0tLS0NCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gYi9kcml2ZXJzL3N0YWdpbmcvaWlvL2Fk
Yy9hZDc3ODAuYw0KPiBpbmRleCA2ZTUxYmZkYjA3NmEuLjBhNDczYWFlNTJmMiAxMDA2NDQNCj4g
LS0tIGEvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gKysrIGIvZHJpdmVycy9z
dGFnaW5nL2lpby9hZGMvYWQ3NzgwLmMNCj4gQEAgLTExNCwxMCArMTE0LDEyIEBAIHN0YXRpYyBp
bnQgYWQ3NzgwX3Bvc3Rwcm9jZXNzX3NhbXBsZShzdHJ1Y3QNCj4gYWRfc2lnbWFfZGVsdGEgKnNp
Z21hX2RlbHRhLA0KPiAgCSAgICAoKHJhd19zYW1wbGUgJiBjaGlwX2luZm8tPnBhdHRlcm5fbWFz
aykgIT0gY2hpcF9pbmZvLT5wYXR0ZXJuKSkNCj4gIAkJcmV0dXJuIC1FSU87DQo+ICANCj4gLQlp
ZiAocmF3X3NhbXBsZSAmIEFENzc4MF9HQUlOKQ0KPiAtCQlzdC0+Z2FpbiA9IDE7DQo+IC0JZWxz
ZQ0KPiAtCQlzdC0+Z2FpbiA9IDEyODsNCj4gKwlpZiAoY2hpcF9pbmZvLT5pc19hZDc3OHgpIHsN
Cj4gKwkJaWYgKHJhd19zYW1wbGUgJiBBRDc3ODBfR0FJTikNCj4gKwkJCXN0LT5nYWluID0gMTsN
Cj4gKwkJZWxzZQ0KPiArCQkJc3QtPmdhaW4gPSAxMjg7DQo+ICsJfQ0KPiAgDQo+ICAJcmV0dXJu
IDA7DQo+ICB9DQo=
