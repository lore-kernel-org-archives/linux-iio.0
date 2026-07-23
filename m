Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEE2385D8E;
	Thu, 23 Jul 2026 11:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784805293; cv=none; b=BudwT9v2RwTZaO0C0nIIiGeK9n1rkKE5ZuBUtYE1jUHI1GHI1sl7Eo/JFV3qbqmJPcb/dGTvk8luXM8uyE5Zv2LzvvSrhwtepR0lPoWyyvEf2rvKRfKSisO6DwwwojxB/yJAq1QM0njW33vNx/x/e8VU4TM/HUGwPFM/JxcDg3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784805293; c=relaxed/simple;
	bh=9h8Skd8/2Q3N5w8ZVEl1fL1qWuE8S9lhdl85i7N96bY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=j60VgzCQ5jw1O+Cj3eEKg567ov7W3TlOogA/Cnsdy76T6zQmqEDST8/4yq8szQYwDX+o2Movs2yf8a14MRmutQAsjBxbK8/ziEHAQfYAooJxoMy6XHhGP297A2RXUUQuvXr+3aPmRwoMH7KyqEbw1Cl31+GpOPszV1VNDyCAPx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YDn6DfpU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YDn6DfpU"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66NBEFwqC414001, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784805256; bh=9h8Skd8/2Q3N5w8ZVEl1fL1qWuE8S9lhdl85i7N96bY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YDn6DfpU6+Jk2Ety7HYLl2lhPBP0DVxsFdyW16JO4HT52elJsRQSc2ZxIwggW10Hc
	 iYNILMNcpxmJ+DcbQ812/7WJfT2P5osU3Nw7hMiSeHC69lyhdtRmlunBfspaP/WGiv
	 8lzYvwpMH/xkssEHqThFyzOUwnGoSC08/NE1njUA9qauvMpTSNrUIITeTpOlleLt+Q
	 bhAgzSeTsbMaEbhDGXvbUTnlYNiMbLQhOuMu/trH3a7RAHarnNZ0EdMdY030zUcqZE
	 ARjsVPMuQEvmHY34E+SqK1dHRGaTu9NppmE+NW/zEOQgQtyqnBY8umnG7vzJMLgGKJ
	 DI7UO7wT2xxSg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66NBEFwqC414001
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 19:14:16 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 19:14:16 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 19:14:14 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 23 Jul 2026 19:14:14 +0800
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
Subject: RE: [PATCH v7 5/9] gpio: regmap: Add gpio_regmap_operation to extend
 reg_mask_xlate callback
Thread-Topic: [PATCH v7 5/9] gpio: regmap: Add gpio_regmap_operation to extend
 reg_mask_xlate callback
Thread-Index: AQHdGlVbAgYGyBxDqk+qdE3R2tmcA7Z6JLWAgADOVPA=
Date: Thu, 23 Jul 2026 11:14:14 +0000
Message-ID: <f4b79d5510b64ad3bc2d716a51d21cfe@realtek.com>
References: <20260723034237.2501507-1-eleanor.lin@realtek.com>
 <20260723034237.2501507-6-eleanor.lin@realtek.com>
 <DK5R2VCAK468.2GAEC7VG8OJBZ@kernel.org>
In-Reply-To: <DK5R2VCAK468.2GAEC7VG8OJBZ@kernel.org>
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

SGkgTWljaGFlbCwNCg0KPg0KPj4gQEAgLTcxLDcgKzczLDcgQEAgc3RhdGljIGludCBncGlvX3Jl
Z21hcF9zaW1wbGVfeGxhdGUoc3RydWN0IA0KPj4gZ3Bpb19yZWdtYXAgKmdwaW8sICBzdGF0aWMg
aW50IGdwaW9fcmVnbWFwX2dldChzdHJ1Y3QgZ3Bpb19jaGlwICpjaGlwLCANCj4+IHVuc2lnbmVk
IGludCBvZmZzZXQpICB7DQo+PiAgCXN0cnVjdCBncGlvX3JlZ21hcCAqZ3BpbyA9IGdwaW9jaGlw
X2dldF9kYXRhKGNoaXApOw0KPj4gLQl1bnNpZ25lZCBpbnQgYmFzZSwgdmFsLCByZWcsIG1hc2s7
DQo+PiArCXVuc2lnbmVkIGludCBiYXNlLCB2YWwsIHJlZywgbWFzaywgZGlyX21hc2s7DQo+PiAg
CWludCByZXQ7DQo+PiAgDQo+PiAgCS8qIHdlIG1pZ2h0IG5vdCBoYXZlIGFuIG91dHB1dCByZWdp
c3RlciBpZiB3ZSBhcmUgaW5wdXQgb25seSAqLyBAQCANCj4+IC04MCw3ICs4MiwxOCBAQCBzdGF0
aWMgaW50IGdwaW9fcmVnbWFwX2dldChzdHJ1Y3QgZ3Bpb19jaGlwICpjaGlwLCB1bnNpZ25lZCBp
bnQgb2Zmc2V0KQ0KPj4gIAllbHNlDQo+PiAgCQliYXNlID0gZ3Bpb19yZWdtYXBfYWRkcihncGlv
LT5yZWdfc2V0X2Jhc2UpOw0KPj4gIA0KPj4gLQlyZXQgPSBncGlvLT5yZWdfbWFza194bGF0ZShn
cGlvLCBiYXNlLCBvZmZzZXQsICZyZWcsICZtYXNrKTsNCj4+ICsJcmV0ID0gZ3Bpby0+cmVnX21h
c2tfeGxhdGUoZ3BpbywgR1BJT19SRUdNQVBfR0VUX09QLCBiYXNlLCBvZmZzZXQsICZyZWcsICZk
aXJfbWFzayk7DQo+PiArCWlmIChyZXQpDQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwly
ZXQgPSByZWdtYXBfcmVhZChncGlvLT5yZWdtYXAsIHJlZywgJnZhbCk7DQo+PiArCWlmIChyZXQp
DQo+PiArCQlyZXR1cm4gcmV0Ow0KPj4gKw0KPj4gKwlpZiAodmFsICYgZGlyX21hc2spDQo+PiAr
CQlyZXQgPSBncGlvLT5yZWdfbWFza194bGF0ZShncGlvLCBHUElPX1JFR01BUF9PVVQsIGJhc2Us
IG9mZnNldCwgJnJlZywgJm1hc2spOw0KPj4gKwllbHNlDQo+PiArCQlyZXQgPSBncGlvLT5yZWdf
bWFza194bGF0ZShncGlvLCBHUElPX1JFR01BUF9JTiwgYmFzZSwgb2Zmc2V0LCANCj4+ICsmcmVn
LCAmbWFzayk7DQo+DQo+IFdoYXQncyBnb2luZyBvbiBoZXJlPyBMb29rcyBsaWtlIEkndmUgbWlz
c2VkIHRoaXMgaW4gdGhlIHByZXZpb3VzDQo+IHBhdGNoZXMuIEFsbCB0aGUgb3RoZXIgZHJpdmVy
cyB3ZSBhcmUgbm93IHJlYWRpbmcgdGhlIHZhbHVlIHR3aWNlLg0KPiBJbiB0aGUgcmVnbWFwX3Jl
YWQoKSBhYm92ZSBhbmQgdGhlIG9uZSB0aGF0IGZvbGxvd3MganVzdCBhZnRlciB0aGlzDQo+IGh1
bmsuDQo+IA0KPiBIYXMgdGhlIGdwaW8gY29udHJvbGxlciB0d28gZGlmZmVyZW50IGJpdHMsIG9u
ZSBmb3Igb3V0cHV0IGFuZCBvbmUNCj4gZm9yIGlucHV0PyBBcmUgeW91IHN1cmUsIHRoZSBpbnB1
dCBiaXQgZG9lc24ndCByZWZsZWN0IHRoZSBvdXRwdXQNCj4gYml0IGlmIGl0J3MgY29uZmlndXJl
ZCBhcyBhbiBvdXRwdXQ/DQo+IA0KPiBJTUhPIHRoaXMgc2hvdWxkbid0IGJlIHBhcnQgb2YgdGhl
IGNvcmUuIHJ0ZDE2MjVfcmVnX21hc2tfeGxhdGUoKQ0KPiBzaG91bGQgZWl0aGVyIHJldHVybiBS
VEQxNjI1X0dQSU9fSU4gb3IgUlREMTYyNV9HUElPX09VVCBkZXBlbmRpbmcNCj4gb24gdGhlIG1v
ZGUsIGlmIHRoYXQncyBuZWVkZWQgYXQgYWxsLiBJJ2QgZ3Vlc3MgUlREMTYyNV9HUElPX0lODQo+
IHdpbGwganVzdCB3b3JrIGZpbmUgYW5kIHdpbGwgYWN0dWFsbHkgZmV0Y2ggdGhlIGFjdHVhbCBs
aW5lIHN0YXRlLg0KPg0KPiAtbWljaGFlbA0KPg0KDQpSZWdhcmRpbmcgdGhlIGhhcmR3YXJlLCB0
aGlzIGNvbnRyb2xsZXIgaW5kZWVkIGhhcyBkZWRpY2F0ZWQgYW5kIHNlcGFyYXRlDQpiaXRzIGZv
ciBJTiwgT1VULCBhbmQgRElSLiBJZiBjb25maWd1cmVkIGFzIGFuIG91dHB1dCwgcmVhZGluZyB0
aGUgSU4gYml0DQpkb2VzIG5vdCByZWZsZWN0IHRoZSBhY3R1YWwgc3RhdGUsIHNvIHdlIG11c3Qg
Y2hlY2sgdGhlIERJUiBiaXQgZmlyc3QgdG8NCmtub3cgd2hpY2ggYml0IHRvIHJlYWQuDQoNCkFz
IHlvdSBwb2ludGVkIG91dCwgbXkgaW1wbGVtZW50YXRpb24gd291bGQgY2F1c2Ugb3RoZXIgZHJp
dmVycyB0byByZWFkDQp0d2ljZS4gVGhlcmVmb3JlLCBJIHdpbGwga2VlcCBHUElPX1JFR01BUF9H
RVRfT1AsIGRyb3AgR1BJT19SRUdNQVBfSU4gYW5kDQpHUElPX1JFR01BUF9PVVQsIGFuZCBtb3Zl
IHRoZSByZWdpc3RlciByZWFkaW5nIGxvZ2ljIGludG8gbXkgY3VzdG9tDQpyZWdfbWFza194bGF0
ZSgpLg0KDQpCZXN0IFJlZ2FyZHMsDQpZdS1DaHVuDQoNCj4+DQo+PiA+ICAJaWYgKHJldCkNCj4+
ID4gIAkJcmV0dXJuIHJldDsNCj4+DQo+Li4uDQo+DQo+PiAgDQo+PiArLyoqDQo+PiArICogZW51
bSBncGlvX3JlZ21hcF9vcGVyYXRpb24gLSBPcGVyYXRpb24gdHlwZSBmb3IgcmVnX21hc2tfeGxh
dGUgDQo+PiArY2FsbGJhY2sNCj4+ICsgKg0KPj4gKyAqIFRyYWRpdGlvbmFsbHksIHRoZSBvcGVy
YXRpb24gdHlwZSB3YXMgaW5mZXJyZWQgZnJvbSB0aGUgYmFzZSByZWdpc3Rlci4NCj4+ICsgKiBI
b3dldmVyLCB0aGF0IGFwcHJvYWNoIGRvZXMgbm90IGFsd2F5cyB3b3JrIKFYIGZvciBleGFtcGxl
LCB3aGVuIA0KPj4gK2FsbCBjb250cm9sDQo+PiArICogYml0cyBvZiBhIHNpbmdsZSBHUElPIHJl
c2lkZSBpbiB0aGUgc2FtZSByZWdpc3Rlci4gVGhpcyBlbnVtIA0KPj4gK2FsbG93cyB0aGUNCj4+
ICsgKiByZWdfbWFza194bGF0ZSBjYWxsYmFjayB0byBleHBsaWNpdGx5IGRpc3Rpbmd1aXNoIGJl
dHdlZW4gb3BlcmF0aW9uIHR5cGVzLg0KPj4gKyAqIFRoZSB1c2VyIGlzIGZyZWUgdG8gY2hvb3Nl
IHdoaWNoIG1ldGhvZCB0byB1c2UuDQo+PiArICoNCj4+ICsgKiBWYWx1ZSBvcGVyYXRpb25zOg0K
Pj4gKyAqIEBHUElPX1JFR01BUF9HRVRfT1A6IE1hc2sgZm9yIHJlYWRpbmcgZGlyZWN0aW9uIHRv
IGRldGVjdCBpZiBHUElPIGlzIGlucHV0IG9yDQo+PiArICoJCQlvdXRwdXQuIFVzZWQgaW4gZ3Bp
b19yZWdtYXBfZ2V0KCkgdG8gZGV0ZXJtaW5lIHRoZSBHUElPDQo+PiArICoJCQlkaXJlY3Rpb24u
DQo+DQo+IFRoaXMgaXMgYWxzbyBub3QgdmVyeSBpbnR1aXRpdmUuIEknZCBleHBlY3QgdGhlcmUg
aXMgb25seSBvbmUNCj4gb3BlcmF0aW9uIGZvciB0aGUgZ3Bpb19yZWdtYXBfZ2V0IGFuZCB0aGF0
IGlzIGV4YWN0bHkgdGhpcyBvbmUuDQo+DQo+PiArICogQEdQSU9fUkVHTUFQX0lOOiBNYXNrIGZv
ciByZWFkaW5nIGlucHV0IHZhbHVlLiBVc2VkIHdoZW4gR1BJTyBpcyBjb25maWd1cmVkIGFzDQo+
PiArICoJCQlpbnB1dC4NCj4+ICsgKiBAR1BJT19SRUdNQVBfT1VUOiBNYXNrIGZvciByZWFkaW5n
IG91dHB1dCB2YWx1ZS4gVXNlZCB3aGVuIEdQSU8gaXMgY29uZmlndXJlZCBhcw0KPj4gKyAqCQkJ
b3V0cHV0Lg0KPj4gKyAqDQo+PiArICogT3V0cHV0IG9wZXJhdGlvbnM6DQo+PiArICogQEdQSU9f
UkVHTUFQX1NFVF9PUDogTWFzayBmb3Igc2V0dGluZyBHUElPIG91dHB1dCB2YWx1ZS4NCj4+ICsg
Kg0KPj4gKyAqIERpcmVjdGlvbiBvcGVyYXRpb25zOg0KPj4gKyAqIEBHUElPX1JFR01BUF9HRVRf
RElSX09QOiBNYXNrIGZvciByZWFkaW5nIEdQSU8gZGlyZWN0aW9uIChpbnB1dC9vdXRwdXQpLg0K
Pj4gKyAqIEBHUElPX1JFR01BUF9TRVRfRElSX09QOiBNYXNrIGZvciBzZXR0aW5nIEdQSU8gZGly
ZWN0aW9uIChpbnB1dC9vdXRwdXQpLg0KPj4gKyAqLw0KPj4gK2VudW0gZ3Bpb19yZWdtYXBfb3Bl
cmF0aW9uIHsNCj4+ICsJR1BJT19SRUdNQVBfR0VUX09QLA0KPj4gKwlHUElPX1JFR01BUF9TRVRf
T1AsDQo+PiArCUdQSU9fUkVHTUFQX0dFVF9ESVJfT1AsDQo+PiArCUdQSU9fUkVHTUFQX1NFVF9E
SVJfT1AsDQo+PiArCUdQSU9fUkVHTUFQX0lOLA0KPj4gKwlHUElPX1JFR01BUF9PVVQsDQo+PiAr
fTsNCg==
