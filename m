Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8123F24336D;
	Fri, 24 Jul 2026 05:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872097; cv=none; b=pFpmg6aYG7x407hwc68aqiivuToMljKfbEGaFb4tcFxqgvczBDUUbdirolj9vGx4nnJNvZVvedsQzOX+Vc/TJi4DP3OXHVVimZCu9nuHvv3J83R7B6RpNyo/p5lpkJ/UnOdFBDhqXbbw6kQEoqivkli/wfUKVeEdwvBWFQGRauU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872097; c=relaxed/simple;
	bh=pRKhmNblUuOdIiP1uDhQByrIlDODpIb9SOjGcRX55VU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fJ7jnsuTVgeWbRC2aDaB4I52oFgTxvvHN4TQu+x8Ho087jDLfKMtjnVealGKGaiqzZDd49URDLhjpkWCvNSY6KZS8/Q2DmjUvsb05mMJu7cRjF+gVktxudZEM9pZycg4e9hNXSNsY+d8xVCkXCnrVSXkZfrYNQZ7DAwYS9xhQ4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=F3vDbIsO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="F3vDbIsO"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66O5lQjxD999637, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784872046; bh=pRKhmNblUuOdIiP1uDhQByrIlDODpIb9SOjGcRX55VU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=F3vDbIsOC9mvNHEEuY/IZKmHP7gFPR4+otEKZqxGLZg0nyU/uOafLVvK0pwJ5pvWn
	 IuBXtBUUx2mmkYw4BgDndwYzzMuKU5Bop76acGr4cjGIN1anmRx2J6Rqt5OPlDcZB2
	 c/rpo4Li5pnd5io+4gnS4TBh8XQufhMtox0n5Foo7ims20TZYoFMylz0rXEUSW/5Y9
	 f9hQtHNnoT2v+dZ9gxQD7YwlQMxjwUVZo1Jd5obpnPmRy3N5Kv5l5mTdfr1t7vDqgZ
	 rKLvtwA5dY7MxXVHY+5s3ZU1FGoCOsWabgweM2aaolMQjp9j54dsgIqzpT4y6UHdUk
	 f8Gt2Z069/Dkw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66O5lQjxD999637
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Jul 2026 13:47:26 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 24 Jul 2026 13:47:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 24 Jul 2026 13:47:26 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 24 Jul 2026 13:47:24 +0800
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
Thread-Index: AQHdGlVbAgYGyBxDqk+qdE3R2tmcA7Z6JLWAgADOVPD//3ytAIABtq3g
Date: Fri, 24 Jul 2026 05:47:24 +0000
Message-ID: <bb4d02c9d5de442b9324587e9b7aaeb1@realtek.com>
References: <20260723034237.2501507-1-eleanor.lin@realtek.com>
 <20260723034237.2501507-6-eleanor.lin@realtek.com>
 <DK5R2VCAK468.2GAEC7VG8OJBZ@kernel.org>
 <f4b79d5510b64ad3bc2d716a51d21cfe@realtek.com>
 <DK5WSEM5SVXT.2A5HHVXDHGYGF@kernel.org>
In-Reply-To: <DK5WSEM5SVXT.2A5HHVXDHGYGF@kernel.org>
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

PiBIaSwNCj4NCj4gT24gVGh1IEp1bCAyMywgMjAyNiBhdCAxOjE0IFBNIENFU1QsIFl1LUNodW4g
TGluIFuqTK+np2ddIHdyb3RlOg0KPj4gUmVnYXJkaW5nIHRoZSBoYXJkd2FyZSwgdGhpcyBjb250
cm9sbGVyIGluZGVlZCBoYXMgZGVkaWNhdGVkIGFuZCANCj4+IHNlcGFyYXRlIGJpdHMgZm9yIElO
LCBPVVQsIGFuZCBESVIuIElmIGNvbmZpZ3VyZWQgYXMgYW4gb3V0cHV0LCANCj4+IHJlYWRpbmcg
dGhlIElOIGJpdCBkb2VzIG5vdCByZWZsZWN0IHRoZSBhY3R1YWwgc3RhdGUsIHNvIHdlIG11c3Qg
Y2hlY2sgDQo+PiB0aGUgRElSIGJpdCBmaXJzdCB0byBrbm93IHdoaWNoIGJpdCB0byByZWFkLg0K
Pg0KPiBKdXN0IG91dCBvZiBjdXJpb3NpdHksIHRoZSBvdXQgYml0IGlzIGFsc28gdGhlIGNvbnRy
b2wgYml0IHdoaWNoDQo+IHdpbGwgc2V0IHRoZSBncGlvIGxpbmUgc3RhdGUsIGNvcnJlY3Q/IElP
VywgeW91IGFyZSByZWFkaW5nIGp1c3QgdGhlDQo+IGJpdCB5b3UndmUgc2V0IGJlZm9yZSBhbmQg
dGhlcmUgaXMgbm8gd2F5IHRvIHJlYWQgdGhlIHJlYWwgbGluZSBzdGF0ZS4NCj4NCj4gLW1pY2hh
ZWwNCg0KSW4gb3VyIGN1cnJlbnQgaW1wbGVtZW50YXRpb24sIHdoZW4gY29uZmlndXJlZCBhcyBh
biBvdXRwdXQsIHdlIG9ubHkgcmVhZA0KYmFjayB0aGUgc3RhdGUgd2Ugc2V0Lg0KDQpCZXN0IFJl
Z2FyZHMsDQpZdS1DaHVuDQo=
