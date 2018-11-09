Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr710080.outbound.protection.outlook.com ([40.107.71.80]:58096
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727519AbeKIRyU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 9 Nov 2018 12:54:20 -0500
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>,
        "nishadkamdar@gmail.com" <nishadkamdar@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 4/4] staging: iio: ad7816: Add device tree table.
Date: Fri, 9 Nov 2018 08:11:57 +0000
Message-ID: <c2dd05ea2893315e848bcf48af5e51b415d7a22c.camel@analog.com>
References: <cover.1541733949.git.nishadkamdar@gmail.com>
         <209172d47d8d14c1244556e5f05bbd6455b4de04.1541733949.git.nishadkamdar@gmail.com>
In-Reply-To: <209172d47d8d14c1244556e5f05bbd6455b4de04.1541733949.git.nishadkamdar@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gRnJpLCAyMDE4LTExLTA5IGF0IDEzOjA4ICswNTMwLCBOaXNoYWQgS2FtZGFyIHdyb3RlOg0K
PiBBZGQgZGV2aWNlIHRyZWUgdGFibGUgZm9yIG1hdGNoaW5nIHZlbmRvciBJRC4NCg0KT25lIGNv
bW1lbnQgaW5saW5lIGZvciB0aGlzLg0KDQpUaGFua3MNCkFsZXgNCg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogTmlzaGFkIEthbWRhciA8bmlzaGFka2FtZGFyQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBk
cml2ZXJzL3N0YWdpbmcvaWlvL2FkYy9hZDc4MTYuYyB8IDcgKysrKysrKw0KPiAgMSBmaWxlIGNo
YW5nZWQsIDcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2lu
Zy9paW8vYWRjL2FkNzgxNi5jDQo+IGIvZHJpdmVycy9zdGFnaW5nL2lpby9hZGMvYWQ3ODE2LmMN
Cj4gaW5kZXggYTJmZWFkODVjZDQ2Li5iOGE5MTQ5ZmJhYzEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZl
cnMvc3RhZ2luZy9paW8vYWRjL2FkNzgxNi5jDQo+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9paW8v
YWRjL2FkNzgxNi5jDQo+IEBAIC00MjIsNiArNDIyLDEyIEBAIHN0YXRpYyBpbnQgYWQ3ODE2X3By
b2JlKHN0cnVjdCBzcGlfZGV2aWNlICpzcGlfZGV2KQ0KPiAgCXJldHVybiAwOw0KPiAgfQ0KPiAg
DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhZDc4MTZfb2ZfbWF0Y2hbXSA9
IHsNCj4gKwl7IC5jb21wYXRpYmxlID0gImFkaSxhZDc4MTYiLCB9LA0KDQpJIHRoaW5rIHlvdSBh
bHNvIG5lZWQgdG8gYWRkOg0KKwl7IC5jb21wYXRpYmxlID0gImFkaSxhZDc4MTciLCB9LA0KKwl7
IC5jb21wYXRpYmxlID0gImFkaSxhZDc4MTgiLCB9LA0KDQo+ICsJeyB9DQo+ICt9Ow0KPiArTU9E
VUxFX0RFVklDRV9UQUJMRShvZiwgYWQ3ODE2X29mX21hdGNoKTsNCj4gKw0KPiAgc3RhdGljIGNv
bnN0IHN0cnVjdCBzcGlfZGV2aWNlX2lkIGFkNzgxNl9pZFtdID0gew0KPiAgCXsgImFkNzgxNiIs
IElEX0FENzgxNiB9LA0KPiAgCXsgImFkNzgxNyIsIElEX0FENzgxNyB9LA0KPiBAQCAtNDM0LDYg
KzQ0MCw3IEBAIE1PRFVMRV9ERVZJQ0VfVEFCTEUoc3BpLCBhZDc4MTZfaWQpOw0KPiAgc3RhdGlj
IHN0cnVjdCBzcGlfZHJpdmVyIGFkNzgxNl9kcml2ZXIgPSB7DQo+ICAJLmRyaXZlciA9IHsNCj4g
IAkJLm5hbWUgPSAiYWQ3ODE2IiwNCj4gKwkJLm9mX21hdGNoX3RhYmxlID0gb2ZfbWF0Y2hfcHRy
KGFkNzgxNl9vZl9tYXRjaCksDQo+ICAJfSwNCj4gIAkucHJvYmUgPSBhZDc4MTZfcHJvYmUsDQo+
ICAJLmlkX3RhYmxlID0gYWQ3ODE2X2lkLA0K
