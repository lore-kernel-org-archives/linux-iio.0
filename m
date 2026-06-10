Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010031.outbound.protection.outlook.com [40.93.198.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907E23F6C2E;
	Wed, 10 Jun 2026 12:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093415; cv=fail; b=jbAjizfw4cVmqbt4Pv3xm4rpFKM/LkY4ZEVpaPJTH23hJin5DLk9yRgRZYBI3vMCq/rx1TQPQkP6bcjSqJoOQjTDy4KDCLgEwu8+AyVMqTsSXmPiuTfgB22qf0mgIjPKdUnnuXxQrapS09TH36NwjoKrwjAk4CWFyARO2XqxnuU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093415; c=relaxed/simple;
	bh=/bGSbeeHGWzhZ9yWXme+lp/rwAVS9TDpvpLOdQJBuQc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eRs77ESlnhzBKOiKHatnDXZ7qvBng/7cV2GzcPezKN5aYlFapcJZLtXVV7Cd7u5j+zSmwyjKykcOi3jT0KZPvXDone762tcnvkPgx5JgKDo3K+NxoaB/YQghZBFWq6egjVg8jQKENBUEPh7Z8ViOVbzKJWmWCl1Mq+Hq9zXwqrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HiB40Nvi; arc=fail smtp.client-ip=40.93.198.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HiB40Nvi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KPOgs0dTeFpTFDAU1D5l01Ts0h8GUmlJzPkJtD1IL+eVYqFKoHmliEguWV8xLnwzNvEnC3NC2iZRl55MIbZHz5OF6qmn/7vkeT1pP+kyomaVqmxqFrWfBibbuwPMVywxm3gHOBAS0PUZiwI7sjnhAbz7PgRdcS2a8qBny+yXrYZwdjt5rXHJty92EAdyKFjzkbfSogmntR4HHhzYwbeKJdxoS9A3LQO7tGOyZEEa1C7JrUOyqFKEJJmxz041EKoJ+xGcn5bELEcp+Z7D4jrvK3URpJmi17/dVxRObYDeWsyeqVEmzBB9+AxVN0bqJEyKSy6JwHfDTaWmlnX7nEci2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cb8MtV4dnX3Jb/YdZpPTodnmLH2AvI2v81xi+FZPZXU=;
 b=CrC+INMMtFBEzE4vSmFuG+nrishjS6YrAKSlytKvoJXtMs8xDlHozAZjpAooU44eAh2kA2O/VFL17wu7F/82A7bCjWGHURIihQ8afFheDr41snlhl6RkN02tG8pRD3S8gFiS3BWe6/op8HfCXlz8KDuAhyRdCa52q8QJHN1ZmCNrK4z0XzwIaPYCTATM5aMcTGI5sl2sRF1vbXOyKYjiO/A4hsbCEMjS+tR4WmKYdSx3ynQZ7jBIOdsBoEFjRnvU/Jztj+W/Art8QWZyzEbCjeN61A87VtN0yVutsjeqxZRucrMncXEPSBqyAWlqjfb4NgLaJ3gOrGlD7EqVt1yT+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cb8MtV4dnX3Jb/YdZpPTodnmLH2AvI2v81xi+FZPZXU=;
 b=HiB40NviQLYMqbE2H4mHDhj+6CEFtCtJ8hJAWEQXRnx9R42L4YtcyCnwvH20Ip3huVZJooHFOdU7xFBJqea4v1jA5GkZM96XX5GBgOdLFZQ7zt/gCeOVtv7LaMJaySjw2mGlPUGMbFDXKQ2WDHrVsJi4UV0etCci9rkKsQ8G+gI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by SN7PR12MB7854.namprd12.prod.outlook.com (2603:10b6:806:32b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 12:10:09 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 12:10:09 +0000
Message-ID: <6378c39f-f368-4fd6-a51d-6fe057fd38c0@amd.com>
Date: Wed, 10 Jun 2026 13:10:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] iio: adc: versal-sysmon: add threshold event
 support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260608183801.1257051-1-salih.erim@amd.com>
 <20260608183801.1257051-5-salih.erim@amd.com>
 <aihTVQIedgsFKeM7@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <aihTVQIedgsFKeM7@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0527.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::11) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|SN7PR12MB7854:EE_
X-MS-Office365-Filtering-Correlation-Id: f1f3a67b-1ba2-44f4-e76f-08dec6e93732
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|11063799006|18002099003|22082099003|6133799003|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	7XDTc1cEP08kc4NxVvUEDgrGpJeKm7Z/wE+AdXXIBS1Cc9CZTBXpK1zH3XEZ9fVg1Nj4SsMxbs/NAhf2SdF6Ix+l2w1+lb30HcuOS7LXsP/vk6q20kwlQHERGm8uZuTBda6LcqDBcF8R1qENss3nIKGRj1GAdMu/XSz5Eip/FM6HFg93YxIiJamAXndHYg07Rwl4tsEraHJACcDzL8Z+9v0lzXEj+4xPxKjvjXujpgE7LMlS+JGduDPsJHukNEg+5IBi21Tp2a6Tspx/zGuBo8XixLGcnnV3QO8bgcPEtW2RsTj4vcZaxqvdIdGvgOPH9M2+mdb0zoGGceqlxIQcMCAdnIUhyLGkkTWvaJafFaw5y7CtTani/MrNDRlbPpa28scx55SzqUtQ4L4j8o5LM3vFYXEGdzC+tdwmiGStwlbCc2iSAHnlwKr0YXinYiKe9bjEnAEUJcEektcrT1QIajH6eJvt1NyLzDm0H2jhRtk1N/hIhWraI4YD2xl+ijw2MO7/0gM6I+FeAZeqoPUwANjCypHJpLeCdHRICdPYNm21pp872NKWyA3/j3QTdMgiijJ8ppLGHe8MULJXvRkAiocoAuCz2Bw9pABZl92n9K98MSDLhGT53fohP7+mfp+63Wne9G1c7pCShxcspCAGZgSUqWaVk5kOnj9nW2tkZeHDxfmwvaUqsQ9wVNq7KWcb
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(11063799006)(18002099003)(22082099003)(6133799003)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZS9IbVk3YUdoMVpDRmtWUHNPVWZ3aXUwY3RXbytQaUMxV2VnRU8vd2ZDYTBh?=
 =?utf-8?B?RmdneVozNWZ1bEFldjVpSTR6MTJxMC9nQTJKN3BtOGdvM1ZxNHlXWlBSV3ps?=
 =?utf-8?B?eldseGdDaDF2Mml2N0JBbFROSk9aRGZjQlpWMEJOMTdZeW1BQ0RYVXltV3A5?=
 =?utf-8?B?bkt3V285MlVydU5Ucm5KNjRCdmM2b3AyZEdRUVpHcGFCR0h6cUJVdEJNZlJq?=
 =?utf-8?B?UE9YSVlqbXR2TVJwN1M2b0NjMzlLSS9qWlAzRndJY3NqRVgraGFGRGZKUE1w?=
 =?utf-8?B?eUhmR1hCNHoxeWJLQUdIRHdLRUQvSmZTMWpYVkdRTi9uQXJ0NjhaUHdzRVBy?=
 =?utf-8?B?bnRabWU4T0hVMGw2ejlxa3I2bXN6OXRubVh4b1J2N3JFdzJUQ3d3TWFiNm11?=
 =?utf-8?B?c3FSbGxaSDBYSWc2ckRnK0tDQ0JDbzV5RjFMMkprRGRoZjhZekEwL241Y0xk?=
 =?utf-8?B?bll5SHg3NGZTZGpJTGdneHNPT1JtbjhITzlIaXA0UWRoVk93OGtiMENVUXNQ?=
 =?utf-8?B?REpzeWRPS0NaaEJzNys4YmV3S285MkVVeGJYREtmVEU2T2JhOGRCNEhDa3V2?=
 =?utf-8?B?NlBpOU11TG1NR3V5K0R1L1lKcGo4S1dNYWFqbG5nWWVSZTErOW83ZHJpNy9s?=
 =?utf-8?B?T3c0ZHhFRXdOSElENGZKeFVDd1h0enlqN3A3RGQ0aTdBYnVsNHB0NnBaM0Nz?=
 =?utf-8?B?ZW5Fc1YzRVN3Tk9TRHViMThqZnd6M3BDVGlkdDlMcVppQzM3TGQ3WWMzZTR4?=
 =?utf-8?B?ZkN0cWZBekFORjAyaEd2MGtxRVhSYUl5UEZzdzlncEJpQ1R4NjFLaUt0a1FG?=
 =?utf-8?B?UFgzeDFLemV0WXczYmVzZktBZjY2eE1JaEE2cnEzTkpzM0lNUnRVVzU4MHBr?=
 =?utf-8?B?Y0VSZkVVQks4OWJkUUZmWHBmTnBMeEpvMjNONVB5YlBhaVZFUE5GNFU5ekhC?=
 =?utf-8?B?WGxQWCtYaWM3azVpU2VFcENnbEZTaE0rUldleXErbnJGMDB3UzFOcy8zc3Nn?=
 =?utf-8?B?M0RrbExJUHpyUldTUnhsOEwrWWtrUW1iVTFWZkNFMGRyYkJOMDNyM2c4SUN0?=
 =?utf-8?B?QVRhSTRHWFcwNVVmbWZXaDUxdTNEQnFUcVZEN3RNeTRFMEUrQjVyS3UzYktJ?=
 =?utf-8?B?YnNDZFY4dlVtbmdJMFlTTWNnV05WU0JQUVRoWjVMZDE3MEdYNkcvRDN1THdp?=
 =?utf-8?B?Y0dyZVZrSmFVVitRRlJzeEZKejdqRzZsWWx6QXpBelhxdXBLUmhnTHgxV3Zi?=
 =?utf-8?B?cFpGUFZHNW1oSktEUW1wL0JiMFNpR1RzYk9mK3paZWljZkdkb1hvZ0JVUkFF?=
 =?utf-8?B?OElTa2lQN29ZN2Vza3NHcnlpWjMyTXJqNGZRTkplWk9kOTlFaTFacGFFdUxt?=
 =?utf-8?B?dmhRSldDY0l5S3l1Y3d6cy9KbEN5eVJhdUxKcitYb3BmT2xwWjBRZDZ3eVdI?=
 =?utf-8?B?Ymd3VGR3RERoanZzUWF1VWFmNmlJVXJ6Mk5jQlM0R2JQdHhXei9OZUpFQXQ0?=
 =?utf-8?B?WXNMb2VkakRsQTVlR1Z3MTQ5dGs2V212OHAxZEZ2MFY1dTlRaHNoWWY1RVQ0?=
 =?utf-8?B?QzExTUJKUXhEMlpGUnR3RmF2WTlzK3dTMEN6bjhkd0FhSG03QjRLNWNRa1Ft?=
 =?utf-8?B?VXlneEUwUTM0NGtVcjhGY0FxQ1ZWSE9aNHY2NlpyaUNDWlhpL3J4VjJoREo4?=
 =?utf-8?B?b1FiTmV1RE9qSU9XRGJobkxqWlRTbHF6RWdvb01rZlRmYjg3eDE3dEM4NUVB?=
 =?utf-8?B?Uml5SzBkREcwVnRsekU1MTM3Y2VLaUNjWHBkTXJIdEEyNUprWEZkNUtYbFRN?=
 =?utf-8?B?bGR0WlNvZi9Ma1RUbnRqc0RIV21RRHZMV2xvS3lWZWR0UVc2ZjlzUDNJTnNz?=
 =?utf-8?B?dXhHNk1sU2F5YlVTbGVuV1dtWnJQaEhWTSs1OHUvTjhoZDhXeVNCRHk2Vmky?=
 =?utf-8?B?Z1NZREdnN3JOU2o1Nmg4clZJNDVidkE0M1l3c0ZweHQzeHVzVEdTWU1pbVB4?=
 =?utf-8?B?N1AvT2cyWDBTRDdBTGFOZWV5dlpsbzZ3SG00czY0QytNOGVyQklqRGlicWo2?=
 =?utf-8?B?Y2hXNkpudmlCN0xhV25aNVIyVElHYnczWktUcmF4djNUME92eE5RMTk0SDB6?=
 =?utf-8?B?WVAyWnY1OXh5OVFIT3g4MVc1VXdBSlNmRlF6cWNJVUdMVmprRllGbkNFOGdh?=
 =?utf-8?B?cWcvdFJGRkVkMjJ6Zmk4T1JrOGpvUVlJd3FRY1lkL2ljSGJaTnhRaFdLcHBW?=
 =?utf-8?B?NUNEeFJPc29ydGVQUTUzeFZldWZjaHVWcWdRZE4wbzZ0VE5DYVdkaUc4eTRJ?=
 =?utf-8?Q?+2IP4y3xEeFCflIEMw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f3a67b-1ba2-44f4-e76f-08dec6e93732
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 12:10:09.1158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +n66Lm42I6rYWDY0RtK7sa5p9+eUGBOFRDE+rkeob+TrJF8SMyScPOWFH5e7UUNf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7854

Hi Andy,

On 09/06/2026 18:54, Andy Shevchenko wrote:
> On Mon, Jun 08, 2026 at 07:38:00PM +0100, Salih Erim wrote:
>> Add threshold event support for temperature and supply voltage
>> channels.
>>
>> Temperature events:
>>    - Rising threshold with configurable value
>>    - Over-temperature (OT) alarm with separate threshold
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
>> The interrupt handler masks active threshold interrupts (which are
>> level-sensitive) and schedules a delayed worker to poll for condition
>> clear before unmasking. When no hardware IRQ is available, event
>> channels are not created and interrupt init is skipped, since the
>> I2C regmap backend cannot be called from atomic context.
>>
>> When disabling a supply channel alarm, the group interrupt remains
>> active if any other channel in the same alarm group still has an
>> alarm enabled.
> 
> ...
> 
>> +#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _name, _events) {\
> 
> Just move { to be on the separate line, it will make the macro look better.

Accepted. Will fix both SYSMON_CHAN_TEMP and SYSMON_CHAN_TEMP_EVENT macros.

> 
> #define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _name, _events) \
> {                                                               \
> 
>> +     .type = IIO_TEMP,                                       \
>> +     .indexed = 1,                                           \
>> +     .address = _address,                                    \
>> +     .channel = _chan,                                       \
>> +     .event_spec = _events,                                  \
>> +     .num_event_specs = ARRAY_SIZE(_events),                 \
>> +     .datasheet_name = _name,                                \
>> +}
> 
> ...
> 
>> +static int sysmon_write_event_config(struct iio_dev *indio_dev,
>> +                                  const struct iio_chan_spec *chan,
>> +                                  enum iio_event_type type,
>> +                                  enum iio_event_direction dir,
>> +                                  bool state)
>> +{
>> +     u32 offset = SYSMON_ALARM_OFFSET(chan->address);
>> +     u32 ier = sysmon_get_event_mask(chan->address);
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int alarm_config;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     if (chan->type == IIO_VOLTAGE) {
>> +             ret = sysmon_write_alarm_config(sysmon, chan->address, state);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             ret = regmap_read(sysmon->regmap, offset, &alarm_config);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             if (alarm_config)
>> +                     return regmap_write(sysmon->regmap, SYSMON_IER, ier);
>> +
>> +             return regmap_write(sysmon->regmap, SYSMON_IDR, ier);
> 
>> +     }
>> +
>> +     if (chan->type == IIO_TEMP) {
> 
> Still same problem you promised to address. Please, go back to the previous
> thread and check again what has been addressed and what's not.

You're right on all counts, and I apologize for wasting your time
reviewing the same issues.

The cascading if statements should have been converted to switch
in v5. I fixed it in the oversampling patch but missed these event
functions. All will use switch(chan->type) in v6, and
read/write_event_value will also use switch(info) for the nested
dispatch.

> 
>> +             if (state) {
>> +                     ret = regmap_write(sysmon->regmap, SYSMON_IER, ier);
>> +                     if (ret)
>> +                             return ret;
>> +
>> +                     scoped_guard(spinlock_irq, &sysmon->irq_lock)
>> +                             sysmon->temp_mask &= ~ier;
>> +             } else {
>> +                     ret = regmap_write(sysmon->regmap, SYSMON_IDR, ier);
>> +                     if (ret)
>> +                             return ret;
>> +
>> +                     scoped_guard(spinlock_irq, &sysmon->irq_lock)
>> +                             sysmon->temp_mask |= ier;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
> 
> ...
> 
>> +static int sysmon_update_temp_lower(struct sysmon *sysmon, int address)
>> +{
>> +     unsigned int upper_reg;
>> +     int upper_mc, lower_mc, hysteresis;
>> +     u32 raw_val;
>> +     int upper_off, lower_off, ret;
> 
> Keep in reversed xmas tree order.

Accepted.
> 
>> +     upper_off = sysmon_temp_thresh_offset(address, IIO_EV_DIR_RISING);
>> +     if (upper_off < 0)
>> +             return upper_off;
>> +     lower_off = sysmon_temp_thresh_offset(address, IIO_EV_DIR_FALLING);
>> +     if (lower_off < 0)
>> +             return lower_off;
>> +
>> +     if (address == SYSMON_ADDR_OT_EVENT)
>> +             hysteresis = sysmon->ot_hysteresis;
>> +     else
>> +             hysteresis = sysmon->temp_hysteresis;
>> +
>> +     ret = regmap_read(sysmon->regmap, upper_off, &upper_reg);
>> +     if (ret)
>> +             return ret;
>> +
>> +     sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
>> +
>> +     lower_mc = upper_mc - hysteresis;
>> +     sysmon_millicelsius_to_q8p7(&raw_val, lower_mc);
>> +
>> +     return regmap_write(sysmon->regmap, lower_off, raw_val);
>> +}
> 
> ...
> 
>> +static int sysmon_read_event_value(struct iio_dev *indio_dev,
>> +                                const struct iio_chan_spec *chan,
>> +                                enum iio_event_type type,
>> +                                enum iio_event_direction dir,
>> +                                enum iio_event_info info,
>> +                                int *val, int *val2)
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int reg_val;
>> +     int offset;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     if (chan->type == IIO_TEMP) {
>> +             if (info == IIO_EV_INFO_VALUE) {
>> +                     /* Only rising threshold is exposed */
>> +                     offset = sysmon_temp_thresh_offset(chan->address,
>> +                                                        IIO_EV_DIR_RISING);
>> +                     if (offset < 0)
>> +                             return offset;
>> +
>> +                     ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +                     if (ret)
>> +                             return ret;
>> +
>> +                     sysmon_q8p7_to_millicelsius(reg_val, val);
>> +
>> +                     return IIO_VAL_INT;
>> +             }
>> +             if (info == IIO_EV_INFO_HYSTERESIS) {
>> +                     if (chan->address == SYSMON_ADDR_OT_EVENT)
>> +                             *val = sysmon->ot_hysteresis;
>> +                     else
>> +                             *val = sysmon->temp_hysteresis;
>> +                     return IIO_VAL_INT;
>> +             }
> 
>> +     }
>> +
>> +     if (chan->type == IIO_VOLTAGE) {
> 
> Again, same issue. Are you sure you sent the new version?

That's purely my mistake, I will address them all in new version.
> 
>> +             offset = sysmon_supply_thresh_offset(chan->address, dir);
>> +             if (offset < 0)
>> +                     return offset;
>> +
>> +             ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             sysmon_supply_rawtoprocessed(reg_val, val);
>> +
>> +             return IIO_VAL_INT;
>> +     }
>> +
>> +     return -EINVAL;
>> +}
> 
> ...
> 
>> +static int sysmon_write_event_value(struct iio_dev *indio_dev,
>> +                                 const struct iio_chan_spec *chan,
>> +                                 enum iio_event_type type,
>> +                                 enum iio_event_direction dir,
>> +                                 enum iio_event_info info,
>> +                                 int val, int val2)
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int reg_val;
>> +     u32 raw_val;
>> +     int offset;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     if (chan->type == IIO_TEMP) {
>> +             if (info == IIO_EV_INFO_VALUE) {
>> +                     /* Only rising threshold is exposed */
>> +                     offset = sysmon_temp_thresh_offset(chan->address,
>> +                                                        IIO_EV_DIR_RISING);
>> +                     if (offset < 0)
>> +                             return offset;
>> +
>> +                     sysmon_millicelsius_to_q8p7(&raw_val, val);
>> +
>> +                     ret = regmap_write(sysmon->regmap, offset, raw_val);
>> +                     if (ret)
>> +                             return ret;
>> +
>> +                     /* Recompute lower = upper - hysteresis */
>> +                     return sysmon_update_temp_lower(sysmon, chan->address);
> 
>> +             }
>> +             if (info == IIO_EV_INFO_HYSTERESIS) {
> 
> Ditto.

Will be fixed in v6.
> 
>> +                     if (val < 0)
>> +                             return -EINVAL;
>> +
>> +                     if (chan->address == SYSMON_ADDR_OT_EVENT)
>> +                             sysmon->ot_hysteresis = val;
>> +                     else
>> +                             sysmon->temp_hysteresis = val;
>> +
>> +                     return sysmon_update_temp_lower(sysmon, chan->address);
>> +             }
> 
>> +     }
>> +
>> +     if (chan->type == IIO_VOLTAGE) {
> 
> Ditto.

Will be fixed in v6.

> 
>> +             offset = sysmon_supply_thresh_offset(chan->address, dir);
>> +             if (offset < 0)
>> +                     return offset;
>> +
>> +             ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             sysmon_supply_processedtoraw(val, reg_val, &raw_val);
>> +
>> +             return regmap_write(sysmon->regmap, offset, raw_val);
>> +     }
>> +
>> +     return -EINVAL;
>> +}
> 
> ...
> 
>> +/*
>> + * Versal threshold interrupts are level-sensitive. Active threshold
>> + * interrupts are masked in the handler and polled via delayed work
>> + * until the condition clears, then unmasked.
>> + */
>> +static void sysmon_unmask_worker(struct work_struct *work)
>> +{
>> +     struct sysmon *sysmon =
>> +             container_of(work, struct sysmon, sysmon_unmask_work.work);
>> +     unsigned int isr;
>> +
>> +     /*
>> +      * regmap errors are not checked here because the worker and IRQ
>> +      * handler cannot propagate errors. The MMIO regmap uses fast_io
>> +      * with direct readl/writel which cannot fail.
> 
> OK (but they can fail on HW level to the point of bus errors or so :).

Accepted. Will add error checks to modify flow on failure
instead of just documenting why they're absent.

> 
>> +      */
>> +     spin_lock_irq(&sysmon->irq_lock);
>> +     regmap_read(sysmon->regmap, SYSMON_ISR, &isr);
>> +     regmap_write(sysmon->regmap, SYSMON_ISR, isr);
>> +     sysmon_unmask_temp(sysmon, isr);
>> +     spin_unlock_irq(&sysmon->irq_lock);
>> +
>> +     if (sysmon->masked_temp)
>> +             schedule_delayed_work(&sysmon->sysmon_unmask_work,
>> +                                   msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
>> +     else
>> +             regmap_write(sysmon->regmap, SYSMON_STATUS_RESET, 1);
>> +}
> 
> ...
> 
>> +static int sysmon_init_interrupt(struct sysmon *sysmon,
>> +                              struct device *dev,
>> +                              struct iio_dev *indio_dev,
>> +                              int irq)
>> +{
>> +     unsigned int imr;
>> +     int ret;
>> +
>> +     /* Events not supported without IRQ (e.g. I2C path) */
>> +     if (!irq)
>> +             return 0;
>> +
>> +     ret = devm_delayed_work_autocancel(dev, &sysmon->sysmon_unmask_work,
>> +                                        sysmon_unmask_worker);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
>> +     if (ret)
>> +             return ret;
>> +     sysmon->temp_mask = imr & SYSMON_TEMP_INTR_MASK;
>> +
>> +     return devm_request_irq(dev, irq, sysmon_iio_irq, 0,
>> +                             "sysmon-irq", indio_dev);
> 
> I would do that on a single line, but it's 86 characters long, so up to
> Jonathan.

Accepted. Will join on a single line. Happy to split it back if Jonathan 
prefers.

> 
>> +}
> 
> ...
> 
>> +static int sysmon_init_hysteresis(struct sysmon *sysmon, unsigned int address,
>> +                               int *hysteresis)
>> +{
>> +     unsigned int upper_reg, lower_reg;
>> +     int upper_mc, lower_mc;
>> +     int upper_off, lower_off;
> 
> Reversed xmas tree order.

Accepted.

> 
>> +     int ret;
>> +
>> +     upper_off = sysmon_temp_thresh_offset(address, IIO_EV_DIR_RISING);
>> +     if (upper_off < 0)
>> +             return upper_off;
>> +     lower_off = sysmon_temp_thresh_offset(address, IIO_EV_DIR_FALLING);
>> +     if (lower_off < 0)
>> +             return lower_off;
>> +
>> +     ret = regmap_read(sysmon->regmap, upper_off, &upper_reg);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ret = regmap_read(sysmon->regmap, lower_off, &lower_reg);
>> +     if (ret)
>> +             return ret;
>> +
>> +     sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
>> +     sysmon_q8p7_to_millicelsius(lower_reg, &lower_mc);
>> +     *hysteresis = upper_mc - lower_mc;
>> +
>> +     return 0;
>> +}
> 
> ...
> 
>>        sysmon_channels = devm_kcalloc(dev,
>> -                                    size_add(size_add(ARRAY_SIZE(temp_channels),
>> +                                    size_add(size_add(num_static,
>>                                                  num_supply), num_temp),
>>                                       sizeof(*sysmon_channels), GFP_KERNEL);
> 
> Same comment as per previous patch.

Accepted.
> 
>>        if (!sysmon_channels)
>>                return -ENOMEM;
> 
> ...
> 
>> --- a/drivers/iio/adc/versal-sysmon.h
>> +++ b/drivers/iio/adc/versal-sysmon.h
> 
>>   #include <linux/bits.h>
>>   #include <linux/mutex.h>
>> +#include <linux/spinlock_types.h>
> 
>> +#include <linux/types.h>
> 
> Same comment as per previous round. Really, please double check what you missed
> to address.

I removed types.h from P2 as you asked, then added it at P4
assuming the new struct members needed it. They don't --
spinlock_t comes from spinlock_types.h, unsigned int and int are
built-in, struct delayed_work comes from workqueue.h. Will remove
types.h from the header entirely.

Regards,
Salih

> 
>> +#include <linux/workqueue.h>
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

