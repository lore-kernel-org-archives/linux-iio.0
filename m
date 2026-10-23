Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.63
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792750788;
	b=BIwfXnXH0NZcbsz/2v5hrQJgfJpGVbtMmSQLK2SRina42W8WiSrzvEtWVcI1TUhG9HXG
	 zWw8AhNFKRLizsKQNoJZnKT1LFJGjJ3KQhVCuQiwNv4GJgM4g9js6SMcu10xN+lQewhrQ
	 mELS0O+d7qGzsmxUXu5UoNuLWMc3FNqzL2N60+MoNZDkHI0V5fnrA/JDg1lGeNwXojldG
	 e+s8WAPwtwdJ9fRByE4lyTvPaGddwPGoWR8LAqZfLbh9MsKIxkx65NGciwmvBm1VWLUvq
	 wGyOr8cCa5/LUKKe+g8nG3oY3LkjD1bvtG+WzX60JYOnLKaUngtsgwuZtdQ67x4dKMQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750788;
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
	bh=88Pc6nFyiXZM1X284UUVFQ/onxhVXr5jRp6cpJ+ZXyY=;
	b=XNp+t/Pwc3Zf5OH2yLS7kdIaYAZirdtx44M+2cvd6Pb0PgvyOB68VxTCBcF4e54Z8gsh
	 KpetAI7d7sGzAicoYmlvx5rvrqw5YUtdmTFQlVuZRsGoeYV8bxGS2m3HnUAfMg7BdCIJo
	 wciaEz4wahRToW/+BeyHKQfkJuX6XjFGSJzxm6Jkl9rElZ6qGX1DTU+SnRbDvAJROuCiW
	 zFRKWfQmvIidXaGFDNXI0yvtwP6iICrxVyAV7VndKzaIu4SBUvINdz6JNmFCWmoF3rrkH
	 1DJ4g37MDkZf1dH3bqpZ9AjJmgBtILUCJ0//YJFc5R4YvEr9w+r17CR00IGHX2qVN8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b="i/XkcAxs";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.63
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010063.outbound.protection.outlook.com [52.101.84.63])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366A9606A323;
	Fri, 23 Oct 2026 10:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 366A9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=i/XkcAxs
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=heTIC3B9Cik4UkBoAYp3j3+z9l0jrVPEKwDEdSF/J9a6UZmTXm5YNTLeYUDN/6e2jKGnMm2mBxmGTSvPbRXga+A/4/ShWg6cdvHp6NfCOtqSlDocHTk6CJS/YaJwoEb5jpz11Hhtopz0wiHm8TBseTa31OMGaXTgqcUTb599bb4OFigUfQ9ukn/mDTa7nhQXjzmN3es1vEu6tiBp2k4oHkBj7ma470TY0lSFt0blxMoOXmgt3/BUDamZo0TPPuevR/71/1AG2jrx3qWW29UjxzlSFMrGQgV4aUPqZo1lzYp7h6Qu6Y2Jnztrpyh04GPYNAyumGIaVTPWj9H7GGK7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=88Pc6nFyiXZM1X284UUVFQ/onxhVXr5jRp6cpJ+ZXyY=;
 b=TumuMlodb3xxAxU8GnEE4zaZuCB2sUgG1nLs+tlAIE5NBMKf2lXpJlUP4MbJLjV1DPuqa2xbBQGkz3EX/1FNUuvd9k5j1tzb7jnNd0MvabpfkSgpWW5CLnrhua49VZeF26uPq28HTHwEU60tl1Zfn5ovT5TSgIGp4Pq1rCRFSe82yn2zcOwWQo0d6E9Z3HFHR1dLpNkJ4qzvR9f/WeFb4xomCC/dRhv5FzegZpBbwZ2O7cGc2oEhbGM968vponyJhbyDRQYNc1VFxUsq4zaPc1Ye5p/IH1mmC7uN4lEXmXjWrDCI2lOofwXJo4CMJPluPta37HvT1KG/9LLBtFBO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88Pc6nFyiXZM1X284UUVFQ/onxhVXr5jRp6cpJ+ZXyY=;
 b=i/XkcAxs2h5fUEY3czZwlurexnPAkx+Ijl1N/k3dPWDLKH0zEBGeieNGE9nGMevftqf1DyALL3Feqo1w5kASZdzNXECM8qusouuMVaCV3ik5lOsArhMGPfsmoWuKtcyIL3jR8JFQEwmLS5sRB/5qaFNDD1Su1WjIAde/xYnPXfM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com (2603:10a6:10:62a::23)
 by GV2PR02MB8697.eurprd02.prod.outlook.com (2603:10a6:150:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Fri, 23 Oct
 2026 10:19:43 +0000
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3]) by DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 10:19:43 +0000
Message-ID: <7cac8178-ee10-43b5-9fc1-6537b96e8c0a@axis.com>
Date: Fri, 23 Oct 2026 12:19:41 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iio: light: opt4001: add support for opt4041
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
 <20261023-opt4041-v1-3-45227f82d05c@axis.com>
 <atslcgx03BMp-juY@ashevche-desk.local>
Content-Language: en-US
From: Jesper X Nilsson <jesperni@axis.com>
In-Reply-To: <atslcgx03BMp-juY@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0077.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::20) To DU4PR02MB12006.eurprd02.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DU4PR02MB12006:EE_|GV2PR02MB8697:EE_
X-MS-Office365-Filtering-Correlation-Id: 32ccb407-ae9c-4047-ed12-08df30ef2787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|366016|376014|10067099003|18002099003|22082099003|261022113327099003|3023799007|11063799006|261009223027099003|4143699003|261022105027099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info:
	M2jeBieSB5G9Ad1RKgV2orp7hXNzM2LspLIMXpYZPziu/ppGBTh3jvdqsJEvxea3G3UrMhd6kykhS2cwE1Id9SLYzEWme9fYVXd05m86s/SYFR3NVvyTIJtDT5kblWtfGDHUSUFnKXDB9zm5P6MIvqvCPBCCVOEuYk4SntGN/0ZIAjSZrO/dHq8SuHU3E6uJ8Er69CxDjQJiQLZl3+udoPt5J2hAh69Uc3lqkdQ/KTe2crB5CXPnD4XrxZqYp+PkAN+LRTiG3RamYtp6GnerALV9pNB1tJdd1wY4/gO3Zj+jZEtyFWQkywYKQhAlPbNEVqWtzoHygC44XjqnRhdtwjvqlySqHaO/mEkELZYoOSf0zdJwEh6nK6mZMBiyA8kbW2IBipTZAeZi5kq31MyKwOof+Miep2VDnaKy0WJLfF/p1y1cPnpPQGRxuXgpz8BviTS7bn1uIpCgqMm4ywi4tLgYb8miDSGLeySKNSViJpzVW1eSJwranKhVpFTBMThnJICOO0xdFO5JUH9SWFl3GFWYXpfaIn8emM3b3TDQwz6NyyCNxLB8yWs3EXvSUXpswxMHW8mMK6BAzbQP8Pr0dEfDTJ7HbHJ8lzIAXbdTCU8EGb2Z92pThiyBC8zgrbLofHFHrUSU265c47z620IFqAFTjZcW7rzHkYa+jxqut20=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR02MB12006.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(366016)(376014)(10067099003)(18002099003)(22082099003)(261022113327099003)(3023799007)(11063799006)(261009223027099003)(4143699003)(261022105027099003)(56012099006)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWc5YjVWbGZOVXZ3TXBiYTNEOUl1OEdCZFNHY2pQS054V1lCM21RT05qOVk2?=
 =?utf-8?B?SHFDS2V2NUlES3Vka255K2tYalhIc21iUHE4aDJib2JHVllKZFIrK0kvem42?=
 =?utf-8?B?RDFMcGdmQkhrV1NkZ2xPZzJqSWZuQ1NWK0IwK0lMNjNVRnNyaE1GWVdsL3pn?=
 =?utf-8?B?YVc0c1oyb1RjWWpaUTlTbTBEL0hrV1Y1Lyszd1RzV2xWR0MvRXZPN2IxRENO?=
 =?utf-8?B?QktjSHFJcEhudGFPQ28xNEp6MUVIc05lS3I2ck1ORHp6NHFkOXFCdlRpUlJn?=
 =?utf-8?B?ckFOREtpK042NThmenhBWVVYUFY1RFd3TkQrNENDMDA0QVowaUJjSE1FRk9s?=
 =?utf-8?B?Smo5bUU0TUV5ZDNLZFlqV3U3ZldmMmJ5QU0ybmR1YlRYS1JzMTQ1dVFpQXpL?=
 =?utf-8?B?bi84U1cySlBScldON25jazhUYU1tR0dVaEl2d2VoSTBwUU1lNjRsUzEyd2g4?=
 =?utf-8?B?cFk2YVhHNSszTVNKQlVwQlQxT3V2UjI1MFpCOXR6UHhDTitTd0twZlBFWTZ4?=
 =?utf-8?B?Wnk0OVJCYy8vYkp6VkwwcDQyZjg0WnU1RDAzdnE1blR5amZTZGt5Nk02ZndX?=
 =?utf-8?B?OXppTURJajFwMG1ic0JERFhiZE9XRUZDVGNlUUdSMWhtbmNzcDJaQnVLcm9l?=
 =?utf-8?B?U2RhbWEydFFsQmhzNDh6amwrK251TlMyb01xQXhmNkdvL2pNdTlUeU43eC9i?=
 =?utf-8?B?Rkh6NDVSTTBFWTR6eGlxR1llUVl3R05lWTBZSm1BM0pnY3B2UU14Y0dlb0tD?=
 =?utf-8?B?K1lmb2lnY2Y5NmNybXpVTTZ1SUcyb2pod3Z4U3hRb3B6dVdiS01VOHhjYU9q?=
 =?utf-8?B?ZFJWczlrc250dloyS2ZUNTFwWmtzdnlUNXZZMHV6SWMrelJPcTZ3VVpVd1Rl?=
 =?utf-8?B?a3FnQkxGZDU0emtPKytzK1NNanJ5SjFxMDMxNW55QmlJNXl1N2ppTTk2aDRY?=
 =?utf-8?B?N2dOd0QzbUpEUTlCZVNBdjMwUEJSTm9mSzA3Y0lWc090SkJJbVhKcWxyZXJo?=
 =?utf-8?B?UklabnFHNVJsSU1DcUdKWm93SGw3L0NSdTJ5Ym9VM1BWTURmK0dld1l4dXU4?=
 =?utf-8?B?dVloTnJ3YXJQbnFyWUtYZnpKRTlDN2l5UVpLWlVlR3hWVk1FTldhT0lKS3hq?=
 =?utf-8?B?YUhHR29wYnZESDMvMC8rVk9sREc1clpMNUVoWHB1VTIwYUIrT1BLU1VjZXdr?=
 =?utf-8?B?eUlXNmI2NlVKdzJraWVNcDdkaWRidlBEQU0wOTlZbUkwVkcvTS9teFdvbHZB?=
 =?utf-8?B?MUlUZlpEMGZNa1Z3RXlnV1d4RHhFQmJJWXhhZldyYTRtVEJLNnRhZ2o3b2ZK?=
 =?utf-8?B?enJ4V0FweU85eXorTW85eUV2d3dNZ1NjbmJOYlR6NUc3dWhNaWQzTm9BOHJB?=
 =?utf-8?B?N3MxL2ZXdVdJYXZvUmR2VVNKMjJQVHZESHhBWWlBN3JPSXNFbEROWnEyY2Fz?=
 =?utf-8?B?ZWRPUHdXaFV2OUdGQXpxWnByUTZHMlVOTklTZGxsUi8rZWtSZFoxOE42YnBv?=
 =?utf-8?B?WXRuRzRSMmpjelNVZHVzU1JJQTluUmd4aHF5aEhSVGZCL212Ulo1NGR6Rm1C?=
 =?utf-8?B?amNlU05peHlraENLQXVvZDFBOHMwWE02WHlIdnFjSForU01TbUdzUVB5aGli?=
 =?utf-8?B?cTI0VDVYdnFsVXRsdjhRaHhFZXJTVVZDYWFpQkJDUVh3V1g4NG80alh3bVZ0?=
 =?utf-8?B?ZGdaY3k4Vk5IMTRjQjFNYnNoVnk3OFY3OHcxSHBzWGZnUmZ5UnhjWnNQNk9n?=
 =?utf-8?B?TmNLZXk1MUo2RnN5MVg5VG5nZHM0NzZ4ZldKQW1zdE13NkUyQzNNd1IvTHpj?=
 =?utf-8?B?WjZEQTJDOXhVUTcvV29ZL1ZIbUhZdVRGYkk4RFdSSG80eUxYSFN3RDZYVEtz?=
 =?utf-8?B?UDJ5cmlKNUpwMVZ2MmNrdEdlZTlhekplT2dqSlk0bGtTdUdYWkZhU2tmZlA3?=
 =?utf-8?B?RFBQQW1pZS9DSjZZbHdveE5zRTR6YnhMTU1aaExwU05OOGN6bGl4R0NicmxN?=
 =?utf-8?B?VWdnSi9uYTIyL0NxNnV5MW9iOGFXMWFhRWlDdXFvSDEzVEwva1BmYkMwckZw?=
 =?utf-8?B?K0l5QS9oUHVJaE9Bakw4eDZvanhwekhYZDFwRHZNVlFwSmFKM0NjQmJSajlM?=
 =?utf-8?B?Qks1OGZPNE1TdWF2MzI4WExhQUd0cjc1WWV0cjNWbFlLL0xuU3ZoZUkxQURT?=
 =?utf-8?B?TlRKZDZYc2RFS0pPeDlqT0FTdTRMZWF2ZURTZmsrK1A1VEZVeVRrNExUQjdj?=
 =?utf-8?B?YUtJeWJsWU9XR1JNVnFrajF3V2tqN2pnOERES01PREdVSm5COGZnLzg0RDVI?=
 =?utf-8?Q?pYz0gyroAbDEEJriVX?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32ccb407-ae9c-4047-ed12-08df30ef2787
X-MS-Exchange-CrossTenant-AuthSource: DU4PR02MB12006.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:19:43.0215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sxxKPTfGCgbvCRuRO0Y11TcJn2VlLUaWcgd4XD0gM/5ykSjICyTlkRAQXgHc9Oxk0pnOxJ6wkHjVYO7I+fHzBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR02MB8697

On 10/23/26 11:14, Andy Shevchenko wrote:
> On Fri, Oct 23, 2026 at 09:48:15AM +0200, Jesper X Nilsson wrote:
>> Extend the opt4001 driver to also support OPT4041. The devices are very
>> similar, with the difference being OPT4041 having two channels, one
>> visible and one wide band channel ranging from 380nm to 1000nm.
>>
>> The register map is almost the same. OPT4001 has registers to read out
>> the last four values sampled. OPT4041 maps to the same registers, but
>> has two channels, saving the last two samples for each channel.
> 
> ...
> 
>> Assisted-by: LLM
> 
> Drop this.
> 
I will drop the tag in v2.

> ...
> 
>>   	help
>>   	  If you say Y or M here, you get support for Texas Instruments
>> -	  OPT4001 Ambient Light Sensor.
>> +	  OPT4001 and OPT4041 Ambient Light Sensors.
> 
> We in IIO established kinda a style for this to be scalable, id est list them
> one-per-line:
> 
> 	  If you say Y or M here, you get support for Texas Instruments
> 	  Ambient Light Sensors:
> 	  - OPT4001 (...can add some short useful detail here...)
> 	  - OPT4041 (...can add some short useful detail here...)
> 
I will change to this style in v2.

>>   	  If built as a dynamically linked module, it will be called
>>   	  opt4001.
> 
> Perhaps also consider changing summary text at tristate to make it like
> "...OPT4001 and compatible".
> 
Good suggestion, will add it in v2.

> ...
> 
>> - * Device driver for the Texas Instruments OPT4001.
>> + * Device driver for the Texas Instruments OPT4001 and OPT4041.
> 
> Make this and MODULE_DESCRIPTION() to be the same as summary in the Kconfig,
> see above.
> 
I will update the MODULE_DESCRIPTION() in v2.

>>    */
> 
> ...
> 
>> +static const struct iio_chan_spec opt4041_channels[] = {
>> +	{
>> +		.type = IIO_LIGHT,
>> +		.address = OPT4001_LIGHT1_MSB,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
>> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)
> 
> Trailing comma.
> 
>> +	},
>> +	{
>> +		.type = IIO_INTENSITY,
>> +		.modified = 1,
>> +		.channel2 = IIO_MOD_LIGHT_BOTH,
>> +		.address = OPT4041_LIGHT2_MSB,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
>> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_INT_TIME),
>> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_INT_TIME)
> 
> Ditto.
> 
>> +	},
>> +};
> 
> ...
> 
>> +static const struct opt4001_chip_info opt4041_sot_5x3_info = {
>> +	.mul = 5850,
>> +	.div = 10000000,
> 
> Just sent a patch to move this to use struct s32_fract, I believe you may
> incorporate it into your series as a precursor).
> 
I will add the patch to my series.

>> +	.name = "opt4041-sot-5x3",
>> +	.channels = opt4041_channels,
>> +	.num_channels = ARRAY_SIZE(opt4041_channels),
>> +	.device_id = OPT4041_DEVICE_ID_VAL,
>> +};
> 
> ...
> 
>> +MODULE_DESCRIPTION("Texas Instruments opt4001 and opt4041 ambient light sensor driver");
> 
> See above.
> 

Thanks for the fast review!

Best regards,
Jesper

