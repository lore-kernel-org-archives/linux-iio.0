Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78F5321457;
	Fri, 24 Jul 2026 05:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784872226; cv=none; b=HN/WWVep44LdV6oYbAfsJSwmY2vvDX/0Vrq2MYCpGzg03MVLhM1kDzbM+3v6v0gQbOTjaw6GaMV9q++seBL2vfpPLJ2bbiUXm2aDPI7Ms29PXqEkDkN85JINFpu4ggiWkwlsQ2V+SIbAh75gNkM7YXkkoUgDP+4sopqOYbTGuus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784872226; c=relaxed/simple;
	bh=C3Ldm54X7DaMaLaqpP1usrwn0i16BXT+0c4NHTY8o8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RZkIFF8AHUiB0fC9CT7u6WNkY8BP+rGFcq2IqCcg142sYDNg2WER+2LX4XcB+8hZGeXZ/MzUxws54OwaAJr4P/i3wJ0lKY5PfMc1vlPjMspbriGtQl8oh/6AVmzKKy4ggK2raKERnv6e5ygYjcXNtM89s1RURzPCtg+Pv8AnQ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=UE41rIa8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="UE41rIa8"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66O5nvQ631001265, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784872197; bh=C3Ldm54X7DaMaLaqpP1usrwn0i16BXT+0c4NHTY8o8c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=UE41rIa8lFsKJE9Ii+LeiMz4CyMaSQsTZffUE8inshGKGFgNpVWTRPaCetRfimerF
	 EOZsKL1E+wfXkEAqd1v8GUc3ocTx5NZ/QWGq5tetSCKGMTZBofWZpiAXH3U+4GDmyH
	 xvNvvAUhlpngnX4n2UevywXyKnjq3Dc6RJtG+C4+JMx5YM4Fwt7PYwB6KMg2VFk1OE
	 ht4OP0CNuen+4etZFUc6BMfnr1GDOC1KWybxcZDai12N1JOtaZqkKT3B24k8rehffb
	 vrBuC+eXAgbEj9PXAJH6F4s/rZ/UDSYyrnrU2NfXax0D7xXooZa515iztZTCFq+QBk
	 lRrnLVQyME+Jw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66O5nvQ631001265
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 24 Jul 2026 13:49:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 24 Jul 2026 13:49:57 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Fri, 24 Jul 2026 13:49:57 +0800
From: =?utf-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>,
	"linusw@kernel.org" <linusw@kernel.org>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "mwalle@kernel.org" <mwalle@kernel.org>,
	"brgl@kernel.org" <brgl@kernel.org>, =?utf-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?=
	<tychang@realtek.com>, "wbg@kernel.org" <wbg@kernel.org>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>, "Michael.Hennerich@analog.com"
	<Michael.Hennerich@analog.com>, "jic23@kernel.org" <jic23@kernel.org>,
	"andy@kernel.org" <andy@kernel.org>, "u.kleine-koenig@baylibre.com"
	<u.kleine-koenig@baylibre.com>, "dakr@kernel.org" <dakr@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "o-takashi@sakamocchi.jp"
	<o-takashi@sakamocchi.jp>
CC: "dlechner@baylibre.com" <dlechner@baylibre.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux@analog.com"
	<linux@analog.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	=?utf-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
	=?utf-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>
Subject: RE: [PATCH v7 9/9] gpio: realtek: Add driver for Realtek DHC RTD1625
 SoC
Thread-Topic: [PATCH v7 9/9] gpio: realtek: Add driver for Realtek DHC RTD1625
 SoC
Thread-Index: AQHdGlVcRKLWXF+PVUK+hLPgsNfnkrZ6xDeAgAFnkfA=
Date: Fri, 24 Jul 2026 05:49:56 +0000
Message-ID: <35f478ec14374c9c99f9a6ec37784d60@realtek.com>
References: <20260723034237.2501507-1-eleanor.lin@realtek.com>
 <20260723034237.2501507-10-eleanor.lin@realtek.com>
 <DK637ZCIRBUN.2YESFM7RFP8PM@bootlin.com>
In-Reply-To: <DK637ZCIRBUN.2YESFM7RFP8PM@bootlin.com>
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

SGkgTWF0aGlldSwNCg0KPiBPbiBUaHUgSnVsIDIzLCAyMDI2IGF0IDU6NDIgQU0gQ0VTVCwgWXUt
Q2h1biBMaW4gd3JvdGU6DQo+IA0KPiBIaSwNCj4gDQo+ID4gRnJvbTogVHp1eWkgQ2hhbmcgPHR5
Y2hhbmdAcmVhbHRlay5jb20+DQo+ID4gK3N0YXRpYyB2b2lkIHJ0ZDE2MjVfZ3Bpb19pcnFfaGFu
ZGxlKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykgew0KPiA+ICsgICAgIHVuc2lnbmVkIGludCAoKmdl
dF9yZWdfb2Zmc2V0KShzdHJ1Y3QgcnRkMTYyNV9ncGlvICpncGlvLCB1bnNpZ25lZA0KPiBpbnQg
b2Zmc2V0KTsNCj4gPiArICAgICBzdHJ1Y3QgcnRkMTYyNV9ncGlvICpkYXRhID0gaXJxX2Rlc2Nf
Z2V0X2hhbmRsZXJfZGF0YShkZXNjKTsNCj4gPiArICAgICBzdHJ1Y3QgaXJxX2NoaXAgKmNoaXAg
PSBpcnFfZGVzY19nZXRfY2hpcChkZXNjKTsNCj4gPiArICAgICB1bnNpZ25lZCBpbnQgaXJxID0g
aXJxX2Rlc2NfZ2V0X2lycShkZXNjKTsNCj4gPiArICAgICBzdHJ1Y3QgaXJxX2RvbWFpbiAqZG9t
YWluID0gZGF0YS0+ZG9tYWluOw0KPiA+ICsgICAgIHVuc2lnbmVkIGludCByZWdfb2Zmc2V0LCBp
LCBqLCB2YWw7DQo+ID4gKyAgICAgaXJxX2h3X251bWJlcl90IGh3aXJxOw0KPiA+ICsgICAgIHVu
c2lnbmVkIGxvbmcgc3RhdHVzOw0KPiA+ICsgICAgIHUzMiBpcnFfdHlwZTsNCj4gPiArDQo+ID4g
KyAgICAgaWYgKGlycSA9PSBkYXRhLT5pcnFzW1JURDE2MjVfSVJRX0FTU0VSVF0pDQo+ID4gKyAg
ICAgICAgICAgICBnZXRfcmVnX29mZnNldCA9ICZydGQxNjI1X2dwaW9fZ3BhX29mZnNldDsNCj4g
PiArICAgICBlbHNlIGlmIChpcnEgPT0gZGF0YS0+aXJxc1tSVEQxNjI1X0lSUV9ERUFTU0VSVF0p
DQo+ID4gKyAgICAgICAgICAgICBnZXRfcmVnX29mZnNldCA9ICZydGQxNjI1X2dwaW9fZ3BkYV9v
ZmZzZXQ7DQo+ID4gKyAgICAgZWxzZSBpZiAoaXJxID09IGRhdGEtPmlycXNbUlREMTYyNV9JUlFf
TEVWRUxdKQ0KPiA+ICsgICAgICAgICAgICAgZ2V0X3JlZ19vZmZzZXQgPSAmcnRkMTYyNV9ncGlv
X2xldmVsX29mZnNldDsNCj4gPiArICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAgICByZXR1cm47
DQo+ID4gKw0KPiA+ICsgICAgIGNoYWluZWRfaXJxX2VudGVyKGNoaXAsIGRlc2MpOw0KPiA+ICsN
Cj4gPiArICAgICBmb3IgKGkgPSAwOyBpIDwgZGF0YS0+aW5mby0+bnVtX2dwaW9zOyBpICs9IDMy
KSB7DQo+ID4gKyAgICAgICAgICAgICByZWdfb2Zmc2V0ID0gZ2V0X3JlZ19vZmZzZXQoZGF0YSwg
aSk7DQo+ID4gKyAgICAgICAgICAgICByZWdtYXBfcmVhZChkYXRhLT5yZWdtYXAsIHJlZ19vZmZz
ZXQsICZ2YWwpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgIHN0YXR1cyA9IHZhbDsNCj4gDQo+
IENhbiB0aGUgcmVnbWFwX3JlYWQoKSBmYWlsIGhlcmU/IFdlIGFyZSBub3QgY2hlY2tpbmcgaXRz
IHJldHVybiwgc28gbWF5YmUNCj4gc3RhdHVzIHdpbGwgY29udGFpbiBnYXJiYWdlPw0KPiANCg0K
QWdyZWVkLiBXaWxsIGZpeC4NCg0KQmVzdCBSZWdhcmRzLA0KWXUtQ2h1bg0KDQo+IFRoYW5rcywN
Cj4gTWF0aGlldQ0KPg0K
