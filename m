Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012011.outbound.protection.outlook.com [52.101.53.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425DB3BB9E3;
	Fri, 20 Mar 2026 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774015245; cv=fail; b=bFZ4sjjCj/Wi2Wjzc7wBq+pYxLXUBkmX9/yhOlTADfWZzPe1dSXENFORFLc4pQkoyGScNpPedRwXLFgLAajN6Ro4BE1TuwB2MNMLG9fSTpRsp4w/07mAH985fcGHLh9HEOfVRYzHO1Nnca4GUG07kNOa2/eMpZqEO8mHf37iaxM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774015245; c=relaxed/simple;
	bh=o74KVk4asF0kkS/MZS6+RzF43OvSo0mJrBNoUgUVg8M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ByXBjEJwR31ViIquYd+HWwTGPEJwJaRDBC8wWd9Gds0t1guau9SOb4imwFlCoWFd0S+MV7WyQ0pAxSRtI+LJYJr+gvwime3aGEPERKzK8C2k1tVAO23ytaoK28Ng0U0iDk6nH5lqkk1Q1BUrn3eK9475LEbB1r9X6E7TbeDdxZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=tIdwWyqx; arc=fail smtp.client-ip=52.101.53.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="tIdwWyqx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzclmC2U8RjdaZjoYPvJC2LKFT0dS31/Ul1kKDbu6ck++zFGiV+RZVXqwvtFFAcMIO9cbBvyr9S+t5Zgo7HcWGiZz55SkAnOq47vk3Fw5xXVYBTuOuj/4gTaWm3BiGOcjeyU+n/PtNbpUHIsZ4nFL0iK1/0deiXcTOp5RW3y4rQhtGzGfPymPNF8eAkPNuN5I4JYfD/daPldmYpz+0kustW49p3C5pbp6Hyz7hlw6E4yBnGSfDq4I3Pyg4E32+yPkS6W3VTmma6zy/LtKlkuCl3GB45aoviWy0JS86ouWz5LFwgVTc92Hfz3u0eYmWDYvrCZWofbsC67pxoYQYQ9rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o74KVk4asF0kkS/MZS6+RzF43OvSo0mJrBNoUgUVg8M=;
 b=OxbS/WdQOGh3jSlu4e9TNZdvzngMozxv6mkUz2bF6IrL5sQVTZfZzu/LTmz4xxKkzi33vFqVgn15H10FULp8PwtJSaR7f+bFTIo5J0kDwScjn0cAmwVy1IyblXXtcEuiQXgpDOg6EDj7Ws168LvnqMqMcO8hYxjr6RMHWRZtFF0u7vr1/wx9lHylq2aI6/JQWJz+lqZFESC8I32l8FrzxIYOgAEe1QBpZ1zW2w/jR5UFW1Jd56SFkgvCiNVVD56zkG0B+WIlCW2bSSoJd7rd0oJaPWGAkswZvpxu4UMohaLAEyzmLbmBA8Je1U4akjixDXrkDwhBzOQ7rybjzgrR8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o74KVk4asF0kkS/MZS6+RzF43OvSo0mJrBNoUgUVg8M=;
 b=tIdwWyqxXBMtSWZCGWPmsEvuJlIauT9g7HtGPUFh24clvg9Ybay4vn9pTD+HIWfSzv6DH39i62S81y3Oi+/ZiyVOGpBBrJmPoB8tsWnSdXF+ztR2U5gAuw/imSSztj3qgQANrcwejSUfDKSroFC1gW39ws8occ+Y2j6PsR4yfggnbZAxGJkjxfGwlBHMZKF4QqSevzK+kYj0apZQjH46Jk0Z8ttcT4/G8rfi6W6Wlh4aMNCMxF4xNGxIju/bYtHoX5cLuAdE60lyywnNG2KSE2hXSTNRHH13T5CaSmO790JPK3PXUWFOi7dsmpUZOozTrP1NFFuTWO6UMerDl6WpPw==
Received: from BYAPR11MB2950.namprd11.prod.outlook.com (2603:10b6:a03:8f::29)
 by CY8PR11MB7875.namprd11.prod.outlook.com (2603:10b6:930:6c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 14:00:37 +0000
Received: from BYAPR11MB2950.namprd11.prod.outlook.com
 ([fe80::57bd:815c:82ad:9b77]) by BYAPR11MB2950.namprd11.prod.outlook.com
 ([fe80::57bd:815c:82ad:9b77%5]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 14:00:37 +0000
From: <Conor.Dooley@microchip.com>
To: <455.rodrigo.alencar@gmail.com>, <conor@kernel.org>,
	<rodrigo.alencar@analog.com>
CC: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
	<dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <p.zabel@pengutronix.de>,
	<corbet@lwn.net>, <skhan@linuxfoundation.org>
Subject: Re: [PATCH RFC v2 1/9] dt-bindings: iio: frequency: add ad9910
Thread-Topic: [PATCH RFC v2 1/9] dt-bindings: iio: frequency: add ad9910
Thread-Index: AQHctwCHbT1bLKt6z0CWlkYzoWzha7W2HLuAgAEssoCAACxSgA==
Date: Fri, 20 Mar 2026 14:00:37 +0000
Message-ID: <f38d913a-486d-493e-b871-17238d8ca5f8@microchip.com>
References: <20260318-ad9910-iio-driver-v2-0-e79f93becf11@analog.com>
 <20260318-ad9910-iio-driver-v2-1-e79f93becf11@analog.com>
 <20260319-annex-varying-afbddcb825b7@spud>
 <zi7ifl45h5fu76rlbdubkeq7wa7gtve5wsdruo574gzj5qbfu6@fl6rh3soaj74>
In-Reply-To: <zi7ifl45h5fu76rlbdubkeq7wa7gtve5wsdruo574gzj5qbfu6@fl6rh3soaj74>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR11MB2950:EE_|CY8PR11MB7875:EE_
x-ms-office365-filtering-correlation-id: 5e64547b-cef9-472b-9991-08de86891075
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|18002099003|56012099003|22082099003|38070700021;
x-microsoft-antispam-message-info:
 zNmmJYlk6mqOqxUm3x6CGUmzMMKmR3DlfcbkQclMpMGV4KSx9quKiC8h6TeJuGqtsv+jJYLqTUnhHie3jcnHZpfXqaHnK2P/UJHb/eIsC/piuL+FwKzmhGiUz09yX4xYd0mRzCexd3y3L3wZ0RvdP6Yd2hbH997qnzVn7cLIRgbkPAGA0TuU/6mmzHAgbtWMZykOWx4yYOy5+VWTdF949BA5LVlMt4nx1fqylvuFTkX8Aszow+n8e1oRvocq25x3q+nPX4DlmdnqxTtDDLeI0myJSx7Noypv0KAb55zlEXqyN/eUkiS/HjZoPVMNSC+hBwTYNIHDeQrlYKAf5rhvnci+bQzhV2mUGYcoc10BE3RvtgGv1uezQeA1dvDh31B6JJzeB5U+H7Se/PwyfMttH8d31AdIBO092UzClaenxIQZJzMKZssl0jjMEDJcENjBCel+UTc9m2THG7bFbeU8YDpeQkoa1nQrxFy2TjvWLdjNrddn8YAdUKoWqZJcDo5vxN5FNZUs/3shVVrwJjS/BdBRmpbdo0CnZbAUKt9jsLGdNdT9n/3GOpVEecrCMV2CDW8hwOBci6+a8jv54fWC731FmnLDRGuE7GwO3ciJEXhZLRzs5FXX3y8womJ7OB2yMzaxmeft6zG117sJ+WawXRjvR66SR6tz9/DkHDeQKudFQVS6CSmQsS9a1COIqOBGCQHcAC27FtIQNlrzSJF66mW585KyNWVaemc2bkcMaef6qQPDvMpHWEjFS+vxaEO6B79WlK/b+hCKD3oex1RwzGhI+7C1/KpF1rrzBpQW5rU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2950.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(18002099003)(56012099003)(22082099003)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RDJiVVp2ZWRudlJyc3ZmYjJRZExtR2RERllzbXZWZWhBT2hMaGtQeDd5aWNL?=
 =?utf-8?B?Tk83Z3h1bm5KSmVQN2J4bHNiTnhFWHhWYlExNGR5VE02SExxVmM3R1pVeEpR?=
 =?utf-8?B?Znd0d0JtNVByeFpuNVBHNDhTcmpNSWh2QWNKM3dJVElUU1ZBOG0rZ2VVVlo1?=
 =?utf-8?B?SEJkZks3RFVLek51eGpQMGpUZnJOZzhsanR2U2swWDU1SlR1TmxsM0VjQndO?=
 =?utf-8?B?ZHNFSHByTUNLTmZ0MG03T1RxNWgrZUE3Z2t5cWkwb2x1NUYrenlydTVBOHdG?=
 =?utf-8?B?Q2d1QmxuR0ExZ0xkWG1EZWVLakYvLy9EanlSeDg3M09qY0xZRGJ1bndBa2NG?=
 =?utf-8?B?QU1MVHZ1VlppY083UCtOcTRQWnZaWTdlZjJ3QTdJQVk3ekhybDhiTmxPSkZ6?=
 =?utf-8?B?d1grVVRRTHdsYlhDRVFjUTFaajdXQThMbno1elZCRTIwU2NMZHN1T3JyWHh2?=
 =?utf-8?B?SkJ6a29EZ29jbGNSVVZJZmJIc2taZ0lsajd3TGZTOUFVa1l0YlNRVUx6WnF0?=
 =?utf-8?B?VnJSU3ZhUHJtOGNNTFBSYjZKVnZNMTl6SHROMlBWdEhJTDdBMUhzcldndWJR?=
 =?utf-8?B?bjJCWUszTTVuYzhYODNJbFowc0wvdld4djdJRXJwbSt3TmtlSmoyVWVpeTZY?=
 =?utf-8?B?TCt5bWNNdHdveFo0RG9pUndMMk5nKzMvRVQ0SmtPT1hLR3BGUFNOSDJRSEhp?=
 =?utf-8?B?eXJPeHhwSUVFZUN0YUpVcjJZamhLTmszQzMwNVBwWXZLNEdDazlZNFBlM3M2?=
 =?utf-8?B?cHd5eGI1eTB5SEN3VFc5WEx6QzY1ZS9pUHFxZE81WHF6ZXUvclowMWViUDRw?=
 =?utf-8?B?YTRQcTV3aGUrMTZmWUZYTVlkSTZQSUNzdml6b0R6YzVEMm5TSmcwQjU1NDlF?=
 =?utf-8?B?eFZiYWtDQjdGOWV0RDEwVG1QZ082Y3ZVU1ZTRUJtcGhsd04zNkp5bTVMN1VH?=
 =?utf-8?B?aGJwVS9sZzJXV0dpK2d4czVNb3NZMVRlamxLWmd2azNXZ01MRUpmRHZuY3Fn?=
 =?utf-8?B?VUNDc2dZV1dZMnBoM0N3aUdvcFBCaXQ3eGQrb2I3MktUR1ptdm1kOElJWFQ1?=
 =?utf-8?B?MGJBcVZocVFoT0JNYjlMc3FWQmt5ZisvV0psSWtkVFhNelBWSUx1Q1E1bXQ0?=
 =?utf-8?B?S1RIVFdvVXhabVNOcUVYRWtnUE96Z0Y1M3kxZ0ZNY1dMVlRReG5PenN0T3I2?=
 =?utf-8?B?Qmp3eGExajkyRzRLN0xUQXBwaW9uVWNIeHVPOG5lR3kyRWN0QktGM3d1eVBY?=
 =?utf-8?B?YWd5V1RaTENNYW9Ca0Q4RFNxSXZ1TWNLcGlPK3g5ZVRHYysvU1ZvOEVPNnNo?=
 =?utf-8?B?UWtkbCtrS1pnTGN1SHJ0SWN5UVhqZkgyTGZzdVNCZHlocCtzbnBkeGdrSWJq?=
 =?utf-8?B?L1N4L0xBYWdsZFlBZEJsdnZ5OU5adFZOMnp0cWRzSlNJaitVSTlwYWNlelJw?=
 =?utf-8?B?UTI4UzhJTCtIWDQzNGkvNTdqWFdwZkJCYnJpekRpaVQ1TTB5Z1NmeWVkcE1R?=
 =?utf-8?B?MzRxNkI0NXZZczJkVmZoa2svOW43RE8rdHRTZ1FiS3B2bnV1SzR2K0hObTJT?=
 =?utf-8?B?QVZVazNpdHhiVFlZQTdQcm1jSjJZcCtyMGR0WTdXTE9EVGpWd3lNTkxBL2k2?=
 =?utf-8?B?eWoxa3l5SUE0cVAzM00xZm94ZGdBRVo2VGdQNGpYQitHMzg2cnQ2WGY2Z29x?=
 =?utf-8?B?RkFWeUtkaDZDeFlLUHdIZXpibURuUlExYkhucGlSV0NWNlhEdXlPUUhpS1BK?=
 =?utf-8?B?Sm5EZFlHMVAxMDZ2anZhT2g0Qjd2QnNaTDZQdW5GaFc2ak84NnZWakFnbG9W?=
 =?utf-8?B?eEhmeFFtQ0lDbDA3Umtsd25NbGtTZWZNcm55dVk3ZjRZeExRZERhWllBOWpB?=
 =?utf-8?B?UXBsc1VYVWRwanRHY0FVMGhac2tDcmlrZnRENFdVMVFZcjdESjFnOFhsdkF6?=
 =?utf-8?B?VU1CQkJxUzZjVVZyRnI4UHF6TG8xQXluNmlZUXNmSkVYRng4SVN0cUltcVhZ?=
 =?utf-8?B?ME12ekw4QkVPK3phS2RKMTdjUkQxODZIbzRsdkpLN29DaUxWaEo4MkFkOERv?=
 =?utf-8?B?eFdacGRMQ21Sb29XS1haT2M0WEtXMWRiZTY0WURkM2xqS05wWDFjNno0UFNZ?=
 =?utf-8?B?KzYzMkptYlBBa1BzcXpxTENid2N1czMzdlRucmtGUE1CZ3l1ZSsrS0gvQ1Az?=
 =?utf-8?B?Yjh0NWgzUUJxRmUzUHpIK3pEUmdzcEE3UGhFS2t6bTUxbm1vYzF0bUs2UWhy?=
 =?utf-8?B?a3Vocks1dit6NW9LMlhGVkJaeDlMMGpTbVdKSEQySlVBKzF0WlRlOEtscEVm?=
 =?utf-8?B?d3prOGdWb2c4TEY3K2w1b0s3cURzSEpCTktvYzAxZUpPK1NDK3NiZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9E4F483336717B40AF7F9845F8A56979@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2950.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e64547b-cef9-472b-9991-08de86891075
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Mar 2026 14:00:37.7899
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aa/eXTTGw5t7iYG65i+v7n7lZ82huvoZ8DA+pZ2qGzJz/9mZeleMIMNhtvhku95wXDNhDyacBZK8M5fe8/jfwDcvmZIqayQ20TwJn22HhYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7875

T24gMjAvMDMvMjAyNiAxMToyMSwgUm9kcmlnbyBBbGVuY2FyIHdyb3RlOg0KDQo+Pj4gK2RlcGVu
ZGVuY2llczoNCj4+PiArICBhZGksY2hhcmdlLXB1bXAtY3VycmVudC1taWNyb2FtcDogWyAnYWRp
LHBsbC1lbmFibGUnIF0NCj4+PiArICBhZGkscmVmY2xrLW91dC1kcml2ZS1zdHJlbmd0aDogWyAn
YWRpLHBsbC1lbmFibGUnIF0NCj4+PiArICBpbnRlcnJ1cHRzOiBbIGludGVycnVwdC1uYW1lcyBd
DQo+Pj4gKyAgY2xvY2tzOiBbIGNsb2NrLW5hbWVzIF0NCj4+PiArICAnI2Nsb2NrLWNlbGxzJzog
WyBjbG9jay1vdXRwdXQtbmFtZXMgXQ0KPj4+ICsNCj4+PiArcmVxdWlyZWQ6DQo+Pj4gKyAgLSBj
b21wYXRpYmxlDQo+Pj4gKyAgLSByZWcNCj4+PiArICAtIGNsb2Nrcw0KPj4NCj4+IFdvcnRoIHBv
aW50aW5nIG91dCwgeW91IGhhdmVuJ3QgbWFkZSBlaXRoZXIgY2xvY2stbmFtZXMgb3INCj4+IGlu
dGVycnVwdC1uYW1lcyAod2hlbiBpbnRlcnJ1cHRzIGFyZSB1c2VkKSBtYW5kYXRvcnksIHNvIHRo
ZSBwcm9wZXJ0aWVzDQo+PiBjYW5ub3QgYmUgdXNlZCBieSBhIGRyaXZlci4gSSBzdWdnZXN0IHlv
dSBtYWtlIGNsb2NrLW5hbWVzIG1hbmRhdG9yeSBhbmQNCj4+IGludGVycnVwdHMgZGVwZW5kIG9u
IGludGVycnVwdC1uYW1lcy4NCj4gDQo+IHRoZSBkZXBlbmRlY2llcyBpcyBub3QgZW5vdWdodCBt
YWtlIHRoZW0gcmVxdWlyZWQgdGhlbj8gdW5kZXJzdG9vZCENCg0KbG9sLCBjbGVhcmx5IEkgYW0g
YmxpbmQuDQo=
