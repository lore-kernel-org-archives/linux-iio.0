Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623BF3A9624;
	Tue, 21 Jul 2026 10:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630843; cv=none; b=Mc3N7A6wI0T9ioTX5bEuHtJp0mAMFOXOX57SutaV5HxSgaKTc/4PTGrRzqSkd8vOYu8I9hCxMd4m8vQblmeTURC8vqfBSBcij4bUgKxWUZGB8VWkQDeC1bHZcuuSMovL9LD355b64C/Mqp7y/rPBEW4FC4yO5N3x3EgcHkHN5Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630843; c=relaxed/simple;
	bh=hE1w0kX/6SU6ib8xxRjcx8F1a94GNLtuYjFT1/vCU5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jlVTR2/9wmAufJAoUf5DzOoW1UFxCcFJdXsASnaE3/gjLyfSZJhOitzKyASs6HEjkP6b7aIH3NTfGENdrxmOTPwJLIZitJEYSqUAS9s+Bk/O7UjEQyw1TK3CToTDanTSdKIllp5RL3BYgAJ0UYZW+4ixZWoNdrhrkfOGDGtwj3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=X3zLqLL1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="X3zLqLL1"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66LAklkA73115281, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784630807; bh=hE1w0kX/6SU6ib8xxRjcx8F1a94GNLtuYjFT1/vCU5I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=X3zLqLL1TRghSQnh8FUsbbAFMU8WZ80HgZKlAPAVaxOWn9nFy/dRIzdUrnQThNe1e
	 JFo3Q7hpSryQK6KCQwrw4pX1V90YsuiCCeEfEIDygjFd05670B5G+kswRqtSF0uKoF
	 fntNfy9hAVRTT3+mB3qZey418wjzMKr7hWH3EysHsifRzJ0tP2NN+o1KVPBs+05qNT
	 b+DFd39p/R1Wm118G4seSXYIPd+ecJgJ80X7ucUhAnhHiAS0bEsRTszLZrShQmXeM8
	 XzIMcdcBsL6NfaZpAHjci7NwpwhU6FQ3FLlmzl6nH/oxUL9Id5huVZLMUH/08v6KXw
	 kQvIEL91FvF6w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66LAklkA73115281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 18:46:47 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 18:46:48 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 18:46:47 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 21 Jul 2026 18:46:47 +0800
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
Thread-Index: AQHdGN5IJQDSpRIowU2BMchTrbLbjLZ3C9GAgAC+36A=
Date: Tue, 21 Jul 2026 10:46:47 +0000
Message-ID: <520080c564ef4a039b67d2a820e7a646@realtek.com>
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-7-eleanor.lin@realtek.com>
 <DK42I02A80FJ.1TX1U341LOAXG@kernel.org>
In-Reply-To: <DK42I02A80FJ.1TX1U341LOAXG@kernel.org>
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

SGkgTWljaGFlbCwNCg0KPk9uIFR1ZSBKdWwgMjEsIDIwMjYgYXQgODo1OCBBTSBDRVNULCBZdS1D
aHVuIExpbiB3cm90ZToNCg0KKC4uLikNCg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
Z3Bpby9yZWdtYXAuaCBiL2luY2x1ZGUvbGludXgvZ3Bpby9yZWdtYXAuaCANCj4+IGluZGV4IDQ1
YTMwZjUwMDQzZi4uMjM0NjA5OTVjMWQxIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVkZS9saW51eC9n
cGlvL3JlZ21hcC5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2dwaW8vcmVnbWFwLmgNCj4+IEBA
IC04OSw2ICs4OSw5IEBAIGVudW0gZ3Bpb19yZWdtYXBfb3BlcmF0aW9uIHsNCj4+ICAgKgkJCW1h
c2sgYmVmb3JlIHdyaXRpbmcuIFRoaXMgYWxsb3dzIGRyaXZlci1zcGVjaWZpYyBsb2dpYw0KPj4g
ICAqCQkJdG8gYXBwZW5kIGFkZGl0aW9uYWwgYml0cyAobGlrZSB3cml0ZS1lbmFibGUgbWFza3Mp
DQo+PiAgICoJCQlkeW5hbWljYWxseSBiYXNlZCBvbiB0aGUgY3VycmVudCBvcGVyYXRpb24uDQo+
PiArICogQHNldF9jb25maWc6CQkoT3B0aW9uYWwpIENhbGxiYWNrIGZvciBzZXR0aW5nIEdQSU8g
Y29uZmlndXJhdGlvbiBzdWNoDQo+PiArICoJCQlhcyBkZWJvdW5jZSwgZHJpdmUgc3RyZW5ndGgs
IG9yIG90aGVyIGhhcmR3YXJlIHNwZWNpZmljDQo+PiArICoJCQlzZXR0aW5ncy4NCj4+ICAgKiBA
ZHJ2ZGF0YToJCShPcHRpb25hbCkgUG9pbnRlciB0byBkcml2ZXIgc3BlY2lmaWMgZGF0YSB3aGlj
aCBpcw0KPj4gICAqCQkJbm90IHVzZWQgYnkgZ3Bpby1yZW1hcCBidXQgaXMgcHJvdmlkZWQgImFz
IGlzIiB0byB0aGUNCj4+ICAgKgkJCWRyaXZlciBjYWxsYmFjayhzKS4NCj4+IEBAIC0xNTAsNiAr
MTUzLDggQEAgc3RydWN0IGdwaW9fcmVnbWFwX2NvbmZpZyB7DQo+PiAgCQkJICAgdW5zaWduZWQg
aW50IGJhc2UsIHVuc2lnbmVkIGludCBvZmZzZXQsIHVuc2lnbmVkIGludCByZWcsDQo+PiAgCQkJ
ICAgdW5zaWduZWQgaW50ICptYXNrLCB1bnNpZ25lZCBpbnQgKnZhbCk7DQo+PiAgDQo+PiArCWlu
dCAoKnNldF9jb25maWcpKHN0cnVjdCBncGlvX2NoaXAgKmdjLCB1bnNpZ25lZCBpbnQgb2Zmc2V0
LCANCj4+ICt1bnNpZ25lZCBsb25nIGNvbmZpZyk7DQo+PiArDQo+DQo+IERvIHdlIG5lZWQgYW4g
YWRkaXRpb25hbCBzdHJ1Y3QgZ3Bpb19yZWdtYXAgcG9pbnRlciBhcyBhIGZpcnN0IGFyZ3VtZW50
PyBIb3cNCj4gZG9lcyB0aGUgZHJpdmVyIGZldGNoIHRoZSBhdHRhY2hlZCBvcGFxdWUgZGF0YSBw
b2ludGVyPyBJIHNlZSB0aGF0IHlvdXIgZHJpdmVyIGlzIGRvaW5nDQo+DQo+IHN0cnVjdCBydGQx
NjI1X2dwaW8gKmRhdGEgPSBncGlvY2hpcF9nZXRfZGF0YShjaGlwKQ0KPg0KPiBCdXQgaXQgaXMg
dGhlIGdwaW8tcmVnbWFwIGNvcmUgd2hpY2ggd2lsbCBhdHRhY2ggaXQncyBvd24gZGF0YSBwb2lu
dGVyIHRvIGdwaW9fY2hpcCwgbm8/DQo+DQo+IC1taWNoYWVsDQoNCllvdSBhcmUgcmlnaHQuIEkg
bWlzdGFrZW5seSB1c2VkIGdwaW9jaGlwX2dldF9kYXRhKCkgaGVyZS4NCg0KTXkgY3VycmVudCBw
bGFuIHRvIGZpeCB0aGlzIGlzOg0KVGhlIHNldF9jb25maWcgY2FsbGJhY2sgaW4gJ3N0cnVjdCBn
cGlvX3JlZ21hcF9jb25maWcnIGFuZCAnc3RydWN0IGdwaW9fcmVnbWFwJw0Kc2hvdWxkIHRha2Ug
J3N0cnVjdCBncGlvX3JlZ21hcCAqJyBhcyB0aGUgZmlyc3QgYXJndW1lbnQgKHJlcGxhY2luZw0K
J3N0cnVjdCBncGlvX2NoaXAgKicpLCBhbmQgdGhlIGRyaXZlciBzaG91bGQgdXNlICdncGlvX3Jl
Z21hcF9nZXRfZHJ2ZGF0YSgpJw0KdG8gcmV0cmlldmUgaXRzIG93biBkYXRhIHBvaW50ZXIuDQoN
CkknbGwgYWRkIGEgd3JhcHBlciBpbiBncGlvLXJlZ21hcC5jIHRoYXQgYnJpZGdlcyBncGlvX2No
aXAgdG8gZ3Bpb19yZWdtYXAgYW5kDQpoYW5kbGVzIHRoZSBmYWxsYmFjayB0byBncGlvY2hpcF9n
ZW5lcmljX2NvbmZpZygpLg0KDQpCZXN0IFJlZ2FyZHMsDQpZdS1DaHVuDQo=
