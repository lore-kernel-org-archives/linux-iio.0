Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010007.outbound.protection.outlook.com [52.101.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96543749F6;
	Thu,  3 Sep 2026 07:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788421776; cv=fail; b=RMeTDeF9X89LZKvJRbpmL2uf5ycSLGqBUmFgnpXVyVbmrI2InUbXeaIL9TLf4FtCcPnOt3a9k8KMn9lK6Kt+Kx20+OyisuNYEorx0L9vEGa7B1xuw2XafKm6q4iW1oH/hY/4BFeKIPclUUPWp4+k+JjKbm7Abz9wJ2AHTBBMRgI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788421776; c=relaxed/simple;
	bh=9sfESGbcaRCL0Dw5VA9LugJHGTSg56GP0ULbOdaFgGQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UdY9DcUxFK7SQkM2VKxv6kC6j2n5Mf3YXiKh6EvUHYL7sForLPtZjOelsEVaI2plFahg5oeUFHFOlygro05mQORLXAWMqFRkP3fGhgEjniK+RGxGMM7pUHNY0D/aHkA1xwDL/oTPH2FLGasIQuDCNiKiNNvO8Ev8eLjpF/HUEgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=i4QMZ8Io; arc=fail smtp.client-ip=52.101.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="i4QMZ8Io"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C0yrUD0tLMa/o4FHrJJ+ZUWkU3cwVZntbFyc8Il+3MXDamoRCUpKrSNWWZiwR+IFb72flE4UjDJDPj4wm5vyV6TNw8eVq3HUUjFy+6yMMrw89mo6ZKtZjFHgngmza78ldzPog0nCZDnhtAnJU7KGczObqBVv1ntudYolGXfgMMmvfLPYeccQ8VadnltzPcU/D/5b4GCPDgiPJJIKG0PFXFquBjF/6YZgp7n1IaHTTeOrpHpnYKqJPMETzf89MAm/fncioHjCW5keeK1mmYTg+T1Ivu88TmN2ITUYEef+GGuhvgLo61V8g37n9vYPuIsztIjoICB1T7OoqBn27AiGLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sfESGbcaRCL0Dw5VA9LugJHGTSg56GP0ULbOdaFgGQ=;
 b=p3d7wfwJQoGKuflPa65tpnl97KjxLdOxjaCXtJjwv8sArnb2zgFUejjWE58tmljDgP3EWOaKjTYGJ4Udgu5T5A5iGqlFjFKfmbMjckvYW+YjXD7fZhsNWn8IAD8VBKgfVCmy8K7Ax5EX36yNdLFGJ3rTfWykyjK3r2Wh5VP3IiLT/vvlg64KKBcJN3FW3jlIEBv3N5N8iExdm4Sj174ZF0CYnEfTvkGHEqPuumd790oruK4ThOdKNYh4DMRuYFMd84mJdxpzt8bNb+rtFiq2T+wtNMwav6GdCWEG+crRY545apT2yGlqU6tv1V3beuh8K83xT08RR2VdLsTSGFYFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sfESGbcaRCL0Dw5VA9LugJHGTSg56GP0ULbOdaFgGQ=;
 b=i4QMZ8IohexpcFVK9JR4Cg6EjCsUcgiyQbKZWH9krgG0/Pl0i4oeka1sSj3cBptTnlUmJjdTFj8u4mikTx10InZB4me+4oo98q3bfCEPc9gaVBbrNZG2fLaj0E0EO89+An7zs8aZ1JULa1XnatO1WOFff1zv4wV/BuQbi5lFscM=
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 (2603:1096:405:29b::10) by TYCPR01MB11885.jpnprd01.prod.outlook.com
 (2603:1096:400:3e0::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 07:49:30 +0000
Received: from TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4]) by TYRPR01MB15619.jpnprd01.prod.outlook.com
 ([fe80::a68f:5c9:9de8:4fa4%3]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 07:49:29 +0000
From: Cosmin-Gabriel Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: David Lechner <dlechner@baylibre.com>, =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
	"magnus.damm" <magnus.damm@gmail.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 5/9] iio: adc: rzt2h: implement DMA buffer support
Thread-Topic: [PATCH 5/9] iio: adc: rzt2h: implement DMA buffer support
Thread-Index: AQHdNv4XBAqgjHfJp0eoNLgyXFZjxra0OzyAgAbFe+A=
Date: Thu, 3 Sep 2026 07:49:29 +0000
Message-ID:
 <TYRPR01MB15619584AE0D8737B439D317185B62@TYRPR01MB15619.jpnprd01.prod.outlook.com>
References: <20260828145943.2077589-1-cosmin-gabriel.tanislav.xa@renesas.com>
 <20260828145943.2077589-6-cosmin-gabriel.tanislav.xa@renesas.com>
 <178796644341.2599003.10846523729399514118.b4-review@b4>
In-Reply-To: <178796644341.2599003.10846523729399514118.b4-review@b4>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYRPR01MB15619:EE_|TYCPR01MB11885:EE_
x-ms-office365-filtering-correlation-id: 596a6518-5adc-4524-9e9b-08df098fe263
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|23010399003|7416014|366016|38070700021|4143699003|10067099003|11063799006|18002099003|22082099003|56012099006;
x-microsoft-antispam-message-info:
 4Sb9PzQfNnVfqOuBZ0GzPYhnDYCn3MnPxOF4ckhVRXK1YuHUPwEJdUYhcAhANfLNoI2kH2VWpzYYxzv8xMW/Unq/bDLsMcI63YRbnxmd6hvWbG7xhygiQF2gfz4WNiRdoBf7ZaMmxt798GgLXhebZwUaaJkSOEeXM7NvOnGbzX4XgdtOF8gNODioMvzxy6WkDFo0BBggyy8IPfDkwDWEYmd+nQcWZ3u9up+9lHsLRRaBu1fheKSBePUbO4Xixd8ua+7VIWLYX+z8mqYuBUjDYqna4jrW9RhDguEEL4PJf7w9bgHxuxSsvXGJFFdBZODqvefs8nRVfwDhrlipNaBPSnqmn8aLIt4oQxdauLxk24mMreK5HumuPh+FrTj+7dd8640dsTmjl2Gnq46lslzoVyeYmyWH2pIHIWxQHeis0OnBvckaqMzuNRQTxgzAIpj7TiSZc/GnPDzfFC8RPJ+y9T9LmiyhG2LmCgor4KzTiuIY1chsWcXOk/EKpfC0dIHAcFsz8B3UcO304GISTm3qgPUnumOiV++FKYQ1k7jv+vjS+nQGueZWgiifugVftl2jqQGNZvAkE4lR9lb2Rietj9P5I7alsp8XhYPN+y8b9NzDj0lOPEKiPYNY8H2CxsBmrxqQ0dR7T05rUTbMPVpEZaPIvL5CGHfjivKmO05JGltvb13Xl98U8xqEhpC2TH3RMf0bXAIkyWW091GrdZwLqrMe63ohP3s05Cey9HmqyCQ=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYRPR01MB15619.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(366016)(38070700021)(4143699003)(10067099003)(11063799006)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZGlwYjcrU2I1WjN3WitTc0dLbUlIT3VFZWpDZzkyNEFlMnZrbEVxMHBKL2ZJ?=
 =?utf-8?B?ZG53dGZsZG53MnRrYWdrV0hEZjkzYWgra1RJUGFqQi81Z0NsVC9aVTNFSWJn?=
 =?utf-8?B?QS9NNzN6MXVIZWt5K1JFWWdtZWQwR2Y3NE9pd2tDZjlwWXlvdUg4MDJDYjFQ?=
 =?utf-8?B?UTUyWDJpMmF4ZktLK0dzcENXa3NISjhWR0NFT2ZFUTh5OUI0R0cza3BSaTlP?=
 =?utf-8?B?elJyZml2MWN5dHlKMkxwUG1VcTQ2ZGx1bWZtOElXNFNFQ3dQci8vbEdhY0ZO?=
 =?utf-8?B?MXI5OTNRb2VVcTYrU1lHMTlNNnZ4TTZmRlVCeHFlQW5lL1dhVTI1RTlyMW0z?=
 =?utf-8?B?S2llTGg2L3FQWEJxVk1kaXdOQ3lnSDZZVk1XTDd2aS9LZmVBM2t2WTdySDF0?=
 =?utf-8?B?L293SzJsSjhwNUhhbWtOekIwTzExVjB6alRuZ3JtcjFYQmVoQkpSQWZCd3I0?=
 =?utf-8?B?RjcvNmoxTTBCelRQWmN4bzhwYjlubXI5djVEdDlEcXJjMFI4c0dEbWt6djcy?=
 =?utf-8?B?SEJ5a1A5SHZWcUdYb2ZHcjlJdU13MzhVSnM1dVdLaEtaMllHM1J4MkplMWxa?=
 =?utf-8?B?aUs0elphT0szSFM2L1FDR3FpT3g0dmNRQytMdENoV1ZaTlVBdlFIeXplcC9W?=
 =?utf-8?B?OGlWdEUrOUxFcnpEY2c5c0tOOHd6ZDdFRS9qSTVIZ2FUNkFJKzVsbytaRSsz?=
 =?utf-8?B?Sm03Wm1uY2lMaGhjbFMrRk9Udkh4VC8wMWdXd2FrQWc2aWhZY2RzMG82c01x?=
 =?utf-8?B?STEvWExBQW1QNDhpcFNCaExSNGpjSmY3OHJndDF4enp2VkRXVy9sYXJCSHpy?=
 =?utf-8?B?UlFWVjBobFkrZGYwNi9TdXZQVGZxQkxxa0c2ZWM3UlltS0R2SW9yUXJ3TnN1?=
 =?utf-8?B?NStHU2dxQmdmM2FuRWUyWnk1citkTW1RdTc4UDROUEhNYjN3ZWFVWjl2ekEw?=
 =?utf-8?B?QVE1RzBCL2svT0dQSGN4QytYd3dpd1NiOGZmTVZ6YmJDNkF6bC8vUUFWV3hN?=
 =?utf-8?B?YTZKdmpPYlV0ZE5lcEtLTUxyQkV0R2NwOHhQTDNEMUJxbUdCcmJJM2FoNzF0?=
 =?utf-8?B?OHpLZFBDYVhpNmNtU2EvQXZaNy9yWkMwK3BYcng2bit6alh3TDZ5OVorbG5j?=
 =?utf-8?B?QlZUTjFhSE1tZXlSaE9SSVo2V0lqaCtZVHZLM2g4YjlHeXdKMU9jK04yUnRG?=
 =?utf-8?B?ZkdEK3BCN3pKN2VYL2hmaFdWOFphRWpyRVdGRUk1dkwrYjFITmRDeUp4MGcy?=
 =?utf-8?B?MG84TWxJYXlRdFdSWTMvaFR2UWRJUVJrZy9tMVNKS0M4MjRISkVaT0d3Y2xa?=
 =?utf-8?B?eW5FTytSdncyYVdEd3BjR1ZyazFOWnBPd2NnTDFaWGVjVXo5amVNL0djOElO?=
 =?utf-8?B?alhpOHM1UVZLdnE2YkpXWURwRlhORHBUYkxlVWhDZCt0bmd4OUMvUDJ5QU9m?=
 =?utf-8?B?VktRbmU3eWpqbXhYNWRRRjNOOExCOUJvMVlaYnk2QTNxZG92b0xqaG11SVlO?=
 =?utf-8?B?c1NnbHlTM3V5eVVvdUFIeGhpQjEzWUgxbWlOZlNSU2FFNjk3WjJ5dE5TWld4?=
 =?utf-8?B?M2xwUS9vVEdqVndqSEpmQ2syaktNR24rQU4rTXYrSXQ5MTU4NFFkWC9PWDJn?=
 =?utf-8?B?akNuUk5rSnBvNVR3ODZNeVBvMFVUVzlOTk96ZUM2SVhvdjNPR2VWSlRnQ1JC?=
 =?utf-8?B?ZGVHWkdNTElvbzhXRzRHd0cyOERvaHRBM0dSY0pVcWVEbDh6eEJmTFdDY3lW?=
 =?utf-8?B?cVpKdHgzOGFuQlBxWnhxRW1XaUxocGtxWXNyKzBFSS9lcCtHamlsRmYvRUVo?=
 =?utf-8?B?VE5sS212SFB2Zk1VVFhZTXR1TWJrQjFyUklqL1Mwa0IzYmNBMEsvcWc2Y1Uv?=
 =?utf-8?B?bk5tYnVzQ3BwRDYxanE3ZGIvc0c0a0Ivb3dkUGU4V0dCdzlEdnBPVTE0cFFR?=
 =?utf-8?B?QVU3WEhuOHNhN3htV0l1QlM3eHhVYnF5WURXeDJtd0RVMVY1Njh5NFE2Z3E5?=
 =?utf-8?B?anlOTkVWSHYxYi84UWtXNnc5cmtxalBKTmFYL1kwalYrbmRuL3VBRXBZTjdC?=
 =?utf-8?B?dDB4blZTeG5VTGV5ejluK0ZIakFXcHl4OVdhbk13M1lwaHJPVUNYQjhoOWZp?=
 =?utf-8?B?Vzdzb2hWanE2YkxKR1M0K1lGY0NHaytkZFh0L2IweDVIYVVpNHYzUzBrRXIy?=
 =?utf-8?B?NWJRcmdsRHJuM3c0L1JXU0tGNVhLT2JqcEYzNFh5T1pMZU10ZitUeUpRVUl1?=
 =?utf-8?B?UnIvNWJzU2lvcHhhUzdVdWpMZ3NRcktPSDZuaGs0Q1I1ZzZoU0orOXlWeDFh?=
 =?utf-8?B?dm81R2RxcjZGNndRWlBzWjdkM1hBRFhzczh3L29rRUkzdXZ6c3NuYS9GazRo?=
 =?utf-8?Q?q1VIJzZ+aVclWn9Qm5FJ1HO/dIwKc5t1myCQr?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYRPR01MB15619.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596a6518-5adc-4524-9e9b-08df098fe263
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 07:49:29.2871
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W+sEHlVyBcK6UQwI/XUD+Z7aS6ltlDmogqq/QgoFB4EeR0benIHJUxH7dWZ2hiY7O3yEGfs+3sCY7KJ1T/DSM/KWsuaH2qm7YawJihlq0Ok6Zg3jr95IU2eOrrcCaDzh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB11885

PiBGcm9tOiBKb25hdGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPg0KPiBTZW50OiBTYXR1
cmRheSwgQXVndXN0IDI5LCAyMDI2IDQ6MjEgQU0NCj4gDQo+ID4gSW1wbGVtZW50IGJ1ZmZlcmVk
IGNhcHR1cmUgdXNpbmcgYSBjeWNsaWMgRE1BIHRyYW5zZmVyIGludG8gYSBrZmlmbw0KPiA+IGJ1
ZmZlciB0byBzdXBwb3J0IGNvbnRpbnVvdXMgaGlnaC1yYXRlIHNhbXBsaW5nLg0KPiA+DQo+ID4g
T24gYnVmZmVyIGVuYWJsZSwgc3dpdGNoIHRoZSBBREMgdG8gY29udGludW91cyBjb252ZXJzaW9u
IG1vZGUgYW5kIHN0YXJ0DQo+ID4gYSBjeWNsaWMgRE1BIHRyYW5zZmVyIG92ZXIgdGhlIGFjdGl2
ZSBjaGFubmVscy4NCj4gPg0KPiA+IEJlY2F1c2UgdGhlIERNQSBjb250cm9sbGVyIGRvZXMgbm90
IHN1cHBvcnQgbmF0aXZlIHNjYXR0ZXItZ2F0aGVyLCBhbmQNCj4gPiBiZWNhdXNlIG9mIHRoZSBj
eWNsaWMgRE1BIHNldHVwLCB0cmFuc2ZlcnMgbXVzdCBiZSBkb25lIGluIHdpZHRocw0KPiA+IGNv
dmVyaW5nIGFsbCB0aGUgZW5hYmxlZCBjaGFubmVscy4NCj4gPg0KPiA+IFNpbmNlIERNQSB0cmFu
c2ZlciB3aWR0aCBtdXN0IGJlIGEgcG93ZXIgb2YgdHdvIGFuZCBhbGlnbmVkIHRvIGl0cyBzaXpl
LA0KPiA+IGNvdmVyIHRoZSBzbWFsbGVzdCBwb3dlci1vZi10d28tYWxpZ25lZCBncm91cCBvZiBj
aGFubmVsIHJlZ2lzdGVycw0KPiA+IHNwYW5uaW5nIHRoZSBlbmFibGVkIGNoYW5uZWxzLg0KPiA+
DQo+ID4gU3BsaXQgdGhlIGN5Y2xpYyBidWZmZXIgaW50byBmaXhlZC1zaXplIHBlcmlvZHMuIE9u
IGVhY2ggcGVyaW9kDQo+ID4gY29tcGxldGlvbiwgYnVtcCBhIHBlbmRpbmcgY291bnRlciBhbmQg
d2FrZSBhIGNvbnN1bWVyIGt0aHJlYWQgZnJvbSB0aGUNCj4gPiBETUEgY2FsbGJhY2suDQo+ID4N
Cj4gPiBGb3IgZXZlcnkgY29tcGxldGVkIHBlcmlvZCwgZ2F0aGVyIHRoZSBlbmFibGVkIGNoYW5u
ZWxzIG91dCBvZiB0aGUgRE1BDQo+ID4gbGF5b3V0IGludG8gdGhlIHNjYW4gbGF5b3V0IHRoZSBJ
SU8gY29yZSBleHBlY3RzIGFuZCBwdXNoIGVhY2ggc2Nhbg0KPiA+IHdpdGggaWlvX3B1c2hfdG9f
YnVmZmVycygpLg0KPiANCj4gQ291bGQgeW91IGluc3RlYWQgdXNlIHRoZSBhdmFpbGFibGVfc2Nh
bl9tYXNrcyBpbmZyYXN0cnVjdHVyZS4gIGJpdCBhbm5veWluZw0KPiB0byBzcGVjaWZ5IHRoZSBm
dWxsIGxpc3QgYnV0IGlzbid0IHRoYXQgbG9uZyBJIHRoaW5rIHdpdGggMTYgY2hhbm5lbHMNCj4g
DQo+IDE2IHggc2luZ2xlDQo+IDggeCBkb3VibGUsDQo+IDQgeCBxdWFkcw0KPiAyIHggb2N0ZWN0
DQo+IDEgeCBhbGwgb2YgdGhlbS4NCj4gDQo+IFRoZSB0aGUgSUlPIGRlbXV4IGluIChzaXRzIGJl
aGluZCB0aGUgcHVzaF90b19idWZmZXJzIHBhdGggaWYNCj4gd2UgaGF2ZSBhdmFpbGFibGVfc2Nh
bl9tYXNrcyBzZXQpIHdpbGwgdGhlbiBkZWFsIHdpdGggcmVwYWNraW5nDQo+IHRoZSBkYXRhIGlm
IG5lY2Vzc2FyeS4NCj4gDQoNCkhpIEpvbmF0aGFuLg0KDQpUaGVyZSBhcmUgYSBjb3VwbGUgcmVh
c29ucyB3aHkgSSBoYXZlbid0IHVzZWQgYXZhaWxhYmxlX3NjYW5fbWFza3MuDQoNCk91ciBsaW1p
dGF0aW9uIGlzIG9uIHRoZSBETUEgc2lkZS4gSXQgY2Fubm90IGRvIHNjYXR0ZXItZ2F0aGVyIGlu
IGENCnNpbmdsZSBkZXNjcmlwdG9yLCBhbmQgd2UgbmVlZCB0byBjb3B5IGFsbCB0aGUgY2hhbm5l
bHMgZm9yIGVhY2gNCmNvbXBsZXRpb24gSVJRLiBUaGlzIGlzIHdoeSB3ZSBoYXZlIHRvIGNvcHkg
YWxsIHRoZSBlbmFibGVkIGNoYW5uZWxzDQppbiBhIHNpbmdsZSBibG9jaywgYW5kIHRoZSBiYXNl
IGFkZHJlc3MgbmVlZHMgdG8gaGF2ZSB0aGUgc2FtZQ0KYWxpZ25tZW50IGFzIHRoZSBibG9jayBz
aXplLg0KDQpNeSBpbml0aWFsIG5haXZlIGltcGxlbWVudGF0aW9uIGNvcGllZCBhbGwgMTYgY2hh
bm5lbHMgKDMyIGJ5dGVzKSBhbGwNCnRoZSB0aW1lLCBidXQgYXQgdGhhdCBzaXplIHRoZSBETUFD
IHF1aWNrbHkgaGl0cyBhIHdhbGwgd2hlcmUgaXQgZG9lc24ndA0Kc2VydmljZSB0aGUgQURDJ3Mg
Y29tcGxldGlvbiBzaWduYWxzIGFueW1vcmUsIGF0IH4yMjBrIHJlcXVlc3RzIHBlcg0Kc2Vjb25k
Lg0KDQpPcHRpbWl6aW5nIHRoZSBETUEgd2luZG93IGFsbG93cyB1cyB0byBhdm9pZCBsb3Npbmcg
c2FtcGxlcyB3aGVuIHRoZQ0KZW5hYmxlZCBjaGFubmVscyBhcmUgZGVuc2VseSBwYWNrZWQuIEVu
YWJsaW5nIG9ubHkgY2hhbm5lbCAwIGFuZCAxNQ0Kc3RpbGwgaGl0cyB0aGUgRE1BQyBwZXJmb3Jt
YW5jZSB3YWxsIHRob3VnaCwgZm9yIGV4YW1wbGUuDQoNCklmIHdlIHdlcmUgdG8gdXNlIGF2YWls
YWJsZV9zY2FuX21hc2tzLCB0aGUgQURDIHdvdWxkIGhhdmUgdG8gZW5hYmxlIHRoZQ0KZXh0cmEg
Y2hhbm5lbHMgdG9vLCBzaW5jZSBpdCB3b3VsZCBoYXZlIG5vIGtub3dsZWRnZSBvZiB3aGV0aGVy
IGENCmNoYW5uZWwgaXMgZW5hYmxlZCBsZWdpdGltYXRlbHkgb3IgZm9yIGFsaWdubWVudCBwdXJw
b3Nlcy4gVGhlIEFEQyBzY2Fucw0KZWFjaCBjaGFubmVsIGl0ZXJhdGl2ZWx5LCBub3QgaW4gcGFy
YWxsZWwsIHNvIHNhbXBsaW5nIHJhdGUgd291bGQgYmUNCmFmZmVjdGVkIGJlY2F1c2Ugb2YgdGhl
IGV4dHJhIGVuYWJsZWQgY2hhbm5lbHMuIEJlc2lkZXMgdGhhdCwgdGhpcyB3b3VsZA0KYmUgdHJh
bnNwYXJlbnQgdG8gdGhlIHVzZXIsIGJ1dCBpdCB3b3VsZCByZXVzZSB0aGUgbGFzdCBzZXQgc2Ft
cGxpbmcNCmZyZXF1ZW5jeSB2YWx1ZXMsIHdoaWNoIGFmZmVjdCB0aGUgc2FtcGxpbmcgcmF0ZSB3
aXRob3V0IHRoZSB1c2VyIGV2ZW4NCmtub3dpbmcuDQoNCklmIHRoZXJlIGFyZSBhbnkgZXh0cmEg
ZW5hYmxlZCBjaGFubmVscywgaWlvX2RlbXV4KCkgd291bGQgaGF2ZSB0byBjb3B5DQphbGwgdGhl
IGRhdGEgYWdhaW4uIFdlIG5lZWQgdG8ga2VlcCBvdXIgb3duIGNvcHkgaW5zaWRlIHRoZSBkcml2
ZXIgdG8NCnVuc3dhcCB0aGUgQURDJ3MgMTYtYml0IGRhdGEgcmVnaXN0ZXJzIG91dCBvZiBlYWNo
IDMyLWJpdCB3b3JkLg0KDQpUaGUgYXZhaWxhYmxlX3NjYW5fbWFza3MgdGFibGUgd291bGQgaGF2
ZSB0byBiZSBjb21wdXRlZCBhdCBydW50aW1lDQpzaW5jZSBub3QgYWxsIGluc3RhbmNlcyBvZiB0
aGUgQURDIGhhdmUgMTYgY2hhbm5lbHMuIEFsc28gdGhlIHVzZSBvZg0KZGV2bV9paW9fYWRjX2Rl
dmljZV9hbGxvY19jaGFuaW5mb19zZSgpIG1lYW5zIHRoYXQgd2UgYWxsb3cgZ2FwcyBpbiB0aGUN
CmNoYW5uZWxzIHRoZW1zZWx2ZXMuIHNjYW5faW5kZXggaXMgc2V0IGluY3JlbWVudGFsbHkgYW55
d2F5LCBzbyBpdCBjYW4NCmdldCBvdXQgb2Ygc3luYyB3aXRoIHRoZSBjaGFubmVsIGluZGV4LCBh
bmQgdGhhdCB3b3VsZCBuZWVkIGV4dHJhDQpoYW5kbGluZyB3aGVuIGJ1aWxkaW5nIHRoZSB0YWJs
ZS4NCg0KTGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsgYW5kIHdoYXQgdGhlIGRpcmVjdGlvbiBz
aG91bGQgYmUuDQo=
