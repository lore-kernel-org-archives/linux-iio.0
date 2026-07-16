Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65AE3DA5DC;
	Thu, 16 Jul 2026 12:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203807; cv=none; b=YUCPV2Cmyz61H5nCk7N3WAkmHuz2MMauda/l11kp4f/Nj3DhhcHSssYajFkW/osS5A1/K583fdKDXGaVV0pKiL54n1/ZBXAxozMBWx2KC0LHKpUGTihlaDK+RWOgKVqDunkH7du/t5mqMoD9ZAffdZ3M2KAJNK/pyy/VpF9RCGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203807; c=relaxed/simple;
	bh=RH04RLGz+jFlIqWnHEegMUoRMI01fhF20NaK8B6pDMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TJJS/Rg0KA1nQcNeUIUINtV5Lp/8PCQH2NukLycQsRKu6pit/2V9FX0ujRONOpjFLrum1XAMPJMKeRp2TEpKvjj085KGE89IBXSM1sF+MvpMqhy6J0BJgzHCxEY6DLQXXdJIE5m56hQsPsB1J7A8knHniRYRwJPH4OvRbvHKUmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FC89PrXK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FC89PrXK"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66GC8wLhA3620812, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784203738; bh=RH04RLGz+jFlIqWnHEegMUoRMI01fhF20NaK8B6pDMw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=FC89PrXKFju57TtTTAFDKLIpqT8K+zrLLqJZvevop/VX9IQuapCEyMsquHJ9OySqL
	 2mVH4njGdnheS849qfn+QOOFEMekesJfXxx/WPvbwauw/6Ed2/Uv260NFkdYqfxR7h
	 8gVRMVlnl5mJCYeSz1sJqpQcBcTV0JfeAu9oTxMyDwsfOHEfZnP4iiERwI+ufjJ+VL
	 zSRih+2xZu3KezvkmziaPf5ctik/BG16VFha9bFtmTeUQIWbdYzdOTGxWrSs+/8BoI
	 OueLMvOPUK9X9hqZ9OLMWkj2eLw6Q3UabJaqz/b50THmBHB6zGhuqfdhGBmDkQHGnE
	 WS/x39TeiDyQQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66GC8wLhA3620812
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 16 Jul 2026 20:08:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 16 Jul 2026 20:08:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 16 Jul 2026 20:08:58 +0800
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
Thread-Index: AQHc4cATPP5CAXxOA0S9aBj6QrzqgrYJ8C6AgFvXxWCACcZxAIAAIc4AgAALpoCAAAi9AIAAl8rg//9/lACAAIpZkP//gIUAgACMm8A=
Date: Thu, 16 Jul 2026 12:08:58 +0000
Message-ID: <b8eb4f0680b6424097d4b8049608b27b@realtek.com>
References: <d301ba0cd45d49d59e6a014188306ec9@realtek.com>
 <20260716062614.1507243-1-eleanor.lin@realtek.com>
 <aliV4u6_xzx9D9Aq@ashevche-desk.local>
 <DJZVLZ4LLD9E.3MPLYYXT1VQ9R@kernel.org>
 <alim_HGTD5RCupav@ashevche-desk.local>
 <9ee344c1d9c642bdb7d3b85bc922fe66@realtek.com>
 <DJZY1YPMDLIN.3W0QOPEI9L8JA@kernel.org>
 <068b13e117464cf38b7b215eee72fe7a@realtek.com>
 <DJZYVQSJL0MO.143E5QFQRAXVV@kernel.org>
In-Reply-To: <DJZYVQSJL0MO.143E5QFQRAXVV@kernel.org>
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

PiBIaSwNCj4gDQo+ID4+IGludCAoKnZhbHVlX3hsYXRlKShzdHJ1Y3QgZ3Bpb19jaGlwICpjaGlw
LCBlbnVtIGdwaW9fcmVnbWFwX29wIG9wLA0KPiA+PiB1bnNpZ25lZCBpbnQgb2Zmc2V0LCB1bnNp
Z25lZCBpbnQgcmVnLCB1bnNpZ25lZCBpbnQgbWFzaywgdW5zaWduZWQNCj4gPj4gaW50ICp2YWx1
ZSkNCj4gPj4NCj4gPj4gbWFzayBzaG91bGRuJ3QgbmVlZCB0byBiZSBhIHBvaW50ZXIgYXMgeW91
IGRvbid0IGhhdmUgdG8gbW9kaWZ5IGl0LCBkbyB5b3U/DQo+ID4+IHJlZ19tYXNrX3hsYXRlLCBh
bHJlYWR5IGRvZXMgdGhhdC4NCj4gPj4NCj4gPg0KPiA+IEFjdHVhbGx5LCBJIGRvIG5lZWQgdG8g
bW9kaWZ5IHRoZSAnbWFzaycsIHNvIGl0IHN0aWxsIG5lZWRzIHRvIGJlDQo+ID4gcGFzc2VkIGFz
IGEgcG9pbnRlciB0byB0aGlzIGNhbGxiYWNrLg0KPiA+DQo+ID4gU2luY2UgdGhlIFdSRU4gZW5h
YmxlIGJpdCBhbmQgdGhlIGRhdGEgYml0IGFyZSBsb2NhdGVkIGF0IGRpZmZlcmVudA0KPiA+IGJp
dCBwb3NpdGlvbnMsIHRoZSBmaW5hbCAnbWFzaycgdXNlZCBpbiB3cml0ZSBBUEkgbXVzdCBiZSBl
eHBhbmRlZCB0bw0KPiA+IGluY2x1ZGUgYm90aCB0aGUgV1JFTiBtYXNrIGFuZCB0aGUgZGF0YSBt
YXNrLg0KPiANCj4gWW91IGNvdWxkIHN0aWxsIHJldHVybiBib3RoIGJpdHMgaW4gdGhlIGZpcnN0
IHhsYXRlLCBubz8NCj4gDQo+IEJ1dCB5ZWFoLCB0aGF0IG1pZ2h0IGJlIGEgYml0IGFzeW1tZXRy
aWNhbCBhbmQgbm90IGludHVpdGl2ZS4gU28gY2hhbmdpbmcgdGhlDQo+IG1hc2sgKGFnYWluKSB3
aXRoIHRoZSB2YWx1ZSBzb3VuZHMgb2sgdG8gbWUuDQo+IA0KPiAtbWljaGFlbA0KPiANCg0KVGhh
bmtzIGZvciBhZ3JlZWluZy4gSnVzdCB0byBjbGFyaWZ5LCByZXR1cm5pbmcgYm90aCBiaXRzIGlu
IHRoZSBmaXJzdCB4bGF0ZQ0KYWN0dWFsbHkgd291bGRuJ3Qgd29yayBmdW5jdGlvbmFsbHkuDQoN
CklmICdtYXNrJyBpbmNsdWRlcyBib3RoIHRoZSBkYXRhIGFuZCBXUkVOIG1hc2tzLCBjbGVhcmlu
ZyB0aGUgR1BJTyB3aWxsDQppbmFkdmVydGVudGx5IGNsZWFyIHRoZSBXUkVOIGJpdCBpbiAndmFs
JyBhcyB3ZWxsLg0KDQoJcmV0ID0gZ3Bpby0+cmVnX21hc2tfeGxhdGUoLi4uLCAmbWFzayk7DQoJ
LyogSWYgb3V0cHV0IGlzIDAsIFdSRU4gYml0IGluIHZhbCBiZWNvbWVzIDAqLw0KCXZhbCA9IG91
dHB1dCA/IG1hc2sgOiAwOw0KDQpTaW5jZSB0aGUgV1JFTiBiaXQgbXVzdCBhbHdheXMgYmUgJzEn
IGZvciB0aGUgaGFyZHdhcmUgdG8gdXBkYXRlLCB3ZSBtdXN0DQphcHBlbmQgaXQgYWZ0ZXIgJ3Zh
bCcgaXMgZGV0ZXJtaW5lZC4NCg0KQmVzdCBSZWdhcmRzLA0KWXUtQ2h1bg0K
