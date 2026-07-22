Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012042.outbound.protection.outlook.com [52.101.48.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DB416843;
	Wed, 22 Jul 2026 17:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739754; cv=fail; b=cumIzzX59iv2ai/1zgZvGfuAkStG8uFUsnFHjgUWkpGTRLy/l2G3IRTyNyTvhB6RxTGWjLaNAvYjfn0La5j90fAFO+MWEpwBUTGTPSgUyShz8T+ivVBauPC6YQfU0KhF6CP4FFXC4KmM44nfe6zPozR/WJqDBotqHT5AEcQ1tJY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739754; c=relaxed/simple;
	bh=0Fl41eoWSfiYNQFxlwoHqOnqQD1/QQT3kNQQv+BBaZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arDR6vHTUjWMmrJdkedBmdEjJUndZbRYKJ2SyK5qD1rY1bQmRb7PwEKwwBSOyH1AfqendLAa4mqjGNoc/E6OrQ5U8mftZ2jjpxakRQPvnsjqMsucOYHcsV6nyQTKHV7Gv0Z6AjERIcgYN8WD+Yn9cudYODfjTeUP8qNWOIwjz/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=W5egLu3Y; arc=fail smtp.client-ip=52.101.48.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="W5egLu3Y"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkVwuwWzsQudGu6In9EgqZyVwVgbh2xf9fJLLajete+WZmkuLC6Y6mV2IScgr+jIQg+OCcK8ZnPC1RPN7ZYW6uthme+sOUYSxJtrX93W5dXBVFjWD4D/eQyYkuk+RyQxLMMwVVBlbzdoqLXm+1pbSVyTDUFC8HYsLDxWHpKbwWmEQKz3ZQOcIYD2v5QcGnZtSVEYMWAfBa+chBJmg/vM8wUqEAS1qOwnGlDTGDVGiE+0pFkcSaugfa2e4ksBw5TELu5oBTri4jo3srI92PiYMT5V67zediNq/SpBvIZCbUtKjjUkoqt4UyPggrf/QEtQ3wZNUrf2wpUNbZNftVCfKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Fl41eoWSfiYNQFxlwoHqOnqQD1/QQT3kNQQv+BBaZ4=;
 b=fRzcDADkXwh4x99OSLLpvqtgl3XTWzpyB3FzGpusauvjuPVKGkM5CSNfOhKJ9aS2JieZhYsFrTqME18hWnvGSR9Bud1vWUITrw+LzNHCuTBH0AU5krpDauaewSJE1bHxSJo/G+NmckyOvRSancmSpVmAYMr01t7bvhOkyYdIxAO7iv0hjUkoiu/w0HLVpYXQ9YKhMcUcg5jSdUAOWza8L9fmcYNo9nnYOns0XcavL5LkC+P0oqqxgQHVjgV1KcoTYLqh6QqkMYyGxACoHJdhIVvasumz6EtznTqZZXkAb7+oeynjPwXK3q46H7JXVuPkHKFWr1QN5uvK6NiSB59xEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Fl41eoWSfiYNQFxlwoHqOnqQD1/QQT3kNQQv+BBaZ4=;
 b=W5egLu3YlyBuxTJhrJn63Rh7jvLDtuOrn+uCcsFR+PMmKcRjDJ1/g3S2fydbXJ1vnjwJ1BW4HMrDy/z1landOC8avjyVFRdKk6hLT3k80hgjMdQVbih42jvIP8XOhM9EDHjrVkSLCObVT53a+bMviWC/50IEBYjGoFncIu20/rBRjWN6v8hjym22z4KFuFYZj1YXtPBOd7O98z1S9fVdBMubsl/Wt1yzLS9zd0tdSL9BlbZHBZqCC9kD97CWRdpJE5ljb9J8PFQaJKMHYcFLhNod4rdQDj8iCEZ2tzKEHOu12dvaJL8fQ1NM3JVcEqU0LHwv9KZw4lpdIQsYvc4OUg==
Received: from DS0PR11MB7624.namprd11.prod.outlook.com (2603:10b6:8:141::6) by
 PH8PR11MB9832.namprd11.prod.outlook.com (2603:10b6:510:3c4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 17:02:29 +0000
Received: from DS0PR11MB7624.namprd11.prod.outlook.com
 ([fe80::33b1:3e53:2b94:9990]) by DS0PR11MB7624.namprd11.prod.outlook.com
 ([fe80::33b1:3e53:2b94:9990%7]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 17:02:29 +0000
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
Subject: Re: [PATCH v7 3/7] iio: adc: mcp3564: Add support for spi-device-addr
Thread-Topic: [PATCH v7 3/7] iio: adc: mcp3564: Add support for
 spi-device-addr
Thread-Index: AQHdGa9vZSBX56/xs0etMzmGWafakLZ5v4IAgAAE3wA=
Date: Wed, 22 Jul 2026 17:02:28 +0000
Message-ID: <3b5253f88b8363727dedee9481212e5be222bc9f.camel@microchip.com>
References: <20260722-ad5529r-driver-v7-0-7781cd74ad75@analog.com>
	 <20260722-ad5529r-driver-v7-3-7781cd74ad75@analog.com>
	 <20260722-violet-dayroom-f1ec88771772@spud>
In-Reply-To: <20260722-violet-dayroom-f1ec88771772@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7624:EE_|PH8PR11MB9832:EE_
x-ms-office365-filtering-correlation-id: 01953f54-3d4f-40e2-fcb2-08dee8130342
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|38070700021|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 EDM82NQ3deTDSb+YX1Tn6etZEN1RsjCXHa40n9ypaYrS02BQK/15/TvFzp08g685eY448JXx7G1VMpKfohc0uP6mxHHLRAgNiwLCIvJQnK1rZToVwhkwiDxBbudOSNgiZJJKPhLx4OZ00y17m5Kg3kRnj49C1haxOfgOogagPzDoBi15vk7MRkroev5aCCU1MKpA6rswZfnU/VZxDjy+h+FR3lQwf4C0bajisPhklA6EPP3LUxuHklv02HCPJGSEH8Un+h8pbr/1+snWEeP0qj5xN2D8bWB8QZ9awfS7FQEPnEQzFzzpEfNfa848wkVwWMAscEPJlLIuYL39N9khEMXAEwuJ99qngiaRDTIltGWo47AZDZlLo65x+e7uYNl9rcsIOvRCjoQgutuweVDrU2QZChJO7JzVzipvqX2wrR0DbZZck/3IeFpcbGG1DpmK8nEnLQ/U6TjW2ZM0D24rmFWRcVQwQg5+bogqFL6t4GyRkvRRdpqUVCCRBFNATLTGRK+zEPrG53c1ftCr1qg4/FrpKkKU9OBZzqkGhLpvowoRwjQcbpvtKoqLZGzq45P0XB0eF8+yNlSMk2/Oq3ltYybtXpzGQbfzn2U/Xxyhdt4CHiuMFOii2Kp0mpJwCj87cbnGR9PXQmXDWfFaM2x9npENtncJ6QKv3X81ircwsyZWdzZ1APS8UYXnOvQcatic2Wp8yrwwGujjn/Z7KNH5wA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7624.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(38070700021)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Vm9oUW9wN2NTQjZBTXRNaVl4MFB6V2VZOE9HZjJkSzBOMVZXRDk0cnBWKzdW?=
 =?utf-8?B?NUhUMjNoRi95NkI1bDNUY252blpaeVh2TzJXYWs0b3prN3IvYjdjd2JRRFpC?=
 =?utf-8?B?V3d6YnFONHd3aXczYjR4NkV1cFZVV0lhRG93VmRJTFEzbDR4bXNRaHd1QUk3?=
 =?utf-8?B?UC9tekRub3l2SEpzU1RHeVR2dVdxNEVuLzRGdkJRbkJBSnl0b3I0N2RDbEZ0?=
 =?utf-8?B?QmVEdEJxLzkveHhQb2hpYzFxVTBVcHJLYVh5TWxhRFJTWDZmV2hmWWV2WEdT?=
 =?utf-8?B?cWpTZUdNQ05iTWxRYlJ0WE01Ynl5QkxaYWpwdjJGTVRiZnVoWnZrTW85TlU0?=
 =?utf-8?B?NVpxZGpvZFFvYnZUWHpmd3l2TTdySzdkbXRXOHNPbVlNV2hjbWpCblp2S2l0?=
 =?utf-8?B?WXlGa3pCSmJvNm5tanRJbW5SV0hjRTBVc1dhQmNVcy93YmsxczBsalNDakpP?=
 =?utf-8?B?T2xyVGtud010ZThmeUpHa29HbFBUZG1OZkthRVJBWlA0VUxobXU0bFdRWk9K?=
 =?utf-8?B?YVBqL2J4ZXc0ekFFeU9IQmpwVU5YZkU4Y0h2UjVCcnFuTkplZDQ3MVFEa3gw?=
 =?utf-8?B?aFN5aXIyeGY1VUZ1UEZtZy9jdWpLOVNMNXl5R1ZkSXd3bHlITmhvaTl4a1pv?=
 =?utf-8?B?SlFKRGhoVFlYZ1hzaHZHanhjTU9vSTMzTFFkYnh1aXdZaWVOYmtsWWlHNWZF?=
 =?utf-8?B?SVdPclUrSTZOQTdreEpiZlJJZklORmZ1T3N1cmYyRGdMUXpmQkhwTzFiSEhl?=
 =?utf-8?B?ZzFyZGQvbzYxMmlUNVdSaWVndHlYMnhXTUhkb2tIR2lvMXI3ZG9nS2VKSmFu?=
 =?utf-8?B?ZisrMmhXMUIzWGd0YWtZZEVIeGY4QTVNbVZqd3FWY1paUjlNaGJjcUN1UjQ3?=
 =?utf-8?B?YmxhS2dWTGpFUVUwd0tPUDdZYVN6NXp5czdqQ0NQaTVIUFhoN25HaEhaRFpO?=
 =?utf-8?B?Z05OdEZGY0J2QVgycVJ4WWhna3YxN1kxTGRwcE9EdElyZk9zc1ZrYkQ3SmVJ?=
 =?utf-8?B?VkVubVFFbkpVOHlBYmUrZ21EbWxEaEVpNnVBbEY5TnNUMDRzdGcvSUgwSUx4?=
 =?utf-8?B?MXVUUWxYNXJTd0VhaTMxbVh2ZzJPVkV2WWtyMmwvRVVIWXhsdE9NNE5haDN5?=
 =?utf-8?B?c054VVFUQlVnS0tnWm1PdEUzdG9NUGs2UXl3R1VMNkFPTnRBSlVOdnhKdFVw?=
 =?utf-8?B?aTQyaXRyZU9iSHY1N3k4eDFOWDhWVzVPazZzVFBZYkVjRFAyQ3VNcXZxUzk1?=
 =?utf-8?B?YkJTV1ZDeVJEYmxhd203L29IU1hPV3oxdUJTY2xxWGhGVFl6cEIwSVcwd01F?=
 =?utf-8?B?d3k4MUZ2dWo0ME9PQWMxcHFLNjRJdTJ4ekdPWldNQ0FCb1VPc3F0aEw4Sklv?=
 =?utf-8?B?Y1V4c25lUXMwUE1GRUFIanZvSVFOK1k2TFNaZUpXRmM0ZlFQTUxZSlVsY1E4?=
 =?utf-8?B?MDZWS09RdlRJT1NxUWFuY3EyMlBpYjNWRWRoNHU5UHIxWUhBNHExOUtxUk1W?=
 =?utf-8?B?M2kybUlCaXRzYlRxaUFGWW9OMEZLNmpkYzFVMzlpR0c1dDI5KytxQ01XZ1gv?=
 =?utf-8?B?RG5XQ2hRdmdEVDczV09YaENEdGh2MlpzY1d0TFdxZk92Y3lZRFdWM0s1Skc2?=
 =?utf-8?B?UHl1VTJnWWJpREdnZUxBWVV0cDY5clMrZ3BRRWh6UHBqQzBOR2xZMnV6RDRW?=
 =?utf-8?B?U25STmgza0p6bkZDMjgwamkydTNGcWFVQzNKVW5OMHBaV2NJcVo2UTZrd0Zn?=
 =?utf-8?B?M1A3eUdxZFpDVFRKSnJXek1Cc2ZUdFpETUVnbDI2NWR6TkZVU2VBREF4KzdP?=
 =?utf-8?B?M3lwRkRXUlVwTnlMM0RjeHVBdGxxM0lWcmpWV2hrZDZCSVR5dXgydUtTS2lC?=
 =?utf-8?B?SGFzY05xZ3AwZ3RMMFU3clFmeWhCNWVubmtJNEpIcnZ0NVRFZFNNYk9XZVFG?=
 =?utf-8?B?b2ZVQ2F2dTh0eUQ5NlFsSHlqY28xWjhveDBpUWU3d3d4WFl5VS9YeDFROWRY?=
 =?utf-8?B?dWtSZHRHU0dPcW1CS21JQzZVa1Q2aTU5aHZOUEczTWxpVWpCS3ArT1MrMkFh?=
 =?utf-8?B?SjFNV3Brd3N0c0JnWE9HYTBZQ1RINXdzR3Vwc2NiNDFjMWQ5QTdwQ2o0cGhk?=
 =?utf-8?B?KzZzcW9KeW9CN085bzFCaTc1VXJsVmlIU0hMdnVFdXUxQUQybnhleEk4ZmNk?=
 =?utf-8?B?NFliTjdvb1dKa1BSVWlTQ3E1ZDh5cXhBdHZzTGVmRTVKZmNEZlEvY3dETEY0?=
 =?utf-8?B?cnJRWmxERE1zQnNBbDd5SGpsR3BJUS90cjRYbnZ5bytjYk5zd3dIdmdTVVZP?=
 =?utf-8?B?cXZJT0p5d0k2WVNPTFRaT3kwVUpKL1E0VEZKWmE3ZkI5M2lWcHRzby9veFNl?=
 =?utf-8?Q?KBWYkKJdTtguTTnc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C103F56BAC8BC14ABDBEE316068033A9@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 01953f54-3d4f-40e2-fcb2-08dee8130342
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2026 17:02:28.9496
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lMBIfaleh9cHxh9Xa5b3ruw5Wv3fMGY2+6B3rtjW9MTopUgT7qwW7b504qTtaofwJu/qbe9Ysk/WMFgj3z1o9gI3L95EXqsCpiXWWYPrm0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9832

T24gV2VkLCAyMDI2LTA3LTIyIGF0IDE3OjQ1ICswMTAwLCBDb25vciBEb29sZXkgd3JvdGU6DQo+
IE9uIFdlZCwgSnVsIDIyLCAyMDI2IGF0IDA5OjU0OjE1QU0gKzAyMDAsIEphbmFuaSBTdW5pbCB3
cm90ZToNCj4gPiBSZWFkIHRoZSBnZW5lcmljIHNwaS1kZXZpY2UtYWRkciBwcm9wZXJ0eSB3aGVu
IGRldGVybWluaW5nIHRoZQ0KPiA+IGhhcmR3YXJlDQo+ID4gZGV2aWNlIGFkZHJlc3MuIEZhbGwg
YmFjayB0byB0aGUgZGVwcmVjYXRlZCBtaWNyb2NoaXAsaHctZGV2aWNlLQ0KPiA+IGFkZHJlc3MN
Cj4gPiBwcm9wZXJ0eSB0byBwcmVzZXJ2ZSBjb21wYXRpYmlsaXR5IHdpdGggZXhpc3RpbmcgZGV2
aWNlIHRyZWVzLg0KPiA+IA0KPiA+IFRoZSBkZXZpY2UgYWRkcmVzcyByZW1haW5zIDEgd2hlbiBu
ZWl0aGVyIHByb3BlcnR5IGlzIHByZXNlbnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSmFu
YW5pIFN1bmlsIDxqYW5hbmkuc3VuaWxAYW5hbG9nLmNvbT4NCj4gPiAtLS0NCj4gPiDCoGRyaXZl
cnMvaWlvL2FkYy9tY3AzNTY0LmMgfCA0ICsrKy0NCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9paW8vYWRjL21jcDM1NjQuYyBiL2RyaXZlcnMvaWlvL2FkYy9tY3AzNTY0LmMNCj4gPiBpbmRl
eCAzNjY3NTU2MzgyOWUuLjcxZGViMDVlODc4ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lp
by9hZGMvbWNwMzU2NC5jDQo+ID4gKysrIGIvZHJpdmVycy9paW8vYWRjL21jcDM1NjQuYw0KPiA+
IEBAIC0xMTIyLDcgKzExMjIsOSBAQCBzdGF0aWMgaW50IG1jcDM1NjRfY29uZmlnKHN0cnVjdCBp
aW9fZGV2DQo+ID4gKmluZGlvX2RldiwgYm9vbCAqdXNlX2ludGVybmFsX3ZyZWZfYXR0DQo+ID4g
wqAJICogYWRkcmVzc2VzIGFyZSBhdmFpbGFibGUgd2hlbiBtdWx0aXBsZSBkZXZpY2VzIGFyZQ0K
PiA+IHByZXNlbnQgb24gdGhlIHNhbWUNCj4gPiDCoAkgKiBTUEkgYnVzIHdpdGggb25seSBvbmUg
Q2hpcCBTZWxlY3QgbGluZSBmb3IgYWxsIGRldmljZXMuDQo+ID4gwqAJICovDQo+ID4gLQlkZXZp
Y2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LCAibWljcm9jaGlwLGh3LWRldmljZS0NCj4gPiBhZGRy
ZXNzIiwgJnRtcCk7DQo+ID4gKwlyZXQgPSBkZXZpY2VfcHJvcGVydHlfcmVhZF91MzIoZGV2LCAi
c3BpLWRldmljZS1hZGRyIiwNCj4gPiAmdG1wKTsNCj4gPiArCWlmIChyZXQpDQo+ID4gKwkJZGV2
aWNlX3Byb3BlcnR5X3JlYWRfdTMyKGRldiwgIm1pY3JvY2hpcCxody0NCj4gPiBkZXZpY2UtYWRk
cmVzcyIsICZ0bXApOw0KPiANCj4gU2FtZSBvbiB0aGlzIG9uZSwgc2hvdWxkbid0IGl0IGNoZWNr
IHRoZSByZXR1cm4gdmFsdWUgc28gdGhhdCB0aGUNCj4gYmVsb3cNCj4gY2hlY2sgb2YgdGVtcCA+
IDMgZG9lc24ndCBqdXN0IHBhc3Mgd2l0aCB0aGUgZGVmYXVsdCB2YWx1ZSBvZiB0bXA/DQo+IA0K
DQpEZWZhdWx0IGhhcmR3YXJlIGFkZHJlc3MgaXMgMHgwMSwgdW5sZXNzIGEgc3BlY2lhbCBvcmRl
ciB3aXRoIGN1c3RvbQ0KaGFyZHdhcmUgYWRkcmVzcyBpcyBtYWRlLiBJIHRoaW5rIGlzIHNhZmUg
dG8gdHJ5IHRvIGNvbW11bmljYXRlIHdpdGgNCnRoZSBkZWZhdWx0IEhXIGFkZHJlc3MuDQoNCj4g
PiDCoA0KPiA+IMKgCWlmICh0bXAgPiAzKSB7DQo+ID4gwqAJCWRldl9lcnJfcHJvYmUoZGV2LCB0
bXAsDQo+ID4gDQo+ID4gLS0gDQo+ID4gMi40My4wDQo+ID4gDQo=
