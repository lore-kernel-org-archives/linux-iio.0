Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010046.outbound.protection.outlook.com [40.93.198.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0578E42F71D;
	Fri, 24 Jul 2026 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784896242; cv=fail; b=Y7X1H2uHkzgPfduQw8s68qmAm7IKWymR4GPUzokDNzS92ilhv+62Go0pYsPncQqMRlucz5ixRYni7ujv0ejCI+yK8I1J6BPkuBB5UqOESDP9iQFdtK/t/vFtmDjkZtSoHw9fnFJhWjvhLQXn9ZprzxD5NgWsxRyx5AdnLJVmbEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784896242; c=relaxed/simple;
	bh=IqAnHq1ggeTC5AB4abJbDO/8G+p6QvssC8CleDOD8Rw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BT0s9vOASTxHm/s+ENDTw400UedaAcHiweftX260sAZyc3I2/hy+qzel56HL0pDPTRW0gwKxb7Lq1p/xcPgh1FQkMxy18++SXqHT+cc9dwyI+RS25gtkXcdBvc6b51ikXcANpZq/AXf24A+l73yl1DVuEiwenF76poGPxfVkO0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=61dZ8DFD; arc=fail smtp.client-ip=40.93.198.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="61dZ8DFD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4HpnCnAV9oMiXadr2KQJjepxznwOm30oaowQHo48edyaxwzIlz7KMOjLDoCid9pR3Gb+uEzaT4W4fllnfuSEtxiQTatNtwHGRpFHY/OJSjDqtC4/V7/gTWzgR+zEuTiPbzScYdmUX1kts9jqDdA4p6XDF+EUrIfHk9a8aGxg+XIE96n7+e1GPIMQC8ZHNdcFh1j0vaDF7aGwRvOAkiJrir7YYBTI0tps8ladWA13iVa+VAJNNHRyW9XCZBUxCqj+WxRaKTXUkcMZB47j0tYMakxTADp6ibeNjPcQigdUaswTU768CksqK7RTcKFPDQxAFJADiUUuqH61UcxxHltQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IqAnHq1ggeTC5AB4abJbDO/8G+p6QvssC8CleDOD8Rw=;
 b=Y3YtOxhrqVbXESFQg3Rn2cVDAPD8VNaAuy3QOE0O4SO/ehfuo7+y7c3qNZPfmXjSoumyWZDt/O3XOMbOv09jLSa3GdHM1q2k7J2oBk39e4zhdCJ8UdjJs+l0NmRLp6qZcCA9lQ5/m6s/+JQMlYCQK9oHKJvbStNG2gfHhxWUzgjkCCkJ6CIheGmfQq/VPJuO0uaRSuaAgrSaMPoyNsQCPNcF5Reh0v4A5ud5I0pBsXEY8ZrI4yWFSWVBc3yFHqi56CvPoNWbjEFze27s6du77RHF/v7TOIshFxRT+bO8YaWFpvexvFW108/lnje+ItOBbD04TxRDtcCVLNctZOplzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IqAnHq1ggeTC5AB4abJbDO/8G+p6QvssC8CleDOD8Rw=;
 b=61dZ8DFDHW8GspmA3Scd0NW0iAIyf/QaJM+AxuxVLiBwobxw7RI8D+IXztY5G05K5xT1mMEawpZdHbzyEBcTg36IrKTJ4+FdGxG8GYBdJO4MOjh3KgTrKtopfTsqG1UFlKo7mzcQpo80XB5Ye69cAsk+0m2r1I/y5r/MyYmMPwZKQ4vvxTQpvrcNvyztlxWcZrh7x6/yEK8RvLA0PurSwk3YGiprx4CEGb0j5EXg1rKuuG6dDJRPbJp9bVtCxXskiDhB4+JZpVCOUhk/ldV/sI+84fuqS7bPqNRMwVIgih9jJgrCK0CGiS1igDSiQGJMcsxZ95SLnxY4+qrRNANKrw==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by SJ5PPFEF71E136E.namprd11.prod.outlook.com (2603:10b6:a0f:fc02::85f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 12:30:31 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%3]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 12:30:31 +0000
From: <Ariana.Lazar@microchip.com>
To: <conor@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<jic23@kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: iio: dac: add support for MCP48FEB02 SPI
Thread-Topic: [PATCH 2/3] dt-bindings: iio: dac: add support for MCP48FEB02
 SPI
Thread-Index: AQHdGqk+S+5IJLdiNke9LBtZmvMfQLZ7ThwAgAFM/YA=
Date: Fri, 24 Jul 2026 12:30:31 +0000
Message-ID: <7e121a7afaaa5aa72e39a4a70de2b0edff796def.camel@microchip.com>
References: <20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com>
	 <20260723-mcp47feb02_refactor-v1-2-ee59e63672bc@microchip.com>
	 <20260723-festive-genetics-3645c8e0b318@spud>
In-Reply-To: <20260723-festive-genetics-3645c8e0b318@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|SJ5PPFEF71E136E:EE_
x-ms-office365-filtering-correlation-id: a6b2523f-568f-4eec-c242-08dee97f5a1b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|23010399003|22082099003|4143699003|11063799006|18002099003|38070700021|56012099006|10067099003;
x-microsoft-antispam-message-info:
 lW+t+ky+qX7LTghHRecfompGapRRxmNHDXLHJ1KYJyIZ59MHGcjWE5QCRi6gNzfiTVjn0Hsn1zF+DltPSCrPrQjaR4JVA6hzCOalOETKsScHqDg6mC7p7L8qj06XgIjYYoU2JOmI6PXfTwri/5W8QHiMjDOOJEXOPUiwulZZPxJvqobVZQTElhfllX8lXtCclXdCzXXQUNGuUPtNrLufuuT7wx+uh89AqNfGvlEO+uxk9Q/6ipts8lWJ6hs0EM2TkoUipicDbU4XCN02JPUGDs12+mZYyiNxvP/0n+6LbsSlLp0tpy5jefpOU56HzPN1rSwgknLCaEvKgWIrlqq3Q9zq7UvUALOvAGzGaqfjeZFSUkbtl+uwsNDAEgOvzXMhZuIGncBMH1X9zw1Rm9ox3+2zwAx9si7zFGgOArY4OA2GhKw8C0gW09dIZarcvB1OaCeP2pSSqw1fwPE1BS765xB/Yzk8RlmnYRnPKE5eBUB0B6bJu9Tthk/l1MB4QEYLfABE/4ZAEDJBTsGko5XwKbUVASESkrBiPMc9op7abiiK9863yEs3pOUij5Ephx80buJkeUKI2I/xwLBWaxg/se+fXsat+dAk8pu86A/k2XZhAETVl/q0Pc6kdk7u2JtdvgdCrfcqq71SoCE3MS3eRVyvhAakAY0xbmtnkweUZWi3MO34Bv11ND+YI/tkLXLFU6kso0rJas+TIurpgOSB+47lf/hMNPkPPT+0fFj1uNs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(23010399003)(22082099003)(4143699003)(11063799006)(18002099003)(38070700021)(56012099006)(10067099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R2tDZ3RRL1MrNUtlVkVMUldpVGNObk5CdGZYUlBtdUJnM2FaYTBxWHg3bTh4?=
 =?utf-8?B?eE5Zb1JMeVFzcWRnU0lYSE5nT01XQlduMDJwbkk2NnA0Vlg5RzYzVjdhTzg3?=
 =?utf-8?B?QndNalYzRDI4YWN3UXdxMWNPVXYyOFhCajhrRTFBL0FXUlQxM29SRkhuS2lZ?=
 =?utf-8?B?N2RIZU4xMXdHanBIcForamFLUW1XZmxLREMwOUNVRU1IRmNiVEVzMnhrYm9m?=
 =?utf-8?B?d3ZvNENaREZGbWF3eWtmblBpR1pqUGlMUEZhS05GdDZJcDg1c084bUNSdEk5?=
 =?utf-8?B?R2pHMkRQeFdDMEhjNHBHN2lIekFyaEN3WDJhZWl0dW5lSW9zdnptK0FXcllm?=
 =?utf-8?B?cXRqMnlyTm9NQ3RBY2lzWElXdVJpRlFuMk13b2N3THZJK01YU3RxVVBoVnEy?=
 =?utf-8?B?V3Y1Vm1iaXdoVGlYRU1JemJ5U1gxK3gxQVFPeEdoVWt2YjgxTGdXcUd2L0hi?=
 =?utf-8?B?ZFJhLzF4bGgydHBwQnhPUDlwNlJoWmpMTnpCRkxFejB2NkpRMGNMT29BQmNT?=
 =?utf-8?B?dklGMUozak42ZlJyTitFRnYxZVRiOGNkUE1Ka2tlRVd2NHc0UmhOL1hFbDdK?=
 =?utf-8?B?bzNUdEhwV09xN2F4bzNhUHU1YStrMm1qV0pySnBmVnE5UkIvbk1KNzdhUTZj?=
 =?utf-8?B?NUcyQy9ScllzRXlldUc0T09GUnhUak9zaDZ3T05FN1c5clBUVTlpMjVFOU9l?=
 =?utf-8?B?QnVOZDNLVzlra1BHanJjSTQzZGlwRjY3OEg0M1lNYWR1aFdwSjdyRmh3MEUw?=
 =?utf-8?B?UWVVbUwwUW8vbk9zSWNwamMrcXVSQi9SYlhTNTlvYVhnK0JSV2VjZnRkbkw3?=
 =?utf-8?B?VzJMUEdNSmoyWFdMWXZodlFOMnFVeUd0ZHR4NVNVeUo1WTh3TEIycEh6Unl1?=
 =?utf-8?B?VDNLYXJVQ3RRNTBzQU5qUGQrYXl6aGN4bmt1QTVtbkpuTy82bmVieHpmNE9L?=
 =?utf-8?B?MERxb3pJNFhLeFp0MFBZZXVteVFTbEQra1E3VGsyUjVJTWJIYTY2ZlNhcElM?=
 =?utf-8?B?Q1ZPWVhnZzVydHFubjR5R2NpSUJCcVdHcFRpVjJ4VGdVVlozWGJaanA2TFEw?=
 =?utf-8?B?ZWhIMkJtYm1vZWFKbzFtdmVqZ0xDR01CM05HTXkzQkNmNWd1ODBVMk4vYkhx?=
 =?utf-8?B?TjNHYTk2cldCQlNGMG5xSmRRMTVUb1R0SG1VSjNIQWdNUW9wc00ySkU5RmtD?=
 =?utf-8?B?dDduV1VpQzljSUFLK2VpTlhJNytuSFV5cGRHcmZ0WkJ0blFsSGRuejA3SUhk?=
 =?utf-8?B?ZFpGMGlMOXhSOEpIY1BtWElPelZuNHhMNXpiKy9GWUhleVczTEoyL1IyRmcz?=
 =?utf-8?B?NG4yNDNYR2xBOW5YeWRLWnVRZ29GWFFsaloyeTFNQVVCV0kvUXlJZzNFRGJo?=
 =?utf-8?B?M0YyRmQ2NGQ0d0J1SzdmYzQ5b0RDcHFYNVhCM2ZCYSt0UUtIN0diNjlCMVJG?=
 =?utf-8?B?VlRmQjlkSjcyS0FlTEk1M3l0Rk1KUzc4UlBiZXpSQ0N6WmVnQktPWHZQWS9P?=
 =?utf-8?B?YU44WEZPL2VGcDlxNWM0NVdHbnNSSi9BOUtWSGwvK204cWdzdC9PbEdORUxC?=
 =?utf-8?B?N1VFYzhNbXUwYXdEZ3I3bXNDdG50SndVSkRUQU9ia01NTFlubnVCby9XcEFr?=
 =?utf-8?B?Wm1uZExpRzZma2lOa2V2WjNESy9TbUNndThxTGMrYzZ6NVUyTDVBaWo2c2Fv?=
 =?utf-8?B?bWtWYytxbVFZcXdIOE5DUHpleFZranVHSVJ3TzZpeHUrMUpoRjlhNUgvNVZm?=
 =?utf-8?B?SDV5c2dlUWRVZWtRdXVLT2FteFdwWDdNM1lJeU5pQUE2YnpPYkNCZ0FkNUVy?=
 =?utf-8?B?ai9LODVIaVJaS2dseVRsQUk4djRKU0lzL0lad1cxQ2RsS0VMQ1F0ZzNVTTJM?=
 =?utf-8?B?TE1YTUhUaENDdlRxQ2dYSFRsZE13TnlQQjRLbmhRVkt3SDJrdUlORCtnVlFp?=
 =?utf-8?B?bS82WjZieGF1cXp3Z1FXUmprVzhFWU15VWFTSE5ERWlod3drTXM0dTBveHVG?=
 =?utf-8?B?R0gzcjJwRWo5RlNNdmdCVHJPU1h5dnM4Vm9aWjhnM3ZiZXVCSXdGM2xEN1lD?=
 =?utf-8?B?UHhib1VReXlwTUduWVpUNytDTjA3RVpEWktpVDc4RnJ0d1dSU0dWbW5aaDVi?=
 =?utf-8?B?Y3h0a25jNnNQS092ZkI2L21lODR3QXdqR0pKd0d3eXRsRERienFpNzR2ZFdk?=
 =?utf-8?B?dUhZcWE1aGxFZk9zLzdWVXhvbVMycDlTZDFoMlRpZmh3dHZBT1cyck10R1RE?=
 =?utf-8?B?cUM0eUdyUEl5OGQweHFtaVBNM2dpRzJObTVsS0tRRnptL1RUcSthaGplRUx5?=
 =?utf-8?B?ZmJhWVozckRvekdENjB2bjdJM3hBYnRRc3Fhd1RqQ2N3QWFiYkdQd29IQ1VE?=
 =?utf-8?Q?ElBuihd+tdXodtrQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <567161B7E1D4B942AF808768E385F9FC@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8251.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b2523f-568f-4eec-c242-08dee97f5a1b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2026 12:30:31.4853
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08zMzL28CBlaas8Pcola1d1OXSBoAuelohpFWZxFKW3wx2Uq87K+nLlyAYlT8sU2OyZPzqrl2wCxTHdgK/xmi20BQkO+SyA3kkHYgraXVv0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFEF71E136E

SGkgQ29ub3IsDQoNCj4gVGhpcyBpcyBhY3R1YWxseSBhIHYyLCByaWdodD8gVGhpcyB3YXMgc3Vi
bWl0dGVkIGJlZm9yZSB1c2luZyBhIGJpdA0KPiBvZiBhDQo+IGRpZmZlcmVudCBhcHByb2FjaCBJ
SVJDPw0KDQpUaGlzIGlzIHRoZSBmaXJzdCB2ZXJzaW9uIGNvbWJpbmluZyBib3RoIHRoZSByZWZh
Y3RvcmluZyBhbmQgdGhlIFNQSQ0Kc3VwcG9ydCBpbnRvIGEgc2luZ2xlIHNlcmllcy4gT3JpZ2lu
YWxseSBJIGhhdmUgc2VudCB0aGUgcmVmYWN0b3JpbmcNCnBhdGNoZXMgc2VwYXJhdGVseSBhbmQg
aW4gb3JkZXIgdG8gYXZvaWQgY29uZnVzaW9uIChjYW5ub3QgZG8gYSBkaWZmDQp3aXRoIG9sZCBw
YXRjaGVzKSBhbmQgdG8gYmUgdHJhY2tlZCBlYXNpbHkgSSBoYXZlIGRlY2lkZWQgdG8gbWFrZSB0
aGlzDQpzZXJpZXMgYXMgdmVyc2lvbiAxLg0KDQpJZiB5b3UgdGhpbmsgaXQgaXMgYSBnb29kIGlk
ZWEgdG8gbWFyayBpdCBhcyB2ZXJzaW9uIDIsIEkgY2FuIHJlc2VuZA0KdGhlIHNlcmllcyBhcyB2
ZXJzaW9uIDIgYW5kIHBvaW50IHRvIHRoZSBvbGQgcGF0Y2hlcyBhcyB2ZXJzaW9uIDEuDQoNCkJl
c3QgcmVnYXJkcywNCkFyaWFuYQ0KDQoNCg0K
