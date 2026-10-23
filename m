Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.28
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792750070;
	b=PufGkHZm0LBdqsX128zJfRx/4RXZ4B9jyszCF2T9Ks9CmGtNiks/60pFPrhcHeZ53PvV
	 zE5t5NU4/fHDNXYT0JAklgGsj6WGAvLEsfap0xlPkms0TmYlMtm83JeETaU7JvJc5m6o/
	 oBRFUJpURpg6y0j7WB5k9l03UP3ma2GVur1q8TqpF8xzSuulzovFIDXSPWkoxudyjLplX
	 InlYqsg76b6tASdIwsWJ1EG4DknDc0m6uBSQX9yegO2PNwgEIwj0S/gbUWrxmUItIkPDg
	 /OYUAMF/QRZBgkCR4ZIIclClqQt7ghXYrihCj3K7kgYEm5afC/MSHIqRe3FWTEt8iLg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750070;
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
	bh=LiuQtGt+oMtbceZsCq43jWxF1+OSU4a06mfxZ9sAZgg=;
	b=WGmw5CCWKWFrUG6/jX40akEMFb19EZEgqktcTqkqJntCuz7aY0Tuj9ll9xcqgvHk2H0k
	 KkdCHiU1bgPRGLTgQgjTFqLc1iGx1wru0A3HPaYJY+PB0LVN/VoD6crB3Ni2Gb8cStg01
	 bOUMxHFHPUy9l4Vs7POmJxXVVd98AvtdWGLC3HUD8vUP07Bd2gGjdG0NDqiu7C1mg9WDm
	 ev8yjkip5Q4rLomTML1EtLk7+A6+vcuDKsfKp2zdXfm1MYB2YPG4r//kk6WaMMfVDiCEo
	 Vf86NQ/HAlzUH8yqOVyOKy4BmMr/B96MX39JF8vJl6GdjtXljJ82bTb2Inb3ykLmrxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=BFdptjWT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.65.28
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011028.outbound.protection.outlook.com [52.101.65.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AE7606A31B;
	Fri, 23 Oct 2026 10:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 92AE7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=BFdptjWT
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y30DGSfYeHtxRLaxmYnpD3gedhRXSO1jIULKRxYtBbFKxYAffstx/Bf5HXYxWCpYwi7bg8W6YnLJLROSYMz4fBxfFGzmzvx/6KMJBeukuEpW6KU4tiQ2NkSruOLxNaP3Bjc/rcSzJGyxWJ/XU6UeWqpa+MjvP2BaMFstMiY/hC3l+L58ju5onY81xyc1IKuBSJ5QW0byaR7uSFn7VzU2gls1kwd05AOVhmIOsxrzalpScxEPGNhY66gSvnEHXhxpWJZ9AyP4Cz7IW7iXjUryGS03xYYNAUbdET5PIwjugMuCFiGrbMPiaXJ1pE/f4XqyDYBVHG+eVWF49RKmKMKDRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LiuQtGt+oMtbceZsCq43jWxF1+OSU4a06mfxZ9sAZgg=;
 b=irabO8/a8c7Zf5siIZcfgy7G+I9quICuqhXHJVSn8wdVJurAvoaJw2o+OuU+ecKE+tepj7BuK6uTZ/dCyphSZVm4cAZ2yCfyhvfCL4y88vCoMtgbPUIVJfWJmvRPo6QKkgbtIZzibbsUWXtTlt7klty2szMdTUAHIoAoNHaqtWzkfy7gBTSp7wde8x51FgMaae01ZQEDLX/pY/L6nwDWin+lmpP9ywy/bc/AehuYCYcWa/LyMY+/nBlOEHxeshxWiR/C6ttBJAwII3x2pr9QfCD2lRBb39LVuPsLrwp//Bl2qb1HxaHNLz/z57BWUvSUse8/lsWuSx8pYsc9O2XTiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LiuQtGt+oMtbceZsCq43jWxF1+OSU4a06mfxZ9sAZgg=;
 b=BFdptjWT92LEMQRJ2OmPt1cQcy4sRFixMa5JZvPuExBWeN+kZ9jVQy444dqdyP6NwLd9p76SpDvFsckIsnxMJstZxkXD6H3sL1jtTzQaIMt/GL2xnWYAE+kNfDI39JDoDm6KwfFH/ZcY5P9UFf4kMVtuJgLHBAr6B2x72LQ52t0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com (2603:10a6:10:62a::23)
 by GV2PR02MB8529.eurprd02.prod.outlook.com (2603:10a6:150:ad::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.18; Fri, 23 Oct
 2026 10:07:43 +0000
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3]) by DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 10:07:43 +0000
Message-ID: <f51f9c6d-1272-46b2-a8fe-f0f100b77a9d@axis.com>
Date: Fri, 23 Oct 2026 12:07:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: light: opt4001: refactor driver to prepare to
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
References: <20261023-opt4041-v1-0-45227f82d05c@axis.com>
 <20261023-opt4041-v1-2-45227f82d05c@axis.com>
 <atsj2tE357ZvUuCm@ashevche-desk.local>
Content-Language: en-US
From: Jesper X Nilsson <jesperni@axis.com>
In-Reply-To: <atsj2tE357ZvUuCm@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0076.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::18) To DU4PR02MB12006.eurprd02.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DU4PR02MB12006:EE_|GV2PR02MB8529:EE_
X-MS-Office365-Filtering-Correlation-Id: edc6fb68-6938-45be-b220-08df30ed7a57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|23010399003|4143699003|56012099006|11063799006|261009223027099003|261022105027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gjFMzh9FPdrDbugTaVszkAWzY4l2RE+IWXfzYtjO82XC5t03f57YsjYDWuAWSxs/mc+/PS6QU3W8jSjcKeQzUxoLHGQ8ZiF6Cpe4WZiDY7sMpzG4HFDUqhzWLHaki7GrYQwHgo5QO7m1XCsLielQHRjf4u7HRCnhcA0efReBrRYrl2ngSjbo1lNIHGXkvm6jvEwd9OIh2H2OXr+aYouqWSAKGWJrnx7fi4HSCW6vjVOjqXX13SphqhhRBWmMMVxCjVukrTEWWK3/GGUJawD+lG5DsLeRTRfMXOy5We1FDRyPutp2yfj09slZcBcmnaHnp8mHQ0jATw4pWXJ5/9JHF/k86Jc8tPDwvmqgmkftFdb8X0G06Uw9Mkd0E+J7nf/BB15nJ2GLXzqvGcd08VDk/hDQXoHTZ38OLqyso+rTSMb2TBe7cCGQw6gaea+95Tm3MPGYejCKphRYlqOr0No2gSSVeVwDmhq5kAtielhkHMh2sgaNdQlPT7KiPTHAuQ43mYbQ92agrWAqM4rTjU5DtVf7TDF3+o8zcbalmeusv7rBXbW7XNJQAkMt5AV7SLyNy/DixZNYF5zJB1KrCNjWUCJM/qbv0E5WRSEzJ9R5+GrINkmfgyGLwNsD/8ONt8Ivdbu+FDXhtBTS5dxrixLOmMjcr0e1/e5yVF1vDeo679E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR02MB12006.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(23010399003)(4143699003)(56012099006)(11063799006)(261009223027099003)(261022105027099003)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V3dNelBtT3RiMWc1dzlDdjFFL052a1lwWlBsaWQ1b3RTcUc4YWZuajluVTlY?=
 =?utf-8?B?cDNhU0hkY3hFUTZSV0hsT3hnZjlvOEorNHdwSCtsTDdQWXlaV2FNM1djNWVL?=
 =?utf-8?B?aUg0WC94ZExMVUpXMEhUdWVpUW81RnlobUFZdmlZVTBtYkVSRS94cSs5SjRx?=
 =?utf-8?B?djZ0MzBqL3FucnRyZGszQkp6MzdUNlhZbGM5T29rVXZGcVlBMFd1YlhMaEJn?=
 =?utf-8?B?OTVJK3VLSnp5VzJEQ1gyM2NuZ2xwSTlGU0lIZGdiMHEzMCtNc1ErUmttalBZ?=
 =?utf-8?B?UTRqMWpGQWtxOXR2RUNvVE1vRUEwMmVBdG4zUVNwL0N0akZwbDA2V3YxQVVr?=
 =?utf-8?B?enIzbkdjanoxSk1jWVhLYWliTXdWN29BVG8yQzVjVTZlTEhuMFNMODV1WlFi?=
 =?utf-8?B?RXhONGNtREJnMXFzL0xWZGhGK1dQL2dvaGwwRFFWdnNuNG9UNy9BT3JaVVFB?=
 =?utf-8?B?SXh2a3lLTEtJVFJMemtlKzBRRmIrRHNGSFVvSXNiVGpQVmh2OHU1anY5ZWpZ?=
 =?utf-8?B?WmErcklkR21kV1BDRjhVMzhtKy9lNnNncFRHRHlYd2xnRVAzOVRLYjBvTEpi?=
 =?utf-8?B?WVZIa3IvZktxRVJBM2RNVngya01pVE1WaWY1cG1BRmRBZGNvaWtWeDBERnln?=
 =?utf-8?B?OC9QeXlydzJaZWdsYmNBRkYweFEyNzBZWi9WRVF5RmtVeGVESUp3cFZRaFpw?=
 =?utf-8?B?K2drcHdsaDVvL29jTTNScXZhWlN3elpvK0J0b3psblNRRjZ0RlhSMEpQMjBr?=
 =?utf-8?B?YllYY2lFck44cThUaGg5K0t2eEVYSm5uQlFIRFc1aFNGelo4SnlLMGZsd1NR?=
 =?utf-8?B?TGdPK1pJamova1lhb0NtS0JGYmJvYTlYVCtXTUFxZmNkbC94OWJCRC9KMm13?=
 =?utf-8?B?ZnF0dDVUcm8ySG9qc0c4TWxPTFlNRjdTWnlNSUtHODdsRXVSVTB2TVpKS2tG?=
 =?utf-8?B?OVIxRnBvbWU1V2FtMmNSQ25FWHo1RnUwajZTeUFDM1QrL1F0YktGeTR4eElk?=
 =?utf-8?B?aG1rbFJaQXdwdVorYnk5cTN3ZXVxZVNoTmZZYllmRm1LeW9GbUR2REN5RXhD?=
 =?utf-8?B?d2RrTU1wdGJ3RGx3MmNJVGFNbThJWG82d01aTTR2aDJleFhlenlQNGM1Qjdl?=
 =?utf-8?B?SHhRWlc2NFF1aGQ3ODBBaFlCVThIZGpsY1lUTmpSTjhHRWtqaWNJTHV0R1dn?=
 =?utf-8?B?dU1sLzQ5UTZsZWhjaUVVSnpiSGt2N3p2emtUTU9uVGtWYURLL3VKYWxlK2pl?=
 =?utf-8?B?aXA4aWxRRC9LZ2hXRGxrSjRweERPREt4TGZUdm96WStxM3dZcVlxcWw5Z1E1?=
 =?utf-8?B?clZKZGRWVzNBbVNmUzJTdVc4MU9WaG9rRVJVMURxQklsOTA4Z2ZyQUYyNzEz?=
 =?utf-8?B?UmgveitxL1dveVhsUEwxazFMb0tpN1hnbXMrV2x3US9GcFE0MTM3Q25wWWdF?=
 =?utf-8?B?TUFRUHdOaDJ5VFNSKzFqMFdWYUtlNzFIblFrb2ExdnEzQjEvdnh2c254Zmxs?=
 =?utf-8?B?bWNDWDFwenRZamlrWlVYL0Y3eDVia0FEQ1BnL1ViQlA3TTdGQVRtMENKbUFs?=
 =?utf-8?B?Unpvc2VCQWRBak9kZjlsejg0UVQxendaS0JobTNTT3h3Q3RJak9hY2RWbVlF?=
 =?utf-8?B?a0tEMEk1RVN6UUlRVnQyM1BSOG43cGthNFFya2VXbkdKcnIweFBLVWc1YS8v?=
 =?utf-8?B?WWRDeG5LUE44ZERVNCtObkJNdEtIOXl5QzZWRWcyMHI4SWJkWnhzekQxNXlL?=
 =?utf-8?B?YnhZS3VmQVYrMXN6NitibGI1THNyemNBd003MzlLYnREblgxWGdVUVQrRVlu?=
 =?utf-8?B?dSt6dnNJM2RhMDh2ZUJFdElhSVZvSVphdXFTUEY0djBwWVNNdks1UXliNVY0?=
 =?utf-8?B?WktvdDczdEFFZitRUGJML000c01vZGFEcHVPUUNtZ09SdkRqbUY0aWVmY1dy?=
 =?utf-8?B?M0JIMzFBQS9UbmF5L3Mvdi9peVF6cWIzdGwvaEVESTJBYjVaRy9qbGVOakVS?=
 =?utf-8?B?ZnZzYkQzTkorblBkZ3pHQVo5czhqV3ZJREFyblpTamVaODVldzlSakYyZ1k4?=
 =?utf-8?B?eHRKZFpsOG9qTjNwcE04Uy9lT1VsSkNJZFd1QzBwUEprdlZFcEhVSldRUjF0?=
 =?utf-8?B?RVhDMXpFM0pNUlZKckZWSEVEbEJ6aDdxK3NZUzZZNHpUWVFMa1NuT0Z4Vlkr?=
 =?utf-8?B?Z21qVFJnMk1ud3k2cTVaeTNjeS90RGw1ZGY4NE5pczdORW44b2hSTVJ0Z2xu?=
 =?utf-8?B?K0Zwa1JPUWIrdVA1THZxaDdSTFhlK3piRTlHUy9WTmNrNkZIZ0JwVEg3aWVJ?=
 =?utf-8?Q?9bv9gQTHLH7zIsFq3s?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edc6fb68-6938-45be-b220-08df30ed7a57
X-MS-Exchange-CrossTenant-AuthSource: DU4PR02MB12006.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:07:42.9970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hWIcmDIoCwbZIsaCOSTpaZ9clZR6ljRl3tYTP64Mfx3cJkHko1PLuvIYT9k+ZwEwd6VIpkBl3joMdLI8ZnhoRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8529

On 10/23/26 11:07, Andy Shevchenko wrote:
> [Some people who received this message don't often get email from andriy.shevchenko@intel.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> On Fri, Oct 23, 2026 at 09:48:14AM +0200, Jesper X Nilsson wrote:
>> Prepare opt4001 driver to be able to support OPT4041. Extend struct
>> opt4001_chip_info with fields channels and device_id because OPT4041 has
>> two channels and another device id.
> 
> ...
> 
>> Assisted-by: LLM
> 
> Drop this tag.
> 
I will drop the tag in v2.> ...
> 
>> +static const struct iio_chan_spec opt4001_channels[] = {
>> +     {
>> +             .type = IIO_LIGHT,
>> +             .address = OPT4001_LIGHT1_MSB,
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +             .info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
>> +             .info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)
> 
> While at it (and I see it was in the original code), add a trailing comma here.
> 
I will add trailing comma in v2.

>> +     },
>> +};
> 
> ...
> 
>>        u8 count;
>>        u8 crc;
>>        u8 calc_crc;
>> -     u64 lux_raw;
>> -     u32 rem;
>> +     u32 mantissa;
> 
> Try to put it to make more of reversed xmas tree order.
> 
I will fix it in v2.

>>        int ret;
> 
> ...
> 
>> +     chip->chip_info = i2c_get_match_data(client);
> 
> For now it requires
> 
>          if (!chip->chip_info)
>                  return -ENODATA;
> 
I will add the if check in v2.

> --
> With Best Regards,
> Andy Shevchenko

Thanks for the fast review!

Best regards,
Jesper


