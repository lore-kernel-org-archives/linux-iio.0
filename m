Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E01A5391E7A;
	Fri, 21 Aug 2026 12:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.166.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315999; cv=fail; b=bR9HMufc6NUj7GYcgLS/BGQczOgznWPGAoixLNWU17jxatCrDJsMp8zcY0xCQ5ivrNzQ366K+0atkNeyk7JfLC8tGBGuf1cwVt3LSmUzoSgg2N9Pt1tjaIxWgaKi70ViNILXhgneBHcFQxOcQp+viNrlSwimxvwTzwZALr1D9tk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315999; c=relaxed/simple;
	bh=MjC6bEdY2/GnR/2CkmBuebq6vPOzLyJpOcPVPMzEITU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M51ztS9ftKmJbIWJoE/NibElYqiu4LUIQXwebJrQO3O5ZoFdz2h4Ex0Co5TlvIDiuPoB5jeT73dvBoO0gg3U21xwHO/69x9emwX17DpoP5hUq4+bOyS0kdghko21vhoTLlPxUpiGp6+btvZ9icD0gW7NHDdU3UgBXoQD8ge7D1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com; spf=pass smtp.mailfrom=tdk.com; dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b=I1zXRRI1; arc=fail smtp.client-ip=205.220.166.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tdk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tdk.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tdk.com header.i=@tdk.com header.b="I1zXRRI1"
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
	by mx0b-00549402.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LBwQXd3538441;
	Fri, 21 Aug 2026 12:39:52 GMT
Received: from beup281cu002.outbound.protection.outlook.com (mail-germanynorthazon11010058.outbound.protection.outlook.com [52.101.169.58])
	by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 4g4ydytpq7-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:39:51 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KgviVuirPeDXaYrFz0+6qXuiBQrHDr6NXqrGcBZVbMWQiaBTAobWySUiAbP+eYHkgfEhFYQvk3G65KKyGV8n+lNk1wsYLxm2BenmwE9IwD6jBcn7fCsm9+u9sEJ2wDGYJcBNKmdSZldX/+nivPtNcF3HaLvohno4TR5mssrFZSflZWS4CnyQu8FaPoOqxIML9iI5WGToakaQ3xx1xn3NUnIDqo3NauqP8GD7TCSkVfhrGCnFm20qPP8u8wDddIEKBOLP0OnPx+hURvyhg1X5UHnD5wTrcgXQCmtHfN6JJnsVUiAHeWFdOmZmz8nPEkKU5c2ZFbO99J/jeR1t4nUCXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MjC6bEdY2/GnR/2CkmBuebq6vPOzLyJpOcPVPMzEITU=;
 b=hHWgJ+xOVH9Io3r062th4w2ulVcFmSqx1LFhOcrRcg1bQ6ocwjrB9I5UIqgIEy+K2zE4FEdaWCpYYYPM+B3oWo98T2pyO8Y9IaSAcMDpHW5RgpXxtDMlkD28onDSPeHgitM9vSm+Q6bx9odrruCTircK+wZYbRrTwJytPjC1m3DP2LtfMer6I3qxlne8yTwYaK6XTMyfsk6u1X/5EmR57hrglha3OzNMyQ4aM4nRp/2ykfv78v81+MWUUN0rt7dc2jEDzmXwrNXSiDyLT3BnpRySzaeSqgVNpYrN6tpl1Xzk3wgjB3j2fFedO1wYmPNmRtbmxY3exugyuZ3jW0tWhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MjC6bEdY2/GnR/2CkmBuebq6vPOzLyJpOcPVPMzEITU=;
 b=I1zXRRI1elVcmPwVnxai3nzkkhThGbsF4VANZ09NumtI54lTMliQP7jmljKW9ueqiHeD8KSMBg/S0XIGyjVxvHpBdTEonAGchkrn+yVi6s1+SgqeTyCDQ1TTJT3SDn/SC4zi2+uQnMEFURfg2ZRXLcJWYV4a2ehqekU9ePd/0RwV4MOXCtOTtg4DTSGbVvDEgyr0VGGDxCtbUAya8QzHZ67KC1Ah5ezIyPqdJHyCW4/wUvTxnR5ZPZ+/SBkliZXv7853JFOJuJ5mYUKnldgDt05xHmWmJVcUsqW5abGCxhv3PxEJK5hxW92L3OP871KETR4zez05dacvzG4z6NBUyA==
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:19::10)
 by BE1P281MB1953.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:40::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 12:39:46 +0000
Received: from BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b]) by BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
 ([fe80::9d4c:26bd:ea0d:b04b%5]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 12:39:46 +0000
From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To: Jonathan Cameron <jic23@kernel.org>,
        Jean-Baptiste Maneyrol via B4 Relay
	<devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
CC: David Lechner <dlechner@baylibre.com>,
        =?utf-8?B?TnVubyBTw6E=?=
	<nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] iio: imu: inv_icm42600: sleep before enabling FIFO
 data
Thread-Topic: [PATCH 1/4] iio: imu: inv_icm42600: sleep before enabling FIFO
 data
Thread-Index: AQHdMNaCkfw3JSjenUm8FyoeTF/EqranoCCAgADRrMI=
Date: Fri, 21 Aug 2026 12:39:46 +0000
Message-ID:
 <BE1P281MB1426199FF06AD1BD7FE030C0CEA32@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
References: <20260820-inv-icm42600-enhacements-v1-0-075a881db557@tdk.com>
	<20260820-inv-icm42600-enhacements-v1-1-075a881db557@tdk.com>
 <20260821010623.4d064f8c@jic23-huawei>
In-Reply-To: <20260821010623.4d064f8c@jic23-huawei>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BE1P281MB1426:EE_|BE1P281MB1953:EE_
x-ms-office365-filtering-correlation-id: b9ad9b46-ea6a-49c4-4da1-08deff814846
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|1800799024|366016|19092799006|376014|23010399003|18002099003|22082099003|56012099006|4143699003|3613699012|38070700021|6133799003|10067099003|11063799006;
x-microsoft-antispam-message-info:
 4KQkvBcw9R5+4ihWg608O671abkyMnSaUITTjuCyVr89sJ7jyaHk9akLEVajFCPt8L5Qmdutaq/DTfPB46HJKjKEAsKsynY7oeES1jnwS5i0th2hAmLwkNdEnwghVUcz/pmbUWwbOUpd3dTvUKleElZaca9+AsyGooFGGdF24UsEdh3EgDf26NaamUtLgAHIkI8qhoAfWXyQ41nJAK/xyo+psaFdfNITlddFKxIq7JrjVdfx9UkweG6UGDvTnq+/lVkr1DyN5Ajj5XCVQz9sCtgbAucwIO19xorerLGUdW+RK0yR0C6nLsZxM+TWsss+lyXfvarqNUsmD2/7ztEQ7FbNq+60JEW5NsInEppz9sbfWn2VA/pK5JhiJGcJb2rvKmuIoZ7CJmPF0tbBJZ+qZ2OIUkcWHXOroLUupo6Bo+Gg0rcL+8GL1EQfVwFXW59lHgYdZtrZujh5QkEMNYrmHvvkYEmV5lfa73x8DRW+gjLuDUAiZQwG3r5/wq55d4iDIshiR7nThwL+vxNRYfF1kyCrdwbk4AE5oDucP+yWNHT8iZd/W/OdrF8Hx0RH9s9CovD93OAKoC+vQF05e0gEgCjU+OtX5vlS3BPX16mTS8pQgE5zu/VOahFJn4trJvjSu0QgO8cB4laWtJKa2bx47c2nMxT9v4Jw6i3xL6DEs52bKxT62nQMbRDMQFb0+Tx9Cj+EwXn9h6Dx6AbuoNyKdTRDpKFHZ8S2GwZLl2bB/2srxAqFTBpPgzKvGVXLsssO
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(19092799006)(376014)(23010399003)(18002099003)(22082099003)(56012099006)(4143699003)(3613699012)(38070700021)(6133799003)(10067099003)(11063799006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?a0FlMnpKOFA2M0MyL0svVlZ5MzIrOW1aUDZMcXcwVUhlVzVFY2Izb2lJanRt?=
 =?utf-8?B?cnBnRVdVNVFObGxPS3BNMnM4T25BYjNQWnNUSTY0Tm5OczJhdEZUZHNrZWNR?=
 =?utf-8?B?WkRSRUdnQm9YMStOVDgwc2EyT0hUYTA1YzQ3TmRDYWZvNyt1OGtPcWFDdG93?=
 =?utf-8?B?Y0JiVjhNajBybm5SSmh6cDlrVEhlNDV3STcwUmQ4eUs3QlJQb09RSnROOW1y?=
 =?utf-8?B?MTB4TndwU1YxZ2tHaFplbGNXeTZFNW1PM0hIakVVVVdlTStIQU5BOHBBa0RT?=
 =?utf-8?B?eDFIbmF6Vk82d1kySVZoMzZJNTVnUE9TRytuMzVIVFJKSFFIZDZ6bFo2bjB6?=
 =?utf-8?B?bDQvNU5ZRndLU1ovekxXaHJiSXg0UmtBQjdpS01ubnRqZXVHellLelFpNE9i?=
 =?utf-8?B?WjhybTFqRGpTYkRHQXJ2T2Q3V0N4WkhqdzFyY20ycTgwOVdQM1BnUDFDLytL?=
 =?utf-8?B?bFdXejQvS0NqR2JhTXE3a1FFMExrSkZGWUFlaEhmK2FTOHV6ZEh2TzVPelFj?=
 =?utf-8?B?MGRKTnRHYWxieDBJcFlKOGY0cU5KOTUxNWxUZUJqVzZaellZN3FGRkxHS2FL?=
 =?utf-8?B?ZU5JNGlxY3NkRk5HZFhucW1tN1ZYZzJ1dVVreCsvT2ZCcWVmOFE4dytyY1lU?=
 =?utf-8?B?TXl4ZlB5MkxmaUpkRkdEclNlOTVVSU1xVjZackZhRzNWRld3bEdhcU1xUGlR?=
 =?utf-8?B?OGRSZDFydG5uNkhrSUVpMk5YbXNTMUlwS2crSXVIbGdMSHNGVzF4RlNGUk44?=
 =?utf-8?B?RHFvK0g1NUUyREg1NncyVjhiSGtUaEh5eHJ2akcyYStTT2FZenFGVkhLQUV3?=
 =?utf-8?B?R05zRDZPcVFIdUM3TllMYVVSYlZEVXZKS25EVVhZVlNQb25wZkRFb3JkcHds?=
 =?utf-8?B?YUxLOEQ0cVkyekp5KzJpbDh1enB2MDM5dXJVajQrTXhiWEJkQUsxbzBwTFhH?=
 =?utf-8?B?VHcrUHpvbll5d3pxbi9VajhKSUlsSDJJTTNJWndwSktKdEh5SFFnVDdyL29I?=
 =?utf-8?B?bHhLTjQ5aVc4clpyOVRsRWxoU3orVUxJdnFrK2RacVp6aWpVdExSVGZwaGtv?=
 =?utf-8?B?S2lPY2ppZzNoaDZYQjZEUmpUY2FOWnRGV2RJeGx4eHljdEtDVWRFQXpxQnZT?=
 =?utf-8?B?YmJYc2xkeERoLzk4d3pLQ2N3OW5JT212RjlXVXpnZDMvM1JiVEEzZGJaWG5N?=
 =?utf-8?B?a0VvRnFUQlNHcTEvUnRMN0VOVXJtdXlqNUFWV1Q3clQrVGxkUUNSRk8xeHBa?=
 =?utf-8?B?eDdwV2JpeVVHQWpodWxubGt5cGEvZDVESjY4bnRydTZxNGFpL1NWejNKdU9C?=
 =?utf-8?B?NS9kM0Z6RVMrREpMVEZTY3MwYjRUSGJkVFpoSDExSCs0WWYrUWdCUXNRcWow?=
 =?utf-8?B?KzRuUmJONEdIMDJFZytya1R1bktVejJxK3o4b0JaV1NFRktqdFBGY25WenNO?=
 =?utf-8?B?R3k3cnprSDBrNWVjYVZUaVN3d0MwckVpRVI2TWh4T3lxa25rSUcxVjQrbENN?=
 =?utf-8?B?SFloTUhRUm90K09MbnBwenB2L2ExVEIxOHZFTDlUdkFHN2V6dDFGTDdxM3VO?=
 =?utf-8?B?Yzc5bGZVWGx1dk1lMS9JMS9PVUNqQ2UzemtoL2tuTDBXMDhBY2h1Y3FWbU90?=
 =?utf-8?B?MEtsMHQrcy9QQlRQYWJ6d2dCTHRwNU5lQzF3Yi9oTUYwOU85VUtmakV4S01x?=
 =?utf-8?B?VXNtZ0doMExvbFcxdHJFaDhjTVlCand5TzNLYmlFbGlKOGNGeURCbnBRWXVU?=
 =?utf-8?B?QTIrMXZzSmpxNjhlSldUZTdXTThCZGswOWVzVDU2SEtFbWpxejYrN01LcnJC?=
 =?utf-8?B?T0xDMUNaQWFvMVhjL3JGbitXRlNKT29lUXpyWmozWkhUT2xyVktOQXBUd28v?=
 =?utf-8?B?NmV2VlNTb1MxWWNlVktvVUJ4RHRibGx3S3lZdXlkcCtKMnNxTEhadS9nbjNJ?=
 =?utf-8?B?eUd5L1VyK3l0V1BaK1I1Ui9lMUhOVTBVWDRRRTNDQ2FqaGt0ZHZFK3hFbGJO?=
 =?utf-8?B?d29lT1dEVkZ4eDIzaGVmY0c1Q01lR25XWUZWM1U5TllDSFFNemdZMUZyL1po?=
 =?utf-8?B?aEs2M0xVU3BoTWdRWFp2NWZoejJXMThQbU5VbjdJVk9LUFpiTGZWcm1ibFJP?=
 =?utf-8?B?SDVodlJBdXA2RG9QSmRKaHNCYld4cTN4dE45aTdtSUkxeXFiSjVSYnNIaGdW?=
 =?utf-8?B?Z2JBd0hiWFNBRU9NZmhwRzNyZEw4MHlTSXVHQWxRNXNTSitjWFR0R1RCazBv?=
 =?utf-8?B?NHNMTjBHSTIzS0tpN0h0ZDJucXZYODFkQ0dRK1FaYkRoQkNkdmpFakFnaXhy?=
 =?utf-8?B?SjZpRVJIbnNnZUVqUTFldDltUm1sbUpmMDBjL21ESW9ISERGWUwwUFBlZzlp?=
 =?utf-8?Q?jgYDppSP+U8mDStf184a6I+PN8BNyfD7oho/qzZXSTKp+?=
x-ms-exchange-antispam-messagedata-1: UPmVZu1m94dLtw==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	OpJKxN5V7B/KKGx0jh9i3NxqyWFdpxcpyO+N6BdqP1ltU3onMjTE9PrwP5+Soy96UGbcWrcbgaO1bb94SbDkNR4LyV6KXsTeJ/TE+3IaREvPhUsFY1GYu0aa+cuwzfQFIDf+l5qIOwEfaNFDo1BNwYVImokDVF5HwXACd4x28VRrSC88KzVKp3oIOap5zFwhGwnrXPctHIeG2hhPLJV6aJVPp5hxaR7QsXmATUprahNgtGxLjJkAOw48P93nnq12XNI6tcy12lzUstIJo/S4EEbR3A5UCkyuvChzHLhqhe0g6WqclD8CDaBsNcIGxCytxggho9/+KSdbKWnaViXnpQ==
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: b9ad9b46-ea6a-49c4-4da1-08deff814846
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2026 12:39:46.0557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OxMnxAGEgwh2b/N6VZcOdZeq9yY3HuvdnaqdombxXTVcx3ciZBIX24Y9LAUqUM586eTPRMGQd+Wfvqc5F8WHsXgPiuFj6RZzPojTyFVsymg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB1953
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX4q7ke+XYmF+9
 RAaINi515TZLQXPg/Q4U3Odwuc583dl3orTFhTxfYcep/wUG/01KnW1Ghd0+JmGV6OCJIeMfKud
 4TYKBBgilCEXx6ObCpmzrkh5WdEyFTo1lIo8pDqJGu3bMUorB3yH
X-Proofpoint-GUID: QIaOF7CYRwPOyC4vTv06o0RJeD-XPOJs
X-Proofpoint-ORIG-GUID: QIaOF7CYRwPOyC4vTv06o0RJeD-XPOJs
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX8E9PuNgU8uHq
 LPrrl6a4PNF52P7j3J4KCi2DEqDXMgshfprF84/jRIDlasyIFNIp50K3+D9kQWWSe1hBVBpZH/Z
 45vtURdtud+jNHjLuopKPHr6mTf7Jk9+A7ouaNNst+pECJzpLeUju/huBdAUseABmUENj2hda19
 I8lpjDWcUzIrg+rnKzyN/rCMhWCcAok/Bg8pdaddqZ8Nd4mgn2XzeNi5IVbTWM3Worzxv7Z05DF
 UJRvaPDoCMQ1nGcrwDEw5s/DWpLf/zXz/e8Yd0yqoEZ8Oau5TsRC8ok1AzbshmfG6FLMmsxO9/U
 NLXIk8gTozunWF5vxbnu7Olefgtod3bYDYvMNswQjVg6rr5UOTpX70zoR+1IRu5zAw47P7st3HT
 +V6zQPQxjBjN6u/TQaFgtvp1A+YxPHzmqyg+J/2FG86/J13hCgvanzTWZT3df9pHyjJkO9oAR2P
 3ZN26WUO9es2GtBHgeQ==
X-Authority-Analysis: v=2.4 cv=PqyjqQM3 c=1 sm=1 tr=0 ts=6a884718 cx=c_pps
 a=VdJcGZ1pK9xtMcdC1Pd9qA==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=Uwzcpa5oeQwA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=W6z64dnQKVPvYeLC5f8l:22 a=vGRfEVypjB2sPmOVjkt7:22 a=VwQbUJbxAAAA:8
 a=In8RU02eAAAA:8 a=DxwKdISikkNFTMK1s5IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210096

Pgo+Cj5fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj5Gcm9tOiBKb25h
dGhhbiBDYW1lcm9uIDxqaWMyM0BrZXJuZWwub3JnPgo+U2VudDogRnJpZGF5LCBBdWd1c3QgMjEs
IDIwMjYgMDI6MDYKPlRvOiBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIHZpYSBCNCBSZWxheQo+Q2M6
IEplYW4tQmFwdGlzdGUgTWFuZXlyb2w7IERhdmlkIExlY2huZXI7IE51bm8gU8OhOyBBbmR5IFNo
ZXZjaGVua287IGxpbnV4LWlpb0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wKPlN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80
XSBpaW86IGltdTogaW52X2ljbTQyNjAwOiBzbGVlcCBiZWZvcmUgZW5hYmxpbmcgRklGTyBkYXRh
Cj4KPk9uIFRodSwgMjAgQXVnIDIwMjYgMjE64oCKMDI64oCKMzcgKzAyMDAgSmVhbi1CYXB0aXN0
ZSBNYW5leXJvbCB2aWEgQjQgUmVsYXkgPGRldm51bGwramVhbi1iYXB0aXN0ZS7igIptYW5leXJv
bC7igIp0ZGsu4oCKY29tQOKAimtlcm5lbC7igIpvcmc+IHdyb3RlOiA+IEZyb206IEplYW4tQmFw
dGlzdGUgTWFuZXlyb2wgPGplYW4tYmFwdGlzdGUu4oCKbWFuZXlyb2xA4oCKdGRrLuKAimNvbT4g
PiA+IFdoZW4gdHVybmluZyBhY2NlbCBvcgo+WmpRY21RUllGcGZwdEJhbm5lclN0YXJ0Cj5UaGlz
IE1lc3NhZ2UgSXMgRnJvbSBhbiBFeHRlcm5hbCBTZW5kZXIKPlRoaXMgbWVzc2FnZSBjYW1lIGZy
b20gb3V0c2lkZSB5b3VyIG9yZ2FuaXphdGlvbi4KPgo+WmpRY21RUllGcGZwdEJhbm5lckVuZAo+
Cj5PbiBUaHUsIDIwIEF1ZyAyMDI2IDIxOjAyOjM3ICswMjAwCj5KZWFuLUJhcHRpc3RlIE1hbmV5
cm9sIHZpYSBCNCBSZWxheSA8ZGV2bnVsbCtqZWFuLWJhcHRpc3RlLm1hbmV5cm9sLnRkay5jb21A
a2VybmVsLm9yZz4gd3JvdGU6Cj4KPj4gRnJvbTogSmVhbi1CYXB0aXN0ZSBNYW5leXJvbCA8amVh
bi1iYXB0aXN0ZS5tYW5leXJvbEB0ZGsuY29tPgo+Pgo+PiBXaGVuIHR1cm5pbmcgYWNjZWwgb3Ig
Z3lybyBvbiwgYSBzbGVlcCBpcyByZXF1aXJlZCBmb3IgbGV0dGluZyB0aGUKPj4gbWVjaGFuaWNh
bCBwYXJ0IHN0YWJpbGl6ZSBiZWZvcmUgcmVwb3J0aW5nIGNvcnJlY3QgZGF0YS4gRG8gdGhlIHNs
ZWVwCj4+IGJlZm9yZSBlbmFibGluZyBGSUZPIGRhdGEgdG8gcHJldmVudCBwdXNoIG9mIGluY29y
cmVjdCBkYXRhLiBUaGlzIGlzCj4+IHJlcXVpcmVkIGlmIHRoZSBGSUZPIGlzIGFscmVhZHkgb24g
YmVjYXVzZSBhIHNlbnNvciBpcyBhbHJlYWR5IHJ1bm5pbmcuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6
IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgPGplYW4tYmFwdGlzdGUubWFuZXlyb2xAdGRrLmNvbT4K
Pgo+SSB3b3VsZCBsaWtlIGEgbm90ZSBpbiBoZXJlIG9uIHdoeSB0aGUgbG9jayBkYW5jZSBpcwo+
dXNlZnVsLiBXaGF0IHNvcnQgb2YgYWN0aW9ucyB3aWxsIGJlIHdhaXRpbmcgb24gdGhhdCBsb2Nr
IGFuZAo+bWFrZSBzZW5zZSBpbiB0aGUgaW50ZXJ2YWw/Cj4KPk90aGVyIHRoYW4gdGhhdCBsb29r
cyBmaW5lIHRvIG1lIGFuZCBkb2VzIGluZGVlZCBzZWVtIGxvZ2ljYWwgdG8KPmRvIHRoaXMgYmVm
b3JlIHRoZSBmaWZvIHN0YXJ0cwo+Cj5Kb25hdGhhbgoKSGVsbG8gSm9uYXRoYW4sCgp0aGUgbG9j
ayBkYW5jZSBpcyByZXF1aXJlZCB0byBwcmV2ZW50IGJsb2NraW5nIHRoZSBvdGhlciBzZW5zb3Iu
IFdlIGRvbid0IHdhbnQKdG8gcHJldmVudCBkYXRhIGNvbWluZyBmcm9tIGFjY2VsZXJvbWV0ZXIg
d2hlbiBlbmFibGluZyBneXJvc2NvcGUgZm9yIGV4YW1wbGUuClRoaXMgaXMgZXZlbiBtb3JlIGlt
cG9ydGFudCB0aGF0IGF0IGhpZ2ggcmF0ZXMgdGhlIEZJRk8gY2FuIGVhc2lseSBvdmVyZmxvdwp3
aGVuIHNsZWVwaW5nLCByZXN1bHRpbmcgaW4gZGF0YSBsb3NzLgoKSSB3aWxsIGFkZCBzb21lIG1v
cmUgZXhwbGFuYXRpb25zIGluIHRoZSBjb21taXQgbWVzc2FnZSBmb3IgdjIuCgpUaGFua3MsCkpC
Cgo+Cj4KPj4gLS0tCj4+ICBkcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYw
MF9hY2NlbC5jIHwgMTIgKysrKysrKystLS0tCj4+ICBkcml2ZXJzL2lpby9pbXUvaW52X2ljbTQy
NjAwL2ludl9pY200MjYwMF9neXJvLmMgIHwgMTIgKysrKysrKystLS0tCj4+ICAyIGZpbGVzIGNo
YW5nZWQsIDE2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2lpby9pbXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9hY2NlbC5jIGIvZHJp
dmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfYWNjZWwuYwo+PiBpbmRleCA0
YjBlM2NkOGE1MDYuLmQ4ODljMWRjZWVjMSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy9paW8vaW11
L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfYWNjZWwuYwo+PiArKysgYi9kcml2ZXJzL2lpby9p
bXUvaW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9hY2NlbC5jCj4+IEBAIC0yNTQsMTUgKzI1NCwx
OSBAQCBzdGF0aWMgaW50IGludl9pY200MjYwMF9hY2NlbF91cGRhdGVfc2Nhbl9tb2RlKHN0cnVj
dCBpaW9fZGV2ICppbmRpb19kZXYsCj4+ICAgICAgICAgICAgICAgZmlmb19lbiB8PSBJTlZfSUNN
NDI2MDBfU0VOU09SX0FDQ0VMOwo+PiAgICAgICB9Cj4+Cj4+ICsgICAgIC8qIHNsZWVwIG1heGlt
dW0gcmVxdWlyZWQgdGltZSAqLwo+PiArICAgICBzbGVlcCA9IG1heChzbGVlcF9hY2NlbCwgc2xl
ZXBfdGVtcCk7Cj4+ICsgICAgIGlmIChzbGVlcCkgewo+PiArICAgICAgICAgICAgIG11dGV4X3Vu
bG9jaygmc3QtPmxvY2spOwo+PiArICAgICAgICAgICAgIG1zbGVlcChzbGVlcCk7Cj4+ICsgICAg
ICAgICAgICAgbXV0ZXhfbG9jaygmc3QtPmxvY2spOwo+PiArICAgICB9Cj4+ICsKPj4gICAgICAg
LyogdXBkYXRlIGRhdGEgRklGTyB3cml0ZSAqLwo+PiAgICAgICByZXQgPSBpbnZfaWNtNDI2MDBf
YnVmZmVyX3NldF9maWZvX2VuKHN0LCBmaWZvX2VuIHwgc3QtPmZpZm8uZW4pOwo+Pgo+PiAgb3V0
X3VubG9jazoKPj4gICAgICAgbXV0ZXhfdW5sb2NrKCZzdC0+bG9jayk7Cj4+IC0gICAgIC8qIHNs
ZWVwIG1heGltdW0gcmVxdWlyZWQgdGltZSAqLwo+PiAtICAgICBzbGVlcCA9IG1heChzbGVlcF9h
Y2NlbCwgc2xlZXBfdGVtcCk7Cj4+IC0gICAgIGlmIChzbGVlcCkKPj4gLSAgICAgICAgICAgICBt
c2xlZXAoc2xlZXApOwo+PiAgICAgICByZXR1cm4gcmV0Owo+PiAgfQo+Pgo+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfZ3lyby5jIGIvZHJp
dmVycy9paW8vaW11L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfZ3lyby5jCj4+IGluZGV4IDI1
M2JmNTcxNDM5ZC4uMzQwMzdiOWMxZjgyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2lpby9pbXUv
aW52X2ljbTQyNjAwL2ludl9pY200MjYwMF9neXJvLmMKPj4gKysrIGIvZHJpdmVycy9paW8vaW11
L2ludl9pY200MjYwMC9pbnZfaWNtNDI2MDBfZ3lyby5jCj4+IEBAIC0xMjYsMTUgKzEyNiwxOSBA
QCBzdGF0aWMgaW50IGludl9pY200MjYwMF9neXJvX3VwZGF0ZV9zY2FuX21vZGUoc3RydWN0IGlp
b19kZXYgKmluZGlvX2RldiwKPj4gICAgICAgICAgICAgICBmaWZvX2VuIHw9IElOVl9JQ000MjYw
MF9TRU5TT1JfR1lSTzsKPj4gICAgICAgfQo+Pgo+PiArICAgICAvKiBzbGVlcCBtYXhpbXVtIHJl
cXVpcmVkIHRpbWUgKi8KPj4gKyAgICAgc2xlZXAgPSBtYXgoc2xlZXBfZ3lybywgc2xlZXBfdGVt
cCk7Cj4+ICsgICAgIGlmIChzbGVlcCkgewo+PiArICAgICAgICAgICAgIG11dGV4X3VubG9jaygm
c3QtPmxvY2spOwo+PiArICAgICAgICAgICAgIG1zbGVlcChzbGVlcCk7Cj4+ICsgICAgICAgICAg
ICAgbXV0ZXhfbG9jaygmc3QtPmxvY2spOwo+PiArICAgICB9Cj4+ICsKPj4gICAgICAgLyogdXBk
YXRlIGRhdGEgRklGTyB3cml0ZSAqLwo+PiAgICAgICByZXQgPSBpbnZfaWNtNDI2MDBfYnVmZmVy
X3NldF9maWZvX2VuKHN0LCBmaWZvX2VuIHwgc3QtPmZpZm8uZW4pOwo+Pgo+PiAgb3V0X3VubG9j
azoKPj4gICAgICAgbXV0ZXhfdW5sb2NrKCZzdC0+bG9jayk7Cj4+IC0gICAgIC8qIHNsZWVwIG1h
eGltdW0gcmVxdWlyZWQgdGltZSAqLwo+PiAtICAgICBzbGVlcCA9IG1heChzbGVlcF9neXJvLCBz
bGVlcF90ZW1wKTsKPj4gLSAgICAgaWYgKHNsZWVwKQo+PiAtICAgICAgICAgICAgIG1zbGVlcChz
bGVlcCk7Cj4+ICAgICAgIHJldHVybiByZXQ7Cj4+ICB9Cj4+Cj4+Cj4KPg==
