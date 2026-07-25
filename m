Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F5472627;
	Sat, 25 Jul 2026 12:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784983735; cv=none; b=ZTcYWQK/DpuZXX0BhXFP/EJ1yYDcjA4qyb3270T28gGbDhBQhE6ksKp/7P3KaJFrXfn3x2HlZUWErlMJlWj1zmQpXchGqtI5RFkIEIfVKeQp0VR8dnqiARgU9OcNGfCfTXb0JI4SxBD3TEbe3n/b4F/wD4MXpMzlmEC7D8hfUK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784983735; c=relaxed/simple;
	bh=Av4Bn+YSGRvGi+rY85WbBxqve3tJoV+orody3IYR/8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sBSTRQN7RMzmhcvM90GNkzm+znmSdKd/F37EfyNL82DYZT3qxXE0OPooiYOi7zKoCJ93o0kJrb3zpH5v07JAGj/lTAYaXtTmFlr4gboL1Gfy+aISkbdQRoNmpQw5GtxVuayHFfdTbWYTBwYBsFWYnJdqtN/K3cIuql5+eyaj5s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=M9evjnyK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="M9evjnyK"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66PCm2xdD1763308, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784983682; bh=Av4Bn+YSGRvGi+rY85WbBxqve3tJoV+orody3IYR/8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=M9evjnyKw7mauaBq79X0LbQql5eXKNaq4nQiszneP3/D31keid1Cg9Xzwg2er6gbg
	 qxOXG4gcScVMvojqEZPXEO9Hn5kEvdJL3axM39FcpuCi+Kg8yfz9K3HeVg4ITbEUbQ
	 8hKYx/ogB5iuJJiaHH+QDBPoArHQCCVY4qvNLKXmQvkRQRn9HeLq8m0c0ekZO5X4rx
	 cN/8MghuT3LPYO/7qcPfFe41rW5HDkcd7pM0fUljryX5PQiyyoG5zVVU57jpsE1i/C
	 TS3at5Q4v2khAgJ6GPNOEYlX70h8HV2GS64xS1EMvBFhfroKo6tQOKYnBnzG+Yk+zj
	 wWi6y4tE560zg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66PCm2xdD1763308
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 25 Jul 2026 20:48:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 25 Jul 2026 20:48:03 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sat, 25 Jul 2026 20:48:02 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Sat, 25 Jul 2026 20:48:02 +0800
From: =?big5?B?WXUtQ2h1biBMaW4gW6pMr6enZ10=?= <eleanor.lin@realtek.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: "linusw@kernel.org" <linusw@kernel.org>, "andriy.shevchenko@intel.com"
	<andriy.shevchenko@intel.com>, "mwalle@kernel.org" <mwalle@kernel.org>,
	"brgl@kernel.org" <brgl@kernel.org>, =?big5?B?VFlfQ2hhbmdbsWmkbLZoXQ==?=
	<tychang@realtek.com>, "wbg@kernel.org" <wbg@kernel.org>,
	"mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>,
	"nuno.sa@analog.com" <nuno.sa@analog.com>, "Michael.Hennerich@analog.com"
	<Michael.Hennerich@analog.com>, "andy@kernel.org" <andy@kernel.org>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"dakr@kernel.org" <dakr@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "o-takashi@sakamocchi.jp" <o-takashi@sakamocchi.jp>,
	"dlechner@baylibre.com" <dlechner@baylibre.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, "linux@analog.com"
	<linux@analog.com>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	=?big5?B?Q1lfSHVhbmdbtsDgsq7LXQ==?= <cy.huang@realtek.com>,
	=?big5?B?SmFtZXMgVGFpIFvAuafTrnBd?= <james.tai@realtek.com>
Subject: RE: [PATCH v6 5/8] gpio: regmap: Add gpio_regmap_operation and
 value_xlate support
Thread-Topic: [PATCH v6 5/8] gpio: regmap: Add gpio_regmap_operation and
 value_xlate support
Thread-Index: AQHdGN5I8WbpmIM47EyUD7twNI9s1LZ8tSuAgAGAL/A=
Date: Sat, 25 Jul 2026 12:48:02 +0000
Message-ID: <6d1391c912514cf499b4e473be5db537@realtek.com>
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
	<20260721065802.689530-6-eleanor.lin@realtek.com>
 <20260724225057.520dfbeb@jic23-huawei>
In-Reply-To: <20260724225057.520dfbeb@jic23-huawei>
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

PiBPbiBUdWUsIDIxIEp1bCAyMDI2IDE0OjU3OjU5ICswODAwDQo+IFl1LUNodW4gTGluIDxlbGVh
bm9yLmxpbkByZWFsdGVrLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEV4dGVuZCB0aGUgcmVnX21hc2tf
eGxhdGUgY2FsbGJhY2sgd2l0aCBhbiBvcGVyYXRpb24gdHlwZSBwYXJhbWV0ZXINCj4gPiAoZW51
bSBncGlvX3JlZ21hcF9vcGVyYXRpb24pIHRvIGFsbG93IGRyaXZlcnMgdG8gcmV0dXJuIGRpZmZl
cmVudA0KPiA+IHJlZ2lzdGVyL21hc2sgY29tYmluYXRpb25zIGRlcGVuZGluZyBvbiB0aGUgc3Bl
Y2lmaWMgR1BJTyBvcGVyYXRpb24uDQo+ID4NCj4gPiBJbiBhZGRpdGlvbiwgaW50cm9kdWNlIGEg
bmV3IG9wdGlvbmFsICd2YWx1ZV94bGF0ZScgY2FsbGJhY2suIFRoaXMNCj4gPiByb3V0aW5lIGFs
bG93cyBkcml2ZXJzIHRvIHRyYW5zbGF0ZSBvciBtb2RpZnkgdGhlIHJlZ2lzdGVyIHZhbHVlIGFu
ZA0KPiA+IG1hc2sgaW1tZWRpYXRlbHkgYmVmb3JlIGEgd3JpdGUgb3BlcmF0aW9uLiBJdCBpcyBw
YXJ0aWN1bGFybHkgdXNlZnVsDQo+ID4gZm9yIGhhcmR3YXJlIHRoYXQgcmVxdWlyZXMgYWRkaXRp
b25hbCBjb250cm9sIGJpdHMsIHN1Y2ggYXMgYQ0KPiA+IHdyaXRlLWVuYWJsZSBiaXQsIHRvIGJl
IGFwcGVuZGVkIHRvIHRoZSBkYXRhIGR5bmFtaWNhbGx5Lg0KPiA+DQo+ID4gQ29uc2VxdWVudGx5
LCB1cGRhdGUgYWxsIGV4aXN0aW5nIGRyaXZlcnMgdXRpbGl6aW5nIHRoZSBncGlvLXJlZ21hcA0K
PiA+IGZyYW1ld29yayAoYWNyb3NzIGRyaXZlcnMvZ3BpbywgZHJpdmVycy9paW8sIGFuZCBkcml2
ZXJzL3BpbmN0cmwpIHRvDQo+ID4gYWNjb21tb2RhdGUgdGhlIG5ldyByZWdfbWFza194bGF0ZSBm
dW5jdGlvbiBzaWduYXR1cmUuDQo+ID4NCj4gPiBTdWdnZXN0ZWQtYnk6IExpbnVzIFdhbGxlaWog
PGxpbnVzd0BrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFl1LUNodW4gTGluIDxlbGVh
bm9yLmxpbkByZWFsdGVrLmNvbT4NCj4gQWNrZWQtYnk6IEpvbmF0aGFuIENhbWVyb24gPGpvbmF0
aGFuLmNhbWVyb25Ab3NzLnF1YWxjb21tLmNvbT4NCj4gI2Zvci1paW8NCg0KSGkgSm9uYXRoYW4s
DQoNClRoYW5rcyBmb3IgdGhlIEFja2VkLWJ5IHRhZyBvbiB2NiENCg0KSG93ZXZlciwgSSBoYXZl
IHNwbGl0IHRoaXMgcGF0Y2ggaW50byB0d28gc2VwYXJhdGUgcGF0Y2hlcyBpbiB0aGUgdjcuDQpU
aGUgdGhlIGNvcmUgbG9naWMgcmVtYWlucyB0aGUgc2FtZSBhcyBpbiB2Ni4NCkp1c3QgZGl2aWRl
ZCBmb3IgYmV0dGVyIHN0cnVjdHVyZS4gDQoNCkhlcmUgYXJlIHRoZSBsaW5rcyB0byB0aGUgdjcg
cGF0Y2hlczoNCkxpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNjA3MjMwMzQy
MzcuMjUwMTUwNy02LWVsZWFub3IubGluQHJlYWx0ZWsuY29tLw0KTGluazogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGttbC8yMDI2MDcyMzAzNDIzNy4yNTAxNTA3LTctZWxlYW5vci5saW5AcmVh
bHRlay5jb20vDQoNCkJlc3QgcmVnYXJkcywNCll1IENodW4NCg==
