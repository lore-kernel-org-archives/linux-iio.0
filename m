Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519770;
	b=iqF0ga1RIZN0guZoZapxwDkxABjk6xC6BxqYIRqyf+7QFF3H5c4hs/lCa+gOHJHTAC3f
	 yNs3iGBlwd3l3fowM6BZYoEqniWOUH3u2rPY+Kx9LBPh9q4kR2LAzTEoW479CPLDXm/M5
	 1SUsyZoUP7/5kNFjyYZXkVCjtONfoH2Jrkyk7xSRXX/Y6VXFVNXn7QRcF+VNdGyCsa2vn
	 z1WXmgsugXELc1GFJCsT5TMeX+A/2cZyxgoYyMMnFpQbm34zTJiZm62b5c5f2AfWhAiD/
	 oDV5wzYFKQyGSPQeVWq+JVt9c6JOQ9y3nM8koYNjxlzPgBJkMOalt7ncDV+m1r3eMpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519770;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=RVbU1FTUE6HHYZf5Mnk5L3Z4aP3Aw+XYI/7cYIX3mOA=;
	b=kQjseDLGYyF48tMVI1fxFf+o1oboFqgftMHO2NBe7HlyW7dTCq/nDF5TTR9SVFWdXqfs
	 Hm8MHviPt3GsmPRzHES5l3g1ZdOjdDkvJQaFN9dkc//NhwQVdj90e7iHrE4Xehu2mrnZk
	 Mx6GIZT3S2pP3olZbtbcKB7Fhx9rri4S/jEnxSqCeevTD5vdqxocF0clMamUXwZpCbNRB
	 atxbx9hJ7mWdo1DhpVKTu8UxxUrUhk+4LBbaRLe61pkmbaaRL39OjYugxjO+uUA5jmwgp
	 bBCJ/KDGFtakWyUjVxoMuWEjhmzaJtWnhITwBP+W6eXqjem4UOonKr/tB+s0xbv8Qsg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=mhanOY+z;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Lo9GXWjT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBC2606A31E;
	Tue, 24 Nov 2026 11:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DBC2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=mhanOY+z;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=Lo9GXWjT
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAvhTO3110456;
	Tue, 24 Nov 2026 06:29:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=RVbU1FTUE6HHYZf5Mnk5L3Z4aP3Aw+XYI/7cYIX3mOA=; b=mhanOY+
	zg3EhKlYPEKTDEQBh9/ILeEezv117NyQHuX2/Y9CdxALSNmRLW9bk7vvcbMrClRT
	T0RWQjNeb+sDWTqVOmfmgFns0Os5rNqH+gLcpa7AlQMNgiv0AX12bj8jC8/T+n9X
	RTIRtyHVpW6Mt0XI/o68UXNfFUL9mwA6DlU54mLd8KJPYP946/2XuUfmE4CGZEH5
	kECUkq1xGCj8TYNLCTUkK/66yY2hIwpDVKh7wpGIoU7qm2tbVRM3mDk2Jbyteau8
	NFLz5owuX4FRnxDsxTZej45xzMiuHOE2qmiiFmfKLx9SLV9pInrZkQYoEyfrSUGF
	YzEsI2uILrfrefA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=RVbU1
	FTUE6HHYZf5Mnk5L3Z4aP3Aw+XYI/7cYIX3mOA=; b=Lo9GXWjTw0kOnPcd2Si9r
	Yeq07Na1ffOUC2jRzr+KgneMUOhmpeIKgw3NknKFTuG9kpffvkwphCSvlasWdgev
	nagW35gQJmecYz6w8g4JnLSTAA/vLyR0NttkQumO4d0P2KK/B0OKnnple9fpninj
	gFrc3uOeAHTUMyXuNtIWNTYVKrzxfKgLKTmqCqYmeWammVoY5cY4UOgwKfl5oOd9
	/rp9zy2a+0XhBYtEi9WSH1IhiWhyYC5ZPLP0xKWdDWk/aWl47K9A1IexLZ+1mJh4
	pATw5aJH1toaXsHOhsdSqwg7rJ+aczlBr7JFqmlFjovRvaloTWBe+n6QZq8jUfyD
	A==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011058.outbound.protection.outlook.com [52.101.57.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4j4bfa928k-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:29:18 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovSGj1MZgzL42m0Xulorz48PJ1IMggulcHfytmKkabshanc5Sb8R6Tsaci6au2I3jRLr5U4t+4dWzFHm98Nz9w1uXdRjsUgc2kV1G95BWrXhfkHMI4ZlzGZToHHXfp3TOSdN3fYUGk+nHshRLfFKEAv4BiYFwvPEu8Thn2YKjhPC2X1WJkHzZX89BovvOz9L8KL/E4ClQiGwUuYwGqkvKKfVJd/gdjHRbIpA0u/B+/ZvahbheWxG4bcekLic4zKFc/8UHmbKBvtmEQzuwNmDwmwjpZusHcbdOSavubthRTkcL4u5A9zaZ0xwHsr3nNrLEjk1/LtR02LNB5hoPD2RCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVbU1FTUE6HHYZf5Mnk5L3Z4aP3Aw+XYI/7cYIX3mOA=;
 b=hh9iW/vvkIimDcIaUif39zOR3Y7n/0090YFYdEZCLfo7fdANqODmcgRPjCRyqAsZvtPfsh+IGs+71rYqcHF8L1Rf93qd02ypPenVUfNUxZRX7lexkJ4DJDmX7bYRUkcWnIFcY4PhRGKzH8X+/e77eGoVz/5o+GByhQWf1YGY9J9iILICEuSz1de1s1BBjQVe1MVGYz5rD9I1TZ/1UoU3lL1PNlvQbOzYFpjIkTuQ/2hwb50Vtq/worNNDtX1kNypGwYHIEuVGD3L51CIcHsyVJmH0B2f/nbMcGBiZ7hkbKxkp3fSTpJebMJw7EIArkloKpqbV7m5WIhRS3HlaGkAuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA6PR03MB7949.namprd03.prod.outlook.com (2603:10b6:806:430::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 11:29:00 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 11:28:59 +0000
Date: Tue, 24 Nov 2026 11:28:55 +0000
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Rupesh Majhi <zoone.rupert@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        David Lechner <dlechner@baylibre.com>,
        Eddie James <eajames@linux.ibm.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lucas Stankus <lucas.p.stankus@gmail.com>,
        Marcelo Schmitt <marcelo.schmitt@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Petre Rodan <petre.rodan@subdimension.ro>, linux@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: debugfs register access through regmap in the
 core
Message-ID: <awV0zollH6Tuj0Et@nsa>
References: <20261124065016.185124-1-zoone.rupert@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261124065016.185124-1-zoone.rupert@gmail.com>
X-ClientProxiedBy: ZR0P278CA0209.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:6a::26) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA6PR03MB7949:EE_
X-MS-Office365-Filtering-Correlation-Id: c2556cfb-daa1-47e1-8d3c-08df4a1e226e
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|10067099003|261028144727099003|261021123027099003|11063799006|261021121427099003|261022075727099003|261026140227099003|261009223027099003|261022105027099003|261026121527099003|56012099006|261102123227099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 8szzNNcrHNc0K+rdzNesya2+jrrV09PW/u0PK6tGlZ85NwAF6kGbykc5OZHO6D5aD5u2Xc9HgevpUQwA5UE5RTYxoZdBYYyKiuaM6reCXaAS47TSKPMwU5bkvDPLFK0ayLFiXBA089YtRr7gYUA0XhETrOiOyKCubPpI9dKhaRo8EYakmgJCwMn/0+6e03relLdhkJ7UvDSh+16CTlEJihf9hEAQW/H7dGtfzuIZRLSGW22HrJS3RdpeVK1EjPsGD6RoacBwkLeMVqzYg18IIQlmFjR6Apzx8bweJO3Z4EXvnlejiHTr8JqyHpwj/X2qof0uXF/vTMXals7TWnmgEnVfsW5HKZgCkMY5Lu7snZFZTSR9wdL/lwN8xmk/jQTVbxUa8d47YDCwZaLiuwRpWFPAtpXyggHunule7ETy+Uj6AC6ZZGjInGmd/MD13Yzl4kKySnLPfLTnh1OcYP194s9Vfw5LOL1re4IYio3qM/2KjWxr/0y7b9rEzPBbH2UbAq3rKx2f5nrbUfTkAd20/VRgiM6fAH65QI/xCNlRy9xNft8VyRYFLCAIvJuiu0ZtV6fz8mQLgzXOAZqbALOBEimFeeRVKVcndJRL3q9bHTsUxC9RDu4XpjWdUF0uX3j7jIUEyPjgXZ5cbuzvgiVU5LHBH0U/30sGshs09MK8Cco=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(10067099003)(261028144727099003)(261021123027099003)(11063799006)(261021121427099003)(261022075727099003)(261026140227099003)(261009223027099003)(261022105027099003)(261026121527099003)(56012099006)(261102123227099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?dFJPY2tvb3RiVVM3VmEvRDZua3dLV1JJNWZVdkZNYkZkRSthcFh4VXp0elhi?=
 =?utf-8?B?VmdaSmhlbFJ2WUo5TGU0RkF3dTN6QzJlV25Vc1NiYXVsWVdBVDI1V1lQZ2xN?=
 =?utf-8?B?aU9NSnFvMVBWUU5MeHoxQXBSdGJMY2N5WUpsd1VUQ3lhSjBLK1ZBMnUzQ1JT?=
 =?utf-8?B?d2FxekZabjlpZkwwL0gxVVgrc3dQWVZEbGpuMG8rdlk4NVJnS0NYUE1VcUky?=
 =?utf-8?B?NUNENmx2czNqTDJoeGFqTHpMRy9JUStGSkgyTVE4ZjlhczZaWnczekR4NW5G?=
 =?utf-8?B?bTU0MlhTdDZRaVZaSkVvUHlpeVNTVEtZNEE1ZnpvMmFTRzl1eGJjOFluMDly?=
 =?utf-8?B?VEJsb0x4WE90ZVpIeWRjL2Z2aERJSWN2cnNVemdDUVJxZW5YdHhQcExNeGI4?=
 =?utf-8?B?YnR1ejNhMHIycWRtak83bkRFMkJpTGZFeUxTTEJPYUdlQ3lqdVNUMVVEM2NM?=
 =?utf-8?B?U0NaNEtNYkJBaC9HNmxsWnM5OVNZcUxsMDgwQW8vTWM2VzI1blNkbE5PWkFC?=
 =?utf-8?B?eXQ3ek1RcnVRRkk0SjhuRlhtZnExNmxwdk84cStlbTF5NWdTMXBJaW9LMlZq?=
 =?utf-8?B?UUk0T3dYT25ScjFxTnZpb2x4c2pEbVI1TS9HM3AvaXJWQndsTEt4ekdlMjl5?=
 =?utf-8?B?SnppbmRZWVI5UndMMGR0K1NDS1Y0a0ROK0VDNDBjTS9BTlF0QzdheDVWRjJZ?=
 =?utf-8?B?dUlFRmJzRHdKWDBoY1ZpUXdxOEIrTjBVWG5rQlJuUUU1NEpFdlh0aW5keGFy?=
 =?utf-8?B?WDlqOTJJNzJnZ2E3NjEvUHRCZ3p4K1N3YTgybTVYc2JoSHd5V2d0cklMUUlt?=
 =?utf-8?B?MG51UWVLci82Rk9FVzBrU1lzZWxYZHJyR3lJYXc4bWk0R1N6ME5RVmhEdlB5?=
 =?utf-8?B?bCtuYjVPQ2F0L3FOejVuNmh3NXFiaUhoUk8zakVmallhbkRQdDJUc1pxcWEx?=
 =?utf-8?B?dXh3RENBZEJpZ05ZdGdnNjIzMzgyNUcrazF1dER3czZNVHZuWEQrNTdOY3NI?=
 =?utf-8?B?aUU1Z1JHSkxoNmdKYlZ0VzRhWjErVTBYWUVqQzZDVjE3OVRjSFR2TWlxdFB6?=
 =?utf-8?B?K0ErZnB4OFYvaXNhT0hZaWZ0WklFMzRROWxMRGJWemNkc01xNlFhYTJmaVJj?=
 =?utf-8?B?Mi9xb2NEbkJNQ2Y0dDFIUEN2VkNPRzM0aFkvemVUcWFINk42TmtyMkF6OTFZ?=
 =?utf-8?B?NVBSVWZsY2tyaFdYdERxdllpVGs4RXNxMTZxa2o0Ukprd2VHczhDWk4wWFB0?=
 =?utf-8?B?SEFHeWpoQkt6Sit6dWhKeWRMSWFQRktxY0FpV01QQ3hPUHlMZFdPMStDckg5?=
 =?utf-8?B?SkRGR3h4RlNDemZJc2NwS2l2TFNObW14Q0ppYzJaOGZDTkpmK2UvY0ZjWTYx?=
 =?utf-8?B?T2FGbTZUaWpjNHQvZ09iQ3p0QnBDSk9ncitCK1lCZ1dsL1ZoRThqekluU1l2?=
 =?utf-8?B?TWRLd0hGZFRUdkdwcGpOV3JXdTVWTjRVMDY4N0h3R0diTnZwUUN4d2o5bk1n?=
 =?utf-8?B?Y3ZlNkoyWHhvMStqUENXc3lBTlFUV1RvT0FYQmN0MGxlMURIenkrcW1TaGZP?=
 =?utf-8?B?bFBuS1JLL29tUDNxM2YyZnJKMWJENXVxM1Q5dXYrWG1NakZBM0toRG91d0gr?=
 =?utf-8?B?K3lTNytaS3JMZy9EVThuK28xaWZpRkM4T0ljQ3ZsUTNlU0FxMVB1NWhEQlhL?=
 =?utf-8?B?THowbHVrR3NZRlAyNzJGM3pIWWlnTGhKV3NIRmR0aUtheG91aUVKL2ZZWER2?=
 =?utf-8?B?cmNoc2NUNngvNWdqUWNOc2hnQ3hNa1FXNHJ0N0VzajczNVRYa3VyR2QwdTdM?=
 =?utf-8?B?VGhjTHIvQXA2ZmtNNWdEV3hyREJ5R3lYNHZlb0hiRWI1emJEUDBkOGgySFhX?=
 =?utf-8?B?UnFzMkcrL1FsS0M0cmsrQXgweE1qNDBXbld0RWVCNGsvMlhmc0tKbkMyeTJa?=
 =?utf-8?B?VlBEbWpyRkV3ZUNOUGYvSmwxR2QrRkc0TFlrMjU4eTArT0FaNkZTZDJoWWx6?=
 =?utf-8?B?TnQrb3VOUTRPdHVveTlEU0NVZmZpMjFtVkNBd29TSHg3Rk9iZFBKL2RIRk5T?=
 =?utf-8?B?LzhIajRtMXNPbUovd3hDZXJDMFZMa2NTK1ZsV3k2N2JBajBGc0FkTDJkVkJn?=
 =?utf-8?B?U3kxNkJveDBFM1VwSjgwNDhBNi9pQW43UTFhYllZb3czR1llNmg5YWdGS1NX?=
 =?utf-8?B?OGdqZ05IVUF4VmI4RXF3NUJGUXl0Z0dhK3pOVWJzUkJMVXJOemltT1Z3TmNL?=
 =?utf-8?B?TjJXMHFxWitPVXpxQVEyWW9KcnhYUXd5RzBJY0FaVFRGOUNCRkN6bXBqbUdq?=
 =?utf-8?B?aFE4UUlLeFV6ZDNyYWtTclJlcVVLd250cisvd3BLWkFPbzVvMkFQUT09?=
X-Exchange-RoutingPolicyChecked:
	J6BKvKZcFpKDYRI96vGYUy4Cua7f0c7XUQwq+6RuYmHBGqWHgqxVsEbJiFhROFRRICpdiYZHK2fyA8295Ybikf48csNJ6A7cDS0fg8yIySVgIVdFFb8uYWZfje4E4b8JJgGSrYyXZ7ZPrLYvGjcIlL5WYxQ+cu1ab1+DgpIoq8RnHxgg/7U6ZQ/JxMdot9+aEwnJj8FQIP2lpaMtTASUTX7q2Ef+5Dhv3dPFrKlqDUK1Is81bf5qwYYfcqqIgN+yFn7fgiPR8zu3kURygduc1IpDG28zT0lNvU3jV1zg1EfJ3KE4r8viP4NYEYX1Emksrk2q760itCNkX+pazMAAVQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2556cfb-daa1-47e1-8d3c-08df4a1e226e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:28:59.8253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nwaa8PtXM7MQjPrey3Lf06dnntgk17+t1FIiS/wnRFg611J2huUgefex8ALnQtIrJihNhlO6ofP5BTj/h/UjGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR03MB7949
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX5XHPDq32UljW
 IvTCLhd3HjJalQygRjWl+sOoBweQIE2r244ZI3hf5ABPACCDz5hyx/cGesd+c8Wn12PIIpZZfR9
 QcxhEuHV8HgfzafuVpSH/2Lph/ryLStmjiggJpD0OWf/4Jl0+S1lX5ip0Upl8O3N0uOyaI2Sj56
 u1s8feK/ngO7lfovFh3MVSDL78JpJwcG5ys0Ij8R54Ru0WHfrFZViQlQypFA9Lzg1YmkTcYq7Og
 J8EP3/qLSiWcithK8AUehlRPYZD/x5vG+Ug4jhHYrcJQouU+zIAfLxOoL6MzHU6jGJu0TF1q63w
 Ny+GqBpmNNazxK3FEuZBAuDp9lB+tWo17Kit8i09k0akIii91GpQ2FeN3Lg2R8sElD7js7CvJz/
 OKZuyjN8sYeG/cVklQNS6bcnLqh/ywd9JGE95ecB3/BDdrblh65FQBIoPg6NBt2paXsAe7p/7UB
 3JFMakLpKV+Dl9Ge0qA==
X-Authority-Analysis: v=2.4 cv=OK+yTiaB c=1 sm=1 tr=0 ts=6b05750e cx=c_pps
 a=qNvklhu79FbMMzLDwJ4KEg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=3BfbUxR3QIPS3rfmfB0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6wXb5PdcYmQPSOC1KtoDzITANDRswTn5
X-Proofpoint-GUID: 6wXb5PdcYmQPSOC1KtoDzITANDRswTn5
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX/a5vxR++nr9P
 zd0fcrzWXy+GY1Qi4nq6ZPnvJdWqQ5U5R6yFRlmEyhi2PWb8HzEXaHDDm5pSDmfm07N6f/HuuGW
 XZKnyMz5AEY/KhB2bz4RMaTi4ZTt52hOPO/wui4QhI0aDpRMiZjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240044

On Tue, Nov 24, 2026 at 08:50:10AM +0200, Rupesh Majhi wrote:
> More than 25 IIO drivers have a debugfs_reg_access callback that is
> only a regmap_read() or regmap_write() on the regmap of the parent
> device. Patch 1 adds a core helper for that, patches 2 to 5 use it in
> four drivers and patch 6 adds register access to dps310 with it. The
> other drivers can follow in batches if the helper is wanted.
> 
> The helper finds the regmap with dev_get_regmap() on the parent, so it
> only fits drivers with one regmap there. Existing callbacks that take a
> lock or claim direct mode around the access are left alone.
> 
> Patch 6 is tested on a DPS310 on a BeagleBone Black. I don't have the
> other parts. For those, adxl313, adxl372, bma220 and ina226 (ina219
> uses the same callback) were instantiated on i2c-stub under QEMU:
> reads, writes and refused registers through direct_reg_access give the
> same results before and after.
> 
> Based on iio testing.

LGTM! With Andy spilt:

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

> 
> Rupesh Majhi (6):
>   iio: core: add iio_debugfs_reg_access_regmap()
>   iio: accel: adxl313: use iio_debugfs_reg_access_regmap()
>   iio: accel: adxl372: use iio_debugfs_reg_access_regmap()
>   iio: accel: bma220: use iio_debugfs_reg_access_regmap()
>   iio: adc: ina2xx-adc: use iio_debugfs_reg_access_regmap()
>   iio: pressure: dps310: add debugfs register access
> 
>  drivers/iio/accel/adxl313_core.c | 12 +-----------
>  drivers/iio/accel/adxl372.c      | 15 +--------------
>  drivers/iio/accel/bma220_core.c  | 12 +-----------
>  drivers/iio/adc/ina2xx-adc.c     | 15 ++-------------
>  drivers/iio/industrialio-core.c  | 28 ++++++++++++++++++++++++++++
>  drivers/iio/pressure/dps310.c    |  1 +
>  include/linux/iio/iio.h          |  2 ++
>  7 files changed, 36 insertions(+), 49 deletions(-)
> 
> 
> base-commit: f2cbef9101b9fc979a324bb1242b8b802a2484b6
> -- 
> 2.43.0
> 
