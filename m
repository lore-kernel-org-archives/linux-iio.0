Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0046F3EAC6C;
	Tue, 14 Apr 2026 15:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776180515; cv=fail; b=l9hcP4s0+oUqaTAT/ADWRMfGqAMrFGTgHeHwJ28PR1KIQPMqmmHvIoyZSxkXoFm5lnamRe7tlOhoxVrcIHtaQ+xv7UuIalfuJfkHnkc5QXa4YK/EJ10S/hcFgv7ApOLwVISeLGd77ULPW2FG3XFtof5gcKJW8nlgsd0GtrbmMKk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776180515; c=relaxed/simple;
	bh=XhYtSpScLhRcsnkokqJQuxjsnApkvWOq7LSFsJ/unTE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TAtJLSIWP+pnZr85vcOZOgHA/YhCUnXJ4KXzC8uDOji7f2JPjwmMo3ryKT+GKOfERTJvp1fzrXtWLeMtuLSWQj5mKwFNs9V3TLj32lwbPtdLyYEaCPv8eLNsMvSd0hKfwWH4XuD59BJe+cx1DzDUanc8WoN+5Ny9QSNEV5c+6tI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Qn3FWehT; arc=fail smtp.client-ip=40.107.209.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Qn3FWehT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lqiArj9uirMhaRgeeVxCO4UcmBu0kLYGaNw/ruOq92wbHtLFaA4d33ftVFLxJgg1uuWfa+W/t5VWT4mimFwtl+a5zrOwsKSFM+fyQGpiDo/IuxYIxWeqLeDlwdkHk6DDdQOiPmPNfv4p70QVFwWmHhpjB/kVPlGYW0gpIDcSJJ9w9hct3hGliYvJjsY/q3jvh0LEp96dZoqTlpLd09Zv8paHZAHvw/EpLE09UNrHah2YWzBwAueSr+igl0qSgQrHs8PiQAKO1SlkI7cws4DlDKjVqSD3MsWyfKiQHewopp+RuqHNAj37jsuaptGbm97wcdEzHLmjVCAe4g1HLPGfSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhYtSpScLhRcsnkokqJQuxjsnApkvWOq7LSFsJ/unTE=;
 b=V73D321ZX8OBtOVNMgGOd9QCWlMYSrGguWhKJ6VSydjIfLJjc3Ef2uDoPRentqElJYGcXQ76zPw1zxfRu6JTeQGyTIq4sxoMjQG/QOLdVaZq6w6iOnqX8ZHXF6QEIiMF9jt1BELHEx9KVs58z0R2n/P8TSbSDug/87VKRssMmZ8B51t+hXjCxiDEaVvBCvOzTxcY3hHzLMVVkmf5gHtT8Fnro52e7nUT0itDnbIrXOe1cHpVboUs7mvQGtNMZy9JodKfil5NfVsYJ9VABel+6tfZ7VA324krARQ3Ql9HFwaXfOANZo2i2io0gTUeEbjhrrOPjNW3OCox47haqWoA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhYtSpScLhRcsnkokqJQuxjsnApkvWOq7LSFsJ/unTE=;
 b=Qn3FWehT8EqhyP7ss07FJwzojtL3zNW4JegXtn8xusNE5tEf6Xxti91nLRZ6KHTiN0g3Sl1t3WeAjDGUF2TBnuaojIsfVdbPfX6lBP1IiOlm/NEhQurivEQGBgAuNAkc6qQ8ecp71Wa5bQHdCj3T5Iw0fUdlOQ3nawZ+AuaLQn46Fyd8+YgS6HirR02UcvUSEtGyPdeeo//Y0XaVVZm5E53aF0zU9DC7W/XWe3VbWYW0qMyOVnmTFTvMTHa8ZPp/F/LdFT/WUxezNGeQb6fF/0pn3KLQWoP73c6O4OO5F+6URuzsdHKuMN0LdREMH/BvqYmW7JeJAYE3EiuUCQwpSw==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by MW4PR11MB5889.namprd11.prod.outlook.com (2603:10b6:303:168::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.15; Tue, 14 Apr
 2026 15:28:29 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%3]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 15:28:29 +0000
From: <Ariana.Lazar@microchip.com>
To: <robh@kernel.org>, <krzk+dt@kernel.org>, <jic23@kernel.org>,
	<nuno.sa@analog.com>, <dlechner@baylibre.com>, <conor+dt@kernel.org>,
	<andy@kernel.org>
CC: <Jonathan.Cameron@huawei.com>, <Conor.Dooley@microchip.com>,
	<devicetree@vger.kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: mcp47feb02: add MCP48FEB02 SPI driver to
 MCP47FEB02 I2C driver
Thread-Topic: [PATCH 2/2] iio: dac: mcp47feb02: add MCP48FEB02 SPI driver to
 MCP47FEB02 I2C driver
Thread-Index: AQHcw1e0MHwcUzmpM0eA/CxxgMNbArXO7SaAgA/S24A=
Date: Tue, 14 Apr 2026 15:28:29 +0000
Message-ID: <4b289795ffe7ce3505087446a5f2aee053ace561.camel@microchip.com>
References: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
	 <20260403-mcp47feb02-fix2-v1-2-da60c773550e@microchip.com>
	 <1e05b8f9-e95e-458d-9179-ac8268023ae5@baylibre.com>
In-Reply-To: <1e05b8f9-e95e-458d-9179-ac8268023ae5@baylibre.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|MW4PR11MB5889:EE_
x-ms-office365-filtering-correlation-id: 360c8e23-7fc1-48fc-0c80-08de9a3a7ac1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021|18002099003|56012099003|22082099003;
x-microsoft-antispam-message-info:
 ZyT4L7zTsYBZJAdTbVpf9FtSBhwr7iT2WdrVogHMUV5r9bsLMHk9cAuaRZd7jZzEN04+91L2AcekIeYvZUlTJ2mzTgWHDdIVsZX552A/KEvC5NpuiBnJOlY9ZfuRgDb1pRwmakqm4bRvUiCnbyNzcy0vpPhG417vmXFqCKpZvbMV1ZPyX5tHnEe/BKqZJdepwTh/nI/U2xvcFP/wDdx7KspYp1q6zxvu0hhOvw22/7ewpF6EANeOCpTFd4lf9OVR6kZU7HYx5+r9h4T8N931zBMEeJ0yQgEclSF50bDdufoFQSSDqZUJWYhgRmMxBRP8huREKYaVfwG4Z9vEfKrlbLnXL6W+Ulcsv3xFrVnc3/KwUmLkf7rnXl34j5/xHKWifgmOQQTFnr3+OY3pSxIOmYAEkY4i/fDC0vyBJrtI0BVThWlrk934rWnlQTcULSMBLHOS0rgNRyZTovJItYlv7Azf9+y4x0Q5n8caRAfVtx+vMFWrfFZrbhN8khB/u/rZmZiHkwd/6cCORZZM3eDGgojz5cQgy+JzjhkI+NfEhLGr4B3b/VL9MStCVpuH2UIDogswKie6vZWlqY08eGHUXR6lyBwdXurQMtz+JVDs4fVpWfLIYec1iYG/N41XGV0oMF8y9zEpDiYVcY305JCz/yUvc1KS3hHN2D1G0s3g4eIf8nc6wzsXUHVsVzlfXYjxcSSwjPMz23jp8A3xWK/EVIP1VrTMUY2gEdDAikYrUQa85Kub6VoOrEVCqq/s3U5B7l9uF43IfG4Svulw1GfeChhi3wQS3zmrfNH/6ereURg=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UzJad0RBL3JsbHJ2YUs0T2s0QnpieEMzdEdxZk4yTTMybkRCNkMxN3JKNE5X?=
 =?utf-8?B?VUlPOGs2U1BKd0RFNEkzUnF0UVhOd2JhdWxlRVBhV1ZkZEhXZURpL09nOVZk?=
 =?utf-8?B?QUlwdkdrcHhvSjl6NFNnL0I5aTAvNGZHSXZtMEJQYVdoT2FvcERiNjFycXRz?=
 =?utf-8?B?Q2RGN1ZYek4wVnk1SUZGTC8wOE5zV2ZvSGM5YkF1ZE5CZDlYcXBxV3VRUzZm?=
 =?utf-8?B?ZjdlOU5TcHExWW1WbWp0M09jVk14UnV5RWl1cmtHNlJWK0NlU3N0MWVNd1Jj?=
 =?utf-8?B?SUpVQUJ4dXhvYWw2aU96RTVzUy8rRmJySUlYKzhQSm1vR1JqZGJubjZ6RnBK?=
 =?utf-8?B?MDFFMmROK1ZzeWdwMXpSZ3RSemZtNUd6U0hEdVg0QjdtdTg3YlRGN3VqTjdI?=
 =?utf-8?B?cnhTRU1zZk93QVJVRXY5Rlh6UE9HeFZXL0pYanhlay9EN2pBQzBobXV6TlJt?=
 =?utf-8?B?VThCeG85aCtWR000Z1lkSUQ2dU5mdFlpbzdYSDJWOGhhdW9IclRFS1dJa29a?=
 =?utf-8?B?MDE5VUxocG1BYlJHY3FzZjJWTTRHWjM5dElGNzFIdk44OGVtMjZsUVAzOVEy?=
 =?utf-8?B?ODM1bllnenUwN1VUbitKSFBHWmFoWFhXM0xudmhEdzdncWRJcDlWQkVsQ0Ja?=
 =?utf-8?B?c1dOSUFxR01kQTg0M1N4UGJYczBHTlNVNmtJZytNK0EyRDB4MHJHR0RDanBX?=
 =?utf-8?B?a2haZnEwWWtFZWJib25iNXMxamFrSHR3REFONDMrR0R4UkcwTjNuamh1eGY3?=
 =?utf-8?B?Tjl1OUdRTXdIUmdHZjVFLzRTRHU2d3dwTHpydEloL2d6azRIU3A3cVgvQ0ln?=
 =?utf-8?B?cXNnUTZ2OTZkNms5SDg1RlhsMUxiYnlOcGVsSXp4K1k1ZW4ycURiUWVMbnNK?=
 =?utf-8?B?bjNUcVNra3YvYk5ybEp3MVNKaWI0ZmRqeStRVUY2eVo3NzRxN3FidmQrTzJw?=
 =?utf-8?B?UzdBRGgxcHZLeEhEeEVDL2MxejVkdndPUk9ncyszZzFlZ08xUzBsZzhUalNS?=
 =?utf-8?B?KytEZHRMY2tCb3FwaXQvNXJuSmprTjRvUW9iYW9TdStxRk9hQXEwYTA4T05R?=
 =?utf-8?B?clFZRHlxQWltZFlBRktKenFZalRjZmhxUGFVb0d1Z2ZNeDFwRW91K0o2VGdT?=
 =?utf-8?B?bzdTUEhwV2tFeVNML3Y4Qk5YYWhqblpsMzhDaTJubE9NNG16aks3b0JobjV6?=
 =?utf-8?B?NzBxY0VpQW93K1p2NFkvQjdhNGU4TjFMRUhRRSt1NCtLQXNIdUNZb1ljbWhC?=
 =?utf-8?B?Q2FWQTV4bEtSUDNadkhqd21sdkpQZUxWZnFrV2t5dnVkWlZyVVZHdm9vbkFE?=
 =?utf-8?B?TERaTkdXMmlJc2plZ2VtUEpLQmhtMnk1Wm5qVTZDUHpaL0lXeWxSTm50Vkdu?=
 =?utf-8?B?Z09RTjBKZkZDQmZxVW5GblprNTVsUVlLUzVNU1l5YkhaSkpKWnIxbW9hQWNy?=
 =?utf-8?B?VUFNRFFBeU9SZUl6M25ZUWtUL2xvejBPQ2VIZ2NVc0dNSlp5NzBGVWFKQnZM?=
 =?utf-8?B?Y2JtdnBDUHEyWC9rMElPV3FyRHlXSk05amVkc0FHVS9vTnhjYTdaallOQWlW?=
 =?utf-8?B?TmY2Y0FWVWF6UnRVc2Job3l6STFXNzhxYndSczI2Q1JTV0s1eE5pbFcyazdP?=
 =?utf-8?B?MUltdEgzZ25DVTRBMHQ4WUlKVSttQkpaMGoxb3JOYjlsb2YzbzFwK1d4eVVM?=
 =?utf-8?B?emNhYXNxRW5oZStCWnRLa3REalNPNTNTeDZwM0FJZDVqMnVxTmt2dDFsZWFR?=
 =?utf-8?B?dXN4bXd5dEhSOGpFZUwwUDBZWnRPT042RXF4bjVPUjlmU3VOdXJXUVZUVXpB?=
 =?utf-8?B?Qkp4Q3VHRWJTcGxMSlk5NnBTSXc1Q1lJOVdFZURaMlhsQjJ4MW5yenJEU1Jh?=
 =?utf-8?B?dndraEZCKzg1bGNUUHlvVGUrODk2SEdwZnpOK3U3bzlzaUN1V0JtbGp1Nldo?=
 =?utf-8?B?TmhtNkpQd0ZUOUtjS3ByOUxTYnZqK2NWNG9KaXdvU1ZNR3JaRm1Zai9BU2Fa?=
 =?utf-8?B?REVrNzNkdXJSdGNwb2VLSzVSTDBnZFd2cG9ZY3VjVmtGM1VtQUpqNmQxWXUv?=
 =?utf-8?B?MjIwaUdRTkQ5dHFhUEw4Q0VOZ3Z2aEtmcXoraEkwNkszdXlLSlY4VmN6cFZ4?=
 =?utf-8?B?a2FmSUt2SXAzSVZCT05oNEhvZXRxVFkyVHEranpKK3J0TDdTenBlTnNVKzZR?=
 =?utf-8?B?eGc3ZTg2a1l0WWZtaTNsaEFYa1hjZDllNXBhSThEZnhEZHhTWTRoVy9hSVFH?=
 =?utf-8?B?WERjYWZObitXdUhjQlNiNnhaVVUvblA1c1lMcE9NRUhSU2pRUGN2VDR2aXZw?=
 =?utf-8?B?UFk1a2R4V3ZxblovTm1jbXl0Q1BqajNwMm5ob1NaYjFLNUJ4RkErK0xrc2h0?=
 =?utf-8?Q?ILVz20XbB5h+c2BA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1D673EFBDE1D3459C5C8E6A1B3EDC22@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 360c8e23-7fc1-48fc-0c80-08de9a3a7ac1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 15:28:29.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mtxYqnKVzGgQ3Gpuki4N4y78nqnSS3Tdv7x2aSn7hXw/ct9Xo89Ww9q323UebzNAwJ0DZNKxrUMKy3yKngTRGEFnM+p6YzNrlGhRCuburc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5889

SGkgRGF2aWQsDQoNCj4gPiAtLS0gYS9kcml2ZXJzL2lpby9kYWMvTWFrZWZpbGUNCj4gPiArKysg
Yi9kcml2ZXJzL2lpby9kYWMvTWFrZWZpbGUNCj4gPiBAQCAtNTQsNiArNTQsOSBAQCBvYmotJChD
T05GSUdfTUFYNTgyMSkgKz0gbWF4NTgyMS5vDQo+ID4gwqBvYmotJChDT05GSUdfTUNQNDcyNSkg
Kz0gbWNwNDcyNS5vDQo+ID4gwqBvYmotJChDT05GSUdfTUNQNDcyOCkgKz0gbWNwNDcyOC5vDQo+
ID4gwqBvYmotJChDT05GSUdfTUNQNDdGRUIwMikgKz0gbWNwNDdmZWIwMi5vDQo+IA0KPiBTaG91
bGRuJ3Qgd2UgYmUgcmVtb3ZpbmcgdGhpcyBvbGQgZmlsZT8NCj4gDQo+IFRoZSBwYXRjaCBzZXJp
ZXMgd291bGQgYmUgZWFpc2VyIHRvIHVuZGVyc3RhbmQgaWYgaXQgd2FzIHNwbGl0IGludG8NCj4g
b25lIGNvbW1pdCB0byBzcGxpdCB0aGUgZXhpc3RpbmcgZHJpdmVyIGludG8gdHdvIGZpbGVzIGFu
ZCB0aGVuDQo+IGFub3RoZXIgY29tbWl0IHRvIGFkZCBzdXBwb3J0IGZvciB0aGUgbmV3IHBhcnRz
Lg0KPiANCj4gDQo+ID4gK21jcDQ3ZmViMDItb2JqcyA6PSBtY3A0N2ZlYjAyLWNvcmUubw0KPiA+
ICtvYmotJChDT05GSUdfTUNQNDdGRUIwMl9JMkMpICs9IG1jcDQ3ZmViMDItaTJjLm8NCj4gPiAr
b2JqLSQoQ09ORklHX01DUDQ3RkVCMDJfU1BJKSArPSBtY3A0N2ZlYjAyLXNwaS5vDQo+ID4gwqBv
YmotJChDT05GSUdfTUNQNDgyMSkgKz0gbWNwNDgyMS5vDQo+ID4gwqBvYmotJChDT05GSUdfTUNQ
NDkyMikgKz0gbWNwNDkyMi5vDQo+ID4gwqBvYmotJChDT05GSUdfU1RNMzJfREFDX0NPUkUpICs9
IHN0bTMyLWRhYy1jb3JlLm8NCj4gDQoNClRoYW5rIHlvdSBmb3IgdGhlIHJldmlldy4NCg0KSSBr
ZXB0IHRoYXQgbGluZSBzbyB0aGUgY29yZSBtb2R1bGUgd291bGQgY29tcGlsZSBhcyAnbWNwNDdm
ZWIwMi5rbycuDQpJZiB5b3UgcHJlZmVyLCBJIGNhbiByZW5hbWUgdGhlIGNvcmUgZmlsZSB0byBt
Y3A0N2ZlYjAyLmMgYW5kIGFkZCBqdXN0DQp0aGUgbGluZXMgZm9yIHRoZSBTUEkgYW5kIEkyQyBt
b2R1bGVzIGluIHRoZSBNYWtlZmlsZS4NCg0KQW5vdGhlciBvcHRpb24gd291bGQgYmUgdG8ga2Vl
cCB0aGUgY29yZSBtb2R1bGUgbmFtZWQgbWNwNDdmZWIwMi1jb3JlLmMNCmFuZCBjb21waWxlIGl0
IGFzICdtY3A0N2ZlYjAyLWNvcmUua28nLg0KDQpCZXN0IHJlZ2FyZHMsDQpBcmlhbmENCg==
