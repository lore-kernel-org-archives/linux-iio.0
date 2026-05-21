Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2132.outbound.protection.partner.outlook.cn [139.219.17.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC16828B4FD;
	Thu, 21 May 2026 08:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779353596; cv=fail; b=cGquz1AZWcKNeb27DoiI1M6vtF7HF+d6Vih5gvtBscM+rJHvrSMhRXFQRwD8Oo4ZfXAY0ye6Jv5CWTrHr2tfRQCiuiXEl07MBF7/+WLV+ps3raw5CKXdZIlCPs5lwvQ4xK8udasz12c88ktDoLqvUSusaw7l9umsJ5AAK9HxAtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779353596; c=relaxed/simple;
	bh=Fhwwfh9oA4C6WGkBCU+3ANCJ4Z3H+eXnppFYFO+jmGw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hkzs1stYPhxOTxQffh+51Hb0Ovg1FbHBVs9rApBS80DsDhVwEzjNFqSasRzOPKCKKEvMvf4ZNl1NZeQ3c0Nx92SEO1KEucwCFk7kfpBDKucMyjWs+pR4USdj76QyAJL/OEeLa8uOqAi8PpgTyPj0NaclcDrIRXpmxUqV2WFDSFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GGJTbzBtdhtgbeMu0358mWfj5M+Ge4htWKFtFLPJbkHVW+xTntiWF+jbp+WhaPGWE3UbPo9OJf40oZF/Sp51p97UtF1UjZwzrpPNXh2BZK0FaWurw9fETlhD6XwUxcbBl2NADLciDwagipprG60XXbTuUsvZMWxIve4Jzwtv0w0oRBwxxuzuL4z8wJBrH8cNBLSdiR+vz2CRPZ2ftQtn+Fjlp+8pN9bVUHz+9GB9k/P3L4T5vsWlJdSSuefihxQ2YGNhzxuV14vEejd4PRzatjjVAqg3ouLur9pqz5LBOa4hLcGLXJdGg8149yzuXo3YkJtmAbtYMF04Vr3r/SpJaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fhwwfh9oA4C6WGkBCU+3ANCJ4Z3H+eXnppFYFO+jmGw=;
 b=BYf4jw9TXrD3mH4ZMdlH0VhOVJ/5OJQSlDfgO0Nwac13XNL4qKjMlL2rTBkISiOCMboMaxNCk4+tumBW4YFAY/6OAII3IIkrlyMZ9XXzkiCWtIi6OaODX3frzsllz7iKZ7YNwe/EXJ5ZttHKkDsS0Iyr1aWPJTA5A0DGy3aoTbLfvQmd6TPre/BME4xY6S/vJZy3byjjgKDytff8gkvSj52Xb2JG+BaMkrHpMvYRYVlzJ9xfA4L97E9s9sMB7P8yRBZPpHlq3tZW0gVfBs1gc8c3RvUOh3UCtLUm+VhX/dzaXI40noNhCUJUYcAA2xDCdYKArguJBMpDb2yEvmlTBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1067.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 08:37:26 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::d8e2:3f39:6ae7:bdf2]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::d8e2:3f39:6ae7:bdf2%6])
 with mapi id 15.21.0048.016; Thu, 21 May 2026 08:37:26 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?utf-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Thread-Topic: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Thread-Index: AQHc5p77jQOM2JwohkK7qO7svRU7q7YW0a+AgAFaAzA=
Date: Thu, 21 May 2026 08:37:26 +0000
Message-ID:
 <NTZPR01MB0956253C288738D28DE10BB49F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
 <cee001b1-eca4-427d-8803-56eb620a698c@kernel.org>
In-Reply-To: <cee001b1-eca4-427d-8803-56eb620a698c@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1067:EE_
x-ms-office365-filtering-correlation-id: e95975ca-ac15-4887-3374-08deb7142fce
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|22082099003|56012099003|18002099003|4143699003|3023799007|38070700021;
x-microsoft-antispam-message-info:
 Umx+/kuqwGOarrsgqW5U/Q/wmdMooFmAuzIDZ/nafFGUYlgKSn2dhP2hOVR8iWc13AaVVp9QSK2dnGS8KaSBiXMYGFOy5LV5kElWntJ4+c0Od4KjzlkZCdL322l2jpUMr8RsWGIp8BHgLqoX7cM1d0zkfTQnGJrDdhJV0vywRwMvfG3eHg98vD/KhnZt4ksSpik/zZf1kktNYGcUbC/BUFy6Crt4XV3lAUcCS7Fp56J+eMJQAtpi48J4n0J8MZdeuN2C0dG3ksoKWMyiyegtJKVu7pjSVJllhWiBrwDp2NcpfyZmJ71WjdcABnU+Ci6cbJmIwNbIbAWH3ExEpym5L001eXz3yghGTPi6YcTu4F2zi5mG3fakSN6PJdEX/qg5FvYrMBtG0aISfJ8pz9ZIZqhPHGogY/9pj61BRbnw6wCsJUh0s33PD+FZu8GozKVTEmZExvf84Kx1ruCPx6FUb5FVrjSu04rXdivOpQ1tmRhmTyz9YDx67LEnxHOwEbjtqHDx/+OPBF1Npyc1FUl06xLZhj6H5TgaOGG0nWf/cYUYxXWykHHElDjSrI9aeQvV
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(22082099003)(56012099003)(18002099003)(4143699003)(3023799007)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TkE5d2ptQ2I1MUZENkEydEYrMjBVWDNtTktOQ1lhbC9WTVFqSWNDcWpKb3lF?=
 =?utf-8?B?bWkvc3I0SExEVjF5YnNJOHFIRlh4UklqUDNXL3ZMbzNZZGVuMUtHR3YvNlNL?=
 =?utf-8?B?R3ZxN3JRSXVKczRFZzRQcU9yMmFyWWphejZTb2tyM0N2TVROTU5jM2dCK0dk?=
 =?utf-8?B?U2E1a2pqV3hoVGxrODhiWm5RQ2F3R2VwblV3N0R6REErMFVuRnljbXlWd0lm?=
 =?utf-8?B?S3FRdFNPYndLWDdncVYrNFN4d1lPZU8rNlZnM0ZKbytVY1FWNGExT1N3SlZR?=
 =?utf-8?B?MkJVYnI3OVRIZlQ5VzJBcEw1d2JES3ZFdG8yWnNBTGRhVm1SZ0NObzF6Wldw?=
 =?utf-8?B?VmRzVU1FREt3SFN5elkweXpCU2R1d05ZMWdUcUVnendiZWVZNzdkeGV4VkxC?=
 =?utf-8?B?RnlRalZhbnBMM3MrRFRMSUtQSk9rdnlIVXhwRldVZ2grYWVJRk5zVysxTkJP?=
 =?utf-8?B?S0M3ejZ1L3RZSzVYRjcyaHBWOXY1RzIrZHVnTUxTeTIybGprYVpHcC9SVFJX?=
 =?utf-8?B?MFVka0JMYkhvZ3A2bmtSdTMzc3kyUTlHNXMxUVIwbzl5SjdOWWh1NzJKdTFX?=
 =?utf-8?B?dzBXKzVjVG5uYVlsNi9DMSt2K29jcENhdlJiY0FVT1FhTy95di9NaTdhUVFF?=
 =?utf-8?B?Z1Z2WVJaMmFiNE4wNy9zeURLUWdHcE5jWWhYcDVsV1hZZ0VBS241Y2hmZ2dj?=
 =?utf-8?B?WlRsQnBaZkV6R3hoL2c4S1JtV3Y3aVIxSG9IeTBxTVdEb2h4QVR5ZUJWUEJj?=
 =?utf-8?B?UEd5QTcyYXljVWdtd3VwU1VIeEhubng4aXN4VkZCUnlTa3lJczZpdWVTcFlG?=
 =?utf-8?B?bk9DcmdBOUg1UmlIMUVXM3JzWTlIQVhjaGNjVEM1UUVNSmdyQTRtZ05CeEVj?=
 =?utf-8?B?K09DWUhtREJlMFd5alRQMVRONjU2Z21pSnd4Y1BOWTgzMk1nRlU5dVZ1U29W?=
 =?utf-8?B?ZytHK2RGY1FIbHJYSlk0WWVnQWR4QU5JQmF1bjFOWmgrc0VUSkozS3YwQ1Vz?=
 =?utf-8?B?S0JRMml5SHgybWJtZnlaUlRSSS8zQjhaR3g0TWExM2d4dkg1UENtQnNBR2Rr?=
 =?utf-8?B?ZW5jT3hVR3I3Y21GN3RTY2JjNnV2ZFBNampGWkpQU1JIK2tjR3I1c2orK2p0?=
 =?utf-8?B?cmI2TU9oNG9qQlpLNElDR3ZKTWFQV21lR1lJL1ByNUJMTjV1UWtKYzR0V0Fm?=
 =?utf-8?B?bHRpYStMN0h5RXlINUFoNHV0T3JnNmZlWkxWTlh6Snh0bXdyNVg2L1FwV3Rp?=
 =?utf-8?B?eWZISkdTRnI4VkZ3U20yV1YwZnNWNEJhNjgxM09zWlBDQUh6Z0VNL0FDYlhl?=
 =?utf-8?B?dXJ4VlBVM05QNllWdzE0Qms0MzFCUXNKckhHKzJuVWJQem1peWU0b3RpTGdR?=
 =?utf-8?B?UlI1a1Yxb0JhYTdvb2psVmljRk5HWFBsZnZ0dFlBTmR3YWxkN2RZbHArVlVB?=
 =?utf-8?B?NjRSUHRtSDBHWVdjVERUOVd1Nm9nTE1tbXg2S1VUTmVXN283WjBYdHFWSUNK?=
 =?utf-8?B?QnVSWE1UWGRFVWRjaU1ObFEvN0ZKbkFseUtYajBNT2prZ1F4QU53YnhCN1BO?=
 =?utf-8?B?V1NBWmptYW02Y1VrMXJoMmtoeUJSUjlkMm9yanoxbzJDeFdQSGtPRCthSktF?=
 =?utf-8?B?SGxEQUFoNlovbkhXMFpFUHVXVG9yMW1nQWRwcHVEN0FpczlVRzVIUHNyejlT?=
 =?utf-8?B?OWVzWFBNaHIwSjdZYmNuR1c1eDJRSXdOUmZQU1BlWEZNMkJrSXRtZUVlRytx?=
 =?utf-8?B?M0NtSkRtbEdTS1JLWmMrS2V2cXdrR0tiVkFjQmZGYzYvRFNicXBTQnpFMjRl?=
 =?utf-8?B?eVNySkpXV0RVVHlGY3dyK0ZSUkFob3RiYmE2NUhGZTB3cnpLSTI2c1V6MmZN?=
 =?utf-8?B?djh5K2RVeEpxR2I0NlJTdFVCSkYzVmlFTDRpbmJxZHdWTXJPc0FWZVpWVTdw?=
 =?utf-8?B?WnQzelgwZzVhdkxweDlIZlIra09Kb1Q5bHhnSU5YWHd4VTJDMjV6aGtWdDRQ?=
 =?utf-8?B?VDB1OGVIcFpUQ1RvYUh0WnBySkJjckJkV0lHZTI4cHkrUTA3aWM5Tkhudngx?=
 =?utf-8?B?WmI3MEhWeVZSQ1ovNkdQN21iS3l5WWd5RjR1ZTZJOElESGN5enVDS0VFeEln?=
 =?utf-8?B?dFduR0lQQ28xWGVHVHlESWt1SnBIVjB0SVVNYjNUSzY0bVpoZUhVZjViSUNn?=
 =?utf-8?B?NzEvK0w4dmlNazhVNS9WTFdOT0ZqVWs5L0hBaVpWalBhdkhVZmttcnIxK2l1?=
 =?utf-8?B?andaSjNoQVVCQy9SbkdCMXpkNjYvUjlTNTJ4emVJV2p2WTF1RHIzSDQ3VjJI?=
 =?utf-8?B?ei94R2ZYVXVWZ2t5aE9UbExibHhFN1dzVXR6Tk1oN2d2Sy90SHNYQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: e95975ca-ac15-4887-3374-08deb7142fce
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 08:37:26.1970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AGMzCaZSs6m+tG+/LwQTJ2ujy4xzw1DWsfXKqob1Xn4c9tikrE2L/sw3pQDlw6UVHu0Ad8oX1X8BFlmHMQqb1KTsWa+LGgsf2eq4O2yduPw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1067

T24gMjAyNi81LzIwIDE5OjU1LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPiANCj4gT24g
MTgvMDUvMjAyNiAxMDoxOCwgWGluZ3l1IFd1IHdyb3RlOg0KPiA+IEFkZCB0aGUgbmV3IGRvY3Vt
ZW50YXRpb24gb2YgU0FSLUFEQyBmb3IgdGhlIFN0YXJGaXZlIEpIQjEwMCBTb0MuDQo+ID4NCj4g
PiBTaWduZWQtb2ZmLWJ5OiBYaW5neXUgV3UgPHhpbmd5dS53dUBzdGFyZml2ZXRlY2guY29tPg0K
PiANCj4gUGxlYXNlIHVzZSBzdWJqZWN0IHByZWZpeGVzIG1hdGNoaW5nIHRoZSBzdWJzeXN0ZW0u
IFlvdSBjYW4gZ2V0IHRoZW0gZm9yIGV4YW1wbGUNCj4gd2l0aCBgZ2l0IGxvZyAtLW9uZWxpbmUg
LS0gRElSRUNUT1JZX09SX0ZJTEVgIG9uIHRoZSBkaXJlY3RvcnkgeW91ciBwYXRjaCBpcw0KPiB0
b3VjaGluZy4gRm9yIGJpbmRpbmdzLCB0aGUgcHJlZmVycmVkIHN1YmplY3RzIGFyZSBleHBsYWlu
ZWQgaGVyZToNCj4gaHR0cHM6Ly93d3cua2VybmVsLm9yZy9kb2MvaHRtbC9sYXRlc3QvZGV2aWNl
dHJlZS9iaW5kaW5ncy9zdWJtaXR0aW5nLQ0KPiBwYXRjaGVzLmh0bWwjaS1mb3ItcGF0Y2gtc3Vi
bWl0dGVycw0KDQpOb3RlZC4NCg0KPiANCj4gPiAtLS0NCj4gPiAgLi4uL2lpby9hZGMvc3RhcmZp
dmUsamhiMTAwLXNhcmFkYy55YW1sICAgICAgIHwgNjIgKysrKysrKysrKysrKysrKysrKw0KPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9zdGFyZml2
ZSxqaGIxMDAtc2FyYWRjLnlhbWwNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL3N0YXJmaXZlLGpoYjEwMC1zYXJhZGMu
eWFtDQo+ID4gbA0KPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9h
ZGMvc3RhcmZpdmUsamhiMTAwLXNhcmFkYy55YW0NCj4gPiBsDQo+ID4gbmV3IGZpbGUgbW9kZSAx
MDA2NDQNCj4gPiBpbmRleCAwMDAwMDAwMDAwMDAuLmJhOGUxOWI3MmFkNw0KPiA+IC0tLSAvZGV2
L251bGwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2Fk
Yy9zdGFyZml2ZSxqaGIxMDAtc2FyYWRjDQo+ID4gKysrIC55YW1sDQo+ID4gQEAgLTAsMCArMSw2
MiBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMCBPUiBCU0QtMi1D
bGF1c2UpICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOg0KPiA+ICtodHRwOi8vZGV2aWNl
dHJlZS5vcmcvc2NoZW1hcy9paW8vYWRjL3N0YXJmaXZlLGpoYjEwMC1zYXJhZGMueWFtbCMNCj4g
PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwj
DQo+ID4gKw0KPiA+ICt0aXRsZTogU3VjY2Vzc2l2ZSBBcHByb3hpbWF0aW9uIFJlZ2lzdGVyIChT
QVIpIEEvRCBjb252ZXJ0ZXIgZm9yIHRoZQ0KPiA+ICtTdGFyRml2ZSBKSEIxMDAgU29DDQo+ID4g
Kw0KPiA+ICttYWludGFpbmVyczoNCj4gPiArICAtIFhpbmd5dSBXdSA8eGluZ3l1Lnd1QHN0YXJm
aXZldGVjaC5jb20+DQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6
DQo+ID4gKyAgICBjb25zdDogc3RhcmZpdmUsamhiMTAwLXNhcmFkYw0KPiA+ICsNCj4gPiArICBy
ZWc6DQo+ID4gKyAgICBtYXhJdGVtOiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4g
KyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBtYXhJdGVt
czogMQ0KPiA+ICsNCj4gPiArICByZXNldHM6DQo+ID4gKyAgICBtYXhJdGVtczogMg0KPiANCj4g
TmVlZCB0byBsaXN0IGl0ZW1zLiBTZWUgd3JpdGluZyBiaW5kaW5ncy4NCg0KV2lsbCBmaXguDQoN
Cj4gDQo+ID4gKw0KPiA+ICsgICIjaW8tY2hhbm5lbC1jZWxscyI6DQo+ID4gKyAgICBjb25zdDog
MQ0KPiA+ICsNCj4gPiArICB1cHBlci1ib3VuZC1tdjoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBU
aGUgdXBwZXIgYm91bmQgdm9sdGFnZSB2YWx1ZSBvZiB0aGUgbW9uaXRvci4NCj4gDQo+IFBsZWFz
ZSByZWFkIHdyaXRpbmcgYmluZGluZ3MgYWJvdXQgcHJvcGVyIG5hbWluZy4NCg0KTm90ZWQuDQoN
Cj4gDQo+IA0KPiA+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMv
dWludDE2DQo+ID4gKw0KPiA+ICsgIGxvd2VyLWJvdW5kLW12Og0KPiA+ICsgICAgZGVzY3JpcHRp
b246IFRoZSBsb3dlciBib3VuZCB2b2x0YWdlIHZhbHVlIG9mIHRoZSBtb25pdG9yLg0KPiA+ICsg
ICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5pdGlvbnMvdWludDE2DQo+ID4gKw0K
PiA+ICsgIHNjYW4tZnJlcToNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBOdW1iZXIgb2YgdGhlIHNj
YW4gY3ljbGUgaW50ZXJ2YWwuDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy91aW50MTYNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0
aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBpbnRlcnJ1cHRzDQo+ID4gKyAgLSBjbG9ja3MN
Cj4gPiArICAtIHJlc2V0cw0KPiA+ICsgIC0gIiNpby1jaGFubmVsLWNlbGxzIg0KPiA+ICsNCj4g
PiArYWRkaXRpb25hbFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+ICtleGFtcGxlczoNCj4g
PiArICAtIHwNCj4gPiArICAgIGFkY0AxMWJlMTQwMCB7DQo+ID4gKyAgICAgIGNvbXBhdGlibGUg
PSAic3RhcmZpdmUsamhiMTAwLXNhcmFkYyI7DQo+ID4gKyAgICAgIHJlZyA9IDwweDExYmUxNDAw
IDB4NDAwPjsNCj4gPiArICAgICAgaW50ZXJydXB0cyA9IDwxNzI+Ow0KPiA+ICsgICAgICBjbG9j
a3MgPSA8JnBlcjBjcmcgMTg+Ow0KPiA+ICsgICAgICByZXNldHMgPSA8JnBlcjBjcmcgMTE+LCA8
JnBlcjBjcmcgNDY+Ow0KPiA+ICsgICAgICAjaW8tY2hhbm5lbC1jZWxscyA9IDwxPjsNCj4gPiAr
ICAgICAgfTsNCj4gDQo+IE1lc3NlZCBpbmRlbnRhdGlvbi4NCg0KV2lsbCBmaXguDQoNCkJlc3Qg
cmVnYXJkcywNClhpbmd5dSBXdQ0K
