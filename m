Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012014.outbound.protection.outlook.com [52.101.53.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675183DD513;
	Fri, 12 Jun 2026 12:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268066; cv=fail; b=mlwpTRVLkdlahI0FIwzfVIp8IiEsqcuK7SYPuLQcLznc4ZNQB9oh7eGLx5w7nhstDTxMwNeeW2gnwOmeT3cm+W9sXGWokbb/+lzebJPoMgVUsAUhIgxvhjCn502u6KQkQqtMmHeFTMQo7yhoBDCCsQwOr7D7xGBafM/DK1lkDGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268066; c=relaxed/simple;
	bh=ICIJM+CfiWEU53eb1aOr69GEvEs8kJ5v0BZQpK5TATU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tybL1Q5J900dJPRFYVEz7HE9SzMuVaXXPEdZ23A1CfUUcvlbz1Vpq+yAM3oV6g3kdTG1pGSfjDKk+Bm16tkC0eR47Xli6tHeyxKP/VLMenArF6f+px3ARGiZvOkfjAv/dV9OpEzuNL8vBVlRvhclx4hSHftE9SI5jlYAtXqF3co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UY8hV24U; arc=fail smtp.client-ip=52.101.53.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UY8hV24U"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UboioKIhqK/03Gt6jgkVbBeGEHrsA3wkkU6kW7gOYtkbE+tWq0GL5gwrkLmZiAqQOBFhqSH6BXhhjxAlolFl5l84OT7wKrjy1w7OPUf7Yys4n7nOCEQ1Zh2twJpRkaf3v/ibl3k0MThbvCosh3GYvF6RTW7nAw6KAaAHrleNW2iRgtnPScmVoHyJEKwG9xgiBep++GkuN2eUkcB5UpYIN6fTR7BUIIZROZRgZnj3yQAC3C31n89OtAszRT3upncXDVemU4LSFrfYdHn+Wy+49rVMwV3ydB2sSIdH30Jk9HlRIid7EXmfLoojW43x/xWNVGkSfsmjI04LSdIH5binkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3zwrBcjZcYAJhh/ZadJKfs0v/qO0pzOhf13FAd9O0U=;
 b=gvF6c/rZO0ZeyGMy/AcdmTAIbf2tkqRJw/ZZse0QmD+uGvura+q1ccf4gOvouBL8GgqWUQfD+FQfbLfzq8coKGY2dBwy5iIwhlpyZY/csArRkw1jlqJksFAsg1BGFHqRRt51clvs87CFAx+xy3ZNvZ5aX1W9d5iMxnNBvAA3PbECGoO9f5WUbA8+ud87pkWMVt7hTN0bOs4a0dzf0UFaIsE22UylNpPmubCq1rinX+l7h9xSiiTe2sZliEhcGVcxM4y1FPnKIl0auvwmuyeTbDLgSO7WHOvjWKzSnmDaRQnuveresrcEfHlQKnuP1Z/nY2McJCljx1ciL34d2Dg0dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3zwrBcjZcYAJhh/ZadJKfs0v/qO0pzOhf13FAd9O0U=;
 b=UY8hV24UpHbBFaXwXzWJVUA3yDGJbFd0X3KuRyFFQyUVewSKF4Hl/MBOCnoFra8TQSdiMFr6lHPqpp1/oZfiHCG8+qRljG6M1vQTIwnzS1oaevfoHFrvf8rmDwqMRPnNSh/kRbb0YQllRqV2JDdYAwwRAJPhn7Q3XiIFslzqrFA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DS7PR12MB5792.namprd12.prod.outlook.com (2603:10b6:8:77::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.13; Fri, 12 Jun
 2026 12:40:59 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 12:40:58 +0000
Message-ID: <b7941c7e-b944-4782-a55c-d28dfa644d02@amd.com>
Date: Fri, 12 Jun 2026 13:40:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/5] iio: adc: add Versal SysMon driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 conall.ogriofa@amd.com, michal.simek@amd.com, linux@roeck-us.net,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260611222738.2035062-1-salih.erim@amd.com>
 <20260611222738.2035062-3-salih.erim@amd.com>
 <20260612131009.1be11ff2@jic23-huawei>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260612131009.1be11ff2@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0114.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::11) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DS7PR12MB5792:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e530a8a-a8f7-4285-5a7f-08dec87fda25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|18002099003|22082099003|11063799006|56012099006|4143699003|3023799007;
X-Microsoft-Antispam-Message-Info:
	hruxwO26A3X2Stu2/uPGamnzcXEVTEWveE8/CJZJGtg8MN55JlA/YJNUhNtZHcRRKpeK48Fw/Zn/JTXavdYuuI3cMDNjaf47E/YzuCVk3/xN8FgnSTvVmpG/2yLS4XvSaywd6hp+e0HK+r6T44GPBpwpeUToa6e6ggPbKePcWvfUHjBrYr1lpZMEvSIpmdp1bm2qH7iQqofuU/3MPBwYtwQ75+QBANTCyevuSn6D+5r1yxN6F7okH19oKz38k1tLuG9YP99k1aIg00WJdVhP89F6YPoXmhzyMgA2fxqMoxHsCHIRvQ16rbGm8T2DS62HZhkcxQzi5HYhuy5Y8hGWjgqG6rp/uhFMnr7sxAfQg6WlAXYT1NtuSNlO/tfoqweJCaD01F4Vbf1wAxBL3zFPmhHd9NFN76v4W17GaJjbMPgn3UymlNDvDOBbdfh3Qv/ay7pSUqyV+Ly8G58T0/YnIo+wWq4rcQgAlRblM5BepROKTjFwd4eKXHNk1zYFmHiW7/uu3ZVhOagfAlyLAcMkENlC48wTjQRTAaVnvgqqVeBDvxbtiLmy7Z67/Kzc5m4X3ATzdKQQnMkWxkk+Mx6W/9OF8ByJaWgeL6MptPF6rAdbx6JkPlva2EuhKqkYmZjwGCoXkZq3Y3Fm/Xi/3ftjHvMU8r7NENfaj92PWI8ggYgjXl5ATaLp7eXJj33ayUqa
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NnpEa0c1SlVkQmtCd0t6NTAxYWFnMFYwK3hOZzkzeExQalVzeXNOUnFheith?=
 =?utf-8?B?SEFlbnNEUEVydlFXM3QxcTNWd2t2M1A4cW41Qk9DN2ZFZ0hJcW9obGtjelZE?=
 =?utf-8?B?dzZqdGZwcDJVZnEwdFRvYUZaQUJ0MkgxT3h3RjZXZTRCeER2U2FnNSs3dFh6?=
 =?utf-8?B?V1NZUWY3N0x2L0lKOCtma2xrWDhvUlkzMTlNcmRTcnJpRTRwaWZVZDZ3bkNT?=
 =?utf-8?B?WURFd081SWhWVzZXVFJmWUpoL3JpcTRSOUZnS2VLb0lvOVh6R0hRaWxvNURv?=
 =?utf-8?B?L1RMQjJQSFkxaVpTOHliTWdodmJWSEpVWWxEb1NXZXJ0YTA1aXFXOE1Mejdr?=
 =?utf-8?B?WlU2M0tsWmlnRGZPTWdIOEs1QmxSTTc5OUhoOTZNZDlxczlUeVp5YXR1N0p1?=
 =?utf-8?B?MW8wZy9Jc0trY0x3YnFucTRtZXhHUjMvWm1GRFJQbFR4R1QzaVdaOGhBWDAv?=
 =?utf-8?B?Nmk2ZFZKNjJHMzBZcFF3TlNvMnZqN0EyWktGREgwM0U5bGxuUDI0QThOZ2Q1?=
 =?utf-8?B?TzhLYzBmVVZPQ2l5bUd3WXFBdENMbFY0V285MnI0OFJWVlhPa002WXZaN1Jk?=
 =?utf-8?B?ZWJqK1FBOUJFVVdXUThsNENXeld3NFZVa09zZ2hDRjRIWTdRSmJ3ZUVJYy9x?=
 =?utf-8?B?S0UrOW1GL2dQNm1wVSt0UnFuNnR1Ri9NTXF5Ny9ma0pUby80REV3R0M0ZmVr?=
 =?utf-8?B?Z3ZodGs3Q1VNcmxxMlJ6M2FkUHRUcTkzRXFhMDVEdTMrdmlXay9VY1N5YWVl?=
 =?utf-8?B?OHVPYTFUTUU4OGtweERtSFZHa21OUGFUQkpOSzZqK1RySHZiL2x0cjZjbU54?=
 =?utf-8?B?N2oweUNOTlJKNHU5YWJYMTJOd3pUeDdGbndxNkZTTFZrSlAyQ0lqU09OWXpR?=
 =?utf-8?B?c2NPWDVaRjJxM3lLZkVuWEFiS2h0Rmt0bXlhYUZTR3FBS2dndkhDWWZ0N0gr?=
 =?utf-8?B?NnR4b1doejh6czFkNE1zT2RDSjBxeEdhNTZZdEVaQUNFTWk4ckMvenVleVZT?=
 =?utf-8?B?ak1oczVXL1BRc2FOL2M0VFViMW5jL0xaUXZFUXRhbEdFaUlzTVkwKzZ6RUsv?=
 =?utf-8?B?YVRuL0grdHg4NUY5OWF6dFJMdVJCaWRwemtBcDhYeEQyVG9Sai92bFdkWWk2?=
 =?utf-8?B?MURMaUJDaW5iQUpKcG1vajd6K0JSbVhVYkFmTHoxbjVZUnYybzN4N1Zla2Zq?=
 =?utf-8?B?c003bUdQTU9tellqTzhBNnVtdmJzVlZ3VHBiR043T0NXZzkwQ1lwT3hIcC8z?=
 =?utf-8?B?cDV4VHhzbnVRNTFTdzBtM2xjanlqMEJyNldoSHZOMng0bFpCRGxOTEQyOTRo?=
 =?utf-8?B?bkp2TmRIYjh4T3RZSHhrTHNEOUNlclZLUEtMWGlYdmRIc1VJOThnaWtlZWhm?=
 =?utf-8?B?bFd5dXo5c3VteTZDYmZDNHgvcERaMzA2bDRRcXR3ZkpmbmRkZEtKNkRzZmt4?=
 =?utf-8?B?UlVwU0xGSFRaVGMySmc0eHhrc0pRMFlTb0MyQmlYMUdUajZJamc1MWZWdXdS?=
 =?utf-8?B?Z0VJYnNGRDJVblJLSTB1YmloTFdIdXN1Z3FpSEx3bno1L2lmaFJUMWY5cEN5?=
 =?utf-8?B?REpNazl0SDBDNnU5ZjdXNWx4Uzd2eWpWSjUvSnhYTkgwUnlvTmJMWWY3eDZY?=
 =?utf-8?B?Z2t2MUVpQkdFcTN6d1NpVFFncVpSM3VHZ2JvVzZiKytzckxtamp0cmNZWHcw?=
 =?utf-8?B?MEZsQWl0SzZ4STBPeFRFdzdDOGY0TnBwL0MxNUJHQTBCdWFneGlDZlN4VmVV?=
 =?utf-8?B?SXJhOTBzNk9NUlhQV0RWckRReXM4SUxkN1hFUXpmMkRTSXRDdW5IekhMYVJt?=
 =?utf-8?B?WW41MEVUc2ZxWFJzMjZISU9pd0VSZTRRemNsTm4rTytEQWdnNURSSjF3Tyt1?=
 =?utf-8?B?R24ySFIvWjFVZWw5NUd0NXVnSGo2N01qQjN6enBSOHZNY0NsQWpYUWgzeGdi?=
 =?utf-8?B?T1F2TkNmaWxYWndiYmwvSVpaOE1yVGZ0bTNuZkZSRjNZYXdsbVpvVDZYMmNi?=
 =?utf-8?B?aVIxckhCL0J2blFOY0VNTkdBTXN2dE1wbWNtU0ltc0Q4ZWRqYjhxU0U3TFJ6?=
 =?utf-8?B?aFJ6aTBSZFpRV2N2eTFNMjVvTHd4a0xKWm9KaDNUZ0V2dUh0Q1pPcUJGNUtW?=
 =?utf-8?B?ODRhZ1BXcXFvUEVMTWpFZzBuMmI4VEdIMmpjaENNYm56THRNN3lqY21uYU0x?=
 =?utf-8?B?RU1PUStYb1VaWFQxeWg0NHlONWdsNi9VcTYweTVMRHhaOUo0SjZqbXF4d3N2?=
 =?utf-8?B?SGQ1YnpqdGRJT3NxOUpkQkkxOGtRT3RxZk9FZ1E4TWN0dmVROXJOSS9aZHdz?=
 =?utf-8?Q?vVjwxo9lvmUwg7/Z/1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e530a8a-a8f7-4285-5a7f-08dec87fda25
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:40:58.1972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3KThwPNBn9HX2J/X9PJuGlrd4jbau2qpkWBEXU9JGrO/g9hF57axANFo0shv9Top
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5792

Hi Jonathan,

On 12/06/2026 13:10, Jonathan Cameron wrote:
> On Thu, 11 Jun 2026 23:27:35 +0100
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
>> The driver is split into two compilation units:
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
> One question on the static temp channels. I may have forgotten
> some earlier discussion!
> 
>> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
>> new file mode 100644
>> index 00000000000..c875d156dbe
>> --- /dev/null
>> +++ b/drivers/iio/adc/versal-sysmon-core.c
>> @@ -0,0 +1,281 @@
> 
>> +
>> +#define SYSMON_CHAN_TEMP(_chan, _address, _name)             \
>> +{                                                            \
>> +     .type = IIO_TEMP,                                       \
>> +     .indexed = 1,                                           \
>> +     .address = _address,                                    \
>> +     .channel = _chan,                                       \
>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
>> +     .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
>> +     .datasheet_name = _name,                                \
>> +}
>> +
>> +/* Static temperature channels (always present) */
>> +static const struct iio_chan_spec temp_channels[] = {
>> +     SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
>> +     SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
>> +     SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
>> +     SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
> 
> Sorry, I missed this in previous reviews, but what are these channels?
> The labels are rather unusual.
> 
> My guess is they are gathering up values from across a bunch of sensors
> but I'm not certain. They are unusual enough we probably need some documentation.
> 

Your guess is correct. These are hardware-computed aggregate
registers across all active temperature satellites:

   - temp (0x1030): current max across all active satellites
   - min (0x1034): current min across all active satellites
   - max_max (0x1F90): highest peak since last hardware reset
   - min_min (0x1F8C): lowest trough since last hardware reset

The cover letter mentions this but the commit message and code
don't. Will add a comment block above the channel definitions
and expand the commit description in v7.

Thanks,
Salih
