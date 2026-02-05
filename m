Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420929A9FA;
	Thu,  5 Feb 2026 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770309595; cv=fail; b=Z11Y6e6OiMuk+dBOc+sP3EDJQWeBGomJno+0GH9igcfSCP/mEv+kKwDX6QwLfrHzwUOW3oblo1Ma4ADzWCmccAkW6+FzLzaYTVCYV0IcI8nWkTh0Xkg62EMgi+y2qyoHm72ftd2rmDjsEfzS6Bt3i88X9LgsR/UXOLFIM2pHlX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770309595; c=relaxed/simple;
	bh=hA/5s2sSly4lttYzMtVHotT2qCseM1QoMVFum7ZKgT8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=R/YcjSYXG3PULh+QVJen6FYKGVD7Fp8VtrDJjETAe8wfmdemrQzcdBZdKv4CAU8SIveRPQpcVozfriImCzlUZLBzPGCNsm8QEF0eL1uJcEdJovTmApZwlXKJq+GyKtY3LW4ejNNg2rZxYd45O/dBP2Tlkz1bopxKb29zeif6vno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hOhFFgmD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EKr6rFbR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hOhFFgmD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EKr6rFbR"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615Fu1UX482359;
	Thu, 5 Feb 2026 16:39:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=XnXH5CHMvEPMsZGeAFuNWJFq00YwT5slZm22YEr0Xso=; b=
	hOhFFgmDWBNAuSkYtt/mZ4JwZsCboCNjS9ChkpN3gn9ss8FDMEfCBGrskxu2VSXM
	cnIMtW+cLipQ3xwG1SUL76gPpF7Aqs1fZ4w69UHMgS2qXZfReUVAX3DqtKIdGj1A
	RHaa5xXe5XZD+mW+IalRLYM2OjB/DVapyharrFC7X+5Or6/T60j6fCdR0u7qhXXB
	eeceN9Wgx+GEmFzGafA0Xy9yjOSfXvD+ZPb3GdGyF9Z447BTz/Ke2KwuqOQ+ebwz
	e3A1uDmRfIoCWylYFRHjLCYTPl32SUepICkWwcqRC+2Ci9YarIDFoli7mdCm3or+
	DE152c5v5WxZg/qtld1U5Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4c3jhb41rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 16:39:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 615F8Ro5027128;
	Thu, 5 Feb 2026 16:39:48 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010028.outbound.protection.outlook.com [52.101.61.28])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4c186qxkfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 05 Feb 2026 16:39:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUhOSUt9SCWEDaDHYQeGKfmiExK+RrlvnXSvHNfX2BT6Ez0uKdbZytr98eN/73WcfDqT9IdFG17eZiJvkZNcypjyefujB2jgE3bKdha1mHCyi+c9zxI7rOaQdLRcxmujMbvn2kjCo145zrNLBBicVWchC3HlZteDZjSxA3lHmQ15vdZZQGVhiLQnDWPlOkZiGhLBkkLCWFs0R6BskJNeyhCS6nnq7r/lhnvHh0d0K+UT5AkADOe2C3qAvHTZS9h35Ut5cGAUFqyf7IT2Ynv42VgcMB3ytqWk0W19liiCc2GnmK8/0IVMBZbpoIHFcZRD/Sbjd+cN1RQS7TOuY+IVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XnXH5CHMvEPMsZGeAFuNWJFq00YwT5slZm22YEr0Xso=;
 b=hsWr+99xQkiW8cjRMq0x7/51YvntCMdV5s5cnDJfhB/KD/4plq3K0vR+EnIoDFHpC/HY1Mwhbr38CAuuBFj/0SZLo/6KnYkqawjbG/h+1rNkTdrDbqodSYFblz1IFJyfHZcX1ZxTjYZhO6WOJCRMUxB7oimKukiCATj3XP6CVUAb34S59k09dcaD/IBH5gBedYkcSh4zj+3RFQFr85TIRK/dygdW2yXCfsIMJ6R0ugMMIqgfULjfaTqgXrP33nnsd4Hft7+B7Quf0rDvZKhnNxw1q8IAEvoqWg0z/FYzADrvTCDi9UD1AkUG9KzrbE3JHXtkBxGDLiWNot1oCusBtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XnXH5CHMvEPMsZGeAFuNWJFq00YwT5slZm22YEr0Xso=;
 b=EKr6rFbR/RV0fp8GNRmP30I6dj2ERHtdaTHXpT4C+TYR2gjOUjS4I1JUV3rPju1WnTYHQqUnLkzhHXO1qAH/4oRhTMHJ3Mqiwn7vMAGccYkddxk/9ML20Tu/q+bR8GAYiko3ig/2gJYJrgyUP7s1CNJbA3d05LRLuyed2RRrzEE=
Received: from DS3PR10MB997700.namprd10.prod.outlook.com (2603:10b6:8:347::19)
 by SA1PR10MB997631.namprd10.prod.outlook.com (2603:10b6:806:4b5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Thu, 5 Feb
 2026 16:39:46 +0000
Received: from DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a]) by DS3PR10MB997700.namprd10.prod.outlook.com
 ([fe80::4c1c:3bb:c4c9:8e7a%6]) with mapi id 15.20.9587.013; Thu, 5 Feb 2026
 16:39:46 +0000
Message-ID: <e9c61a85-9c73-4ccc-9a7a-3e3bb9995037@oracle.com>
Date: Thu, 5 Feb 2026 22:09:39 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 next 5/7] iio: sca3000: use guard(mutex) to simplify
 return paths
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
        David Lechner
 <dlechner@baylibre.com>,
        =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko <andy@kernel.org>,
        Andrew Ijano <andrew.ijano@gmail.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <20260205131234.3244467-1-harshit.m.mogalapalli@oracle.com>
 <20260205131234.3244467-6-harshit.m.mogalapalli@oracle.com>
 <aYTEnvrd6pZ9Lqda@smile.fi.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <aYTEnvrd6pZ9Lqda@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0257.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::11) To DS3PR10MB997700.namprd10.prod.outlook.com
 (2603:10b6:8:347::19)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PR10MB997700:EE_|SA1PR10MB997631:EE_
X-MS-Office365-Filtering-Correlation-Id: 25dda719-ad7d-4a7a-5da3-08de64d52bc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SE40bklCMFZET3hzQ1lmZDg0bktQRlI0M3JlbkFqd3RUTk40N0ErS09reVJ1?=
 =?utf-8?B?RUJMUlVUMUVoa3FNbEhCRXJLUXo0Yzh5TEtHOEszUWFBb2ZsdUhHeDFjaUpz?=
 =?utf-8?B?bkRkKzVHaW9FU0dKVmEwUTJNRUs5MWpGYW9qOTk4OEJRbmRIMFc1bTJWVFpY?=
 =?utf-8?B?MmJFKzdNVUl5ZW1kUDgvUzZGbE9hZ2dueFhkdnV0ZytUelE4L3hZRE5HMW5X?=
 =?utf-8?B?K2NXOHBvRHhrM0g1OVU0ZUNsT3RkVm0ra3BkbnJvK1Q2UHZUaDZ2b1VCTUZH?=
 =?utf-8?B?bzVlcnd2azdJQzhCSnFUSW1OUEhmR3NONjM2aTRValFtV2JTVlRscDdzaW1X?=
 =?utf-8?B?Z3BOWWZPUUpSRHl1dmdLeVJwc2xPbTExTDRISXh1T2ROUHhUcEMveXZzU2wx?=
 =?utf-8?B?VVJtM01mektVK3d3Mlp4TzMwU0pZT1owN0xBRVFXdHkxZ2J1UlhMWmdlTHJ6?=
 =?utf-8?B?dVVac2NVK1dSWWlrdkNibGpsbnVWbWY3b3I4OHdRQnk4V0ZJVzRoSUdyRTVm?=
 =?utf-8?B?QmFxQVh6bUUwNjh6YVR4a1VUMGhBVnBYNndrMDh2cVZKYVh5RkVidUZySkZv?=
 =?utf-8?B?TjEycS9vWm9WVEhXS2ZxekEvVFZ6UkFkUC90NkU3OUsxYkhRazA0REtreTRW?=
 =?utf-8?B?VHFKMjhSSjk2U1lCOTA2LzU4citxQmFXTG5NaHBPZk1kQklra3JNMnZpYzdC?=
 =?utf-8?B?NGNRWDZjZ1BJSDlINmYzTTRPSjB0bzM0U0NNbERhVFhSRWY4b0xXUFR3NXVi?=
 =?utf-8?B?dytaanRoaGdIa2N5ZmlCUm1TeWhkZ2VlaUlvUmxxZERra0tpTG92UG5yVEh5?=
 =?utf-8?B?Q0dlVk1TSnJybmxmdXk5M3JqazNCQnRscTNVd2FlRkhKNm9FczdzeEtsc3Av?=
 =?utf-8?B?ZGYzakpNaWhnZktqKzFBMzVHaVhXYmZLeFRmb3RWQWVYNmRCbVptaDRITGU1?=
 =?utf-8?B?NEhKRUd0RnpCMXV1UW40VUtUc1NrU3ZIaCtFelc0UXo0UmhjTG4vNlphcDlJ?=
 =?utf-8?B?ejlmTUJGTmVERVNqZytsQVQxYmY5c2R0dHBQYitEZTVaRmQ4OWtJaDdPSEox?=
 =?utf-8?B?SUJFeVpkdUp4aHRtOXNKbjZSajNZNENXWnlDOXpneEx6SkEyS2lZTWJGOGdH?=
 =?utf-8?B?bjA1bklta3lXejVzR3U1OWlEZ3hVYUtiMWd5bkdQNVFSUzNPbUpkajc3Qkx1?=
 =?utf-8?B?Tmlwb3VrbmRQSXk4KzBGQ0pGdHd2ZTdudTBJV3ordjVFVjA3VHNvd09pZ2pE?=
 =?utf-8?B?YS9ESzdLV0xnVi9tTnJFRjY5dnZ0Qkp5TTFuY3h5LzhGSjdXVHFNNlZJa3VH?=
 =?utf-8?B?VCsrNnc5Z1NuTWY5bnUxYjdHTzdmWkUyU1lPTkM2bHlaNU84TmNPZmRLc21Q?=
 =?utf-8?B?QW84a01jaXRjZGk4TGtaWGh4ZXRLYzlZRThtT1dXdEhOaG9CYWpHc20xbFE5?=
 =?utf-8?B?VHQ2MXllbkNLNy9BTjRjNkFpS1hFT0FiUmViTUtVa2FGZzR6SGZZeWR6Yy92?=
 =?utf-8?B?eUdUVjRYemxxaW5rRFRpRjU3YnVLUFBKK01TenRGN2Eyb3ZscFRnMG5RWmRN?=
 =?utf-8?B?VGhYazAxL0MvSitzQzdYZHhFYitwRHJKak5IVit5WXBiM3JRMkRxZ3VDd0Ix?=
 =?utf-8?B?d1FYdzhFS1M3M1V4MG5MZTRSbEtKdXF5YWtPcWpqQnlBU3Z5dDBSN3JwSCt5?=
 =?utf-8?B?QnZnVEkxNDMxaThsalluY2dMTVR2Q1p5NHRzTVNWOFV6RGxiRzIxVHVuQ1Nk?=
 =?utf-8?B?QzhJQ1RRTkZsMFdoNTNPQjVDRmZtdGJYeUFQOC9UUVN5MktjN05saW0xK0NE?=
 =?utf-8?B?R2xaSW53M01RQkhjUUczcXEzRjRQeGk5V3JBYUZmbHh5QmczWWdIbk5nS0pq?=
 =?utf-8?B?RTJzUkhQWkR4b0hvemNnUE5VTFkrT2RndjNsOFZOZ1JlLzBMNmlGc3YrN1l5?=
 =?utf-8?B?MWQ2K0VtTW44T05aT0pHcitoRTQwTURhdWxtNG42OUh2TFBFK0ZzQzcyRVV2?=
 =?utf-8?B?NjY4TjVCZXpBQXhvc3JsUUxlU2JNUFlQNUFHdE55VGdRUFBBSWttMXV5a2Mz?=
 =?utf-8?B?a0VGUDh4STRtOEY2bHRGUHFyRWRleEErbXVJYU1abCtST2ZEZnRsV3k0VEZZ?=
 =?utf-8?Q?gegM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS3PR10MB997700.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bzlCV3NPRm5NcjgyaVNDZE9PWEMyTTJvNkhqcndpckFhM2F3TjRhK3BLRUFi?=
 =?utf-8?B?V3VScmo5b2NkSXlPL2FCQTM2djB4bngrNjlTWXFnMHV6RlpPSWV0ZHdkOWtr?=
 =?utf-8?B?bnhxMjNPbi91Z29LY2NmcG1ObVBSSHR2SWtmZzNsamVqVGo5Tzdia2IxQTZ5?=
 =?utf-8?B?K2VTTUQ2ZjYyTElpYjJBRk9iR0R3N1ZSRCtjdkFlT2NKMXVaL2JLR3JVSkds?=
 =?utf-8?B?eFp3VWVGM0dwdkpMWWgrbllib1p2R3E5UU1OSkhHdS9ka05BTnM3by9ZOWZj?=
 =?utf-8?B?aDUzcy9QVmMydXgvYmQxQjAxZDEza1JUQzBjRU5RN0MrZDdPUUxjZzNQdXVv?=
 =?utf-8?B?QjJuNlNMVDU1R0htMkVIYXpWNk9hYUhJTXBsODBQUmJtUFVtMXZOSmU1cThU?=
 =?utf-8?B?VlZxRzdyMmhpZVk1bWJtMVhCYkVGWkc0eHR0M1I4cDZQRjU1UHQxdElmSC80?=
 =?utf-8?B?TkxzTGRpRzZOcURyNVZCN0NvQlJMckdNY1RISW9hY0ZmQU5kTkFyZHp6WG4v?=
 =?utf-8?B?cVVnYm83VVJXL2tlMi9VbzgvRnNlM1RNLzQ1djZndU5ySWlhRHIxWFNlVzcz?=
 =?utf-8?B?ZWFxbGs3SmpTSGlyTzZlemlNRnRva2JuQnVvdGpCS3FLUGUyU2JwQWVOY1dx?=
 =?utf-8?B?U0VsU0VIRG9HTEF5T0xhb1hUNE9uTjVBTU1za0pUdklNb0FuRTZyeEZRWDJw?=
 =?utf-8?B?dHdQWHA5V2p3SG1LSjhhck1EQU5mTWJrb2lZUkJ1eG9wazJMemgySWJkOUlV?=
 =?utf-8?B?NTFJMTkwTDRZWDFmeWQ4N3BPSGN5dXdIU0JYSWlObjZPZGZKY05MTFdyaWow?=
 =?utf-8?B?R2lVbVk0WTRHbUlxcGtRUXZNMStteDgxelEwY1JZekxMT2QyblF3akhPRUhr?=
 =?utf-8?B?K2Jkc2JPOXNwL2hqajFKdGR3dXdwcklsbHVEVFh1MjBSem1wdzZzWitiQ1pF?=
 =?utf-8?B?a3pmZjEyQlVIbkVac25UVERuSThoOHRSNXlNcDlxTzBiQW1JK3BybDNKVEc4?=
 =?utf-8?B?bEszdFlqVmJuQVJwODVzZ1Ixc2wvemVlaUlXMkFBYWg1RUpFNDJtL0FQWlM1?=
 =?utf-8?B?aDFSM1g2TXNzRUljU3duVzgwMEsrenZSUStSZHE1V09MNFNuZmJLMUYrQmZq?=
 =?utf-8?B?Mm5ocE5yZUdFekUvVHNzNHR6cnVZei8xdkVIQWNGUG13a2Q0eVhFZ1FHM0ox?=
 =?utf-8?B?ditueTZudnhGRWptanA1OFBNcWs3WVlDRzQxMGJubk54QW9NRVg0STV0d1Jv?=
 =?utf-8?B?a0VabkEya3hNVm5CUTFJYkljdDQzYU9wVkhNeWRBQUVMRHptRkVHR3oyUjFZ?=
 =?utf-8?B?TEVvQVBKQ2VpY3ozazNKcU1TckxWMUhMNmV4YmMwNXdPQVJOYzVlejRQMEdR?=
 =?utf-8?B?TE56Wjh5TTdvL2NPN3BJMlpOUjBkRGoxc3V0VVJCemE2L0ZrbW1sSEJyQ0NQ?=
 =?utf-8?B?bC9qcTlob2dEM3U1TE0wVVZibm1vckR6S2J1TFJUelpYOTR6TllFL1pHRnRs?=
 =?utf-8?B?amdCb29pT1l4NXdFRVZqMzc2UGxRYUVrUWJiT2M1d0ZUZVZ5L3ZRNTdhOG1T?=
 =?utf-8?B?VWdCQWlwUjNubU1HZUJrRVlOeDViK2RnaXc1V2crMTV0QVMydUlCWE14TWtq?=
 =?utf-8?B?dkdWSnNjOHZjU3dtb0Q5RWR1NlUvdE9zQlE3Zk5IWjV2QUJCcHRwNCtSRjlO?=
 =?utf-8?B?V1MyaDJXa3RzU1U5Q2phV3poaXdMYmh1KzQ2TzJiWlNoM2ZWbDNQdERJSUtp?=
 =?utf-8?B?bVl2WHp4MFlyZE5JaW01VWhUYXZVakdwVjVHcHQ3ZVl6RVZOWVdrWHMxMkVm?=
 =?utf-8?B?U25ERWpTWmVuUTA5cFVZaUdLaXZabTNkWk5PcUdZbTRkYm8vU0VCS3NmUmtF?=
 =?utf-8?B?NHd2MTN1M0s0dUYyOWVZRHBUUUlqZ3FjZ2xaQmxLaitNcVZCL09LTU5waTcx?=
 =?utf-8?B?aEQyaEJtYmpiaDhYek5HNGRXSlU4V1dhaENrWWU5M0V5TEVwaDRIeU93Ymg5?=
 =?utf-8?B?dnRYWjBtMnl6YWh6MlV0a2NIbS9oSHRPTE02L2hRcGFNWGg4NUlWSUlsMUxi?=
 =?utf-8?B?QkxodUhXQnR6c1BsTk9CcDlWVmNlT3RNaVlZM0JDMjlVWVgwNkpHaWRqb3NZ?=
 =?utf-8?B?Skw5SjY2c2hqSDlHaCtMNU1FWGZDSkx0TlVES3RnNkkxZ1EyMTBrS2w5RzZo?=
 =?utf-8?B?NlV5UHVHWnV2emdHTHhVc1k4TlplNCtwU3VYZUFXc29iV2dYdEI4YVFqUVdV?=
 =?utf-8?B?YTZLSlZoQk1FNWQ1RkdMZ2I3WWpBbFYxUStxeFhqTGEvT2J5aWo2LzlsVE9h?=
 =?utf-8?B?anBKdVljc1ErRXpodjY1OVZvcWRZRUR5UWtzNmFNTnA5RWhLVWhCeHdaTnY3?=
 =?utf-8?Q?mMZpDQ3T4lSFHPdWr/GGdMqamSPxU3q6PgPT1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rG2bX5hSy37SWIcxbEDtsEhqtXji+jtXMoY3ygkh8m4yiQCICQ3faMLaZex3vexIquUvXSWlwYtlGwiLh8nRRvTUhTrTJ888youjb2ydBlSD28t9gB0fiFKQW0jmuBoTCIYP2N4IAUidz4kiw3VA0jNFWf6A7BlXRTx6oFWB6I43KH1tRes6trYNbemDUtfrxglCkD4Tb5+cRHc59jSEVAxH7cQGpL1eovS6jrw4rYITu4y0l8UKgEf2lKtYSAjiQui8O2X5nqQ1Ok8EZQUgzC8VIyTDbyYBlsvDU/WEBP+vyeOUL8l1ZjKJbuNXIkC5pxBE2jmXgkJkF+sLcJ9W3hIE2BR/Kgv8dque/ZJ8Zy/02dXxnmKjfXF2pJCPYpp8aaluj1yhuGB1IuNbCbwsjvw8l4DoENKsB+yqkIB64p3v0MUrXZIeHO1M66+MN16pRR6NyGHZ6oA/TsI+2ezUOPj8dIONxPEvWx8Dtwq91hI0XlFx3A04t+gFm25Da4jIAauwXN4K+aBOJV/RCo9G2MHcoQeiU67Y1Kx4UZqr5+T/3Co56QUhZDQkrC/mBLfKkLOOhnVNQoFls8sXyUIMlAGpUX1Ri4x3xptDtK7z2Oc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25dda719-ad7d-4a7a-5da3-08de64d52bc2
X-MS-Exchange-CrossTenant-AuthSource: DS3PR10MB997700.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 16:39:46.0246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yd3EDZcxIoeaGoXJWM371vEMWFBdKegw9hh2Y4d5FVNjLRtNqk1mcGWifiqFLIHIlcuKEJjMmex9h/mOQf2LFufEBFewcQguH70ZtjNlZyJlwmPOkUa9SADMYmL5lTUg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB997631
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_04,2026-02-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0 mlxlogscore=932
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2601150000 definitions=main-2602050126
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDEyNSBTYWx0ZWRfX7/eSovgUs5kT
 1Kjp3rwDYmMqNpKbHBFVkVcaHph3tMXDqmgjpGmpd/2vsv86IMxtnqJscWerBPGgvWA4CxFcKec
 +2je9HcnIpaZYFm1OSEskcMrPFQf46eh2RlFqF6rfXA7hq823wA35O3xefm1YUJzk1hQ5c3t9D3
 rBYX1cDs6MLT525IsDSEtH70OzihE56jGqSnQgzJ2Q4fHMWEHChtdacMDudgexw006ROUHtDd8D
 oRajgDicMaw4bmoDjCflq6+Wr6Smry5vf34Q7xxP5bHDEVS0qTan5H986Oa0THLuvyyHWhhH9Io
 bRukPazH1I17jNxSSdZcaA3UC7kh4p95Nq6JATGxh8NsL58Y59smVTJWU+4tO5VrS+xbu3GI809
 uZH3n3Ks+CSFfgFYJDqv4Tjo5L/AK52UGT1AQ3LN1e6QhAH5vSVnpTJG1RKudf0NPk7o1YvzZfG
 7zoJ3h7uDtde2+wUoUCI31JH/tPjcdFRHoiJBads=
X-Proofpoint-ORIG-GUID: jpqV5u7PMrJoRfdTX7MV0pSSZNgc8ZSz
X-Proofpoint-GUID: jpqV5u7PMrJoRfdTX7MV0pSSZNgc8ZSz
X-Authority-Analysis: v=2.4 cv=CaYFJbrl c=1 sm=1 tr=0 ts=6984c7d5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=HzLeVaNsDn8A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=QyXUC8HyAAAA:8 a=fHi4pgT6aMrwoIQiOkQA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12104

Hi Andy,

On 05/02/26 21:56, Andy Shevchenko wrote:
> On Thu, Feb 05, 2026 at 05:12:11AM -0800, Harshit Mogalapalli wrote:
>> Switch sca3000_stop_all_interrupts() to use guard(mutex) to simplify the
>> error paths without needing a goto.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
>> ---
>> v4->v5: rebase it accordingly as we didn't change label "error_ret" in
>> the previous patch.
> 
> I hope you see the difference and how the whole series gets better.
> 

Yes I do, thank you very much for the guidance on this :)


Thanks,
Harshit
>> ---
> 

