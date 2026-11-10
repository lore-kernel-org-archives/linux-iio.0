Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794326927;
	b=IyYGDHKQzoOYHG5uvSGlPFb4LXonn4Vs837Z8tTHsxaE+OObO+GksjSHtX52xj05NJsp
	 KRZWGcrcoHk8BXW7dpPOQmrFQRMsLVduehuvsRL8ARNWjOdg6gUhvuq9qSS3eCeMpgj38
	 qDcQkHXqXXjiuuvGiwE3/SLkp1TldK1qNO06+DKbw5Nh7KvRkdQjTje4CZQKeFqxnB1Kf
	 Y3Kj6221R/aQazyRleicHAZvR3TfjxkSBIyMimmxPVIalFJM+d7VEK4bG6sk/wACEBK9i
	 tSwXapOsaK/ZU9ZL3uJeoFEiPOPlrNBj7yz8EqGs+x7/tc/wIdb2UjIqyyhJUliX75g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326927;
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
	bh=WPm+Vr6nQIbCRb4yT5UWIVEBEuiJoTmih+ganpauvx4=;
	b=xheNaDQmChsSc7OjZHiCbd6shWf/TlxdaLIU1gA7RQXw8Ek2kD+IYyJ6lYdBa34c16PO
	 SZnggf6mabZyuLWPws3XQGKTjDYm7lUwknI0nzAwRmKsCF5w2X5qXpomghivTRvPknfbV
	 ZgvPjBn+ID5/DQbc7FsbH9/FxoJ7rZRGqnHpqL1/I0vC9Y1xzPnceYBI9HIf8cQYtT4o4
	 aA3NZFydr2h+k7TWAcSMuHAyGMLEVYMIkMm1I9TmhNWHs9fx5/JzkFBDLgTkTqlVVeGuD
	 Euy7r8gDQ/m9BlgeQxRbaTKWlRbtWIQUD3cvy1ywARSUb3HwESbJJaOPlZVjd/JeBqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=phRhtZQZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.70.45
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011045.outbound.protection.outlook.com [52.101.70.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02761606A31C;
	Tue, 10 Nov 2026 16:08:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02761606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=phRhtZQZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Njw2ZpPpQllFzgQC3GjyglutzHsXWiMM+6U+mtGK+0Xs7WUweEfpmxs2hoAHerhqPABzyb4aAQ5mtaPpyFo3ZZjUGazJF2+QAmOiejGwWUbaVilV6iWEWfnTRLcV5BHjE6cUtlTj79a76g5ewL2dIvydSgjEjw8hu6lssAt3lpGOWhQ5SXzC28Hkly8ygwiiHM+dDGdJOL8R2YoymEb9QFqOeuN6xYeMANghPGM3vL5zbhDM7fN90RpT3StAwOv0SSQ7gGzG0BrJGlFpC5dH673mHZPuSFjgNS4nAOk4h9CAjD6oaCQjWc1Th3dHEELbJNMWlK3injtqNNUV5qPEig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPm+Vr6nQIbCRb4yT5UWIVEBEuiJoTmih+ganpauvx4=;
 b=HmGE049/sc0KgrP9G2QnlF35SN1U+VRYn3LiH9yCDD/mhOmklLpTqLPW3sp6+Id2cBkabf2Z5BmvazFeX/X9IEnIdz/YKyNJUd9ZW0ETf1f/xK1MIyjgmfrELksBlc8iEXN1Ijzs16FW6u4M0rUQ97YQJfqwaBsWRSLwOtoOUdY+nKP5BQxnwyCwucNBxOmDgFIHRpbF0cVaydcgazBiRf6ElACW8uoDtqwdJONLLb2b6ylJqy76vvIBUBmJzFb93BrdTXVKQmN9gjUfhyg1HOXLebzllP5FNI5QiXQntwnVrpi1V7l/TzVakyNrV+KZX889MWrs6KWXCtNNiNgT4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPm+Vr6nQIbCRb4yT5UWIVEBEuiJoTmih+ganpauvx4=;
 b=phRhtZQZNIVCCY9GSuRPLe9KWelC6OMXHO7YxLTTsgWQEnNRIReSQKX7dIs/ozWZs/pMatLWd0cugpBAqB0I/B2mo5ug0KYL00y59/+YHB8Znu/IBkF02XikC4CdgodfIqmcLb6tOIV+uMvVW5EfEdSslyd0Xl0QgQnFSqNEPds=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com (2603:10a6:10:62a::23)
 by GV1PR02MB11143.eurprd02.prod.outlook.com (2603:10a6:150:1ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 16:08:41 +0000
Received: from DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3]) by DU4PR02MB12006.eurprd02.prod.outlook.com
 ([fe80::7584:3ff:da11:e6b3%5]) with mapi id 15.21.0592.012; Tue, 10 Nov 2026
 16:08:40 +0000
Message-ID: <389d5226-b147-4b8f-b3c3-b6bffc5ca78e@axis.com>
Date: Tue, 10 Nov 2026 17:08:38 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] This series adds support for Texas Instruments
 OPT4041 Ambient light sensor
To: Jonathan Cameron <jic23@kernel.org>,
 Jesper X Nilsson <jesper.x.nilsson@axis.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@axis.com,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20261023-opt4041-v2-0-ee320812804c@axis.com>
 <20261023215858.623ef46b@jic23-hlaptop>
Content-Language: en-US
From: Jesper X Nilsson <jesperni@axis.com>
In-Reply-To: <20261023215858.623ef46b@jic23-hlaptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0116.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:9::33) To DU4PR02MB12006.eurprd02.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: DU4PR02MB12006:EE_|GV1PR02MB11143:EE_
X-MS-Office365-Filtering-Correlation-Id: f5184f4e-4ff3-499e-f0d2-08df3f44e253
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	esASLNdZYEpIJIgW14EyK1fERkUwou79McGE0GaWG5wvyk+EGubB7WdOcFVIVa0Hpdazb0Z4YwwjkO/pdNIXE3aJdHB4w91UdC8ReidfX7NvlycmEKbyGd7C/bXlSdR1dVUqescnwmZ6HZXgv/0YCi/vlydE8I7ouIexgk0ZNdGkOY6z3r9JF3w9C31I12e8wtKm9MkoXEkaYeRn91L97F3oIkes6Ua7quA/8B6BWAlAJzU/cpIY5YeDbVX21WB+ljSUqxALLST0aXhw2AnimoINrZYsFdKtplkbGSd2C3mX3orAhNGsi6HhQj3yHIqU0+uNjq/5eQIz+IDOmAZ1Qn8/qKE18OillghXz+gNObRrvL/6QMkZqfRmeto6wyt6ARViSfwUtrTZ2FzvR21FObBV8ddVSRTWNonG9RXA3oBh25fmhq6AQWWZI0kRWgTZhOz/Z9LMvC+mnv74OBrSgpwQzlh3d7rfrMLiO7aJ/6EfFzStIGUcp/lx3esScscu0wHmE4wP2ol2L81DWilwzHvGxtXm1MNUsv7WGPe8v7JU3lfJMf38ksPnNUvHEcdFCR5wwE+WmLr5k5O5Bord7zbxYaT/8dk7IXA7QfXNOOCSZEL4U++X1njMy7F3eDJiRwO93bNwMqCxbFqsaVfrBtngZsLjafm701cjycqvXLQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU4PR02MB12006.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(56012099006)(10067099003)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Wk9iRFpIdXpXWDhaV1VRSnZWUWEwdmpURUQ1bERtdUFWYlltZWEyNmhQckd0?=
 =?utf-8?B?c0lZZGV0MEJVNjdTUGx6UExQZzZyQUtVaE5RVEV2QzIvOGVHYXNBOUxEUGlm?=
 =?utf-8?B?UDdjS3lWQ0VDanBwWVIvTE9zdzZUTldIRW85TG1tZVdVSDFwZEIzRFFvZXVp?=
 =?utf-8?B?d3pBOEJEbWNONjM5SldNaGdySWJuZkl0NFFMM0dzT1IxN3ZpdGlJUThtQXZs?=
 =?utf-8?B?bVowK0JkNnpYbnArSGdOZ0V0cHRveERsb2ZVNTRjdFk1N041WHVzeGlBOTRT?=
 =?utf-8?B?dk9sK3l0N2ViUS8wMnN6RlRlRWFPSkZnTzA4SEVReDY1Q0VacEdGR25mOTUx?=
 =?utf-8?B?aVA4bjdRUmcxd3dCOGl0WkNUR0s5OEltZ3BYWW5PZlBwU3BTU2hHbDJoVHJC?=
 =?utf-8?B?d2FIaUd1V29BYVJjOFRUeHpCZUxCeDJEdjJRZDV5eFlJWVF4b0szbXNVTXIx?=
 =?utf-8?B?emFHWEd5ZDNpOUdDVnZsNkpkU3l4a00xQzN2UldOU1g2U05MQnk2UE9wVUU2?=
 =?utf-8?B?L3ppUVc0RGRoc2U4V0hQSWlVT3cySG5TR0srRnNNVEtoNXBoV0xvd1EzWXlS?=
 =?utf-8?B?UkNleTd1V1FBQ1R0T0J2aTJFTDV1Vk9zWGswSHZSYXhSL3JHVnc3UXp3MUlh?=
 =?utf-8?B?Tkd4K3VTUGVqMVVYUlJpN1hMc0V1OVRMSGV0WXJVb2pTUHd0S0dEYmJqUm1Z?=
 =?utf-8?B?ODBIQ002ay9FcVAxdHo5OFBPYmttTEhlWVhXM05QUmJTZUlPR1BxNGVvNGFw?=
 =?utf-8?B?eS9vMWFtN01GcXZYdUtsNXh3TTRhN2xGbHphODFMMTllb1VscEwrdTM5emdn?=
 =?utf-8?B?WXdEZjBiOUZHS3loeHM4YndST1pQSmt6ckI5dXljQmVvUkIrcDBzWi8vdlow?=
 =?utf-8?B?QU1nanZScXRMTGI3RVNBYWd4UmFYYVVIMkhLK3NXb1ZGSGlCTVpWemNNM1B3?=
 =?utf-8?B?aUdqdy9nbmlqWE9LRjBpNG91aXhCUGVMUWYyZ0hMVEdhS04wU29rNHVpYXVm?=
 =?utf-8?B?MkNtbmJtUmxPZE56eDY1eGdVWlpUOGVrMFRtd0dpZ0RTS3d0WDExSW1CcHMx?=
 =?utf-8?B?NHRleFJzYUQ2dkQ2ME94MlUzbFFzRGdIbUh5TmVyNmVaaUZENmNRVGNCRmlp?=
 =?utf-8?B?RHlHUlJXS2V5Z1RhdEhmS1Q4bzlSWFY3N254em9Gb3NIRUpSZE5sVjF4TXBu?=
 =?utf-8?B?MmdKN2NTTHEzcG5KS0JVZDhxS2pTVUZrc25yM1Q0RndVRFVONFl6WTBuVTJ6?=
 =?utf-8?B?OTFmRlF5UUNNTlZKUmV0dzNxQzVGVmlDYXNqVFd3d2FHRXcxS2QwMXVqbVAx?=
 =?utf-8?B?WEFNaE04SkF3am4veEx6QTY0Tk1udDREVjcxVkUvaHNaa2tmcmtwYVd4eHdS?=
 =?utf-8?B?Mk9iVTNnR2FpYjd3WFExMzE4S1RlRzVnQWNnRmI1WHM1RzVnRmc5M3M3WVdr?=
 =?utf-8?B?bTRkaEMvU2JWRDBMeXV1bSs5WnBBZFVxNzJ5QURmQXRuekM3SVE5bmwyWDVo?=
 =?utf-8?B?ZWlOSDhjSG9NbHZydGdxYzFkMFVHZ1dUc21QYm1MbEcvMGpuSGdZbDI3aVlw?=
 =?utf-8?B?VCtHY1VyblhySFpUTlVMTCtIRVlCek1jajJiMDJSVjVjZW9qMmJ4ZnZpRkwy?=
 =?utf-8?B?VUFKTkIyeStVVXlEM0Rha29lVllLT215RDAzVjh2c1VpS1lEY252MWM2OFpG?=
 =?utf-8?B?S2xNMUxpK0RaM09ueEkzZUMwalBzZGd6a0JHa0wxa2dudDZkSys0RG04c2lB?=
 =?utf-8?B?Wi80d2s4TngrZkR3TWFFTDJYYWQyYUVIbnpTS3ErL0UySm0yKzR2S1RZY054?=
 =?utf-8?B?dWlPQVN3aFNTL2E2YTBWTm5SR0ZaWm1zSTQ4WStCZm4vVzQ2T0QrSk5yQWIz?=
 =?utf-8?B?UDNxLzAra0RuczM4czNTYkJpc1hmend4a3F1V1Fsc3FMV1E0ek14QTVWL3hC?=
 =?utf-8?B?cVliZjJmbklEdkdtVEhSTVhSM2czTGwrbmxIZVdQbk1YRUxaazl6VzY2dGNS?=
 =?utf-8?B?aCt3azl5QmxxeCtOMXBRTzd5VFlqQkFlVDlpRlp5ZGlzU1NzYVBzbHFneVlV?=
 =?utf-8?B?bmx5aW9RWm1MYnBGT2FTVXp4YW1OazhpTkhUWEVCSG9wSDRCTkluRmcxSjZs?=
 =?utf-8?B?WGpkMWQwTDA2VjZHVDhBdlNxbEl4SEZOUlpIVkN5eWdkdGpYRXVzMDErRzNq?=
 =?utf-8?B?c013K1UrMkR6YXBRNWRSUGpwOWdiVDFaV2xwRmdLVEMvcENGMnhWUWdCRm9Z?=
 =?utf-8?B?dkVDNGZGSDB2dlh6RWVNc2VJbXI5TzZ2V0pLdlVud0FTMnZwRVhiRlVnZytY?=
 =?utf-8?B?T2x2QVQ0Mi9KZVoyNkwzTWxRL1lSaEpBQ3huaU5NWk1jREJNeStOQT09?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5184f4e-4ff3-499e-f0d2-08df3f44e253
X-MS-Exchange-CrossTenant-AuthSource: DU4PR02MB12006.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 16:08:40.0721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rVvYLhROZbaBA6ian/+7zq+Py7T90yZnmhIe1uE9D7Jo+snclxjAMUl5AoSD65SsvBjkVHbOIw8OjW1ToVtp0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB11143

On 10/23/26 22:58, Jonathan Cameron wrote:
> On Fri, 23 Oct 2026 14:30:27 +0200
> Jesper X Nilsson <jesper.x.nilsson@axis.com> wrote:
> 
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
>>
>> Datasheet: https://www.ti.com/lit/gpn/opt4041
>> Signed-off-by: Jesper X Nilsson <jesper.x.nilsson@axis.com>
> 
> 
> Normally I'd say slow down to give more time for review, but seems
> you got good reviews anyway and the code looks clean to me.
> 
> Ah well, sometimes you win - but generally wait a few days at lesat
> between versions.
> 
I will keep that in mind. Since I got good comments so fast, I was eager 
to fix them.

> Applied to the testing branch of iio.git. I'll be rebasing that
> on rc1 once available.
> 
Have the changes been applied? I can not see them on the testing branch 
of iio.git

Best regards,
Jesper

> thanks,
> 
> Jonathan

