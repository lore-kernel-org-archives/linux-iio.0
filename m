Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792750853;
	b=0sutRUdr7HO/VskOpO02sqY06u+0+PZRJyxtjwaRBZr9Er9iNgin0VDHwbxNZbwLdpKO
	 yRzTqjEYlY+s4PNQzfRbN6ENpjvZmLAGW4yb6w7gR4joc8DaeyRUNfYqN+CXFj4cdCfsg
	 hEAmgLs/tTm25WgQnukyWZStsSndoCk9jRQkG10a925o7CkYlffDcNcAjbkDBfmkCV62V
	 A91qkVWotH0QWRRDmQk7DpaKCRwaYAbOVwHurJGqIJ9BMttUEzblye/17y0S/07ADICdu
	 IIUIXgy7GmXm8VZLHK8dxEimlzBQkoapCd1AERmT2hot9xjz39mNuBG5AmlrhVB/FBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792750853;
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
	bh=TsGVk65Ce0SGTqpGljv8TUP55sejw8PAlv+pS9NqBUo=;
	b=DQ3laCTZUiuSC52UWCIHK0hdRyAzL/N+AA+6GeWfPOq3cT7cpgaGbe2syZnJSAPBcTHY
	 XXMN1TMliUL3T579Kv+YU+A4EvTlZJ+9lpilZVK1fru7YwUVMyehb2txp9Gxyik3jK94d
	 HmMIyWyYa+XWirVi+9PnCiNNys5eexeqlpqmHIKt62DgfIUU/1ewKIhls+jFC170wQAMs
	 Op7hrWPMLtpKP4cQ/eoEo4fWFzEDoaNl9n532jFpKbrWAQT6+aGHsgZIRWasy1rHMStWF
	 QjnuXi+Baq4CEISiMcx58SasFBjK5AOGun/Mj1yTxGn8pObAoiNX1S6feRfoFYIe2ZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=ZXOw9GAD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.53
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB5FE606A321;
	Fri, 23 Oct 2026 10:20:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB5FE606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=ZXOw9GAD
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tmSFgSFiaS1TZ2qSSattBAf7q/MUbuyJgvBo07iSdI40X4KNG1a3nBjit0tMKKy70C7vZBSGoRN1jf+ykRyvb3IWjQWJDecjDQhHyNLS0I0Wgh1+jyE/FE7Af5jonPyA+xi9q9tQAZ+yLYC0x2ZMoPh8p1djr8KgDosbFjtiTRVOz3T3RtkkwmprMac2MfodrQI5hoMoRflRHvaUslGQoh2hT9pzJnc81kffQevIeWZoV3kB0c2GPopWBUf194X650WSBaobm1lg5yJ9XS7GtwYzR48X4m3r+i/uyHznGitnM5eATQ7nd976g7+gSok6D8MEusDE58cYt3cZl9dCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TsGVk65Ce0SGTqpGljv8TUP55sejw8PAlv+pS9NqBUo=;
 b=CXxo76kSZbuDiCyfvnRaCsxN0phlsoKvM6Lyne3HaABL5cbeA8bbgEu2YX1hQ1EQiaiTKYSLhOQb7Y4XG67yW5BhGaHUTnqMUj4j6SxbScz81yJ7T0HZObjaM9pvhurqUrd4qs8h2I9VlTPnCTBOxPVAzx4DNXsA9Hb3R2Xgf47uHTYdacJFhnB7KMyqoH09zeYh4dytWbADN4warh+LIa6rAgYQU3K+pLZ1sWma/mk13DOvc3LZN94HXqS2qWdXkjJwf/84ZC2zWCy/Lhjeh2XTeZk78zah2STrpjhKFmeQghDjeVbPCGO35rrXzHKjZ3fuCiQxeFdJTUYft02h6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TsGVk65Ce0SGTqpGljv8TUP55sejw8PAlv+pS9NqBUo=;
 b=ZXOw9GADaCN3Y6vq62c8KqBDgGUt/tsqXqfPWlEL5abgOKCesjJCLtL/pDl3PLGg8+q9odgvg/NZRF24hx7dqoCYvucd6Otna9SyhzDpmY/w9lhjycbRP5sum64AZPNY7Eu3PINxAfwcpOk6RSRK5FwILUC+UbupBp9lPNDtYMo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com (2603:10a6:10:62a::23)
 by GVXPR02MB10833.eurprd02.prod.outlook.com (2603:10a6:150:14a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Fri, 23 Oct
 2026 10:20:47 +0000
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3]) by DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3%5]) with mapi id 15.21.0546.017; Fri, 23 Oct 2026
 10:20:46 +0000
Message-ID: <d3212ead-623d-4457-98b2-25ca319c6d65@axis.com>
Date: Fri, 23 Oct 2026 12:20:44 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] This series adds support for Texas Instruments
 OPT4041 Ambient light sensor
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
 <atsmKZjpr-NQLKBD@ashevche-desk.local>
Content-Language: en-US
From: Jesper X Nilsson <jesperni@axis.com>
In-Reply-To: <atsmKZjpr-NQLKBD@ashevche-desk.local>
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
X-MS-TrafficTypeDiagnostic: DU4PR02MB12006:EE_|GVXPR02MB10833:EE_
X-MS-Office365-Filtering-Correlation-Id: 379c3af8-4f7c-4246-46f7-08df30ef4d36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|18002099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	kTAY9/U4VMdNhv1lxU2S/dGo2RFXhdObinPllJ7OijAyud8yuDGZX4ujHuWLHOXoMDoXRLYYnuY6x0SCzUqt67LtfTZgEU6b74FhMycP9fDB70620e9JBL9MpydJBAkAvcYmpQitzTPxyHkXUnz72LijDAKlhlnv69zpHWQt4hY+AonHKeoxOKvQ44H9FQX3WqfP0TU/2rLOv4t9HWIYj7OcgaYkK6cs6NLqOvmtVPcvbraNfn13lKGBfpM+sx/FbuEX8w1ieYWFp+MD3tMjBk0MJYLAt4iJixWD5NdBtCUPNwwRi4Mf9CbR0Dvx+vrgrNX6i5+BUBhs4CJqgo/tq/FZA/cljqsSsMBf0ZGsW1DKyag2MDa1mj92DLV+ljneZ8UO2Y7Pg47kdrP20osAE90yUsBUTRBuzvVSYmP77j4ShkcObTs/qvhUX/kkyHsAIKnZznBGLcXRX5+uZTQzCmQM5yh9mBxZNIZgSmvXhxejwpUOix9S4Kb1ciTJg4Mn+vTfsr8E3MX7o+laUK9tvtm0C7hTTmgZ1WWvjAfycKuap0RPdGpQYvwDb5Ni7Vk3gqxvZ+I+CPbYVf3AY2p4pZt8RSCztKm4zQyNOW+LL2NBR/vUi5fGBSBUcCYjt6LS6vSiOOFTXQABQsLim80m451h+kJ5ZzVbq7dUSb0yUX0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR02MB12006.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(18002099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eDBEVG1vZGQ2TkRRUDlVTHBvVUsrd1VQWFRYVy8yWFJNS2tjZzhtUFhseTB1?=
 =?utf-8?B?S2pZaUhITFYvOEdtaEdrMEllMDQ4RnA0cm1vbzVsVi9WSldaa0RweDREUXZQ?=
 =?utf-8?B?YkRpLzNHbzhJNllvWDcrd2tEYW83ak1GNVNOZ0lzNmhnRkpJQ1ZXZ0V2VjM1?=
 =?utf-8?B?REtmL2N4UUZnL2pXVlE2UnFwWnY3OGk2SkZyMUprYTU0OUZXV0JqL28vdFM5?=
 =?utf-8?B?ZlY4Q3RaY1dkUjNXTW1RbERXb1FQSnhDek9DNXJ2bWpORnZBcm9EZ3owWWNJ?=
 =?utf-8?B?TXdXVDBuQ3o4S202SFRHN05MbFRZc0Nna1hncVl3ZTlVNXdOK3lpV2FNR3VZ?=
 =?utf-8?B?ZUZtbnY3SDBuV01DRUxnaS9jNk9EVSt5cjBkNWpWUmdiRFlRZGpmMVZvdVM2?=
 =?utf-8?B?VVRLY294VUh2Sjc3ZHRQT1hNMG80MllDVERQNnk1UVZ1THcyQjBtd2Z6TmU5?=
 =?utf-8?B?RDE2dTRYVjgwUlZBV25sejdUbkNPUkZzNWdhdDBmMVlQVlRYc2I5emJJWXRh?=
 =?utf-8?B?RzNVVDJzdVpSc0tqdlJMVGp0ME0yb2ZhUWtNSnFjeStFekhIekJTMGttQU1M?=
 =?utf-8?B?ZDJweG42Z2xYbFdsanlaTTdjWkc4Y2hZcmlNOFp2MHhxL1Z2Vm0rb0tnNGJu?=
 =?utf-8?B?NFNsNVYxR29rNmxoL0sySHhDWWsxbTNNRXJieDdzSTUvSDAyWXd5UzZLc2tm?=
 =?utf-8?B?Vml1Y0FHek1JY1BvVm1JMzA5UTF6cWRjZ2RVTHBLR0lCWk53b0VLU1g3Skp0?=
 =?utf-8?B?Nnk5c09YUkRjR1BGZ3BqYm5CK1YvaURPRDJOb1dWTERpQ0Vla0VzYkhLRlV6?=
 =?utf-8?B?QXFiMjlLY2U2SStSUUYxZ0hDTFZiWWZ6czBXMVA3eG8wc3pHS0RvRU5SaHp5?=
 =?utf-8?B?RVkzVW13UkNWQTAxNWF6UU4zT1JlYjE5d0pFbVprWjI0MWp5NHpGSWRmamE4?=
 =?utf-8?B?bG1ZSVRyeTZLczBXblBVMWdXcnJBNG5KdnNhamhhZkJwbjM2dGpYdTV4M01v?=
 =?utf-8?B?eHdXc0hxd3p6YmFYOGVnbWFiL2xydHU0UzJRamZrSEZVZDY3RUdjUEVnd08x?=
 =?utf-8?B?cGdBdGIvSmRmOEZ3cFNWWkVpYUxzTkdIeGJjdVVaaTYzWTRXMXduakgvUVVS?=
 =?utf-8?B?Vyt2LzNPelNrTXVmY0FQcEtsMzRtOEpEZ1RPTkZVTS9BV1dEWUVnN3Awekxy?=
 =?utf-8?B?TTNaWWVZaUp5V055NGFha2lQTU1iNC9UdG1RdHdBTmtPZ1oyeEZobktqYmQv?=
 =?utf-8?B?S09Zc21QYWM0emxuL1RjYVJHejhrbzZWV3JWUEprMWtkL21IZjdlamZUV0Vo?=
 =?utf-8?B?T0ZiMVNHSyswamtBckE1Kzl4dm9YRlN5TElCSXZTNlk2U1AyaWFHMTBoK1Nu?=
 =?utf-8?B?Rktuc1NLTlQvNTNrUUcrWnE4L0Q3T3VZMHRnRkg5b3FqWi9tMWtwK1RZOC9Z?=
 =?utf-8?B?Y1c4czZzRHR0ZlhJNlJXOEgvS0gzSGxNeHhSMjh2Q0w3S0pza3F2RWxxbFBN?=
 =?utf-8?B?VCtwSWlrV0dlMGtTTTFxM3Y2SllpQXdMQjUzWlBRNjNIZjJBdCt2RXMzNVA0?=
 =?utf-8?B?RDJUeFJJRDJMdzVBWDdGaHVoWllPNE0xamtUNUR3eXgzcTBpY0xXRTQxQmJz?=
 =?utf-8?B?QVJ2MXp0c3N6OGJUZXd0T1htL0dOTC9CejllcFJvODJkZFU0TXRuaGQ1czZL?=
 =?utf-8?B?NW1ndzd1S015bVhRWExEenRZMDhVVE5SRFBqV3h0Q3QvUy81RE1PNDdIbWhp?=
 =?utf-8?B?c2NRYk40YTFPU3Q5TUk2U2sra01DTk1DTy9kdW9BdDlJdlJzQ3FMU256WTJH?=
 =?utf-8?B?dXpKWWRreGhBT1lDTHV3c1BtUHJnQ3ZCdVR0OHNlZ2lPcWExUXB5RFBmNVZp?=
 =?utf-8?B?MXVSQjNEMkt1ejk2bTNCT1g4Z1c4OUF5NjZOLzJMcnRGUmF2VEFzSlFJZ0s5?=
 =?utf-8?B?cm1nWE5NRkdsR2dzMXZsRWlWcjVsR0ZWTGN2WlpnMnMzcllqT0tDZTk4SmVG?=
 =?utf-8?B?ajdONUZINzhNS1lpRVN4Mllrb3BDSXpndzNGNCtOQnlJNHdMdEowMEdYdkla?=
 =?utf-8?B?VVVITTZsWFJsbHRVc05ab1FQSE5WWnhYYmlQMlJIbVV6aGo4blF4VWlycFNu?=
 =?utf-8?B?RktCMkNBazhqblFMZnk5eFJ3Nnh6d2tudmZqdlhuUW50c0tkZWV5YU1UeVJO?=
 =?utf-8?B?VEdRMUZuUFlUekM0a2RCU2pWUEp3eEFiUkNRbmFjZjBoTGd4RHQybW5YSjF2?=
 =?utf-8?B?Q3hza3hMMGova2NSeGFRSExJNDFUU2IzQUQ5YnRzZG9HdjJXRnE4Z1Q0RkRx?=
 =?utf-8?Q?HHvGCFJDw67VgsV9Y+?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 379c3af8-4f7c-4246-46f7-08df30ef4d36
X-MS-Exchange-CrossTenant-AuthSource: DU4PR02MB12006.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2026 10:20:46.1957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MOYs+tkPQDInCpskdubR7y/pxueBCXaQu2gwOcKcLuITQbTN0RSFIv0I2tCQvCXZzLwmInMAtcR/sqVI4MXQlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR02MB10833

On 10/23/26 11:17, Andy Shevchenko wrote:
> On Fri, Oct 23, 2026 at 09:48:12AM +0200, Jesper X Nilsson wrote:
>> Extend the opt4001 driver to support OPT4041, since it is so similar to
>> OPT4001. The OPT4041 adds a second channel, a wide band channel ranging
>> from 380nm to 1000nm. The register map is almost the same for both
>> devices. OPT4001 has an internal fifo of size four, OPT4041 has two
>> fifos of size two, one for each channel.
>>
>> Since OPT4041 has two channels it has one bit in register 0Bh to select
>> which channel is compared to the threshold register. The driver does not
>> support setting the threshold registers, so no new support has been
>> added for this.
>>
>> The OPT4041 is pin compatible and has the same package as
>> opt4001-sot-5x3. Although the device id is different, I added a new
>> compatible string since the driver already had different compatible
>> strings to differentiate between the two OPT4001.
> 
> Overall very good small series, I have a few comments, but they like 15 minutes
> to address, id est mostly style related. I'll give my tag if you send a v2 with
> the changes as suggested.
> 
>> Datasheet: https://www.ti.com/lit/gpn/opt4041
> 
>>
> 
> No blank lines in the tag block :-)
> 
I will update it in v2.

>> Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>
> 

Best regards,
Jesper
