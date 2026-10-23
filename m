Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.22
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792749738;
	b=Jbn1K8OQrhgCNoE7rPFSpOuZWzW0BWrpL1LjxCK8fpWGPTjB6VZakiDJkDVgcFtZRPXa
	 OkjXv2m697I4feHrN5+YN1DW/9kppvtPPjciP7jB0bQl9LAMKRntKsOlaOs5283P/YhXq
	 1lZCBqGK7A8XG8kkDVWfdJK73372v2B79XgC7DnXEccZGchH/sDL1FM0CG3tlNWfDY/V3
	 od3OXCEz7rcBb7cmsy0nwbCfz9zl2jGhMVZ9Ga1Mlgjm1ve/KwZbwLA8MPmW1ifZKo0dX
	 rIy8tik06JuV9N51g7RP/buTlqjiy9fUrWZTSEU2v6ZtvCbYiDF4ThiHuTR0KDGnopg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792749738;
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
	bh=AgK6tkHJg1/sKEcbi4KhAxzB7SALXR74urDzLMCn0s8=;
	b=tODIDmgPYXkTXOEyDAo2xGTc7PlRTWVfJSGJpn4ZQyZMUyjueLrDVe392iF+ZpS09+li
	 +rA/i+m57E3vtSe/FcXMsLShtlnMWVmfADmyvw1NiZr7+eHQr0FdN0xhAvU5mtUPn4ZkZ
	 XpGZ36qph+d8sqDPipQsc2fUh3otgDnGJb8goK1wyafXWzgN42D4/71qrtSSV8s91OXo6
	 flrUlcnVig2WTQFhWKwNFWmnLht590PdQyqcjNfcwdJ6C4xJFd7uP+ekFg7tEIe9BeJUZ
	 CEgH1BYzVLz/xzfkrzG9YG5W9rI+RVcnr7Aoqxn9yUnFtO7NZNneTdiedQp5Gojed5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b="U/QJ4d7R";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.22
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011022.outbound.protection.outlook.com [40.107.130.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B901D606A326;
	Fri, 23 Oct 2026 10:02:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B901D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=U/QJ4d7R
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lTB2nHxUYHXWDH3BdeWdNcxyxHYeLrYnG5QfMERaaGRXloQLksTvQBikuZtDVxiIi0lb3JMjSEbFZBpQnGLXAIAHqjOgsBsoFOB5dfYHAZvbeib+gdXoWeZQyK9PVfuRksfXlLZz14iMLW5xYzBu7n1i9Z9CHj8u8LdniAiAfF9a2kGNtY4u5cPbAnvvRrlXdSAU7Sj5vFEyLHv91DtO4I5q/2nygSoJ9IAr6QPcsGWx6LeiRZUWHkgVdO5d1UXOPVpzOk1mJbr0izZHvBnUWxB4/fk9Mbys2C5KPFTfPZbgPCIKFor+6qaeQZlhIg3mFwRENohYVNu0Y4CVy2PDhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AgK6tkHJg1/sKEcbi4KhAxzB7SALXR74urDzLMCn0s8=;
 b=xTOwHVrRp3MN0QLeMu4CY/EslRTWyWx01aIqoW7xZzmoiaz5xGnzTZN1x1Zu/gnDjiqSN93ZfHIn8FguVTQ0GGo5XbIRpexS6CextuZRkJhuEqMgILxq3QFla7OV8xX7BaKw0/tHjsTIjC84b+OkmfQw19qMTnwGYD3uaXiVmaqliKcnvNRm6G4XrxQjJXP/4ZikgRHn2KfNL9ZXUHGtZ5BSsJglX09qoVcrHeX/gBzpNYs8ppObxle26u22bLui30QpBmiQ2qERquCUNwBEcxo0ijWFG5jBNDFGAJzgb6500bdv2gxjQbnCOLjBAhcunnIwqldpcX6H6ewQ053cQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgK6tkHJg1/sKEcbi4KhAxzB7SALXR74urDzLMCn0s8=;
 b=U/QJ4d7RdrjGzh6BUSvdbrJATdXOIZRvYqWvb1Luw81+uWewSz7keyf6ii0j7GN5XGc3sA9R+Z4TIIrgP7dyyJW1qjWiP/ms8ta26EVzXVuTMUzD3y/e0zuVPIkMJIXBFg9CUpYGMoQaT+QLlFQ7EvUlpcAVeI5dWpr3TB07rbU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com (2603:10a6:10:62a::23)
 by AMDPR02MB11200.eurprd02.prod.outlook.com (2603:10a6:20b:6cb::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.19; Fri, 23 Oct
 2026 10:02:14 +0000
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3]) by DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 10:02:14 +0000
Message-ID: <c5054015-84f1-4b83-b4b9-e50f6b8a89d3@axis.com>
Date: Fri, 23 Oct 2026 12:02:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] iio: light: opt4001: Re-use generic struct
 s32_fract
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
 Nikhil Gautam <nikhilgtr@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>,
 Jesper X Nilsson <jesper.x.nilsson@axis.com>
References: <20261023090802.1957593-1-andriy.shevchenko@linux.intel.com>
 <atsnIMEnefu0GD96@ashevche-desk.local>
Content-Language: en-US
From: Jesper X Nilsson <jesperni@axis.com>
In-Reply-To: <atsnIMEnefu0GD96@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0063.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:8::27) To DU4PR02MB12006.eurprd02.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DU4PR02MB12006:EE_|AMDPR02MB11200:EE_
X-MS-Office365-Filtering-Correlation-Id: 6df24756-6bda-4384-0a10-08df30ecb6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|23010399003|4143699003|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	QJglG1TlILG6HP21tYQncQao3SDy4EcnMg/E5L+BxH2r//qaNjyOU8TRJEAKZWeCtnVyx5aqu4EfJ75ZKTDKOv9U9C+gJ4by8obgU+hbH77J804rCgwMQE8FrWJPvaz0xRt9EvOXDX675OQrCzNsL48IysGhDLWuiYWoTKeQhUkCn5/gqUEjpNfYmlcHvGBjRxi7bSlEoHAc3r11EbNc6CZLW3E+1m5MTFOI4rk1YgYdOAI/qQ+7kgOZl8Ibrue2bpsehX8AEvLZgXNVoiLzuM1KjCj/bqzPEBOEHaZ4QS+7rDRU/sbHIg3fger5QCPjF1Te0pYGqoDmiz3JjcRelRvj36L8ANuUeY5jgzwyWiqXkSpOy3T/1S1RGPOy9+zhRsjIqPuJzIZqp2SgPVkv69bXRpviljoD1rBtdWxyV/WyIEglmdxeY9tGPK54zlao9ftoXVsPqiaq+MQf10OCCTgOmQY9+MDrB4WKBJrXX2Du5lK9KqcicU6+DDfzPXnGyHt3OItNvjO94nFPdw0lHhwDffFD7ueXIdTBOk+kPtM1AgD3GNGK3/e/lnFajcjXxtfTLyOqM7jyf16c/ppegqUDGWBghfD4hElONjELWFwq0LQ1DYNqDPwlBYVIOayiW2lO91lcTjCRT1hG651Cu9YMZh3AaWr5C2v+b3Y44Aw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR02MB12006.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(4143699003)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OXhBMk0xaUsvZmJ3ODc4Q29UbGxlbUV4MmZpWGM2aHhzUkp3Q3VQRG1vZ0JV?=
 =?utf-8?B?L2VESkdnL0pQZHZENXllQzRKK01KcXZrWmlibGRtSWZQdUNhTFZwZndHSDcz?=
 =?utf-8?B?TExiTDlBWDJsbUtjYitBYlVsUUo4a2xHbkltazl1QndhWDA2b0lpbC9jdWtT?=
 =?utf-8?B?Sk1PRnFIRGZpeEdTci9HOXN6aVc2Qm9mNjhxUEFTQ1FEWEhpT3RoZDJhcGNi?=
 =?utf-8?B?N0VYTlVvTHA4dmVQZ3NzQnRBTTFRN1BxOFhzNDQ4bTExTmp4dFIxb0RrRk9P?=
 =?utf-8?B?YzVUUFpValpveDB5aFVsQnJ4dXNOZ3M5Y2g4MW1IdnpGVW44Ylpvc1BMNW51?=
 =?utf-8?B?NjRhS1FPYVhyaEM5S1FheU1ySDY3K1czZ3hBTEx5SG8wSmJzQ2NyaTl6NXJx?=
 =?utf-8?B?WVh6UkNWTXhsUWNleFRwTjROdGs5NlVyTnZoYi9Sdm4xa0ZFQkZzY3RyV2hx?=
 =?utf-8?B?aGhpWW9GNWlUOHZtczlNZTdNcEU5Y1NkdENiQldEdUhLTUhMNVNnQmFTWHpB?=
 =?utf-8?B?aXRFTFp5T0l0YWxHcTRZUnp1aHRSNVNOUnlnbUNCaFkzYitScVo4ZWxvczZi?=
 =?utf-8?B?em5HNGt6Tnp2U29vU25tYm9xVldDUTN5djMrTWdNUkdlNUlBNmtzYzJGMWMz?=
 =?utf-8?B?RVN4N1V6NkRHYkRuQUFScm5keDFLNDY4dXpvK2pHb3U0ZnFtQllRMVhMVktL?=
 =?utf-8?B?MFYyOWFSanp0dkdvbW0zTSs4Vnk5NkJWb1dJTE9tbnBPTkFLNnZWejc5WW94?=
 =?utf-8?B?bURQcFJYdjhmcXVONXV0MnpGNWtSakRDRzRaVmNvdTBCRDkydEUrenJrUmEy?=
 =?utf-8?B?eDQ4Q084ZzBtYWZ2cHpkOUJWak5MMW5UeHpPK1d4aUlLdlFJYUZUZThzZG5N?=
 =?utf-8?B?K1FwUS9jekw5L2w2bWlRSnlYbmVPSmlnaEtrY053ZnJiVTRpVE5IbEJwQTdu?=
 =?utf-8?B?emRJNXBNVGJYZEswUUR6RVdVRFVDaG52eHp1T2F5K0pvRWNxcVdIakxqU2lp?=
 =?utf-8?B?RG1RbGVXNGdRekx5YTJvdzk2amdDRVprb0p4ODgrUmI0bHB4K0xLN25BUCtO?=
 =?utf-8?B?bkdTS2Nqb1M1RVhESWF5QWpEbEJxVG4xNkVkdjlZTkQwRnlndDRuLzNTdVJt?=
 =?utf-8?B?VXhKM0dBd3NPdFcrcDVRa2E5VnJQNTBNU2hKdTBsRk5jTEtZQmZJSEI2eDQ1?=
 =?utf-8?B?VTFjZElkU3VWVWNxQlpVMFRZRzYxZlhUa2EvallGcVYwYmJ2Y2xtaUV1d0Rz?=
 =?utf-8?B?YWorV1FzKzdTdjZZZ093TldweUxzS1VlUlFBU0I2UDM3cXlnZm1La2lRbk1U?=
 =?utf-8?B?Ti90SU9yMk1WZFZpMjNzN3FwSFVEYThWdnoxU0RlVUJUT1Fvc1JmRlpHbEJT?=
 =?utf-8?B?bnBuSUNYbVBWSjhOcElhRkp6b3ovK2RwQU83Q3R0ZTZsQU5yVGtSaFI2dGto?=
 =?utf-8?B?a3FqSlNTT3M5T0dVWXhrbDNJcnZaSzlTYjErTU1USkVLbVhGdjlmZWE2NlRo?=
 =?utf-8?B?ZDRzTlR0eko0d0NNZXF3WnduOGdxeFc2LzVCUnR6SjBrclkxSXNjTDFPVFFi?=
 =?utf-8?B?SXI1S0ZZSXd1alRKT29ZZUc0NkFjMnp3RjNlU1BMYStWc3VKcXdoTytwdG9n?=
 =?utf-8?B?OTYrTjVrVW1vT3ZiSU9YbklZS3FMUEhzdldKd1VIbVRXV0wxSW05YkZDdlhs?=
 =?utf-8?B?Sk01cFMwYVAxS0ttMlZmUTBxNi8xcEJtaXovSW9ieDdyeVBZYUVna0ZWSWZB?=
 =?utf-8?B?cXIyNGk4ek5oMlhEenFSbWlTMitWWHBDcEtWNzZCNlRPM2I5dWtGQWJhMGln?=
 =?utf-8?B?cTVYdFpRNUIrZWhNa0Jick1yVXprQ3BxRmg3N25DNmlzQVRkMDFPYWxldVg4?=
 =?utf-8?B?SjJNSlB5U2NJcm1EYUdaS2tWeHFrSDNZaDEyek9QM3BId0FPdVN3VmFZYmVp?=
 =?utf-8?B?VFN2cXFIOU5kQmwrUmcvTndvMkc3SEorQ1lsRm9iSFVhemMxQ1RMRThwSmxZ?=
 =?utf-8?B?d0gzT2lROEVWb1BQRkRoYXg4L1dHOWtjY25lbDJJemJValBIbEtJc3YwRGtB?=
 =?utf-8?B?ZjJDUmhQOUhvL3haNnNFSWpHK1NEcThDb0ppYlErcUxVdzVIYXFLU05Vcitu?=
 =?utf-8?B?Tjd4MWdZUmVwT25IU2JBdHZCbVNTN25MTmpmZ3JhRVJKREY1UWh1MG5zRWxR?=
 =?utf-8?B?TjBRdWg4eENLNWVaVit6aWxMejhURGE3V2pqVU1QRkJqeWtWcWY1M3hOYkE4?=
 =?utf-8?B?Z0xLazlnT054WFkyeGlTcjRsM0dYSHA4RmtKWEFVWGtXZ2hjZmJaSjlCSGpK?=
 =?utf-8?Q?Jwcqn3RYHSibC88Jzh?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6df24756-6bda-4384-0a10-08df30ecb6a5
X-MS-Exchange-CrossTenant-AuthSource: DU4PR02MB12006.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:02:14.5660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8KPhbQrimSQOBYNMIVpqqGMguBFjDieTO3vdy/MdsJogDf9VIY4tvCWsvR/Wzqe1tWARAHvrEJGO+M3K/FkuZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMDPR02MB11200

On 10/23/26 11:21, Andy Shevchenko wrote:
> On Fri, Oct 23, 2026 at 11:08:02AM +0200, Andy Shevchenko wrote:
>> Instead of custom data type re-use generic struct s32_fract.
>> No functional changes intended.
> 
> ...
> 
>>   static const struct opt4001_chip_info opt4001_sot_5x3_info = {
>> -     .mul = 4375,
>> -     .div = 10000000,
>> +     ,ratio = { .numerator = 4375, .denominator = 10000000 },
> 
> Oh, I should have compiled it, but I missed. Should start with a period, of
> course.
> 
>>        .name = "opt4001-sot-5x3"
>>   };
> 
>>   static const struct opt4001_chip_info opt4001_picostar_info = {
>> -     .mul = 3125,
>> -     .div = 10000000,
>> +     ,ratio = { .numerator = 3125, .denominator = 10000000 },
>>        .name = "opt4001-picostar"
>>   };
> 
> Ditto.
> 
> ...
> 
> Jesper, please take this patch into your series, but also fix those typos.
> Or if you are busy, I can do it after my lunch.
> 
I will add it to my series and fix the typos.
Best regards,
Jesper

> --
> With Best Regards,
> Andy Shevchenko

