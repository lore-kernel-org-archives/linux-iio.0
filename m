Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792750981;
	b=lfCtWdbtwOTpRlQpbEWpPO9RQ7MfBm7uZ2JfjAxp4kbYTeTpxStCbfoUcG6ID35ocjNT
	 Z+8Cnr9ZCWgFeNEoWbRjmiL8fJsA86V6Njx7Io5KlwosvMGDhMAyjNMduxqmzIy4Q4Tfx
	 vKb0eM/sZg2r0PTaT5Y2WqHYSyVhWmXLosbV4c12oE0WyVxrLeYvoTRooHM7F4cVaPRcM
	 +Er1G3jNG1dTSyZLRF99iHt66JF1/sNqkZ9GFxkkOGT7ltr3f2jY0JNm+FcRTCY9W9aNm
	 646ktpMjyl0eFx7Pa14MVzUaXPMaelMCjUpIaHuEaZNfTfCQDviurJDQ0wDAeoCU2RQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750981;
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
	bh=huKpjUao8sUU9Vdzts03Yu14+NDHtcOaYek251AsiuM=;
	b=LZd8zX1yj2ySUj2VNE2t1Kxx5iOCuWfdkJWzZyBgFBxVadsTqW6Vnqws4UB0+lQRqL/K
	 s9sKhqLuaMVvoWP0NADnMLA74D5GMgEINAafYPUSDPV3jyDDRYrG5r3OUvAAQXGn9OQyh
	 /fHmSRahCQDmpHg/49i4GyOK8ictKShoqm/u175az/kr8OSg6AeiCod37Nl0CnJe56Tp7
	 aMzHa9dWE6GPlo2gmXzLiqFmeCebhGaro3lNFrpYLumbP2H1dNOWaJIAagWYsuvRVsdyc
	 ZfnU9GfyBOW+wHwPKcOqYbOQq8WWyufxSTa9VZYBX502eVColMJpmxauRfARR4sJHUA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Tvu5eu2J;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.53
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013053.outbound.protection.outlook.com [52.101.72.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED6B606A31B;
	Fri, 23 Oct 2026 10:23:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9ED6B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=Tvu5eu2J
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GTDSJm80AfOJDfO1mveGECS4ynjMvMef5yjbuJU5ag8in5ZGAuVe/ge34rqbzKVX+YHMZ4fXIgZW0H5gJSTBg4bqR7XuUWUxIQhOzq7RBblqjGXNTgOGvl9XiCXAglZWFuZtiF1SgUhMeI6PZMkHZ2bJasb1I+PITR4xa9aGQYoOGfz0lngZNMwn2QOYkiVBRo7PMAwHIR739ZLFEyynhsgFga2z1dKreUthoGp4LbDepWLR4EkZAe7KZZHcnE72Nbf5GaUxXzoKeIWA6iD5ayMAT6BY5jDm7ZgQlrvPOCEeBoXeS9UKCIL7mv2lgCAJBE09AlbBCYk2hW1ZFNwW4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huKpjUao8sUU9Vdzts03Yu14+NDHtcOaYek251AsiuM=;
 b=yHLcszIAEimoN+BlM+9gkZjIDBLyQ1NttYCj0GOhwI06J2zi1PS28feiRcroF1JwTpTaaHN3hlJNCXpnxuT6Rvgi2cg2Ozyv6URZb1jMpoNk1tGzGcajwCWgEv0HDMsxhMb6XHXVOwVduMSXyXzX0ZMiSFVc/kUeGseS9PjoE87MunfVtdl5X/xk5Iegclp9xGAt7pUdepXS/Wws+mlfbyXkpAcRaJododLZynh6V5h+BkBy/fCh2OzGANjFB8Kf/Qbqrba9RCuyYQ+T2hm78WQRWG1fJ5AG7et/mI6Dw/DSgilNJvF6NaH5U2QL3HNHMKkK3V/DFZKkd46CnxqG2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huKpjUao8sUU9Vdzts03Yu14+NDHtcOaYek251AsiuM=;
 b=Tvu5eu2JUj6lGQhc0U2ma4wNqMX+pFmcrK7JQjXe2ClrgwaKLPu8/54FuJb2/KUQpZ3HOdsycwNgPU5L8b2VJ3giDmOuDzW9E8YnYqtMVYYH7JyQO8EQlLhA3blreTVh32WiECQ4o5BlTjfZrP5VaCvenGtljFzpxMEcOu6Qmh0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com (2603:10a6:10:62a::23)
 by GVXPR02MB10833.eurprd02.prod.outlook.com (2603:10a6:150:14a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 10:22:57 +0000
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3]) by DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 10:22:57 +0000
Message-ID: <8d0158bc-c35f-4507-822a-2420a89ce6e2@axis.com>
Date: Fri, 23 Oct 2026 12:22:56 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] iio: light: opt4001: refactor driver to prepare to
 support more devices
To: Joshua Crofts <joshua.crofts1@gmail.com>,
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
 <20261023111032.0000019b@gmail.com> <20261023111643.00007823@gmail.com>
Content-Language: en-US
From: Jesper X Nilsson <jesperni@axis.com>
In-Reply-To: <20261023111643.00007823@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0041.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::16) To DU4PR02MB12006.eurprd02.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DU4PR02MB12006:EE_|GVXPR02MB10833:EE_
X-MS-Office365-Filtering-Correlation-Id: bbe3d656-6f0a-4c64-b449-08df30ef9b6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|4143699003|11063799006|10067099003|261022105027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bwtoaPqGdUSorAKEgwn2lALDJwLmVy9kBbeUgrAn0fzcSzLWwI1wYfNuySNHysLegtfzKn8CdRU/WzERxa3HMc/u+ZuE9j6ClZ9/hceq4AkGppiQXBkA0E5e+WWJAPVk5MoLpLfSR4AoTjjFCoXuuKNDRPezFWsRaveqkv4IyrjZc0eEkRaDozc7KuZ6zhgPr+pyDIfRoR09qrpBT37S1Fm2O0vaJf67RqEOfYF7qjxSUfjDbV2LpyuSVUJ6nJdg7mbGNe0buD+Cc92c4Odj61H1UElZaDh6DCVEipp+8ByPXkWRrwNDJfxLkXF6XQuY7mHp0pX/d81Bv9iWHpwBb8yGrzLFd8NXNq7rKeaWvnVbadNcFDgXeP/T2G/ZMq5R/fsmkuxdPcXu3NSm+hu4kqubjlnHgVek/9ODBfVDEvLwv+Ep60Uak8fF7AbfxDi4Wkb8FhM2SLNaO8/DoSuCcjG7MmZ6SEp93+ImNbnF87TEnLFhMCmznThYNCg5QIatFrdZOoTOzhkqwM/6M6EobYCUBh2BeB/GQAf/iOHlyS96cw3tI/PNj9Cl5YRNJ9id+2Lvd4oIwBMyXcT3WuyEZ8Fg4eem733jL0wUet3vyGy76uky4dX07dFaNgdfXT4zZFvvU5FuW22ihwvwm5+nDIN7Ey+KTwYJlZTiFHLDtYY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR02MB12006.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(261022105027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?czhYMENyaHhhdzRGaHVNLzJrU3l4dDhVYldxNEhZYTErSWFwOWR4KzZhRXps?=
 =?utf-8?B?dGJheGhhaXhwMEZxQ1NsUkd1WnV0dklpSlpVUUhvSk1SMlhKU1l0Q2dmTWxw?=
 =?utf-8?B?Tk05L1FsTFJNK2FSRFhnTDdmU0c0aDE5OFJLTWFqdWJ1SGF0UVRwemZYb0tP?=
 =?utf-8?B?S1Q1R0lKcUd6dHdkOGhXc2NWbzkxUDE3eXRTV1l3N2ZVeXRxdUhJTEU4MU5C?=
 =?utf-8?B?UnlUZXBnVTFUdDE3cFhMZlc5Qmw3OUVKRlU4U3RqeFZqY3VSc2l2ZVVoYkY1?=
 =?utf-8?B?ZFRsZC9mN2J5bGZ3N0ZIaytaV0tqZjVLUDdXT0pqVUxFRmVpREYyWlJJUXJz?=
 =?utf-8?B?TlBqbkxGNkMxdWsza1JuVFlPMmhOa3pDU1RJRmcyeHNCM0JELy83MkxmYjAw?=
 =?utf-8?B?YUx5azVHa2xwbEhTbTl2WDJzV2VBZHowTU1LRDU0NWJoc3Z3R25HMTZRa2pn?=
 =?utf-8?B?Z1RrbGs0OUJEU0hSUllxWkV0THIwVnpsdzdaV3lUakNVdWhYanVJTllva0xD?=
 =?utf-8?B?Z0ppamxTNW1DTjA5VHR4dVppU2c4bWYzZ1I1d3E2RElUdzc3WExyczdlNjVw?=
 =?utf-8?B?V21KRmpjVzFPOFVMOGcwQlBlNmRETWI0cE8xM296K3hjQUlCVjZBUzZRdkJW?=
 =?utf-8?B?dFAyaDFia1l0Sm40ckdYMlRJaVIyYThoRjJ3eGZYbmZ4d25JOWNDSVNaVk9V?=
 =?utf-8?B?NWhXRk1KcVJydjd2MXllWWxHS3M4Z0phTHpGam5QNmYzcVh0d09MMGxjREwz?=
 =?utf-8?B?MVZxVkpnTTdyQUZUUnRSbVNEWkNqM0FyMmk1MHAwZXM5b2NwUVY3dWhtRE5Y?=
 =?utf-8?B?Z1FNK1JyQSswS0owQVVZbVZJdEQ4OGN5ZStZNzFwMnVmNEErT1RwU2ZIL2FO?=
 =?utf-8?B?ZHBSVXJHTnJWcm5CbDdNZlhUYTA5RXdZZ3FrNzI4YS8vaDh1MnFLNXN2SVdn?=
 =?utf-8?B?eWxaWDBMYTcvYU8vUithbk8xQml6Z1hCa01JOHdaQjVPZjJPdHB2NmFIaDFL?=
 =?utf-8?B?L2R2RVAwbXJreUFidWMwN0U2QjFIa0l0KzhWL1RJWnEyZW9MMWdyM0YrUmpO?=
 =?utf-8?B?aXE5YWdJamR6VTNyck9IQ1k3N0xESkV6SEYwamJnWGU1YmpMdGczTnBHdC9y?=
 =?utf-8?B?NE1DbytkREdtVld1azdROERVMnNrdGlyK3Rxc2E3N2JuU0pKc3N2dEdaQmJn?=
 =?utf-8?B?QVpVZ2N5Y0N0eWJrMFJTM1N5QmtTRWdRK0pkK2cxR0xxQzArZGZjL2Z4ZVlP?=
 =?utf-8?B?Mmtxa0dVSUVYOEs1TndtdGFPSTc5YVhSNjBpdGdhZ0F3ZDN6T1I1SVgxMkFM?=
 =?utf-8?B?TlRPMXhnVHJUeTRBWEJna2tqbTJkdTk4WGtRZmJucnFUbTBpUlpKSlNURFk0?=
 =?utf-8?B?aWdXSStGS2hmUVBLT3hJMGlCcnA1UGRRM3BDT25KUlZ4YThsWGQyZUYzUDVu?=
 =?utf-8?B?TGZHM1RQaTEwTWd0VnpqRUYzVi95Qk55MTBPYkdOS3R5ZnFpU3p6c1RRakZ0?=
 =?utf-8?B?cHVCWWpDVnNmeDdYZnRQQWxoQStJbzFhZnh4a28raE9Nc2o1a3BUWjd4MnJ5?=
 =?utf-8?B?ZFJYTjZtZnNKSmtHdXJRYUJZTS81dlJ5TEN1V0ZoU1VBVnFMTldyamhDYUc1?=
 =?utf-8?B?YXRRbWh5YlpvNkFEV0FCSmF1WGtnaUFLY0Y2R2Fhdk9aSmlWQzR4SWRVMDA3?=
 =?utf-8?B?UkFEWURSLzhSSkY5NWgycVZyNTRRWDM3Q2FWaEVuRHVqdHBXUHliSHM4ZHRo?=
 =?utf-8?B?OGI2TEJuTEhIQWZqL0J6OVRGVFpqbDMrdHVrQnBsdnJacEw2SUdWYTd5b0J5?=
 =?utf-8?B?NnNobDJuWkRIS1U3QmNtdTlwVENUQ2N5bDlxMUVIMVRSa2VLdUNka0piNkl3?=
 =?utf-8?B?bndEdVVNUHdoUWFBZ3JxRHZMSzhrbi9lZFVpYUw0ZDhPNGpVZDFFWjNQUHVW?=
 =?utf-8?B?WE5HMCtjbTd6azk3cmVFVGVxK2R4cWpmUVRBaEhQM3BjREl6SlZNRnVPcnZ1?=
 =?utf-8?B?VzF4OWplaGI5Rjhod2MrNm1Lcy9IOWl4VHIzbE1xUmhpMmQ5SndBb3h5OTJ0?=
 =?utf-8?B?VlJaWFZISkdodmlTOGlqdnJPRmJNbW00Rjd0SjhTVWJiVGprdDVXNlBKcEt3?=
 =?utf-8?B?dVo4N0hGcktKSDE2WEs4VGdMcUVwU05tbUNUSGxNWHR5VlEzQlRKM3hldmt6?=
 =?utf-8?B?OHZwdXFpTEpZN2M5N3pQbFFnR2F1M0kzTFA5ZnJiZ2Rpbkk5TElpNFZwWGhX?=
 =?utf-8?B?ZGxHM3VBT0txN1JQYmFjZVk5V3VYZVIyNjcxbWxoeXZ3TEY5NDdjc3dhZ3VG?=
 =?utf-8?Q?4FhajVLl16g5Y/mvq+?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbe3d656-6f0a-4c64-b449-08df30ef9b6b
X-MS-Exchange-CrossTenant-AuthSource: DU4PR02MB12006.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:22:57.4038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8JAorOQNburwfNhnYLnQ+u0/DooMrT8iKn7YkjGMRXBisiZysx7GSrqI9dRSPApkWwj/jVSyXBjYHLyq/42ONg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10833

On 10/23/26 11:16, Joshua Crofts wrote:
> On Fri, 23 Oct 2026 11:10:32 +0200
> Joshua Crofts <joshua.crofts1@gmail.com> wrote:
> 
>> On Fri, 23 Oct 2026 09:48:14 +0200
>> Jesper X Nilsson <jesper.x.nilsson@axis.com> wrote:
>>
>>> Prepare opt4001 driver to be able to support OPT4041. Extend struct
>>> opt4001_chip_info with fields channels and device_id because OPT4041 has
>>> two channels and another device id.
>>>
>>> Datasheet: https://www.ti.com/lit/gpn/opt4041
>>> Assisted-by: LLM
>>
>> This tag has been deprecated.
>>
>>> Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>
>>
>> ...
>>
>>> @@ -388,19 +411,19 @@ static int opt4001_probe(struct i2c_client *client)
>>>   		return dev_err_probe(&client->dev, ret,
>>>   				     "failed to reinit regmap cache\n");
>>>   
>>> +	chip->chip_info = i2c_get_match_data(client);
>>
>> + null check and return -ENODATA on failure.
>>
> 
> Just noticed that Andy was faster :)
> 
Yes, you were both fast :)
Thanks for the review!

Best regards,
Jesper
