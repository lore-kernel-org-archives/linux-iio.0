Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307282E54D1;
	Sat, 31 Jan 2026 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769880766; cv=fail; b=fgsIYJkS7u93HEFyimNYYTsHATFCtIb87XH0WeqV40r+N012BQxnsPTfM46162/iZDY7yv7cnAyh27FF3+1ryU2Chaf+yRCZh6YGTIn5o89Kz4Z4WLVgUPVDDieaiYppQRDdGolgcwzLJC7kL+kaNPGPdoTp3aG3k7nPqciPDPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769880766; c=relaxed/simple;
	bh=G1O5ocl8mfO2fZ8l63nRUNc4oQHWwT+O/EazKMoSayw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kQkhRUJwEqmnFlSEsICjToGwk9YLTScHCEldiRnCH5MK/kJYu0FM4l6cpRctYm2oRh6fcxdnjCl1u0x/ovvIBYn76wM95CGp5wSzvX3icM0C9ViDzW3+chaZaGB1zoO40OTRvCtGs3o9wQbVPZEGVM7seZYOMBYd/IrgzUm3Txg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UtQAa+lR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zrxXpTjG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UtQAa+lR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zrxXpTjG"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60VGjw8v1286695;
	Sat, 31 Jan 2026 17:32:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=DurYUUUMKUnOjEV9DoEGtFywsebtTv4MA9d4IRUWsZQ=; b=
	UtQAa+lR7O2eQ4Rqd2PG8Lm7JZ0fFkdHEJJ95zhkWa+aw4gfo1YBlh7+ZugMA4cn
	5kwinFO9ry1lNnL4jxTo3Tw/V+EsrmjYHG+Z4XQb5wP0CUsvWGIDFuhL32edqh0q
	8PKFP4M8mawhoxy9BsLuow461RBWf+tB5Vyw/v6MtDu75LmqLoNszCisv0SmViQ9
	YMUXIU+NpV8LahPpZX8aCLhVDwMvLfonnOON0xqz5AG0upFY8DDmRkXMPOlCvA4B
	Fd/R87iZ9MFguZMJZ9ez/ErwYytv6asQdGfSaOKmKxqVSsKT6870jIjmCRzktqFY
	zciZqplZbsIFTc+V0bz7Kw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c1arkr9hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Jan 2026 17:32:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60VCSj3o035917;
	Sat, 31 Jan 2026 17:32:26 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010015.outbound.protection.outlook.com [52.101.85.15])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186bee3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 31 Jan 2026 17:32:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eTauPcwmMeVZEJ+FaF5aWImCugVhkC5sWwelIgaFX3C0+r/cDY+djy3fkvlDKimCCp6mJG+n9cAb1FCsVUU+fxKnsrdSrQnKmPer4fSVYPrWBcLxSwptYAKg38fr5YiF556zW0KlhWKQMk0iz52nQnYXwMyoSyBHigJlloqy5erSW10UyUz3oBVVMy2GsPgoU/xxlMToI+9XAkseNODxfvGXppgR7OgjxYwyZR0WA90lX9QWyoCzougCwmhfzfTYWoE1FF1rnWejG0HenDldoN12FiSKoHQ6FM0yNZHBE09j0NRhMOptyNtG4ZZDmX5pyqpozJ1RWKM8mfJ8QYJckg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DurYUUUMKUnOjEV9DoEGtFywsebtTv4MA9d4IRUWsZQ=;
 b=frIFGo+7JcGzR50DQh0A3DjPLgQ+s4q8kU0qEQIfMHInruUtN4LSFWTRtB/SfkhyYjuPRbkZgdQMbJZsd4+2muUev8PYUv2xjtrejeHmdr1rYYpnUfQKqBMEBkPHVM9cQeBKgQS2vJqID1wbilEtuzr8ysTaexCVbGd8SeDspLCHxiIHHmpAnkD7Thn+MUFfN88UBBA756erLaJlsSi3bAV/NB2ZvJ6kRHKUTtDFX1FGz77eOjFD+AJ1SnNmHw54Pgj59sjJxz9EDdQOIqCZiMo63aq/aobtEIusEjTj1ohdgfgMiuHCMx6cJVzBe5pDjg3Ziy9EMJ//yaKEBrpa+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DurYUUUMKUnOjEV9DoEGtFywsebtTv4MA9d4IRUWsZQ=;
 b=zrxXpTjGAb7kO9gimyadiQHBVHRCW1B/sKfqlHKUxq3EgchuFCjY3fkb6a0N3GQ8GkkDDwvzm35La6O1qzp6r5587UnMG7/knNykeOksH/NAG88To8GBjB7RKD1ru/l3LhIppJvHZaK8dJr6nOJLjYx2mrtXo56kwDklCfeoRYU=
Received: from CH5PR10MB997695.namprd10.prod.outlook.com
 (2603:10b6:610:2ee::6) by DS4PPFD91C619EF.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d4e) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Sat, 31 Jan
 2026 17:32:23 +0000
Received: from CH5PR10MB997695.namprd10.prod.outlook.com
 ([fe80::6458:28b8:6509:8b83]) by CH5PR10MB997695.namprd10.prod.outlook.com
 ([fe80::6458:28b8:6509:8b83%3]) with mapi id 15.20.9564.014; Sat, 31 Jan 2026
 17:32:23 +0000
Message-ID: <fdb53b50-e0b4-4337-bf73-e138a0cfdea5@oracle.com>
Date: Sat, 31 Jan 2026 23:02:15 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next 1/4] iio: sca3000: cache SPI device ID in probe
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260130214323.236389-1-harshit.m.mogalapalli@oracle.com>
 <20260130214323.236389-2-harshit.m.mogalapalli@oracle.com>
 <20260131162807.137bb92a@jic23-huawei>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <20260131162807.137bb92a@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0317.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::18) To CH5PR10MB997695.namprd10.prod.outlook.com
 (2603:10b6:610:2ee::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH5PR10MB997695:EE_|DS4PPFD91C619EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 7fc0fdc6-b6d8-445a-9ed5-08de60eeb0ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VW5ibkVveFp0aEZ6TXNQNEJQb2x4VlVwTWtwSTgwZTNZRXExWERnSER2Q0lY?=
 =?utf-8?B?dEU1N3JrVmpLNS9ia0VNRjdMeElGdDhTNGlwSnd1cTFlVFluWXhvLzZSUlor?=
 =?utf-8?B?TTgxblAxSkJCdllEM24rQ0w4NHVya3VmTHBydSs0OTJRQlJrNnM4KzlIWEJi?=
 =?utf-8?B?a0c4MXU4aWFSQm5hL29WY2J1dWc3S3NHemg4bEcrNHptb3YwdVlRMVllTGht?=
 =?utf-8?B?TWFoVUVYVk5KRTRXbjk2dFZtOUtXczljL09aZjRkcXFZT0p4RUZ6OXZCdUdH?=
 =?utf-8?B?d21aQmxmeHA0Z3NjdTY5YjVZYWFpNXJCeVRCR2R0RG92eWc1a3hFR2x1ZjNj?=
 =?utf-8?B?MWI0Z0ttMkx4bk1FMzZuT1lxT2Y2OG1VYzVjVFVhak1QQjI5SWR2dUVVNUV1?=
 =?utf-8?B?b1ZqSStyNklZcTlYc0NnR2NVR0hRVmdBRjNxMUdxUWJ3Z0o2aGZGVnVqYnEr?=
 =?utf-8?B?T1dtMDV6UFlxdEloTytBTUdEV3g2d0xtSG8vOXVMTkNVUDVlOTJNTkVNeGZY?=
 =?utf-8?B?dHpRd25KK0d4dlEybytmYUtEcVpqbnRDbzc1MFB6akxyemN0MisxOFJYTVJs?=
 =?utf-8?B?WE1MRU92c3BmMUF3eDQ4QlYvUUZWcHRNNllBaTVwUHZoVVd4bzZrWXBLV2lF?=
 =?utf-8?B?TDRiVzMvUjZjbnFvK0YvUmk2c3U5TzRQc0pGMkh3Y05nWExWMjNtZzA2L1R6?=
 =?utf-8?B?VEY2WW5Lb1NRWUdvZEVRMmRwTUtsclZmVE9LVmlOU0xUZklTVExuUXNQYm90?=
 =?utf-8?B?VXYyakhjSFJ3ODFtaVVDMDhhNUhGRUs5Rnoxa0VtamtYeE9uZU5XQUlsRUg5?=
 =?utf-8?B?MC9meGRuSlBEdzJvcmJJQ0lCTklwclBTR1RQbS80NnRhLzFUdGh3TGJHZUZk?=
 =?utf-8?B?ZHp1MXVEZmhUTlA3ZmxrS1ltQzVOdFF5T0hSRFJiUEM2YU8xY0Z3UHlicjRj?=
 =?utf-8?B?MGg0YWxSVi94WExFcG5pSzZXdnlLNkhndEtHcng1d3BJVUk2dmFvK0Jyclcr?=
 =?utf-8?B?VHVXM2NYTVdrSXlvbWJPUzhWbC9DakM4Wk1TNURLZ0UrTXRuMlVNbUUzNXEw?=
 =?utf-8?B?U2pZUGE0WGdKVGRBQ0hEalJIS1VldW50ZVEybk1iekxkbEJaSzdBUlEwOGVr?=
 =?utf-8?B?UHhPZkNVdHB3VFpqTk02MUYvUmhNdTVLYmlhUldjVnp4REVWOEgva0J1QXNS?=
 =?utf-8?B?OFhMNXpaemR2Vmp0UXM5YTFPSm8yQ25PMEtOU3hZVEYwMmhUMVZJWkNDZE1z?=
 =?utf-8?B?WGFKMzFHMGgvQy9xRUt4M3RjRVp0UVpYOVBjaStLTHdWclFSdHBEVUk5NExw?=
 =?utf-8?B?bWFoWUJMMHNZK1RLZldhQmhhb29UbzRURDhrZFdzSlpaR1RNLzIxT0ZTNXl0?=
 =?utf-8?B?UkxCL1dYTkdHWmpicm03OFhPVWo5b2kwOXBwRmFlZ3MyOHNXV0VCMFhaUDht?=
 =?utf-8?B?QzFmcnZNSWhyZWZRUmtaYUhoQTJBeTlqTGZESlZXajNPTWZMUVZCZDN5RDBY?=
 =?utf-8?B?UU4yc2p4TnpYVDd3Z1JJVGhoM0IrNjVqYWc1NWZyL1p0Q0xlQllQY2N4Z2Yx?=
 =?utf-8?B?eVBuencxbzI5S2ttU3BHdUFISUE2T285ZzZHTDA3UGR5d2xLTlptNVZYeWt6?=
 =?utf-8?B?ZjJxNE00eGdEQWZSTFQ0VVNjbkp3NlYwN3lvQ2pyLzNQVDR4RXVJRHBYWWFD?=
 =?utf-8?B?NzlDQVlKVXJ6YlhPOWVMeW1HdzY3ZGE1b3hmTmZIN2RrWFZ4aWNPVkp6RCsy?=
 =?utf-8?B?bVkyWGVuQXNueEVORS9Ec0g5NXdqdEhjZFdYTXN0UXNlMG5pbVAyRjdTRVhG?=
 =?utf-8?B?WTlFSGY4TE5LYy9qUTZGREMxZmdHdktnTjF1N2tuTmxMdEJqa1huQTR6S0FD?=
 =?utf-8?B?U3Q4Y3dUVU1YaEJZT2dLckdLNlN3WUJ1TDA1aTM1YlBla0xUcmNPV0JQdkdU?=
 =?utf-8?B?WXQvVGtwVm5CaStYSzR3SENNMzBva0hlbktta1h1c3crYmNLQjZ2OWdRZ2hB?=
 =?utf-8?B?dTEwNGpLZHFZcEI4Rmx5VWRlNkpNMTlmaVNEblZPQkRNY0tIUlVCY0wvaE1n?=
 =?utf-8?B?WE1pMnhQNTM3NjZpQ2tuVGRWNzJaN0pzVVZVQVloaG9EcWFZZzdUTmNsci9i?=
 =?utf-8?Q?D/QU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH5PR10MB997695.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UnMzdHVqRGN5VjRuNHR3cjMzVEc5b0NObm9sN2d2VHBHcVY2dFptZHVGSGcy?=
 =?utf-8?B?Wm9YV0pHTFVzcll4U0JqZnR2VzBLUFBZTURNTmQ1MVpvREZQTTQ5eUJiRGpr?=
 =?utf-8?B?bFFIM2FJSGZFRFBMSUlVa3pqK1lOTitDWWZ2L1U2YlZleGVoeXpVWnJ0emxB?=
 =?utf-8?B?OEtVRFRxeFRNR1NzbUlWVklHS2EzWkdBaGk0MklGdUR3RG5xZTlOMEYrcHZO?=
 =?utf-8?B?Q0dFNGpSQTFuOXNZSE55QzlpZ1dvdjk2d0o4eGRFVU5Qa09OalJ1T1VNblg3?=
 =?utf-8?B?aHB0enViTVhpWUx0dndUZnRvb1lxdTJqL0NEMEZLUFg5TUFuNFZKSGhHcU5j?=
 =?utf-8?B?NS81MTZ0U25yNmp3VDJNckxTdVZod2VGK245cUh2R0dPSzQ3djA0cW5RNFZx?=
 =?utf-8?B?U2RVZ1lEeWdWcVUrWWdxYzI3YzdBdGw5Z290NlIwcU9XTEdid2VlamJiQXM5?=
 =?utf-8?B?UkJxdUhNMS9LdnJKMEN0LzZraFQ4RkMwRVJuZzkwVnJEN2FoblJHVUhmRHVj?=
 =?utf-8?B?Z1NjRkRIMFpjVTZJKzNmK0pQQU54SGt2OFF4b2ozeTlmOE4wWDk0RGpHbDVh?=
 =?utf-8?B?MGpQWHJBc2gwR3JWR1BlUlk4ek40Tzk5MkllZXZsWnd5VmlzN0lxSUR4Tklk?=
 =?utf-8?B?MTduWmkvTjFkcVBOeTJqMVAzVC9sckJ3RGV1c1lQOTh6TldxU2YzUEZ6VHVS?=
 =?utf-8?B?WjQ1WXZNRlpjWWlpc214M1VLb05xVTJkVDFkOTRudUdYdldEWjVoTlFBbTV6?=
 =?utf-8?B?ZXluSW5teGR0NmtoVlNiU24yR1o2QXoranlXSFlFQjRENkdZOXRDY1dTUWIy?=
 =?utf-8?B?bmdoSXRCMXJlNm9BQUwwSEQyQ2tWaGV6MTBSWjk3NEtmSU1BUlFhSlBjMXA1?=
 =?utf-8?B?N09aKzJPYnNxZFoxVWRPZ2hrZVJ4MXdpRXNPM21RR2pCZFN2bXJPOHlaVHdo?=
 =?utf-8?B?cG1xMnphMzgwclhOTjYzcEpocExxMDIrTnBtT21VenlSQU10RjR0MGZQbVdx?=
 =?utf-8?B?RjBxM2pLS0ltSzl1OXlZQUVKMnNUdFY5YmZVajl2REMySUp4emxsMUQwNlNy?=
 =?utf-8?B?MDVsdW0rUFVOdjlzS28xZWNUZmtUWVZYeGlhNFN5WjQrVUlHTndHU0FBKzha?=
 =?utf-8?B?NENoSWQ3VEFYbUlHRDVlNks2eXMzbGprTUtSSmVjUGFNMEdaOVVRMmxnVmJh?=
 =?utf-8?B?RFViQ0hCOVBIRnczZGpkM2NPU0N2b3h0cnQ1REIvemFFSDZ3eEprMUtka2ZO?=
 =?utf-8?B?ZHo3bldNWVk0UFZuQXhBZDNneGZYQXI2NGxqZEd6S212VEs5dkVrT1g2UVIx?=
 =?utf-8?B?bmszZWcveE43eG5xZGVMaGdEZCsyVml5VU51ZE5EdnV2UlFTZ3N1UVpSR3Q2?=
 =?utf-8?B?ZWJ4aGg5bStLU0N1VVhmSVI4bnZZSWs0LzFRL2ozUHpEWXh1M283M2Z1K2xa?=
 =?utf-8?B?L1Y1dmdWbmE2bFdtN0Fsdi9IVVh4VEtMQWNnaVFXZGt1WXVqbmRySDNiME0r?=
 =?utf-8?B?SDF2ZXJjd0YybU0xUC9JRCtab3hmVng5bHVpZmZiMi9WNCsrcFlOekFMZU5o?=
 =?utf-8?B?R3J1SzNYQzBGWnBSZzJjTjZmTUJVSHdrVDFHWVVha3g5cktlVjFHUStSeEpX?=
 =?utf-8?B?bGxzR2NvUWhNcThmVSt1N3pYTFJSZ1MrWW9UaDVQdk1FZGdUVHJEdUdDb3lM?=
 =?utf-8?B?dmxsdVkzVHgycTRpeitVV1ZtSTllSmZvcU5XNXdWUFcrdkk3QnNzVzdwdFVw?=
 =?utf-8?B?U3JnWHo1TE5VYzFFdEVFYnM4anhBZURJcWYzRXorTjQzYyt1TCt4dlJ1UktR?=
 =?utf-8?B?MmVmK0NhcENHeHBEN291S2lPQkwyQzVRVkhlQ3kwNDRITG53VzlEcXhCYWNx?=
 =?utf-8?B?WGN1S0UwS2gxcGdUenRZVDFZTG9PYWw2bTJNWlRHd283b2t3djFOM3cvZG5o?=
 =?utf-8?B?bStMMkhYbmhTUzFFKzg1YnpNMzV3NFo2M0o0U2JxMHRnVEVKN3VYQWRqU3J5?=
 =?utf-8?B?bTRvNXJuRUdVNkxQUDUxMW9iSTlNVUgrblF6REpsOWhwVDNTOUhqMU8xU2lE?=
 =?utf-8?B?RXhJcHk2bVlCT2t2YjhOaFRqUnBJcGpaUzdMMzZxNVdCMGdvWFFpbm9XK28v?=
 =?utf-8?B?b2hMcE1rMlA3ZEtNTXo3UUxxTG5YejFZMjBOUWQ0UXV6TGJKejBBSW1ya3Jk?=
 =?utf-8?B?dWRPaUhKbzlobmpuWGJvOFFxeHRGcnQwTUc2Z01VMU1wc0JmalVvNGVJMFRj?=
 =?utf-8?B?ZmhWT2FSbjFLRmZnOVhxb1BiS2hwcHRCMHBObXpwSkhqcWc4dzlPOXdrWXlm?=
 =?utf-8?B?ZUI2QTdKSXo2L3pQUS9SRHlaYWxUY1ltMVB1dWplRTR3bFhQZkNPVnU4a1lK?=
 =?utf-8?Q?gj4opA3HxLC3+cSraIYv8uW2GezQkeXxkYgao?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kdIraIaJ9P29yaXw1Jmw9BaamlrKLSkiOmeLINCn7T+Zo4mBBTtiXDPoZfTi3OuVotFEAqEtixseS1c/TOD9iJhsBt/3bLkSmB74UZnTfBPNewl1JnZDOLLFZA2ytNaZEuyichaAN0CRGj7OQpe9iYLXKNsxWo5NU43oZbPsiU3EGy1JOmj3bekbcqNcsSDQFrBzT1UX76cvrDI8Bm2yofaPkQYtZvqqv0QnoyfwwuVRvn/QSAFO0/REjOd/MpnMF74MwJdKRCt/Ghdx5nvrXRfrvDryi6ksm4h+xgfdWcyMAwmxrCSySJ21F9plL15DZZId+UvnA1jSLhCX3fSX9uf2d4SAHqI1MUht15Yd1CUDB1QhLNfvVQ7tCiNfA6zaLoeqhw3PkAYa4t4n5WNMRGdX7YC6pG8X+FtsPwSqsrGwKVqtuz3qdM13JwnWS04n/lqt8iX8Jk8H6LUBzkZj3UQpE1QFt5vXxyzYtMAgDsKZdPCf7rijpwPVr7M5+w2c+bRZn/dz0EA0kgS9E/gfJsg3XA2Id2mi/iMPvr31n0Mq+rcTiAxXOJdXSR9oUrNARpRTWLX+BB0PK9ZjtT0vpzbGzVQeLY/7ax4SskpINRk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fc0fdc6-b6d8-445a-9ed5-08de60eeb0ae
X-MS-Exchange-CrossTenant-AuthSource: CH5PR10MB997695.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2026 17:32:22.8857
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t/vJUKRi4T0VhioembVjBC+62qKWeo8K9HIfdzhpOsAPuPybEmAJmLsw5dD9VklD2f8FshhRskRehgOxoAtN7f8wczYPxgAJ18vO23+zJbOgs/arHpQfVPSb7+RrevVm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFD91C619EF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_03,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601310147
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDE0NyBTYWx0ZWRfX6FnuSK5WhhZI
 QCWxCpMr3nVxfrhWEBa9owptX4Bo33kPyhCAS2IHflaJJRUZx2/3Ze0KvTCHnWYCOpHGCob3L7H
 FZq3Tb33QY0Kcv+62UXCh34jaTAZ8WYsqp3/ANR0DLPomsULnvajknCcsvhcDizBiPhwFZy7lur
 aVpUj3QcTcurdeQO5GoVXmf5MgdW5NL85gTfu8SbnrLr77aQCCu1ox6D76bcJkWGLuy97bpPMTj
 tJbsV3e1nXQCufbJHPyhIOfWuTHX3RRu1bYy+Lg7eohdSH1Fp8ESwsYji8hALI8ZKtWM2Ua+BNV
 EULk3UboPJhgIUy1At64mUY7zWpDuLu6vI4ciP27ujPH+AQ9laRbHsh6Vhgin9GpdZMnf1TNj9T
 YtMQj+Wq+y153bc15AuCNjSKyeE/42ShyjHLRa1yreTOYUYxiPmUVUzMdzrjJofdrPN58oTXTxc
 EJ0FmlmsUA8WEf/wyV5aGe+Zp0S4ydN0vnZdB0xA=
X-Proofpoint-ORIG-GUID: wBM9Y0qeFMkBxpB2L4eBdEl5E2_FCVYw
X-Proofpoint-GUID: wBM9Y0qeFMkBxpB2L4eBdEl5E2_FCVYw
X-Authority-Analysis: v=2.4 cv=VfL6/Vp9 c=1 sm=1 tr=0 ts=697e3cab b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=tIBax259FId3cG_mFnYA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13644

Hi Jonathan,


> Hi Harshit,
> 
> A few comments inline but they are all about extra things to do rather
> than really being comments on this patch which is fine as a starting point.
> 
....
>>   static int sca3000_probe(struct spi_device *spi)
>>   {
>> -	int ret;
>> +	const struct spi_device_id *id = spi_get_device_id(spi);
> 
> This is probably ok as an intermediate step, but ultimately we
> shouldn't be using the spi_device_id at all.
> 
> id->driver_data should be a pointer to a named (not in array)
> sca3000_chip_info structure and so should the data in the of_match_id
> table etc.
> 
> Then we use spi_get_device_match_data() which prefers the of_device_id
> table entry (which would needed adding).
> 
> 
...
>> -	st->info = &sca3000_spi_chip_info_tbl[spi_get_device_id(spi)
>> -					      ->driver_data];
>> +	st->info = &sca3000_spi_chip_info_tbl[id->driver_data];
>>   
>> -	indio_dev->name = spi_get_device_id(spi)->name;
>> +	indio_dev->name = id->name;
> 
> This also needs an update to make it get the name from within the
> chip_info structure.  Whilst this works today it can be fragile
> if we have dt compatibles that don't match exactly with the spi_device_id
> table entries.
> 

Thanks a lot for the review, will try to make this change on top of 
these refactors.

Regards,
Harshit
