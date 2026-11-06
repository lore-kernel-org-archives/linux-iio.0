Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.36
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793965570;
	b=cebqVVGTdk8rlqzWmkGfDeKkI0EZLJ+ll1uRyu8mPyrujfiuK8gjyuSagbbLhFQRjUCq
	 kXFOqQjzLdF6ONE9FIuf7eiSyWHI3KeQlfOy3LK3sP7FA7rCox4y4X7pnxpLewEoHNDOe
	 bAEHj0qCKvUcLVkrqEgy8sdEwDTEbAkWIM0bSrhLukzgP7pri/Ft3Uv7b7EYpahPtEDmw
	 olaX1hIL7wypqH1xujkByffjEEM532O16LSPVfyxTjJjeK3LHsVgtB/hY/iyc0QpTPE1j
	 WsTY+7A7nPCtr5/m2kRhHAE35OavqqViAUMum2jUVJe8rsCSX5DKZYsfrWHLGTkSz+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793965570;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:CC:Subject:
	 Thread-Topic:Thread-Index:Date:Message-ID:References:In-Reply-To:
	 Accept-Language:Content-Language:X-MS-Has-Attach:X-MS-TNEF-Correlator:
	 msip_labels:x-ms-publictraffictype:x-ms-traffictypediagnostic:
	 x-ms-office365-filtering-correlation-id:x-ms-exchange-senderadcheck:
	 x-ms-exchange-antispam-relay:x-microsoft-antispam:
	 x-microsoft-antispam-message-info:x-forefront-antispam-report:
	 x-ms-exchange-antispam-messagedata-chunkcount:
	 x-ms-exchange-antispam-messagedata-0:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-AuthAs:X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-originalarrivaltime:
	 X-MS-Exchange-CrossTenant-fromentityheader:
	 X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
	 X-MS-Exchange-CrossTenant-userprincipalname:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=nEYurTFuolknHD8QkNc6xQ1Tc9PoMCRI6kvBtjQHn/8=;
	b=VD8NUqH4taHTnXMrHe6hC/KzTNgRGFjstOD4MecwJdYh3bysOYBiJJKxK7SrihBMiI0p
	 o2+kmhJw6+f6F3/ER//xWAi5PUZhRP6/L6CUr+cdVqAfeY5QYcgF6zYp/z0gJ/kf5QFd8
	 80VSdStjxf1pLsqZldKXSlmNt52wYVzZtiBFPOEMPpK51lBHbaJn9gRaOUy6A2r8tbAxW
	 yK8ZPOCbRqs2lBXcYy2VDSCgTnyNqS5eNk57noJZDXLynTqOyz8U7yTqE1rmMPEMRwxbc
	 w3JIoNkyFZWfpI38cX3P/WtaAxI0zk8QrUIxYYsivGykYcZ2Kh6I1mS52x1rlREyFxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b="R/ntfE8M";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.195.36
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A38606A32E;
	Fri,  6 Nov 2026 11:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69A38606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=R/ntfE8M
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qmTFnfyYBEXh1JpVCpT1D7kJekBNeVTqeXa6j4lYVE5buSoAFPLCIMsqAnkHUvCMOztdtkQ2SHCYCRHIOEMUQnA5TdU0HdtkLp05PXegnTT08Q3pGsQ3TyW+Wsk1QWlBXEzr2/XEGc2sZ38GWdHosJLm6qb+Z2UKjUTwZ3x2bxlzz60KiAFko34mFhbxqju7zfVTKxUrowG1L0fLdrRxXffbO6h8owkAjUmtMsOfzARlAWwXAwHz/vS/RkLcb9yDb0L9iXgWLZK5shZq8uAH/R/h7tX48u4UsVG0auZcp70BnF7fzLB7+TAu8qw0QPYRateyZPISxPGgjtuSKEf6VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEYurTFuolknHD8QkNc6xQ1Tc9PoMCRI6kvBtjQHn/8=;
 b=lXpeKywuOFvV/u2oAUOtTUQFrv56DbQFeA0VQLrBSPNTmrjrRsRDuTXXmQYpk1ylruhH9J7FzJHXuc7+d/KQEvMisCMKh6dwk651h2dZegImpuQWPzvfHysJkCyix9HBGTukgIbfFXdr93ozntSAVt1d3oCasQJ9SdCvj5tJ6oiIl9EE+Ny4I05K59myo+xucuVsf77S/+TVGmi2ASqKDRDuwoOSacXJjx0TIOzjmkDORN0BUZfYeoa9wMKf4Y495+WtIfv03LjYjVwHJli88cz9sbYpydYyz4NtEcdkWLrqM1CJkEHTzgbAIMy3r+ZKyF+Yc6e98etQGvfnia3QzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEYurTFuolknHD8QkNc6xQ1Tc9PoMCRI6kvBtjQHn/8=;
 b=R/ntfE8MqlEtA5ecFM+ml2iB1q+kQVqZ5r1mmRyPN2uv0i4kiWKoqSwjUy3eV99wIC4GsEiarW4etbriK38YO0zqdWW3BF4YE/cZulMaOd6WchbIBdPNocZjS7Jg5TFB7zIlBhns2a+1U6WRVByC0OfnQa9tRDa8Kp07xiGG+ak=
Received: from DS7PR12MB9503.namprd12.prod.outlook.com (2603:10b6:8:251::15)
 by BL1PR12MB5730.namprd12.prod.outlook.com (2603:10b6:208:385::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 11:46:03 +0000
Received: from DS7PR12MB9503.namprd12.prod.outlook.com
 ([fe80::62c0:6aa0:897c:44d9]) by DS7PR12MB9503.namprd12.prod.outlook.com
 ([fe80::62c0:6aa0:897c:44d9%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 11:46:03 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: "Simek, Michal" <michal.simek@amd.com>, Jonathan Cameron
	<jic23@kernel.org>, "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>,
	David Lechner <dlechner@baylibre.com>, =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "amitrkcian2002@gmail.com"
	<amitrkcian2002@gmail.com>
Subject: RE: [PATCH 5/6] arm64: versal-net: Add SysMon and thermal zone
Thread-Topic: [PATCH 5/6] arm64: versal-net: Add SysMon and thermal zone
Thread-Index: AQHdasTRV2aYrJfrJEelsI81bXQz1bca3nKAgAYUFuA=
Date: Fri, 6 Nov 2026 11:46:03 +0000
Message-ID:
 <DS7PR12MB95033CBCB0077E855D762466DC762@DS7PR12MB9503.namprd12.prod.outlook.com>
References: <20261102122112.1723130-1-amit.kumar-mahapatra@amd.com>
 <20261102122112.1723130-6-amit.kumar-mahapatra@amd.com>
 <065bd297-efca-4a07-840e-ceefc881bd48@amd.com>
In-Reply-To: <065bd297-efca-4a07-840e-ceefc881bd48@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Enabled=True;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_SetDate=2026-11-06T11:43:26.0000000Z;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Name=AMD
 General
 v26;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_ContentBits=3;MSIP_Label_198e8dea-a4f3-4850-b16a-fd6d2b1302b4_Method=Standard
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB9503:EE_|BL1PR12MB5730:EE_
x-ms-office365-filtering-correlation-id: 819784be-782f-452b-3bd3-08df3bfb8926
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|7416014|376014|261102123227099003|261009223027099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261028144727099003|261026140227099003|261026121527099003|11063799006|56012099006|6133799003|4143699003|10067099003|22082099003|18002099003|921020|38070700021;
x-microsoft-antispam-message-info:
 dNayRjLZnPXKB06/L6HyYsMQEVIslu7SLrnBDNH6EwpqzTfTE3J40qu6cEad+WrasWlRI0UCawQ5jqw7GRKq9by5qkUSfyNla7kgbYqbC1wEk6K7kVTjvXMAN6OnKsRuXfDUUh5R4Hea7vfWXL92/bo2nvw6zNMqIBMtpB2G6wjILfNVMCIDl52mUu+9OMC8zwM0+C7WNgm0wAKViMXQ3cBtNj2zfT772nbeQpvFnEGwQelkFw9akfrKfR/SEQbmm4/he3+tV1+jOOUGGij9JnFsVyd2jyB/lzTP5Pjm2WUuy/7JIzMnq2YhZIC+s+NNCosKJOOpCHUHAidngsNodAiyWweQoYlKOG2rLjf66807SLjFRRoFJ/O64RgySUisUFkXgbWGiiPFElU7UP4UkRKTL6dLymqwwfPJCdyNGvWSQbJwkOhBByB0Zoo5/+xg7fEsjWjhDPzvWKvB5vYbKo6QDbJxYaPwd+fZQ0M5dMj0bvNp4F3TeiaxC11C4XM2PTrwWK4C5CTmYY1FFHcQuviHN2nGRgiat2IsbXJg4JJ5Rime49vJLcD78NbRsEnFrKeoUDcVWEWlLaJ5hbcVc9x1jBuV8mE8Nqih3saiBFHSVsXNObqmWHzfzJ3UodDDopIL1gWOkW3wZAw0OXEb3HrNX5DiKUk3bHkenigtyDQDK4lDa6VTdHgqJpQaC3YWqCaud5H5HQStI0elgxJNtaeAns6fQJ0TfR2DlvvUHsqUK12WDu+5oBo3Ja8EV+pl
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9503.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(7416014)(376014)(261102123227099003)(261009223027099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261028144727099003)(261026140227099003)(261026121527099003)(11063799006)(56012099006)(6133799003)(4143699003)(10067099003)(22082099003)(18002099003)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bXQxZW5lMkluNWl2UGVpSjd1NE9DRFBudysxclZOOEp0NWRqeHl0SDFKdGYw?=
 =?utf-8?B?dGs3Zm0yKzNiZ29VbUw3RU5XNTJlb0ZhaFZ0NHlmUjhzQ0xZVW1nVFNXSXBE?=
 =?utf-8?B?Q1hrKzM3WHp5cUY1REFSbmV0RjhpZUFZYjJiZTM3bmg1Y2t4QkZ2aXZaZTFE?=
 =?utf-8?B?VU5yQnJvbExxZ2tkRXVhallYSGV3ZExUcDByQXowczVSQXZqaWNtNE11Q1hJ?=
 =?utf-8?B?NEpOd2VrUFZjNHkyOWgzaW5wZHRaMTNuSjBNa1FUWVdoOS9mbFRnRHRDTW9G?=
 =?utf-8?B?alYycDlTZUhvajlQWXR6aEtzSlVlUTVxUXFqUmFwYVh4WHVYbGV1K2Q3czRM?=
 =?utf-8?B?OEI4S0JySXM2UmtWYlErcWV2blVtZFBmbUtzLzR6dS9MdGk0SlRyM0ZQZDRZ?=
 =?utf-8?B?RHpoU2cwR0hXOGt4eFV0VHZ3NTZmL0lsTVo2dVZhQ3RwYU5YcWluR2ZMSG9F?=
 =?utf-8?B?aEVyb3RXbDluYnZQK1Z5YVEweENraGVWOE5DUm0waldwOUljZXRzQk05WVQy?=
 =?utf-8?B?RkJaWXJEYnFRdWNsbHRoUlI0N0RwczNPVUJOVmw2MnFKNkl1MUlIQmJTWGxu?=
 =?utf-8?B?aVBMZG9FTGdJVWlXdVBab3crdU1nUmRKSFR0bUZEcm84djBHUUVOQWtqaUFu?=
 =?utf-8?B?OW5RQ2h2RU1lc1Q5cmIzamVyY2k1eEw5Q05OcUg0c0lYSHljemJZcEF5ZStG?=
 =?utf-8?B?Y2FxTGVXMkZBOE9TcGxKcUdUazFBOC9zeGlsOVF1dzNxem52L3VKdnpGckw3?=
 =?utf-8?B?cklwZWtMRWZnakRYUC9ldmlERURwZDFhYmhHWUJNTjQxMys3ZEdSUjhLWXYy?=
 =?utf-8?B?Q0txK1hnWFlRaGRzdUUrTkJUWmZSY2VsQ0N5WWNtZE04aCtWZXlvOGRtSG9i?=
 =?utf-8?B?SktkQmpWQnFlL1Z2YjQ0L3VvRFRPbEg3QzByblNmZGkrSVBobFBUMlRIWldo?=
 =?utf-8?B?Sk42d3BsM3JVbGRwb3p0dXJQQkVIRnFnOWhiV3NjREhNMmNDOGRpVXI4Rnhw?=
 =?utf-8?B?NGJmd0YwaCtnM0dPR2NrN3RYM0JhNmtpc2ZwNVFqUlZKWkZRVjV5QkdIaVFB?=
 =?utf-8?B?Q2w0VjkxQjNvTjNuL1YrTlYyRWowTFNvc3RVY25TNWM3V2tPS1NyUFRKR3d0?=
 =?utf-8?B?S3M5M2xKekZCZTkvbnNLdkpEYXlmaUFIVnJRVWFPSWhjY2I2MDdySWFsZFhP?=
 =?utf-8?B?dW1SSjdoV3E3RVhvM3NLQ01rUEgydkttUTVHYnVZblhjN21GcmRmZ1lSd2RT?=
 =?utf-8?B?TEZpTVRlakErWFVwczBOZTloWThrN2UzaFpOQkUvdlljaVEvVDN0OGtlTHdp?=
 =?utf-8?B?TmI0R3RVL2lPajVLdlBxWGtmR3ZtUFlaK2liVzFzZGYwTlRPbUNpRHBrTWxM?=
 =?utf-8?B?VFI5NzlFTHdHQUl2TG1mOXFZN1B4QXFHMFROcFAzME1yS2hGNit5N3B1Ump2?=
 =?utf-8?B?Y3FETlgzWm1YWGJ5WUhNNjZmb2JQYjBWYkEzdEhpWHpLOHMrTnF6OE40bE45?=
 =?utf-8?B?d0hkTElza2tqTndWTWIyaEd3ZEhnakF0VXBOYndMQXhvVTFCc0c2cUZWWi9q?=
 =?utf-8?B?Rkg1WlJPZUx2V0VPeXlmSUhjT3U2dXcxTytWUDVJU1BMZDRyNVVhNHRFRnIz?=
 =?utf-8?B?b0E5Q21vVm4zTzJuTTMwY09hNndpMTZvUlBQL0dsQTJYNDkvU2cvVlNudkpR?=
 =?utf-8?B?ZW1vSFJBU0hmMHh2dTNBeHhya2tBZ2hRL091RmsxSUc2Q0tYV05kYjdSUVNV?=
 =?utf-8?B?RFhoT3JuTy9OUWlHNXp6dEFON003NmlaRXlkYXhGWE9zUUxWZGlrOXZocm9l?=
 =?utf-8?B?eWdnZjkrWWxkdVU3UVh3VURFdzZlaTNsYXZmT1UwOG43RFFPNWg1ZTVRWXpi?=
 =?utf-8?B?THNwNk5sc0pUc3llNGVwTnZxRnovTWltMlhsQnBJb3lOYnF2RHpEaDVyRThB?=
 =?utf-8?B?cGwrUlhqLzgvUG5MeEZrSXZvdXRLNG5XN1czdkowYVlERWpZRTdiSmNtMkFq?=
 =?utf-8?B?VjJ3dFlQR2w2Wkx4WXJlWnRJWDJVMi9pYXJUYjhpL3RydjdnZTBIU3hZekZN?=
 =?utf-8?B?VEVLV01qUmYxTVVHZmpuZmFkM0QvSVFab29KMmlycTJnbTEzekF4cDVuQXYz?=
 =?utf-8?B?bjY4UnRKUW9JUmF0K2VlL01uVHByL09mWW4wd3RmYTlEMXFySzNrSi8rSTNV?=
 =?utf-8?B?Nk1TNXhRRFJUQzE3aG8zdjVMSVVFTHFMNURyRnRFRElwbVQwMm5FcE14dHhx?=
 =?utf-8?B?TEFLTVl2cEhPNHNYbDZVM3JuT2xjVnpPY2ZFbFpVakthTG02dnVrOWpDQ3hj?=
 =?utf-8?Q?AOlFSbyZq/ukSax12W?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9503.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 819784be-782f-452b-3bd3-08df3bfb8926
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Nov 2026 11:46:03.3609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bln7B5shBm4EPeSjo2Y/9vMNK2hJiyNZ3Hs7dgws+TcaTezaj99nhkOS5gtZj6hyTpfCSlWvI75OOiYtS9QxyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5730

QU1EIEdlbmVyYWwNCg0KSGVsbG8gTWljaGFsLA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFNpbWVrLCBNaWNoYWwgPG1pY2hhbC5zaW1la0BhbWQuY29tPg0KPiBTZW50
OiBNb25kYXksIE5vdmVtYmVyIDIsIDIwMjYgODoyNCBQTQ0KPiBUbzogTWFoYXBhdHJhLCBBbWl0
IEt1bWFyIDxhbWl0Lmt1bWFyLW1haGFwYXRyYUBhbWQuY29tPjsgSm9uYXRoYW4NCj4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz47IFBvdHRodXJpLCBTYWkgS3Jpc2huYQ0KPiA8c2FpLmtyaXNo
bmEucG90dGh1cmlAYW1kLmNvbT47IERhdmlkIExlY2huZXIgPGRsZWNobmVyQGJheWxpYnJlLmNv
bT47IE51bm8NCj4gU8OhIDxudW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5IFNoZXZjaGVua28gPGFu
ZHlAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nDQo+IDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0
b2YgS296bG93c2tpIDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkNCj4gPGNvbm9y
K2R0QGtlcm5lbC5vcmc+DQo+IENjOiBsaW51eC1paW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0
cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMuaW5mcmFkZWFk
Lm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gYW1pdHJrY2lhbjIwMDJAZ21h
aWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNS82XSBhcm02NDogdmVyc2FsLW5ldDogQWRk
IFN5c01vbiBhbmQgdGhlcm1hbCB6b25lDQo+DQo+DQo+DQo+IE9uIDExLzIvMjYgMTM6MjEsIEFt
aXQgS3VtYXIgTWFoYXBhdHJhIHdyb3RlOg0KPiA+IERlc2NyaWJlIHRoZSBTeXN0ZW0gTW9uaXRv
ciAoU3lzTW9uKSBibG9jayBpbiB0aGUgUE1DLCB3aGljaCBwcm92aWRlcw0KPiA+IG9uLWNoaXAg
dm9sdGFnZSBhbmQgdGVtcGVyYXR1cmUgbW9uaXRvcmluZywgYW5kIHVzZSBpdHMgZGV2aWNlDQo+
ID4gdGVtcGVyYXR1cmUgY2hhbm5lbCBhcyB0aGUgc2Vuc29yIGZvciBhIHRoZXJtYWwgem9uZS4N
Cj4gPg0KPiA+IFN5c01vbiBjaGFubmVsIDAgaXMgdGhlIGN1cnJlbnQgbWF4aW11bSB0ZW1wZXJh
dHVyZSBhY3Jvc3MgYWxsIGFjdGl2ZQ0KPiA+IHNhdGVsbGl0ZXMuDQo+ID4NCj4gPiBUaGUgdGhl
cm1hbCB6b25lIGhhcyBhIGNyaXRpY2FsIHRyaXAgYXQgMTI1Qy4gUGFzc2l2ZSB0cmlwcyBhbmQN
Cj4gPiBjb29saW5nIG1hcHMsIHZvbHRhZ2UgY2hhbm5lbHMgYW5kIHBlci1zYXRlbGxpdGUgdGVt
cGVyYXR1cmUgY2hhbm5lbHMNCj4gPiBkZXBlbmQgb24gdGhlIGRlc2lnbiBhbmQgYXJlIGxlZnQg
dG8gYm9hcmQgZmlsZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBBbWl0IEt1bWFyIE1haGFw
YXRyYSA8YW1pdC5rdW1hci1tYWhhcGF0cmFAYW1kLmNvbT4NCj4gPiAtLS0NCj4gPiAgIGFyY2gv
YXJtNjQvYm9vdC9kdHMveGlsaW54L3ZlcnNhbC1uZXQuZHRzaSB8IDI5ICsrKysrKysrKysrKysr
KysrKysrKysNCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm02NC9ib290L2R0cy94aWxpbngvdmVyc2FsLW5ldC5kdHNp
DQo+ID4gYi9hcmNoL2FybTY0L2Jvb3QvZHRzL3hpbGlueC92ZXJzYWwtbmV0LmR0c2kNCj4gPiBp
bmRleCAyMWJiOTE3YmNiYTEuLjM5NDE4MWM5YTc1MSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL3hpbGlueC92ZXJzYWwtbmV0LmR0c2kNCj4gPiArKysgYi9hcmNoL2FybTY0
L2Jvb3QvZHRzL3hpbGlueC92ZXJzYWwtbmV0LmR0c2kNCj4gPiBAQCAtNzM1LDYgKzczNSwyOCBA
QCB2ZXJzYWxfZnBnYTogdmVyc2FsLWZwZ2Egew0KPiA+ICAgICAgICAgICAgIGNvbXBhdGlibGUg
PSAieGxueCx2ZXJzYWwtZnBnYSI7DQo+ID4gICAgIH07DQo+ID4NCj4gPiArICAgc3lzbW9uX3Rl
bXA6IHRoZXJtYWwtc2Vuc29yIHsNCj4gPiArICAgICAgICAgICBjb21wYXRpYmxlID0gImdlbmVy
aWMtYWRjLXRoZXJtYWwiOw0KPiA+ICsgICAgICAgICAgICN0aGVybWFsLXNlbnNvci1jZWxscyA9
IDwwPjsNCj4gPiArICAgICAgICAgICBpby1jaGFubmVscyA9IDwmc3lzbW9uMCAwPjsNCj4gPiAr
ICAgICAgICAgICBpby1jaGFubmVsLW5hbWVzID0gInNlbnNvci1jaGFubmVsIjsNCj4gPiArICAg
fTsNCj4gPiArDQo+ID4gKyAgIHRoZXJtYWwtem9uZXMgew0KPiA+ICsgICAgICAgICAgIHZlcnNh
bF90aGVybWFsOiB2ZXJzYWwtdGhlcm1hbCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICBwb2xs
aW5nLWRlbGF5ID0gPDEwMDA+OyAvKiBtaWxsaXNlY29uZHMgKi8NCj4gPiArICAgICAgICAgICAg
ICAgICAgIHRoZXJtYWwtc2Vuc29ycyA9IDwmc3lzbW9uX3RlbXA+Ow0KPiA+ICsNCj4gPiArICAg
ICAgICAgICAgICAgICAgIHRyaXBzIHsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
b3RfY3JpdDogb3QtY3JpdCB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgdGVtcGVyYXR1cmUgPSA8MTI1MDAwPjsgLyogbWlsbGljZWxzaXVzICovDQo+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaHlzdGVyZXNpcyA9IDwwPjsgLyogbWlsbGlj
ZWxzaXVzICovDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHlwZSA9
ICJjcml0aWNhbCI7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgIH07DQo+ID4gKyAg
ICAgICAgICAgICAgICAgICB9Ow0KPiA+ICsgICAgICAgICAgIH07DQo+ID4gKyAgIH07DQo+ID4g
Kw0KPiA+ICAgICBhbWJhOiBheGkgew0KPiA+ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAic2lt
cGxlLWJ1cyI7DQo+ID4gICAgICAgICAgICAgYm9vdHBoLWFsbDsNCj4gPiBAQCAtMTAzMyw2ICsx
MDU1LDEzIEBAIHNwaTE6IHNwaUBmMTk3MDAwMCB7DQo+ID4gICAgICAgICAgICAgICAgICAgICBj
bG9jay1uYW1lcyA9ICJyZWZfY2xrIiwgInBjbGsiOw0KPiA+ICAgICAgICAgICAgIH07DQo+ID4N
Cj4gPiArICAgICAgICAgICBzeXNtb24wOiBzeXNtb25AZjEyNzAwMDAgew0KPiA+ICsgICAgICAg
ICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJ4bG54LHZlcnNhbC1zeXNtb24iOw0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgcmVnID0gPDAgMHhmMTI3MDAwMCAwIDB4NDAwMD47DQo+ID4gKyAgICAg
ICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDAgMjAyIDQ+Ow0KPiA+ICsgICAgICAgICAgICAg
ICAgICAgI2lvLWNoYW5uZWwtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgICAgfTsNCj4NCj4g
VGhpcyBzaG91bGQgaGF2ZSBzdGF0dXMgPSAiZGlzYWJsZWQiOyBiZWNhdXNlIEkgZXhwZWN0IGl0
IGlzIGNvbmZpZ3VyYXRpb24gcmVsYXRlZCBhbmQNCj4gaXQgbWlnaHQgbm90IGJlIGF2YWlsYWJs
ZS4gKE9yIG5vdCBhdmFpbGFibGUgdmlhIE1NSU8gYWNjZXNzKS4NCj4NCj4gUHJldHR5IG11Y2gg
dGhpcyBwYXRjaCBzaG91bGQgYmUgc2VudCBzZXBhcmF0ZWx5LiBUaGlzIHBhdGNoIHNlcmllcyBk
b24ndCBoYXZlDQo+IGNoYW5nZXMgaW4gZHQgYmluZGluZy4gVGhhdCdzIHdoeSBpdCBzaG91bGQg
Z28gdmlhIG15IHRyZWUgYmVjYXVzZSB0aGVyZSBpcyBubw0KPiBkZXBlbmRlbmN5Lg0KDQpJIHdp
bGwgbWFrZSB0aGUgcmVxdWlyZWQgY2hhbmdlcyBhcyBzdWdnZXN0ZWQgYWJvdmUgYW5kIHN1Ym1p
dCB0aGlzIGFzIGENCnNlcGFyYXRlIHBhdGNoIHRvIHlvdXIgdHJlZS4NCg0KUmVnYXJkcywNCkFt
aXQNCj4NCj4gVGhhbmtzLA0KPiBNaWNoYWwNCj4NCg0K
