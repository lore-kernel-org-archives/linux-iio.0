Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012053.outbound.protection.outlook.com [52.101.43.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1DD480977;
	Wed, 17 Jun 2026 16:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714057; cv=fail; b=ibHO1HbBjrprZaWnyvr/HTpSoP5L4R+TD9MSvecK98i1HLykYlK5v8yRXC/OhWDRz8gu3tXimKPje0rhTtLCj34vJ29brpN5SmHGZMaa6EUAZCVv+2+7r1I1zLdeNz4gpcIRLWuIFFjiTqxMOpnCMTQ+2/+BMN9ISL9isK2tVsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714057; c=relaxed/simple;
	bh=LvRiIliu1TT2MaXujstOQBHTiyGU95dI93JWTke2S8A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JmSeTBl5Dz0vpFK5Q3JShO6KDIOUHMYW3MUnB8CXtBGY+tiYZuFNNa+GhBtXWb3cLVx9Zew7/vl/b/tHBVr2iemrzeAHe8w9oxBHlgGDxQfSJym9/HNIYuWQp7nFz3RVZs6jlkADt9cf+l6fCa1JgQowuHgNH8pj040bT/1yPVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=q8CjuhCf; arc=fail smtp.client-ip=52.101.43.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="q8CjuhCf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIranaORcbnd5jHID2dWn4iRTwOBtXpb3g6K+2avCMpzkN6fcJqUBGBtggC1JGnTR4Lt28P9QumZmz21MO4VP2hOiWs5QsaYIhEvSOgjaAIjXuTFJUjDLFWi/GvutgpUWmgobEDousyh4FGPdroCThbdg3Fcx5fxP+EQq5J7tepqHo51ZAigs/CIXy0rrwWzArq3o57ORN5lwwzadIhRxS2yEgfDNCrAiUAd4dEtTn7OJJf4MxsFpKW/eECvGsXbEkWsNa14BB4C1D8hdG7PaIQRMK6Ghx0tUyLEkd+9vsHOamfl9CG2yD+Cyn1QkazH1HZB5s3gECgf6FaRibqlug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvrEfcI28hjhMU6KlGh5+s7uwcrYDehHk6t/E2Thga8=;
 b=ckCJGqYO8Jouoi4NYOiK+LsQUcN9Q95hfQF+ZHFT+I0vJUMqKwOL7A2yrbT8f/xEkARlzOQfcNSZv9TLaoZaW86o684hGq+Znp8qIyBjV+/iBuw2+kDxTyliAc0OlLjwlBHN2mAqfFZ53Zaj/1G+IT0j/sFTJVUFH6oORqLTqwsU0SKMgX3uzCQhgLi1bXpUPX/9EfQP/vQgj1H4y/9w1axaOmhcu/XnOqbDMWFMTeUDiq7WiVWtfGcuPZPfq8ovHUkBZKibRL9uUAchyrN2jK3YiOSTfp87ZA5uGcnQq05emP8ciavgsfWHIWYv/fM/HdQTdSfRT7fOCtOY+9MQHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvrEfcI28hjhMU6KlGh5+s7uwcrYDehHk6t/E2Thga8=;
 b=q8CjuhCfdZyy8EOVNeFNyxJ5Z+8sxTziCWsOgfNAgtLZdBsCAYB+BrWzV6SJeNtZUfUA+cn3IsC/q+isDiN+8x4Y2A02HANPz7+2lTn74TstwUO+qQCSFl3lQ22IrX40w+jNy6qAoV4ainQdTsskBc7uix3ZCobf9YfveF6lg+I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Wed, 17 Jun
 2026 16:34:09 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.009; Wed, 17 Jun 2026
 16:34:09 +0000
Message-ID: <23e50165-c58e-4648-a848-5a11af091b8d@amd.com>
Date: Wed, 17 Jun 2026 17:34:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 4/5] iio: adc: versal-sysmon: add threshold event
 support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260616131559.3029543-1-salih.erim@amd.com>
 <20260616131559.3029543-5-salih.erim@amd.com>
 <ajK_kmZMfdLaVyIj@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <ajK_kmZMfdLaVyIj@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0286.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::21) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|SJ2PR12MB7893:EE_
X-MS-Office365-Filtering-Correlation-Id: 57909a9b-3a8e-4fc1-d1fb-08decc8e41e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|23010399003|1800799024|18002099003|22082099003|4143699003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	qCzNQbH5eMc3fwfSeNu/fI9ijA8slkR1qv2CrIJUn4UEckDGu0jM20RJapc2u08ezWoSig3RcQpdfNv0NZSbLax+vEgmkn5/BuD13b8ZBlAHSLvinY5YuGN8GMjzBjpcvfuSyugeDuC88Hy8rIRH28ZZ4AfPqph7EdvHOuxQ4pM1/YGVzQMM6qgl4VCuJWDZUyC/XDGznB0ZIw2yJLt4h5UNynEJNnYpykd9ueaYunB7IFPcBdITYY5AQ9vK9uOzC0pQfu2Wy4RckaPaEcm3/ttSMx9CwtHY9/CmTgaWuBmUveb3wfOO99p1c9w82NjUyiN7nvzwO425f8DoTdats31i7hW+GR033at/G829/E/rZse1aQSsiBYwSeYkLLn19zIWTypiHHHAOh4BpYVHYJ/Prz9v75BGCSfH/WWBWqQFAquS29cfKyHpf7eNhCu93b2v3xWic1hu4akGM3sNS9glmuhOexsZjWI1mdo7GTUVkr4aWBK7wV26G4HylWdCpT2Qa0G8WaGMHtbAcSK6HoL4RLK5a0cZlemYJ2JefQStaMkx9VYujZa/+Rlvpt0zHeIcXqksnt5Jax4uRIaqAiue5h4ANNjKX882ljOu5mQGz2SWDvUfDm8lXXS8HhbSgt3N6fgtYXJ3K0IyTD7/NIUlt5Cuu07foIvXtPZP3oULmnnKmOFiaLvKSstGrw6T
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(23010399003)(1800799024)(18002099003)(22082099003)(4143699003)(11063799006)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eWJZaVdCMEJWODNVTVE4M285dG9GWStWNWxjeVVUU09IRk56SGxyOU9CRmVh?=
 =?utf-8?B?VnozSUFQbVBFejhvdXRKNWhvWDlNellSRHRzci9mODV0Nlc2Q1lUWXdFZFdh?=
 =?utf-8?B?NTVTQS9zRzdQSzU2NHo2K3oxWSt0T1h1RmpyclJSOFNqV2pNc01id041bUJU?=
 =?utf-8?B?TzZTeEtFdGtlSjRqWmVsTXhVWUE0R0VqLzRRT3VBS2kxQkJZK0txZy9qeGNQ?=
 =?utf-8?B?YlBTY0VNeC9LeEwrU1hRWlE3WGZOTFBXSmI5cDY2bHVBeTJ1VVk0bXE3OHNU?=
 =?utf-8?B?M28vNngvS3BRSUsweXhxS3BsQ3N2d3d6RXQ2Y3JHTzJLOHk5Q3BTQzJ5NmI0?=
 =?utf-8?B?VXY0b1F0OTRSZmluNWpQd1Z2MUpZa2dIVHZ0a1pXM0IyS21PcGUrRnUyN002?=
 =?utf-8?B?YzN6Q0srVURBK2JNTDgrZ1cwSjFJZXM2c0RWOHVtazF5emNUdEJwVkJjSkFE?=
 =?utf-8?B?elVUdkM2UmFzZTAvZjBVMlZoa0ppTkFPcWVwdUdlSlpVeVdSWldzdkVWeS9s?=
 =?utf-8?B?NmJOaTdETTNDTEVtZ0ZENkgzQ0JnYWg3RXJJNEhWUHZVNjdQNnFoaHpxMnNL?=
 =?utf-8?B?VUlBUS8zTFVQNkVqYjJqOTdPb2J1UjRiQ2loVFYwOS9HRUJDS1ZuZktjbkVn?=
 =?utf-8?B?aGlQczN4aCtjMDUvWGcxY2RHWk1HT0VEV1dPV0xuTlZlNVduSDBUS1BPZ2dx?=
 =?utf-8?B?UjVvbTZxT2hrS0hncksxdXVyOGUycXZaQ3pRaWZZUnNUVFRzU21BTU9udVl3?=
 =?utf-8?B?YVY1ejFUK2xnUC9DSWhvV0JPcHRpK2pmWTdjbFEwZ081dXVkN1QwWll3OWFI?=
 =?utf-8?B?WUhUaFZ0NTdIcDY5S1ZmKythRmpaaWZyNm1HYjNpbG1oZGNrZG81VStjY0pC?=
 =?utf-8?B?ditUUUZHRVdXTXBMTm5Yc05zK1BxN0p1R1pXM0tYMmxtUnFZZW1aTkpYcitM?=
 =?utf-8?B?Wk9Sbm9XaEtjWVhXWkZHai9GSU93NGZtUFJSWFg5M29uQUFOcm5nSUs4Mm5L?=
 =?utf-8?B?MkU1em0rallySmNnQ20wUFlBdjBVdVlsbTROWWV1YzBZeTFoQmYwbEFheUZt?=
 =?utf-8?B?SHMrOFBYYWpnRFhPSCt3TjBCeFdwcEtMMVRhUmduK3BudjEwc0VIQVN0SVJD?=
 =?utf-8?B?MGpQVDk2TmFmRmRnb1F5ZzlDOFJjNDZ2L3p6RnBHdzRVamxwdUZKNlc0dGQw?=
 =?utf-8?B?SmErZDluam13dGoxa0gyVVA1TDcyNUV4L2hFSGdSeWU3MFFmUVBCVVM4R2dB?=
 =?utf-8?B?TUR6akdyYTdJZWlRY1VlK2tUVENiQjZCaUFnRWhzQm94YksybVlJallCQ2Rt?=
 =?utf-8?B?cFBieFJRUElYZHkwODFwYndBRjAwTlFCRXNnVTJHbFl2VEgvekxkWlAwQ2pn?=
 =?utf-8?B?N24rWlFVc3NaTTNxbXRNNml0TW9NOXk5bk1VSEtGSUkxaHlHL0thQmp3VFBi?=
 =?utf-8?B?ejRLZng5RmgxL0hydkFvUWNscUxWWlo2RkZ6elFxVnd3cDFHMHZwYWFoVnox?=
 =?utf-8?B?cnV5MkdyTmRVVStDRWlRMUczVnhGdW50ZkJhSTg1aTZnRVNSMnp1VHJCWC8v?=
 =?utf-8?B?amxNYmUxaFJLaGNGT0JxLzJkU3dvK0gwNXN1ZDB3REtZdjZ6dkwydEIvd1Rm?=
 =?utf-8?B?aVVlSkI3MHQzUitNd3FJMytFZTFqMzFBb2FSaGtuT0l1dGU2UXY1WGRKUGkw?=
 =?utf-8?B?TjVzSHRpei9UNmVBRXZpTy9uZSsxQUl1QndvRGZVbitpUE5ndUFsNE1MdWpv?=
 =?utf-8?B?dXVDNGEvOTIxSTc3Qnd1RWU3LytXVU1aclgxQmxReURUV2pRZW13aGFWZ05l?=
 =?utf-8?B?QXRmWDB6eWxialhqRWtJSFhrMm5jemlaTXV0SXQxano1ekkwSjZkbkh0RThm?=
 =?utf-8?B?Z0FtTGpueTcrSWtPQ3J3MWJyOEFaRm9ITithaXlJdWJpT2JxY0NJZG0rUm5m?=
 =?utf-8?B?WWlZU0dHQWwycDQ0YklIVmtCaUFkUkVqbEVYOHdhRmsrOHpxSEhrc3E3czND?=
 =?utf-8?B?T2NXak5tckY5ejJlSEhWd3FIRWtxYUVzSFBYUmlZYVBjMjZZRkk4YlRzeVFP?=
 =?utf-8?B?cGVTMlpFdHVlK0FaWFQxQUpPSjBrSGU2Y2lYU3h3bTdGaERTc0puMTNaVTla?=
 =?utf-8?B?VDFHN0l5bW1KaEtYVWhJeE00KzN4L2Q5N08zc3VLQm1DbUd5MkxQa1JSOGI2?=
 =?utf-8?B?U1VmMzFBS1U0VURKRTg1Sy9lTXoxWGhxbEM0alpHQ1E4Mmljd1lFSkt4bjFl?=
 =?utf-8?B?bXhySVpFN21tK1l4SzMzKzQvRHdEZ2pOWWEzSGIyRU5ZLy9HN1lQVTNRT21C?=
 =?utf-8?Q?3vAghvvMeArWXrolBR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57909a9b-3a8e-4fc1-d1fb-08decc8e41e1
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 16:34:09.7650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k6oLax41ClAq7qboARcvwfRSNssIrM/mTPTN2LRtx71LwiUhwBcxQlmmjRo6qERR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893

Hi Andy,

All accepted, all will be fixed in v9.
On 17/06/2026 16:38, Andy Shevchenko wrote:
> On Tue, Jun 16, 2026 at 02:15:58PM +0100, Salih Erim wrote:
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
>> +static void sysmon_supply_processedtoraw(int val, u32 reg_val, u32 *raw_data)
>> +{
>> +     int exponent = FIELD_GET(SYSMON_MODE_MASK, reg_val);
>> +     int format = FIELD_GET(SYSMON_FMT_MASK, reg_val);
>> +     int scale, tmp;
>> +
>> +     scale = BIT(SYSMON_SUPPLY_MANTISSA_BITS - exponent);
>> +     tmp = (val * scale) / (int)MILLI;
>> +
>> +     if (format)
>> +             tmp = clamp(tmp, S16_MIN, S16_MAX);
>> +     else
>> +             tmp = clamp(tmp, 0, U16_MAX);
> 
> Double check that minmax.h is included.

Accepted. Will add <linux/minmax.h>

> 
>> +     *raw_data = (u16)tmp;
>> +}
> 
> ...
> 
>> +static int sysmon_supply_thresh_offset(int address,
>> +                                    enum iio_event_direction dir)
> 
> Make it a single line. OTOH why is 'address' signed? Perhaps u32?
> Or for some reason unsigned long as per _alarm_config()?

Accepted. Will Join to one line. Changed to unsigned long for 
consistency with sysmon_read_alarm_config() and sysmon_write_alarm_config().

> 
>> +{
>> +     if (dir == IIO_EV_DIR_RISING)
>> +             return (address * SYSMON_REG_STRIDE) + SYSMON_SUPPLY_TH_UP;
>> +     if (dir == IIO_EV_DIR_FALLING)
>> +             return (address * SYSMON_REG_STRIDE) + SYSMON_SUPPLY_TH_LOW;
>> +
>> +     return -EINVAL;
>> +}
> 
> ...
> 
>> +static int sysmon_read_event_config(struct iio_dev *indio_dev,
>> +                                 const struct iio_chan_spec *chan,
>> +                                 enum iio_event_type type,
>> +                                 enum iio_event_direction dir)
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int imr;
>> +     int config_value;
> 
>> +     u32 mask;
>> +     int ret;
>> +
>> +     mask = sysmon_get_event_mask(chan);
> 
> Just make it together, as we don't validate the value of 'mask'.

Accepted.
> 
>          struct sysmon *sysmon = iio_priv(indio_dev);
>          u32 mask = sysmon_get_event_mask(chan);
>          ...
>          int ret;
> 
>> +     ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
>> +     if (ret)
>> +             return ret;
>> +
>> +     /* IMR bits are 1=masked, invert to get 1=enabled */
>> +     imr = ~imr;
>> +
>> +     switch (chan->type) {
>> +     case IIO_VOLTAGE:
>> +             config_value = sysmon_read_alarm_config(sysmon, chan->address);
>> +             if (config_value < 0)
>> +                     return config_value;
>> +             return config_value && (imr & mask);
>> +
>> +     case IIO_TEMP:
>> +             /*
>> +              * Return the administrative state, not the hardware IMR.
>> +              * The IRQ handler temporarily masks the interrupt during
>> +              * the polling window; reading IMR would show it as disabled.
>> +              * temp_mask bit is set when administratively disabled.
>> +              */
>> +             return !(sysmon->temp_mask & mask);
>> +
>> +     default:
>> +             return -EINVAL;
>> +     }
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
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     u32 ier = sysmon_get_event_mask(chan);
> 
> Here you call the variable 'ier'. Please, make this consistent in the related
> APIs (see above).

Accepted. Will rename to 'mask' in write_event_config to match 
read_event_config

> 
>> +     unsigned int alarm_config;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     switch (chan->type) {
>> +     case IIO_VOLTAGE:
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
>> +
>> +     case IIO_TEMP:
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
>> +             return 0;
>> +
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +}
> 
> ...
> 
>> +static int sysmon_update_temp_lower(struct sysmon *sysmon)
>> +{
>> +     unsigned int upper_reg;
>> +     int upper_mc, lower_mc;
>> +     u32 raw_val;
>> +     int ret;
>> +
>> +     ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &upper_reg);
>> +     if (ret)
>> +             return ret;
>> +
>> +     sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
> 
>> +
> 
> ^^^
> 
>> +     lower_mc = upper_mc - sysmon->temp_hysteresis;
> 
> Either add a blank line here, or remove the one above as these three is kinda
> semantically coupled.

Accepted. Will removed the blank line, the three lines are a single 
conversion sequence.
> 
>> +     sysmon_millicelsius_to_q8p7(&raw_val, lower_mc);
>> +
>> +     return regmap_write(sysmon->regmap, SYSMON_TEMP_TH_LOW, raw_val);
>> +}
> 
> ...
> 
>> +static void sysmon_unmask_temp(struct sysmon *sysmon, unsigned int isr)
>> +{
>> +     unsigned int unmask, status;
> 
> As per above perhaps name 'unmask' as 'u32 ier'? Or did I miss the use case?

Accepted. Will rename to 'u32 ier', this is the value written to the IER 
register, so the name fits.

> 
>> +     status = isr & SYSMON_TEMP_INTR_MASK;
>> +
>> +     unmask = ~status & sysmon->masked_temp;
>> +     sysmon->masked_temp &= status;
>> +
>> +     /* Only unmask if not administratively disabled by userspace */
>> +     unmask &= ~sysmon->temp_mask;
>> +
>> +     regmap_write(sysmon->regmap, SYSMON_IER, unmask);
>> +}
> 
> Also looking at all this, please double check variable names in all functions
> and make types and names consistent across the whole driver code.

Accepted. Will audited. To be consistent: 'mask' for the event interrupt 
bitmask in read/write_event_config, 'ier' for values written to the IER
register in sysmon_unmask_temp.
> 
>> +     }
> 
> ...
> 
>> -     num_chan = size_add(num_temp, size_add(ARRAY_SIZE(temp_channels), num_supply));
>> +     num_static = ARRAY_SIZE(temp_channels);
>> +     num_chan = size_add(num_temp, size_add(num_static, num_supply));
> 
> At glance I don't see any additional arguments, can we introduce num_static in
> the previous patch to reduce a churn here?

Accepted. Will move num_static introduction to P2.

Thanks,
Salih
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

