Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F0B3C9EF0;
	Thu, 16 Jul 2026 11:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784200933; cv=none; b=kqoKMKN2epjsQY47E6v5B6Gc++tDQZkOcJmJZ+123K9bznUdY+JbbDYsjjuGbPTn3xzKnwf9xZjE5zyJ8LRFlimF5W/wP4Owmcn8qYv8W9Qwnr4U6XuJtq2abN8lLEPJSEUqYXW06YirMC9kTEwB/1XTON5QGHaNu0IuwKAD+vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784200933; c=relaxed/simple;
	bh=44kXH3/E0w/lHoH9WlHMM2cyxoqGH42gczpsrCIsszU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rhZsgvlPHHv+fRzSRNMYBFACnQfseTftbnSsI0wI4/6ixAf4sBpi/IW5CQAIcKPQyrjFpQTi5vVYG4LM9nx5mD2VMPo8FpOFYzjU2KE7yVlflRFfOC5QjBzn4+oof4igakYCgppri3TTpTNvtegl3EAEWi1E3Avx1Uy5rx7N6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ItLSuFDV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ItLSuFDV"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66GBL5WO03604801, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784200865; bh=44kXH3/E0w/lHoH9WlHMM2cyxoqGH42gczpsrCIsszU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ItLSuFDVradEyRHwRtXmYUGqpuvmf/rc9uYSGZlQpGnjXH9XJet2akTWdBjBA7gS1
	 U81eeJIZyUxWVS6f9YcNG9LAxAKvTbCaDz9sLNs+HO9O5Jwnc4yBzRMDE+pKPK9RnD
	 pGg8W5RDHPyxkzTRY/ulpRZ73lJ0YYgtv+JcRmXl9pVen/fM4hldGKc3BeD4HzZ4kq
	 +7lgYGfXZQJQ8rpO2kXRKUjkyNWupq/kXNlzjucQ0MBbIPdpyFlqGkNdSjSnB7u4X9
	 K+UidcoUJ1VF3c+lGzi/8W3RRf979dIvCE65yPqbeejKxOVoc2lOcU7HO86dWFQCYp
	 wjoTIBWk9YyEw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66GBL5WO03604801
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 19:21:05 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 16 Jul 2026 19:21:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 16 Jul 2026 19:21:02 +0800
From: =?utf-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
To: Michael Walle <mwalle@kernel.org>, Andy Shevchenko
	<andriy.shevchenko@intel.com>
CC: "Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>,
	"afaerber@suse.com" <afaerber@suse.com>, "andy@kernel.org" <andy@kernel.org>,
	"brgl@kernel.org" <brgl@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, =?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?=
	<cy.huang@realtek.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "dlechner@baylibre.com"
	<dlechner@baylibre.com>, =?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?=
	<james.tai@realtek.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "lars@metafoo.de"
	<lars@metafoo.de>, "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
	"linusw@kernel.org" <linusw@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-realtek-soc@lists.infradead.org"
	<linux-realtek-soc@lists.infradead.org>, "mathieu.dubois-briand@bootlin.com"
	<mathieu.dubois-briand@bootlin.com>, "nuno.sa@analog.com"
	<nuno.sa@analog.com>, "robh@kernel.org" <robh@kernel.org>,
	=?utf-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= <stanley_chang@realtek.com>,
	=?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>,
	"wbg@kernel.org" <wbg@kernel.org>
Subject: RE: [PATCH v3 3/7] gpio: regmap: Add gpio_regmap_operation and
 write-enable support
Thread-Topic: [PATCH v3 3/7] gpio: regmap: Add gpio_regmap_operation and
 write-enable support
Thread-Index: AQHc4cATPP5CAXxOA0S9aBj6QrzqgrYJ8C6AgFvXxWCACcZxAIAAIc4AgAALpoCAAAi9AIAAl8rg//9/lACAAIpZkA==
Date: Thu, 16 Jul 2026 11:21:02 +0000
Message-ID: <068b13e117464cf38b7b215eee72fe7a@realtek.com>
References: <d301ba0cd45d49d59e6a014188306ec9@realtek.com>
 <20260716062614.1507243-1-eleanor.lin@realtek.com>
 <aliV4u6_xzx9D9Aq@ashevche-desk.local>
 <DJZVLZ4LLD9E.3MPLYYXT1VQ9R@kernel.org>
 <alim_HGTD5RCupav@ashevche-desk.local>
 <9ee344c1d9c642bdb7d3b85bc922fe66@realtek.com>
 <DJZY1YPMDLIN.3W0QOPEI9L8JA@kernel.org>
In-Reply-To: <DJZY1YPMDLIN.3W0QOPEI9L8JA@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

PiBIaSwNCj4gDQo+IE9uIFRodSBKdWwgMTYsIDIwMjYgYXQgMTI6NDcgUE0gQ0VTVCwgWXUtQ2h1
biBMaW4gW+ael+elkOWQm10gd3JvdGU6DQo+ID4gSSBjaGVja2VkIHdpdGggb3VyIGludGVybmFs
IGhhcmR3YXJlIGVuZ2luZWVycy4gVGhlIFdSRU4gYml0IHdhcw0KPiA+IGRlc2lnbmVkIHRvIGF2
b2lkIHJhY2UgY29uZGl0aW9ucywgd2hpY2ggcmVxdWlyZXMgYm90aCB0aGUgZGF0YSBiaXQNCj4g
PiBhbmQgdGhlIFdSRU4gYml0IHRvIGJlIHVwZGF0ZWQgc2ltdWx0YW5lb3VzbHkgd2l0aGluIHRo
ZSBzYW1lIHJlZ2lzdGVyLg0KPiANCj4gWW91ciBtYWlsIGp1c3QgYXJyaXZlZCBhcyBJIHdhcyB3
cml0aW5nIG15IHJlcGx5LiBTbyB5ZWFoLCB0aGF0J3MgYmFzaWNhbGx5IHdoYXQgSQ0KPiB3YXMg
c2F5aW5nLg0KPiANCj4gPiBJIGhhdmUgYSBuZXcgaWRlYSB0aGF0IG1pZ2h0IGJlIHNpbWlsYXIg
dG8gTWljaGFlbCdzIHN1Z2dlc3Rpb24uDQo+IA0KPiBJZiBub3QgYWxtb3N0IGV4YWN0bHkgd2hh
dCBJIGhhZCBpbiBtaW5kLiA6KQ0KPiANCj4gPiBXZSBjYW4NCj4gPiBpbnRyb2R1Y2UgYSBuZXcg
Y2FsbGJhY2sgdG8gYWxsb3cgdGhlIGRyaXZlciB0byBpbnRlcmNlcHQgYW5kIG1vZGlmeQ0KPiA+
IHRoZSBtYXNrIGFuZCB0aGUgdmFsdWUuIEJ5IGRvaW5nIHNvLCB0aGUgZHJpdmVyIGNhbiBkZXRl
cm1pbmUgdGhlDQo+ID4gY29ycmVzcG9uZGluZyBXUkVOIGJpdCBiYXNlZCBvbiB0aGUgb3JpZ2lu
YWwgbWFzaywgYW5kIGFzc2VtYmxlIHRoZQ0KPiA+IFdSRU4gYml0IGludG8gdGhpcyBuZXcgY2Fs
bGJhY2sgZnVuY3Rpb24gcmlnaHQgYmVmb3JlIHRoZSBmaW5hbCB3cml0ZSBBUEkgaXMNCj4gZXhl
Y3V0ZWQuDQo+ID4NCj4gPiBUaGUgaWRlYSBsb29rcyBsaWtlOg0KPiA+DQo+ID4gc3RhdGljIHZv
aWQgZ3Bpb19yZWdtYXBfc2V0KHN0cnVjdCBncGlvX2NoaXAgKmNoaXAsIHVuc2lnbmVkIGludCBv
ZmZzZXQsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgIGludCB2YWwpDQo+ID4gew0KPiA+
ICAgICAgIHN0cnVjdCBncGlvX3JlZ21hcCAqZ3BpbyA9IGdwaW9jaGlwX2dldF9kYXRhKGNoaXAp
Ow0KPiA+ICAgICAgIHVuc2lnbmVkIGludCBiYXNlID0gZ3Bpb19yZWdtYXBfYWRkcihncGlvLT5y
ZWdfc2V0X2Jhc2UpOw0KPiA+ICAgICAgIHVuc2lnbmVkIGludCByZWcsIG1hc2ssIG1hc2tfdmFs
LCB3cmVuX3JlZywgd3Jlbl9tYXNrOw0KPiA+ICAgICAgIGludCByZXQ7DQo+ID4NCj4gPiAgICAg
ICByZXQgPSBncGlvLT5yZWdfbWFza194bGF0ZShncGlvLCBHUElPX1JFR01BUF9TRVRfT1AsIGJh
c2UsDQo+IG9mZnNldCwgJnJlZywgJm1hc2spOw0KPiA+ICAgICAgIGlmIChyZXQpDQo+ID4gICAg
ICAgICAgICAgICByZXR1cm47DQo+ID4NCj4gPiAgICAgICBpZiAodmFsKQ0KPiA+ICAgICAgICAg
ICAgICAgbWFza192YWwgPSBtYXNrOw0KPiA+ICAgICAgIGVsc2UNCj4gPiAgICAgICAgICAgICAg
IG1hc2tfdmFsID0gMDsNCj4gPg0KPiA+ICAgICAvKiBMZXQgdGhlIGRyaXZlciBtb2RpZnkgdGhl
IG1hc2sgYW5kIG1hc2tfdmFsIHRvIGluY2x1ZGUgV1JFTiAqLw0KPiA+ICAgICAgIGlmIChncGlv
LT52YWx1ZV94bGF0ZSkgew0KPiA+ICAgICAgICAgICAgICAgcmV0ID0gZ3Bpby0+dmFsdWVfeGxh
dGUoJm1hc2ssICZtYXNrX3ZhbCk7DQo+IA0KPiBZZWFoLCBidXQgeW91IHByb2JhYmx5IGFsc28g
aGF2ZSB0byBwYXNzIGdwaW8gOikgQW5kIGF0IHRoaXMgcG9pbnQgSSdkIGNhbGwgaXQNCj4gdmFs
dWUgbm90IG1hc2tfdmFsIGFueW1vcmUuIEFuZCB0aGUgc2lnbmF0dXJlIHNob3VsZCBwcm9iYWJs
eSBsb29rcw0KPiBzb210aGluZyBsaWtlOg0KPiANCj4gaW50ICgqdmFsdWVfeGxhdGUpKHN0cnVj
dCBncGlvX2NoaXAgKmNoaXAsIGVudW0gZ3Bpb19yZWdtYXBfb3Agb3AsIHVuc2lnbmVkDQo+IGlu
dCBvZmZzZXQsIHVuc2lnbmVkIGludCByZWcsIHVuc2lnbmVkIGludCBtYXNrLCB1bnNpZ25lZCBp
bnQgKnZhbHVlKQ0KPiANCj4gbWFzayBzaG91bGRuJ3QgbmVlZCB0byBiZSBhIHBvaW50ZXIgYXMg
eW91IGRvbid0IGhhdmUgdG8gbW9kaWZ5IGl0LCBkbyB5b3U/DQo+IHJlZ19tYXNrX3hsYXRlLCBh
bHJlYWR5IGRvZXMgdGhhdC4NCj4gDQoNCkFjdHVhbGx5LCBJIGRvIG5lZWQgdG8gbW9kaWZ5IHRo
ZSAnbWFzaycsIHNvIGl0IHN0aWxsIG5lZWRzIHRvIGJlIHBhc3NlZA0KYXMgYSBwb2ludGVyIHRv
IHRoaXMgY2FsbGJhY2suDQoNClNpbmNlIHRoZSBXUkVOIGVuYWJsZSBiaXQgYW5kIHRoZSBkYXRh
IGJpdCBhcmUgbG9jYXRlZCBhdCBkaWZmZXJlbnQgYml0DQpwb3NpdGlvbnMsIHRoZSBmaW5hbCAn
bWFzaycgdXNlZCBpbiB3cml0ZSBBUEkgbXVzdCBiZSBleHBhbmRlZCB0byBpbmNsdWRlDQpib3Ro
IHRoZSBXUkVOIG1hc2sgYW5kIHRoZSBkYXRhIG1hc2suDQoNCkFzaWRlIGZyb20gbmVlZGluZyAn
bWFzaycgYXMgYSBwb2ludGVyLCBJIGNvbXBsZXRlbHkgYWdyZWUgd2l0aCB0aGUgcmVzdCBvZg0K
eW91ciBzdWdnZXN0ZWQgc2lnbmF0dXJlLg0KDQpCZXN0IFJlZ2FyZHMsDQpZdS1DaHVuDQoNCj4g
LW1pY2hhZWwNCj4gDQo+ID4gICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+ICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+ICAgICAgIH0NCj4gPg0KPiA+ICAgICAgIC8qIGln
bm9yZSBpbnB1dCB2YWx1ZXMgd2hpY2ggc2hhZG93IHRoZSBvbGQgb3V0cHV0IHZhbHVlICovDQo+
ID4gICAgICAgaWYgKGdwaW8tPnJlZ19kYXRfYmFzZSA9PSBncGlvLT5yZWdfc2V0X2Jhc2UpDQo+
ID4gICAgICAgICAgICAgICByZXQgPSByZWdtYXBfd3JpdGVfYml0cyhncGlvLT5yZWdtYXAsIHJl
ZywgbWFzaywNCj4gbWFza192YWwpOw0KPiA+ICAgICAgIGVsc2UNCj4gPiAgICAgICAgICAgICAg
IHJldCA9IHJlZ21hcF91cGRhdGVfYml0cyhncGlvLT5yZWdtYXAsIHJlZywgbWFzaywNCj4gPiBt
YXNrX3ZhbCk7DQo+ID4NCj4gPiAgICAgICByZXR1cm4gcmV0Ow0KPiA+IH0NCj4gPg0KPiA+IEJl
c3QgUmVnYXJkcywNCj4gPiBZdS1DaHVuDQoNCg==
