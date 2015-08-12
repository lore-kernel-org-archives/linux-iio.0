Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:33667 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933557AbbHLIhT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 12 Aug 2015 04:37:19 -0400
Message-ID: <BLU402-EAS1833F81D76FA29E2297AC96D67E0@phx.gbl>
Content-Type: text/plain; charset="gb2312"
Subject: Re: [PATCH v1] staging: iio: hmc5843: Set iio name dynamically based on i2c name
References: <1439367630-8964-1-git-send-email-sdliyong@gmail.com> <55CB0396.2050303@metafoo.de>
From: LIYONG <sdliyong@gmail.com>
MIME-Version: 1.0 (1.0)
In-Reply-To: <55CB0396.2050303@metafoo.de>
Date: Wed, 12 Aug 2015 16:37:10 +0800
To: Lars-Peter Clausen <lars@metafoo.de>
CC: "jic23@kernel.org" <jic23@kernel.org>,
	"knaack.h@gmx.de" <knaack.h@gmx.de>,
	"pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"cristina.opriceana@gmail.com" <cristina.opriceana@gmail.com>,
	"tolga.ceylan@gmail.com" <tolga.ceylan@gmail.com>,
	"k.kozlowski@samsung.com" <k.kozlowski@samsung.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

dGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLiBsZXQgbWUgc3VibWl0IGFub3RoZXIgb25lDQoNCrei
19TO0rXEIGlQaG9uZQ0KDQo+INTaIDIwMTXE6jjUwjEyyNWjrDE2OjI4o6xMYXJzLVBldGVyIENs
YXVzZW4gPGxhcnNAbWV0YWZvby5kZT4g0LS1wKO6DQo+IA0KPj4gT24gMDgvMTIvMjAxNSAxMDoy
MCBBTSwgc2RsaXlvbmdAZ21haWwuY29tIHdyb3RlOg0KPj4gRnJvbTogWW9uZyBMaSA8c2RsaXlv
bmdAZ21haWwuY29tPg0KPj4gDQo+PiBMb2FkIHRoZSBkcml2ZXIgdXNpbmcgdGhlIGJlbG93IGNv
bW1hbmQ6DQo+PiBlY2hvIGhtYzU5ODMgMHgxZSA+IC9zeXMvYnVzL2kyYy9kZXZpY2VzL2kyYy0/
L25ld19kZXZpY2UNCj4+IA0KPj4gSW4gc3lzZnMsIHRoZSBpaW8gbmFtZSBpcyBobWM1ODQzLCBo
b3dldmVyIHRoZSBpMmMgbmFtZSBpcyBobWM1OTgzLA0KPj4gdGhleSBhcmUgaW5jb25zaXN0ZW50
Lg0KPj4gDQo+PiBXaXRoIHRoaXMgcGF0Y2gsIHRoZSBpaW8gbmFtZSB3aWxsIGJlIHRoZSBzYW1l
IGFzIHRoZSBpMmMgZGV2aWNlIG5hbWUNCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogWW9uZyBMaSA8
c2RsaXlvbmdAZ21haWwuY29tPg0KPj4gLS0tDQo+PiBkcml2ZXJzL3N0YWdpbmcvaWlvL21hZ25l
dG9tZXRlci9obWM1ODQzX2kyYy5jIHwgMSArDQo+PiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRp
b24oKykNCj4+IA0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9paW8vbWFnbmV0b21l
dGVyL2htYzU4NDNfaTJjLmMgYi9kcml2ZXJzL3N0YWdpbmcvaWlvL21hZ25ldG9tZXRlci9obWM1
ODQzX2kyYy5jDQo+PiBpbmRleCBmZjA4NjY3Li4zYjAzNjQ0IDEwMDY0NA0KPj4gLS0tIGEvZHJp
dmVycy9zdGFnaW5nL2lpby9tYWduZXRvbWV0ZXIvaG1jNTg0M19pMmMuYw0KPj4gKysrIGIvZHJp
dmVycy9zdGFnaW5nL2lpby9tYWduZXRvbWV0ZXIvaG1jNTg0M19pMmMuYw0KPj4gQEAgLTU5LDYg
KzU5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCByZWdtYXBfY29uZmlnIGhtYzU4NDNfaTJjX3Jl
Z21hcF9jb25maWcgPSB7DQo+PiBzdGF0aWMgaW50IGhtYzU4NDNfaTJjX3Byb2JlKHN0cnVjdCBp
MmNfY2xpZW50ICpjbGksDQo+PiAgICAgICAgICAgICAgICAgY29uc3Qgc3RydWN0IGkyY19kZXZp
Y2VfaWQgKmlkKQ0KPj4gew0KPj4gKyAgICBjbGktPmRldi5kcml2ZXItPm5hbWUgPSBpZC0+bmFt
ZTsNCj4gDQo+IFlvdSBhcmUgb3ZlcndyaXRpbmcgYSB0aGUgbmFtZSBvZiB0aGUgZHJpdmVyLCB3
aGljaCBpcyBhIHN0cnVjdCB0aGF0IGlzDQo+IHNoYXJlZCBiZXR3ZWVuIGFsbCBpbnN0YW5jZXMg
b2YgdGhlIGRldmljZSB3aGljaCBzcGVjaWZpYyBkYXRhIGZyb20gb25lDQo+IGRldmljZS4gVGhh
dCBpcyBtb3N0IGNlcnRhaW5seSBub3QgY29ycmVjdC4NCj4gDQo+IFVwZGF0ZSBobWM1ODQzX2Nv
bW1vbl9wcm9iZSgpIGFuZCBhZGQgYSBwYXJhbWV0ZXIgdGhhdCB0YWtlcyB0aGUgbmFtZSBmb3IN
Cj4gdGhlIGRldmljZSBhbmQgdGhlbiBwYXNzIHRoZSBpZC0+bmFtZSB3aGVuIHRoZSBmdW5jdGlv
biBpcyBjYWxsZWQuDQo+IA0KPj4gICAgcmV0dXJuIGhtYzU4NDNfY29tbW9uX3Byb2JlKCZjbGkt
PmRldiwNCj4+ICAgICAgICAgICAgZGV2bV9yZWdtYXBfaW5pdF9pMmMoY2xpLCAmaG1jNTg0M19p
MmNfcmVnbWFwX2NvbmZpZyksDQo+PiAgICAgICAgICAgIGlkLT5kcml2ZXJfZGF0YSk7DQo+PiAN
Cj4gDQo=
