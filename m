Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012049.outbound.protection.outlook.com [52.101.48.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DFA3A1A26;
	Mon,  2 Mar 2026 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772447289; cv=fail; b=H3atZb9fyiUuT44ikEM5A0oPlRTTGRZRacjhwToISQg4SwTHWUc1nK2WkOyLWKn7TZ/q7yFRJYnOO1qYga9qgbbJCt3vbEe2iA8cTXZ8fQj3BP8S2hhAC2p8EH+S6ePMtzl960cFisvnHKCVgJqqpjNF8Fl42gVXnvQ/8XksP24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772447289; c=relaxed/simple;
	bh=sclC0hIc86M67ccC4217B6Jwamba0thoq7NVhbGpn2g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ASijUenmImF6V1FvWHfBeKcTZASmLvWNZBLpDnUfxrQdaiKCtn/OPBrT8ILCaMwDG/ib+yiWzD6FOGyn/MXm766WDeJA6EKyd2kwWQnAY+3BMZEuMfGDSOl7UoP3qtPgFHqUz8+QPOVgrvi1x/os4eL7j4IymAnIC6PxKmASNm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=4I+keM66; arc=fail smtp.client-ip=52.101.48.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="4I+keM66"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hX9ImjazKr6mT5DJfE3FXSJn1BoyEtUAEm9MoVg6jfMg/Yg3ebgY5p+wjPv8T7BTtCjZT2EXbx3v3Bu5yxw5ybLhyFQ+lTiuVTVpoU2DLCGRBFch2a52m6K6UV1/bCvjnqohJUu4/2tKCwVWqtJ9UvjlglzmY/K/QDvamsU+Xp0HQ9dggMC3yD/HeBJam02Gs6x72LaDPrqG4gD0RBTQQIYdVUnfVVM7v5XvJEj8V3tE3rMAfkXqNnJB1lZGwHNYXULgBe+qRvhRR3soRdPd6kgNhmiP4ydQW3sZCi6kbpZv+DDU5wrJ14esz21VF+oCmU0E18LOapRozO30obJ8gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sclC0hIc86M67ccC4217B6Jwamba0thoq7NVhbGpn2g=;
 b=iMkyUlot5uPZrBhgFtOx7VqUB1xXOC4mClXg3+sQnqI9n7BzNj2cuiG1rL/TMd0QNWQoBTUXlC+o//kpdwfrvK9CzZVtsC8xNe+etXP34NcyAVmycsANBP0ZHLo2ai+TOoaTJ2i6yzScs7um6zPHd6EQ3vK2QO7zT5nxtGltEIlH4PzxnH3x3VIvnSoctvJfDpLsSY9ZtGAWnaKyQGZLlfG3pmc1V9hIdg28GoQfbZowPsF7IzI0JKyzXLTKEw4v2/ebZfVQAcbeqhmlAl3+0EoPV47C4jV/SPQZ8AjtWbCQGTXZATcliIvLpxoRyWqQNVmJzK15EiJRUVHj+UKMgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sclC0hIc86M67ccC4217B6Jwamba0thoq7NVhbGpn2g=;
 b=4I+keM66c8lvKU9A0IqvoCMiObd4FAZknbf2Im79cVwO3vjVJHdZq6Kn8of/eGE5lrs/4rAqXDqMnL8SC43EhiBZU0L3rOwdANLH2TQsGuuqQDn9YbmTLUnIuS8S3tyV585eiRvM3adq3jImt5KJsM39+JvoFLzS6YpfLOIXxrcZM9GiuCzdbFa+Ux0YPo2Ly3mTiqMIMvmZ29cUPaEXhWc0wd+trF83Ex6BVUDlmrNG2Gcq9b+YPCw9hL3N08qubs+h2RlEdmcaJExJRi4n5AiM0j9uJk6M7StbcWAnZNu8Rj/r9m070vefc9pTq35YpM8L0tLQvpWREU0yxeZPEA==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by PH3PPF9D9CDC305.namprd11.prod.outlook.com (2603:10b6:518:1::d3b) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.19; Mon, 2 Mar
 2026 10:28:04 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%3]) with mapi id 15.20.9654.014; Mon, 2 Mar 2026
 10:28:04 +0000
From: <Ariana.Lazar@microchip.com>
To: <jic23@kernel.org>
CC: <dan.carpenter@linaro.org>, <dlechner@baylibre.com>,
	<andriy.shevchenko@intel.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<andy@kernel.org>, <andy.shevchenko@gmail.com>
Subject: Re: [bug report] iio: dac: adding support for Microchip MCP47FEB02
Thread-Topic: [bug report] iio: dac: adding support for Microchip MCP47FEB02
Thread-Index:
 AQHcl24xxWmzSZRfwUiLfa7mzfu6B7V1tA6AgAAIMQCAAAuUgIAABMyAgAAHCgCABezEgIAd/2sAgAFvy4A=
Date: Mon, 2 Mar 2026 10:28:04 +0000
Message-ID: <ba4306f4a3cba818008c20b0bb9724a184425488.camel@microchip.com>
References: <caa37f28-a2e8-4e0a-a9ce-a365ce805e4b@stanley.mountain>
	 <aYXvP5FLA5BvkoVX@stanley.mountain> <aYX016NlTNkJzGdT@smile.fi.intel.com>
	 <aYX7tlJ593KBDGW0@stanley.mountain> <aYYFba5-ZV8VuZHM@smile.fi.intel.com>
	 <aYYJc2d5AwJbc_vV@stanley.mountain>
	 <CAHp75VdhTEKu2tKC+UKJLs1DcE7079KEbPV0NTFfUAjADBEg_g@mail.gmail.com>
	 <16614d1f875aa1e9923375dd3de0897de17791f5.camel@microchip.com>
	 <20260301123140.10f585b4@jic23-huawei>
In-Reply-To: <20260301123140.10f585b4@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|PH3PPF9D9CDC305:EE_
x-ms-office365-filtering-correlation-id: e7e4528e-5c4e-495e-f6d5-08de78466391
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700021;
x-microsoft-antispam-message-info:
 8u6Y7qftq1rTikFY36Lb5bxnECWiizVEDWj64tAT4TLqeP9Td43/5tldN+Jqd5SBRAIi7KUmTUtwZ4zrU6hzi4PgogZa6YQT2TGck/IuyFAesPE7v8YEwIT6xsngUULgRz0vjJhJkzS9DLYaLEZ1qOEXGw4ZmYTndrFq2APQfXrCNhEFnYMoeAFbuhcDyuW749jM3w+EDbE171pP3mhUvNGutlaAWdJiR+6N4N/MHPxyhF6XuNc73GbSSKWZXKX79neY62JvDfD353S8Up+/hG1zF68YbWY1A3TFwjbkakWQe+n8T2ia1bOFJ6DCFaFny+akBHbiFgY77USWz4wHehw+kq0j5X0eaiRPz964cdTnHMp46JsVhwTTONFoHoMPyg3HVec7ryGtBbjdkIb5MrA3YUgzC9WyxFJKaaFOvZ3As6rg3PMFpEdpq2rFieZS90cBLbv8d+j2dB5dNPylE57pyUcvkqBjFHe32LijldANdZ0bQ3mAtUWYNYzIq4aaxpZNoXtd5pGX3j9+vDUqCoE1tBrzfa1TACo2qA7MVt9pXlR7WL6zMAVzKIVqm/TB9zrSv0eT3MXvBq0khgXC927YrlXQu0HjT8G/CnUDwraUItSMmyQgcsJUk0/TW+vE7IWZ8yNYRZrmWtPH/Mfj2nCg/oSKJezguyw+8NzmGIBB+pScQjl3XDaYS/eEGDKKNKgAHiKkFpyPIUQUn7Pk4aJk33pd9Bpwid0bpgQsIqOtPImjJyziD6uNE4PEnjh2C9c7mP8WoujqIDOh5k3MZltTZ4ZHcWBAZp54NNyI748=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3I1aWNPT0ZjRlZHOUxhYmg2aFpSMlNTRW4yWWx4Z1paSHQ0Y0JhME5MbXRa?=
 =?utf-8?B?QlhLUGlWaXUzeXp0Zk9BK3VWZ2V3V2hocGZBMFhiS3RwSU8yMkZqNGpsUkNu?=
 =?utf-8?B?M0Z5R3lCR3FhTGtSTi9QcWxUblJ6MUNLMlIxTGplVnd5c2F3QWtueXZTYmtF?=
 =?utf-8?B?Ry9sSitBdC9DZE5qYWlVL1NYSERad200YjVhZlZRUU5lSEZNVXBSdEwxSEt1?=
 =?utf-8?B?eDZHdzlVbkZ0M0NoTG5MQ0JJaVVZZzlySG9tMEZNZGgvUFJHSEovNkw3YlFx?=
 =?utf-8?B?UU5qT2FyOElJSWd2NnpSMkJiSDhZWldQR1pMbVpWSnF1T2JXRDdHVU5FdlB3?=
 =?utf-8?B?NnFIb2cyVTVkbjFUSFJwL3FmakhMN3NQcVg5NlRqU1prbWlCQmdCTVVjMURE?=
 =?utf-8?B?TlhsaEJRczMrZGg5WFJsRGcrbDJXQXkxVDZKS0tubXNvdXRRenlnRkVlSFRJ?=
 =?utf-8?B?Rms3bXZoSnFNU2U1cFpnU0g0QytJWGpjWEY4OEFSeWdiTUxTbkdqZytOUVdR?=
 =?utf-8?B?RzVBVnc3RHJvTllMT1FCWS81cG55NDRUbDJQRUNHK1BHNkFibkRqRlNXWi91?=
 =?utf-8?B?RGV1VVg5S1FSMmdOa1Zodk15K1hzUzJKSHhkczBGd1E2czJIOHBnZEFNakFJ?=
 =?utf-8?B?RHJSK2VmWlJ3Y0xWTjdYS2VFZnl2V3VIZkxtUFpVY1RZN3dmeG5tcythdUgv?=
 =?utf-8?B?ZWJnVTZtVlowQ2tZa1Z2d1N3cHRCTC9xY1czZWtmdXZkMCtaUWVreTNuK3o5?=
 =?utf-8?B?ZmFRZDVQNWQ5UllhRDBGakNyT1BPVlBkVjhLWXNYb05vK09LK2lhcnpwb3VF?=
 =?utf-8?B?amszaVBNUlJoN3cvNlpZNjNXcE9jVFhNeG90czRHQlZjUC9iY1hxTmwzWjRR?=
 =?utf-8?B?c3h4am84cGtIYTJHWDJFelgrUjVNOVNFUmhCdU1uVkhwR2w5QzNTQzh6MVo5?=
 =?utf-8?B?Q1JMVzBUQmxFODNXQm91NE9CVXdWMnVRL3lHeFpXNVZ6UkRlU2Q0NVAySmt2?=
 =?utf-8?B?YytHM3c2NG1lbGFGdk03TUlBUjNTaFRia2FHODRmcVNWV1Nxanp5NEFSOWhP?=
 =?utf-8?B?Y1JFcmwzbnIzZWhpY0Fab09rYVhrMk1KMEJ4elRxeU1Cc2dZQWl0RUMzTStp?=
 =?utf-8?B?ZDlsWkN2VVlIanR2N2IvM0JpSXZMR2szVW9mdVZMOGk3bFNET2VHVXpHNDlR?=
 =?utf-8?B?cllJaWlDOGRNbUJaMWp2REg3VWF5NU1sVDU1dllYeDZJRm02SzMydDRNYTlm?=
 =?utf-8?B?Z3k5KzhFQjd3ZVZmdWMxcWVOMnd1WXFodnpQV3VlbngvN1BaZnZFeUNieFBu?=
 =?utf-8?B?N1VKb3lMMENuZXNiODJyVjlPRmVpUTdnRVdpV0E4dGozWHI5ZUdzWVBMeDZt?=
 =?utf-8?B?aDNVSWI4dFBpMUZ0S2NlU0psS0lBL3JjWGpGVTNTajBPUzRDcGc0eStrTDkz?=
 =?utf-8?B?eGppemRBQnZzVjg0MVc4NCtkT09SUWpaNE5NS1Ava3hrRGp5eVFIR3FMOTdR?=
 =?utf-8?B?d0FucHhSK2k5d1FsMU9xUnRGVS84QXhFZGxPYjVwcTIwZWF6QU9MR1JQQzdj?=
 =?utf-8?B?cnE2VnA1dlU2WVRxWmRicEMzalQ3V2cxOXhUQU5Na0E4bFI0MHBTTEpMc1Jr?=
 =?utf-8?B?c1RDeVhoenhlVU1zTFRPT2ZHcXdPU2xJQWxsdjZHU2JrWVNMajVhb0ZUbEJ3?=
 =?utf-8?B?ZU5nVEFpMVdPcmVsMyt4T1p4S3ZkdFN0VXhHbmVicHI4T1lBOHNKV20zNGcz?=
 =?utf-8?B?eWkwbWwzZ2tVclB5R0Y5WXdiU2FMK0lUcHRQQldOYVFKa3Q1ZnE4Z0g4bE1k?=
 =?utf-8?B?dDFWNncvalFZRHpFNXlPbTVPTTdVekxYSk8rVHY1eHY4UlVHQitZcDloTEFh?=
 =?utf-8?B?b1V4MzJOTFRkeG9mb1dRSGxmeEU4NDJCTXdBYzJrU2lDTW03bjBoRnB5bE9Y?=
 =?utf-8?B?dTQ1Vmk2clczdFNhR1VTUExxM3FSQU5CS2tPOGs2NXBBaEw2Q0VBVnR2d1Zr?=
 =?utf-8?B?WHlHNGU0dmRoc3VaMS9nS1JlVVZtYXRGUEtRTGFWNktwcXlvUGs1TDBLeEdq?=
 =?utf-8?B?ZkgvNUVPS1ErYnBxMmNCMnhvZVlqK0dVRFN1Nk1OeEhaUTJrc0VZLzlmS3pr?=
 =?utf-8?B?ZzNiazc4MDM4azlyMm0xNkFDRTlsNi9KWGNGMXZQNGEyWnFjbkZIeHJnZEl4?=
 =?utf-8?B?VE0yQUtFWTlEYnYzY2pnMnRzV3A5WWpCQktaTldLZTJyVmFFVkFiclBBTnYx?=
 =?utf-8?B?Nm9GQ0ZjSHFDbVdxb3g4ZEliUmd6K0poZnJ3M3Y5aWhUdGNTcThRNXgxNENm?=
 =?utf-8?B?VnlQd09JaW05Y2FqYWhLSFV5ckV0dzZQRjZMZkRBbnVlUE10ZzVUTVJIZ1Zn?=
 =?utf-8?Q?NI1fDRf1TbbEnzvk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D4B933138846C4489D1D83F3DCFA100@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e7e4528e-5c4e-495e-f6d5-08de78466391
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2026 10:28:04.6182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BFYuGaJJHnA0wza+D4tiJzTyGoloAqHHilFh6XwhW7aAl0EnV0pSBXEPGE4TC4lwZaY9F6gd1Qgn/Y39CB2JTLHVed+yWOsI5UTJxUbKUdM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF9D9CDC305

DQo+IEp1c3QgYSByZW1pbmRlciB0aGF0IHRoaXMgb25lIHN0aWxsIHNlZW1zIHRvIGJlIG91dHN0
YW5kaW5nLg0KPiBNYXliZSBJIG1pc3NlZCBhIHBhdGNoPw0KPiANCj4gVGhhbmtzLA0KPiANCj4g
Sm9uYXRoYW4NCj4gDQo+ID4gDQo+ID4gQmVzdCByZWdhcmRzLA0KPiA+IEFyaWFuYQ0KPiA+IA0K
PiANCg0KSGkgSm9uYXRoYW4sDQoNCkdpdmVuIHRoZSBsYXRlc3QgcmV2aWV3cywgSSB3YXMgd29u
ZGVyaW5nIGhvdyBkbyB5b3UgcHJlZmVyIHRoZSBuZXh0DQpwYXRjaCB0byBiZSBzZW50LiBBdCB0
aGUgbW9tZW50IEkgYW0gd29ya2luZyBvbiB0aGUgdmVyc2lvbiB3aXRoIHRocmVlDQptb2R1bGVz
IGluIG9yZGVyIHRvIGluY2x1ZGUgYm90aCBwcm90b2NvbCBmYW1pbGllcy4gSWYgeW91IHByZWZl
ciwgSQ0Kd2lsbCBmaXJzdGx5IHNlbmQgYSBwYXRjaCB0byBmaXggdGhlc2UgYnVncyBmb3IgTUNQ
NDdGRUIwMiBhbmQgdGhlbiBJDQp3aWxsIHNlbmQgYW5vdGhlciBvbmUgd2l0aCB0aGUgY29tYmlu
ZWQgaW1wbGVtZW50YXRpb24uDQoNCkJlc3QgcmVnYXJkcywNCkFyaWFuYQ0K
