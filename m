Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:40814 "EHLO
	mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S932082AbbKSNzv (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 19 Nov 2015 08:55:51 -0500
From: Giuseppe BARBA <giuseppe.barba@st.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	Denis CIOCCA <denis.ciocca@st.com>
Date: Thu, 19 Nov 2015 14:54:58 +0100
Subject: Re: [PATCH 1/2 v2] iio: st_sensors: support active-low interrupts
Message-ID: <564DD4B2.9050509@st.com>
References: <1447664287-17310-1-git-send-email-linus.walleij@linaro.org>
 <5649BA9A.50206@st.com>
 <CACRpkdaumSNemq63o7s5EeZuBtTKmXqzd9_Kb5ZfouNQbfvEOg@mail.gmail.com>
 <5649E96E.8030400@st.com>
 <CACRpkdbxPhPsHWoYZwvTOrofBPsj9ELeHVSopbM-m2Mg9qVR3w@mail.gmail.com>
In-Reply-To: <CACRpkdbxPhPsHWoYZwvTOrofBPsj9ELeHVSopbM-m2Mg9qVR3w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

DQo+Pj4gRm9yIHRoZSBhY2NlbGVyb21ldGVyIEkgZ3Vlc3NlZCBpdCdzIHRoZSBzYW1lIGFzIHRo
ZSBvdGhlciBzZW5zb3JzLA0KPj4+IGJ1dCBhcyBMU00zMDNBR1IgYWxzbyBoYXMgRFJEWSBmb3Ig
dGhlIG1hZ25ldG9tZXRlciwgSSB3YXMNCj4+PiB3b25kZXJpbmcgaWYgdGhlcmUgaXMgYSBiaXQg
Zm9yIElITCBhbmQgT0QgYWxzbyBmb3IgdGhlIG1hZ25ldG9tZXRlcg0KPj4+IHNpZGU/DQo+PiBZ
ZXMsIHRoZSBpbnRlcnJ1cHQgcG9sYXJpdHkgaXMgYWxzbyBwcmVzZW50IGZvciBtYWduZXRvbWV0
ZXIuDQo+PiBUaGlzIGlzIG5hbWVseSBJRUEgYml0IGluIHRoZSByZWdpc3RlciBDVFJMX1JFR19N
ICgweDYzKSwgYml0IDIgKG1hc2sNCj4+IDB4MDQpLiBGb2xsb3dpbmcgdGhlIGJpdCBkZXNjcmlw
dGlvbjoNCj4+DQo+PiBDb250cm9scyB0aGUgcG9sYXJpdHkgb2YgdGhlIElOVCBiaXQgd2hlbiBh
biBpbnRlcnJ1cHQgb2NjdXJzLg0KPj4gRGVmYXVsdDogMA0KPj4NCj4+IElmIElFQSA9IDAsIHRo
ZW4gSU5UID0gMCBzaWduYWxzIGFuIGludGVycnVwdA0KPj4gSWYgSUVBID0gMSwgdGhlbiBJTlQg
PSAxIHNpZ25hbHMgYW4gaW50ZXJydXB0DQo+IE9LIHVwZGF0ZWQgdGhlIHBhdGNoLCBzZW5kaW5n
IGl0IG91dC4NCj4NCj4gQnV0IGRvZXMgaXQgYWxzbyBoYXZlIGFuIE9wZW4gRHJhaW4gYml0Pw0K
Pg0KPiBZb3VycywNCj4gTGludXMgV2FsbGVpag0KSGkgTGludXMsDQoNCnRoZSBkYXRhc2hlZXQg
b2YgTFNNMzAzQUdSIGlzIG5vdyBhdmFpbGFibGUgb24gdGhlIGZvbGxvd2luZyBsaW5rOg0KDQpo
dHRwOi8vd3d3LnN0LmNvbS93ZWIvZW4vY2F0YWxvZy9zZW5zZV9wb3dlci9GTTg5L1NDMTQ0OS9Q
RjI2MjE2OA0KDQpUaGUgaW50IHBpbiBpcyBpbiBoaWdoIGltcGVkYW5jZSBhbmQgaXQgaXMgY29u
ZmlndXJlZCBhcyBvdXRwdXQgcGluIA0KdGhyb3VnaCB0aGUgYml0IDAgb2YgcmVnaXN0ZXIgMHg2
Mi4NCg0KR2l1c2VwcGUuDQoNCg0KDQo=
