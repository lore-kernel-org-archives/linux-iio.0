Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2121.outbound.protection.partner.outlook.cn [139.219.146.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A4F3A6F05;
	Thu, 21 May 2026 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779360525; cv=fail; b=Len4mZty/2d+nMHKce1wBzejx9Te7ebtzJT3W7zfmtuUiy/F+GBYrEg8BDx7skNtFQOe1fhD7tMUDF2xjDmLHEbV/G7fOa0RknAimg8Vl1dn98pHZwGD8zZiqZPLdscSKv5/Rg8I5keWfrKDxIHW7a/pvAR2DkDORaHcwmmE/UE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779360525; c=relaxed/simple;
	bh=aykJiBh7PSytK4ATc02Irfn/uAptoYTNYnR/rKcw8H4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o9mREJVLkUbY0VJTAFukoRHzPfcK1vqjwFkzh2gpOFs3pRNxmuu+frE5P3IcZ4GRBT7gwjf1mNDx5uCpcb+lWQ20R72gPNGqaCDGuZ6Rf8EvQBeZ4Te8HBtHPD2s+yOZCHVSIA1PhfZTJs2RBQ1qRFBA8PWo6zA/6H4kW+01FH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPiZee6RIs9TJJS1EP/tvnkgFCmPcSVa9Mhn8AAcbXbpXcwjzdHtipwhXH8HRYPvEGe8SZsSdrX5ijZ/KW1gaNKP4a4lv1rsf6LnEAyXpPXAJvCuI9CMO/GbEVjUNBL5AtyS+F+9xCTu5gzMDNs0e83DtyBwMIPG3YMSA8SENC80LHTfYHFdCn9T3MjbTvgsXRwUX3hvaHHtqKBAkBFWnp6SRK7u2xNQe53Nxq1hM3fuUk0J/gRuzEoHq+T29yQP+rCuGfcvwfK0rWUetkXuJCSwKVYvN240I5SnQpZfAuBPs/jwnYeua+955JNkS4qOWpLjCMvLq3Iw3i9MP7eIqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aykJiBh7PSytK4ATc02Irfn/uAptoYTNYnR/rKcw8H4=;
 b=Z7D/a9dbU6CmVQ01F9jLHyVRlXNu9Pox20urZztLR2DJfFTCoBnNzTZ5f5ib+CGJv22M6SxaA7KFPma0DtDvjadrMQlpC5IclFJQ5GYiP2YSsUHd6/gHp4BBz1DC/Hu4Juql5iaLD4B6oGb1gt6qMsrlG0hMyh3Z4slE/byjFbRv1/67mEVdocpNJLPj5ZPui0fdcjst57b2p20ro9RfCmmIIvBrYzevwX01skHqEy+vJj9+YlYVvVHCmDRrtBkwOxcSJAu73vdByUUDsSgzMuY1opkOPrSy8EDzpJ7SeNAeSLPvcc5o3MuayFE54LJ3cbg6lbzcfIUrCLfqPqBG5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1066.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:9::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.17; Thu, 21 May
 2026 10:48:30 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::d8e2:3f39:6ae7:bdf2]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::d8e2:3f39:6ae7:bdf2%6])
 with mapi id 15.21.0048.016; Thu, 21 May 2026 10:48:30 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?gb2312?B?TnVubyBTqKI=?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Thread-Topic: [PATCH v1 1/2] bindings: iio: adc: Add StarFive JHB100 SARADC
Thread-Index:
 AQHc5p77jQOM2JwohkK7qO7svRU7q7YT+EcAgAEVtmCAABFGgIABhc1AgABkbYCAATcuwIAACRcAgAADHDA=
Date: Thu, 21 May 2026 10:48:30 +0000
Message-ID:
 <NTZPR01MB095629EB71B52C539E872D119F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20260518081852.116909-1-xingyu.wu@starfivetech.com>
 <20260518081852.116909-2-xingyu.wu@starfivetech.com>
 <20260518-elderly-barman-2b1abfc3755c@spud>
 <NTZPR01MB095679F35A873BBBA304655F9F002@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260519-undoing-ambitious-012d608ebd7f@spud>
 <NTZPR01MB095657AA216608109BEF9CBA9F012@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260520-relic-chloride-c5cdb96696ce@spud>
 <NTZPR01MB0956DC43B5D6E6EBB4F457129F0E2@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
 <20260521-growing-brunt-4e5a9f955a4f@spud>
In-Reply-To: <20260521-growing-brunt-4e5a9f955a4f@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1066:EE_
x-ms-office365-filtering-correlation-id: 3f921f64-24c3-4a92-60be-08deb7267f23
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021|22082099003|56012099003|18002099003|6133799003|4143699003|3023799007;
x-microsoft-antispam-message-info:
 baz5p599HZYJkaVzI/t15u/YhYDMvtuXtIeHikEH6riFC5O7G2o/b3vCX2HII6Dn+hssUKb20M9PxDCh5vtonXN7KXO16GP3VxoywxME7V38leksKa6YEhniRngHaJq+pBdr1gVfD3zzfeqi0q32Ro1/1cHwo7caEgsRnyjyP0KaCtkdwQ7CT/2I7BJAJK56PfiQxaZHfzaCqmelwL6a3sxLyxhB/4nb9CnpKkAJonxoY8orhv8d2x/eS+uoDsgB6jtYSaAAS2OX3eZFbyub99CwqUJ9C83qN1gjT9ep6jqB7rMTqf8jsBMUXK7JBvs0Nnab28Y8otS2mrILIolQOilqSZM98OtzNw+/MsNFXUE8dDjlVBJhOmAId5a22yjPchWLrXiOOoi1BN6oQv99pLt9zxbtNU9T6XGrThHUNYeXdpUFBtjqUHcGrIv3vfco4hLKu8+kz2uQxuje33IB9JUxH7lJmoiZKpGetgL7k3RoSxOlEAsThH6mFgC0DfTSUDG+h3F+qLJoooCkz+TLM2dE9+QzZ8RWfl56eWpJh6nka4/zmKgBYA+RScLFVSu7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(22082099003)(56012099003)(18002099003)(6133799003)(4143699003)(3023799007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?WCtyRUxmc0s2ajRzTmlCSmlKbHJyZUg2UHNTQkF3UzNOUXUxUklUMEZyT0h3?=
 =?gb2312?B?bTdDY2drcmMyZDBjZXNFaWJMTVUrK2VNeHB6VkJSQWxLNGQ3aElOTWVvSE5t?=
 =?gb2312?B?UWNUOWdjcmpMdWFCMmpTQytRa2hpZGtmdGRPdzF0d0FKVE1CanhhUGRyc3la?=
 =?gb2312?B?WUczdFR0K2cvN2FGSWZUQUJkNENBZWg0eENnamNSKzMvQ2F5aFZ6UjVEYWpq?=
 =?gb2312?B?UDh2dFpiVGhXd1QxUDFPa3VVN2JmMnBvU1RUclZqTXVTc1ZUdEN5eXg3TlFv?=
 =?gb2312?B?cVBYcHBGR0NoM2lFVFFZU1NjdnpRQ3dROER2eXlDS1E0aUw1d2ZlblRjeTF4?=
 =?gb2312?B?THZETVdrMm1vMGRQR29CUWRBbWttWFczTFZobWY2WVM2NGsrQU9DQllqRGRV?=
 =?gb2312?B?U3AwNUN6ejlKTnlQNm9XeUh1R3VsUk1velovTC9mZHJ2SzBWd2RrVGFIWXVM?=
 =?gb2312?B?d0hPYnhhdHIzZ2NCOTV6aGFScUpyUXM4SUJRR3BYdkVXNUFNa3JBNkg5VVVy?=
 =?gb2312?B?Uk93QW4vNCtkQTJod1pPM3pwMmJUTGppQkVyaWhLejlQcVRGVTNBeW5OYjJV?=
 =?gb2312?B?QWgyUnJENjlKM0YwVDdhd3d5aUhWNk1iZzVQVFY4NnFRZUFqd0pjeUZTWU1j?=
 =?gb2312?B?NFhuUGtHZDZsb0JPeUpveWhoaldMTndRdmxpL2FzeUIzZnpHTUZoMXBqWVIy?=
 =?gb2312?B?MVo1ZndCdHhwaWxQTEt4MkFhamk2Y0NQR0NSdDh1SEZrZFc3TkxVVVhLaUJL?=
 =?gb2312?B?c3N0eTJDTDNkQmtyUURBK2lySU9PMUMrZ21EQmV0dCs4WXZaMFBkQUtmbjZX?=
 =?gb2312?B?VWpEV0VaQ01xUWt0Y2E4TWQydDNieTNSM25EbkZMYkNlUG1PNVNTYlZSNUZS?=
 =?gb2312?B?RytWTklWU3k0SmJXQU5OaTJRSUdVS040VGw0K2oyQ2RqSlZFak8rWkNQbndh?=
 =?gb2312?B?K1VjUTllUFhqVXhIK1hUZ1Vhd2lqa0ZyZ3RwcnlDaTRDL0gxdlZ1WEtaSVVq?=
 =?gb2312?B?Q1NhMTI3d0JCWHNIcmo2RmtFRE43MDhaUlhGNjAyOG1hTFcvb2YrMlRFNUtF?=
 =?gb2312?B?Y2ppNHFHcjZlQUFSTGJ1M3lGaDZKeDNubW1IYkZObEppbDYrL2kvS2p4QWha?=
 =?gb2312?B?VUdzQnJoZjFzOFJhL0JYdFhmblVkV3BnenM0UmhaR3ZOenRseDI5eGhmMTB3?=
 =?gb2312?B?SXJjWW9ybUY4RTZmRzMvK2lJdXJKaXV0bG1VUHdBcTVJKzdteERDTWVOUEhv?=
 =?gb2312?B?N21lNzNGSzZQQ1lrOHU4SXhLTnZEeExQaUg0UFNYZWFPaU1WYnBGT1UwMFl3?=
 =?gb2312?B?dnNTWFFVejNMWVhoMTNZdzM0THNacDNnR1RDWE9meWRPbHVPVUlUVUE0REhz?=
 =?gb2312?B?ekl5Vk51YkNIcU1OK21yOWxXLzRFeG9xeWxmODJrbEVRdXNDdnpkU0JaRFE1?=
 =?gb2312?B?dlZaWUgvMlpVZ25jOGNZZ1BHN3NoMTlNYjNCYzVKNjVzRTRlMVpqKzlhbmtD?=
 =?gb2312?B?NjF1MzRocVNUaW80WUtVak1ZWGlpeG5LUVFSMTNjSHRUKzdlTWZtaU92WUdz?=
 =?gb2312?B?dWtoMk0rLytoVFBMSmFBaEowTHpCUFgvN0dNYTJ1d1Vya0F1K2RhdnJzUEkv?=
 =?gb2312?B?T0c1akJwaW9WS1RiUmxWaU5iZUMrSmxRdEVSQnNxZ0FwK29qOEpEZ3JoTVFw?=
 =?gb2312?B?ZXN5MDNkMU9lbS9INkZCcEtwek0vZHdIUXg5MHNUaDFDNzFZNFJMb1ZFeUt0?=
 =?gb2312?B?WEFpR3VWNW1taVFJWDJseEwzNXNKRkVmSzdGOEVJQXJ4dDByWThuaXNqMTB3?=
 =?gb2312?B?WEFsM09xaHBLU2IzeExFTUdSUGM5aVZwUFRlU1MxRm11VjlUZE40T2crZWE4?=
 =?gb2312?B?T2VQRXhtbXhyZ1c0TUt6cHpxWEM3SDQ1YmQrdGhrbHN5YkVQV0d4eEl4R2Qv?=
 =?gb2312?B?bmJlampRdmIveUxoLzNDUEJnWmp1TXgrYnByRlJCS0tWNTA5MC9DNUZ6L1l6?=
 =?gb2312?B?ZGtBckduVUFPL1JuRzBKQkF1bktJUGsrMllTNWUraXlWTXl4c0VFYmtDTmRm?=
 =?gb2312?B?VzBmMElIcHpSaHlkdERjYjNBeno3Wk1zUWtKYjRDc2g0V0VCSnJuNjc4OXpx?=
 =?gb2312?B?WEswSXlaZTc2NVVRTW44SzJBUjdHMXFQbWFuV05UL0IrZ0h2VTlmSFAzVmdl?=
 =?gb2312?B?amhmRXgxTkg0QzI2bUlrTXNJRTRnWk9tb2xtaDJtM0VZWEg3RDRqd3NZRHBq?=
 =?gb2312?B?eXVDQlVyaVppVVhsRlAza1JnVzlJYkF5bXhiYi9oTzd5UzlxTDB6Ymlia0dp?=
 =?gb2312?B?dDFBSVRDSkg2Q0xqYVZDWUJETEJXQnAwWlQ5VnZ6RnVVRU9DSEdpdz09?=
Content-Type: text/plain; charset="gb2312"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f921f64-24c3-4a92-60be-08deb7267f23
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2026 10:48:30.2267
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KqCQtfC67VT1K+/j5GnDikI6hcCgEHrd9BHrV7l49gL5rxk7QmGEuIXbXQaHiV7SVZUVwT5JuLXk+uBbElUpjg+Sjc7yUW3Q1f4IgBLEkHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1066

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQ29ub3IgRG9vbGV5IDxj
b25vckBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI2xOo11MIyMcjVIDE4OjIxDQo+IFRvOiBYaW5n
eXUgV3UgPHhpbmd5dS53dUBzdGFyZml2ZXRlY2guY29tPg0KPiBDYzogSm9uYXRoYW4gQ2FtZXJv
biA8amljMjNAa2VybmVsLm9yZz47IERhdmlkIExlY2huZXINCj4gPGRsZWNobmVyQGJheWxpYnJl
LmNvbT47IE51bm8gU6iiIDxudW5vLnNhQGFuYWxvZy5jb20+OyBBbmR5IFNoZXZjaGVua28NCj4g
PGFuZHlAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+OyBLcnp5c3p0
b2YgS296bG93c2tpDQo+IDxrcnprK2R0QGtlcm5lbC5vcmc+OyBDb25vciBEb29sZXkgPGNvbm9y
K2R0QGtlcm5lbC5vcmc+Ow0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZzsgbGludXgtDQo+IGlpb0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MSAxLzJdIGJpbmRpbmdzOiBpaW86IGFkYzogQWRkIFN0YXJGaXZl
IEpIQjEwMCBTQVJBREMNCj4gDQo+IE9uIFRodSwgTWF5IDIxLCAyMDI2IGF0IDA5OjU0OjI3QU0g
KzAwMDAsIFhpbmd5dSBXdSB3cm90ZToNCj4gPiBPbiAyMDI2LzUvMjAgMjM6MTUsIENvbm9yIERv
b2xleSB3cm90ZToNCj4gPiA+DQo+ID4gPiBPbiBXZWQsIE1heSAyMCwgMjAyNiBhdCAwOTo0Mzow
MkFNICswMDAwLCBYaW5neXUgV3Ugd3JvdGU6DQo+ID4gPiA+IE9uIDIwMjYvNS8xOSAxODowMCwg
Q29ub3IgRG9vbGV5IHdyb3RlOg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gT24gVHVlLCBNYXkgMTks
IDIwMjYgYXQgMDk6MjY6MDNBTSArMDAwMCwgWGluZ3l1IFd1IHdyb3RlOg0KPiA+ID4gPiA+ID4g
T24gMjAyNi81LzE5IDAwOjI0LCBDb25vciBEb29sZXkgd3JvdGU6DQo+ID4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiA+IE9uIE1vbiwgTWF5IDE4LCAyMDI2IGF0IDA0OjE4OjUxUE0gKzA4MDAsIFhp
bmd5dSBXdSB3cm90ZToNCj4gPiA+ID4gPiA+ID4gPiBBZGQgdGhlIG5ldyBkb2N1bWVudGF0aW9u
IG9mIFNBUi1BREMgZm9yIHRoZSBTdGFyRml2ZSBKSEIxMDAgU29DLg0KPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWGluZ3l1IFd1IDx4aW5neXUud3VAc3Rh
cmZpdmV0ZWNoLmNvbT4NCj4gPiA+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4gPiA+ID4gPiAgLi4u
L2lpby9hZGMvc3RhcmZpdmUsamhiMTAwLXNhcmFkYy55YW1sICAgICAgIHwgNjIgKysrKysrKysr
KysrKysrKysrKw0KPiA+ID4gPiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNjIgaW5zZXJ0aW9u
cygrKSAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+ID4gRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvc3RhcmZpdmUsamhiMTAwLQ0KPiA+ID4gPiA+ID4g
PiA+IHNhcmENCj4gPiA+ID4gPiA+ID4gPiBkYy55DQo+ID4gPiA+ID4gPiA+ID4gYW1sDQo+ID4g
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0DQo+ID4gPiA+ID4gPiA+ID4g
YS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvaWlvL2FkYy9zdGFyZml2ZSxqaGIx
MA0KPiA+ID4gPiA+ID4gPiA+IDAtc2ENCj4gPiA+ID4gPiA+ID4gPiByYWRjDQo+ID4gPiA+ID4g
PiA+ID4gLnlhbQ0KPiA+ID4gPiA+ID4gPiA+IGwNCj4gPiA+ID4gPiA+ID4gPiBiL0RvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9paW8vYWRjL3N0YXJmaXZlLGpoYjEwDQo+ID4gPiA+
ID4gPiA+ID4gMC1zYQ0KPiA+ID4gPiA+ID4gPiA+IHJhZGMNCj4gPiA+ID4gPiA+ID4gPiAueWFt
DQo+ID4gPiA+ID4gPiA+ID4gbA0KPiA+ID4gPiA+ID4gPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gPiA+ID4gPiA+ID4gaW5kZXggMDAwMDAwMDAwMDAwLi5iYThlMTliNzJhZDcNCj4gPiA+
ID4gPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+ID4gPiA+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2lpby9hZGMvc3RhcmZpdmUsag0KPiA+ID4gPiA+ID4g
PiA+ICsrKyBoYjEwDQo+ID4gPiA+ID4gPiA+ID4gKysrIDAtc2ENCj4gPiA+ID4gPiA+ID4gPiAr
KysgcmFkYw0KPiA+ID4gPiA+ID4gPiA+ICsrKyAueWFtbA0KPiA+ID4gPiA+ID4gPiA+IEBAIC0w
LDAgKzEsNjIgQEANCj4gPiA+ID4gPiA+ID4gPiArIyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjog
KEdQTC0yLjAgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ID4gPiA+ID4gPiA+ICslWUFNTA0KPiA+ID4g
PiA+ID4gPiA+ICsxLjINCj4gPiA+ID4gPiA+ID4gPiArLS0tDQo+ID4gPiA+ID4gPiA+ID4gKyRp
ZDoNCj4gPiA+ID4gPiA+ID4gPiAraHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvaWlvL2Fk
Yy9zdGFyZml2ZSxqaGIxMDAtc2FyYWRjLg0KPiA+ID4gPiA+ID4gPiA+ICt5YW1sDQo+ID4gPiA+
ID4gPiA+ID4gKyMNCj4gPiA+ID4gPiA+ID4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+
ID4gPiA+ICt0aXRsZTogU3VjY2Vzc2l2ZSBBcHByb3hpbWF0aW9uIFJlZ2lzdGVyIChTQVIpIEEv
RA0KPiA+ID4gPiA+ID4gPiA+ICtjb252ZXJ0ZXIgZm9yIHRoZSBTdGFyRml2ZSBKSEIxMDAgU29D
DQo+ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ICttYWludGFpbmVyczoNCj4gPiA+
ID4gPiA+ID4gPiArICAtIFhpbmd5dSBXdSA8eGluZ3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+
ID4gPiA+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ID4gPiA+ICtwcm9wZXJ0aWVzOg0KPiA+ID4gPiA+
ID4gPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gPiA+ID4gPiA+ID4gKyAgICBjb25zdDogc3RhcmZp
dmUsamhiMTAwLXNhcmFkYw0KPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArICBy
ZWc6DQo+ID4gPiA+ID4gPiA+ID4gKyAgICBtYXhJdGVtOiAxDQo+ID4gPiA+ID4gPiA+ID4gKw0K
PiA+ID4gPiA+ID4gPiA+ICsgIGludGVycnVwdHM6DQo+ID4gPiA+ID4gPiA+ID4gKyAgICBtYXhJ
dGVtczogMQ0KPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArICBjbG9ja3M6DQo+
ID4gPiA+ID4gPiA+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+
ID4gPiA+ID4gPiArICByZXNldHM6DQo+ID4gPiA+ID4gPiA+ID4gKyAgICBtYXhJdGVtczogMg0K
PiA+ID4gPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiA+ID4gPiArICAiI2lvLWNoYW5uZWwtY2VsbHMi
Og0KPiA+ID4gPiA+ID4gPiA+ICsgICAgY29uc3Q6IDENCj4gPiA+ID4gPiA+ID4gPiArDQo+ID4g
PiA+ID4gPiA+ID4gKyAgdXBwZXItYm91bmQtbXY6DQo+ID4gPiA+ID4gPiA+ID4gKyAgICBkZXNj
cmlwdGlvbjogVGhlIHVwcGVyIGJvdW5kIHZvbHRhZ2UgdmFsdWUgb2YgdGhlIG1vbml0b3IuDQo+
ID4gPiA+ID4gPiA+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9u
cy91aW50MTYNCj4gPiA+ID4gPiA+ID4gPiArDQo+ID4gPiA+ID4gPiA+ID4gKyAgbG93ZXItYm91
bmQtbXY6DQo+ID4gPiA+ID4gPiA+ID4gKyAgICBkZXNjcmlwdGlvbjogVGhlIGxvd2VyIGJvdW5k
IHZvbHRhZ2UgdmFsdWUgb2YgdGhlIG1vbml0b3IuDQo+ID4gPiA+ID4gPiA+ID4gKyAgICAkcmVm
OiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91aW50MTYNCj4gPiA+ID4gPiA+ID4g
PiArDQo+ID4gPiA+ID4gPiA+ID4gKyAgc2Nhbi1mcmVxOg0KPiA+ID4gPiA+ID4gPiA+ICsgICAg
ZGVzY3JpcHRpb246IE51bWJlciBvZiB0aGUgc2NhbiBjeWNsZSBpbnRlcnZhbC4NCj4gPiA+ID4g
PiA+ID4gPiArICAgICRyZWY6IC9zY2hlbWFzL3R5cGVzLnlhbWwjL2RlZmluaXRpb25zL3VpbnQx
Ng0KPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBDYW4geW91IGV4cGxhaW4gd2h5IGFueSBv
ZiB0aGVzZSB0aHJlZSBwcm9wZXJ0aWVzIGFyZQ0KPiA+ID4gPiA+ID4gPiBzb21ldGhpbmcgdGhh
dCBzaG91bGQgYmUgaW4gdGhlIGRldmljZXRyZWUgcmF0aGVyIHRoYW4gc29mdHdhcmUNCj4gY29u
dHJvbGxlZD8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBNeSBpbnRlbnRpb24gaXMgdG8gYmUg
YWJsZSB0byBvYnRhaW4gdGhlIGluaXRpYWwgdmFsdWVzIGZyb20NCj4gPiA+ID4gPiA+IHRoZSBk
ZXZpY2V0cmVlIGR1cmluZw0KPiA+ID4gPiA+IHByb2JlIGFuZCBwcmVzZXQgdGhlbS4NCj4gPiA+
ID4gPiA+IERvIEkgbmVlZCB0byBkcm9wIHRoZW0gYW5kIGp1c3Qgc2V0IHRoZW0gdGhyb3VnaCBz
eXNmcz8NCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFVubGVzcyB0aGUgaGFyZHdhcmUgY29uZmlndXJh
dGlvbiBkZXRlcm1pbmVzIHRoZSB2YWx1ZXMgKHdoaWNoIEkNCj4gPiA+ID4gPiBjYW4ndCByZWFs
bHkgc2VlIGJlaW5nIHRoZSBjYXNlIGZvciBzY2FuLWZyZXEgYXQgbGVhc3QpIHRoZW4NCj4gPiA+
ID4gPiB5ZXMsIHlvdSBuZWVkIHRvIGRyb3AgYW5kIHNldCB0aGVtIHZpYSBzeXNmcy4NCj4gPiA+
ID4NCj4gPiA+ID4gVGhlIEFEQyBoYXJkd2FyZSBjYW4gYmUgc2V0IHRoZSBzY2FuLWZyZXEgcmVn
aXN0ZXIgdG8gZGV0ZXJtaW5lDQo+ID4gPiA+IGhvdyBmcmVxdWVudCBpdA0KPiA+ID4gc2hvdWxk
IHNjYW4gaXRzIGlucHV0cy4NCj4gPiA+ID4gVGhlIGNhbGN1bGF0aW9uIGlzOg0KPiA+ID4gPiAJ
ZnJlcXVlbmN5ID0gMTAwLygocmVnaXN0ZXIgdmFsdWUpICsgNSkgTUh6LCBUaGUgcmVnaXN0ZXIg
dmFsdWUgc2hvdWxkID49IDE1Lg0KPiA+ID4gPiBUaGUgbWF4aW11bSBhbGxvd2FibGUgc2NhbiBm
cmVxdWVuY3kgaXMgNU1Iei4NCj4gPiA+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiBIb3cg
YXJlIHRoZSBib3VuZHMgY2FsY3VsYXRlZD8NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBUaGUg
bWVhc3VyZW1lbnQgcmFuZ2Ugb2YgdGhpcyBBREMgaGFyZHdhcmUgaXMgZnJvbSAwIHRvIDE4MDAg
bVYuDQo+ID4gPiA+ID4gPiBUaGlzIHNldA0KPiA+ID4gPiA+IHZhbHVlIGNhbm5vdCBleGNlZWQg
aXQuIFRoaXMgZXhwbGFuYXRpb24gd2lsbCBiZSBhZGRlZCBsYXRlci4NCj4gPiA+ID4gPg0KPiA+
ID4gPiA+IEknbSBhc2tpbmcgaG93IHRoaXMgaXMgY2FsY3VsYXRlZCBzbyB0aGF0IEkgY2FuIHRl
bGwgaWYgeW91IHRoZQ0KPiA+ID4gPiA+IHByb3BlcnR5IGlzIHBlcm1pdHRlZCBvciBub3QuDQo+
ID4gPiA+DQo+ID4gPiA+IFRoZSBjYWxjdWxhdGlvbiBvZiBib3VuZCBpczoNCj4gPiA+ID4gYm91
bmQtbXYgPSAxODAwbXYgKiAocmVnaXN0ZXIgdmFsdWUpIC8gMHhGRkYNCj4gPiA+DQo+ID4gPiBU
aGVzZSBhcmUgdGhlIGZvcm11bGFzLCBidXQgaG93IGRvZXMgc29tZW9uZSBrbm93IHdoYXQgdGhl
IHZhbHVlIGZvcg0KPiA+ID4gYm91bmQtIG12IG5lZWRzIHRvIGJlPyBXaHkgd291bGQgc29tZW9u
ZSBub3QganVzdCB3YW50IHRvIGFsd2F5cyB1c2UNCj4gMTgwMG12Pw0KPiA+ID4NCj4gPg0KPiA+
IENhbiBJIGFkZCB0aGUgJ21heGltdW0nIGFuZCAnIG1pbmltdW0nIHRvIHByb3ZpZGUgY2xhcmlm
aWNhdGlvbj8gQW5kIHRoZSBkcml2ZXINCj4gd2lsbCBhbHNvIGNoZWNrLg0KPiANCj4gQWxsIHRo
YXQgZG9lcyBpcyByZXBlYXQgdGhlIDE4MDAgbVYgdGhvdWdoLCB3aGF0IEkgYW0gaW50ZXJlc3Rl
ZCBpbiBpcyBob3cNCj4gc29tZW9uZSBkZXRlcm1pbmVzIGlmIHRoZXkgc2hvdWxkIHVzZSAxNjAw
IG1WIG9yIDIwMCBtViBldGMuIFdoYXQgYXNwZWN0IG9mDQo+IHRoZSBoYXJkd2FyZSBkbyB0aGUg
Ym91bmRzIGRlcGVuZCBvbj8NCg0KVGhlc2UgYm91bmRzIGFyZSBqdXN0IGZvciB0aGUgbW9uaXRv
ciBtb2RlLiBJZiB0aGUgaW5wdXQgdm9sdGFnZSBpcyBvdXRzaWRlIHRoaXMgcmFuZ2UsIGludGVy
cnVwdCB3aWxsIGJlIHRyaWdnZXJlZCB0byByZXBvcnQgdGhlIHVzZXIgc3BhY2UuDQpUaGUgYm91
bmRzIHZhbHVlICgxNjAwbXYgb3IgMjAwbXYpIGFyZSBkZXRlcm1pbmVkIGJ5IHRoZSB1c2Vycycg
YXBwbGljYXRpb25zLiBVc2VycyBjYW4gZnJlZWx5IHNldCB0aGVtIGFjY29yZGluZyB0byB0aGUg
cmFuZ2UgdGhleSB3YW50IHRvIG1vbml0b3IuDQoNCkJlc3QgcmVnYXJkcywNClhpbmd5dSBXdQ0K
