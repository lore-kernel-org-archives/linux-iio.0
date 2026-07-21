Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD27A48C8CD;
	Tue, 21 Jul 2026 12:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784635867; cv=none; b=QttrPlnG+/pl0ovElmrhtCAqgC5TqBZhdHZLT8oi2SIXcsrss6Kikuf5Pq4PtbP1D2CVNtrFm9ty/57CCzO0D9hP3SIygXrDOzdU3VpkN/j6TdKjlctykOaBH5VHCdtJk+vAcMf2XYean/1Yqd4X3GBXpbQdLsn6GjDtjwI3AtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784635867; c=relaxed/simple;
	bh=6nRxoOSO7kE6J1Szs5DUMQaP6ijmlj4uOIpV9+F/H+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=J+qmsK+jHeDjKdb52VIud8a1jypjHV5OLEIcGA1uQsl5q21Tm7zem1vBsoHXxU3/yce4r1pdzLKpNrGn2HE2FxJOoAsdgJaAobITYiRvoRjweqXO9XqUFM0GhmWvDgYg7CzwU5rEQeo+gdqdHdPQPEAvL5eyQ34pHH58DscHfAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z7sk6eMp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z7sk6eMp"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66LCAfukE3141895, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784635841; bh=6nRxoOSO7kE6J1Szs5DUMQaP6ijmlj4uOIpV9+F/H+w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Z7sk6eMp5Q2fgkNS7pQKfNtNb9r0YoHS3/rFMv7o6X4mai5Dq6G+HlPv3+4zdkruc
	 ZyzfE5RUoRBssl64A3SlR547WkjeFlu7ma7YTRCl3lPhH8Ud8wmyzGwerWJ5P4Eb6a
	 2L6t5oAnLPYGU2OHO6T2UQtWAQ+QJRQ5B8VgNP28jUpw0vp8isE71/pcVEWUtLcTmq
	 b19sCbPAS1AGHcXf0ZElrEZQj6Ie7GBOI8ySdd6/SUwOt/TRaLgVJCt1gE6eN8OZYF
	 QNKCxV742lZx2DJOY0JxJ+uGcp6PTVgNW07ZqaU0MhVkz2+X7dXgbuRJpl+2eLCXr3
	 0qKjuhthmOsoA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66LCAfukE3141895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 20:10:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 20:10:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 21 Jul 2026 20:10:41 +0800
From: =?big5?B?WXUtQ2h1biBMaW4gW6pMr6enZ10=?= <eleanor.lin@realtek.com>
To: Michael Walle <mwalle@kernel.org>, "linusw@kernel.org"
	<linusw@kernel.org>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "brgl@kernel.org" <brgl@kernel.org>,
	=?big5?B?VFlfQ2hhbmdbsWmkbLZoXQ==?= <tychang@realtek.com>, "wbg@kernel.org"
	<wbg@kernel.org>, "mathieu.dubois-briand@bootlin.com"
	<mathieu.dubois-briand@bootlin.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "Michael.Hennerich@analog.com"
	<Michael.Hennerich@analog.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"andy@kernel.org" <andy@kernel.org>, "u.kleine-koenig@baylibre.com"
	<u.kleine-koenig@baylibre.com>, "dakr@kernel.org" <dakr@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "o-takashi@sakamocchi.jp"
	<o-takashi@sakamocchi.jp>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux@analog.com"
	<linux@analog.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	=?big5?B?Q1lfSHVhbmdbtsDgsq7LXQ==?= <cy.huang@realtek.com>,
	=?big5?B?SmFtZXMgVGFpIFvAuafTrnBd?= <james.tai@realtek.com>
Subject: RE: [PATCH v6 6/8] gpio: regmap: Add set_config callback
Thread-Topic: [PATCH v6 6/8] gpio: regmap: Add set_config callback
Thread-Index: AQHdGN5IJQDSpRIowU2BMchTrbLbjLZ3C9GAgAC+36D//4KmAIAAlKNQ
Date: Tue, 21 Jul 2026 12:10:41 +0000
Message-ID: <d03008716deb40c7baeda976452b346b@realtek.com>
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-7-eleanor.lin@realtek.com>
 <DK42I02A80FJ.1TX1U341LOAXG@kernel.org>
 <520080c564ef4a039b67d2a820e7a646@realtek.com>
 <DK47HK67DGGW.37OGI53JJAVUL@kernel.org>
In-Reply-To: <DK47HK67DGGW.37OGI53JJAVUL@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Pj4gT24gVHVlIEp1bCAyMSwgMjAyNiBhdCAxMjo0NiBQTSBDRVNULCBZdS1DaHVuIExpbiBbqkyv
p6dnXSB3cm90ZToNCj4+IEhpIE1pY2hhZWwsDQo+Pg0KPj4+T24gVHVlIEp1bCAyMSwgMjAyNiBh
dCA4OjU4IEFNIENFU1QsIFl1LUNodW4gTGluIHdyb3RlOg0KPj4NCj4+ICguLi4pDQo+Pg0KPj4+
PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC9ncGlvL3JlZ21hcC5oIA0KPj4+PiBiL2luY2x1
ZGUvbGludXgvZ3Bpby9yZWdtYXAuaCBpbmRleCA0NWEzMGY1MDA0M2YuLjIzNDYwOTk1YzFkMSAN
Cj4+Pj4gMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvbGludXgvZ3Bpby9yZWdtYXAuaA0KPj4+
PiArKysgYi9pbmNsdWRlL2xpbnV4L2dwaW8vcmVnbWFwLmgNCj4+Pj4gQEAgLTg5LDYgKzg5LDkg
QEAgZW51bSBncGlvX3JlZ21hcF9vcGVyYXRpb24gew0KPj4+PiAgICoJCQltYXNrIGJlZm9yZSB3
cml0aW5nLiBUaGlzIGFsbG93cyBkcml2ZXItc3BlY2lmaWMgbG9naWMNCj4+Pj4gICAqCQkJdG8g
YXBwZW5kIGFkZGl0aW9uYWwgYml0cyAobGlrZSB3cml0ZS1lbmFibGUgbWFza3MpDQo+Pj4+ICAg
KgkJCWR5bmFtaWNhbGx5IGJhc2VkIG9uIHRoZSBjdXJyZW50IG9wZXJhdGlvbi4NCj4+Pj4gKyAq
IEBzZXRfY29uZmlnOgkJKE9wdGlvbmFsKSBDYWxsYmFjayBmb3Igc2V0dGluZyBHUElPIGNvbmZp
Z3VyYXRpb24gc3VjaA0KPj4+PiArICoJCQlhcyBkZWJvdW5jZSwgZHJpdmUgc3RyZW5ndGgsIG9y
IG90aGVyIGhhcmR3YXJlIHNwZWNpZmljDQo+Pj4+ICsgKgkJCXNldHRpbmdzLg0KPj4+PiAgICog
QGRydmRhdGE6CQkoT3B0aW9uYWwpIFBvaW50ZXIgdG8gZHJpdmVyIHNwZWNpZmljIGRhdGEgd2hp
Y2ggaXMNCj4+Pj4gICAqCQkJbm90IHVzZWQgYnkgZ3Bpby1yZW1hcCBidXQgaXMgcHJvdmlkZWQg
ImFzIGlzIiB0byB0aGUNCj4+Pj4gICAqCQkJZHJpdmVyIGNhbGxiYWNrKHMpLg0KPj4+PiBAQCAt
MTUwLDYgKzE1Myw4IEBAIHN0cnVjdCBncGlvX3JlZ21hcF9jb25maWcgew0KPj4+PiAgCQkJICAg
dW5zaWduZWQgaW50IGJhc2UsIHVuc2lnbmVkIGludCBvZmZzZXQsIHVuc2lnbmVkIGludCByZWcs
DQo+Pj4+ICAJCQkgICB1bnNpZ25lZCBpbnQgKm1hc2ssIHVuc2lnbmVkIGludCAqdmFsKTsNCj4+
Pj4gIA0KPj4+PiArCWludCAoKnNldF9jb25maWcpKHN0cnVjdCBncGlvX2NoaXAgKmdjLCB1bnNp
Z25lZCBpbnQgb2Zmc2V0LCANCj4+Pj4gK3Vuc2lnbmVkIGxvbmcgY29uZmlnKTsNCj4+Pj4gKw0K
Pj4+DQo+Pj4gRG8gd2UgbmVlZCBhbiBhZGRpdGlvbmFsIHN0cnVjdCBncGlvX3JlZ21hcCBwb2lu
dGVyIGFzIGEgZmlyc3QgDQo+Pj4gYXJndW1lbnQ/IEhvdyBkb2VzIHRoZSBkcml2ZXIgZmV0Y2gg
dGhlIGF0dGFjaGVkIG9wYXF1ZSBkYXRhIHBvaW50ZXI/IA0KPj4+IEkgc2VlIHRoYXQgeW91ciBk
cml2ZXIgaXMgZG9pbmcNCj4+Pg0KPj4+IHN0cnVjdCBydGQxNjI1X2dwaW8gKmRhdGEgPSBncGlv
Y2hpcF9nZXRfZGF0YShjaGlwKQ0KPj4+DQo+Pj4gQnV0IGl0IGlzIHRoZSBncGlvLXJlZ21hcCBj
b3JlIHdoaWNoIHdpbGwgYXR0YWNoIGl0J3Mgb3duIGRhdGEgcG9pbnRlciB0byBncGlvX2NoaXAs
IG5vPw0KPj4+DQo+Pj4gLW1pY2hhZWwNCj4+DQo+PiBZb3UgYXJlIHJpZ2h0LiBJIG1pc3Rha2Vu
bHkgdXNlZCBncGlvY2hpcF9nZXRfZGF0YSgpIGhlcmUuDQo+Pg0KPj4gTXkgY3VycmVudCBwbGFu
IHRvIGZpeCB0aGlzIGlzOg0KPj4gVGhlIHNldF9jb25maWcgY2FsbGJhY2sgaW4gJ3N0cnVjdCBn
cGlvX3JlZ21hcF9jb25maWcnIGFuZCAnc3RydWN0IGdwaW9fcmVnbWFwJw0KPj4gc2hvdWxkIHRh
a2UgJ3N0cnVjdCBncGlvX3JlZ21hcCAqJyBhcyB0aGUgZmlyc3QgYXJndW1lbnQgKHJlcGxhY2lu
ZyANCj4+ICdzdHJ1Y3QgZ3Bpb19jaGlwIConKSwgYW5kIHRoZSBkcml2ZXIgc2hvdWxkIHVzZSAn
Z3Bpb19yZWdtYXBfZ2V0X2RydmRhdGEoKScNCj4+IHRvIHJldHJpZXZlIGl0cyBvd24gZGF0YSBw
b2ludGVyLg0KPiANCj4gWW91IGFsc28gcHJvYmFibHkgbmVlZCB0aGUgc3RydWN0IGdwaW9fY2hp
cCwgdG8gbWF5YmUgY2FsbCBpbnRvIHRoZSBncGlvIGNvcmUsIG5vPw0KPiANCj4gSWYgc28sIHdo
YXQgYWJvdXQNCj4gDQo+IGludCAoKnNldF9jb25maWcpKHN0cnVjdCBncGlvX3JlZ21hcCAqZ3Bp
bywgc3RydWN0IGdwaW9fY2hpcCAqZ2MsDQo+ICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGlu
dCBvZmZzZXQsIHVuc2lnbmVkIGxvbmcgY29uZmlnKQ0KPg0KDQpBZ3JlZWQuIEkgd2lsbCB0YWtl
IHRoaXMgZGVzaWduLg0KDQpCZXN0IFJlZ2FyZHMsDQpZdS1DaHVuDQoNCj4+IEknbGwgYWRkIGEg
d3JhcHBlciBpbiBncGlvLXJlZ21hcC5jIHRoYXQgYnJpZGdlcyBncGlvX2NoaXAgdG8gDQo+PiBn
cGlvX3JlZ21hcCBhbmQgaGFuZGxlcyB0aGUgZmFsbGJhY2sgdG8gZ3Bpb2NoaXBfZ2VuZXJpY19j
b25maWcoKS4NCj4NCj4gWWVzLg0KPg0KPiAtbWljaGFlbA0K
