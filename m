Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013030.outbound.protection.outlook.com [40.107.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68595309F1C;
	Fri, 12 Jun 2026 13:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271938; cv=fail; b=f5W/iAZ3GkQBux3wRs47P3lvScPkRj+IIQIgJD40U2EGuYZ9S0iCuU3urrj6GQK17rnzBWEMMSzwtzJ2Nb/UY/wHjnkCVaYBsOY4ajb8IyuNkqrDGrwQUMABaNSLyJ6bwKUH9jeNMDzfly+eFp2wG6y9NXcIqZVZMe4xeS+Op/Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271938; c=relaxed/simple;
	bh=BhnQ67XBp04LVInqKz3nmIlHr3EsB4BLcvAkalEvybQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eztmawATMxCn5snUobwDFksyp/uzt8WvGUF8OIiEZ35vcwJ3GwsBd/KHoElkqxVkgXDBATx/TvCHr1cRqWDscMFqzSSrLCz7GsQJsA6WcX4nB4IkacVi0+5z4yxw/5PrWd5k1QZ09MwIYBhRF554AR6mP1EeyBx1bExQA7x+hFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=j8YbJlXI; arc=fail smtp.client-ip=40.107.201.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="j8YbJlXI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H3OOlNwZRpUuHy4zdmUmkb4UsDI06F+DzKWx6SuhmRdkbvLcFPXAKiNW9rUfNKqUqnmPUEapqWW9vosf8iUwF9DHrgRw3zoI1YAxOo8+TNAR+6FWnUf8487wJX/VXiOm2IxwGkls+mYczsg72v+4KVkucjHMc1pkuH1PeUIGuEu1k1jWPnctYyOx/bSACgUGIGPF6cZfqFVXhWsosPwVHKDTNgmSh/JKuvo0dMG309t4CKmwlrdV2EBCX5MFXyBs5FApBEt8bnsqXtHqOVoIoG+ZJT2k20N4u51DaFbk+Yg/aEuMv3t2HBDckGm5f8YrIOhLCNZpObnwU79j6NRPIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyptohBblNxfGPsT2g3dJVkKi6Gvf9CTe/fClmJrogE=;
 b=yEDvVWR6Fpv//jLcuB5ksp60/Og9kKkDu4eDbfQBPam1FqWdKRCmV+Cqcw90ExbZQoAoz6GWf45a6XXaQl+KR0Nm0Avz49OSjUEbrg7LQySFbqgA0Iv944ZiJIt0ijcesNBCpQ5aymDm58XWH3kc4J14ovnkiSE3JJuxxnpsNrESSBArNxPTwQfBQq88LCsXPez1KcSzwQ2jlJ+ToW4MF3owsaY5zbH1SM8vkplqUsNv7nMZHH6JUg/EQH/9i8Q5UkoClxnXpi7KoDKWmAvF8QSZ6PZ9mcMjt0sIBWtvspaXQecUN0Voh9gJPxGnNmI6REnSg3FlwbiXpSFPBzR+Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyptohBblNxfGPsT2g3dJVkKi6Gvf9CTe/fClmJrogE=;
 b=j8YbJlXIv8jBT+BrOnzRLJjpXAt8yhBo6N+zpUHJQoaYitJ02rKXvpFhPwsyBlfexlobZo2BilcGlnBWtFo7CWRDBYm1uPetrSpRLyaJ5Z6vqAd+HTtd0ubt20ICcgNcc/8RE/Sz5PEFniW7UQ4gwVHlSpQmDuDbd1B/8PE0FBM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by SA1PR12MB7366.namprd12.prod.outlook.com (2603:10b6:806:2b3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 13:45:30 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 13:45:29 +0000
Message-ID: <538eb304-6a55-4c52-b5b1-07a7788de6aa@amd.com>
Date: Fri, 12 Jun 2026 14:45:26 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 5/5] iio: adc: versal-sysmon: add oversampling support
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 conall.ogriofa@amd.com, michal.simek@amd.com, linux@roeck-us.net,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260611222738.2035062-1-salih.erim@amd.com>
 <20260611222738.2035062-6-salih.erim@amd.com>
 <20260612135836.526cc07f@jic23-huawei>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260612135836.526cc07f@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0075.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::8) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|SA1PR12MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b55326-2590-4e42-490c-08dec888ddd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|56012099006|5023799004|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	X0J/HGVgXdTPRyrffz3hGrpIpe/smDNnfQjEwJlM8jC4GZFLtvwNP4MuMw5JroISMIVje+DstJRF4amPjZt4pCXeCNqcISNPJ+p5uKHUJ9De2WrxS9qhh3bpjfkdL0vVNMwT34BIh8iEnlecCGH08tZok/5C77YVEvUDFUvZoaURk1vGY6NVmauwCEUsqGGKuCIlv2/mQjimG6Xh50wsf/AjKdlVLdQSH5koraBUvWQ4fV/kxR2QfPjsLkqEus955HHDvh1tvuPIAG/3V4KraRV14c4qz4Hy8+CHT3shsW2umBggShtb536WDFi5i3ipf2LeG9n9de/Xa4ydy/8EZ9U2ZKFgTregnBGIKBUOgyiZfvc3L6UjD62yUGj0eDVR3TCeNwU124chDuAN7YMcIn8U8XPsN3+/Y2wRLRq4+teYUfz0hr3BCXSKNR/6VVbc0qTsi1Ma6iR/wINDTJJstLpDCZaVeO5rtnm5pbX3zoPX6qYBMyyB9Zi/U2jMjYIjHyz/pr0TkjqiXkFmX5yITXQqtvc1d0Xrr5VzdilxxKg0mFyUFkZmZJKMulpbNoWiTWakSmzrYjHZ7/XNPCMP9K+35AmyLzq4KxBV6buYtMdUy09yvLRKnjJMXfbtGiWsnUKpFELaLS8WWoLKvVWXSe9X/oOWEaEjWJnKJzYywOsFvV3GjJ7Lg9mSfV4IscHT
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(56012099006)(5023799004)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U2V0YnBXd3hzMTlEejFmeWdmRWt5U3p6cHRyRnZPa2ZHNkdzZGNvRFFLczJu?=
 =?utf-8?B?NkJQWStDMURtZ2pPcUlkNWRQak44WkFwUjU3UE5MUnRaL2o4aFY5R1ZkYTUr?=
 =?utf-8?B?aVQ4bDUxVGFNb2ZvbFNTc1pMWEMzNFd6SVRkTVUxYUw4WVEvNkJZSWpxNll6?=
 =?utf-8?B?TkwycUg1OHE3dVlVYTJNQmNYRTQ4emVselV6UkIrdFhKVEdTUFNQeFNqdVNu?=
 =?utf-8?B?TWVvYlA4d3lody9pY2ZWQjM1U3BqdHJQR0QwWjVoRmE2bFhGSjJhaHhnOVVP?=
 =?utf-8?B?VlVidnBOSmplTGRhSy95UUlPblNsOTZrYklEMUQ3ZDVacjFWUDk4L0pGNkNW?=
 =?utf-8?B?VThYSmo5eHQ0eDBIcFVER255cEVJd0ZLaHRLNHhtZWh2Q2phK2h6UldVRmFm?=
 =?utf-8?B?WjBoZUQvd0hpdTFQNVNVUDhrMmlyeXRsZ1B3YUxhUmd6S3VyMFQ5bDV5RWhC?=
 =?utf-8?B?TmRQYlFuaGk1N1JzNkZmVHoraWV0cjcxM0N6UkM1ZVQ1UWxRSTJjQ2NGR3pH?=
 =?utf-8?B?WTlZYVd2c3QxaVIxTVpsN0FpVUR6SXBRSERkRGlucDVYdkRlcC9VSzNGbTVD?=
 =?utf-8?B?ZmEvdzhPSnVUSmU5Witzb1hPTEZiSE1tbmQrcGViNzBVK0lNLzhJTGVzYjYx?=
 =?utf-8?B?ZFlYckdDeVFSdG53L3NlYWwrNG1uUi9MTUZUUU5SMTBxRTU0S2Q1MDgvUkI1?=
 =?utf-8?B?OXN5aU5OQzhMQjhzZmhUM09GVnRpWlZHd1E0REdXVE5GdjFYK3RIcERMRFRm?=
 =?utf-8?B?bTdwamNhK2UwWFVPVkduN3JSR2xVanRQZnJhc0VFNURGaWF6aFRQc05RcG1R?=
 =?utf-8?B?OTJNMHlnZHRTSnZVV0htWERBdHVBUFh1NnRYT0twbkFGdDJiVnJPdUpWclh1?=
 =?utf-8?B?czFqNnRhb1pHWFNIa3dqbldIWE1EQjNkaXkvUnpITFdvTC9qT2EzT1BtcFd3?=
 =?utf-8?B?dTVKU2VJaDNraTJoWXBaTXdKMG5WQTR5ZWp3dElPYXo3UEozWmNIbWxrUGh6?=
 =?utf-8?B?OGhrQlB0dzNqdnpXU2Rnc2doalN0TC9OY2llQ2FJT2Jod3QxUncvSnhSbjI0?=
 =?utf-8?B?YTMxaytJd25pOU1wYmlGVW9Eb2pzY25PcmFMYUdack9LbVFRdXZvRDNrbU03?=
 =?utf-8?B?SEhxSDFyWkFyMk9sRHhFT1JPZVI5SjRMUXo1K3hHYmc3bnFTZDlhcXlpb3JJ?=
 =?utf-8?B?WndCWkh2d0IrL3hQTU45NjhDdDFWZjJINURXZkJXa2JlTmJsSGRzKzU1ZEVM?=
 =?utf-8?B?RnRUWHJYWnNDTStQakhvZlR2TWpQOVpZN3h6akVVa3R3dWFBMCtlVTdWc1lI?=
 =?utf-8?B?THRyNGZUVlo0bHFmMGV4UjE2U3dweDQ2R1RLTnF6dTVPTGxHTzZiN2xRL0Fu?=
 =?utf-8?B?MmxYV0JmQnhBUGw2YWhIa0ZMcmg4MGFLRDdsMVRaOFVmSFYyTU8xNHREOGNV?=
 =?utf-8?B?aEVlOU5wRTZ6LzZKSjl0K1V4VW9rR2pYNEFveDVwT05lYUNPM0tMekh1OFh5?=
 =?utf-8?B?RVg2ZjY0UHNvMzdXellCbFQwZTd0YldwZ1I2QSs1SG9hOW5YeVRxUm4zM1ZN?=
 =?utf-8?B?TnU4ZmV1VWdSM1c5UGl3UnUzZjMzcHNGaGNyMEFiSjRrRFJJVTBNajk0K0Jr?=
 =?utf-8?B?WGdua0FuejlqN1dTQkpNNXdNeFdNdk5KbCttYSsvRlEvMyt1TmxpMWtLZlkr?=
 =?utf-8?B?MG9NcEsxYWV6NmlMa0lTOEI5dlBPWTFMNDJaVnB2N2ZJbUNXMmVKNGNZeHR0?=
 =?utf-8?B?YlpMTDI2bDYramdKOSsxT05CRjdaNitMS2s4bnNQOUxveEpzZmNOTkFjQkJl?=
 =?utf-8?B?eTI2SGNvMFFURXM3b2ZrRlR6UitzWmxYR28yQm4yRlF3RzZIdnpOb1c2RjRp?=
 =?utf-8?B?b29tcDlGWFNUUGlDcXNQRU9RUU54TS9pNGxKSTRRTFRlc2swOGo2TlhJQU1C?=
 =?utf-8?B?SHZxTUFSZitSQnVob0lnMkFOL2xRdE51Qk5sNmJCdkQrcEsxNWFpMUFYOWln?=
 =?utf-8?B?NGlweVloTnE3MjMrc0RRTEJGYW1QaW5BR3EyZjBvUG04OTZGK2xKTHRISHlG?=
 =?utf-8?B?ZWZPcTBZR0J0QXFTR0RIUkNJMHpPUjhaQVhVRzZjTHd3ejN4K1JhTFVqOUY3?=
 =?utf-8?B?LzQ1L0xocW5QeHhmeGVUdVpYbVlBa21TV0ppY0h4a08zWS9IbHB2VXJ1Qi96?=
 =?utf-8?B?OFNHbHJUOHNwQzdjcUJBU1UxclR0KytkQVNmSm94UU1LWVhoN1BSNE91R1l5?=
 =?utf-8?B?Rjg1a3VSNFpDWWhocFpVSVorN3pOYTU5dXZZZ3pGODEvTERtMklSTENGSUlP?=
 =?utf-8?Q?u21JrZ3ZmQjxbv/mjH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b55326-2590-4e42-490c-08dec888ddd1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 13:45:29.7679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R6iZLIn6Ne1eBX097+t4UYJaUa/fj+E7m5TAdQvCNWit8VIWjqxUaNihd/JUL2eF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7366

Hi Jonathan,

On 12/06/2026 13:58, Jonathan Cameron wrote:
> On Thu, 11 Jun 2026 23:27:38 +0100
> Salih Erim <salih.erim@amd.com> wrote:
> 
>> Add support for reading and writing the oversampling ratio through
>> the IIO oversampling_ratio attribute. The hardware supports averaging
>> 2, 4, 8, or 16 samples, plus a ratio of 1 (no averaging).
>>
>> Temperature and supply channels share oversampling configuration at
>> the type level (all temperature channels share one ratio, all supply
>> channels share another), exposed through info_mask_shared_by_type.
>>
>> The hardware encoding uses sample_count / 2 in a 4-bit field within
>> the CONFIG register. Per-channel averaging enable registers must also
>> be updated to activate or deactivate averaging.
>>
>> Signed-off-by: Salih Erim <salih.erim@amd.com>
> 
> One minor comment inline.
> 
>>   drivers/iio/adc/versal-sysmon-core.c | 147 ++++++++++++++++++++++++++-
>>   drivers/iio/adc/versal-sysmon.h      |  17 ++++
>>   2 files changed, 163 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
>> index 20fd3a87d44..fa8f0dc868a 100644
>> --- a/drivers/iio/adc/versal-sysmon-core.c
>> +++ b/drivers/iio/adc/versal-sysmon-core.c
> 
>> +static int sysmon_osr_write(struct sysmon *sysmon, int channel_type, int val)
> 
> There is almost nothing shared in here between the two channel_types.
> Might make sense to just split it into two helpers, particularly as
> there is a channel type if / else at the caller.

Agreed. The only shared code outside the switch is the hw_val
computation. Will split into two helpers in v7.

Thanks,
Salih

> 
>> +{
>> +     /*
>> +      * HW register encoding is sample_count / 2:
>> +      * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
>> +      */
>> +     int hw_val = val >> 1;
>> +     unsigned int readback;
>> +     int ret;
>> +
>> +     switch (channel_type) {
>> +     case IIO_TEMP:
>> +             ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
>> +                                     SYSMON_CONFIG_TEMP_SAT_OSR,
>> +                                     FIELD_PREP(SYSMON_CONFIG_TEMP_SAT_OSR, hw_val));
>> +             if (ret)
>> +                     return ret;
>> +
>> +             /*
>> +              * Readback fence: the SysMon CONFIG register resides in the
>> +              * PMC domain behind the NoC. A posted write may not reach the
>> +              * hardware before the next MMIO access. Reading the register
>> +              * back forces the interconnect to complete the write, preventing
>> +              * a bus hang on the subsequent access.
>> +              */
>> +             regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
>> +
>> +             return sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
>> +                                          SYSMON_TEMP_EN_AVG_COUNT,
>> +                                          hw_val ? ~0U : 0);
>> +     case IIO_VOLTAGE:
>> +             ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
>> +                                     SYSMON_CONFIG_SUPPLY_OSR,
>> +                                     FIELD_PREP(SYSMON_CONFIG_SUPPLY_OSR, hw_val));
>> +             if (ret)
>> +                     return ret;
>> +
>> +             /* Readback fence -- see above */
>> +             regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
>> +
>> +             return sysmon_set_avg_enable(sysmon, SYSMON_SUPPLY_EN_AVG_BASE,
>> +                                          SYSMON_SUPPLY_EN_AVG_COUNT,
>> +                                          hw_val ? ~0U : 0);
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +}
>> +
>> +static int sysmon_write_raw(struct iio_dev *indio_dev,
>> +                         struct iio_chan_spec const *chan,
>> +                         int val, int val2, long mask)
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int i;
>> +     int ret;
>> +
>> +     if (mask != IIO_CHAN_INFO_OVERSAMPLING_RATIO)
>> +             return -EINVAL;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(sysmon_oversampling_avail); i++) {
>> +             if (val == sysmon_oversampling_avail[i])
>> +                     break;
>> +     }
>> +     if (i == ARRAY_SIZE(sysmon_oversampling_avail))
>> +             return -EINVAL;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     ret = sysmon_osr_write(sysmon, chan->type, val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (chan->type == IIO_TEMP)
>> +             sysmon->temp_oversampling = val;
>> +     else
>> +             sysmon->supply_oversampling = val;
>> +
>> +     return 0;
>> +}

