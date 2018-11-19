Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-eopbgr680059.outbound.protection.outlook.com ([40.107.68.59]:57901
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726784AbeKSSpP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 19 Nov 2018 13:45:15 -0500
From: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
To: "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "matheus.bernardino@usp.br" <matheus.bernardino@usp.br>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "victorcolombo@gmail.com" <victorcolombo@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] dt-bindings:iio:resolver: Add docs for ad2s90
Date: Mon, 19 Nov 2018 08:22:14 +0000
Message-ID: <563614e00314ba92b9513645a82fde06504a42d5.camel@analog.com>
References: <20181118042540.12697-1-matheus.bernardino@usp.br>
         <20181118042540.12697-5-matheus.bernardino@usp.br>
In-Reply-To: <20181118042540.12697-5-matheus.bernardino@usp.br>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

T24gU3VuLCAyMDE4LTExLTE4IGF0IDAyOjI1IC0wMjAwLCBNYXRoZXVzIFRhdmFyZXMgd3JvdGU6
DQo+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgZGV2aWNlIHRyZWUgYmluZGluZyBkb2N1bWVudGF0aW9u
IGZvciB0aGUgYWQyczkwDQo+IHJlc29sdmVyLXRvLWRpZ2l0YWwgY29udmVydGVyLg0KPiANCg0K
T25lIG1pbm9yIGNvbW1lbnQgaW5saW5lLg0KDQo+IFNpZ25lZC1vZmYtYnk6IE1hdGhldXMgVGF2
YXJlcyA8bWF0aGV1cy5iZXJuYXJkaW5vQHVzcC5icj4NCj4gLS0tDQo+IENoYW5nZXMgaW4gdjI6
DQo+ICAtIFJld3JpdHRlbiAnc3BpLWNwb2wgYW5kIHNwaS1jcGhhJyBpdGVtIHRvIHNheSB0aGF0
IHRoZSBkZXZpY2UgY2FuDQo+ICB3b3JrIGluIGVpdGhlciBtb2RlICgwLDApIG9yICgxLDEpIGFu
ZCBleHBsYWluIGhvdyB0aGV5IHNob3VsZCBiZQ0KPiAgc3BlY2lmaWVkIGluIERULg0KPiANCj4g
IC4uLi9iaW5kaW5ncy9paW8vcmVzb2x2ZXIvYWQyczkwLnR4dCAgICAgICAgICB8IDI4ICsrKysr
KysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspDQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lp
by9yZXNvbHZlci9hZDJzOTAudHh0DQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9yZXNvbHZlci9hZDJzOTAudHh0DQo+IGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9yZXNvbHZlci9hZDJzOTAudHh0DQo+IG5ldyBm
aWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uNTk0NDE3NTM5OTM4DQo+IC0t
LSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lp
by9yZXNvbHZlci9hZDJzOTAudHh0DQo+IEBAIC0wLDAgKzEsMjggQEANCj4gK0FuYWxvZyBEZXZp
Y2VzIEFEMlM5MCBSZXNvbHZlci10by1EaWdpdGFsIENvbnZlcnRlcg0KPiArDQo+ICtodHRwczov
L3d3dy5hbmFsb2cuY29tL2VuL3Byb2R1Y3RzL2FkMnM5MC5odG1sDQo+ICsNCj4gK1JlcXVpcmVk
IHByb3BlcnRpZXM6DQo+ICsgIC0gY29tcGF0aWJsZTogc2hvdWxkIGJlICJhZGksYWQyczkwIg0K
PiArICAtIHJlZzogU1BJIGNoaXAgc2VsZWN0IG51bWJlciBmb3IgdGhlIGRldmljZQ0KPiArICAt
IHNwaS1tYXgtZnJlcXVlbmN5OiBzZXQgbWF4aW11bSBjbG9jayBmcmVxdWVuY3ksIG11c3QgYmUg
ODMwMDAwDQo+ICsgIC0gc3BpLWNwb2wgYW5kIHNwaS1jcGhhOg0KPiArICAgICAgICBFaXRoZXIg
U1BJIG1vZGUgKDAsMCkgb3IgKDEsMSkgbXVzdCBiZSB1c2VkLCBzbyBzcGVjaWZ5IG5vbmUgb3IN
Cj4gYm90aCBvZg0KPiArICAgICAgICBzcGktY3BoYSwgc3BpLWNwb2wuDQpGb3IgU1BJIHByb3Bl
cnRpZXMgaXQncyBhIGdvb2QgaWRlYSB0byBhbHNvIHJlZmVyZW5jZSB0aGUgZG9jdW1lbnQgZm9y
IFNQSQ0KYmluZGluZ3MuDQpTb21ldGhpbmcgbGlrZToNCiAgICBTZWUgZm9yIG1vcmUgZGV0YWls
czoNCiAgICAgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGktYnVzLnR4
dA0KDQo+ICsNCj4gK05vdGUgYWJvdXQgbWF4IGZyZXF1ZW5jeToNCj4gKyAgICBDaGlwJ3MgbWF4
IGZyZXF1ZW5jeSwgYXMgc3BlY2lmaWVkIGluIGl0cyBkYXRhc2hlZXQsIGlzIDJNaHouIEJ1dCBh
DQo+IDYwMG5zDQo+ICsgICAgZGVsYXkgaXMgZXhwZWN0ZWQgYmV0d2VlbiB0aGUgYXBwbGljYXRp
b24gb2YgYSBsb2dpYyBMTyB0byBDUyBhbmQNCj4gdGhlDQo+ICsgICAgYXBwbGljYXRpb24gb2Yg
U0NMSywgYXMgYWxzbyBzcGVjaWZpZWQuIEFuZCBzaW5jZSB0aGUgZGVsYXkgaXMgbm90DQo+ICsg
ICAgaW1wbGVtZW50ZWQgaW4gdGhlIHNwaSBjb2RlLCB0byBzYXRpc2Z5IGl0LCBTQ0xLJ3MgcGVy
aW9kIHNob3VsZCBiZQ0KPiBhdCBtb3N0DQo+ICsgICAgMiAqIDYwMG5zLCBzbyB0aGUgbWF4IGZy
ZXF1ZW5jeSBzaG91bGQgYmUgMSAvICgyICogNmUtNyksIHdoaWNoDQo+IGdpdmVzDQo+ICsgICAg
cm91Z2hseSA4MzAwMDBIei4NCj4gKw0KPiArRXhhbXBsZToNCj4gK3Jlc29sdmVyQDAgew0KPiAr
CWNvbXBhdGlibGUgPSAiYWRpLGFkMnM5MCI7DQo+ICsJcmVnID0gPDA+Ow0KPiArCXNwaS1tYXgt
ZnJlcXVlbmN5ID0gPDgzMDAwMD47DQo+ICsJc3BpLWNwb2w7DQo+ICsJc3BpLWNwaGE7DQo+ICt9
Ow0K
