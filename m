Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7292A43CE78;
	Wed, 22 Jul 2026 17:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740688; cv=fail; b=Sz5TFO1ll7jZH5YkreKphamHvKRQGEYoB6dQyhq5g2xMdG8vZrkWKsOd6aZD3RsP53ctUYWAd+2amjv1gBPkJLxuFk7pk8HdUiOGfa4GouMDnMahFgA5XIZ8Q/V3wKCPKIzIc/XyVsv28qN2J0MzBGppoYJdgSNjgtC+9D0mpyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740688; c=relaxed/simple;
	bh=rbhA2okcsT2lGDft2phvpzf/oQKEQBb045dqoohQGL8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=co9o1/qJ60qNgV/z99GL5tV2M6oTRRCNo7q3rrrrEa98qRzmwBp8aBo3kidIPjvDcV1YGv2KqxjylZi0pAv+xBgyuo2L7BoNJfaQPMjLLpcdIiZFSm5WG4VbmtkKYXqE9YC2B8p9tzwmVSRue6ctxrxtiT67TKXjVOeXZho406U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=U6wRoUu6; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="U6wRoUu6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/6paZ3NrTXHrVUQLEIjeDgwXHzlDHPv8fpmbOTWrw6gImw/1acj5KGhzoFurZRJjpCRmxtkJHltzhrNBiuS6eJjF04Tcrn7k8Y13l2WmQMbBDDQru6/KETD/vjahvnxC88EirfB/5u91UyT2nnLzuY4B59gxltoHiw6ZFVyJu2RsrucMlEpN1UjcfKEntpIHWWK+hb5yDNsVRe5IvA0CJf3YF4DOVDmKLUzIUim73mN1Kqaf4crppN0yOZivQvkyxbk0M7ObjGticr8GjlBpFUkKnvMnoZ0HVcmPa1+XsVnkyA6OhHxOSvhhNWwjOrfqo64jz8SW81WXuTZ33psEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rbhA2okcsT2lGDft2phvpzf/oQKEQBb045dqoohQGL8=;
 b=LI+bHmmdlQXTt3KksaqZk1gmcOj1cMPDTc/x7K5ZEh0x3kES4QGXoaz0Vh1u7X2L2l8ml0eA2OnTUcnF9a7ldlTrZ8Ppf+9cILqSlRCnBJYK33lLetBQkYBVQARRvvZ6GPaXeiRYu2MK6a1wXQ/9lzjDqy2Cb3toPlMLRqmAVVEd3IEzTYNyKv9WVf/04oVimnTQETtldtV6Q6wMPxIWEys0RSI2VkOl+yRU5pjq4xpq+T+y/xhCSDn1KGBD+ElfW08PO7mEq1BEiIZjckqIbh0MCLUCchg6hpqP5xUjnHLlX2HJeDbFzC7QIELExS+9ojcFWOjDGljE+K4cj1Sm9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rbhA2okcsT2lGDft2phvpzf/oQKEQBb045dqoohQGL8=;
 b=U6wRoUu6iTBIvYz8Q24m2+Y7ET7Q+VdubeYdu4L6HFQ3zhW92DKPksI6aTLSkg9My1TbQZZYUFlHsvcRHW3A6Ynl1/g9AWl6x3AXBHph+WViYH63pQmb0d87a6XI1FlNigH0zcjRrDir5pwhPsMxLCkzW5Z31KaOECK3PkZwGMv5ml8QWzBNtnPpZrX8hBxeY0O3ZlUmKaqGdp9UhY+Vzphr1X1PDRzF4QBFQ8UkMe9l6BfQBA/BHt5fd6OdxCEehic5J/gpsw9C6GOVM0xl21FnR3XWHntfuY16zTEX9x4Zzn7W9749OIwDZwXBVAk/OOUdrkcdCTjN4nHGaJ8NxQ==
Received: from DS0PR11MB7624.namprd11.prod.outlook.com (2603:10b6:8:141::6) by
 SJ0PR11MB6741.namprd11.prod.outlook.com (2603:10b6:a03:47a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:18:04 +0000
Received: from DS0PR11MB7624.namprd11.prod.outlook.com
 ([fe80::33b1:3e53:2b94:9990]) by DS0PR11MB7624.namprd11.prod.outlook.com
 ([fe80::33b1:3e53:2b94:9990%7]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:18:03 +0000
From: <Marius.Cristea@microchip.com>
To: <conor@kernel.org>, <janani.sunil@analog.com>
CC: <corbet@lwn.net>, <linux-doc@vger.kernel.org>, <robh@kernel.org>,
	<andy@kernel.org>, <nedo80@gmail.com>, <kent@minoris.se>,
	<Michael.Hennerich@analog.com>, <jan.sun97@gmail.com>, <lars@metafoo.de>,
	<conor+dt@kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<skhan@linuxfoundation.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<p.zabel@pengutronix.de>, <jic23@kernel.org>, <marcus.folkesson@gmail.com>,
	<krzk+dt@kernel.org>, <linux-iio@vger.kernel.org>, <broonie@kernel.org>
Subject: Re: [PATCH v7 5/7] iio: adc: mcp3911: Add support for spi-device-addr
Thread-Topic: [PATCH v7 5/7] iio: adc: mcp3911: Add support for
 spi-device-addr
Thread-Index: AQHdGa9ziGn+f+JRUUCCa6MbjsLkeLZ5vqIAgAAAcgCAAAmmAA==
Date: Wed, 22 Jul 2026 17:18:03 +0000
Message-ID: <4a20b00011ede38be75ae63db2cf9cf29dedf75e.camel@microchip.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
	 <20260722-ad5529r-driver-v7-5-7781cd74ad75@analog.com>
	 <20260722-quickly-drone-6a2a3b79249d@spud>
	 <20260722-vintage-handwork-eaaa304ed0b4@spud>
In-Reply-To: <20260722-vintage-handwork-eaaa304ed0b4@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7624:EE_|SJ0PR11MB6741:EE_
x-ms-office365-filtering-correlation-id: de4ff705-87a9-46aa-e9f4-08dee815308b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|7416014|10067099003|56012099006|4143699003|11063799006|18002099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 HRfUuOwfmHoAut7GruFLLDoYXsP4vKw54wKLq2x6prMzNZzRhY/iwjw2ZjOC4WoRu6W8huFUEwC2zO8RLoTOLeevzFWlKVqJnxlfp4b+uH4hH+jDmNp/Es50yf/h1W1aWGNR5v4N5xZf5CaqdZpnRpFdVJJ7u5NCMQFK38UnES/NKSnPHZ8fXdqizacmGBsN351i0Do+WOwY0Rxzmk9rCdIsukV9g2VOxJKRbx0J7AbAkGjm4VChWio57gS9NBnJc2w9/4Yg/pIe19bo22as2TgsXwNGAQQuxl1bNvFBY8vO4iLmx71FcZCaPitmBl5ovUGrCQ7go83PCyKVnSQN6hOfuPwlvzsNazzYE/1QL7BbBbraAoLaU+QvhdyQhGa3knXq+6WIQ6aT0AeuV6BlMAjddLi6dG5cZNRiXrl2zUu6I1adQGMtwOucDVTkQ4g37oI+n8kGIxB9FcUN9qyQD8fATCdWX+nq6jVVsfFpJ40ycVPb3vZMiLZ2LZl5rhG/zgnpGZtmCQN4V/NpXSI+Uqonb1nmxAu2pefFKBNw9qxuS4UzBqnmbP8LSJr5p29W2/4SG9TUcAM1vOsYFNYquoquYa8ZvNGAjwabADA32+CAwiqx/AkrHz8D45CM7soqkGUFS8rIUywLuYjhsCmgmqFUVNpzU43VPA/XCVGTWhU3PmSTmCkGPUBhTNtZR70oSEdQ1r323qH7e2KlkjZtyp8tJ/VhLB9Dl7mq5+Bsq+w=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(7416014)(10067099003)(56012099006)(4143699003)(11063799006)(18002099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eFVXOVhidFhSeVhkaTdhRWY2Mzg3Z29lRm1wNXNRcmZESTJpZytydVJBYmxY?=
 =?utf-8?B?N3JZMjMzbitoWG9JUUVMZmdJV3ZDSkFlQ2lhWE5od2Q5OWxxemhDdUhFZk96?=
 =?utf-8?B?bHEvWWVVcFhQaHp2Z2ZPc1h1STJSTC95WEdOUXRBSlFjTEh2NFVaQ1AxVDVJ?=
 =?utf-8?B?OHU0RENVSXQxclVDWWRiZFNlbXM4MEYzUlNlRFNZOHMvdy8rTmRETlZwSkNP?=
 =?utf-8?B?OTFaTnBVaG5QM3RPampvWUZlcmZ3aGE5RjMrc0d3ZGVuUXRFMTdTWlkvbFlO?=
 =?utf-8?B?YUxnOE5zanRzcnZTdFNyZEcyd0VEVlErYkNsdTFXaEFNY0xmZ2xoV2xaNTY5?=
 =?utf-8?B?RnNTdnIvUHhSTEtOalFpWmpHVDA0aEhWMG95c0VjY0wvcXloaXBnL3B5QXIr?=
 =?utf-8?B?SHIwUXBiRG5CSzA4VThnRkFZOStNMEtMMUNBSU9DQThRVnJlMlRvMmdRRFlo?=
 =?utf-8?B?bWd2RzhoYU9ENm9LejI2VE4vdm5KaHpMZGhPT0RlWTVkcGJvZjFpREJRT2dD?=
 =?utf-8?B?ZU5pbytVVDkyNWthNWxtZEVUVUlOZ0tiMGVER25LK3RJR3BCcGp1M1ErRWNm?=
 =?utf-8?B?Z3AvL1NTSTNzRGN3Vlc2ZFk3U3F6MGdIbmtMTlFaRGhOK0xRV2VHYm9VQVpo?=
 =?utf-8?B?aDVuVXhYZVIvSUx0STRybG9pc08rUXlJbzlENnRLWFlRemJxc1FtSGNnTDhB?=
 =?utf-8?B?UmFFbmp0T0pya28yM2VXQUhHM1FDYnpZbHRSMmxnbTdybVZDNzFTSHROS3NX?=
 =?utf-8?B?TXd2S1pidnpVT3NQOWR1ZEJJeExLZmtqaFVQTkRqMVY2QkUrZGxQOG84emUx?=
 =?utf-8?B?UlhNY0xFL3hhYzEwY2QySGlQa0E2U3dzUFUySEsxU1NHNWdjWmdDRC9OVnN1?=
 =?utf-8?B?cUZLdDNEQVFERUNsYU5VV0g3cjBmQzdhT1NOVjBiOW50cXJFMkowQWJRUnVF?=
 =?utf-8?B?UFMzalNROWlGZnRsbzlpUnJ4cHcrcFNBQXoxNUVBd0RTYWZOSDd3aEZwUVdy?=
 =?utf-8?B?SVRMVFdjQzFQeENEL2FvZis3Z2V6OXdObkVJQUl1Z0ZVZUx5YkdUdmZDY01K?=
 =?utf-8?B?VVltRHN6aHRYcDRTV1NXQUNudjNhMFdmYXR3WjBRSUhKcTJuRTFteWV3RHNj?=
 =?utf-8?B?Vmw3dXZlMnNZUStsTEUyWTlBV09QdE5tRXlNVFJWR2xaeExJbW5HSVNXQTBn?=
 =?utf-8?B?eU0vZXd4cFF5RHY4eVdUR3R4UVdiUWRBR2k0ZWV2N053ZmpleGM0a0pWN1k0?=
 =?utf-8?B?K2NyVjU2SGdETStaZnQzYksrWTBVQlBxRHZrZkwxOFFCb1ExVmh6QVp6dHZu?=
 =?utf-8?B?b1RqLzdFTko3dldUYkx5NVpabzZtWUV4UlhBS05OUnZnQnp6Q2VXSUJNNEFI?=
 =?utf-8?B?R0xSSWcvcEMwS0FTZ3lKNitOMGNZQkU2VWNDM2wvMG9UemhiQ0dTK3pBNTNq?=
 =?utf-8?B?SlErakpmZkIrdmt5d1grajl5Q3daeEVlN28xc29DL2YvK0YzMjZCc3YvVnBH?=
 =?utf-8?B?aGptWDZ1aHlici9ybWUzY0VLNW5jcTJ2M0tvUW5sQWdlenhJbFBidFFBWjFq?=
 =?utf-8?B?QWNURFE1KzhUQVJTSUxwYTY3MUNiaUxJVEw2Z2FPeVdWaEFwOVd6YmMwU3lY?=
 =?utf-8?B?QlNWdzFLMXoxbTV3T25SbmFBKzFWNTRLbkVjQ3VKalIxMHdtdVRIcHYrdG9Z?=
 =?utf-8?B?WEtLNStjc3gyZkQvU2o1RS9leWI0THRQZ0ErMmVINzFQWm92UDRyUTMxdTZp?=
 =?utf-8?B?YUVZZEtiaEhkUzgwTXpWdjFFZ3dRLzh3Ympra2JMSXRYcnh5cVpQVjZydE5Q?=
 =?utf-8?B?cWdBS2RRYmRxZmN5RHJqbTYzdnF6L3hlQ2Q2RnlkaTBNQWhTd0QwUkk2bTZn?=
 =?utf-8?B?ZWcwWmRpOGwxOHdIeURqV2pyanAvbUQ4cWtTNVdybG55b1BZWmpsbEJJU3p1?=
 =?utf-8?B?S09VcXk1bUVHZ21XbysxRCtsTHd6S1h2c1E2VDVRTHhPWjkyRC9TaktaZ3N1?=
 =?utf-8?B?MVBGTmhMbDQ4VUYrSE5nZWZXbHQyWkw4dk9XQ0YzdUQyYUxxRjUyb1FDNHhP?=
 =?utf-8?B?cWFpY091WWczQmw3WUNIaEJzcUZYNXFCVWU1Q2hEVGs5aDJlUWttUU93UHdo?=
 =?utf-8?B?bEk3bmNkK0N1K2VNUU42RlgzdER6ZWVuMzkzUCtVSi9hQ2hHSXFTYzhla01N?=
 =?utf-8?B?aHUzSWJFREdjUDdmUTRDbU9pZ2FHZkFFU3poN2t6dE5ob0V4d2l3RjlTRmJM?=
 =?utf-8?B?dENOU2N0S0FteGJ4WEZKUThKcHNjNDdCS1ZoWGhJSGp4ZWNXRFBUNTZlcXpu?=
 =?utf-8?B?RFI4QStEQ3Z0TDZ1Y3pyQWU1czlOalErQzFpc21DN1lIUnlFeDBWUkhwcHRY?=
 =?utf-8?Q?S4NSNIRNzceVYFC8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7C39E39DD9F75F46A30814414B671BFD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7624.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de4ff705-87a9-46aa-e9f4-08dee815308b
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 17:18:03.9342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7R6ApoyIDGF3IF7KecH1SQvbN1Zp1MREdkBmK6RaX3493HxeUT98wN83qLdgh3vnlOLYwMnPQkL5ku7ft0gTN9SM2NiLHRtk300M42W8uh8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6741

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDE3OjQzICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFdlZCwgSnVsIDIyLCAyMDI2IGF0IDA1OjQxOjU0UE0gKzAxMDAsIENvbm9yIERvb2xleSB3
cm90ZToNCj4gPiBPbiBXZWQsIEp1bCAyMiwgMjAyNiBhdCAwOTo1NDoxN0FNICswMjAwLCBKYW5h
bmkgU3VuaWwgd3JvdGU6DQo+ID4gPiBSZWFkIHRoZSBnZW5lcmljIHNwaS1kZXZpY2UtYWRkciBw
cm9wZXJ0eSB3aGVuIGRldGVybWluaW5nIHRoZQ0KPiA+ID4gaGFyZHdhcmUNCj4gPiA+IGRldmlj
ZSBhZGRyZXNzLiBGYWxsIGJhY2sgdG8gdGhlIGRlcHJlY2F0ZWQgbWljcm9jaGlwLGRldmljZS1h
ZGRyDQo+ID4gPiBwcm9wZXJ0eSBhbmQgdGhlbiB0byB0aGUgaGlzdG9yaWNhbCBkZXZpY2UtYWRk
ciBwcm9wZXJ0eSB0bw0KPiA+ID4gcHJlc2VydmUNCj4gPiA+IGNvbXBhdGliaWxpdHkgd2l0aCBl
eGlzdGluZyBkZXZpY2V0cmVlcy4NCj4gPiA+IA0KPiA+ID4gVGhlIGRldmljZSBhZGRyZXNzIHJl
bWFpbnMgMCB3aGVuIG5vbmUgb2YgdGhlIHByb3BlcnRpZXMgYXJlDQo+ID4gPiBwcmVzZW50Lg0K
PiA+ID4gDQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYW5hbmkgU3VuaWwgPGphbmFuaS5zdW5pbEBh
bmFsb2cuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiDCoGRyaXZlcnMvaWlvL2FkYy9tY3AzOTExLmMg
fCA5ICsrKysrKy0tLQ0KPiA+ID4gwqAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCAz
IGRlbGV0aW9ucygtKQ0KPiA+ID4gDQo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9paW8vYWRj
L21jcDM5MTEuYw0KPiA+ID4gYi9kcml2ZXJzL2lpby9hZGMvbWNwMzkxMS5jDQo+ID4gPiBpbmRl
eCBkZGMzNzIxZjNmNjguLjM5MTlhMzI2YjRkYiAxMDA2NDQNCj4gPiA+IC0tLSBhL2RyaXZlcnMv
aWlvL2FkYy9tY3AzOTExLmMNCj4gPiA+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9tY3AzOTExLmMN
Cj4gPiA+IEBAIC03NDAsMTAgKzc0MCwxMyBAQCBzdGF0aWMgaW50IG1jcDM5MTFfcHJvYmUoc3Ry
dWN0IHNwaV9kZXZpY2UNCj4gPiA+ICpzcGkpDQo+ID4gPiDCoAl9DQo+ID4gPiDCoA0KPiA+ID4g
wqAJLyoNCj4gPiA+IC0JICogRmFsbGJhY2sgdG8gImRldmljZS1hZGRyIiBkdWUgdG8gaGlzdG9y
aWNhbCBtaXNtYXRjaA0KPiA+ID4gYmV0d2Vlbg0KPiA+ID4gLQkgKiBkdC1iaW5kaW5ncyBhbmQg
aW1wbGVtZW50YXRpb24uDQo+ID4gPiArCSAqIEZhbGwgYmFjayB0byB0aGUgdmVuZG9yLXNwZWNp
ZmljIHByb3BlcnR5LCB0aGVuIHRvDQo+ID4gPiAiZGV2aWNlLWFkZHIiDQo+ID4gPiArCSAqIGR1
ZSB0byBhIGhpc3RvcmljYWwgbWlzbWF0Y2ggYmV0d2VlbiB0aGUgYmluZGluZyBhbmQNCj4gPiA+
IGltcGxlbWVudGF0aW9uLg0KPiA+IA0KPiA+IEpheXN1cywgYml0IG9mIGEgbWVzcyBoZXJlLg0K
PiA+IFJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2NoaXAuY29t
Pg0KPiA+IA0KPiA+ID4gwqAJICovDQo+ID4gPiAtCXJldCA9IGRldmljZV9wcm9wZXJ0eV9yZWFk
X3UzMihkZXYsICJtaWNyb2NoaXAsZGV2aWNlLQ0KPiA+ID4gYWRkciIsICZhZGMtPmRldl9hZGRy
KTsNCj4gPiA+ICsJcmV0ID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRldiwgInNwaS1kZXZp
Y2UtYWRkciIsDQo+ID4gPiAmYWRjLT5kZXZfYWRkcik7DQo+ID4gPiArCWlmIChyZXQpDQo+ID4g
PiArCQlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LA0KPiA+ID4gIm1pY3JvY2hp
cCxkZXZpY2UtYWRkciIsDQo+ID4gPiArCQkJCQnCoMKgwqDCoMKgwqAgJmFkYy0+ZGV2X2FkZHIp
Ow0KPiA+ID4gwqAJaWYgKHJldCkNCj4gPiA+IMKgCQlkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIo
ZGV2LCAiZGV2aWNlLWFkZHIiLA0KPiA+ID4gJmFkYy0+ZGV2X2FkZHIpOw0KPiANCj4gQWN0dWFs
bHksIHRoaXMgc2hvdWxkIGNoZWNrIHRoZSByZXR1cm4gdmFsdWUsIHJpZ2h0Pw0KDQpEZWZhdWx0
IGhhcmR3YXJlIGFkZHJlc3MgaXMgMHgwMCwgdW5sZXNzIGEgc3BlY2lhbCBvcmRlciB3aXRoIGN1
c3RvbQ0KaGFyZHdhcmUgYWRkcmVzcyBpcyBtYWRlLiBJIHRoaW5rIGlzIHNhZmUgdG8gdHJ5IHRv
IGNvbW11bmljYXRlIHdpdGgNCnRoZSBkZWZhdWx0IEhXIGFkZHJlc3MsIHJlZ2FyZGxlc3Mgb2Yg
dGhlIHJldHVybiB2YWx1ZS4NCg0KPiANCj4gPiA+IMKgCWlmIChhZGMtPmRldl9hZGRyID4gMykg
ew0KPiA+ID4gDQo+ID4gPiAtLSANCj4gPiA+IDIuNDMuMA0KPiA+ID4gDQo+IA0K
