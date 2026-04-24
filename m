Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010053.outbound.protection.outlook.com [52.101.85.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B319C1DA62E;
	Fri, 24 Apr 2026 08:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017682; cv=fail; b=S4b8I4qgCfi1Jx70f4M/+YusSAqlirQdJ5SzYcxZHxRkwN30JsfSrH36oJlsgNCtKFduEHsHpi/9j0RtKjRM0MXU+pcpN7vTiqFZnEOmJlsoHN6isp+VNoGr/25BSs77L+RjcqnI2Qc+vwl/Y9F07NIKL0C831G1vgL/+IHfXjo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017682; c=relaxed/simple;
	bh=Hh8nCuLjLugDv/THedkuNE6s4Sx7eUtr7R1DAIftAuI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eROuZKSmS7NAEmcLXOYCvyi9PrDDZ/+phC9sdtINIk9K9mP2hdtR/RBCDCWqY24GzNxKd5RyLHEmG9xxspESB8vDYXGA/weFduauP+wLzyQ0NqCOUh5fjKn0B+lHfIrf/0g7bAgMuDDMAbI76d/KRIH7XmUeP7nmwP3/GPnFl+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BfyXaFUL; arc=fail smtp.client-ip=52.101.85.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BfyXaFUL"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJQp+zAcaK9DOVjwHf7D94/VcV63F4aj7esGV8g7aNIzck0lb5PrC3RzNkO4RzaJySZaqmDANL14v7OxGhI9IjpTKMr4KNlmFS/+1RONkfA/YamdqcKpja1EDncqrpj4BWdamJmVQDfh8c8lzadSBczJt5HOd/2huzt9qaulCQn23F1iPVxAz+6fnzmrUfYB763AVP3MSo+aB/VbfnxqDX6TwjLvAvtQ98RIeHfS+mTFS7YffcKVQq1vmM7Gmz8o2M8kLc9peGNNPg4laBPqDOXVppw618GzoFHavph4bK5/3bn0+u5BX37stbgFrSkw0BEqA/7xtAGi6GCP+RiBZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hh8nCuLjLugDv/THedkuNE6s4Sx7eUtr7R1DAIftAuI=;
 b=WpYza2k9I+dNGCfmFC7+LRhFck5UZrjx4EBsgcYTsOaGRmhEvEZMEWjQvG0jCDcgcXzMj1N+ddxC5S6903EK4l7PX2nTAInA27Umc1c8Y1jGGK1UDhaw1sOrhiSUHjihlYPJ3wXHG17LgHdqb0H7C7e63uAkqE/u4nPs5nZnnf9JGRshQNOSfh+1l+n4HZe94O+GTlXesgGUsOLPoQ8h+T79YIaKZ3E9TZykd0B20z9UOwHvEgtSoBgKtfTO+t/bLSwERQrXS+v/KQYHW/tcXZGJ0bXKJWUT6UtWv7CroK5F4gBn4IIzmSdzFP96dGcDhoVy4n1I1v1iOOmbbS1aqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hh8nCuLjLugDv/THedkuNE6s4Sx7eUtr7R1DAIftAuI=;
 b=BfyXaFULTMC9BRPIvs/0lKz2zBZUneb05AygHUFVXG8OJqS4OOYY+pJWYNvX4VREx2K1lpVkBYkp/WAgj8vYGobdwWdbydx9Ps7SChCK67F7tKkM2vK3lJnd4TvJ1u5VlAErUReAae9kkByC5S0Q50rVqo4Sh5YkiBfCWqFRJqOXstvF/5YkBx9IVK1ZSfYB+THjdwqI5+/AEt5lSG0Owz10+FGIKpTa89FC3X4Av6AydFZ4DqQT7ZKNBU8oCz5v46JckJAA/kAEZQDFJyuA84RSfZES5a4my63c9Q/Rju2CK4A7ez5D86Spbh0RbyJ1bDKAOZ2zJ/cTKeUydRVrIg==
Received: from PH7PR11MB8251.namprd11.prod.outlook.com (2603:10b6:510:1a9::9)
 by BL1PR11MB5287.namprd11.prod.outlook.com (2603:10b6:208:31b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.22; Fri, 24 Apr
 2026 08:01:17 +0000
Received: from PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c]) by PH7PR11MB8251.namprd11.prod.outlook.com
 ([fe80::e81b:3e24:1804:5c7c%3]) with mapi id 15.20.9846.014; Fri, 24 Apr 2026
 08:01:17 +0000
From: <Ariana.Lazar@microchip.com>
To: <jic23@kernel.org>
CC: <dlechner@baylibre.com>, <nuno.sa@analog.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>, <robh@kernel.org>,
	<linux-kernel@vger.kernel.org>, <andy@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Thread-Topic: [PATCH 2/2] iio: dac: add support for Microchip MCP48FEB02
Thread-Index: AQHcnB4CEkxJgPuKSkiQaY7LrEYHMrWEEUaAgGo3ioA=
Date: Fri, 24 Apr 2026 08:01:17 +0000
Message-ID: <f7f45b4327c9ce5c806cd878bd9b53e8fcbf7785.camel@microchip.com>
References: <20260212-mcp48feb02-v1-0-ce5843db65db@microchip.com>
	 <20260212-mcp48feb02-v1-2-ce5843db65db@microchip.com>
	 <20260215175857.4085bc2c@jic23-huawei>
In-Reply-To: <20260215175857.4085bc2c@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8251:EE_|BL1PR11MB5287:EE_
x-ms-office365-filtering-correlation-id: 33a8e9c2-fbed-4f6b-ce22-08dea1d7a9fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|56012099003|22082099003|38070700021|18002099003;
x-microsoft-antispam-message-info:
 ZCiveB6m30+AEB/KZUcMbFaGOFr/ly0L+9st25l26vPTcE0ib2FH7/Ptl4PvpXs1g1g6DVbh8wRgFtCFnj2uJXVMWQgD5m5jEvVJWf1jp7wLeCkk6aNSiE2vaJasQ2gnbxHIVA7Uj66f6wW1Ow3m+Ao8M6pahncbBCdP4Oeb2XrXjEj/Y3I4FgTbKKJmntU0kIBCHTl7iwyRk+gjlPiF9Moxspq3cAGxb9FUhXkW2fG4v+rqCZPJo4A4AA7ZirdGR8Vrn1P9pb13YOSPGPkcjUM04NZLlA82TpYE05638iRNVSKGJYGUaID80EG9jcDWBUMNALxfu7NR8KBFx7fVVPsWN7o272LdzW3iYYeJjcRwqynmwojK3KMzOD2Eppq+RDxC+MbMwBJ4m7DLljHpNwsoviRcDJKZTSbliHxU/3lWtvuaoomZs+qwe/4vn8Vaoho0TkkV+m8EQx/7ndvQNQclOQcKP//04ABN5u3C0I9pkPQPgmn3sW7khpW/tXHmVo/u6ck7eWkKfPUnZfbtyAAh95TlFUHkuWijYU3Cr+Z0nQcD/GH8CPuvLIQ+a3wW3DZ0jmH47S6+Btas7gYP4AHawRZAyxusaAlb9zCAzYia4MFh5RPC5QWg4WYXj8R3EA0/WrM5arWvSr3WxVmU9mG1tctJxqO5mBwLtuAltA33tncZl8yUVNFLRZ77yYlja6FXBNzSXuQDOqCMmOsl2M/6YObqig3p+FiqcG4FMH7Bx9NoOz/FMewoV5mf0dv4UjxDNbBUfpmRIk/XAqwyUBseGny4ZPsDJCm1T7OKRKI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8251.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(56012099003)(22082099003)(38070700021)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UW1ia2dZMDU5eTA2d0E5aWc1M1RkT3NhUzNFamtsWmFqZjdJTFNFTjlKb0JK?=
 =?utf-8?B?R1ZyU0x5VmJod01ESEtVdkY2MlBNMEZiRlAzcFVPQ3hBdC9RVS9WYW9BLzdo?=
 =?utf-8?B?eDBVYnl0VGtmQmtIeVR5L3YrYlFiY1V5Z0Uza1c1MFJCMk9hWTRXYStHdnFV?=
 =?utf-8?B?dWVpOFZTazhlMmlnalNWTWd3Rk9Dbm5uTktiTnliREd1TTVzTFVvWVExRnRl?=
 =?utf-8?B?WFp6L2JBN2crdUlxQy93Qy80aTFTVkNIclF0TFRaeHhpSmRSMFd0c3RlczdW?=
 =?utf-8?B?cVhaQXhkMnl2YkkzVFN0Uyt3MWR3MHRoNFR2N1JsNUJQQ2NsUmlNRGgwbG15?=
 =?utf-8?B?WGE1Sjk2VFg3Ni82YU9wUCtOYWlJdTlUcEFiUDVtekhsTS9tTFZPVjZlUkhj?=
 =?utf-8?B?dmJpaE9ZSW5IbVFtcTlRNlNwOE82VVRKM0o2TTFoRzJpSkxQQWdSK1h2anVo?=
 =?utf-8?B?ZGIzcDJXREdJQjhoVFgwaWEreVphU3ZjZlE1b1luRHdlV0dxME5hMlY5WkxU?=
 =?utf-8?B?L2thaThwdUVqd29OTnB5SkYvaXAvRklLL1BWY0tXY1ZYdHROYWtHZkt6cWpS?=
 =?utf-8?B?d0lsT0F6bWdKUlZWM0dzb1N5MUliNXBBWW1JRXBxU0tLUmgwdG9KMzN3V0VY?=
 =?utf-8?B?cHJQcTBGa2VZZGlsVitDam1Wcjl1YWZNeG8zd3VwNG1vdDA4VVQ4eFlaQVc3?=
 =?utf-8?B?a1lWd2NrcG50RGRVek1qVkJTK09RVlJoZHhBdDVVUkhqVnBmZFBDQXpZaC9O?=
 =?utf-8?B?cmg4WnNsb1pvYndraTFRdlhYdXM1ZnlJK2VlMTBvd3dTbU5SSStPeVFTK28z?=
 =?utf-8?B?OUx4cWh0MFlOMHAxRzNxYW9GbUd3R0x2OXhiQ05nU3ZHREp3UjN5TUdOMTNx?=
 =?utf-8?B?aU5zNUNrdDlwUnlCK1pRNE9tV3k2RWRWTlJ1NDFtMTRjcEErZGRXUU9mOGNo?=
 =?utf-8?B?TC9uUkF6TEw2cENSanNCbnFpNVkzYldBcWhwc3NBUmFpaGRTUjZvdkdQYnpQ?=
 =?utf-8?B?ekczSUgyVGhnOVljakRzS0Z2M2VseHVuRS9tWHN0SThmdWpmNFoyakZkcUt1?=
 =?utf-8?B?UHRpVUZkVldQdDBWUkVhQXFjblVST1Y0ZGUrWWRQb0t5MXlzT3o5M0J1VkFj?=
 =?utf-8?B?NDRiSmJVTHdNMUZwamo3ajVaRGY5blBUaVVBWDhuSUtJVytGbDZ3WFl5RE45?=
 =?utf-8?B?a0RCbjhXSUpKajhWYklMaGFRNWRxejNqMjY1ckpkOWlwdkMzOVJNSHdFQ3Ev?=
 =?utf-8?B?U3RXa0hmeWk5Z2hId0F1ZE9nOWg4K2k4dEFnbHVmKzJwSDhyNHliMFAxQ1BH?=
 =?utf-8?B?QWxkRzFpQmthVTB6QWJuK0dIY2pNaGE4MGVVRnRjOEhEdmFPVGpIUEc1VE9J?=
 =?utf-8?B?RFpTSTk5cmptTm53NUMraTR6USs2ZHpTMHFqZlJwUWZ4L2RKUndybVlMWTJB?=
 =?utf-8?B?MkdmZlRxTkVQaElMeU5pRFJQWjlZY0dDT1VIN3k2NHdSYmtQZWVkTno3bGFr?=
 =?utf-8?B?bDNZeENFa2xhczZwTHpIc0ZZTXhOcld1bituTUNoZTVtZVRBWmE3WTI1VkhF?=
 =?utf-8?B?WENySEYxQjVXVHlVOWh5WWVyM2hKelliaVhSTWRpZEhUSEx4b29sTm1oWWpj?=
 =?utf-8?B?WnhSaWJLQkJvako5OEpuVnp0YWFlODBHaFJIeVFubHkrTW1FRThkY2xlZUli?=
 =?utf-8?B?dmdwaVRPSzhCTG9nSFpqclcvejU0cVFWbGRKMmlFcEl5RVYzTEdESG82Vnl6?=
 =?utf-8?B?ZGMvMnEvd0FPLzh4L0dCSFcySStsQTZaUEg5MVQ5Y2VYbGpLUFJzNnFZZ3c0?=
 =?utf-8?B?SFhVWUJuSjROZE9UU1M5ZTYvemsyalNGaWRZNW03Y1ZtcVFlbjJ0YWt6VjAx?=
 =?utf-8?B?d1dLL2Uydy9nbFNFemQ0UzJkUW9qNGpkcG5OczJob0MwSjBBQ2VSRVlpRzJk?=
 =?utf-8?B?ZGNQMkZwR29NL0N2dTY0TUpmRlpqMVZCYVhvaHk5akNLYUh3RTFRQlo0bUxw?=
 =?utf-8?B?bkJ4VmZzMW5Ta3RtNHNENFlORGNudzBkdDRWSWhmRmlPcEJqQ2N2SE9PY09z?=
 =?utf-8?B?LzYwS1kxclgrSW5Tc0RvbllQUXIzSmpzMUp4YSs2R2R2bXdYYzdqTjJObzZQ?=
 =?utf-8?B?YWJGc3VleXd2Z2c0NzBjc0NIWUZ2Tm55THZxTUhOcDh6ZlNtVi80K25oMVE2?=
 =?utf-8?B?K1BxdFZOZzBlYWZBaW5BTkFiUjVteHpacW55cWdRN0orSENBS2NBTnhBbG1L?=
 =?utf-8?B?OGc0OHRBLzBpOVRUWXB0ZWR2RlRCMVNGZ0loWkNjaHhLdkdLR05uMkhkcjFN?=
 =?utf-8?B?WVg4enA1ajZmTTFUZmw0WEd2S0VPSVdhaytkVTN2RXFIblRIY1pNZmdjc0Fn?=
 =?utf-8?Q?8kfOg//GEBG4DQq8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F1AE4326CCE4804094BD6CAE3B8D9727@namprd11.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a8e9c2-fbed-4f6b-ce22-08dea1d7a9fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:01:17.4864
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XgrJGX/7d+24OLGiP1PUrc9O90hzQ3gUFogoGr8WSVHpL8lRPBeYvA10Bi0PYV8Iqzq0aSk6D5K/RW7o9jeAjOD96w+lXNomby28bYlCw5g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5287

SGkgSm9uYXRoYW4sCgo+ID4gKwo+ID4gK3N0YXRpYyBpbnQgbWNwNDhmZWIwMl9pbml0X2N0cmxf
cmVncyhzdHJ1Y3QgbWNwNDhmZWIwMl9kYXRhICpkYXRhKQo+ID4gK3sKPiA+ICvCoMKgwqDCoCB1
bnNpZ25lZCBpbnQgaSwgdnJlZl9jaCwgZ2Fpbl9jaCwgcGRfY2g7Cj4gPiArwqDCoMKgwqAgaW50
IHJldDsKPiA+ICsKPiA+ICvCoMKgwqDCoCByZXQgPSByZWdtYXBfcmVhZChkYXRhLT5yZWdtYXAs
IE1DUDQ4RkVCMDJfVlJFRl9SRUdfQUREUiwKPiA+ICZ2cmVmX2NoKTsKPiA+ICvCoMKgwqDCoCBp
ZiAocmV0KQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gcmV0Owo+ID4gKwo+
ID4gK8KgwqDCoMKgIHJldCA9IHJlZ21hcF9yZWFkKGRhdGEtPnJlZ21hcCwKPiA+IE1DUDQ4RkVC
MDJfR0FJTl9DVFJMX1NUQVRVU19SRUdfQUREUiwgJmdhaW5fY2gpOwo+ID4gK8KgwqDCoMKgIGlm
IChyZXQpCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gPiArCj4g
PiArwqDCoMKgwqAgcmV0ID0gcmVnbWFwX3JlYWQoZGF0YS0+cmVnbWFwLAo+ID4gTUNQNDhGRUIw
Ml9QT1dFUl9ET1dOX1JFR19BRERSLCAmcGRfY2gpOwo+ID4gK8KgwqDCoMKgIGlmIChyZXQpCj4g
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7Cj4gPiArCj4gPiArwqDCoMKg
wqAgZ2Fpbl9jaCA9IGdhaW5fY2ggJiBNQ1A0OEZFQjAyX0dBSU5fQklUU19NQVNLOwo+ID4gK8Kg
wqDCoMKgIGZvcl9lYWNoX3NldF9iaXQoaSwgJmRhdGEtPmFjdGl2ZV9jaGFubmVsc19tYXNrLCBk
YXRhLQo+ID4gPnBoeXNfY2hhbm5lbHMpIHsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3RydWN0IGRldmljZSAqZGV2ID0gcmVnbWFwX2dldF9kZXZpY2UoZGF0YS0+cmVnbWFwKTsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5zaWduZWQgaW50IHBkX3RtcDsKPiA+ICsKPiA+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YS0+Y2hkYXRhW2ldLnJlZl9tb2RlID0gKHZy
ZWZfY2ggPj4gKDIgKiBpKSkgJgo+ID4gTUNQNDhGRUIwMl9EQUNfQ1RSTF9NQVNLOwo+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkYXRhLT5jaGRhdGFbaV0udXNlXzJ4X2dhaW4gPSAoZ2Fp
bl9jaCA+PiBpKcKgICYKPiA+IE1DUDQ4RkVCMDJfR0FJTl9CSVRfTUFTSzsKPiA+ICsKPiA+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyoKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAqIEluZm9ybSB0aGUgdXNlciB0aGF0IHRoZSBjdXJyZW50IHZvbHRhZ2UgcmVmZXJlbmNlCj4g
PiByZWFkIGZyb20gdGhlIHZvbGF0aWxlCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KiByZWdpc3RlciBvZiB0aGUgY2hpcCBpcyBkaWZmZXJlbnQgZnJvbSB0aGUgb25lCj4gPiBzcGVj
aWZpZWQgaW4gdGhlIGRldmljZSB0cmVlLgo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogQ29uc2lkZXJpbmcgdGhhdCB0aGUgdXNlciBjYW5ub3QgaGF2ZSBhbiBleHRlcm5hbAo+ID4g
dm9sdGFnZSByZWZlcmVuY2UgY29ubmVjdGVkCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKiB0byB0aGUgcGluIGFuZCBzZWxlY3QgdGhlIGludGVybmFsIEJhbmQgR2FwIGF0IHRoZQo+
ID4gc2FtZSB0aW1lLCBpbiBvcmRlciB0byBhdm9pZAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgICogbWlzY29maWd1cmluZyB0aGUgcmVmZXJlbmNlIHZvbHRhZ2UsIHRoZSB2b2xhdGls
ZQo+ID4gcmVnaXN0ZXIgd2lsbCBub3QgYmUgd3JpdHRlbi4KPiAKPiBTcGVsbCBjaGVjayBjb21t
ZW50cy7CoCBtaXNjb25maWd1cmluZwo+IAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICogSW4gb3JkZXIgdG8gb3ZlcndyaXRlIHRoZSBzZXR0aW5nIGZyb20gdm9sYXRpbGUKPiA+IHJl
Z2lzdGVyIHdpdGggdGhlIG9uZSBmcm9tIHRoZQo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgICogZGV2aWNlIHRyZWUsIHRoZSB1c2VyIG5lZWRzIHRvIHdyaXRlIHRoZSBjaG9zZW4KPiA+
IHNjYWxlLgo+IAo+IEknbSBhIGxpdHRsZSB1bnN1cmUgb2Ygd2h5IHdlIG5lZWQgdGhpcyBleHRy
YSBnYXRlIG9uIHVwZGF0aW5nIHRoaW5ncwo+IHRvIG1hdGNoCj4gdGhlIGRldmljZSB0cmVlIHBy
b3ZpZGVkIGNvbmZpZy7CoCBXaHkgc2hvdWxkIHRoZSB2b2xhdGlsZSByZWdpc3RlciBhdAo+IHRo
aXMgcG9pbnQKPiBtYXRjaCB3aGF0IERUIHNheXM/wqAgSWYgaXQgZG9lcyBzZWVtcyB0byBtZSB3
ZSBzaG91bGQgYmUgbm9pc2llcgo+IGFib3V0IGl0IHRoYW4gZGV2X2RiZygpCj4gCj4gCj4gPiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgc3dpdGNoIChkYXRhLT5jaGRhdGFbaV0ucmVmX21vZGUpIHsKPiA+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgY2FzZSBNQ1A0OEZFQjAyX0lOVEVSTkFMX0JBTkRfR0FQOgo+ID4gK8KgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRhdGEtPnBoeXNfY2hhbm5l
bHMgPj0gNCAmJiAoaSAlIDIpICYmCj4gPiBkYXRhLT51c2VfdnJlZjEpIHsKPiA+ICvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfZGJn
KGRldiwgImNoWyV1XTogd2FzIGNvbmZpZ3VyZWQKPiA+IHRvIHVzZSBpbnRlcm5hbCBiYW5kIGdh
cCIsIGkpOwo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIGRldl9kYmcoZGV2LCAiY2hbJXVdOiByZWZlcmVuY2UKPiA+IHZvbHRhZ2Ug
c2V0IHRvIFZSRUYxIiwgaSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBpZiAoKGRhdGEtPnBoeXNfY2hhbm5lbHMgPCA0IHx8IChkYXRhLQo+ID4gPnBo
eXNfY2hhbm5lbHMgPj0gNCAmJiAhKGkgJSAyKSkpICYmCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRhdGEtPnVzZV92cmVmKSB7Cj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGV2
X2RiZyhkZXYsICJjaFsldV06IHdhcyBjb25maWd1cmVkCj4gPiB0byB1c2UgaW50ZXJuYWwgYmFu
ZCBnYXAiLCBpKTsKPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBkZXZfZGJnKGRldiwgImNoWyV1XTogcmVmZXJlbmNlCj4gPiB2b2x0
YWdlIHNldCB0byBWUkVGIiwgaSk7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7Cj4gPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gCgoKVGhlIGRldmljZSByZXN0b3JlcyBpdHMgRUVQ
Uk9NIGNvbmZpZ3VyYXRpb24gKG9yIHdyaXRlcyBkZWZhdWx0IHZhbHVlcwpmb3IgdGhlIHBhcnQg
bnVtYmVycyB3aXRob3V0IEVFUFJPTSkgaW50byB0aGUgdm9sYXRpbGUgcmVnaXN0ZXJzIGF0CnN0
YXJ0dXAsIHNvIGR1cmluZyBwcm9iZSB3ZSBtYXkgaGF2ZSBhIHZhbGlkIFZyZWYvZ2FpbiBzdGF0
ZSB0aGF0IGRvZXMKbm90IG1hdGNoIGN1cnJlbnQgRFQuIFRoZSBkcml2ZXIgc2hvdWxkIHJlcG9y
dCBhbnkgbWlzbWF0Y2ggdG8gdGhlIHVzZXIKYmVjYXVzZSB0aGUgVnJlZi9nYWluIHNlbGVjdGlv
biBpcyBjaGFuZ2VkIG9ubHkgdGhyb3VnaCB0aGUgc2NhbGUKYXR0cmlidXRlIG9mIGVhY2ggY2hh
bm5lbC4gVGhlIERUIG9ubHkgZGVzY3JpYmVzIGF2YWlsYWJsZSByZXNvdXJjZXMgb24KdGhlIGJv
YXJkIGZvciBkZXRlcm1pbmluZyB0aGUgYXZhaWxhYmxlIHNjYWxlcy4KCkkgY2FuIHVwZGF0ZSB0
aGUgbWVzc2FnZXMgdG8gZGVzY3JpYmUgdGhlIGJlaGF2aW9yIGJldHRlciBhbmQgdXNlCmRldl9p
bmZvKCkgaW5zdGVhZCBvZiBkZXZfZGJnKCkuCgpCZXN0IHJlZ2FyZHMsCkFyaWFuYQoKCg==
