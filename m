Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-bn3nam01on0074.outbound.protection.outlook.com ([104.47.33.74]:24096
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751835AbeBFHXW (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 6 Feb 2018 02:23:22 -0500
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "shreeya.patel23498@gmail.com" <shreeya.patel23498@gmail.com>
Subject: Re: [PATCH 1/2] Staging: iio: ade7758: Remove iio_dev mlock
Date: Tue, 6 Feb 2018 07:23:17 +0000
Message-ID: <1517901796.2857.3.camel@analog.com>
References: <cover.1517845616.git.shreeya.patel23498@gmail.com>
         <88eba335f73f931acb1e5d1be63992f8ae0fdc5b.1517845616.git.shreeya.patel23498@gmail.com>
In-Reply-To: <88eba335f73f931acb1e5d1be63992f8ae0fdc5b.1517845616.git.shreeya.patel23498@gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gVHVlLCAyMDE4LTAyLTA2IGF0IDAxOjA4ICswNTMwLCBTaHJlZXlhIFBhdGVsIHdyb3RlOg0K
PiBJbiB0aGUgYWRlNzc1OCBmaWxlLCByZWFkIHJhdyBkb2VzIG5vdCByZXF1aXJlIGlpb19kZXYt
Pm1sb2NrIGZvcg0KPiByZWFkcy4gSXQgY2FuIHJ1biBjb25jdXJyZW50bHkgYXMgcmVzb3VyY2Ug
cHJvdGVjdGlvbiBpcyBoYW5kbGVkDQo+IGJ5IGJ1Zl9sb2NrIGluIHJlYWQgcmVnaXN0ZXIuDQoN
ClJlbW92ZWQgbGludXgta2VybmVsIGxpc3QgYW5kIEdyZWcgZnJvbSByZXBseSBsaXN0Lg0KDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaHJlZXlhIFBhdGVsIDxzaHJlZXlhLnBhdGVsMjM0OThAZ21h
aWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvc3RhZ2luZy9paW8vbWV0ZXIvYWRlNzc1OF9jb3Jl
LmMgfCAyIC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvaWlvL21ldGVyL2FkZTc3NThfY29yZS5jIGIvZHJpdmVy
cy9zdGFnaW5nL2lpby9tZXRlci9hZGU3NzU4X2NvcmUuYw0KPiBpbmRleCA3YjdmZmU1Li4yMjdk
YmZjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3N0YWdpbmcvaWlvL21ldGVyL2FkZTc3NThfY29y
ZS5jDQo+ICsrKyBiL2RyaXZlcnMvc3RhZ2luZy9paW8vbWV0ZXIvYWRlNzc1OF9jb3JlLmMNCj4g
QEAgLTUyNiw5ICs1MjYsNyBAQCBzdGF0aWMgaW50IGFkZTc3NThfcmVhZF9yYXcoc3RydWN0IGlp
b19kZXYgKmluZGlvX2RldiwNCj4gIA0KPiAgCXN3aXRjaCAobWFzaykgew0KPiAgCWNhc2UgSUlP
X0NIQU5fSU5GT19TQU1QX0ZSRVE6DQo+IC0JCW11dGV4X2xvY2soJmluZGlvX2Rldi0+bWxvY2sp
Ow0KPiAgCQlyZXQgPSBhZGU3NzU4X3JlYWRfc2FtcF9mcmVxKCZpbmRpb19kZXYtPmRldiwgdmFs
KTsNCj4gLQkJbXV0ZXhfdW5sb2NrKCZpbmRpb19kZXYtPm1sb2NrKTsNCg0KdGhpcyBwYXRjaCBj
YW4gYmUgc3F1YXNoZWQgaW50byB0aGUgc2Vjb25kIG9uZQ0Kc2VtYW50aWNhbGx5IHRoZXkgYXJl
IHRoZSBzYW1lDQoNCj4gIAkJcmV0dXJuIHJldDsNCj4gIAlkZWZhdWx0Og0KPiAgCQlyZXR1cm4g
LUVJTlZBTDs=
