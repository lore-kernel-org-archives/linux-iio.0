Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793024916;
	b=bmoWFqt6KwZHcqeR3FZvjSs+H+G6D2tlt2MTDyX/IkKblxUbfMWAZPE//B5dLU9TR+Ow
	 ZHmrj4cos966x+Zp/wkigrNRSbsY1O0LVOTZ1rSEBnNGmPkApQqNlErB2iPfhChOTzmUN
	 e2cc2TgpLrjxgEsCKOshiG+wrpTdhJhMmjR5QYIBL6sWyqJ/lMz9Phy3CvTLqXgl3J7AA
	 wR9noNFHAjUTSJ1l1SnrTImjVOLBDApa7DtjhwKRkbaRYhdF3CUifDyfuzwXarqXddP9m
	 XENuFSHK1lgkauWRzZVMsGN11yMT/VsFnPNOFFTNLTzqS+S7kH7w1v3GTrYlR3WROXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024916;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Message-ID:Date:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=ZdCYMtHvbPtitPyePdYBvz85CyvRoNuQJxLJFg9R8/4=;
	b=4xdkHKsI1oFP/6d5TKV07a4zsjaH+t+JJk8SUHBDR+znHLbNOQ8cgmwGYyxcSpw53BRY
	 1+vqLym+bY3IzlOYhnEygciuGRUOe9A0FwUb+EW/qgR61XTxN2iG2O7aDYIs6MVrr3rQ0
	 SUD2+WABwBAiC2ZnXltoWeknr0v2/7JM0cukVmfTxJV/pNvyqMxcQIBBNKNsjtKeupjXS
	 Noaltrg409GqXcvHknhvOmxwcKCaSPH8Hv2DFSQNowi7BS+lZH0sMPq+lh+ue7sDEJGa7
	 FVMwlcYM4d8hvQW32e1RdMDWTzpCFB880LNXM9SHn/jVN8pKAgX8jDesGIe+y+BIRkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Vldvbzaz;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.42
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013042.outbound.protection.outlook.com [40.107.159.42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDBC606A31A;
	Mon, 26 Oct 2026 14:28:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ECDBC606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Vldvbzaz
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q+Ts6fGD+a8u5ySALldu4fyXf1EO8oM9SxWlnVOlTLnc31ZRGKMY6joSu1t0WchpFzV9kT6FOjACQPPnQ0eG9wvBeF1BilEklUGzQx7LSmYuPSG3KhhcVX1ZxgjDApeJ6ktgPIbxN2kGuBATdKRlaxjMzcueMBJlnyPqG+NtYg8tUk7wrjQv5SmX++SCfwuTnab1YqoQFox6mbHzE51NqSSXsiPP7ptsibfstDms2+KkmEn4wLTnuXTtD5DSenFmjEnwKsUV+bE3colMFcdymr3UugVqQSP35cz+vSqN6z75Yi7/OPO9cosmo2NDRhxvBrsWZW2bdwVvWOJtEy+yHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZdCYMtHvbPtitPyePdYBvz85CyvRoNuQJxLJFg9R8/4=;
 b=AB5Ok8vFX1WNefdSP13LCLYERA+Pn5BKWJeHJviTbwWYQu8QbPqMg089JzhiVVs2niBxm1If58c4WoXnHX/1OcGJ50kOmoeZej+I7JLtJFRd/sLF7EJOiFnemmt4z3HKYG+v0Cp5klkEIpX8MeIIEV8mmwEwJtjjTpKorYNOrbon/LZex/JAiFUhMevCon3kBDiW/TrXqVPZiOkhYVjJF0PjlknhVwsTmB9opgt+2rKLCMMZIY7fWdmGcxa8BvrUEOZlzMgdwYm0o2bdSCg1ZKCxPCH8cy8mcq/L0BSGLdW/WeKZiW/J7IpuVfSslv8ZaENi5/inQDSLgwzcJ63Pxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZdCYMtHvbPtitPyePdYBvz85CyvRoNuQJxLJFg9R8/4=;
 b=Vldvbzazqgo8oXvCvPKmVV49md2mgO9avatuvNNSEDc31kEo0ej76K0PwLRTuPMBEtjdLOB/YLbjofp5DdkiqBN+R6b6ZPHku6ffiKUZgGGBec9pU2Ll46y/T2SBE97cTGoTNJqKeVUyeUeD6VVYPvvtAAD/2a7rZ+SBq+HSbYE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com (2603:10a6:10:62a::23)
 by DBAPR02MB6085.eurprd02.prod.outlook.com (2603:10a6:10:181::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Mon, 26 Oct
 2026 14:28:33 +0000
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3]) by DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3%5]) with mapi id 15.21.0546.019; Mon, 26 Oct 2026
 14:28:33 +0000
Message-ID: <93844374-9704-4657-8ce8-9d057c9cd4e8@axis.com>
Date: Mon, 26 Oct 2026 15:28:32 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] iio: light: opt4001: refactor driver to prepare to
 support more devices
To: Andy Shevchenko <andriy.shevchenko@intel.com>,
 Jesper X Nilsson <jesper.x.nilsson@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com
References: <20261023-opt4041-v2-0-ee320812804c@axis.com>
 <20261023-opt4041-v2-3-ee320812804c@axis.com>
 <attmbDFpqyBHV0VW@ashevche-desk.local>
Content-Language: en-US
From: Jesper X Nilsson <jesperni@axis.com>
In-Reply-To: <attmbDFpqyBHV0VW@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0067.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::34) To DU4PR02MB12006.eurprd02.prod.outlook.com
 (2603:10a6:10:62a::23)
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
X-MS-TrafficTypeDiagnostic: DU4PR02MB12006:EE_|DBAPR02MB6085:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9c9dfe-dcb0-4e15-13d6-08df336d69df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|261022105027099003|56012099006|11063799006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Utlu8IUaZWLkSCuH71cnHCiRbCrYO9iMGlkb9kqczqQMBPaxHr61IOOFfr3DLN4ORPyZj3B7MJhCyuIuF25LrRkCVDPXsV53BuugmhmkkGl+YsJU5GioTYEgnh9nyPoLcwr1hdUbQ5L/RN2eRSsp2doh2xo1cmEut75/QITKNekiEKOJzRLoiPt2FsJXLDop6mu7OdZZNdYUgPkxR+ETxs6vB07g//Bx1o2ciJ+CohPr7yd25gFypFtcI4/GIgm5cHvL/HvyacyWFKm8jjXSqeFgzwASlluvo4HqKSCLE4rJrPGPqU6o0aQ301kRMOL63nz/lweBK73fv9cSt7QAWOYklYW0h7iWueHYUbFWg4l73xmt/Uju5cAh009TTad3zHw1BNeEBeYMUjGxdUJlkmL4S74s4mHTmNoBELS0PhxWWsr2Azr+Pf5FaLf3GQo1LOkEZOBT13YD8ekd5xG14XPPM5QSC+Vw4l8u1nJQ+hb73tUDwluHZT01c+GwgIrj2Spd0EmeAoV0+mb+DQFMjf3WUwrF6gm6d0vRwhr8S+7JX8h9gK4TdFLsDvHpQkqzPPHUKOEHh/3KsnsKJiYbUbMeZaUuSftitxkm8iUPZL6W7hEpzOBUNrYylmfv2Tv5iIGGUENEKiILBv2HirGll4bSGcXkr4UOJUt02ZzBu3Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR02MB12006.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261022105027099003)(56012099006)(11063799006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V1dkSnE2NTNJUjVrZkc5Y2VDckdIQVlmdDRqL0FWaHdualh0UkdLWFdNQmR4?=
 =?utf-8?B?RTFKcXhlNStIYVVqZ0JENVFmYlZRMkJhWUQrZzF2ZkhlRVczWHNWRUZFMTE5?=
 =?utf-8?B?eVhQa0o5VjI5eExnVUQwcjdnS3hDamtTTHZXSmRTcjhZN090anJSSEk0TkJs?=
 =?utf-8?B?UUdCd2ZUeGppeW45UjhMQ0ZsS3ZSajlPSmVJUStLdlROdXlJa2MzTmFTRjBi?=
 =?utf-8?B?QlpMc0JHaVVXZ2lheCtmeGRaZUtVNkdRb3JaS0Z5MnhYVUNNcjB3T0J2L2Nk?=
 =?utf-8?B?Njc2VlkxdUJlSWVXRFJ6T09EcStTNnFZOUpVSU0wSy92NEVPWEZtaTQwZS9p?=
 =?utf-8?B?eE9BeS9XWDdUZVRVMzdXSmZ1WFVOZEhzdFN1OUJaK0I5K2dDSFVKQU5raDVY?=
 =?utf-8?B?VGlGWlA0b1pqUDA2aTNlZytLWjBURHdkd0g4aWlKcnZDNktSUHhwR3JtY1hU?=
 =?utf-8?B?eStCcEdLVnpiOEZkZkdsTVpqMDI3NnVUWjBBMm5PWk8yam95KzB2cmN0Yndi?=
 =?utf-8?B?VGFwVUs5YmozTDVDWE9ValVFMjBkdW5qblc5T3B5MVpnQ3NsVkpaS2FHOWdV?=
 =?utf-8?B?MFMzM2JzSkF5ZG1KbXpVN1pHQUV6Qk9KWFZDVXRnNW5hSWFyL0MvS2pjZEhR?=
 =?utf-8?B?aU05S0hFY0M0N1NTTXFkUGdrdGx6bmg2T0hiWVJrempMbHJtU3dlQmtUVnpa?=
 =?utf-8?B?aXVMV05HK1cvR3VLM3RlYU5WV28zSUlsUXpjV292SHdUUCtQODJCb0ZVWnZI?=
 =?utf-8?B?STNScUZVdVJETlZWdmJrT0VjWTdwS1gyVjZPNXdFV1ZpbTJQdnNKK2t3cXJ2?=
 =?utf-8?B?THliQ0tvS0dWczJ4SzlnaTloenlKK0ROekRjSWJYSEluUkVtWTJQamZjZzI3?=
 =?utf-8?B?bEE0SUw2UWpFeEpnY1JqZWdYVWsvNzN2QWluc0RZMjhtVjczN2NXUWdYUDJB?=
 =?utf-8?B?RFhVb1JjU1N6T01DN3hER09oNkhoaTNQNlkyNGlvQjdIUmRwUUJjQnBFRUJj?=
 =?utf-8?B?SDJKQ1VnSWQ3YUVENXNKWFM5MXdkbzFGdXBTSVU2bGd6NkIwNnBoM1ZhMndI?=
 =?utf-8?B?bzRBcDE4MU9GTUgwekJCWWxNcmdpaUFKYjVKYmJoaEphRW1ucVp6dzBNM2xi?=
 =?utf-8?B?V1FFN3pnK1JHNWZZM2oyUHlxeElKa2hXSng5RkFEVUZVamJaRTZqWldIRUdo?=
 =?utf-8?B?QmxzRUxrUHIySHFuS2JsQnppTGd5aDQ0ejEyMUZGRnMyeGVCb2cxMjFCOFB1?=
 =?utf-8?B?UmtXV1hqa3V2cHpjTThOVHhmbnJ5R3ZZMmgyWUkvaE1BVCtiOTNrdXhuNFFP?=
 =?utf-8?B?ZjZXaXJiSjVrOWRObk5SLzBGUGdXdzZXRzl0Y2p6T2FLbENCU1F1REdCTzdx?=
 =?utf-8?B?YjhyMTVINHpqMnAyWHk1WFNsZHBaQVhoWWpVWnJvNU9UelB5a0d6K2RUamJE?=
 =?utf-8?B?aHhSbmxoUjBQMmk0VjVmcWZGdmFkb3JCQ0YrY0xDa0JNTnpRa1RHSzNwZmRn?=
 =?utf-8?B?ci93cjUzeG5SeFRVVi9vcHFjcFcxbUw3WmJ1bEhsSjVvVVlGU3ZiNk1jeHNS?=
 =?utf-8?B?SHpmR2lzcDJmZ2svU1Y0dXJjYlltcFBJaDk2M3BFYzdaRXVUaDhRVWpqUXpk?=
 =?utf-8?B?SkI3dk5nS2xJRnNielZtMnR1ZnNuNll3Tkk1cityMTI0ekdqbngrUGVqTWFm?=
 =?utf-8?B?MlFvcDhtTGdZbXd5bURQOGliOFBNSkJKbit5M0RpZ3AvOUc2U1VQMG9tVHFN?=
 =?utf-8?B?L01yb3R0M1BKTFRmY2d0NXVIRlV0K1dIUmUrM1M0d0l5Y25hT3Y1b2YwNkdF?=
 =?utf-8?B?b2VYOVJmbzQ0ZE8wRk1IZnRydkZEL0Y4bVF5UFZ2TjJ5V0tFMjRlb0hTMDBv?=
 =?utf-8?B?L3RCcTV4OWNIcjlRaWdVWHJ0N0NkcDRuM1BrcHUrbWhVUG5PY3BPeTJEVDRS?=
 =?utf-8?B?VGM0WEdqN0xIYk4zVmJrUFIxYTFTaG1TZ1Q3MVA4ZjFaVWJvNnhTTU9HUmcz?=
 =?utf-8?B?L0l5ZmRkdGdvTEliMGZjbThOMUVOa1hNcDI3eG1TNVRhdFBqSmsxOXdQZWpx?=
 =?utf-8?B?aFQrTWJTU1N3Yjg3LzZ5WlFsaVFuc2UvZUgxNXVjOElid3ZNUUxUeDNyVFNQ?=
 =?utf-8?B?dTJqeU5tMDM2WUcyUnBhOG5kVlB3MC95azRoeGJNUyt4UHZ2SnlpNTEwZlVj?=
 =?utf-8?B?L1M2cDBnVHlHVXA2MEcxVUpmbG9SMjk1ZFlJcDBVY0dxUWJGVmdkV2kraDZN?=
 =?utf-8?B?cmJpdjhJRTNIOFZFZmVQa1M1Y2hqRy9hN2pxVHBYdy9GVHhuaDVjY2M4Y0xI?=
 =?utf-8?Q?s+mbNsK7OXuX634eTn?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9c9dfe-dcb0-4e15-13d6-08df336d69df
X-MS-Exchange-CrossTenant-AuthSource: DU4PR02MB12006.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 14:28:33.2538
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZbSyEH+WmF4ikidGZIPxFSkRB4+7c4ktvd3K8u8tEobRCli6YQJGKsQIUHv26qaOjXtOs8ZU5fP/qzpdX46nWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR02MB6085

On 10/23/26 15:51, Andy Shevchenko wrote:
> On Fri, Oct 23, 2026 at 02:30:30PM +0200, Jesper X Nilsson wrote:
>> Prepare opt4001 driver to be able to support OPT4041. Extend struct
>> opt4001_chip_info with fields channels and device_id because OPT4041 has
>> two channels and another device id.
> 
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> ...
> 
>> -	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_MSB, &light1);
>> +	ret = regmap_read(chip->regmap, reg, &light1);
>>   	if (ret < 0) {
>>   		dev_err(dev, "Failed to read data bytes");
>>   		return ret;
>>   	}
>>   
>> -	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_LSB, &light2);
>> +	ret = regmap_read(chip->regmap, reg + 1, &light2);
>>   	if (ret < 0) {
>>   		dev_err(dev, "Failed to read data bytes");
>>   		return ret;
> 
> Can it be actually a bulk read? (Not part of this series, I assume.)
> 
Yes it can be a bulk read, but not part of this series.
If no one else adds a patch, I think I can send a patch later this week.

Best regards,
Jesper
