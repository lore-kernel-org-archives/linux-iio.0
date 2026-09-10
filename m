Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012022.outbound.protection.outlook.com [52.101.53.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31C4A0F0B;
	Thu, 10 Sep 2026 14:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051928; cv=fail; b=rDjt5pjFnkBrfcPMOOYgHhTGA6DPu3Rwq4k2BHhSUZWWgUEFoJCCbsJvvCX3QatbS2ortPKQUrOdtKm0MUUVNUnc0eNw2l+wpm0Zhc41cU7lYri8I1urQyxRSYYJOcsZx6l2vuV6T/E/Un5mr5WkQMCTwhvjeiFXT48lAF0WCM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051928; c=relaxed/simple;
	bh=m3d32ZSsuAyuW137/pfSUeEPtta8oh2j5/82k+UpTQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hBzS58v3XqkKCIF59gJZHKvgmt2jn7kTk/+xInthtJtM/LBRUPIxp8Mra5jKggZVs0xRnW+EINNOFbsyyDTUPFZYykD1EPcaEyCpVMWwfo1OG9JWxDj2CCGhATsUxPjM0ctXy9foDaYa5NG5IvgXcuXqktofQ4zR+JLjjaCnvAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=IoX9PPJ2; arc=fail smtp.client-ip=52.101.53.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="IoX9PPJ2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKD5ZbOb7gi5bqbTTHx2d4K1fE8D4pebFGu9gEeNv1NwvTfsOnt6c3pdb4l59nkvw26VXAWhcYyA9KExfVzkvuF8USp/sCrLHTc/7AZOijBx5joEAqzCtmk6W11fvpi9NtsG8xwVncvDHWZTMiMub7Tns+ZgfjRieh/hugAbXxMqcqhQTmvlPcM2Aehr3K+yadGYTiDV4OqgCj5qEu9Z9BgswXTkHgH2QuqwJhvnA5SgqzRfBmscX/9r6vxnWsZD2I/IXEfuFsC3mU/H/AwCeptDsiu8jjAwjFIuFGxqvqgYn9KaMNJwnBIke9CgIp2HeYxF/cg3IkikvHjVWHEQHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m3d32ZSsuAyuW137/pfSUeEPtta8oh2j5/82k+UpTQE=;
 b=NKpS5w8gaxKIDiAoDJrj9UKbPrIGLGPVgnkmjAFknEko/MId2FO53/uqRiIO/dlBI8KxGLKtSBcdSlCZWNTd4Iy165kAdR5Kv+3uodMhF9dWYbmbVrsHPJ9vBq868I8c+UpOAvvB3xSSiCl8PzvGfKbj7EKg+XZMUG8EFMUjrP7K+aI77TDA7FWhS92b8ugqTVXJbXPxIKt2UqaJ9SLBB5NjaLSyEfEe9RrzYDQjUcXFZKH/wvP2AQD3A58sx8rX1n14Lb1PsoMLIFLHxr5uowyk7JqI7kXahkTXVhcR43d1RoF7J8cT+ocQRNGLjgZrxW5t1nqUAR7sehsj2A6LJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m3d32ZSsuAyuW137/pfSUeEPtta8oh2j5/82k+UpTQE=;
 b=IoX9PPJ2fXQKwh8MLSjqYf5ELyP0HoFLJXkoMB78NUbjx6bHiNB7Brni9T1WvUlt1Q3YGpAulVXmbMS8gS6jIha8YgXbSN2gaXaQUQvozIFIhXSbNexIe+NAf2xfCY7bNG/VXukk1akDeNOSIu2V4NqLB5BPNriWHWVcxd8nOwJ+iBgjeIMHUzAkLjTV+SY94wx+dEfoUjlHvx5EbDpTm8MDGV6eWRAyj2T37VzK86gYDQivFRvYYmBCr/QWNfy0V5f6mXcolZYtetTUFm0E0kMbBJ5lYyW+yDme093eONMZ1Gl+vd93yBGuAbAab/ZgETBXmCx9k0v+krZw5Zvc3Q==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by LV4PR11MB9514.namprd11.prod.outlook.com (2603:10b6:408:2e0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 14:52:03 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%3]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 14:52:02 +0000
From: <Ariana.Lazar@microchip.com>
To: <conor@kernel.org>
CC: <dlechner@baylibre.com>, <linux@roeck-us.net>,
	<linux-hwmon@vger.kernel.org>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<jic23@kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <conor+dt@kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: adc: add support for PAC1711
Thread-Topic: [PATCH v3 1/2] dt-bindings: iio: adc: add support for PAC1711
Thread-Index: AQHdQFYYYjqbfVQFs0qkp9cnsb/VObbHteyAgAAxKwA=
Date: Thu, 10 Sep 2026 14:52:02 +0000
Message-ID: <b706814686dedc5a640970ae83e5e845589f4163.camel@microchip.com>
References: <20260909-pac1711-v3-0-dff81003b82f@microchip.com>
	 <20260909-pac1711-v3-1-dff81003b82f@microchip.com>
	 <aqKauqCxYwo8_nxM@squawk>
In-Reply-To: <aqKauqCxYwo8_nxM@squawk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|LV4PR11MB9514:EE_
x-ms-office365-filtering-correlation-id: fb93c579-ddba-4d10-3296-08df0f4b1330
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|38070700021|6133799003|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
x-microsoft-antispam-message-info:
 YCssLPUnwewaDrLdvxMPbDbUKSATfB9bp8g4V/5qIvLhhYtYHlz/tBOeWPFFFKqSEwO5Iqm5apAfZhciavmgA4ntjjctxavxCCqEMaxGXYTDTo/XmxOYOVYxy4dqwRCEtFVDuFq+zGeQas7IGskADhAEujrAzEExjfrTHEhiBVHb+xL9qjs4885yRaTr3Dz2ob1c/vTg3GUeJk/KLABo8OO2/t1PbhFX5724hp4iJCl7tMHz3wtp7dKDYzwqlLue3TVe7bI0c8ncCo69dr4Dg0me0N+hr3BYoVYKvyG9fy+X46B17xjNf7X3ZjzCd35+HFTbhRc7Xf73YDlAa05EzU/tSw2A4KGt77uUD52CR1yJDGwKp/7pwZY/wXMcJ4tgQlIl0gm6XzpmU3Sgprc0jicf4ia5n/FneVNoc4XDqoQOh+Alccvqpx3THWa563qW/xdkH3UGIc3dv7Z4vjkBELWuG6z/w278LJrBztrN75KkTk9mh4u4RFDUZwzY8iKqpLG4AgSQSA7y7IPssGQzFrCMiBL23n/U0P3821uodXxZeDysARqGS2bIfa3pior4qIR8gPwW42SIYniiXhN1l1MnYiiY45j4o9CNtRzf/JlufCFHu/9xOPIiSftkMEyw9hV5THWV2PK6v1D5auGBlvCCABTdY+crstWMJJgxm8RUQdVc5CL8uo6TgMpxtaapvYJGu1Qkt5039CJL+yHQniD0ADTnuOZoC5nLQI0sogU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(38070700021)(6133799003)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WSszOXpQYndHNXV3aTdoNVN4aFgxQkxTckxKdUNLN1BvZjZ3SFBYR1hXMndO?=
 =?utf-8?B?aEhaWGFmQnZta1pSVit2dXdPQTNzOGNPZ2gzRmZCMDVMUDVLQW1ReUo3cDJz?=
 =?utf-8?B?bVl4ZlVvYXJrdDV5NWo4MjVndzVFMEJITFdGQys4TDYvTkx2MUZ6dVU1L3Bo?=
 =?utf-8?B?Y2YzaTN1OEVkQytTd3FRTkM4SGk5ZzRnbHlLOXdGLzBKN0JkRnhMS01EWnR2?=
 =?utf-8?B?V2VwaU13eExOTGVzT2M3NHQrdmRQQnRVNFBndkFrNWRXVTZEbzVXb29TZXhy?=
 =?utf-8?B?U2lpdElJL0UvNnZNclpVYWhQMVltc0d1ZEUzRmc2clBLejRsWTNTeU5qM053?=
 =?utf-8?B?YWNoR3RIM3hYTGZrMzdaMnFoeSt2MW9aTnBxMXJyNXdQc3NYVVJaZmkyenhp?=
 =?utf-8?B?ZGswSDRjZmt4bVNqSEZSRlhnT3hkOC9FcEI0MjZwcVlDQ05PUGVyY2ZudU85?=
 =?utf-8?B?NTFmZmpFWGhuUm1XZmUvOTN6Qm1HcE9GSUlzajREbXZNQkx6WGFnVjBLTnl5?=
 =?utf-8?B?YmZIR2NVeXo2bmVpWkRPR3BNalZrM2llVXF5dlhyeWVBR0NUQTk1WDJJUWRy?=
 =?utf-8?B?QXZvRTErcmFnQU5IVEZEQ3dNRmcwcWdDVncyRGp4K0pVcDNrWmh5SUpVQ1NR?=
 =?utf-8?B?ZmpkQjFCZnRhRXBNM3FiRDdlQVloYndzc2hqa3dndzNZc1VlK0ZDL0RjekdC?=
 =?utf-8?B?a2J5aGlpM3NORWpwNXRtNytYK25DckJ4eXU0THN5NVpmTW9XaTU3U3h0SDk3?=
 =?utf-8?B?b1JsNHo3bWptQ3l6Y3h5TWxGWGhRNnJyWTh2MHExMkhaVGd1c1U1bGdPTE1J?=
 =?utf-8?B?bWVDNXBJQnB6bDd1QWdJeUlLVXdmbWpLeVRpakcra0xhQmFGalg0RjduMUcy?=
 =?utf-8?B?dTNwY0VyTWk5dGp4c0xpVmNzNndrTnBhOTBnRVIxbDhVTys2MWY3TkxURW56?=
 =?utf-8?B?NFhyY1BydVo4ejZHZUFJYVBQWGcyNmk4cmRnZXh6aGJMZ1JCbDVFTFhGMm8x?=
 =?utf-8?B?ckdLRHY4MVZBckc1bFU3cDhkVlJXandIai95VkxtcjhFYnRUeU40SUJ4TC93?=
 =?utf-8?B?STMxeXprby9GUllYV3FzeGl5N1dYVW0yTGpYbWNsZ2RlSFJxaVhJa3R1V05U?=
 =?utf-8?B?ZmNCMXhQbE1ZLzFwK0IxS1FpcGtUbU9KU2JsQW84UkFOOXA2UWtQMXZMZmlL?=
 =?utf-8?B?NlRSaGZwZnFvcEVSdWt5NXBZU2VZbm5QZ0dOaktvMEV5a3RTaHNKdmFsUHhl?=
 =?utf-8?B?RWcydHQ5dW4ya1Mrb1RnQ3hCdUtzaUlxT0RZNGY2WU5MeWdlK2hCaVpTRkdq?=
 =?utf-8?B?d1NnR2xROVJOblJCTDU3Si9zNXN6QkFTMHdOMGwxRjJEZlp4SEtHVVQyWlh1?=
 =?utf-8?B?OHlhdnFnYnZKRU9xWGVMUVdrOTZlbDdiOHVKN1VnZTlqRWFTTjN1eVdqaEhI?=
 =?utf-8?B?Q2Q4NVNyMWkxeitKalRDN0ZFbGhPWXdDK3pMNWZlR3pseDlHZXVYN2U2Nmll?=
 =?utf-8?B?NWNWOEZrbG5HMm1WbHMrV1BiT0plQUUvbHVrQVB2cHRUSlRQV0JWeXBpVWV6?=
 =?utf-8?B?dDE3RjRSZ0xic3hORmxBeE9vRHhEUWd4VnoxRGxsSFFCd2k3bTk4b2RFMlJo?=
 =?utf-8?B?ZGVFc1BvWndqaXIxVWZXa1dIanpaUzlheEl4Y3RQanpDZ21HY05CYVBSOVUy?=
 =?utf-8?B?c2p0NnRUY3BDMnk5K0M0TWd6b1l4OUN5WndUUTgvMmZ5SEZsWXVlQ3FpRmdr?=
 =?utf-8?B?dTU1ejB6dkMrME40SnB3YldNcWREWXdaazJqdzJ5Q2tBM28rSjU0NmpHbHd0?=
 =?utf-8?B?SXR0NEdYdHd3MXpOclBFWE9RaEpLVUVKWEtvV1M3eFNuSHBlWmpUUkhiMHMr?=
 =?utf-8?B?dE5uQlEvU2tpdzdjRTJrV2NidkVIOVorUVVkNHhGa2FXSU9sWkx6WjVLV3g5?=
 =?utf-8?B?eDFuUEo3Wm5zMk0rVVg1bWdVdzFQSUZDbkdueEtOT0J4YVBzcWJtNXlNdzEy?=
 =?utf-8?B?Zk5oZjFoc050YTFwUVRXOThBTVBsaTBTMWRrcUh6ZmFIN0VsYmlYSnBIRytS?=
 =?utf-8?B?c3BCeE5TNEEvamV1eFZrbGM2eG13cXU5WkpPUXUwVXFUQXZ6K0ZrVml3d1NG?=
 =?utf-8?B?TjNHaVhyQVk1c1ZxeUp0amtVbVd2bklTZ2wxaFBvTTRYYkV3WFdOZlhEbE14?=
 =?utf-8?B?RVkxUlJBNEpGN0NFQUh6R0dDYlgzM21aaFFjYURtZThqTWluRmZ2WnVwMGE4?=
 =?utf-8?B?QUMyTjlOMjVBeGE1VEJaY1U1emtUSUVINDJmTEM0TmJpSmxYazJPNEFSSUIx?=
 =?utf-8?B?UC9rS25jay9OemwrWE8waEc0N3hIV2lmNGZwVWRWemlNc2QvLzM1TDVMRURQ?=
 =?utf-8?Q?KhRs3vvWbi499F80=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E7F7774947CB2241B7304F233029610B@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fb93c579-ddba-4d10-3296-08df0f4b1330
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2026 14:52:02.8205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FA/DmbsBKG/TCLrb408SYTU/xsEGeJiWM9cuERtoKsbe8jiNfsP6f17KCmJMVdl/nCg91kdziGubmw8btJpHi38KhLBO0SyzMAelwXPFOYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV4PR11MB9514

SGkgQ29ub3IsDQoNCj4gPiArwqAgVGhlIGFjY3VtdWxhdGlvbi1zb3VyY2UgcHJvcGVydHkgYWlt
cyB0byBzcGVjaWZ5IHdoYXQga2luZCBvZg0KPiA+IGhhcmR3YXJlIGlzDQo+ID4gK8KgIGludGVu
ZGVkIHRvIGJlIHVzZWQvYXZhaWxhYmxlIGZvciB0aGUgdXNlci4gVGhlcmUgYXJlIHR3byBtYWlu
DQo+ID4gY2FzZXMgaGVyZToNCj4gPiArwqDCoMKgIC0gdGhlIHVzZXIgd2FudHMgdG8gbWVhc3Vy
ZSBhbHNvIHRoZSBjdXJyZW50L3Bvd2VyIGNvbnN1bWVkDQo+ID4gYmVmb3JlIHRoZQ0KPiA+ICvC
oMKgwqDCoMKgIGRyaXZlciBpbnNlcnRpb24gKGUuZy4gZnJvbSB0aGUgYm9vdCB0byB1c2VyIGNv
bnRyb2wpIGFuZCBpZg0KPiA+IHRoaXMgaXMgYQ0KPiA+ICvCoMKgwqDCoMKgIHJ1bnRpbWUgc2V0
dGluZywgdGhlIGhhcmR3YXJlIGFjY3VtdWxhdG9yIHdpbGwgYmUgcmVzZXQgYnkNCj4gPiB0aGUg
ZGVmYXVsdA0KPiA+ICvCoMKgwqDCoMKgIGNvbmZpZ3VyYXRpb24gdGhlIGRyaXZlciBzdGFydHMg
d2l0aC4NCj4gPiArwqDCoMKgIC0gdGhlIGRyaXZlciBkb2VzIG5vdCBrbm93IHdoYXQgdHlwZSBv
ZiBoYXJkd2FyZSBpdCdzIGRlYWxpbmcNCj4gPiB3aXRoLiBJbg0KPiA+ICvCoMKgwqDCoMKgIGNh
c2UgdGhlIHBhcnQgaXMgbW9uaXRvcmluZyB0aGUgY2hhcmdlL2Rpc2NoYXJnZSBjdXJyZW50IGl0
DQo+ID4gZG9lcyBub3QNCj4gPiArwqDCoMKgwqDCoCBtYWtlIHNlbnNlIGluIHVzZXItc3BhY2Ug
dG8gY2hhbmdlIHRoZSBhY2N1bXVsYXRvciB0bw0KPiA+IGNhbGN1bGF0ZSBlbmVyZ3kuDQo+ID4g
K8KgwqDCoMKgwqAgU2FtZSBpZiB0aGUgaGFyZHdhcmUgaXMgaW50ZW5kZWQgdG8gY2FsY3VsYXRl
IGVuZXJneSBpdCBkb2VzDQo+ID4gbm90IG1ha2UNCj4gPiArwqDCoMKgwqDCoCBzZW5zZSBpbiB1
c2VyLXNwYWNlIHRvIGNoYW5nZSB0byBDb3Vsb21iIGNvdW50ZXIuIENoYW5naW5nDQo+ID4gdGhl
IHNldHRpbmcNCj4gPiArwqDCoMKgwqDCoCBmcm9tIG9uZSBtb2RlIHRvIGFub3RoZXIgd2lsbCBy
ZXNldCB0aGUgaGFyZHdhcmUgYWNjdW11bGF0b3INCj4gPiBpbnNpZGUgdGhlDQo+ID4gK8KgwqDC
oMKgwqAgY2hpcC4NCj4gDQo+IFdoeSBpcyB0aGlzIGhlcmUsIHJhdGhlciB0aGFuIHdpdGggdGhl
IHByb3BlcnR5IGluIHF1ZXN0aW9uIG9yIHRoZQ0KPiBjb21taXQgbWVzc2FnZT8gQW55dGhpbmcg
anVzdGlmeWluZyB0aGUgcHJvcGVydHkgc2hvdWxkIGp1c3QgYmUgaW4NCj4gdGhlDQo+IGNvbW1p
dCBtZXNzYWdlLCB0aGlzIGRvYyBpcyB1c2VyIGZhY2luZyBhbmQganVzdCBzaG91bGQgZXhwbGFp
biB3aGVuDQo+IGFuZA0KPiB3aHkgdG8gdXNlIGl0Lg0KPiA+IA0KDQpUaGFua3MgZm9yIHRoZSBy
ZXZpZXcuIEkgcHV0IHRoZSBleHBsYW5hdGlvbiBpbiB0aGUgYmluZGluZyBkZXNjcmlwdGlvbg0K
YXMgc3VnZ2VzdGVkIGluIHRoZSBWMiByZXZpZXcgaGVyZToNCmh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnL2FsbC9hNzNhYjRlMy01MjBlLTQ1MTUtYWRhZi1lZDVlYzY0NGU1ZjZAYmF5bGlicmUuY29t
Lw0KDQpCdXQgaWYgaXQncyBiZXR0ZXIsIEkgd2lsbCBtb3ZlIGl0IGluIHRoZSBjb21taXQgbWVz
c2FnZSBpbnN0ZWFkIGluIFY0DQpvZiB0aGlzIHBhdGNoIHNlcmllcy4NCg0KQmVzdCByZWdhcmRz
LA0KQXJpYW5hDQoNCg0K
