Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFF53F20E5;
	Mon, 18 May 2026 12:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779108964; cv=fail; b=W0xO3e5zsMpFkqziMrCiGSrCm4g8XdDYzPGI3RcAnfUJF/fLNILvXGIl+YG/ZkPl9xYMFotndYnY1b3kJFy/G+6VSfpRQQ3It7iXMzzV/+ISJTkO+xRV/38EQx6FRwfqWWnnKA96noaYv+5R1H1LlIeoBLVce/bRGf3GS0QMXaQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779108964; c=relaxed/simple;
	bh=AYMWyApBgMLMWFmimBMMqS2eoLve9qasUaPFIg65aA0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QORgUWuO8d96bR0lHZVq33YAxL/lbPaiG6hiZ1l3dkxIeW6g1Am7Xecdy7cEij3Dvm1FVwKjPgtlP5QeEbpb8L3Gou5MX9hal34X4X0I3YTDHOI0Z7PWRUxQyC8SjRnKT5POG1odZqwCqzPKfQYQa3Uf4J9mAYoQdF8aGFo0Lzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=YAMg5M3N; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="YAMg5M3N"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I7dtba3483789;
	Mon, 18 May 2026 08:55:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=AYMWy
	ApBgMLMWFmimBMMqS2eoLve9qasUaPFIg65aA0=; b=YAMg5M3Nmp8PrAYffB6va
	J6TfwmTm6aM0JngYGBJjfPNrYrzZvX3TYkAlIKZAh8b2wLAckH3WvmQElEjGXxeZ
	TmSnKPPIiIKQShvohVZiWzG4Y5Xyst2HHJPLQxopQpYfCGFln2/hjKtf6rWQh7pY
	FYOGWPRsL3g2Xasi0x6aPaZXFOGopZYCRRfKPqhi76qjZrfMMzg9U58/s9pIEWVj
	yy4TaPbNr+7riHDa8LjPHVKLl/LTvw26AaZHU6wvcTZBcBF7EjpxtPVMLBGMIGTA
	fVRONhWuMxmGGT9buBbUr72bDz5L4aA1qdpKdm3bTYNmnbmSJ17bxslvS6WItqvo
	Q==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4e6jdxpcqy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 08:55:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jSyjEP0XDqkaqET0xTDMXjRb3H4GQArCrALoAD3Kh9LLdkyQEjLjAS8UY7dTNZGYuUtsDSJnzCnrLL5a2xPafClgeL/1fWDalHng6E6ZK8dBJkJJze/qGXKSAJOryj5EtEfKPShcdPCAbWazt8N9K6++AlsS6Qp3c8MjpaDV0iPv3ZfFgqLnQ03MN2wD64rvYTPmXiqkZD540K5uUV8SeLPLXgkjOqM4mI5DX2XQD5zWgB09rCK4c2RCjHD0GBsUe6/xFs9MLj/vEVwHqnUigyf0nX1Bam6zCmu0o1LZdqEIO28paa4RaZcEOgoT5FwoFhRNO3f3hx2mxjeSjwjPIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYMWyApBgMLMWFmimBMMqS2eoLve9qasUaPFIg65aA0=;
 b=KGxJATGPPm4NFQE/cx7qbWmp9xQ9hcAZ0hxe1xyZ9qBTFJa81J8JiZdjESze+6tU920BUvivcrbZgx737cwqeko461A9QQdi4AbDN8gLgTPIPCPsF6J340MbU8dXiyTf8lv8k2hGdjY/Ri/0hbrb15rw+9r4goHjBIt7GYbhIEPcHjA0g1sS6HpWeTSQNArUlXWHD9rvU5aJtKQ4dE67rbn+uc0jyKkOdO1JcMNMCJIGIET+0VPH8WavPiFKejfYdcaDlyI9R3Ist0Jo3vGTGiDDZSfcZMkpt9j25ykQjxreP2ptGylSq3OuQjaGlwlRK4562/L2xOJxO3TnDaXH8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from LV9PR03MB8414.namprd03.prod.outlook.com (2603:10b6:408:367::23)
 by CO1PR03MB5729.namprd03.prod.outlook.com (2603:10b6:303:96::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Mon, 18 May
 2026 12:55:33 +0000
Received: from LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81]) by LV9PR03MB8414.namprd03.prod.outlook.com
 ([fe80::d661:7c16:d052:cc81%6]) with mapi id 15.21.0025.023; Mon, 18 May 2026
 12:55:33 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        =?utf-8?B?VXdlIEtsZWluZSBLw7ZuaWc=?= <u.kleine-koenig@baylibre.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 2/2] iio: adc: ad_sigma_delta: fix clear_pending_event
 for registerless devices
Thread-Topic: [PATCH v3 2/2] iio: adc: ad_sigma_delta: fix clear_pending_event
 for registerless devices
Thread-Index: AQHc5qz5cSJVGXIPh0aNlYdsX1C1SLYTvAoA
Date: Mon, 18 May 2026 12:55:33 +0000
Message-ID:
 <LV9PR03MB84140C8048A51E50F241EA28F7032@LV9PR03MB8414.namprd03.prod.outlook.com>
References: <20260518-ad_sigma_delta-fix-v3-0-a2a92b0c36f3@analog.com>
 <20260518-ad_sigma_delta-fix-v3-2-a2a92b0c36f3@analog.com>
In-Reply-To: <20260518-ad_sigma_delta-fix-v3-2-a2a92b0c36f3@analog.com>
Accept-Language: en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV9PR03MB8414:EE_|CO1PR03MB5729:EE_
x-ms-office365-filtering-correlation-id: e849604b-908b-49f5-55b9-08deb4dcbfba
x-ld-processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|4143699003|11063799003|56012099003|18002099003|38070700021|921020|22082099003;
x-microsoft-antispam-message-info:
 iL0oQWPLKI7qkNUxhtC3ncrH1D/qt+IcJ5g2LXCdHSN4Hpg17IYnhrMFbObFQn73XM/VLGua6/Bh/kMMs7fxsVObY5UNINWuAKFKB9Y/WSHgAguUkVokmMSB18IVvolxvYckh/HspiR1kx4nuZjx/pk6/e773+OSfdxRBfo3CrXvvkxa6KgrMP8SDlKbq8AqcAI9VWe2PD2CvmphwjWTE8cCH5tfnVM+oTwbLOrk2DVoHzKSiDfCc5aTOhtG94p6zXI78ukNupXxGJWiAlgYvvWEE49lt7XoRdiRjgygYaxqe67dsuzfdQcXmj7YGJCs7yAyDxIQPnOnerGII3byQ5iE4ByTJFHks65HOz+Y/JHJcIWeffLBcDQ6C8pFvUzkav50PFhZ0ytOUIL05+zHyzVkQ6oSNIuILEtZsT7TDycwbwBhPgfjYMWXy2M1WuNTatLz3AdeRT/91cNYi27T4d1Z5NAc0Z3ym/JXZxhdpiNYtbA9K1NFdcTUytkttnoD15Row+yLSnCddlBGyPnpss1BWcCg8KH3fVeKVjsMbbwfE0cGli7W6erhb7OEhK6/dccLfzwqkLsGzr6grnjepN49ivH4FebuFiugQyB2GxfMdavkAzrW9BikuZe9QtweyUGckkXQX6v+868mMIauOQPOyrrgErlQoF7C9qHNN7Ezva/rXCcDyzQ9vti9Jg/W5mACaZu9Qhfp61oWzXwiE6/A0VvlS1L8zmZcpWfs5vbgB/6qN4NFOERpPs96QqB7RYzanM+aLbA/3XnVlYJRwQ==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV9PR03MB8414.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(4143699003)(11063799003)(56012099003)(18002099003)(38070700021)(921020)(22082099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cXB2cjRCZkZGYmpSZFNldWZtNjJuYkg5dXJnTWtSSVBmWCtPZDg5eWdrRFAz?=
 =?utf-8?B?VTRIY3VkVUEzL3cvSzVQUWFuRjBvaEM2R21Pb3NDVE1DR1gwcG85UWlCTzMr?=
 =?utf-8?B?YnErVEtxRWtzT3VDTFdUN2pSOEZFZ083Y0VjbWszaE5EK2NENisyemR0amJM?=
 =?utf-8?B?cmMrR1Rib2RSRzlIaUhURWlQNm9hdXdNUWNtWDZMckI1NUZtM0ZoOVBJS0sz?=
 =?utf-8?B?dHNVeGlSS1RiSGtjVU9zRHpxN2duTGlZQjB2Ly90WHk2RVdCV1d1N09NcWMv?=
 =?utf-8?B?cUN0TTVzUXk0aEFqM0V4MzNWeGhjNncrQmNzMlNqK1pZaEYwUGVrc0c5K0dl?=
 =?utf-8?B?Z3p3VWwzVldHWW84eXpHSE5UNS9vSThpWkNQZGdaUWRCNjJaRTRoeG4ybmRU?=
 =?utf-8?B?WDk5cDNKVHdLVWpoSVB6ejB1d3Z2TTV2V29EK2ZuUkZMeFBQdnJoZEJxWngw?=
 =?utf-8?B?WWRQYXV1NU1TTUVXcGQ0NFdycXBJSGdXTGJoRE5ZNHY2SW96Q1BSVjBoeGN0?=
 =?utf-8?B?cTR2UllYSGpoaVZveExpajRCR3lES3ZDd3N2TzRlZEEyRC9sME8yQ2xhNXZP?=
 =?utf-8?B?ajVpeWttUU56ZlVpWTVJYmpxck1ERzdYUGM3Y2loMVRRNm5YZitiL25Db2pi?=
 =?utf-8?B?L2oxNzVhRlFKcUlHM2JJM0xkUWFoNWdlY0xkOWZKZ3J6RUlJTFlabTZ6RjJk?=
 =?utf-8?B?Rm9LZU1BNCsrNm55QTR3ZndWR1ZWWjRXQVpSdnM3Wm9WVjYvVy96bmExby85?=
 =?utf-8?B?MEVGaEZpN1NXY1VjdGhLaitwNS9vNkNTY3J4dnVDQXhoaUc4My9PSlEwcmZk?=
 =?utf-8?B?ZFRmWHFoK0ZWOWtEU0N1YWJ5M1hEQ1Y5bm5KS3Y0ZUNMSkRHUWRhM3JFS3c3?=
 =?utf-8?B?bnVJQlQvWDBQWWh0T01IaHJ5YVlGSlFYM2lWZ3hYb01nVUJTQklHMWljMU9l?=
 =?utf-8?B?YVkxbEkva3RUS25uVDhYajdCZVF3TjVqSHkwb2MyTEY1UHBHL3hWMjRvK2Zq?=
 =?utf-8?B?RDl2eVRZZXk0NXE2a1hsWUlsZHdZQWMxVmVWdWdSalh5RDdHekhZSHlSZHp6?=
 =?utf-8?B?TkdTL21GWk5DL29GOVUwR0kzSUdIRmFWdldYdUtBWDB3WVU4K1JZVVl2WXMx?=
 =?utf-8?B?b1NPU1Q1SWs4dG9mb3lDQ2VPMkt3dVB2dVFzRFY4ZUFzTUtDN09VTWxJTE4r?=
 =?utf-8?B?MW1wUFg1Tm5GdzR2RTFuM1lIUFpmVzJTampaZlNZRGtXdTNjdFZPVXdLU1dP?=
 =?utf-8?B?NVlKZGVEZVRyMVFhSXNkbjYvblZIOFREeWlXcEtWYTY5WFN4a3VhMzd2TnZF?=
 =?utf-8?B?ZTh5T2Rwc3hmYjRmd3JMSXdTMHZkRWlTaXpSUFBXOEprTmdleTIyZDk2ZEdr?=
 =?utf-8?B?TE5sK1hSZGt6QjAyL1VJQzRIY0lyMnN3YXU4T0FmV2htdWltY0hxbkFVaDhB?=
 =?utf-8?B?YXN6eklJbU1nN29YMU5CTW5tYVNLUWsvTWNJZUFFMFFpQUdaNzZIUlNibmd1?=
 =?utf-8?B?T3ZuTkg4OHlsOXFoc1ZOcjUybGtHN00yTHhIKy9qNGlwSERhWk9kMXI3TTEv?=
 =?utf-8?B?a2tnemFvWm1KU1cyUE1ySVVaRm5qcVVzSVhDWU5CUk5RYS9vNkswTnhYaG9P?=
 =?utf-8?B?OVcra0lXU1BEclVsTkUwTVZLL2FHa3RWU2tzYWo3S3pYSE5KSmpxWjFwMlhG?=
 =?utf-8?B?bUdXN3QwTlZrNysvR2IxOGx3ei9BNmU1UndtNnJoNTlGeVJjQjNKclRyWjFL?=
 =?utf-8?B?VjMvQ3NRUkZVUlBBYkpWRXRlQXlmMlNxa1BOMWdVbTE3Sm9wUkZhOGUwR0R1?=
 =?utf-8?B?M2lHUmY5N1VFNFBJZEZVWUsrWHhSNittUy9Gb1JBQmpmdGdDV3hOczVyWmk4?=
 =?utf-8?B?N3E3Z29HQnNOUmhVcXBQeGNzdWNJaVRuYkNGRUpiZG94OElhNFFuZm12OXpE?=
 =?utf-8?B?TnNPY3lYSllJS0haT2p3UFIrTE9OYkVHSjN3MFo3S0lvR1FHZWVXWExPWkJH?=
 =?utf-8?B?RFpyc21FTGx1N3EyKzFGUW96SVVqdEFLUXI1dXN3MjdsN2lEZDNROVlRS2pD?=
 =?utf-8?B?NXZOczdRMkhWNjduNWdyT1Vkc1IwRXYxak1Xd2dWUFJiUGpsZFNqUFNqUFFp?=
 =?utf-8?B?RS9mWDROalhhVmgzdS96bVc3cmxEM0dVTFRMV3E5ZTdMazd3N2ZrSCtvc25M?=
 =?utf-8?B?Z0VSUnpuNjQ4aFF1Rng4SUZmVU1mWllnUU1oREM2TTY0azJzK041ek5KNEFZ?=
 =?utf-8?B?UElDTWROTDh3OE5BeVJaZHRxNjkvaVpEeHN4Q0szMmFoOW81bTB6KzVDbEhE?=
 =?utf-8?B?NkZ1c2JTaC95bzI0MDJYdHVSRmFKTkptcXVObVdjMG52RTdrWTIyZz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	Mft25/DNCuCGLCQmGEDCp45a8JPRRSSwQ6SALimHRn3P5hOmjzQyjE72aACaQYCY/Yc9l97jpGQA1f7ENOKzsEB6znowgIzQT+n6BRLEH9ebkg66Y98Kr3dLSLg+qM/zSvneSXG1k5lt5BlV75TNqfVTQLzwmlCEb9N7Tj9FM7oJUmDnP8inAODaESSLPgjI3B3xKfOVuyo2bgEu7Y0FSwPTpKHQ+zW/LC88cL1JGHNGJFhy0+87ULj7MpompyizXjwD6XvvZjEv3aMMdxQZJp0hilEq/az/tu0sgajoYMAA1UD8sgdOkU2T/lhO2uHu0BEWWar/gjmhoyBQb/vDFg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV9PR03MB8414.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e849604b-908b-49f5-55b9-08deb4dcbfba
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2026 12:55:33.5130
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FrHpogoAZG4qbHZAbZ4SX9kCJPRlJpgcf/O36oZxOc1UZsDmv4R/6OPTXT5DeOstHHDrv4ir3kR+IpaWTmLMVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR03MB5729
X-Proofpoint-GUID: MJRQlKDdf2igszlsS_eQAaUmj3qwOy1p
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDEyNiBTYWx0ZWRfXyeA4lACRElj8
 qciowOhpF3X6JU8/ryqz+3aoSBygHOE3UHr1C7cPozySP3uBXymPdKWN6QLCDaFoDGdVYYRImnD
 9EMWQpWcK9jElTHzFPX/Y6lcqBHJ4OuyXbm1tME7ocm4lqGlm8wastgMjAhIrCvdpVCkM4OBUhV
 5yoUlTdF4OHLlM2nTo6kZhfKID8H+7bM1zkV7eJFmH3Br/YLB3baImA7Z39aIc8soWOhGBEPkQp
 0CdQqnQRI7boiNI9elRvdmDWg1R2Jh6TcpSiONY7qXXFsG+eTcdjcgJ/uGnQVez+2L+OB9464V+
 FvJfljuEKVuqasr3JcgxX2i8q7xgu1dfjTxMyYiAetlZKB5SgfoaoUznNjCnLlwd7zOsXkeKL7W
 +Iu/PfpKTWbUas0H11XLwCCapvZ7ZyYcf6OFrdrn1KCRyvdbL+2BYyNPuDXuT8HiJqLjep50jxo
 yShKkfFH+A+S0wrBZeA==
X-Proofpoint-ORIG-GUID: MJRQlKDdf2igszlsS_eQAaUmj3qwOy1p
X-Authority-Analysis: v=2.4 cv=FfwHAp+6 c=1 sm=1 tr=0 ts=6a0b0c4a cx=c_pps
 a=UidE1AiM3qFEYM2TBOftzg==:117 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=VwQbUJbxAAAA:8 a=B2CjxG2daRFIxxY_pfoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 adultscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180126

SGkgZXZlcnlvbmUsIEkgYW0gcmVzcG9uZGluZyB0byBTYXNoaWtvJ3MgcmV2aWV3IGhlcmU6DQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUmFkdSBTYWJhdSB2aWEgQjQg
UmVsYXkgPGRldm51bGwrcmFkdS5zYWJhdS5hbmFsb2cuY29tQGtlcm5lbC5vcmc+DQo+IFNlbnQ6
IE1vbmRheSwgTWF5IDE4LCAyMDI2IDEyOjU5IFBNDQoNCi4uLg0KDQo+ICsJfSBlbHNlIGlmIChz
aWdtYV9kZWx0YS0+aW5mby0+aGFzX3JlZ2lzdGVycykgew0KPiAgCQl1bnNpZ25lZCBpbnQgc3Rh
dHVzX3JlZzsNCj4gDQo+ICAJCXJldCA9IGFkX3NkX3JlYWRfcmVnKHNpZ21hX2RlbHRhLCBBRF9T
RF9SRUdfU1RBVFVTLCAxLA0KPiAmc3RhdHVzX3JlZyk7DQo+IEBAIC0yNzQsNiArMjc5LDggQEAg
c3RhdGljIGludCBhZF9zaWdtYV9kZWx0YV9jbGVhcl9wZW5kaW5nX2V2ZW50KHN0cnVjdA0KPiBh
ZF9zaWdtYV9kZWx0YSAqc2lnbWFfZGVsdGENCj4gIAkJCXJldHVybiByZXQ7DQo+IA0KPiAgCQlw
ZW5kaW5nX2V2ZW50ID0gIShzdGF0dXNfcmVnICYgQURfU0RfUkVHX1NUQVRVU19SRFkpOw0KPiAr
CX0gZWxzZSB7DQo+ICsJCXJldHVybiAwOw0KPiAgCX0NCg0KSGUgaXMgcmlnaHQgYWJvdXQgdGhp
cyBvbmUsIHRoZSBoZWFwIGNvcnJ1cHRpb24gbWF5IG5vdCBiZSBmdWxseSBzb2x2ZWQgYXMgYQ0K
cmVnaXN0ZXJsZXNzIGRldmljZSB3aXRoIG51bV9yZXNldGNsa3MgPSAwIGNvbmZpdWdyZWQgd2l0
aCByZHktZ3Bpb3MgY291bGQNCnN0aWxsIGhhdmUgZGF0YV9yZWFkX2xlbiA9IDAgZnVydGhlciBp
ZiBHUElPIGluZGljYXRlcyBhIHBlbmRpbmcgZXZlbnQuDQoNClBlcmhhcHMgSSBkYXRhX3JlYWRf
bGVuID09IDAgc2hvdWxkIGluZGVlZCBiZSBjaGVja2VkIGJlZm9yZSBhdHRlbXB0aW5nIHRoZQ0K
ZHVtbXkgU1BJIHRyYW5zZmVyIGFzIHN1Z2dlc3RlZCwgcmlnaHQ/DQoNCj4gDQo+ICAJaWYgKCFw
ZW5kaW5nX2V2ZW50KQ0KPiBAQCAtNTc4LDYgKzU4NSw3IEBAIHN0YXRpYyBpbnQgYWRfc2RfYnVm
ZmVyX3Bvc3RlbmFibGUoc3RydWN0IGlpb19kZXYNCj4gKmluZGlvX2RldikNCj4gDQo+ICBlcnJf
dW5sb2NrOg0KPiAgCXNpZ21hX2RlbHRhLT5rZWVwX2NzX2Fzc2VydGVkID0gZmFsc2U7DQo+ICsJ
YWRfc2lnbWFfZGVsdGFfc2V0X21vZGUoc2lnbWFfZGVsdGEsIEFEX1NEX01PREVfSURMRSk7DQoN
CkFsc28gcmlnaHQgYWJvdXQgdGhpcyBvbmUsIGl0IGJlbG9uZ3MgaW4gcHJldmlvdXMgcGF0Y2gu
Li4NCg0KPiAgCXNpZ21hX2RlbHRhLT5idXNfbG9ja2VkID0gZmFsc2U7DQo+ICAJc3BpX2J1c191
bmxvY2soc2lnbWFfZGVsdGEtPnNwaS0+Y29udHJvbGxlcik7DQo+ICAJc3BpX3Vub3B0aW1pemVf
bWVzc2FnZSgmc2lnbWFfZGVsdGEtPnNhbXBsZV9tc2cpOw0KPiANCj4gLS0NCj4gMi40My4wDQo+
IA0KDQo=
