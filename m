Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F8E481ABB;
	Wed,  6 May 2026 14:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079147; cv=fail; b=q82aiZyqgnOQiaLe0ZcmXuQvLmYmIrAgUNOu35L+c5ewG2apKPUkY+rziHyzmFLctAx0JV6Rz17TJSVNwQKgp0l5yK/t9LSXAANYvQC4si556XyWSBDm2gbdQ7asynanxneB1YMpU5WdcUYvHn5MQHaW5WHF93HeyAKC7BawLEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079147; c=relaxed/simple;
	bh=tQaM1K0ysXb0Olwt3O6jMmHF2KC/cpUAMGsAns6965E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eiWFn6hMudzDeOKPSTjpGN4pLlPBkQtdM+334B4lFpDUP9nwKcz14hqZqiO9qZWysPHYeRQEDiLrxVp9xpqs/x9izg+2/R+HhugDnIhVefq3M8a6cZJLN3my/0noL/7an1YN0wP4mLlzq8DDuq2BohBrAPQRpYY6flVrgx4dbpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=VhIUXAN5; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="VhIUXAN5"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 646BL7w13122196;
	Wed, 6 May 2026 10:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=tQaM1
	K0ysXb0Olwt3O6jMmHF2KC/cpUAMGsAns6965E=; b=VhIUXAN5yvTPzHnq84mrz
	qMFaiEvXbviElLusLbIBdjCX77d1m2Jk3/qb4AyObDRYlNfMkThR0qkMjO3AntoE
	lcRT5S/w3IiMryFfFc9P2IF1EV/seKQrLq2tMOQuXgKwr6qfmX/H04XhijxuAZ/w
	CaNuwepxN5d/RgY0ProihyiR8sIWW31Lsmxt4Bkij4us3j+ZEolEF6Am71d7j1oD
	jyUTLbjN/lJoJSUxIlZGO2vnZ89ZhNdSVggWP6LBuHy69IzYmXa84p25cAJCR4E1
	UkD48wN0u4e+rRv9dR1kunaTn/CkxlWovywH4NmWHxl5G6gzCHaoI5rXSpIwRGPN
	Q==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013023.outbound.protection.outlook.com [40.107.201.23])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e04pj8qcc-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 06 May 2026 10:52:08 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QoaPKeWnVBNYxJIEEulaKmqUY5Xl1px6WzrALEp+INzBBcPoP/X4kSkOUHgDmtSV8W8QQBZ0oFT05Q+p6Ofp53oK1xWhJfsFl+ujvpkIXfeZD2fonn5i7X+aTgrZ4jR+T5sFLfIp1np9rHP97t+ETXU3SJnN1mM82LIWny04qL98t7rQM22kGJbMwk+oBYp9fFHLV0GproMQsMy9HQDBHd5uuWyv+2ZtbYUavLej4OSpeIrsi+ZM8/HcjfGEPeV+Lwe8DGaUQPQInfyLnCjuMsPT0IYBh5yx9meVWDpCAu2C+fRqpWDgjLT5lxdycbfWlxbC7AO+FpTqwP9uWwvbDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQaM1K0ysXb0Olwt3O6jMmHF2KC/cpUAMGsAns6965E=;
 b=fC343aeO3k0TQQm/bhE1eQAGbubO9xMasRAxLcW6Wy5psfqTw89ytDr4fCrj0EgtpcSoAtj8JLz8eTRCob/RAsWi4ZtsLgmP78yy6eDgsXR9s+CBmJN82c3qYFVqn3vJC14E1yY59TBIv7VzmC3UZ4oMyyTssXwG/9CL1ktIzw5pG49cdC9lj2fdtAoks6zWo/If1cwbieWs6uAvzUyFJhE6Z1C/84v5CiMSUAb6r2XgWEsCTZehyTCZ+Jze4180W4RzVGaqK/GBeLVwdpVe4NB3lD0BQMkwPAvoOkNtuo2UW7PyLZYShJU9CnyPwmkLLMMNi4zTrnnFwsM1g3y8/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA5PR03MB8377.namprd03.prod.outlook.com (2603:10b6:806:47d::22)
 by PH0PR03MB6558.namprd03.prod.outlook.com (2603:10b6:510:b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Wed, 6 May
 2026 14:52:04 +0000
Received: from SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438]) by SA5PR03MB8377.namprd03.prod.outlook.com
 ([fe80::9276:9909:1b4c:8438%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 14:52:04 +0000
From: "Stan, Liviu" <Liviu.Stan@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: Lars-Peter Clausen <lars@metafoo.de>,
        "Hennerich, Michael"
	<Michael.Hennerich@analog.com>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/2] dt-bindings: iio: temperature: Add ADT7604 support to
 adi,ltc2983
Thread-Topic: [PATCH 1/2] dt-bindings: iio: temperature: Add ADT7604 support
 to adi,ltc2983
Thread-Index: AQHc1knlqBPOAtVfc0qFKzHj3Vhl67X0klKAgAx0nkA=
Date: Wed, 6 May 2026 14:52:04 +0000
Message-ID:
 <SA5PR03MB8377E2EFE0F838C0EBD70AA6F63F2@SA5PR03MB8377.namprd03.prod.outlook.com>
References: <20260427132526.272716-1-liviu.stan@analog.com>
	<20260427132526.272716-2-liviu.stan@analog.com>
 <20260428155819.3b56a3fa@jic23-huawei>
In-Reply-To: <20260428155819.3b56a3fa@jic23-huawei>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA5PR03MB8377:EE_|PH0PR03MB6558:EE_
x-ms-office365-filtering-correlation-id: 2b85b5a2-1c6f-45b5-a6f4-08deab7f0987
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|1800799024|366016|376014|38070700021|56012099003|18002099003|22082099003;
x-microsoft-antispam-message-info:
 35JnykTwNcALgXn765ggOxWOy0pkw2Y8qqpjaE5uYS64f8ZbUbMRrCXnRVbw/qXj4IPUF45cJmTQ79mjbuLyVVp6pB5GCrTVJk+TPBQTv9J/OrJVZ8iCc+xHm6EYNNX7xB/TDm4ue6yXx4RhJj66fZm2jRvue+A3fY/bp/MzSl1JajmY1vgASlazwQuFwza4BYbOhdgqXP7XJQoVNAsdDXDt55lvVxsHFUSbAor2pNprAZefKEnmXvw2TYdkYOxegvynuc6XsTG7MN0RBzii5qn5unNGubEC0uVVqJNbjCBe5QJdrhtjWmOXMK/ROgc0bArp+f5pmtdl9Fq+fdtVXQhmoJ1/nWweeqHWtFjIEhh2LQQkG+qPYci41qeM1DbcURJUcquFa26Ulvc1JFMQCPPpo3y7Abd5CA0bRdWEwJiCwQuwHOIcDqZDrrpw2vgNCYdVQ/ggF+hPKdkoe2QdOYp9kZp2fS3Zx6l7D6xeKJXzndJsw3saD3DreJ6q/Yk0AKCriDvVYEMoz7BDqCB0IQy8HdKYb8oYi4FN9A8eebMmQe/sSoSdo+yTWqJTIhxtA/Oc72AsDkLHuPYeGyyHQjkhQDTvpaYyFRE0dSIqTSkKN8Ua/82WYSZUNvofFcvZKm40aXMtl2E6FDlUHiLkVLkmVCBQUFDoMG+NQOxouQJmIDqEQQ+mezxmKiEZaybdbXMxuoBxf54ervwj2k3LdmrwGBWNzZjYFYTEeVD104ch35/FTmGJcrmEIfxCCJhJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA5PR03MB8377.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(38070700021)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NkZPVzR1T1NRUm9MM0I2QkM5VjJiSlZpdVJ4bnBSNHhOcFdnY2xnOVIxeTQ4?=
 =?utf-8?B?QjV3eG4wVGs0dm9id0JDclFFc0w0QldmZ1NHRXFBM2lsbEl2TUdsNUc0MzZE?=
 =?utf-8?B?NzBxU3h3NVE4QXhqWHZHaTl4akhDS3NzOFRCeGJvQ3h1K21ZMWhnNlBJL0lO?=
 =?utf-8?B?THBQODFRTzRiZHZGM2FCYTRYSmZTYTh0clhGckJwSmpqMUsxWCtGd0VsUS81?=
 =?utf-8?B?SVhRT01lM2syVE5vbnNNSWhUZGhXa0ljam1SNEd0MVRiZVlRa3FXNDJxYUFQ?=
 =?utf-8?B?NGhxNkh4aGVyell3T0hyR1dwU21sWlJpTnJQSmk5bzZZOFFkQnVTZzVTQzZr?=
 =?utf-8?B?eXJnbzU1czFNSldmRTMybE9xY0w4VEdubjV1cFFDRFlJQmdWY3NPbEJDTUNC?=
 =?utf-8?B?b3NHeHJHdHJSZExqT0FXSVFkVnZ1TUZ1ZU9BeG5uOTB0SVhVa1EvZGRSVmNz?=
 =?utf-8?B?YXE5eVFPajY5clNYRlo2TUxOVmRqN3l5Tm0zQzJTYithVGtnb2JzZnBqVkQ2?=
 =?utf-8?B?N1dOZjJaQmhndXRnV1dkZEJyOTJkYTNMMjErc1BWQ0ZwS3REWXhOUFJMK0M0?=
 =?utf-8?B?UUlFcXAydWhGVnRuYzdsdldFMEdvUlNFbjM5QXdpenNRL1RCamxvWWJjSzYr?=
 =?utf-8?B?NDRuaHAzT2lERVA5b1ZIQm9lR2dGRG9XWGNzYXNIZ1g4dHBlQUNhbU1hNCs3?=
 =?utf-8?B?SmV0VFdQbzRmMkpybFB4NjVqNXBISzBhc2tIa2Z5V3lXOU5EQzBxcXorTFQv?=
 =?utf-8?B?ZTdxYXo3TE41SHJaQm51RnZRZ1pDTytXUURFV3VWSExzNzRkcTl3dTJUK1pC?=
 =?utf-8?B?MmE1RFlLRllWQm1KVHUvR2l5RzVyYmVkU0NhS1ZFNmo3bUIvaXltbXdKSVJ1?=
 =?utf-8?B?cVF6QkJSZ1plMEF0ck5VNW9RUmVMUVRJamxIU1lHdi8xWVBCd2pMTXhpYTlZ?=
 =?utf-8?B?YW81Vm05UjV1NDYwNnByMVdhNi9VZG93YkNOejdmelp5dmdyczUyZVBHS1dr?=
 =?utf-8?B?UjdDblZOYXpOMmRvRm1GVENIV3l2dm5rV2daaWxxWFUyRXl5Y2NibFdLS3pG?=
 =?utf-8?B?dzdkZnJzQ1crSW9nNkM3dmFXNTVXc2lTeEVSSGFUVU5YelJrUGJXZjFOWjRG?=
 =?utf-8?B?TVE0MzNVSmpvMXJrS0VGcytqeG1DcHlkVU9nRDZ4Y21YMkdQTzEzMnNLRHVG?=
 =?utf-8?B?Q1VNQ0lzUENQWCtubUxVQzBoNjNRb3AyU1N3MTRheUJYbmJuUThncFlUZjVn?=
 =?utf-8?B?UXZrNVVVb0MzWVRkaUdLQnNJck5oUFcyaVhDei9ZT0lYbENLU3l2cGJNeTh2?=
 =?utf-8?B?WDJFSVQweWlJS2k5d1krcWJZaEc3ZkViUTkxWE9HSFpnbFlESDJ0Y3lpcm5w?=
 =?utf-8?B?TGtqcWlpd0RicURXbG85a2dSVkhzYzM0aUNIczQzODRiQXdXL0N1MmUvenZs?=
 =?utf-8?B?WForU1E0VWpxRERLaUVGYUJjZlltd0p2N3VGQnhkaXZnaHJMaGtBMHMxMUhE?=
 =?utf-8?B?NklGZjllUzBTc3V0aFAzVWlubHNHdThGOHBxYmQ1Q0VmYXdrdGYzTXE4Rndi?=
 =?utf-8?B?WE1MNVNHUGx0MmVWVmY0L1JaZzhsaXNRL3A2cG52UzhSQ3FwelNDcDh2Z2ky?=
 =?utf-8?B?N3Y5WVlUcFBRYjR4TjBoUE9LbnBSUEUramtTQ0VZM0R1VC9xaXN2OXdOMkJT?=
 =?utf-8?B?TW9hc3lDKzh1RC9ucFE4ZGI1UlUyWjZVRXFBSmdxSzhGeUR1aVlxUTh0aHhx?=
 =?utf-8?B?bmhGbEJaYUl3aDJ6NFVhRWpMTy9tNjlLNnZMZDhkVUJiZ1ZjQzZxZ3ZnM1BH?=
 =?utf-8?B?a0NENU1jS2tBTmY4MjJFTVhWdWk1YTZnVGVhaXNtQVRjMHJoOXlGcmJpcmZU?=
 =?utf-8?B?T2lLYmtETEZpSFZkSmdKc0M2OXJrQitWVEFXTnZsSUpVUE9hanVuUWlySzBJ?=
 =?utf-8?B?bHBTU0tic3hMa2VzdUMrcVVjQTlESGcyUVlUMUtqWEV1OVg1bXU0S01rbFAv?=
 =?utf-8?B?OTRDNE03Uk40L0ZJZ1htNlJGbkI3SlJaS1FldStSTldGTFA1YWhHczlrbmpZ?=
 =?utf-8?B?My9maXFxZlNBMThkbUdSbjBkelNtRlVZZUZCUGpyVzBCalp2VWVlYk54Tnpj?=
 =?utf-8?B?UWlFc1pRZ3A4Z3pQeGo1KzVVaHlBL2NlM2g0Mloxc0hBeThkaU01bXBsY0tx?=
 =?utf-8?B?Rnk3SHNzOFFhMStTMGorOWtIaE1GYnRVL1U5bHlwYXBVeWVuclIxUzkwSGgy?=
 =?utf-8?B?cVAvd0d5cDVOU0UvdE1XR2M3bzZ6YlNyNktaUEYvdTNXMnFRWXFWM2R6N1ND?=
 =?utf-8?B?TXM4OHZWU3liYnhQOS9uVU5XWjFzUytua2cwamVEL0gxT1pDdmcvUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	isIQsRj7pJ0p6Ocz1rDaojR/4HIHPpkmjd3+S8fgD+WD4t54xiQy3zPTH+cmZ2otK32aK2JqELVutH/2Pe3y+sBsXu/S/Hi7EyQIUOCry7Fu8/pRdw1EYO5kiGoc0x2dhrSbcalFFgN4lKtur2LE8L3mULWsyLdsLpez5QZuMeIr3L/SnJAUZuYH4v6SiGhY7wWcxUJkzy9ZFTI7tN1NB/CiCdsvLwR44ac/7yd57EgJW3T7asLbIP4cWL+PWSjx+o8bLUf7ahA6dxR1/w/vpS/WycO83wmu2naIm3k1mxULyRi7mxM5MRWqenoyIzvIbhuYlNXXFOYlJc7TFYD3Zw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA5PR03MB8377.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b85b5a2-1c6f-45b5-a6f4-08deab7f0987
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 14:52:04.2092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FMf3SGuCSPeRNlottDRgBQtrD14TiexKn8ISKOTYICjhUZ9tyYGRAEl01xfJ9nNyDa7UIedkEvjuv6O6T77WGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB6558
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE0NSBTYWx0ZWRfXzks7hsENoRpR
 0Hs2e/aZfqtTs54Fg/bXsGNS8h6vhRsdwUtv78AVe6f85g9snMh3rBeMiYm/hcf05i+1kE/epmU
 fFnrlLnbJXh2ToFw1FGxPwJWDKtLW+sOrG3g6PelBUL2997ZF/g2QuUti45DudIxjZ4UPGu5ro0
 deY3H6XtLwQe6T3Mqb14emHbFpLwtPQ42p/Y9nviZm+sDloYN0qi66XCQmAuTwv3wvPCpTBRu84
 zb1w4yUOV/hImt5QZvclLwhCnLOqWKk+gSB68IsKAXkkS/n3j9/F7SN+Av0NMAdOxsiv+ohC5mf
 6b+QDAKSb6HtRFZhy0Q3bBemFL0+3iKsXaU5nLVDI/L0OVUCh59gRb/w1GIBGwGVY30LR9dzPw2
 qcyQYDTt6DHBz20aGUBUDwcYNkTz73ht9ROYEVGMi0rNAzmmAC/H5RLPGZ5RduBJnmcYzAjyiiC
 x81Hjxplwi3WyIhoTyA==
X-Proofpoint-ORIG-GUID: PTWsuMATCbClAcuepmwqoHoqc1L9Q7ed
X-Proofpoint-GUID: PTWsuMATCbClAcuepmwqoHoqc1L9Q7ed
X-Authority-Analysis: v=2.4 cv=Fss1OWrq c=1 sm=1 tr=0 ts=69fb5598 cx=c_pps
 a=JigUrrSO7vm3KiUpdjzzBg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=4MmxKt1G4FNLRmsm7dUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 clxscore=1015 bulkscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060145

VGhhbmtzIGZvciB0aGUgY29tbWVudHMsIGhlcmUgYXJlIG15IGFuc3dlcnM6DQoNCk9uIDI4IEFw
ciAyMDI2LCBKb25hdGhhbiBDYW1lcm9uIHdyb3RlOg0KPiBJIGRvbid0IGtub3cgbXVjaCBhYm91
dCB0aGVzZSB0ZW1wIHNlbnNvcnMsIGJ1dCBob3cgaXMgdGhpcyBkaWZmZXJlbnQNCj4gaW4gcHJh
Y3RpY2UgZnJvbSBhIDItd2lyZSBSVEQ/ICBPYnZpb3VzbHkgb25lIGlzIGNvcHBlciBhbmQgdGhl
IG90aGVyDQo+IHByb2JhYmx5IG11Y2ggbW9yZSBwcmVjaXNlIHBsYXRpbnVtIGJ1dCBkb2VzIHRo
YXQgbWF0dGVyIHRvIHVzPw0KDQpUaGUgbWFpbiBwcmFjdGljYWwgZGlmZmVyZW5jZXMgYXJlOg0K
DQotIFRoZSBwcmltYXJ5IG91dHB1dCBpcyBJSU9fUkVTSVNUQU5DRSwgcmVhZCBmcm9tIHRoZSBy
ZXNpc3RhbmNlIHJlc3VsdA0KICAgYmFuayAoMHgwMDYwLTB4MDBBRikuIFRoaXMgYmFuayBpcyBt
YXJrZWQgYXMgcmVzZXJ2ZWQgZm9yIHRoZSBvdGhlciANCiAgIGRldmljZXMNCi0gU2Vuc29yIGNv
bmZpZ3VyYXRpb24gYml0cyAyMToxOCBhcmUgaGFyZGNvZGVkIHRvIDBiMTAwMSBmb3IgYWxsDQog
ICBjb3BwZXIgdHJhY2UgY29uZmlndXJhdGlvbnMuIEZvciB0aGUgc3ViLW9obSB2YXJpYW50LCBi
aXRzIDE3OjAgYXJlIA0KICAgYWxzbyB6ZXJvZWQ7IGEgPjHOqSB0cmFjZSB3aWxsIGhhdmUgdGhl
IGV4Y2l0YXRpb24gY3VycmVudCBhbmQgYW4gDQogICBvcHRpb25hbCBjdXN0b20gdGFibGUgaW4g
dGhvc2UgYml0cy4gRm9yIHRoZSBleGlzdGluZyBjdXN0b20gUlREIGFuZA0KICAgdGhlcm1pc3Rv
ciB0eXBlcywgdGhlIGN1c3RvbSB0YWJsZSBpcyByZXF1aXJlZCBieSB0aGUgYmluZGluZy4gRm9y
DQogICBjb3BwZXIgdHJhY2UsIGl0IGlzIG9wdGlvbmFsIChhbmQgZm9yYmlkZGVuIGZvciB0aGUg
c3ViLW9obSB2YXJpYW50KS4NCiAgIEFuZCBmb3IgbGVhayBkZXRlY3RvciBhcyB3ZWxsIGl0IGlz
IG9wdGlvbmFsLg0KLSBXaGVuIGEgY3VzdG9tIHRhYmxlIGlzIHByZXNlbnQsIGEgc2Vjb25kIElJ
T19URU1QIGNoYW5uZWwgYWxzbw0KICAgYXBwZWFycywgcmVhZGluZyBmcm9tIHRoZSB0ZW1wZXJh
dHVyZSBiYW5rLiBTYW1lIGR1YWwtb3V0cHV0DQogICBiZWhhdmlvciBmb3IgbGVhayBkZXRlY3Rv
ci4NCg0KVGhhdCBzYWlkLCB0aGUgaGFyZHdhcmUgdXNlcyB0aGUgc2FtZSBjdXN0b20gUlREIG1v
ZGUgKHNlbnNvcg0KdHlwZSAxOCkgaW50ZXJuYWxseS4NCg0KPiBJJ2QgZ28gd2l0aCAiTFRDMjk4
MyBhbmQgc2ltaWxhciIgZm9yIHRoZSB0aXRsZSBub3cgYXMgaXQncw0KPiB0byBsb25nLiBMZWF2
ZSB0aGUgZGVzY3JpcHRpb24gdG8gbGlzdCBhbW91bnQgbW9yZSBpbmZvLg0KPg0KPiBBbHBoYWJl
dGljYWwgb3JkZXIgYW5kIGl0IG1pZ2h0IGJlIHdvcnRoIHRoaW5raW5nIGFib3V0IHN3aXRjaGlu
ZyB0aGlzDQo+IHRvIGEgYnVsbGV0ZWQgbGlzdCB3aXRoIG9uZSBkZXZpY2UgcGVyIGxpbmUgYXMg
aXQnbGwgbWFrZSBhZGRpbmcgbmV3IG9uZXMNCj4gbmVhdGVyLiAob2J2aW91c2x5IHRoZXkgYXJl
IGFscmVhZHkgbm90IGluIG51bWVyaWMgb3JkZXIsIHNvIGZpeCB0aGF0IHRvbyA7KQ0KDQpXaWxs
IGRvLg0KDQo+IElzIHRoZSBhYnNlbmNlcyBvZiB0aGVtIGVub3VnaCB0byBpbmRpY2F0ZSB0aGlz
IG1vZGU/ICBJLmUuIGFyZSB0aGVyZSBvdGhlcg0KPiBtb2Rlcw0KPiB3aXRoIG5vIHNwZWNpZmll
ZCBleGNpdGF0aW9uIG1vZGUgb3IgY3VzdG9tIHJ0ZCB0YWJsZT8NCj4gDQo+IEknbSB0cnlpbmcg
dG8gd29yayBvdXQgaWYgd2UgY2FuIG1hcCB0aGlzIHRvIHRoZSBleGlzdGluZyBiaW5kaW5nIGZv
cg0KPiBjdXN0b20gcnRkIGp1c3QgYmUgYWRkaW5nIG1vcmUgY29uc3RyYWludHMgKyBtYWtpbmcg
ZXhpc3Rpbmcgb25lcyBtb3JlDQo+IHNwZWNpZmljLg0KPiANCj4gSSBkb24ndCBtaW5kIGlmIHdl
IGNhbid0IGFuZCBoYXZlIHRvIGFkZCBhIG5ldyBjaGlsZCBub2RlIGRlZmluaXRpb24gYnV0DQo+
IEknbSBub3QgeWV0IHN1cmUgdGhhdCdzIHRoZSBjYXNlLg0KDQpZb3UncmUgcmlnaHQgdGhhdCB0
aGUgYWJzZW5jZSBvZiBib3RoIHByb3BlcnRpZXMgY291bGQgaW1wbHkgc3ViLW9obSBtb2RlLCAN
CnNvIEkgdGhpbmsgd2UgY291bGQgZHJvcCB0aGUgYm9vbGVhbi4gQnV0IHRoZSBpc3N1ZSB3aXRo
IHJldXNpbmcgcnRkQCBpcyB0aGF0IA0KYWRpLGN1c3RvbS1ydGQgaXMgY3VycmVudGx5IHJlcXVp
cmVkIGZvciBzZW5zb3ItdHlwZSAxOCwgYW5kIHNldmVyYWwgDQpSVEQtc3BlY2lmaWMgcHJvcGVy
dGllcyAoYWRpLG51bWJlci1vZi13aXJlcywgYWRpLHJ0ZC1jdXJ2ZSwNCmFkaSxyc2Vuc2Utc2hh
cmUpIGhhdmUgbm8gbWVhbmluZyBmb3IgY29wcGVyIHRyYWNlIGFuZCB3b3VsZCBuZWVkIHRvIGJl
IA0KZm9yYmlkZGVuICh0aGV5IGNvdWxkIGFsc28gYmUgaWdub3JlZCBpbiB0aGUgZHJpdmVyKS4g
SW4gbXkgb3Bpbmlvbiwgc2VwYXJhdGUgDQpub2RlcyBmb3IgYm90aCBjb3BwZXIgdHJhY2UgYW5k
IGxlYWsgZGV0ZWN0b3JzIHdvdWxkIG1ha2Ugc2Vuc2UsIGJ1dCBJJ20gDQpoYXBweSB0byBnbyB3
aGljaGV2ZXIgd2F5IHlvdSBwcmVmZXIuDQoNCj4gSSdkIGF2b2lkIGRlc2NyaWJpbmcgdGhpbmdz
IGFzIHh4IG9ubHkgYXMgdGhhdCB0ZW5kcyB0byBiZWNvbWUgd3JvbmcgZmFzdCENCj4gQmV0dGVy
IHRvIHB1dCB0aGF0IGFzIGEgY29uZGl0aW9uYWwgb25seSAoYXMgeW91IGhhdmUgYmVsb3cpDQo+
IE1heWJlIGhlcmUgeW91IGNhbiBzYXksIChzb21lIHBhcnRzIG9ubHkpIG9yIHNvbWV0aGluZyBs
aWtlIHRoYXQuDQoNCldpbGwgc3dpdGNoIHRvICJzb21lIHBhcnRzIG9ubHkiLiANCg0KVGhhbmtz
LA0KTGl2aXUNCg==
