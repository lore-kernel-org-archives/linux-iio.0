Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795604565;
	b=1KNMMFWilVzhSYcx1ZtKyBkoVUtJ58C5pduOSGz1f7PT82o6PbxoP8o8HSNg+Xh2jbDJ
	 zpv1Tfum4Spv3snKg2OnlSqSiN2bTbzcrSRQ2x5SU0A9VCY4THI4sNOcCX8fPAHOWEqmL
	 8YmUeNelDVjzXN+Udr55Da9pMA2Cz5UogO8LsNkQ+3nhK6JtWyHzjlHp3w3b+yZStC5ZK
	 N1myDrkUIkbzP07KGDqVZRS13fXnngULtbceVnX917AewZsAnNNl7GYFgJiOgR2jJb1y7
	 AL8XlqO3CRZgiiCVBdtADmO0++ctGt5UhDDwBm2/SPuLfduWRCIeX7NcUfZHAWMiLSw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795604565;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=gb64z9e7k2jPtqYNa5AKn/k6VcPlTIxOgNgXpGC4dHY=;
	b=aNDTS5e3txWObBhmItIG6h+eNOZDPXIwMXLutZpsUfMFmHXo87oR4OjEs+8yaXWLAdpm
	 0BmnNOFpIOG2FiyQrMuZISSr69NM2zw85/n0PySK1ZAch5Cd5BwrBMkDwnLkLJQTecejE
	 eIwTM/5dShFEG2arzkiJLQw8sOIVLowUVXSTFJjYtnrA1YvYQGWGYUpBJgoKBIuIg+qjI
	 kI9w/y4FEZevN57vYiNBghaG4B9VeIXgiyXaQV2jc3tMCO1dkjhsnFbwocYlUifpE1/0G
	 1udZpu7hZn47Kpno4ROeDx/0PhbSBg7+B9bMVykio5Ya/9msouUUdbuIa0NRZlSRCyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=aX4d0jYB;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=POIrUUqG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149AA606A31E;
	Wed, 25 Nov 2026 11:02:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 149AA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=aX4d0jYB;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=POIrUUqG
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9ognb3407729;
	Wed, 25 Nov 2026 06:02:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=gb64z9e7k2jPtqYNa5AKn/k6VcPlTIxOgNgXpGC4dHY=; b=aX4d0jY
	BsmOdAcdFXA++puEEykcaH4JXC8i/MneE65ajUxIaFOUmPZIxmj80z+q/M8akdeH
	b7lB4AfzkVe4hCCSvzUHDCN/Goo2C8I5/QwtfpN1m/fUJczYEwJ0oHyROn1NW+VC
	RXrtz7RfLayfMa2xpqKPQLnRUAonLoI7iaKBekde96t7hVbFB0PxDwCYGd/haOJg
	2y9EcpWyDw8laPhtek8L8xVXH4ZpFfoLbFUaWrr/yK1hfAHET1XahneC4cil8nya
	O2jZXhc4EDMlC1sZSJ1yyK2I2QDypvq+4USvtNRtc92YgwDVd+2Pk58MUGUC8wW7
	rzU6wSIv0ZXTIng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=gb64z
	9e7k2jPtqYNa5AKn/k6VcPlTIxOgNgXpGC4dHY=; b=POIrUUqGxWoz1RZD2XZpn
	o+U9xwUNaxLForMjojF17zMc7zEcC6r5U8JjwL5hUI7r6szrrb9Nrpn7sBAO/Du6
	EnfoSRoHUPoREE2xM4t2gQBpaXSLLyWhSbY9hQa69uQNP9wTrrv1sSMS90FNL2BR
	PRl+4IBspRRpig2ugFkOu/HYdfiNeCUngmMaCloKL9yHfcBmRk1lSvsGZW73o1PV
	X2kInZp+jdeDz7Y0wiAaTDIamaiZRUFSh1/s8/T0fe/Jb0QneRXWF8sF6ikTx4T5
	sdIH+4q9VEk70X8ykn99a64tiX2vpYMF6G8wY4RImrG8kaqGPWP+OIwJXIfnWJvI
	g==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011045.outbound.protection.outlook.com [52.101.57.45])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j574h7pqg-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 06:02:33 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y0HerfsMY3SiCJBlQmoksC98ligRUtSUXWyi5rPGE5PZJYENbJdzMXC0HupOxqFyewPkuBshvQJrUe5jcqqGfdAdHFueHIjmh5m9uAp0xggGfQ/y5/cbb5kVa7+Bp996SH6rJZt/9jBrG8kEi7r/u70/6h7uyk0PjIIRQWMJTPTkMJ4X23hEGMvsxoBDu+M5fwPlcRxXIQkD2iIVEAAmQVkwRwOHvIuEGl2536d5xlbeZ46mBRaaX84fEaGq6t/OgvDdEDPPVEaX6jtKvK3DXx/sg7EvrEuVSGagm1L36NV54sH8LhOoLHNcI/VHuzucSgDIJAlutL+mpcd4GESNmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gb64z9e7k2jPtqYNa5AKn/k6VcPlTIxOgNgXpGC4dHY=;
 b=GP1oronAbVaV4AdzobGr7KV/6r6zoFFY+0oPoBBcqAhhT+ObhyFStJulS7EE4VwZFUXFnkds02ltOXjm22HUV/W5W0Qc0tdRPmmMKyu42JvWJFPKCm2o7Xo9nvm4hxvAZ0SStAGOA4oqo0SQwODeuQmwwPX4nPfLCyLSGNKLhME1duL5mH01kqaEFl+vyw/LP1bUnugjTPtfmutYyPiqtdBRFyzm/byxRlRpZ1K2ixtMzv9YkaP3akBPuD0Oj/SJWnthtkEko0az7Mj/QyHMzdg5O14tOvdLjsXgK7l4lBEFRd8d0HQC8T4jPiO5cUNu+jGegFAda+5uU9PMj9O1tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV9PR03MB8416.namprd03.prod.outlook.com (2603:10b6:408:365::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 11:02:28 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 11:02:27 +0000
Date: Wed, 25 Nov 2026 11:01:48 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux@analog.com,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 0/6] iio: adc: drop platform data from some ADI ADC
 drivers
Message-ID: <awa_4SxQpDZXOaO8@nsa>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
 <f18b118e-9c5e-4cd8-8466-bb3852a80e56@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f18b118e-9c5e-4cd8-8466-bb3852a80e56@app.fastmail.com>
X-ClientProxiedBy: ZR0P278CA0094.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:23::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV9PR03MB8416:EE_
X-MS-Office365-Filtering-Correlation-Id: f4efbabf-6b3f-4004-073d-08df4ae396f5
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|6133799003|18002099003|22082099003|10067099003|4143699003|5023799004|11063799006|56012099006|261102123227099003|261022075727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
 PXleG8bZc9cxIfYipi4CdPMRZHe072n4RTYv1b6YHoEWfPV8GpR+srrtsb06WQd/PDXzjECu9+k9PDvXPPu+uhyvaBL2MVZN40iTaKkkxscNy1jJodpWNvoz5ppr7/TpXj7UOCLGuwyx1uIXuB7w+h8dSDvSlSOFZdt0gO1pkc+wQLJ5GKX9+8L16f8OJ5l2LRUVPKAqci/RVsGhxVPr3VRC1Ej1uzCEvYOTzuHJiRTZksouHORh78gRhC737gLOsNPGfYG/wIvr484hdK5AqMKEVAysoCjrfwcxri+RKRXarjy/2KmqwaUXuin8y9t6YtlZv+kOjEj+3fCaoMTCrcG+KU3hKktq3i8kzsKSia6pIIyFzR3vTSA4JzT+O0L/CXqD9/UpNuPQeW1rF4QQL2mNGuBxYqcuKC4p+6F15bbGOBNEz/+48pYiPg8/W0HawgUPSnAxXHd1H/x7T1luNczF2rt33cYDLuELHkdcGQEyYxFmrQowP83Vj7pt6EIVelrq2fzTwf9o/JZhBB8r2mzf4nh+hI9kZnAg2JTkl04LswHFpfFnsCnqZeRCfqUZ/CEWVCY/kzz0hycESFC4RW+MjnkXHDmy6R6RdPF9FQV6Du95PeEK7qFgxFB7o2UB85O9urhzhDQ3V5QXiYwc802M4sVcHC9ylKEQxc+YgXs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(261102123227099003)(261022075727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Yzh6VUJRWjUvM3NhVWFkUFRYTWh2VzQ4OGVWcXU3amkwMUZmOGNsdmJ1UkhD?=
 =?utf-8?B?dmZLbTIwOFFvU2FqcTRHOVR6Y1drS1VrL0dUNDZ3cCtTN2RoRWdZeHFsU0M1?=
 =?utf-8?B?aSthUEtXYVg4MUZRNGtFeG5ab2RDSitxV2RCZnBuU3dIbmhra0k5bEhiRGl6?=
 =?utf-8?B?bDdlZTA4ZXNjM2R4YkpVY2FTM256TC85SnBRekx1S0o4amNlS0lad01VVmhP?=
 =?utf-8?B?WnZyNU5XMnZJZHRoNm9aeTZjZEN5MjFBOVBhZ3FoZTVBVTQvMEtaQ3hSR2Iv?=
 =?utf-8?B?OUl1TndHVlJiaS83TzFYelJ6dDRSRFdrRmdYaDdQUDRUNHpMUEZQeFFValNi?=
 =?utf-8?B?RzQra0VnODVSaWdhTVEwaktKSHpsV1VkVk1KSG9Cc0E1Qktlek9qUytoeVg1?=
 =?utf-8?B?YW5jSVlNN2dHREpDcWtQVzU3V0JKWDJMejd3a2xCNEVXcFd2QWNWQkNUUGZT?=
 =?utf-8?B?NFcyMUlOQkJtNFpMMy9ic1RWV3lvcVVzOCs5azRWWjFsK09uMzJsOWFhZG10?=
 =?utf-8?B?ek1ORUlZcnlQYmlGWXZSN1lvbEhxT095RHVsSS9VLzUrUTBrZ0thV24vSFh4?=
 =?utf-8?B?bmFsMXJ5OGtBb1RWTlArT3MrT21jaGtJc3VGM3BHMW5mQTJvYUdRd2N5eXhJ?=
 =?utf-8?B?TGdkNnlGblNFS0c4MjJka3RYNkpwZE9NVWh5TEMwWWlSM1ljZ3lFdE9NRkt6?=
 =?utf-8?B?S1MzOWR0c1JrMmxOZi81TXFWUjdsMlVGMUtuanN6UWg3L2ZCRjhoZnkvdzAv?=
 =?utf-8?B?dG92RnMxbVkzZTZsdENET2ovbVgvUiswNXcxa0doaXdtU0pTZVpLOXlicUg0?=
 =?utf-8?B?enhHS1lwaUptRCtERjBrdG1UVzlvTm1McnVWa1lCR1YvaG8rYW80OWJPVzhU?=
 =?utf-8?B?U0grWGZtZVM5WHhQdm9yM2pyY2xDam42c0FKV1NPS2FUdkMrKzI0LzFxR0w3?=
 =?utf-8?B?RTUySGY2bEhYRGJzNkRxa3BQL2V2TTBwbk90bVprdVRNOXBzaUtDSTU4T3NL?=
 =?utf-8?B?ZDZFMGpDVi8xMGZkZldORHRWMlJkR1RCcFNpcTVEWEhJV0UzUnpSN3JSWUd0?=
 =?utf-8?B?NWxVL3FsY2xON1hLdHhVN2gyRjQ2Ny9kcm5neU9xdVo4Smx1SVcrQW1EZkw4?=
 =?utf-8?B?YWRmQ0xVWmFHUHJVVis1SXREbGtrK2VqeDMrdk9COEU1VjRsM3JhcWRDdEIv?=
 =?utf-8?B?Q3ZyQlZsWUh5Tlh0V0ZwSk4rMEhBZEgrell4RFdyME9jMDJOTE9qcS9SM053?=
 =?utf-8?B?MzIvVDVYNUV1S1NHVk9adU5kelk4R2Z6SnRncmJnMWZSbnZYSXpwZkNnZ3p1?=
 =?utf-8?B?Z1pGaTBseElLNlA4ZnBpaWFvOVpIUEUrSDkwU0VFc3ZTNERETXdza0dKYk5v?=
 =?utf-8?B?KzU4L3E3V0l1RlBzL1hhZG13MzhFejZZMnZJZnJ3N1FLbCs4QzZCTFp1am5r?=
 =?utf-8?B?U3UwSTBnZXJMUkhwWWxZQlA5eEw3azk3dHZQekRQOTAxVzMrREZ0V1JIRDN4?=
 =?utf-8?B?L1E2L1pXbHVpVWFsa1pHSVVUUTkwaFZPWG1tSWd3dkt1TlFIeWdrdENZbmpG?=
 =?utf-8?B?NDVWMlBQdnA0S2JaUHlJdHI0ZHBzcjFaWVJydzhERTNtSSsvZVRmUHM4VnlH?=
 =?utf-8?B?a3h2SXlTTW1pREVLQkVSM0hVRkthdVF2dlhvV0ZHN242QXBSdi9DeVM4Z0tM?=
 =?utf-8?B?VkNncndvUVdxVWdyMEh1S3JDc3FhN2xBL254QURPZ09VRGpmUzhKd0owRUwz?=
 =?utf-8?B?ejREcmhmcHpNQk92aTRnZXg5T1JrM0E2WU83cmJzN09TSnNtT3JEZHNOYW83?=
 =?utf-8?B?ZERtVWtYOXFGVnNXTEdWTDVBVUFwa2RHYzRJWVhzd2VEZEVDTmtBeEU3U3hD?=
 =?utf-8?B?WWU4eW5YTFlmRjR3NDVpRnlSalBGQUY1c3pESkE4QTRiSWtIWFI2VnIvTVdF?=
 =?utf-8?B?S3JaVEpSZVpVVkhaTml0SDQzcjFldzIwZTFETC80MzZlTFNHSy9tWGhoOERr?=
 =?utf-8?B?UWM0THhMVmRyck5sTjFDUjFHeHZzQzlJZWlYMThlcXZYS3hPMDN1QjJKZEd1?=
 =?utf-8?B?L0VOTHQ2T2MxaVUrb1p1K2Nsa3VNQnJvZ2xTczBoYlIvQ29kRFVwOGdETlBv?=
 =?utf-8?B?ODk0OVJ2Tmc1cUlGc1Q4czlWaElzdTR0V0dvOGNOUERNcWtGYmJuR0JzZ09k?=
 =?utf-8?B?YkFnNHVzQ25LbVNtQXNKSVQ2Z1pVa0MyVzMxUVBEdXM1eTJtcTFDV09CMUND?=
 =?utf-8?B?Nld3VDRDaFpmV3pON1pRSENkaFVLcHlUT0pPK1RRKy90SWd2UmdzMi8wS2NG?=
 =?utf-8?B?eFR6MDU4VkVlKzBlSUNMaXllM3FEeC8wQmdnNEtyNVNIeGRuRGp6UT09?=
X-Exchange-RoutingPolicyChecked:
	hQmg760z7tNjnqOmJZLT8KLaGyVMTWkMBXloccFYJSz5+o2m8GTq9cmvjNLdh9xNAkiEZ8ia6V7tdo1S/E38gw9XXjBpMwUsVEL3QK2iWSMQ/t/P8BAANr0KquEMY9pp3lI3VRzNW/KDxpWYhnQUYH570oXb0HknAxobcSD4dvBZqw2S68iljc3FxRtYAhUN7oevUbCBYepcHGd+jZeMaYF3hTEICkPiwhRMSettClN5tuKwfCxuaAjtMPZW6S54eHGEfHhGv0+wGdsgoulNhqnBhic6XzYHTK8nez6fPYUy3FUswP1OgfSAwyr3/pNV18K56Ps4F2K/62AZbsCaLg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4efbabf-6b3f-4004-073d-08df4ae396f5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 11:02:27.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFRzgQuOAGb2YrnY4FdiFQ9zo3Nnw1ZVxYQZc9iv5cKSvBzr+HSsAffUfu8lWIpxqL/XrpQ4PfbCgM4OXU3Vhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR03MB8416
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MyBTYWx0ZWRfX8jKblEST49Wi
 OeyCK4dknYqHOdclJ3Rmpav/Yp/ZDNt0YQFoBfETPPvNpQZEnbVpimkQY2EuZiAA+ZqC8qGVA6z
 gFz3QTcRTSnYaQW6bAHXBpddmJ21f1zeBplOyRxvHev11dAKBEVPNKWH2Q6DJ6j7dUhjoxr5iNV
 h05iMj6S16Jdqzf1kBW8nJwnSGw2M++I9nPHeO5dWj2DK7umPDC/PlHV178bBl38LxIZNISoZ4G
 lnVEFIzA+fU51w+6XDb5bGK+bkj1o4EYJdXh/3jFD+iaSK2t8P6lKgo9MR+YLkekPGBDvOcBUMC
 RSZYTFmIpxOWNcU/qzdSbaGfmDWxW0xNk6VLJuvQ9yvIT1rWX5ukq+ZuYhxMT1DXS1CsFv50Sdr
 AMMOyUFcj1sPJj5T3opNPAarRFiVU9a0YJe1c8aa00dX0CKtfDqQU8weNUHJKmrjZQDBcQuI7xy
 q/IIY85S8tMrmZjZciQ==
X-Authority-Analysis: v=2.4 cv=Yt+a1IYX c=1 sm=1 tr=0 ts=6b06c049 cx=c_pps
 a=n4nuXP1CjkzMzYAVBY1Wsg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=p89YWgDLItiPvrVSrVwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: JCjnIRPIPE4ND6bD0zM4eyiixYEXJGyB
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MyBTYWx0ZWRfX8RH2RZq/TiTC
 9vR89GFNaHHDPeFXY71NYcooIiW0Ts0k4Z+edrk+H9OovbhY0RH7tF4WrqMzT/VEKlZtReJD7i9
 rQO8dmBOlXefajEpvHMiOBwKqAVUZOviNTK736ufPC8tCCw0GSeX
X-Proofpoint-ORIG-GUID: JCjnIRPIPE4ND6bD0zM4eyiixYEXJGyB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250043

On Wed, Nov 25, 2026 at 11:36:02AM +0100, Arnd Bergmann wrote:
> On Wed, Nov 25, 2026, at 11:19, Nuno Sá wrote:
> > The ad7266, ad7887, ad7791 and ad7793 drivers can still only be
> > configured through platform data headers, and nothing in tree uses them
> > anymore. This series removes them.
> 
> As far as I can tell, there have never been any upstream users
> of the platform data for any of these drivers.
> 
> > The ad7266, ad7887 and ad7791 drivers already work without platform
> > data, so the headers are just dropped and the drivers keep the
> > configuration they use today when no platform data is given. The
> > ad7793 driver refuses to probe without platform data, so it gets a
> > binding and firmware properties instead.
> >
> > Patch 1 fixes an issue in ad7887 found while looking at the driver: the
> > on-chip reference gets disabled exactly when the driver relies on it.
> >
> > For ad7266 and ad7887, the code for the modes that could only be
> > selected through platform data (address GPIOs, other sample modes and
> > input range on ad7266, dual channel mode on ad7887) is kept, so that
> > someone needing it can easily add firmware properties for it. I'm likely
> > being optimistic and odds are it will be just dead code so I'm glad to
> > drop all of it if that's the feedback I get.
> 
> The patches all look good to me, thanks for cleaning these up!

Sure! For IIO the one missing is ad9523 and that one we still internally
have users for it and deserves a series of it's own. Will try to send it
by the end of the week.

- Nuno Sá

> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
