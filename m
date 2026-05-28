Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012046.outbound.protection.outlook.com [40.107.209.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C1123394D;
	Thu, 28 May 2026 22:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006031; cv=fail; b=aCLGIBGIYUhdFIZZicFYPlXOJLTV6oT6jhbnLQawYj7oSNpEgFY6NTWdQgtlXLX3rx7CJdT3soxwl1b1oiRMMOonAjVZV3RFD2xnoBXH60N33kZfoBq8s23fAAambPXW8U3m78ZxRd+kd4TreQuJGHg+K5HFBP0C28jzyDdaRYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006031; c=relaxed/simple;
	bh=dKvcj7WDkY2kMtGHEq1i1vwAybOwgbs0A98OjldkMEE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Go420dKJOB9l+7JTgDL9u2L35xWycPadW0fw0wdol7iMUZdanQzG3M7OOMNrX/BStw3N7wcswUWxNzHVenObZ+5rsabPVSGSlToEEuwZ86wqBuxBa1x2sBFYtoLVA5cH5bOr7Gv3kECA3hx5McJq0XEg8Kd2JRzYdW5a5hrRhRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rob4EBcF; arc=fail smtp.client-ip=40.107.209.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rob4EBcF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LaFejQt1iFwDcfElaIOSpMGSMV4ukNJf3P4y9f8ksLkxoIZU6oMpSE9KnRUa1u36s0sYGC8kmx+sVPXDDKLDPG+Z1E3u/4ZHnXn5cG1SfeP4ixdTK9u7a0K5wOWJe1uJj7sTvuTIvBAADvbh4elR21pN2sDjh1BH0dwnK0vcQDd68ohJGfcK7focqPlFZdIMxvnG5D/aku+eng4TYZrzMoelkIitLa4c3NbKzfc4VS+D2EKUE0H4slMUUy1Ho6AwRDu8pzP4XFsfvkcMNtDYMcGybf76J/u7Y/KoTdCZxQvic0NB0AK7C2CD/QOmYEJ43dd/tx5FjpFTnozMK+VcmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DvqFdbgq0XEce30AW4r+JRaK5THl0KS6rM2jh+iwOW8=;
 b=TQ9UWM8zh+p/3KIlrT3FMMig9tux98gmyfgklax/sraNGqOBFtv46pXnTr5PYl07tGoWFykaQh7mGxrCHFdSS4HvexGsVUbpIkEfNZayy3nhc5Yv9LYdnbPcPyV2ovSolHg/n/IQcBoTceASFGLM5SsO4WL+8+qaRzIjZekZgxnHlYvHWv0StIPG8XOiTd0t6FsMgKNsBqxVLOtnVdU3Uo2sl0CUqU2fW93Q5pcfh3yulYljAAUkHEQKpAUA8iuAybGptP9OgmTxOR9THeClMl4VQbIgWdwU065QOMElw6JW7ZaYF2uXqWI252cNeQKHedK4MBcYQlR7Ta7SSnoPAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DvqFdbgq0XEce30AW4r+JRaK5THl0KS6rM2jh+iwOW8=;
 b=rob4EBcFXPzRtmJcU4TYGdsI3NzOJIWZw4cigHIK50m3K7n2TGQw5/rCUMM58WXflN+RjFzPkM14fkTN7wBQzqbbvG/VGmNMY71JYavTjcn8plTUjrDIm3xR6kmBAQ/zxBv3B9i+rwbSn85SLbP3D3pLj1UW1sih7m1KFXfNkgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DM4PR12MB6112.namprd12.prod.outlook.com (2603:10b6:8:aa::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.14; Thu, 28 May 2026 22:07:05 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 22:07:05 +0000
Message-ID: <c3c87824-ead1-4ee2-ae20-634997aa86d8@amd.com>
Date: Thu, 28 May 2026 23:07:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] iio: adc: add Versal SysMon driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Conall O'Griofa
 <conall.ogriofa@amd.com>, Michal Simek <michal.simek@amd.com>,
 Guenter Roeck <linux@roeck-us.net>, Salih Erim <erimsalih@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260527114211.174288-1-salih.erim@amd.com>
 <20260527114211.174288-3-salih.erim@amd.com>
 <20260528132410.0e03cfb1@jic23-huawei>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260528132410.0e03cfb1@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0383.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::10) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DM4PR12MB6112:EE_
X-MS-Office365-Filtering-Correlation-Id: b181a59e-3227-4ed5-1c86-08debd0573c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|18002099003|22082099003|11063799006|5023799004|6133799003|4143699003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	0xLSdRAa5HgVPjQlxS53kN4ge+ZuoLaIh4ZKc0kskwTHlLKLp3Tyi/cTu2gB5jQSa+3q8mY3A1I+JMx6Uu3EV+x14HCSIAzX/mTYh3lrF55ir269GrAKMrLr5behu1QRekMGw8QPtWg723jxrY+bE+2lZgcVEII3kcqef2ka+78NRMwdCdGlyNoLDb9TGig18qmkBVl4JcayHPsqqBBhTSXnmvCRckc1aOUM+AAQp5MfVr4pqbxMFZBs4G/bKwT0ZTXXoC62bTgCNslSGRMK7JyipcHs1eExVDERMFuJTsjpv/b2IOFQTzBxzJXqJApjck1zqlMCADS/JYpthoT6Sou58WsEIIWXaKITFTHBB5OvjcBfEIceWhG8OxiJms2Ug2jOq5dU/F3P2FWk5FjfYFKR6GZpziQF2Qq5Mly22iKW/1XX7GDLP+9R36DIC2msezuJGTUmwXlZh38FdnuXThvvR0qb7XQvoD7AZfWP8xr86lEiUIbhOAjWoyM6Lv6TXJMKPouMoMrpwb3e2Jf2Z9pgn7uC0UdzmtBI3Hwgw3B8BDZdZjdmlEytUU/q5g4CMg41yNl30J0V7+G8EElcDube3BSHlF6F9yKWAD4CivyrQH0TztOcIe/1xOX7n51q4fXmz9dPWj869ssYQ48s4XEmZtsbHnlYndW94wDtjozPr71hhghlYZ/ev2skFTdn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(18002099003)(22082099003)(11063799006)(5023799004)(6133799003)(4143699003)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VU9IeEFveG82N25YRDhNU25xUi8rUVFOMUNJMzJ3dEd0Y1NMZXZZMEdqc0pO?=
 =?utf-8?B?bWVtMXNqSjZxVE91aGdDa1ZEOTFvRURRTXVLQjRiSlloUlBaZS9zcVVETGgv?=
 =?utf-8?B?bkJVWUJndGx0WVFGWWM1a0I3VmtpNU9uVjhxWm5yUXFocFpxSUo5UnZYS2RF?=
 =?utf-8?B?YmhtRzVDdlB2S1hGRENHS1R1d1lVMlp0UkJLejRMWjl1QmswT2lic0V1V0Fy?=
 =?utf-8?B?UldNRWQ3OWtOdE5NVFBWNGdDZExDa0lLWW92VDFUN0h0WGVzQ1ozMWRqeWV4?=
 =?utf-8?B?Um9HaFRnWDFwcW9vbVRseHpEbWlhNDFBVFIxS3A3NFdEbk0vSlJ4VEMrZ2ZH?=
 =?utf-8?B?alNXRjJ6MS9rNG9RcUxXSkxsVTd2NlRJN1AyU0hSWE1HWHBuOU9oNE50OGMv?=
 =?utf-8?B?RUxSM3RwSWNtcjYrTGJkeWR1Y3NVTElRZWhtbmJpU3lETlRBS1NTT2c3K3BJ?=
 =?utf-8?B?YlE3TlNJTE44QlhqcURNNEFXTlE5VGdkb3JzTy95Rm5VUXprMlFFMy9nZldi?=
 =?utf-8?B?Yk9nUlNWSUdtRlZPTWtucHQ3bUdoQURIaWtiSEJSbWJ5QzljUHorVG4wYWp1?=
 =?utf-8?B?QzBIMUdqTlNsNklMNkM0MXNJak5JS01yMFYxbFkyVkVlKytGU0RkYkRQbWx4?=
 =?utf-8?B?QkgyOGxPdkwwbmNwK0JxaW5ZZEJTaHJiNXFjRDJJNm84c21uQ2FUTFdzYUpy?=
 =?utf-8?B?UERBRUwzamxuOFBTcm9SdGFKa0xCSTFyWjh3QVUweTFhTzd0cTI5cWxxZjBK?=
 =?utf-8?B?UG8rTFlMbnlrQk5NWWpQRlByWDdZK3NmZmJ5a1NWYmZrL1RtVEpoVzkwKzFm?=
 =?utf-8?B?dExiT2pFQjF2N3VIajFKUjF2ejBLTE52NDdRUWhCN29HbHJVZ3pmSHl4UnVa?=
 =?utf-8?B?RldjWGlyR3g2VGYyNWZKSDFET2loYThST0pwU0k0dzI5K1ZLSjMwd1EwRE5N?=
 =?utf-8?B?eFlOYU5NdDM3Sjl5TW1OcHFXK0NFZm1GWHRQVmtRbDAwZlVCeFVzdFhobUo2?=
 =?utf-8?B?cnFqeENkVU81bTI0eUVUVmpqam5PaG9SUHljaGc1bG0xSktuYTBrTFRUOGlX?=
 =?utf-8?B?RnorQkJlQXhWRjdCa1FFQjAvb2I1MzJOaEwrWXFEeEZUdHREeGROMW8wOVNY?=
 =?utf-8?B?Y3ViSW1ZLzgxK1RwdmZMbnZqMXZJQkNmd2pZLzkrQnoyNlZqNmJreHlHQXkr?=
 =?utf-8?B?aWhqWTRLRjJ2U3lPWk5lSDd6dGUrM2VzQkEwRjRwQk90Zk9SbG0zRisxSHE3?=
 =?utf-8?B?cTRTV0YyN3VsMUNxd2ZvNWsya3RVVEtldjZTNzZXZXhuaDJxVU56S0ZIa1lx?=
 =?utf-8?B?OEhFcFlkUHlQZGZzRVdTSFdVdVBPdkF6TUcxeTI2U3BGR3dnM0VIeUdabFRF?=
 =?utf-8?B?UXR6YnBzWFlSbUZvM2duUFNFa2wrMFJ3MkpKNWJUa3V5SCs2dUFOMzhWZFFZ?=
 =?utf-8?B?KzA0ZG1sQ2ZncXN1MGw0TjZ2dUFQengxd2hyRUVpSW95STFSdFZRY2hlTGly?=
 =?utf-8?B?NUxCaVYzblN1SGFMWkwwVlVvcER4Y2wzditxSTJabXRCRENzbVVJbWRKVld3?=
 =?utf-8?B?NjhQTUFPaE9WczFWdlBtbmp5cXgyZWlxUHlJRVhQT0wyTVhsWGcwU3JiTHVG?=
 =?utf-8?B?Y2Y0NlhUSUVLa0xzTHFsSUs4N0JZS0l5N1F0U0JjWXFxTzZBUTZ2M2VpQnUv?=
 =?utf-8?B?NUxDa05JUmxOTmlNQWJESWJmNmNBRTBDUW5RaGE5QXBML3FrWkM0dkJWdXVy?=
 =?utf-8?B?bWtuZzRad0ZPUTlUdG1vUUZwNFNFRDUzbEJrMXpYL0pTTFhiM0JaNm9VbVlw?=
 =?utf-8?B?K1VPWlJpcU1oUkVaT01JcmFIWjdYZENFTDRpUHo4c2NGUitIZFJ0Y2owZ0Rx?=
 =?utf-8?B?eVFubEMwd0gxS2paNzZhRWpPTnROTm1OODQ5SXhyRGtIaXFMMFJCWjg4bU9T?=
 =?utf-8?B?K2lodCsxV1ZJa2w4RVZmazBYODllTWJaRm92cEpPM1hZalBWSjFuVU1TaWNN?=
 =?utf-8?B?WHlLc3o3aHNaMEZrL3dud0FpSTRnVjJGMmlkZ2VpZzJyd2FHNjVKMjZjNlhq?=
 =?utf-8?B?VW1pb0dGZFRRSDB0ejYvQkNCdWltRW1ubUxYSWRFWDBqYmdsaGV3TUhFdXhU?=
 =?utf-8?B?UUJiV3ZoVUNKVDk0K1ZWZ0JnM1NibmNYUFFKbFRnbHFGaWsya2ZUZzh0amNa?=
 =?utf-8?B?ZllVWTYyNEF5dUtic2d6RlpweWhRQ08vbCtiLzJHU0JMU29XWEJTTWpKZ0tw?=
 =?utf-8?B?NHY2N0NIV0VHbStHamErcjlUY3k5VGhpbzhxOGsvbnA5WW0wWlNWalB4TEtj?=
 =?utf-8?Q?X+GByh4mclTc7yAa7K?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b181a59e-3227-4ed5-1c86-08debd0573c0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 22:07:04.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UbTv3CVLVD852vRxocNJ1w6Fv1bnZFPoUEVriAzZviOr6Y3cnfEa6mdv4wqZbEtz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6112

Hi Jonathan,

On 28/05/2026 13:24, Jonathan Cameron wrote:
> 
> 
> On Wed, 27 May 2026 12:42:08 +0100
> Salih Erim <salih.erim@amd.com> wrote:
> 
>> Add the core driver and MMIO platform driver for the AMD/Xilinx Versal
>> System Monitor (SysMon) block.
>>
>> The SysMon block resides in the platform management controller (PMC) and
>> provides on-chip voltage and temperature monitoring through a 10-bit,
>> 200 kSPS ADC. It can monitor up to 160 voltage channels and 64
>> temperature satellites distributed across the SoC, with a consistent
>> sample rate of 8 kSPS per channel regardless of how many channels are
>> enabled.
>>
>> The driver is split into three compilation units:
>>    - versal-sysmon-core: Channel parsing, IIO registration, read_raw
>>    - versal-sysmon: MMIO platform driver with custom regmap accessors
>>
>> Voltage results are stored in a 19-bit modified floating-point format
>> and converted to millivolts. Temperature results are stored in Q8.7
>> signed fixed-point Celsius format and converted to millicelsius.
>>
>> The MMIO regmap backend uses a custom reg_write accessor that
>> automatically unlocks the NPI (NoC programming interface) lock
>> register before each write, as required by the hardware. The regmap
>> is configured with fast_io since the underlying MMIO accessors are
>> safe to call from atomic context.
>>
>> Co-developed-by: Michal Simek <michal.simek@amd.com>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> Signed-off-by: Salih Erim <salih.erim@amd.com>
> 
> Various comments inline.
> 
> 
>> ---
>> Changes in v3:
>>    - IWYU: add array_size.h, string.h, types.h to core; audit and
>>      fix header and MMIO driver includes (Andy)
>>    - Rename _ext to _name in SYSMON_CHAN_TEMP macro parameter (Andy,
>>      Jonathan)
>>    - Use .info_mask_separate = BIT() style in SYSMON_CHAN_TEMP (Andy)
>>    - Use s16 parameter in sysmon_q8p7_to_millicelsius (Andy)
>>    - Use sign_extend32() in sysmon_supply_rawtoprocessed (Andy)
>>    - Split sysmon_read_raw parameters logically across lines (Andy)
>>    - Remove redundant (int) casts on regval (Andy)
>>    - Split num_supply/num_temp initialization (Andy)
>>    - Use __free(fwnode_handle) cleanup, remove goto err_put (Andy)
>>    - Use size_add() for overflow-safe allocation (Andy)
>>    - Use dev_err_probe() in sysmon_parse_fw error paths (Jonathan)
>>    - Move fwnode_irq_get() to core_probe, remove irq parameter
>>      from bus driver interfaces (Jonathan)
>>    - Use (int)MILLI at call sites, drop SYSMON_MILLI define (Andy,
>>      Jonathan)
>>    - Remove sysmon->dev, sysmon->indio_dev, sysmon->irq from struct;
>>      pass as local variables or use regmap_get_device() (Jonathan)
>>    - Use struct device *dev local in sysmon_platform_probe (Andy)
>>    - Describe protected data in lock comment (Jonathan)
>>    - Add comment explaining RAW+PROCESSED co-exposure (Jonathan)
> 
> Looking at this again, I'm thinking we don't need them both.
> In particular it makes it ambiguous for what scaling of events is
> so best to use one or the other.

Agreed.

> 
>>
>> Changes in v2:
>>    - Split into core (versal-sysmon-core.c) + MMIO platform driver
>>      (versal-sysmon.c) + shared header (versal-sysmon.h)
>>    - Uses regmap API instead of direct readl/writel
>>    - MMIO regmap uses custom callbacks with NPI unlock in write path
>>    - Reverse Christmas Tree variable ordering throughout
>>    - Header include order fixed
>>    - MAINTAINERS entry folded in with wildcard F: pattern
>>    - Kconfig: hidden VERSAL_SYSMON_CORE + VERSAL_SYSMON selects it
>>    - Kconfig/Makefile: alphabetical ordering (VERSAL before VF610)
>>    - Bounds validation on DT reg values
>>    - Named constants replace magic numbers (SYSMON_REG_STRIDE,
>>      SYSMON_SUPPLY_MANTISSA_BITS, SYSMON_MILLI)
>>    - kernel-doc for exported sysmon_core_probe() and sysmon_parse_fw()
>>    - Supply voltage conversion uses proper two's complement sign
>>      extension (s16 cast) matching the hardware specification
>>    - Register offsets sorted by address in header
>>    - Each patch introduces only the defines, fields, and includes
>>      it uses (no dead code in any commit)
>>    - Removed unused linux/limits.h and linux/units.h includes
>>    - Renamed iio_dev_info to sysmon_iio_info
>>    - regmap_write return values checked in probe init path
> 
>> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
>> new file mode 100644
>> index 00000000000..ebe052f6982
>> --- /dev/null
>> +++ b/drivers/iio/adc/versal-sysmon-core.c
>> @@ -0,0 +1,311 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD Versal SysMon core driver
>> + *
>> + * Copyright (C) 2019 - 2022, Xilinx, Inc.
>> + * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/array_size.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/device.h>
>> +#include <linux/module.h>
>> +#include <linux/property.h>
>> +#include <linux/regmap.h>
>> +#include <linux/string.h>
>> +#include <linux/sysfs.h>
>> +#include <linux/units.h>
>> +
>> +#include <linux/iio/iio.h>
>> +
>> +#include "versal-sysmon.h"
>> +
>> +/*
>> + * Both RAW and PROCESSED are exposed: RAW is needed for event thresholds
>> + * (which operate in hardware register format), PROCESSED gives userspace
>> + * the converted millivolt or millicelsius value.
> The conversion seems to be linear.  So you should be providing _SCALE and
> maybe _OFFSET to let the users work out any necessary conversion.
> 
> I don't yet see a reason to provide PROCESSED for this channel type.

Accepted. Will switch temperature to RAW + SCALE.

> 
>> + */
>> +#define SYSMON_CHAN_TEMP(_chan, _address, _name) {           \
>> +     .type = IIO_TEMP,                                       \
>> +     .indexed = 1,                                           \
>> +     .address = _address,                                    \
>> +     .channel = _chan,                                       \
>> +     .info_mask_separate =                                   \
>> +             BIT(IIO_CHAN_INFO_RAW) |                                \
>> +             BIT(IIO_CHAN_INFO_PROCESSED),                   \
>> +     .scan_type = {                                          \
> 
> This is mainly there for buffered interfaces (chardev) but I don't think
> you yet support that so drop it.

Accepted.

> 
>> +             .sign = 's',                                    \
>> +             .realbits = 15,                                 \
>> +             .storagebits = 16,                              \
>> +             .endianness = IIO_CPU,                          \
>> +     },                                                      \
>> +     .datasheet_name = _name,                                \
>> +}
>> +
>> +/* Static temperature channels (always present) */
>> +static const struct iio_chan_spec temp_channels[] = {
>> +     SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
>> +     SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
>> +     SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
>> +     SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
>> +};
>> +
>> +static void sysmon_q8p7_to_millicelsius(s16 raw_data, int *val)
>> +{
>> +     *val = (raw_data * (int)MILLI) >> SYSMON_FRACTIONAL_SHIFT;
> 
> That's a very simple linear scaling so provide _RAW and get rid of this.

Accepted.

> 
>> +}
>> +
>> +static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
>> +{
>> +     int mantissa, format, exponent;
>> +
>> +     mantissa = FIELD_GET(SYSMON_MANTISSA_MASK, raw_data);
>> +     exponent = SYSMON_SUPPLY_MANTISSA_BITS - FIELD_GET(SYSMON_MODE_MASK, raw_data);
>> +     format = FIELD_GET(SYSMON_FMT_MASK, raw_data);
>> +     /*
>> +      * When format bit is set the mantissa is two's complement
>> +      * (per hardware spec); sign-extend to int for correct arithmetic.
>> +      */
>> +     if (format)
>> +             mantissa = sign_extend32(mantissa, 15);
>> +
>> +     *val = (mantissa * (int)MILLI) >> exponent;
>> +}
> 
> 
>> +
>> +/**
>> + * sysmon_parse_fw() - Parse firmware nodes and configure IIO channels.
>> + * @indio_dev: IIO device instance
>> + * @dev: Parent device
>> + *
>> + * Reads voltage-channels and temperature-channels container nodes from
>> + * firmware and builds the IIO channel array. Static temperature channels
>> + * are prepended, followed by supply and satellite channels from DT.
>> + *
>> + * Return: 0 on success, negative errno on failure.
>> + */
>> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
>> +{
>> +     struct fwnode_handle *supply_node __free(fwnode_handle) =
>> +             device_get_named_child_node(dev, "voltage-channels");
>> +     struct fwnode_handle *temp_node __free(fwnode_handle) =
>> +             device_get_named_child_node(dev, "temperature-channels");
> 
> Move these down to just above each check. Note that when using __free()
> it is fine not to have all declarations at the top.

Accepted.

> 
>> +     unsigned int num_supply = 0, num_temp = 0;
>> +     unsigned int idx, temp_chan_idx, volt_chan_idx;
>> +     struct iio_chan_spec *sysmon_channels;
>> +     const char *label;
>> +     u32 reg;
>> +     int ret;
>> +
>          struct fwnode_handle *supply_node __free(fwnode_handle) =
>                  device_get_named_child_node(dev, "voltage-channels");
>          if (supply_node)
>> +     if (supply_node)
>> +             num_supply = fwnode_get_child_node_count(supply_node);
>          struct fwnode_handle *temp_node __free(fwnode_handle) =
>                  device_get_named_child_node(dev, "temperature-channels");
>          if (temp_node)
> 
>> +     if (temp_node)
>> +             num_temp = fwnode_get_child_node_count(temp_node);
>> +
>> +     sysmon_channels = devm_kcalloc(dev,
>> +                                    size_add(ARRAY_SIZE(temp_channels),
>> +                                             num_supply + num_temp),
>> +                                    sizeof(*sysmon_channels), GFP_KERNEL);
>> +     if (!sysmon_channels)
>> +             return -ENOMEM;
>> +
>> +     /* Static temperature channels first (fixed indices) */
>> +     idx = 0;
>> +     memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
>> +     idx += ARRAY_SIZE(temp_channels);
>> +
>> +     /* Supply channels from DT */
>> +     fwnode_for_each_child_node_scoped(supply_node, child) {
>> +             ret = fwnode_property_read_u32(child, "reg", &reg);
>> +             if (ret < 0)
>> +                     return dev_err_probe(dev, ret,
>> +                                          "missing reg for supply channel\n");
>> +
>> +             if (reg > SYSMON_SUPPLY_IDX_MAX)
>> +                     return dev_err_probe(dev, -EINVAL,
>> +                                          "supply reg %u exceeds max %u\n",
>> +                                          reg, SYSMON_SUPPLY_IDX_MAX);
>> +
>> +             ret = fwnode_property_read_string(child, "label", &label);
>> +             if (ret < 0)
>> +                     return dev_err_probe(dev, ret,
>> +                                          "missing label for supply channel\n");
>> +
>> +             sysmon_channels[idx++] = (struct iio_chan_spec) {
>> +                     .type = IIO_VOLTAGE,
>> +                     .indexed = 1,
>> +                     .address = reg,
>> +                     .info_mask_separate =
>> +                             BIT(IIO_CHAN_INFO_RAW) |
>> +                             BIT(IIO_CHAN_INFO_PROCESSED),
> Add a similar comment to the one you have for temperature channels here.
> This is tricky because I have no idea how a user would set a floating point
> threshold via raw.  Their expectation is that is simple and linear.

Accepted.

> 
> How hard is it to take a _PROCESSED event value and convert it back to
> a format that can be used for setting the register values? To me that
> seems like a much more intuitive interface
> 
>  From a quick look at the event patch it seems you are doing that? In which case drop raw.

Yes, the event code in P4 already converts between millivolts and
the raw register format internally. Will drop RAW for voltage,
keep PROCESSED only.

> 
>> +                     .scan_type = {
>> +                             .realbits = 19,
>> +                             .storagebits = 32,
>> +                             .endianness = IIO_CPU,
>> +                             .sign = fwnode_property_read_bool(child,
>> +                                     "bipolar") ? 's' : 'u',
> 
> As above, this only gets exposed when buffered interfaces are added, so for
> now don't set it unless you are using them for some internal purposes.
> Also .sign is being replace with .format.

Accepted. Noted re .format for future buffered support.

> 
>> +                     },
>> +                     .datasheet_name = label,
>> +             };
>> +     }
>> +
>> +     /* Temperature satellite channels from DT */
>> +     fwnode_for_each_child_node_scoped(temp_node, child) {
>> +             ret = fwnode_property_read_u32(child, "reg", &reg);
>> +             if (ret < 0)
>> +                     return dev_err_probe(dev, ret,
>> +                                          "missing reg for temp channel\n");
>> +
>> +             if (reg < 1 || reg > SYSMON_TEMP_SAT_MAX)
>> +                     return dev_err_probe(dev, -EINVAL,
>> +                                          "temp reg %u out of range [1..%u]\n",
>> +                                          reg, SYSMON_TEMP_SAT_MAX);
>> +
>> +             ret = fwnode_property_read_string(child, "label", &label);
>> +             if (ret < 0)
>> +                     return dev_err_probe(dev, ret,
>> +                                          "missing label for temp channel\n");
>> +
>> +             sysmon_channels[idx++] = (struct iio_chan_spec) {
>> +                     .type = IIO_TEMP,
>> +                     .indexed = 1,
>> +                     .address = SYSMON_TEMP_SAT_BASE +
>> +                                ((reg - 1) * SYSMON_REG_STRIDE),
>> +                     .info_mask_separate =
>> +                             BIT(IIO_CHAN_INFO_RAW) |
>> +                             BIT(IIO_CHAN_INFO_PROCESSED),
> 
> As above, add a comment on why both (or drop one of them)

Dropping RAW for voltage as discussed above.

> 
>> +                     .scan_type = {
>> +                             .sign = 's',
>> +                             .realbits = 15,
>> +                             .storagebits = 16,
>> +                             .endianness = IIO_CPU,
>> +                     },
>> +                     .datasheet_name = label,
>> +             };
>> +     }
>> +
>> +     indio_dev->num_channels = idx;
>> +     indio_dev->info = &sysmon_iio_info;
>> +
>> +     /*
>> +      * Assign per-type sequential channel numbers.
>> +      * IIO sysfs uses type prefix (in_tempN, in_voltageN)
>> +      * so numbers only need to be unique within each type.
>> +      */
>> +     temp_chan_idx = 0;
>> +     volt_chan_idx = 0;
>> +     for (idx = 0; idx < indio_dev->num_channels; idx++) {
>> +             if (sysmon_channels[idx].type == IIO_TEMP)
>> +                     sysmon_channels[idx].channel = temp_chan_idx++;
>> +             else
>> +                     sysmon_channels[idx].channel = volt_chan_idx++;
>> +     }
>> +
>> +     indio_dev->channels = sysmon_channels;
>> +
>> +     return 0;
>> +}
> 
>> diff --git a/drivers/iio/adc/versal-sysmon.c b/drivers/iio/adc/versal-sysmon.c
>> new file mode 100644
>> index 00000000000..8473288e7db
>> --- /dev/null
>> +++ b/drivers/iio/adc/versal-sysmon.c
>> @@ -0,0 +1,92 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD Versal SysMon MMIO platform driver
>> + *
>> + * Copyright (C) 2019 - 2022, Xilinx, Inc.
>> + * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/io.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "versal-sysmon.h"
>> +
>> +struct sysmon_mmio {
>> +     void __iomem *base;
>> +};
>> +
>> +static int sysmon_mmio_reg_read(void *context, unsigned int reg,
>> +                             unsigned int *val)
>> +{
>> +     struct sysmon_mmio *mmio = context;
>> +
>> +     *val = readl(mmio->base + reg);
> 
> Blank line before simple returns slightly helps readabilty.

Accepted.
> 
>> +     return 0;
>> +}
> 
>> +static int sysmon_platform_probe(struct platform_device *pdev)
>> +{
>> +     struct device *dev = &pdev->dev;
>> +     struct sysmon_mmio *mmio;
>> +     struct regmap *regmap;
>> +
>> +     mmio = devm_kzalloc(dev, sizeof(*mmio), GFP_KERNEL);
>> +     if (!mmio)
>> +             return -ENOMEM;
>> +
>> +     mmio->base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(mmio->base))
>> +             return PTR_ERR(mmio->base);
>> +
>> +     regmap = devm_regmap_init(dev, NULL, mmio,
>> +                               &sysmon_mmio_regmap_config);
> 
> Fits on one line I think even with a strict 80 char limit (which we relax
> when readabilty is hurt)

Accepted.

> 
>> +     if (IS_ERR(regmap))
>> +             return PTR_ERR(regmap);
>> +
>> +     return sysmon_core_probe(dev, regmap);
>> +}
> 
>> diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
>> new file mode 100644
>> index 00000000000..d24d2481915
>> --- /dev/null
>> +++ b/drivers/iio/adc/versal-sysmon.h
> 
> ...
> 
>> +
>> +/* Q8.7 fractional shift */
>> +#define SYSMON_FRACTIONAL_SHIFT              7U
> 
> This should perhaps be a mask then use FIELD_GET() to extract the value.

Accepted.

> 
>> +#define SYSMON_SUPPLY_MANTISSA_BITS  16
>> +
>> +/**
>> + * struct sysmon - Driver data for Versal SysMon
>> + * @regmap: register map for hardware access
>> + * @lock: protects regmap access
>> + */
>> +struct sysmon {
>> +     struct regmap *regmap;
>> +     /* Protects regmap access */
> 
> regmap has it's own internal locks. So this comment needs to explain
> in more detail what is being protected.  I assume read modify write
> or long related sequences that must not be interrupted and aren't encapsulated
> in single regmap calls?

Accepted. The mutex protects read-modify-write sequences on
threshold registers and cached state (oversampling ratios,
hysteresis values) that span multiple regmap calls.

> 
>> +     struct mutex lock;
>> +};
> 

All items will be addressed in v4.

Salih

