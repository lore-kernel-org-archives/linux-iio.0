Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012064.outbound.protection.outlook.com [40.107.209.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021C7217723;
	Tue, 14 Apr 2026 13:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776173977; cv=fail; b=ju2uqqrwxKZ5kxD6wLIyZmftTYdMti1PNNJGDf7JytG8T0O2JnNlpwVcLWtnKwqCYzfUAbjmH4ezKPOdjnDVM/0XrtVDsBlRjkCvQHgHzh5E7xHnpwJA8zQF1YmKdVqnG2SH0O68luOS96gER7B+QfgF+hhcrxtxD6t68Ujhv/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776173977; c=relaxed/simple;
	bh=gHXQXsEsnHR0ZTqrq2jMWiZAgNR7nvEooWPX1W5qSIo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oXsExW5viXcviyk3+GYZXsrQuYh+aqR0k/nO434RHVkoyF4seGQt3k0j+N11De3C73xMeCVsvbXAewOCB5ywJJE4qe5LLaz9nYkxg6pwKN136xLRlG/KCAJnw0N4XIXK+lIteaYud7qfCgfvg3/3kJlmkR+kA7oL8LRqUAHxS+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=sWjzKGAk; arc=fail smtp.client-ip=40.107.209.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="sWjzKGAk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CeL7OhNVaTCYBCJerChja9RVPtCPXQ10Q5PTDchB0u6YFKbEs7yP7fi5ME0kre3NLaTShSi9NoZ9YwbmsP2ySQqL1tXeySACCiHOR9BQJEqqUS9PYxIqb0VrDk8VPdmdkbff6CQR7iUzoS71eQljgr+LGDRavYsBdcgtVXKvsk8S3MeHegIjM1Si2YZrK4IQ7einrJxTD7HfzBvY6ehRGFQd2t+5Hgxwnh3qA+J45J+5ZZYgoR/7bUoolK9sYb3Tu3x3qD2yLnAS78jVSshw0/iNnP6hVADUwtx44eU9BBfZuhg00+Uaarae6x8ZRtwtcw8s5sCC0A0qgpEl3LoJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gHXQXsEsnHR0ZTqrq2jMWiZAgNR7nvEooWPX1W5qSIo=;
 b=HP4Ivp7+Z1L0q4FJkWdW5ZarHZoIr1AACaLXiAQ/LXaiHjUSCvD9ksOHGLDvdHMmWtKK7ZzkzD90jjr2YmHxb3mOD1IHdwR0pSnpaHKrprCnL+qpTMLRu2aNEjjKuLU0d1T9m8fGQfaMZxkHjA7VgsoFF0ZisusINoPVsfsLLp16vzvY9/mBsbHw/4S8y+Km3s4OeD870igfozXD7FWz2wXDs/7l+aF/4sQUyrO3LIcHa89WYVKraj+v9LItVAv6dRViZCoyEbPApNrtUtn+X5/2HOYfhXguzBs66AHfKmKyMY8AYRj0sYQeTHl6SrCi1Mv2pr8ykW4jn6iABD5mAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHXQXsEsnHR0ZTqrq2jMWiZAgNR7nvEooWPX1W5qSIo=;
 b=sWjzKGAk28qu9uVe6k17XUHvARrD4xXeU70JaTb/utbVNnyLyRQn2Eb3ftGD4MgJLrmnzzYxK133licpRUzOH+4eJpO0eNl1SNpRAmrqOCF5qUHKDaM3qiVlGv7thcpbCc8gyWCIpGPLNDXf3ih78/ohoeTT74mFMkDnYLqLWhuVMVUVo9a17Kjc242mEmehagpOfi7oSr75jVtXriiNejWF+rieUZAbY4Jzg/wh+jn9jn55jG1ArWsIg14ocOqgyD8yyA+MHESduu/h3Yr9B+P3xpogRMKVNdvQk1lf0dsbQ/eLfHin1v18cyNZpfiOL7BaBx+M0DYsCNUsRCPTkA==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by PH3PPF55C5E51F2.namprd11.prod.outlook.com (2603:10b6:518:1::d20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Tue, 14 Apr
 2026 13:39:32 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%3]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 13:39:32 +0000
From: <Ariana.Lazar@microchip.com>
To: <conor@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<Conor.Dooley@microchip.com>, <Jonathan.Cameron@huawei.com>,
	<robh@kernel.org>, <jic23@kernel.org>, <andy@kernel.org>,
	<krzk+dt@kernel.org>, <linux-iio@vger.kernel.org>, <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02 to MCP47FEB02
Thread-Topic: [PATCH 1/2] dt-bindings: iio: dac: add support for Microchip
 MCP48FEB02 to MCP47FEB02
Thread-Index: AQHcw1exsFmkkxZFuEKBWaeFsPQju7XNNI2AgBFtAwA=
Date: Tue, 14 Apr 2026 13:39:32 +0000
Message-ID: <dd516b8155d9e782855f5e06e2260d57b596184b.camel@microchip.com>
References: <20260403-mcp47feb02-fix2-v1-0-da60c773550e@microchip.com>
	 <20260403-mcp47feb02-fix2-v1-1-da60c773550e@microchip.com>
	 <20260403-speed-childless-1360de358229@spud>
In-Reply-To: <20260403-speed-childless-1360de358229@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|PH3PPF55C5E51F2:EE_
x-ms-office365-filtering-correlation-id: 8955b231-7a52-4d10-6b21-08de9a2b4298
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 dwtZ/RImoBybKJQ3QiYAVKg5lLWbP7HzdCx29cnNk0kR7fzXWevMWrWegJt+vDyCyNv2unxEUclqw3vRg2dvHbyapcOxiYYCvdOgSkfxVbPqtSwm7iuuuU77XYUtnbm+ASyzN+yWZU8S48iUufh60NOixr2rouHcuJJ8xkCB7kqkrm7RlLy2VzDbpkHo5V8XEiN21tGGY9Or6kRZtIV+NM8Qyqe++0spM+Z7MGsCKz3uMSoHFw3mFpDSzP9Qc/wcHkV5ZJ3DePrH+AAA2TpPBHi6nDkZTm8RNv2dbh9Pvi7aTvkhPIMe7eZw0iXbMh0c4wuP6/vcImWYrT5+v41X3DR+OaK4NDTY6ajw2hAWNyEONKVJO90SWsKRUVYerR3nMcekXQZQPJ0naJUopyJUx5EIfymLL008IVZKZaG+p2l6i/8pxYIR3aQG7K4Kw+uUAzcbru7PCwEeyinQfQ2uGWnazMtVMKtX8ShgtfZfIEipLei9NQvnuFOWiiKS/sRSCQY6ZPgTGp3KfiQ0kFPOEEsNKSInH3q/mCd0V0V7gHXjokv2lUpEa3naQddU+9R3USHdruwQohk/v6CoMhOpRMYsfwI5+OzMTNc2mi/JThWKbmf6lGxHgwdulfzZL9+K7PkfsVN0w1NMFmjkqmx3U/Z1bVJAzyVM35hUsMhesR/SpibWmvSlBYVJemf3O2G2ZEGPO6Zd22dn31k+mTJ7Qi50nAUp5BsEx2QbQeSuaaooltwsWAp/b9b1L344+vgSIKutOeIAAIw9wcs054xr/W3I7jdjyyXIRP1xj1g0mXs=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cjFFV0JHQ0JMU3k2Z2EvcWVnUFRUSnk2NWhZRURMVHZrbXNNc3lTZHdJbGQ0?=
 =?utf-8?B?VVlvSld0R2R6Vm04dUhHbVhMK0MraWZvUkRPMlBkT2w4TWo0UEFKeThBT2ZP?=
 =?utf-8?B?aHBkZVBRZ1NIOVcveWc3QzV1OFZZMEJwbkQ0WlQxdElBMHlPWnNxb1hTUElp?=
 =?utf-8?B?T0tQY1dlOVNQQnMrWVJaeERTSldqUUpxcE5yVGJ1UFd0R0JXRlFnQUhUM3pO?=
 =?utf-8?B?Q1hwMTgyZGJJUFREYWRkYjZpR0hPMGZMTjI2RmUrNzN2OWQwcU5VdkpCd3U4?=
 =?utf-8?B?VktHVWRucjU4WEhadndLamM4OThsUjNZTGd3WUlEWHhETGxRakVyK3pOakJN?=
 =?utf-8?B?aVZGaDhsK2V6Z2xiOXd2YXVDT3Q3MlZvZlFKaUtmVzVpaWtFSUxnR3VkKy9I?=
 =?utf-8?B?YndWU1RYWmRXbkp0TG51b3VRU0VnZG9saXBkM1dqN21UWmVnamZhMFZWMTlq?=
 =?utf-8?B?bkc5WGp4dXk3dkcwTDVVaS8zMWU4SmxJekd0S2F5d0ZyRHhQcWdmQXh3d0Zz?=
 =?utf-8?B?ZFBqeUJGZmJBcHhVamlFY3JZdHExcldYWlVaMlFiK0xvbTNpSUQ1ZDNTWFJS?=
 =?utf-8?B?VjhaN2pCSXgwQmJmOTNib3doK2p3RW9WNDZtM3pOc09lLzVYOFdZVXhXNjVL?=
 =?utf-8?B?V24ya2MwQ011UmhtRmtGZ244ZjhtQ2N3cGgwSVJpbU44TEFmRHYvYm9Jc2hy?=
 =?utf-8?B?alFFeG83UnhlWFRsMGc4KzFodlphTmxkNm5XWk5VVGFRQ2p1TkdBL29GUW5P?=
 =?utf-8?B?NG9WRWZXZE5HWWdhRnJkK3FGNWNlTUltbWZlK05FWGxNMGxueUlFL2k0cG9T?=
 =?utf-8?B?NFpodUZDdDVOU2Z4YkRjdVNBRy85VVpnOVRiSzlTUjRWR0xOcDYwV2xoTmJ6?=
 =?utf-8?B?ckZiQjVYS1RxdVlQUFEvUFdKUnVJU0dlTGtFd0U4R3JsdmZvRk9iVmh2SkFH?=
 =?utf-8?B?ZGwyTEtwZVB5OUpoRkZUa0cvMFVuVEx1UUlYeXg5WmFLdk1JTnRvdTE2NHJ2?=
 =?utf-8?B?b0djSlV4Wk11c3JocXJrYm1qUGhtbEZmYkNBOGw2c3k2byszRm5lMHRPcEM3?=
 =?utf-8?B?aThYVmUzL3g1ZzRZTkhXSlgxbkwwMWdSL0dIaDIvR0dMUGFHSzJrQnpTWTlk?=
 =?utf-8?B?UFZmbHZsRTV2dC9PWTB2aDI3MFFzU0RDcHA4WGVVUlVBeWI4OGUyeWtDQW5G?=
 =?utf-8?B?UlhIWVQ2K2pEbWV2QUYrZXpBN0pzakoycWM4aElGZWdGSnB2VEFWZUNkMVZa?=
 =?utf-8?B?WkpMeTkwQUoycFUyclZER1hONFdXYkxIMHA0dXFrQkxPdmdrbjNkVGVPRmpm?=
 =?utf-8?B?OVZIRmdjdmI1Z3FwUElOR3U2Rm1jZzltNUF3RjFSemYvSnl6aXBpMEkwdzFp?=
 =?utf-8?B?SkdraFNjSmo4OE5YbnhJTWlwbkNwckk5OC9WSzk2ZGVHeWRGS0V3SklpVGRG?=
 =?utf-8?B?ZjRyMG9TYlY1RUdqblYzUkJweFJKYmZYRnB4UCtCYm4zN0trc0xSTXMwbFJZ?=
 =?utf-8?B?ZWRPNXBMa0k5QjVtZWh5bXcwNkJwZkhwVFl1UFNLZ1dHU2VISWUzeG5pRTVJ?=
 =?utf-8?B?YlBwUEkvamV6dUtDSmZkNUpYSWFrdjF0dXFDQzB5TUM2R0tQbkI0MlRtWVdY?=
 =?utf-8?B?SUl3bXVCQjhNTVExSDh1SW5uS2QzSXhDa3pXMlE2UlhqMGZ3UjdYUVJhMWJw?=
 =?utf-8?B?NWg2WEtvQTRJVGdhQktveEhDRnowemszSTVNM1ZMODFFVUFSRys4WW5YZHpY?=
 =?utf-8?B?cDE2M3lQeWd2QmFhYm9QclNUMEZaZ3BjdWhaUHMxT3YwQWQvVGw4NlpYYUhQ?=
 =?utf-8?B?MGpuSWk0UXd6Q3FiTWJiMXRDWDQycGJrNkNQVVJmQUN5OXF3c0tOVDdOR0RY?=
 =?utf-8?B?RzFPYTYzZDF3Mm1PUEZ1eE5EUU9tQ1RpUENON1Z6dmhsUHZvNnVJRjhMR1NM?=
 =?utf-8?B?Y29sOHRxdWZCSjk4cUsvaG9pRDkvOTJmT0F6bm1DQSt5NzNZTGE5SFBJQW5h?=
 =?utf-8?B?QXg3N0pCcHVQYmtoV2FkeFlxS1MwTGgrcXVSVm0yVG1qZkxxdlJCNFY4eUFP?=
 =?utf-8?B?T0x4OFZoMTNrZ2NyUUYzbU9GWEZsM3hiaFBrS1NPY3h0KytuOGRoYTZxWjRP?=
 =?utf-8?B?VFVyRDEwQ09LdDNDeE5mTU0yMjZXeWtiREhyaXhsYTFDZHorbEtweTR0bzlY?=
 =?utf-8?B?R2o5elEvbjgrNC95eVhJMkx3YzhCWVE3ZHZjRUkwUmJKQ1EweEIyUWhtcW8z?=
 =?utf-8?B?YkJxNDhoSDArbHY0bis1SUhlelNuUUZQdlRMWFJoU1JVRm1uUlRmQ3hFUXNi?=
 =?utf-8?B?NkQyNjBxeW15Y2h4d0l4dlp3TS9Ha1ZMS2Zmc1pqNHdNQU0zMzFoNDEvcW11?=
 =?utf-8?Q?eeVXd9KB1tGbnK0w=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A42DB95F857E8543AA8649BE9AE58003@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8955b231-7a52-4d10-6b21-08de9a2b4298
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2026 13:39:32.3806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3805bjWGqAkd7tCZgEXLYo6IYK6RsfdmPGnIILcKyhascRaPXO9u6Usw/10wFgJTJgUZdrXj9J26yhGTgLfJEJzjXsaJ1P2fU+HVgDa3Flc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF55C5E51F2

SGkgQ29ub3IsDQoNCj4gPiDCoA0KPiA+IMKgcGF0dGVyblByb3BlcnRpZXM6DQo+ID4gQEAgLTE2
MSw4ICsyMjIsNyBAQCBwYXR0ZXJuUHJvcGVydGllczoNCj4gPiDCoMKgwqDCoCBwcm9wZXJ0aWVz
Og0KPiA+IMKgwqDCoMKgwqDCoCByZWc6DQo+ID4gwqDCoMKgwqDCoMKgwqDCoCBkZXNjcmlwdGlv
bjogVGhlIGNoYW5uZWwgbnVtYmVyLg0KPiA+IC3CoMKgwqDCoMKgwqDCoCBtaW5JdGVtczogMQ0K
PiA+IC3CoMKgwqDCoMKgwqDCoCBtYXhJdGVtczogOA0KPiA+ICvCoMKgwqDCoMKgwqDCoCBtYXhJ
dGVtczogMQ0KPiANCj4gV2h5IGlzIHRoaXMgY2hhbmdpbmc/IFdhcyBpdCBvcmlnaW5hbGx5IGEg
bWlzdGFrZSBhbmQgd2hhdCB5b3Ugd2FudGVkDQo+IHdhcyBhIG1heCBvZiA4IGJ1dCBvbmx5IG9u
ZSBlbnRyeT8NCj4gDQo+ID4gDQoNCg0KVGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KDQpJdCB3
YXMgYSBtaXN0YWtlIEkgbWlzc2VkIGluIHRoZSBkZXZpY2V0cmVlDQpiaW5kaW5nIGZvciB0aGUg
bWNwNDdmZWIwMiBkcml2ZXIuIFRoZSBwcm9wZXJ0eSBjb250YWlucyBhIHNpbmdsZQ0KaW50ZWdl
ciByZXByZXNlbnRpbmcgdGhlIGNoYW5uZWwgbnVtYmVyICgwLTcpLCBhcyB5b3Ugc2FpZC4NCg0K
U2hvdWxkIEkgc2VuZCBhIGZpeCBmb3IgdGhlIG1jcDQ3ZmViMDIgYmluZGluZyBmaXJzdCBvciBj
YW4gSSBjb250aW51ZQ0KdG8gcmV3cml0ZS9zcGxpdCBtY3A0N2ZlYjAyIGRyaXZlciBpbnRvIHRo
ZSBjb3JlIG1vZHVsZSB3aXRoIEkyQw0KcHJvdG9jb2wgZmlsZSBhbmQgaW5jbHVkZSB0aGlzIGJp
bmRpbmcgZml4IHRoZXJlIHRvbz8NCg0KQmVzdCByZWdhcmRzLA0KQXJpYW5hDQo=
