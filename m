Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013004.outbound.protection.outlook.com [40.107.201.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A783D7D83;
	Tue, 21 Apr 2026 14:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776780704; cv=fail; b=E8DQ8WURky1mkaphVZctO7aGsXiEj9H0PLmx3p/tefPaP2VsrbGCoKg3NtYUSS5Zan1n+z2xodjuW8wE8Y3ykTEsB883RTujfELjgWs1k6jCHWKBAdZgXrc1lYuhPR+nqvU//jTuFtRatqZ0OQmfN57vmm7YI16w3d5qcGk6Sv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776780704; c=relaxed/simple;
	bh=V9nqz5aZu+GKw4/jXJgUhMTgdJPmBWmt5UtZ2uA0rvE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DTzFEy5z6Usg2MJpyjs4uREcJUr4PuAl1FYd7mLVfEQgE7NkkjvVkyKpEc/vSPfiAGy/VLAQ27mmv+ijLk2r8i2iDhiIjDXfMOZfl8Hf2jyVUPSzI1dYY3gY6C2n1vV3aAyUkqQbQAUsVZ+jv6xQtoTWCFa0nEDfxPpgKB+Q7Mo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=oWk5wyPu; arc=fail smtp.client-ip=40.107.201.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="oWk5wyPu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfXWqehtTo/Nzzz8SH2hBa9S8AmCIF4Ud0RWGvdgWRPnyC8cExCkAlmlxb5eenm6ITLw86s8CKlGNRsvEyBMKyneBwBlPBBM2EIRpa1LOAYuk6PvP73byD/VPSa3RFnKvxdzASykTkAR5lDcHFG6iRt6OIbyFUd+0JCBS2FSaAVWC/5oNAo44Ib09GQA/WIEc4m4ekbobYb9TfPsUQKX6w9VyzJc5GRaYvcgcHI7Yy+6KzBAq/SPPXnpj5q64DTSHTGZnPK4X4EeAZkvrW83m6xEWQa86e4tLc2mU8iWbIcDRYOW+YHlUpcbW6HlkEA3jlojhWdATfSV7ss0KQfDAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V9nqz5aZu+GKw4/jXJgUhMTgdJPmBWmt5UtZ2uA0rvE=;
 b=X8p2LU24+xhVKR1yAY6tEPmFwkdeNZLqJYAlCGRE72JM0RTfcvT91NduafMSeMqQw3FMN50aLqIDvRrXNr3ppBe0qnoZeOFZdC6Wq1sfxHi5D/HXWlroDkX+vLoQ4u58F3UO9Xgf+P0ZWaBP1CcvekTzBrlSgmyMXB4k38I4IYb5C7JVgAtP+QbVPr4qJnHzD7NJXY5J73g1IKNtukzCMqIaRDKUW/3OQkfiMNanEgYux27zqYUo4pq6UUIr3yOSn1N1xceH5JJFo4XRM+oqK1GG2B+0sLiR7xSylNJhBEQ+dTyLZc2/ebivlretDwSUGbiM1cdHXccjrsLyqQ6cVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9nqz5aZu+GKw4/jXJgUhMTgdJPmBWmt5UtZ2uA0rvE=;
 b=oWk5wyPutM75dfYItrvVYPq+hRiAiRv1Zd4H+jbqF/wOfkAxzmZHxbbd0naex0DlznFb4XAwXt8mNng9QHq0WmLp3Gsk/M3nGtzZWQKzJVhwhYUIREomJ4W+M1EQV07wm8kszU9WREOwscgC2QphRulGkxsUIpPRK8t8l0onLuCv4XxeS6xdXvpxe2/HmDpDRJ+CHmUOJcx+ywEUDgXP3EkotxClNHboaTn1tshSu3lZOU7i+Ftgk7BUWaWebFzPh2dXPpQNDs9KqV7sISoDt1sJ8s4NswXK54c3KpT4ytxBQ+i7Zt+08hFnPhneNB2f/rUrl56aZZJo60w6Ig73OQ==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by PH0PR11MB5806.namprd11.prod.outlook.com (2603:10b6:510:14b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.16; Tue, 21 Apr
 2026 14:11:38 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%3]) with mapi id 15.20.9846.014; Tue, 21 Apr 2026
 14:11:38 +0000
From: <Ariana.Lazar@microchip.com>
To: <robh@kernel.org>
CC: <dlechner@baylibre.com>, <Conor.Dooley@microchip.com>,
	<nuno.sa@analog.com>, <Jonathan.Cameron@huawei.com>,
	<devicetree@vger.kernel.org>, <jic23@kernel.org>, <krzk+dt@kernel.org>,
	<andy@kernel.org>, <linux-iio@vger.kernel.org>, <conor+dt@kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: iio: dac: mcp47feb02: Fix maxItems value
 for reg property
Thread-Topic: [PATCH v2] dt-bindings: iio: dac: mcp47feb02: Fix maxItems value
 for reg property
Thread-Index: AQHczm+DOeKvwYNIyUKaQLW302v1kLXoEDMAgAGEdoA=
Date: Tue, 21 Apr 2026 14:11:38 +0000
Message-ID: <8a57341539af3a96ad42004be2389370b76a1a56.camel@microchip.com>
References: <20260417-mcp47feb02-fix5-v2-1-6592ea499cce@microchip.com>
	 <20260420150116.GA2486072-robh@kernel.org>
In-Reply-To: <20260420150116.GA2486072-robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|PH0PR11MB5806:EE_
x-ms-office365-filtering-correlation-id: 18e006bf-5241-4d97-c985-08de9fafe7ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700021|22082099003|18002099003|56012099003;
x-microsoft-antispam-message-info:
 vR08v/PB+5nKO3qLcyW08Nz3Hhv2yDdCThwt0PlmcsMeyAmLJjjQSPTExDSHsTXuw068+pzDGNdiv3iQlYSK3cnIV29qZfNRINmoOWQ4lTctiHoml3x6VQ19i/gK2xhoq8X5bUw1N+/rbNaltgMtG2v85Z2YhuE2IZ2xNKJw/u3xANccl+R3BwcRo7EWPYzKAcDFYenyBwr97oLRhD5vYAx9VdMBt3yHTmy/sT+IzdVLbI7+MgCLLNhEM95N8923OdVJBn19AIw3bkcPkOFTcqvl/yqE2x1mBaCiI4e3QyYPB4mMkpWdLOt8KQeDSzvjqjlgc4UMcw1dpODGkfQLoOso0hKMeiqZcRDspT+GUDn7qyzlhqkqrnCESV81iWAdwl/MNeTz3Fy9zCGlWl9jYdNjpYSVx214Ucg+47bUMiXdutAlRSAU1hsi4Iw8z4fGKM03q4sc0C4QwZOTG7jsfZb5Qy1QQ/mfjfg1NGc83pz+qRiZpZ/k4QcCQLYyb4EEBIMA/7/j4t4wiQKUGU2MKeY/aJ+0LA4EEMuqb4gPaBPQj1jwfC6sTrpLEu8vAO7mYVX0hLfMTEa9g2sMGJvk/asoKono3HIzQuWEYB3//ytH2cmQr69cUEuzmVxAtgrx93WmD5C3r/vN/In1hGGGhL0e8k1FHqh0Wqyv64gzlw1utzy4ONAZ3Q1KVcU9bk5WLLhqPJjQLQWjoL8Q/bU3ChvgtYXwDLsLN0GC9JM/zE4w5XT+L+lYOAkb4ryKgb9YtIGNW4SIUuUtYOekAsCUptINQRIvl0MCGTBypEjnFzk=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700021)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VStKRW9CK3I3b0tzbnI0T2NvRkZqd1hzU2l6QWsxZllwYkplZXdtVHdGU3pj?=
 =?utf-8?B?SUsxUFpUTC9DcG43amQ0L08zVkozZGJ4czFtbDhEVnQ0YzJKVndBbDFOK1Np?=
 =?utf-8?B?MUJYc202UHg5OUoxYmNJcXJ5STZPc01tWGdIejRHSzBKMlp4SGlFTVZqU0pp?=
 =?utf-8?B?eUs3RXNNblNWNERzQi82dC9MdTlxV3o1azg3Ui9hdXUwazcrdjdPMi8weE1G?=
 =?utf-8?B?Yy9rRi9QRnU0T0t4VVZINE1oUTRZN2NJRGxIV0xBdkRpaCt3ZVcwMDd1RkpO?=
 =?utf-8?B?Tm1rU3NvcDZOOGlrRW5LZUpzclpML3NsRVlOWnNCd1ZqeHdMZ0IvYlRNS0V6?=
 =?utf-8?B?bm80QldsSGlVbGxUM0tZckJMZTdJckRnUTJndHZGcVBaYWE3WTJrL1BCWG5E?=
 =?utf-8?B?eDZJeW1GaXZYcFBoaXZjT0FsSzJ1ZW84b0lCa3puY3BUYjE5ZlVIaDFJbjFu?=
 =?utf-8?B?bDRGZU4rNkdnTmRFY29uTkpBZnlYcEZKMVUvV3lUQm1RY1pnYjRVZ2lZeXor?=
 =?utf-8?B?andRcUgwZEp0bXR5Q3dlNTV1bkk5ZkJHRTMva2FtVjhpbmQ1Q0ZNWWRYZlFW?=
 =?utf-8?B?cWlNaVVKNFRWNG1NUlRNamdONkxEaXducU1UaHdpSUJrOUo2ZmNkZ2lNWlN2?=
 =?utf-8?B?cjZZOTU0T3Vlbm0xWmx2cFYrc2lTeHBuT3dHVHJ6dlNUdVVzcjl2WklXWWRD?=
 =?utf-8?B?L0NPano3S0NZdXpVSGVkVVNmNHprVjJvYm1weHQ4b1A0Sy92REZ6VHFENnJT?=
 =?utf-8?B?QWpUL0IwUEl6VGh1WWJ0aXZaSjlqbW5lNUY3SnJFQ0ZxenF3ZU9jOCsxYk13?=
 =?utf-8?B?RGhTMjlKRCtKZElqSytCQUtRWGFuSnpwK05vTnV0ZHk5RXB1dmFNQlRuM0Uy?=
 =?utf-8?B?aDdYMEZ4VnM0d20wZ2xUZ3p3SGxVaEpyaGJVZjBjajZlZFVQaUtHL1hCd0tR?=
 =?utf-8?B?WWQ2K1hEUGIxckZrRFdaVWlxYzBIN3lrWk9QMkNWNlVZYTFBMzAxOHVUNVRp?=
 =?utf-8?B?YVBPMlM3M1BQZklza1ZLaHF2Nmc4dkEyZGViZ3RMT2xab2FwaVFyalByVmU5?=
 =?utf-8?B?ZkRrajRPd3JFTDZtNkR3STVRMUxDem1mTVEvcmwyVGZoMjJmNWZrUzdaRng0?=
 =?utf-8?B?T1FmYm96bUNOM0VTS2N5Y3ByOS9UOGhjTTJzbDBKM1hzWEFtSVJaK09pOEVE?=
 =?utf-8?B?b3UzVnhBZm4xSktmaHRSM2VSc3NjZ3k1RlV3WmJERjgwWlVDa1RHdEZGNGVE?=
 =?utf-8?B?eEJOMENXUUFWeUQzWmVlVHBCKytCUDROem9WbXFmTWM4RjdaNFg3ZlBZMkpp?=
 =?utf-8?B?a2NMZjFhVFl3RzhpSXdHMThyL0NLYS9jK2h5aGNObGt2VlEreksxWm5peVNJ?=
 =?utf-8?B?L1ZXWC9GeXNPb25vbUx1bVB1MGM4dkJWWm1ITy9DVlppQkFNN0NTSks2Q0kz?=
 =?utf-8?B?SG1DeWZoRzgxMWVwNU93V0J5OXJxYVdHUURPRzZxaHJHZHdEcFlabnJ1Zktq?=
 =?utf-8?B?NncvQTZKWTZiQmZHODkxOGZKd203VzZ0SUhQWE03Z1FPUnRBZTI2aEthZHRs?=
 =?utf-8?B?T2VTTGNyYWgxREd3b3YrbHpBKzVHYVRMQ3VQWmFOd3VGV09SSHYvcU5jS2pJ?=
 =?utf-8?B?cEIzUVI5eVhCSFUrRHlEdFRaZUxXRHFYQ0sveFhaVXJBeFpFTWV2SEJvbVhL?=
 =?utf-8?B?YVFaaVpTWTFPeXJOTm5EY0poNnNQbi92ZWlRUmFQQW8xRXR6czJ3ZmJUTThv?=
 =?utf-8?B?QVlWYzVoRGliREtKcGlVNUxxL2dqdE80NkVGUkw2Z3U5dVlRc0dwOVdqQ1lF?=
 =?utf-8?B?U09VOW9NaGR5ZHdQRExqbVJCbmtrQ0sxaEpSMkg3MTBTamUwSWQwUU1aajAx?=
 =?utf-8?B?Y2xyOEpEQzF1UGl3ZFN6dUlHZU1iTk1zOFVXWW9YQklrOU8wajZVbDMwc1M4?=
 =?utf-8?B?aFdhTE9QeHF5bVp5YUFoNFNYcnBQZmhhWG45aU5seHdaTm5nMnZuN05YS25p?=
 =?utf-8?B?S0Zic3UrL0R1bFBCNXk3bVR6emdRUEtZM3dMekdUWkplNHhBZStJTHVrNWMy?=
 =?utf-8?B?ZUxIbnUxakFMMWt1UlhKYUVpSEpERkd2WXJHaVk2aHRQeDUzdllqemhFVVQ0?=
 =?utf-8?B?alJQeUhudlRrK3o3bkhERGZkZk5taG1jL1RZQjU1R29EeXMyQnpWdVdtL3RV?=
 =?utf-8?B?NkdhdXR6Q29ML01uOURIdCtrSVVqQkJIekQrWHVobWY4b3F6UE5pbjU2aHQr?=
 =?utf-8?B?dUlnaTlPUkRLSERsckpBNllVdTQwK1ExQ3hyNFdlMmd2WHhaWVQzR1pZZVpN?=
 =?utf-8?B?REtVYnFaVVN2VFFSWU8vemM2aVJsMSt6N3d3UTZxaFV0YjVxTDBIRWZyVk91?=
 =?utf-8?Q?KJmBPnlIxEVt0KfY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <50C7CFCBD152664FB6D149FF55470BE3@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 18e006bf-5241-4d97-c985-08de9fafe7ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2026 14:11:38.7491
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88s+D2HwqQpA3ID1IXmACzoB9nWo1ZkmKD7s3RLLg3KceTW4AzWsOjblkug3y1z0zPUEfDB68qTxg9+ts3QzCtsYel0ELL0JOkZglrPqXpo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5806

SGVsbG8gUm9iLA0KDQo+ID4gQEAgLTE2MSw4ICsxNjEsNyBAQCBwYXR0ZXJuUHJvcGVydGllczoN
Cj4gPiDCoMKgwqDCoCBwcm9wZXJ0aWVzOg0KPiA+IMKgwqDCoMKgwqDCoCByZWc6DQo+ID4gwqDC
oMKgwqDCoMKgwqDCoCBkZXNjcmlwdGlvbjogVGhlIGNoYW5uZWwgbnVtYmVyLg0KPiA+IC3CoMKg
wqDCoMKgwqDCoCBtaW5JdGVtczogMQ0KPiA+IC3CoMKgwqDCoMKgwqDCoCBtYXhJdGVtczogOA0K
PiA+ICvCoMKgwqDCoMKgwqDCoCBtYXhJdGVtczogMQ0KPiANCj4gUGVyaGFwcyB0aGVyZSBhcmUg
OCBjaGFubmVscyBhbmQgJ21heGltdW06IDgnIGlzIHdoYXQgd2FzIGludGVuZGVkPw0KDQoNCg0K
VGhhbmsgeW91IGZvciB0aGUgcmV2aWV3Lg0KDQpJbmRlZWQsIEkgbWlzdGFrZW5seSBzZXQgbWF4
SXRlbXMgdG8gdGhlIG1heGltdW0gbnVtYmVyIG9mIGNoYW5uZWxzLA0KcmF0aGVyIHRoYW4gdG8g
YSBzaW5nbGUgZW50cnkgZm9yIHRoZSByZWcgcHJvcGVydHkgKHJlZyB2YWx1ZSBpcw0KYmV0d2Vl
biAwIGFuZCBtYXggNyBiYXNlZCBvbiB0aGUgcGFydCBudW1iZXIpLg0KDQpJZiBwcmVmZXJyZWQs
IEkgY2FuIGFsc28gYWRkIG1pbmltdW06IDAgYW5kIG1heGltdW06IDcgdG8gc3BlY2lmeSB0aGUN
CnZhbGlkIHJhbmdlIGZvciB0aGUgY2hhbm5lbCBudW1iZXIuDQoNCkJlc3QgcmVnYXJkcywNCkFy
aWFuYQ0KDQo=
