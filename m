Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795772026;
	b=nFkgarkPJUOyjlgYQHgQdAD3YLXFqvHUwmNVqEib06BPlHJBWrAhw8+vv6+Utnwj2xkp
	 68+XA5X5JANUhn5J6rYcu9ozO4apv+tAsVoQUfRwjV+2aQ/dkhIKw4iDk/e5EccxMwpvu
	 LUUasOzo7N+WaTxnYccxlrMaRa1d4VCZRVS/19vztyVaZoXJGsEkF3n9Z4hgeoozPziLv
	 UYCUhvVcjEUt6dOcU7eHxYtWwZCxZzmMs3ADNiIWWFTXeg0qsd4MR+GAYSLSME8EGHO6H
	 tGA1L9P1JmXa0sSrOIm5PGSalJzmCDHubgOIBBe3Vs00Se9BWGnCwydfXf8azi+la0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795772026;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-LD-Processed:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=w39GUK61Jo1nSxd7bsdOUQjVl8I6Ke3GSlzSkDQzwL4=;
	b=hvTIs05XS4YZp5KL2P0PYuHpWucvcjlAHmZUcxDk08NrdKnGYro2BgoipnV1HhpiovLR
	 pi3u7ILqzNFzqVn/Hj7tvqJu9KCKud9F/IYAfntvaGWpF0badKq41tVHBgY9oef7PtLUg
	 ZGrvAV3irkXk6Fx3EPbao2xqRlBQ/3pPfDHhTjEZSPwRc08sRJVQKvC1abnX8tIiAcLIa
	 yEimqJ6Rgnh4v5zYmzEBw3eJjHlIDU22CjpEUlh0SxfzYGKid3bJ5P76Vta8Dnut+Wh51
	 vik5HNQxv0zF3owUb8GIjpEHDWTEu7kFx7KU2bR1UkzVm5PnhIYY9/yA/FqjTNXX4cQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=f96vD73n;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=YzWPHlwt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E1D606A31C;
	Fri, 27 Nov 2026 09:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 00E1D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=f96vD73n;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=YzWPHlwt
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AR7Lomo361853;
	Fri, 27 Nov 2026 04:33:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=w39GUK61Jo1nSxd7bsdOUQjVl8I6Ke3GSlzSkDQzwL4=; b=f96vD73
	nmAQSVSD7/0HuQnYeW9b5isdA6qTwMrbZtKQ+4lbgSuWnPMIo9K4IOL4uHX7k/17
	WCxNRoRUS//1LsV2HxNCok4q+fum+5uYTUbCqhBeqAKQFWpTe98B6ykKjvcMcW/q
	keeBhN3nz+5IAleHaexamsTQN3T3ZztwzJv3gjwek+rrcvrruUVChOdZrXg5P/Kw
	iQ8hqkn/nTjlx62b6uvzjTHVKUTuCwNpiXVB13huMI3TYTHECWkmLJH1BAhqRCAL
	RHX9J0VpTmr0eq7iiKQsiFoiSGtNhFA6cN/jk3LnQ/rmuYFu0fwNkY95ka3NfNTt
	JBpeCNrVh7jVtrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w39GU
	K61Jo1nSxd7bsdOUQjVl8I6Ke3GSlzSkDQzwL4=; b=YzWPHlwttcSokaTywns7V
	KIOAhjw3XmaGaVVLI9ydYvIQV8HTOk0q2/8PyJMoyRmydfwVUMEpkDObkRRt5l3c
	O2HbuQ4sOqP5vu5i+CHhuoi1pOGPEm4V2pCcI+mhMp6y6xCbIKGU6a8ZpNPVMyp6
	98TP8EFWS2RD4GbbABNEkMTllHbCs9XVw30mWq4/5mZw5hluqDx8WiABuNlqrojG
	4zp866jt29VVcFyjctqogp+wG30q5hzPDwGWQbvD3KKt2fTPIhGMpej+E0FOZK+G
	OlvPRqyi2kE+7RZvmk+DbCI73ynplQPNABMOry0DTjEJpl8amnWj9OxS3IDemw7r
	A==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010005.outbound.protection.outlook.com [52.101.193.5])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j63xu97md-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 27 Nov 2026 04:33:21 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jy65DXkB+XobCLOWHKztnYn/7+5Q6Vt2/N2D9rnipXNY0Me5mV8AMX1K6o5HO6+XUSOXkNM+z2M82FpoTcJdUE8ccC3J2FEs024DIeaL6NHrMKKFkf6GqBPPUBIYOKZGqXporR/K+SnDjUGTEMDWalcAs9Ko5hyfWZBzEduKJJZVomJQ5VahtbhL4+mOmG6iVIpG63Qrifm5t36KGqV5KxjxNWNfoT8KT+UkhB3hzHaSftYFNgxadtlf4wjjA3wuwE9jaGsi7uuvrC9fNsoLFOoiyP5cXLg5j1nbBDyDgijDEW1j6G0nLaZJOABH6BVlnIgF7OBQIDxXGwBqO5S5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w39GUK61Jo1nSxd7bsdOUQjVl8I6Ke3GSlzSkDQzwL4=;
 b=Y5bpOvnUxPrZsHHsuwGosl1lWikOxOzN6JZ66OA4E/MHzAmSfm808XiH2gr9SlKML2TTGltecQg378L+7xGVqFeFHGkuKI3TcrDRuuN/AjDZfQTSJXRZMiFA5SqXGx3bJmHxbduvgeO2X+/1PRN1lKai7bhomZkUXS3NiNDZP6a+argsUbAY9CvJZCL122+pSYM5yf7IyxwRJX37d+IxfHNfJEedlbENSmRSmMH8UxufjD0PNoGxCyywW5isoHEbC56yqboyaVo5smbyzSGXCRfJrEK9jjZnap4NeV3ea/20HzRP9nJ3Wu+HaQVhQQFLeAoh4ggGU54ohH76jxj5JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV5PR03MB8433.namprd03.prod.outlook.com (2603:10b6:408:361::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 09:33:18 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 09:33:18 +0000
Date: Fri, 27 Nov 2026 09:33:14 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Shehryar Ahmad <shehryar.amd@gmail.com>
Cc: jic23@kernel.org, radu.sabau@analog.com, Antoniu.Miclaus@analog.com,
        Dragos.Bogdan@analog.com, Michael.Hennerich@analog.com,
        Robert.Budai@analog.com, andy@kernel.org, dlechner@baylibre.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@analog.com
Subject: Re: [PATCH] iio: imu: adis_buffer: fix buffer ordering for IIO core
 demultiplexing
Message-ID: <awlONu_ohrpr6cPx@nsa>
References: <20261124213118.63979-1-shehryar.amd@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124213118.63979-1-shehryar.amd@gmail.com>
X-ClientProxiedBy: MR1P264CA0171.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV5PR03MB8433:EE_
X-MS-Office365-Filtering-Correlation-Id: 3663e68e-0c49-4a42-122a-08df4c697874
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|261009223027099003|18002099003|22082099003|10067099003|56012099006|261022075727099003|11063799006|261102123227099003|261028144727099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003;
X-Microsoft-Antispam-Message-Info:
 cEHn8sgqd5+lkeQTJSWgBBnUsMKuQ6oDIHM/lLTNge0vLtsHwWzr80POLK/XrOFmNIuaQ/b3xAyI1vRYzYy5ld+rk6m9Vel2EXdBPsiIqas0Tvp2PhpeeuiLUGtlHQ4P2C0LnKMm0wrzVa19BZRcdg6x9o51ZVOFKJ/LwWfclOvzQtLrQL8fcyuepZZGNVTOP06wzdjyrpUzszrXL/Tg5pBK/MhahzaZbd8hjdudgQSGSp7RVeLyDMy+p9myFreJXOy87ZJyuBLEHyLZ37Yx4XzzkrX99OnIKspo9Hggip/gP5ROS8u7HWGt1dvA4h9KTpfXk0l2yyUMqFZ8wazB0c2Vsw+qHuI2lHeEQQgSN9sVpT33rsnq8OEiRTqLFzrNgc5o2uu0AeDuBvPqWapuOILP6n6uhOqqi3XuEWo1chbLu90Li+EvdTkkxYqiy0oyAZj4B29Yzekz20ghHhIRLZwKg57Isul9NPYRIknOGihLj7Pe7+263JBANtMbZFJojRC8tVj0/6HhuqWTlwzHQ0AyoHYhim+81zt6jfEbQEJL/kPm4Gdwt8HPvtd/T9VPOb3lPD+Z208aOPy9IJ3PYGpVOg5BMpXOc2KPLdBKr4ICrUHJRqSy3hpAkYEU8kRE
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(261009223027099003)(18002099003)(22082099003)(10067099003)(56012099006)(261022075727099003)(11063799006)(261102123227099003)(261028144727099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dm1yeTUwcjlOWTBjTkFEQ2p4aGVYOStOUlIzZ25KVHZMOWlkUkt0bXVuYzRz?=
 =?utf-8?B?MDdkeXpBaTVDaGxQWFZJZkI2Q0ZjV1hkMWppY1FjQmRSRE1PaEZDdHJXKzAv?=
 =?utf-8?B?ZUVCT1JEQmxNQTJVbzc2N3BXUnFoUkRsYS9VQndGNGprOHptc0FTeTdXbnBm?=
 =?utf-8?B?eTdPS2lsaUFMTXZLdTRBdVVQLzk4Y2V6bWtzZTVJbC8wY2Vkd1I5SysyY2JU?=
 =?utf-8?B?T1hoVUhLWUdSNTBwOERGWEVGQ2FDaUtOd1NJWmlXSnZIcDRYZjYrNUp6ellK?=
 =?utf-8?B?aGwwSWJ3ZW5wWFhKQk0za0dlTFJweHBEc2VlcnI0MGk0aFV2WmxFZUc4bytS?=
 =?utf-8?B?RTBJOFhYYWc5NXlQbUxOVHBuc00xYzVmVzdHdk1PMzRHcVB0QmwwZThCemdH?=
 =?utf-8?B?aFh4dlh0cCtJaGZjYUVPSWx6YUp6SzBHT1o0RFErcFk3TWFoNDVLM1dTSUxz?=
 =?utf-8?B?MzR4Q2x0eEQ4eUlxZ3FSdGpHVXo4SUVRQWVMTEtoUnlydTI3ejBqa2M4MUdO?=
 =?utf-8?B?a1cvSDRLRHkvTjRUSUh5c1ZqTnpIRTZvanhtR2RHU3NDd3RPZmNudDF0ZmRr?=
 =?utf-8?B?dFk2ZEFqN3RSMXpTWHRlcis1T2pnVWtrMDdWQVF5dm8vdURXZnFYNmVKWmhP?=
 =?utf-8?B?bGxOaUpMNHN1NCtOTG5xR1JUa0VHNDRtQmJMUFVCSHpCdFNaVUhZclcvczVN?=
 =?utf-8?B?UlU0amN2dE9YOWREdjk1ZEdzLzVoYSt6SEZRUkFNK0N3NkttbVRYaldGcCt5?=
 =?utf-8?B?VFl6aFV5cHA1cCtnTWFUSUNtdjJXK01QRjJaWXlPWnFrajNzVU9HQm1oT2Zy?=
 =?utf-8?B?L3czS2NXcGtBc3RLV1NtcVZvWjMzc1RnWnU1S1JEVXhGSzBpN0JjRmFNc0Qz?=
 =?utf-8?B?Q3gvcWNXSjVnMEtjYTc5dkhKWGRBL3RQcTVtKzIxRlpEZGo1K2x6NlY0QWRH?=
 =?utf-8?B?ZURCL29WNEUxR0x3NUdvbllZWWZKc2hzMUg1RGRaTEE4bWJnSGZFUUY0cnBI?=
 =?utf-8?B?WHYycHFIMjE5Smozb2ZhOWQ0Q25aU0ErckJsYTNJNEZzak9mZFNSZU14aGdo?=
 =?utf-8?B?NkRsRmo5bm51OEpVTCtuTHN6WmxYY21sWHFjMDVCQ1R4KzhLSjFESGduMFdh?=
 =?utf-8?B?RXBXT3JKSWsxUXpnaDlWRy93UDZjMlhGYUdLZFNXaUZLeGVOYlNrbWcrV2dP?=
 =?utf-8?B?ZC9LS3NEVjFpT2RWS0kxNXdqZ0oyOGlzVEY3ejAxZ1ZQNGpRSVBBK2hpNU93?=
 =?utf-8?B?bFh6QUZacEt3TzBEYzl0Vk9DZS9zYno5Ym1JMmdHNXNKVnhhbjc3U2R2UW5L?=
 =?utf-8?B?Y0QrU1FFN3JHbUxmWVJ2Sk83T3RPM2xFY2JRNGEwS0YzRUVWeVlKcGY2d29l?=
 =?utf-8?B?dndPY0tCai95RXM5ZlVRNjV5ZE9BZmsrWTRsVnJSNksvVTNjM3JhM1Q5M05S?=
 =?utf-8?B?ZTNtQ0dyWTNLNGx6RDJvYThVNC93aXBRUFl4LzVPM1FKVitNVUNYTzkwVGp4?=
 =?utf-8?B?azBCUlZpOGVhQ2JiL2tBUDZjRDUzaEsvUDQrYUl0Q1J4QVhrOUtQaU0rY01z?=
 =?utf-8?B?NFJ0WjhOTWVWdFZKMHNKMnRBVWFMV0ZLK0FqWWp2elFkNGRRemxFVTdWN0RY?=
 =?utf-8?B?NGNiZ3lDYU5HbkZ4YVM5UjJWRDZWY0x5WFp3TmJ4d2tYNVBtUjJSc1VvNllM?=
 =?utf-8?B?dTRCcUlqWThucENqVGNzZ1NJZzNyTzF1SmJxdllaUkRpRFhkcEtwQmc4a1VR?=
 =?utf-8?B?OFFTdjF4RExQM0dRbytDSisrblhnZHlZdERRRkI2M2hVQ0hRY0pobG53RVo4?=
 =?utf-8?B?WERUMTNsMEZpTVRsYi9ORUVwUkROS0RIb2dVQk12TjhraWMzaXk1ZUprQ1or?=
 =?utf-8?B?ZWY4bDVkdUg5YmFqdVE5TFZ4Vm5qRDFJMlNSang2NFJIS1g1cEV6OHhrSm9O?=
 =?utf-8?B?VHloTFZ3aGU1ZlRJZzdtUXlSbnpvMllCYmkvL1BZVHkzVTVGR1VlU0lQVjY3?=
 =?utf-8?B?aDFydGhKOG1FaFUxY2tYTXdxaTNCNGFoVkFkMkQvV3JsVElMSjdObGhBUVRH?=
 =?utf-8?B?Vzlwdm9DRGpVa0VOK0llN01NMCtqL3Y0Q0RiajVaVjdIZFE5QmRXVzRBM3M1?=
 =?utf-8?B?V1BuUkdLejlwanp1RVFmTG03U08zMzJVYkFZZ2UzbjhxbVhuakFwUU92UFZJ?=
 =?utf-8?B?ZEZHRCtJYXdPeGdmRldoNlpnSXQ1VTZhN3JpM0J1TFpkZHpqVElQWm9taVlX?=
 =?utf-8?B?eUs4b1JYNDV5dkU1cnZiSm9lMnpBS1lnQXpHdHE3UUV6ZHpPNXJWR3VDN0Jm?=
 =?utf-8?B?bTFZK3l6eWxnWVV1SEptUm9GWGxERExFbXl1U09wMDFXYnlZdUs1Zz09?=
X-Exchange-RoutingPolicyChecked:
	GfXG0JFOgAsrIYFtDQ9yEB4jUp+dlqfapWdozYtNEcF7ZUrBn46HjaRkPaOoQ/TkUfprTBzUKoAcFqSWgRxDHK73B5DHnGE00HKrIClWLpljDgXU19nPuixiINO5FRuDkLV6DGWt1OxEfimYL/zVrQ5FTRJbNtwse7W4mtPdYWAHHrJ8ybWdnxAoYwbnAmnYFs6/h35+tehX841JKpEbp2XIVymdxq3enqgfqUBRSzNMt4I4eNrDjEHdFccxVl4NN19JDA6gMuiccr9wEP7wFatk+sCZpqwzVz4yksBMgcRV1aXqSoiIzVzBlmy6DxMrTihCyquTGh096/XQRzUClA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3663e68e-0c49-4a42-122a-08df4c697874
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 09:33:18.8011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+qSnhF8f3hJaPGRWGUrCQPjRB2mNRT2xaPIJkQpkJV/CZ94vGfjFs0zTdGgGCGqwG51W4NhHa40Ar3YJYC4Og==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR03MB8433
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI3MDAzNyBTYWx0ZWRfX5LHwqHNacYTB
 cGJWVz6I8QIwuEBDp2UmErlbJBrqvc/2zwtUWVDU0R4t3/tu6S1b01TpUw0p6WBPhBxEEbwKjcU
 mB0iIAbMzIp/EvHbNgnrfYpq3aK5Jl0fUYzPT1OxxxMK/FuAU7vn
X-Proofpoint-GUID: DQsyX7qk7nWUDr1rbOVmzu9B93eJ-r0F
X-Proofpoint-ORIG-GUID: DQsyX7qk7nWUDr1rbOVmzu9B93eJ-r0F
X-Authority-Analysis: v=2.4 cv=Qt3LTlyd c=1 sm=1 tr=0 ts=6b094e61 cx=c_pps
 a=v0elvT+g34jhj2ItdigShQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=jJQR3eTD5FplHP-Oz0UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI3MDAzNyBTYWx0ZWRfX0U6ozMJ40jzm
 /dFVrM9lQ7cxwH6NXFanAPLGMEIGjoJTgTOmrQTpKZx7jc/MoaGdQuuaffVAcHq2wnd4GVMe+Af
 NofzrsAWG5tpD1+JATQ0KrxKseUvVNYEGehyfE5tagF1HNhP9SuySUP5/HhanHyP5pCGurnsGnL
 R+i+26SabyfL8S+oaRtsDMYnwpFpRIExLhdqYZwfzSge9aMW4IYFDzFnt5hVmJl5jqhHK5q0GOs
 kxgC03L1csfbNfJbvq4j4iZ5/kUDNgJhQa2lhxdmWvKJixriSWBzwlfyMMtQMEObN1R2dmV7G7m
 7Ms0DkgLlYYqzDFqiLR0Jatpae5h6bQBbKlUZkzCw/hhSysipcuIIJ4/OE0JsS9riewpip52xA2
 vNuzlRnR5KkW3sUUIdpn4/Z0ixrDTAV69ww5zZNugYZ/Afc6xy57JjQHUOfsoqwki+9vSO6pLiE
 VGtTHKeF5ISkg0tp+hA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-27_01,2026-11-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611270037

On Wed, Nov 25, 2026 at 02:30:54AM +0500, Shehryar Ahmad wrote:
> Fix adis_update_scan_mode() to iterate in scan_index order. The adis
> library constructs the SPI transaction in channel array order, while the
> IIO core demultiplexes the buffer in scan_index order, causing data to
> land in the wrong slots.
> 
> Signed-off-by: Shehryar Ahmad <shehryar.amd@gmail.com>
> ---

You got some tags in the RFC that you ignored...

- Nuno Sá

> RFC discussions at [1]. Tested by Radu Sabau, but not carrying tested by
> tag, used iio_for_each_active_channel() while RFC patch used
> for_each_set_bit().
> 
> Link: https://lore.kernel.org/all/20260925110239.59320-1-shehryar.amd@gmail.com/ #[1]
>  
> drivers/iio/imu/adis_buffer.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/adis_buffer.c b/drivers/iio/imu/adis_buffer.c
> index 501da4eae..17af61c7d 100644
> --- a/drivers/iio/imu/adis_buffer.c
> +++ b/drivers/iio/imu/adis_buffer.c
> @@ -110,10 +110,10 @@ int adis_update_scan_mode(struct iio_dev *indio_dev,
>  		spi_message_add_tail(&adis->xfer[j], &adis->msg);
>  	}
>  
> -	chan = indio_dev->channels;
> -	for (i = 0; i < indio_dev->num_channels; i++, chan++) {
> -		if (!test_bit(chan->scan_index, scan_mask))
> -			continue;
> +	iio_for_each_active_channel(indio_dev, i) {
> +		chan = iio_find_channel_from_si(indio_dev, i);
> +		if (!chan)
> +			return -EINVAL;
>  		if (chan->scan_type.storagebits == 32)
>  			*tx++ = cpu_to_be16((chan->address + 2) << 8);
>  		*tx++ = cpu_to_be16(chan->address << 8);
> -- 
> 2.56.1
> 
