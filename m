Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012029.outbound.protection.outlook.com [40.93.195.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F5B634F275;
	Mon, 15 Jun 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538335; cv=fail; b=r+Pr7onT9B+UZW0uYJfk9gC4yt+wgdo5TtJUoYYIGub/vQlIzT5fJVnWL+XF4sXpTIFFK65vR5Kk8PoGFZzBRYDdJsqJggPkmxYotuFk6tbWOBPU3gJyD9Dnp8MelkBJndPk16foJbrVLgpwTgn4TQ+nMrOkzjPyOyXadU7Uw8I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538335; c=relaxed/simple;
	bh=pwaCSJGcFGtAGzBH2tqaLM6uHtW077WIL67ZO9owGpM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LEwXIs0Bfz3+1mwb8KOGAwsrvMVIKf5Cd9n6BadBMh+7ZVHTcZqkwtpZIig0jOh/iOozW/A3G1DKTTChWHSWqiAbgEQYf6zFnpF3BSUthr/lSAG8em9kJjKfx+ocsWq7yrKt6o+z3hpGshf69ItrApVJZ472vivjT/bYT8edNj0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HQU1TaNM; arc=fail smtp.client-ip=40.93.195.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HQU1TaNM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kmSqldltK3arzcajofwqJTal4c6ps9rLm/g68naE2kVNBwfBI+40N6Jrki4FNhy6WjvD/Jhh0MyigkKxkCdq83P4T6LhWr0IicWkxJp4iiKgmRmMiGvyuHO1hxrmKqcICdFYsptgB0mOdCmHe4oQs2hYZp7Ch5icVF8TYgxeIh1nqfclVF1QRHXN+ysSX3gYDb+Yt6RPGQ8wmipQUtD3oSgDieOwzAFJHQBhgeEX6nv7mSeEZvMa/+o0RSvWvoEg1M+99GrK04NHVXY/16uYW5+qUyRUGp7R6JgEnTcXXJYM0It0YkTZ0+NnGAnyTqMqvyAxtcr+UrIn6bbXhJ87Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVRtHHvrN9WxftkwjPjxNYInZ5Re2Eh/4u5XQ8aEG9Q=;
 b=xLcEuZeLj1HTgQMTBXHr7gMi2MW6VWNpJ8FWLOE5P0iblPl8sztBGCe7o7DTnQqUIxMdPN/B/WioFRodxHOSTSMDq16CdPNgViH0lkagG3pznFzHkyvh2GYZccMUjucklOTosJK/Cb9rtj94ARUfLuOSrSMDJo6xTKfcSqNwk2J6iGQfu+/QU2t5mSbpcPsSIg2jrsRFAR9kH3v98ZaAic5I2weC4WxFi6RloKvECglamIE7M97uTLY0ftxDspy2ob65dgWZ++9nSeKn2QjyGPymXJOfY3G5R46L1giPLenXehkzWGlNbOSZiOggd+2diVtRLdESnHtskS0xi30tZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVRtHHvrN9WxftkwjPjxNYInZ5Re2Eh/4u5XQ8aEG9Q=;
 b=HQU1TaNMPszG/8DGEj9BLymYkpwsS1YZSxkid0lr7ZoB6xeiAQ0x6gPhCSQ5cXPy64YzTPTklo50caZt13kIBZ/cHp6yGetA0Hee9RUkKOhV+R3bAh+CL1ZFisRNgX1Ot3FFfZPWdu71ecOLMZem3bTIkp9EVrKogAJmcOSzNtE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by IA0PR12MB8906.namprd12.prod.outlook.com (2603:10b6:208:481::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:45:31 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:45:31 +0000
Message-ID: <4372849c-a3e2-49a3-9ac0-717abc191f33@amd.com>
Date: Mon, 15 Jun 2026 16:45:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] iio: adc: versal-sysmon: add threshold event
 support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260614233722.2603459-1-salih.erim@amd.com>
 <20260614233722.2603459-5-salih.erim@amd.com>
 <ajAPh4xKqxRyIpBe@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <ajAPh4xKqxRyIpBe@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0084.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:349::8) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|IA0PR12MB8906:EE_
X-MS-Office365-Filtering-Correlation-Id: f56a410f-0f93-437d-a0e8-08decaf5216c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|18002099003|56012099006|4143699003|11063799006|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
	6c8FCQ7/9I7bxL2Z485OktWZlVT19mxH0Yxc2ZIJLW7DC+2tHWaM5or+6AEIuY7WnLHg2gzX9wOfv2dOpGPZI+h3UOztiTaOh1951XaXhClujRvKwJUPRR7fGOuMyraSkIUYxD7LchUg7C5/QGn57WhOhJhnXIDrsUXUn5Im15UBEOIlQP3DuCVWMfIHXbdMXjW88oyTsGHCPqZgecVEsLdW26xLjDMw+fjTO+YAmsILSgDCbGO+N+1ATpanAi+a2N9l4CtusY1ng48qoIAybW8/zvtkX0rGPP3FUTMM/ezbLfeeBAxwq70xQLBdQyeKP6u8fQXu8qF2Px0TTg9KBDbSa0GPmZDor3UUsU3BZ26xisUE+cKkRJZZhTnmFWmHzq2bQRKiFtOC8iCg3LvfF4JIOJ1ACJcIk4HVZxZT0hkCGRlv4K3JW1lfL6u9WloJXSbhSFUGIKCdrsLqyUujLwihCz+AtVRWc3orG8JEXPZQoEHPnl+oFfNHILVgDBF+rQhf97QEhDcmwP7EPgj1gmdHezsKYDA3WCMMXxHokFaiUPIz2p8nrWrCry1BjC/+Yel4Bp5E7I1s4dYH1/FPPk3xY6FPev+FLxtM89B0+VRGwyVeZOTjejMLdvwX44Py48ki65UgUnUV+5gjJQkCMdh8gS8/4Hnsik5nDE8hHX+wkYWoHol2H1t6yn7aXqRQ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(18002099003)(56012099006)(4143699003)(11063799006)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RWRmNXNnR2I2WlFEdXo0TlMrTEpWVk9nYUlhcmF5c3BQRFcwQ0hONE1CNWFR?=
 =?utf-8?B?TVlwRDlveTJmS0p0Vm10TTVEU1JSM2hTazFNUmJicEFxRnRxTlBlQS9zS3p4?=
 =?utf-8?B?MUNWckhQU0UyL1NVdDYzTWE0SSs3U0lZYzlUTUVJQmx3S1NxaHZiNHVDbFAv?=
 =?utf-8?B?WEFveC80ZjQ2blVmYTg3VDNhcll2RTd1T0lDRWlBMG10L04wM0xKSFBpS0tU?=
 =?utf-8?B?dVdiM1J4QlJPZWxqeEd6Rm5Bbmp4Z1RXS09wSFhaTjVoNXFOeEJ6OHU5dmFJ?=
 =?utf-8?B?U0FGSkFIWGp2U3MzMXZaeVBhWVgxSVNQbG5KZmE2dGUrR0xUWlJrNStOSGIv?=
 =?utf-8?B?M2M3K1dlMmk2VVZDc1FDVGVQelRHOTVXWWhmVW5YakpWd1NFM0RTVlorT1Za?=
 =?utf-8?B?YWxmek9VRHFHeXRVV3AyamRsNFllTmlyWEN2OXhpcDA4c0tzbVFvUWRyRnY3?=
 =?utf-8?B?MnRmSU9jT3ppOVBYT1lVQUQ5VFB2S3F2SngzYmNod0hYSTJPTmVJelF4Q29l?=
 =?utf-8?B?d0lCS0NMUFlEZGp3K2pnZVk4ckZMN2JMNUNSQW1ubXQ5VHNpVE05WVVvb3Ro?=
 =?utf-8?B?Z0xVL2E4dCtYQnBRemFmd1BKaWVqUzZyNnpXMjhCeFFFam9OYnhWZUNHRnYx?=
 =?utf-8?B?Z1NQMW1Gek5vVXYyRkswTWJmMjVrMUZLTnh3aXJJV0h3cEdEbGk4c1V3YVdI?=
 =?utf-8?B?VTdrSU1aRXUyQUVQNEdISW5MMzhzUDB1QkMzM1FNR2gyb0JuUzhwRnhvSDVn?=
 =?utf-8?B?TEZZWDVlMjl2V09XZXB4Y0RYZlBmc1BzS2J0L2N2LzBSUVNXMUlRK2RKeERB?=
 =?utf-8?B?WFJ2SHcvYnVwcEFSaW5mbnJGajdqZm80Z0VmMFk2M0RrVlRSOEIwZXE2OUw3?=
 =?utf-8?B?RkprS2kwQXNBYTBpanpZWGVCQy9PK3F2L2YyQ0N5anFCZ2VCaGZYYlRzSFd5?=
 =?utf-8?B?SVZPQjRmbkVwREVsN1pBc0pwL0JXRGlNc3NHNWJVRXZNZHdKSHloVGQ0eTBK?=
 =?utf-8?B?NXJOWmNmL1lydStCaWI3WmhDc1JDTkRmVU0zUHkrWUNtUHVqdE43RWtBeTdo?=
 =?utf-8?B?UVJUdjloWFFlS2FiTHh3KzMwSW9zQWNTZXpsUHcrckoyNWovTDFOM3hxNWN4?=
 =?utf-8?B?M3huN20yeDN6dUJxUlI5YytuZVVkZklhc3o4S2dwanNIdmFsN2tFUTlhSmV5?=
 =?utf-8?B?ZHowSk9JOWZnc2x5bU90aTZlSVpjcUhjME9HWlJEWUY2VkErWFdrRTdUZTdt?=
 =?utf-8?B?NXo5NkVMbFZKNTJENXVWeS9PcndFazBXbm9UbkdJYk9KVGJLMUFJQzRod1BG?=
 =?utf-8?B?SW4wbzYrNFhLUFpWa1NIV0RnOWpJMDFEMm1ReWozbkNTZm5lcHlnT09leDB6?=
 =?utf-8?B?a3plU09jRXA4M2RKSFpGYzNvNnh2YXRwcVpRTWdGNFdMSmJnQUpiYWl1enBl?=
 =?utf-8?B?MFdCS25USWtwOUorcStBZXd4NHlsQ1pVZjF4NldJTkhFaUpPVU9CQkgrZ2NP?=
 =?utf-8?B?TjRQQnRnOEFNZ0ZxVVArbkUvUmhsVERyT2ZkVGE3SUlRcGt4V0YxRGFnajNx?=
 =?utf-8?B?ZnhYL245NFpTcVg3c01WNzNRY25qUzQ5d0RjZTMvR25kSU5lSE1MLzFRekFN?=
 =?utf-8?B?cVkwdTQrUk9SZGxqdVU3UTVuZ0doTXd5UHNEc3FwUVA0TEJlWjIvS3hnQlhl?=
 =?utf-8?B?bklQZHpkMjlUT1lTM2Jkc2pQRjhaZHMxd2xzR0ZVMEZoOEJyYTE1QlZDYWpY?=
 =?utf-8?B?bGVScG8xb2cxYXFzMm1nc25FUTB6NFFFU21KQVI4SHpVQlZlUWRKWXVKdWVS?=
 =?utf-8?B?RmhVL1JkeW1Pc0Z5TTZjL1hvTDlWRk9LQ3NpWlErcmFWWlJHK1dRd0tuT3V4?=
 =?utf-8?B?ako5cWhwZWZ6cEdXWkJsYUQ3VnRrb2pFT2FodUpieUlyMWYvbDhDeldTWDV4?=
 =?utf-8?B?eHhveVBRbThTVWJmaldEUWFUMjVSWG5FMmNFV1pkU29ab0toUW84NCs3MG5W?=
 =?utf-8?B?Mzh3dlhPQ3IwRjlzL2RvQnV4MG12NDRpTmh4QVFJc3Rtb2pRV3YyUlBSQkFT?=
 =?utf-8?B?MWNpV2dSRGdWbVh0dS9FVWFwYSt4YXg1QWNRMlNHNFUvS0xVbXF2b3liTnQ1?=
 =?utf-8?B?MERObEV4VzRaN2tMZ1hYV3RCY0JCdTBoc2x2aWFIMjFvR3MrMTFPL1h0WmtY?=
 =?utf-8?B?bG5EWHpMRkhaOUs0SXVXaUtOTHpRV3N6MUNQVThReUZDQUNvWXZFUDVwRTJX?=
 =?utf-8?B?ZUVLdHY2eXdpSkpVSVo1THNndlNnckoxdDI4dEZWRWVybDE3TFVqa1FXSW1k?=
 =?utf-8?Q?BVsajwSjBd/cxo+aVo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f56a410f-0f93-437d-a0e8-08decaf5216c
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:45:31.1751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lfm+L1l1TLprhOaGpBgYjKjHXIy4vseeQI4MpXhodlb93u5KzJ+RlPrDdSXH4zyG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8906

Hi Andy,

Thanks for the review, replies inline.

On 15/06/2026 15:43, Andy Shevchenko wrote:
> On Mon, Jun 15, 2026 at 12:37:21AM +0100, Salih Erim wrote:
>> Add threshold event support for temperature and supply voltage
>> channels.
>>
>> Temperature events:
>>    - Rising threshold with configurable value on the device
>>      temperature channel (current max across all satellites)
>>    - Per-channel hysteresis as a millicelsius value
>>    - Event direction is IIO_EV_DIR_RISING (hysteresis mode)
>>
>> Supply voltage events:
>>    - Rising/falling threshold per supply channel
>>    - Per-channel alarm enable via alarm configuration registers
>>
>> The hardware supports both window and hysteresis alarm modes for
>> temperature. This driver uses hysteresis mode, where the upper
>> threshold triggers the alarm and the lower threshold clears it
>> (re-arm point). The hardware has a single ISR bit per temperature
>> channel with no indication of which threshold was crossed, so
>> hysteresis mode is the natural fit. The lower threshold register
>> is computed internally as (upper - hysteresis).
>>
>> Hysteresis is stored in the driver as a millicelsius value,
>> initialized from the hardware registers at probe. Writing the
>> rising threshold or hysteresis recomputes the lower register.
>> ALARM_CONFIG is hard-coded to hysteresis mode during init.
>>
>> The hardware also provides a separate over-temperature (OT)
>> threshold, but it is not exposed through IIO as it serves as a
>> hardware safety mechanism for platform shutdown. OT will be
>> exposed through the thermal framework in a follow-up series.
>>
>> The interrupt handler masks active threshold interrupts (which are
>> level-sensitive) and schedules a delayed worker to poll for condition
>> clear before unmasking. When no hardware IRQ is available, event
>> specs are not attached and interrupt init is skipped, since the
>> I2C regmap backend cannot be called from atomic context.
>>
>> When disabling a supply channel alarm, the group interrupt remains
>> active if any other channel in the same alarm group still has an
>> alarm enabled.
>>
>> A devm cleanup action masks all interrupts on driver unbind to
>> prevent unhandled interrupt storms after the IRQ handler is freed.
> 
> ...
> 
>> +static void sysmon_q8p7_to_millicelsius(s16 raw_data, int *val)
>> +{
>> +     *val = (raw_data * (int)MILLI) >> SYSMON_FRACTIONAL_SHIFT;
> 
> MILLIDEGREE_PER_DEGREE is defined as int.

Will use MILLIDEGREE_PER_DEGREE in both q8p7 conversion functions.

> 
>> +}
>> +
>> +static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val)
>> +{
>> +     *raw_data = (val << SYSMON_FRACTIONAL_SHIFT) / (int)MILLI;
> 
> Ditto.
> 
>> +}
> 
> ...
> 
>> +static void sysmon_supply_processedtoraw(int val, u32 reg_val, u32 *raw_data)
>> +{
>> +     int exponent = FIELD_GET(SYSMON_MODE_MASK, reg_val);
>> +     int format = FIELD_GET(SYSMON_FMT_MASK, reg_val);
>> +     int scale, tmp;
>> +
>> +     scale = BIT(SYSMON_SUPPLY_MANTISSA_BITS - exponent);
>> +     tmp = (val * scale) / (int)MILLI;
> 
> Due to agnosticism of this function, I dunno if the above can be applied here.

Agreed, this converts millivolts, not millicelsius.
MILLI with the (int) cast is correct here.

> 
>> +     if (format)
>> +             tmp = clamp(tmp, S16_MIN, S16_MAX);
>> +     else
>> +             tmp = clamp(tmp, 0, U16_MAX);
>> +
>> +     *raw_data = (u16)tmp;
>> +}
> 
> ...
> 
>> +static int sysmon_read_alarm_config(struct sysmon *sysmon,
>> +                                 unsigned long address)
>> +{
>> +     u32 shift = address % SYSMON_ALARM_BITS_PER_REG;
>> +     u32 offset = SYSMON_ALARM_OFFSET(address);
>> +     unsigned int reg_val;
>> +     int ret;
>> +
>> +     ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return !!(reg_val & BIT(shift));
> 
> regmap_test_bits()?

Will switch to regmap_test_bits(). This simplifies the whole
function to a single return statement.

> 
>> +}
> 
> ...
> 
>> -static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
>> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev,
>> +                        int irq)
> 
> I would leave one line (82 characters IIANM).

Will join onto one line.

Thanks,
Salih

> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

