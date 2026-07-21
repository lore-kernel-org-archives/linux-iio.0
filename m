Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40ADA48A2D0;
	Tue, 21 Jul 2026 10:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630075; cv=none; b=ICjEPD+mxZC3cLXkEwq+GxI5uj0Jrc4gELhSEvumd5EsUVMXTGBuom5UByo+o/S7ZyOzWGqV2dAEMrD+WWe+AiSM0vmgwPGnbBB993Gh9iJonQGnCpLPjPjU3TA+ijxu90gw06nMCFx79JKhqPke/4778lATPsfOiPuVq9cGQNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630075; c=relaxed/simple;
	bh=84FtR4WQih89FesalZbJbpMxdvtz3bEARCAwwU3/gXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PWugHqXaGuMrwLRB5ewL0vzTfVKDRpO/m6jyveC64/mRPMXnYOjRMvM7TJReiaPaePaOhWYfkLyilkF/F6WMBA1WEWG8fc1vgs1z0/9sE7/sxYp/q8qL8hIbNHkoEaZXG8nN8Pa5wyPJJ8xOA7Y07gDTWFOH98km/WF2YJr52ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MfeZvGWK; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MfeZvGWK"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66LAY1rF43109225, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784630041; bh=84FtR4WQih89FesalZbJbpMxdvtz3bEARCAwwU3/gXg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MfeZvGWKS3CQ66yiGu/D8NEm6JUo7epHUDbJWzhGFKBKnby3+B0y/tobw9uVVDqeG
	 eQHONNNxJwSFiA7Q2kGLotZwQ2y7eKo87Hg3PvFKGa66LsYCXVKetS01Ch+y6oMOn3
	 Bn/OzNXIElMobpRuCNG45gIg0P2nomQ4SgKVVn3g0wLxDSBwZo3dzfIzvyXty86I27
	 EdfffNYzziE6k3mQL9L3z3t5Jr85vycY1qJ6N2o2qxrlIjsaDtOwdALV+yFPV/2pd+
	 G7FBt4u8bHYV8kABjcwZBNRHYVXf3M1+3Mu0dxhEaYUDS+7cly6SMX8I5bZB8dqrvk
	 QnVHLjD0Bb3YA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66LAY1rF43109225
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 18:34:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 18:34:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Tue, 21 Jul 2026 18:34:01 +0800
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
Subject: RE: [PATCH v6 5/8] gpio: regmap: Add gpio_regmap_operation and
 value_xlate support
Thread-Topic: [PATCH v6 5/8] gpio: regmap: Add gpio_regmap_operation and
 value_xlate support
Thread-Index: AQHdGN5I8WbpmIM47EyUD7twNI9s1LZ3CZSAgAC9YjA=
Date: Tue, 21 Jul 2026 10:34:01 +0000
Message-ID: <5eca2915f98e4cb8ab182ccc01b0fa33@realtek.com>
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
 <20260721065802.689530-6-eleanor.lin@realtek.com>
 <DK42BVHLGJV1.1TC0EG2OJA7ON@kernel.org>
In-Reply-To: <DK42BVHLGJV1.1TC0EG2OJA7ON@kernel.org>
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

SGkgTWljaGFlbCwNCg0KPiBIaQ0KPg0KPiBUaGFua3MhIExvb2tzIHZlcnkgZ29vZCwgYSBmZXcg
Y29tbWVudHMgYmVsb3cuDQo+DQo+IE9uIFR1ZSBKdWwgMjEsIDIwMjYgYXQgODo1NyBBTSBDRVNU
LCBZdS1DaHVuIExpbiB3cm90ZToNCj4+IEV4dGVuZCB0aGUgcmVnX21hc2tfeGxhdGUgY2FsbGJh
Y2sgd2l0aCBhbiBvcGVyYXRpb24gdHlwZSBwYXJhbWV0ZXIgDQo+PiAoZW51bSBncGlvX3JlZ21h
cF9vcGVyYXRpb24pIHRvIGFsbG93IGRyaXZlcnMgdG8gcmV0dXJuIGRpZmZlcmVudCANCj4+IHJl
Z2lzdGVyL21hc2sgY29tYmluYXRpb25zIGRlcGVuZGluZyBvbiB0aGUgc3BlY2lmaWMgR1BJTyBv
cGVyYXRpb24uDQo+Pg0KPj4gSW4gYWRkaXRpb24sIGludHJvZHVjZSBhIG5ldyBvcHRpb25hbCAn
dmFsdWVfeGxhdGUnIGNhbGxiYWNrLiBUaGlzIA0KPj4gcm91dGluZSBhbGxvd3MgZHJpdmVycyB0
byB0cmFuc2xhdGUgb3IgbW9kaWZ5IHRoZSByZWdpc3RlciB2YWx1ZSBhbmQgDQo+PiBtYXNrIGlt
bWVkaWF0ZWx5IGJlZm9yZSBhIHdyaXRlIG9wZXJhdGlvbi4gSXQgaXMgcGFydGljdWxhcmx5IHVz
ZWZ1bCANCj4+IGZvciBoYXJkd2FyZSB0aGF0IHJlcXVpcmVzIGFkZGl0aW9uYWwgY29udHJvbCBi
aXRzLCBzdWNoIGFzIGEgDQo+PiB3cml0ZS1lbmFibGUgYml0LCB0byBiZSBhcHBlbmRlZCB0byB0
aGUgZGF0YSBkeW5hbWljYWxseS4NCj4NCj4gUGxlYXNlIHNwbGl0IHRoYXQgaW50byB0d28gcGF0
Y2hlcy4NCj4NCg0KSSB3aWxsIHNwbGl0IHRoZSB2YWx1ZV94bGF0ZSBhbmQgcmVnX21hc2tfeGxh
dGUgY2hhbmdlcyBpbnRvIHNlcGFyYXRlDQpwYXRjaGVzLg0KDQo+PiBDb25zZXF1ZW50bHksIHVw
ZGF0ZSBhbGwgZXhpc3RpbmcgZHJpdmVycyB1dGlsaXppbmcgdGhlIGdwaW8tcmVnbWFwIA0KPj4g
ZnJhbWV3b3JrIChhY3Jvc3MgZHJpdmVycy9ncGlvLCBkcml2ZXJzL2lpbywgYW5kIGRyaXZlcnMv
cGluY3RybCkgdG8gDQo+PiBhY2NvbW1vZGF0ZSB0aGUgbmV3IHJlZ19tYXNrX3hsYXRlIGZ1bmN0
aW9uIHNpZ25hdHVyZS4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IExpbnVzIFdhbGxlaWogPGxpbnVz
d0BrZXJuZWwub3JnPg0KPj4gU2lnbmVkLW9mZi1ieTogWXUtQ2h1biBMaW4gPGVsZWFub3IubGlu
QHJlYWx0ZWsuY29tPg0KPj4gLS0tDQo+PiBDaGFuZ2VzIGluIHY2Og0KPj4gLSBSZW1vdmUgcmVt
b3ZlZCB0aGUgaGFyZGNvZGVkIHdyaXRlLWVuYWJsZSB3b3JrYXJvdW5kcy4NCj4+IC0gUmV0YWlu
IHRoZSBuZWNlc3NhcnkgcHJvdG90eXBlIHVwZGF0ZXMgaW4gZXZlcnkgZHJpdmVyIHVzaW5nIGN1
c3RvbSANCj4+IHJlZ19tYXNrX3hsYXRlDQo+PiAtIEFkZCB2YWx1ZV94bGF0ZSB0byBkeW5hbWlj
YWxseSBhZGp1c3QgdGhlIHJlZ2lzdGVyIG1hc2sgYW5kIHZhbHVlIA0KPj4gcmlnaHQgYmVmb3Jl
IHRoZSBhY3R1YWwgcmVnaXN0ZXIgd3JpdGUgb3BlcmF0aW9uLg0KPj4gLS0tDQo+PiAgZHJpdmVy
cy9ncGlvL2dwaW8tMTA0LWlkaS00OC5jICAgICAgICB8ICA3ICstLQ0KPj4gIGRyaXZlcnMvZ3Bp
by9ncGlvLWk4MjU1LmMgICAgICAgICAgICAgfCAgNCArLQ0KPj4gIGRyaXZlcnMvZ3Bpby9ncGlv
LWlkaW8tMTYuYyAgICAgICAgICAgfCAgNiArLS0NCj4+ICBkcml2ZXJzL2dwaW8vZ3Bpby1tYXg3
MzYwLmMgICAgICAgICAgIHwgIDEgKw0KPj4gIGRyaXZlcnMvZ3Bpby9ncGlvLXBjaWUtaWRpby0y
NC5jICAgICAgfCAgNiArLS0NCj4+ICBkcml2ZXJzL2dwaW8vZ3Bpby1yZWdtYXAuYyAgICAgICAg
ICAgIHwgNjIgKysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+PiAgZHJpdmVycy9paW8vYWRj
L2FkNzE3My5jICAgICAgICAgICAgICB8ICA4ICsrLS0NCj4+ICBkcml2ZXJzL2lpby9hZGRhYy9z
dHgxMDQuYyAgICAgICAgICAgIHwgIDYgKy0tDQo+PiAgZHJpdmVycy9waW5jdHJsL2JjbS9waW5j
dHJsLWJjbTYzeHguYyB8ICAxICsNCj4+ICBkcml2ZXJzL3BpbmN0cmwvcGluY3RybC10cHM2NTk0
LmMgICAgIHwgIDEgKw0KPj4gIGluY2x1ZGUvbGludXgvZ3Bpby9yZWdtYXAuaCAgICAgICAgICAg
fCA0NCArKysrKysrKysrKysrKysrKy0tDQo+PiAgMTEgZmlsZXMgY2hhbmdlZCwgMTE1IGluc2Vy
dGlvbnMoKyksIDMxIGRlbGV0aW9ucygtKQ0KPj4NCj4NCj4uLg0KPg0KPj4gZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvZ3Bpby9yZWdtYXAuaCBiL2luY2x1ZGUvbGludXgvZ3Bpby9yZWdtYXAu
aCANCj4+IGluZGV4IGEzYmE4MjQyYzM1My4uNDVhMzBmNTAwNDNmIDEwMDY0NA0KPj4gLS0tIGEv
aW5jbHVkZS9saW51eC9ncGlvL3JlZ21hcC5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2dwaW8v
cmVnbWFwLmgNCj4+IEBAIC0xMyw2ICsxMywzNiBAQCBzdHJ1Y3QgcmVnbWFwOw0KPj4gICNkZWZp
bmUgR1BJT19SRUdNQVBfQUREUl9aRVJPICgodW5zaWduZWQgaW50KSgtMSkpICAjZGVmaW5lIA0K
Pj4gR1BJT19SRUdNQVBfQUREUihhZGRyKSAoKGFkZHIpID8gOiBHUElPX1JFR01BUF9BRERSX1pF
Uk8pDQo+PiAgDQo+PiArLyoqDQo+PiArICogZW51bSBncGlvX3JlZ21hcF9vcGVyYXRpb24gLSBP
cGVyYXRpb24gdHlwZSBmb3IgcmVnX21hc2tfeGxhdGUgDQo+PiArY2FsbGJhY2sNCj4+ICsgKg0K
Pj4gKyAqIFRoaXMgZW51bSBpcyB1c2VkIHRvIGRpc3Rpbmd1aXNoIGJldHdlZW4gZGlmZmVyZW50
IHR5cGVzIG9mIEdQSU8gDQo+PiArb3BlcmF0aW9ucw0KPj4gKyAqIHNvIHRoYXQgdGhlIHJlZ19t
YXNrX3hsYXRlIGNhbGxiYWNrIGNhbiByZXR1cm4gdGhlIGFwcHJvcHJpYXRlIA0KPj4gK21hc2sg
Zm9yIGVhY2gNCj4+ICsgKiBvcGVyYXRpb24gdHlwZS4NCj4NCj4gIlRyYWRpdGlvbmFsbHkgaXQg
d2FzIGluZmVycmVkIGZyb20gdGhlIGJhc2UgcmVnc2lzdGVyLiBCdXQgdGhhdCBtaWdodCBub3QN
Cj4gYWx3YXlzIHdvcmssIGZvciBleGFtcGxlIGlmIGFsbCB0aGUgY29udHJvbCBiaXRzIG9mIG9u
ZSBHUElPIGxpdmVzIGluIHRoZQ0KPiBzYW1lIHJlZ2lzdGVyLiBUaGUgdXNlciBpcyBmcmVlIHRv
IGNob29zZSB3aGljaCBtZXRob2QgdGhleSdsbCB1c2UuIg0KPg0KDQpVbmRlcnN0b29kLiBJIHdp
bGwgYWRkIHRoaXMgYmFja2dyb3VuZCBjb250ZXh0IHRvIHRoZSBjb21tZW50Lg0KDQpCZXN0IFJl
Z2FyZHMsDQpZdS1DaHVuDQoNCj4+ICsgKg0KPj4gKyAqIFZhbHVlIG9wZXJhdGlvbnM6DQo+PiAr
ICogQEdQSU9fUkVHTUFQX0dFVF9PUDogTWFzayBmb3IgcmVhZGluZyBkaXJlY3Rpb24gdG8gZGV0
ZWN0IGlmIEdQSU8gaXMgaW5wdXQgb3Igb3V0cHV0Lg0KPj4gKyAqICAgICAgICAgICAgICAgICAg
ICAgIFVzZWQgaW4gZ3Bpb19yZWdtYXBfZ2V0KCkgdG8gZGV0ZXJtaW5lIHRoZSBHUElPIGRpcmVj
dGlvbi4NCj4+ICsgKiBAR1BJT19SRUdNQVBfSU46IE1hc2sgZm9yIHJlYWRpbmcgaW5wdXQgdmFs
dWUuIFVzZWQgd2hlbiBHUElPIGlzIGNvbmZpZ3VyZWQgYXMgaW5wdXQuDQo+PiArICogQEdQSU9f
UkVHTUFQX09VVDogTWFzayBmb3IgcmVhZGluZyBvdXRwdXQgdmFsdWUuIFVzZWQgd2hlbiBHUElP
IGlzIGNvbmZpZ3VyZWQgYXMgb3V0cHV0Lg0KPj4gKyAqDQo+PiArICogT3V0cHV0IG9wZXJhdGlv
bnM6DQo+PiArICogQEdQSU9fUkVHTUFQX1NFVF9PUDogTWFzayBmb3Igc2V0dGluZyBHUElPIG91
dHB1dCB2YWx1ZS4NCj4+ICsgKg0KPj4gKyAqIERpcmVjdGlvbiBvcGVyYXRpb25zOg0KPj4gKyAq
IEBHUElPX1JFR01BUF9HRVRfRElSX09QOiBNYXNrIGZvciByZWFkaW5nIEdQSU8gZGlyZWN0aW9u
IChpbnB1dC9vdXRwdXQpLg0KPj4gKyAqIEBHUElPX1JFR01BUF9TRVRfRElSX09QOiBNYXNrIGZv
ciBzZXR0aW5nIEdQSU8gZGlyZWN0aW9uIChpbnB1dC9vdXRwdXQpLg0KPj4gKyAqDQo+PiArICov
DQo=
