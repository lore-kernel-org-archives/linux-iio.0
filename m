Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012068.outbound.protection.outlook.com [52.101.43.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8072D73A0;
	Sun,  7 Jun 2026 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780871370; cv=fail; b=JAAp5GelTRyMBR1o5ogJXwrnKc7PlxLFOpKm3mvk8p4xVs5qOrCMpXjGHukROGikxE4oj4nZ8XjSaIL6BR/k1wpBjLl7E6VzAUA0IOmOUAb+DPHIgXtf6TXkujAhCMZDxfIgejGPrRpZd4ZAdIXdRflHNAdwsErNe4kTIulHr2Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780871370; c=relaxed/simple;
	bh=S3ZhNAb/Pkmk/QDKX6NzvhGbE9ZGtAlDeZ0BGmBbhkA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=kzCp9ZFjw4TNrVYoVU0KojODdFd45NpRIV18eDwn5w1iYFMLKbkJwKx3Bqiv+It2sLO2BNpyczqhihUCrMlsN/rjnwUjxzUZOGKg+WbsxjOBW+j+xt5yHxEomowUWXRT0/68QdyQR5C78oVti5As9AD76Fc4AGsJ+4j47OTmsgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0k77a6YH; arc=fail smtp.client-ip=52.101.43.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0k77a6YH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f1C/mmjzQM1f/muj4Uzsl9BOIt2uWD2UA/z57zQGzmjfjWzbLh5bapcqvjcyipoIiBm35MTWILhvCmg0BYqQPIfJa8ilRF4g8/iEkVKmr2oPsM9JCjI5Tl3deyXuQ6jPHZ5pNxLKVU1oQxY3zgnWzG96oiNm5SSToda41WSTpg+98vzFUkBtBRWnQRNHG32LMQTlLv/15rgoX8efoQiZ56yRA4wjtXjWV8HBA213LAv1SaHY8xue1uqRVl1y+bD64SmZ5uz9yx+1fsashINTuq9zAVk/t6T5looev8QDmS4kwS8jyXaSTSlZZGWMeA8Yei+zdw2agZiubfL/glqBew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pBnHzk81RWuLNnqFMQ7mYSADMZ/RK8eqqzJvyRgcmJw=;
 b=oaNtyS+Iv8yU9WVeG+vdVWqUhMDzHhGGZGDcB6cyqgcI4o4YXs1JyVx2cbetqK/SKKsC9ACLA5u7Q9YDCAlBz6lNBg2ZLWYDtS+x9d+EV2dWf7P2gxoehSVZohMwVT9E5b2143HljahOegWcIZ6WPpy3jLzBN/77UNWKOuRLhHyNBn8Gepm7Xp+H5EemI6VG7McBEcK+7vH8A2JcCQsjyLjCxnTJxY2lVhmRbGad8XByXpjYZvhFHg91c2XsHEPvbqDlsTp7KDF2+1aPQ8Pm4VDRcsHiuwjqHkaJcU75tyspiwoBXZ8dTThdwijjF6vFKt8S+ZsbwNXdkSrUxxguew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pBnHzk81RWuLNnqFMQ7mYSADMZ/RK8eqqzJvyRgcmJw=;
 b=0k77a6YH1FxFM5V3w+e0dcxExrKWSjy7iEZKJNJ4YQWwIbZ8jh3d4oAriEWDs3gSdG/YggFV7IquPxA6DhlixNw7H3yijYsa8TjFQwlD0XTYfbmm6uWOzhXuOuA/BgCG4fTO4CVDlyLbh1nrvIPKXhEKSG1oKZhmqL5G/Xbh3Go=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 22:29:26 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 22:29:26 +0000
Message-ID: <3a550d80-b4e5-4e94-ab11-cddafad023c2@amd.com>
Date: Sun, 7 Jun 2026 23:29:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] iio: adc: versal-sysmon: add oversampling support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Andy Shevchenko <andy@kernel.org>,
 David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Conall O'Griofa <conall.ogriofa@amd.com>,
 Michal Simek <michal.simek@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Salih Erim <erimsalih@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260606051707.535281-1-salih.erim@amd.com>
 <20260606051707.535281-6-salih.erim@amd.com>
 <aiUi4jRd2C8kczkt@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <aiUi4jRd2C8kczkt@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0048.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34a::20) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 897b8b1d-6db4-45e2-749d-08dec4e43bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|6133799003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	UQLzRAncHdaqqRbkG87m+yluRRGPuDwbWVg3HeSdeysqHicH4TJJEQckSsdcW0O3V6OLhyw3FsOw9y/JV4jr1EzX5mUKY8qlZVU6RZwNWcln3/m3DYihq7MpNmA236eyOfeOl5XhSQOhDM4/jB5CvLvRR34s8cWGA0373mQ7xErfmBKSgkSWcM1XLOMU9h7BMhBtcSRFocnpg6gue2FqNZ7evo1+9V/CZ6MusmrtXOgK+utqcW297HCW7Ajcmjt1CZqjPEnpTPEHUS9f6rIsXki5jdPu+eaAj3hXeaZd2E2TMzL7n6l7fJ746YRvGPisPAVfM2346DOXFg4sms/WI+MbFQbMqWeRnOphUmsO+UV+U7ivsIW6aOK4EB0Zso6tSv5LOsnLdl2vPXI5ulQO88wEiGow/88X/ulkVJ8lcPGsh0kxBgKukT8nsDjMf9MAOhiLGL+Ar3vvCaQLB41JJG/JLIGqdxZ4uGyJA1VVCEOaE0etOzlf2uNXGi4OcK2Sf6FRhXdY/D4Fqxs7LD/H/yFaSA+fY1QvOYGJDGTCj+5y+ufH3pifgWFIftUdpdZXpIcJTY/PW/zLyK0u5mNNqMQYg4WmIQoPAGPkCUvM1cZrpQAcdW93xeaM1wp67Dn7Aw4sd/kcEEfa3+R+TfwQzFUnPn0qjJ65UvdGGhWXwTfEVtTRtMO3qlqExupkttZM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(6133799003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZzhQdVhNMXQzdkVLR1RzM3hKM3R5elQ3SXRDQmtvTHVNdU4xNnBiZitrbE56?=
 =?utf-8?B?dTA5Tzk3WDYyUUJDMHo2cnN6a203R0ZNZ1h2VFE3Q3c4L1lxTGlOdFkzalR0?=
 =?utf-8?B?QktNQ0N2RzM0NkNXUlRkamd2WncwdjVhT3V1L2xJQk9qTFBWVmdNWUs4ZS9U?=
 =?utf-8?B?dGpiSitUdzRralI4SENJQzhKU3NKMkdrVnpOQ1VxWW9ESEpkaG9ybGxIVnYy?=
 =?utf-8?B?VGliK2RUWE5JUkt4MDJuOWtpdEc1UXdERWxLS2tybzJYR2dSbGx4a3I0RmN0?=
 =?utf-8?B?b0NuZVRuSk82Q09TT1crc3hFd3FGdU5rTEx0ZWxBR3RIRGc0U1hENlM0enpS?=
 =?utf-8?B?cjZKS2RIZ1IyNWJ4SUJyYlpnclZyV0F2RkhEN3plTVBUTjFFZXFWaTJwUm9l?=
 =?utf-8?B?QUtFSU1YSFlHZnJ4aUYyYVhRWVhHVG90Nis2ZWNpOXlPdU44MEs5YTY3RW9U?=
 =?utf-8?B?K0hLR3gxbkt6ckh6eTZOUmp0SVVaU0dDbEdIc2pXSmcrN0VCRFVOVkQxUDlQ?=
 =?utf-8?B?YjRvNnJOMFhCdzV1b1o2clBSbVI5MTZpa05kL3RVVytGU1pTR29yMm9TdFYr?=
 =?utf-8?B?WWVYMXZDY3ZjKytsckJjdGVuclJYN3lSc0E1SXlGTkF3VTFQazRxSXppdlY5?=
 =?utf-8?B?Q1lLamxaVnR6cjJnRlhMZzR4cmRyaDhJMzFuMmVwWWV2M0todlRFR2ZERmtM?=
 =?utf-8?B?Q215VEV2R0dJakZsbDJaOGNScjBubWRlSnN2TVVHMFU2MTRxV3dmWkZQS0U5?=
 =?utf-8?B?SWxSejZyYnBhdzVCNVBGYk51RVB2bUpTVnNacTl6QWJGT3k0cVR5a1dkK05t?=
 =?utf-8?B?c0E2enV0NTFnWmYwcVpoY1I0SVJleU1vdWRyVGlJV3FwQ1BUaGhhTnNiRjVn?=
 =?utf-8?B?OXBBNE50SmhkY0hHYmUzcWRZUWRNblI4THBiUS81NWFCYWR4MzFyZmx5aTlU?=
 =?utf-8?B?R3ZVQ3VvbzZCRFJlcjNzaDI2SnZpckVWZ21abG93TDd2STVMUWoyU1ZvSDlO?=
 =?utf-8?B?VUZjRlZXU1pwY3djUGRvV3N1WE9BUVQ3cTRYcFp6NDFxTFRUZkdQOHpqbG1w?=
 =?utf-8?B?RXBLa1htazFQdXVQQmJKN0VXcklnMm5NeHQrQ2t2VXdoN0sxcWdBWGVEUnVG?=
 =?utf-8?B?SkttdzVoZDh4bWVqRzRKdzJKWVZINnprdmQrd3dLK0ZaQkM1aWtITDBjSG1O?=
 =?utf-8?B?T0ZoOTdGeWpKRnhnQy9mQXpyUlVvWXViMDBvMHJtL0I0dE9QUzlUbzc4K2xl?=
 =?utf-8?B?cDVMdXpmNGRKZGJ5RzM1SmNyZGhjSWxhcmFrcXpndDBaMWRhdi9BQm0vdTB0?=
 =?utf-8?B?akdQL3Z3WUU0TjF3UUJQZE1XOTFIL2Y4dDRwZkpJSjNRcWV4c3U4VVNvdkQv?=
 =?utf-8?B?VnYzc3dRTnNzRlErOHFQRHZ1Q01McjRtNW1md2YyS1ZoZlgrdUpoU2FzWUQw?=
 =?utf-8?B?WDVOM0tJUHU4QjBrTWN4bktjbEZyeVJZbzBhZkx0ZHkzVGtHM1puNGo0ZEhU?=
 =?utf-8?B?VU1yeEhPNnp2UlZ3ejNIdWl6SUpFUnl0NEpwL1VkVUN0cnlNVVNnZVErNFAw?=
 =?utf-8?B?UlNyeEhLMTdmYUtGZG05eXQwalhJRkZBV2U5ZndHUGxPUFk5ak45Q0tRV0wx?=
 =?utf-8?B?aHZpc0VRcklOYXlwYkZMdFRsNkVuY3EySWVUbHNRRUFBWnhQV2V3VEZ4RkFU?=
 =?utf-8?B?MWNtZERoQUtTdWd0K2R6VStteWRvdXFnL0l4ZEZhb0EyTDdlQ0J0WXhSTytp?=
 =?utf-8?B?SFNkWjFPcXNYNUFyMlVBbEMrN2JHSzZCMHBsWnh5N2FUaElmMzFFZURDd0tL?=
 =?utf-8?B?S29BR0pIdkMvOFlnU0o1bUkrbTFVR0tqYWJCV04vSFREVExlTVZVUTlubUJn?=
 =?utf-8?B?UEZzNFhOMW5kN1pZVXpEVXNIVStENy9Cc0pna3NxL0dWU0dscDJKaTJJTFNr?=
 =?utf-8?B?WmRQbjEyUk9kbFZvVEZONGE1YzRQcTc3SWw2dnNSVGVZc2tZTm9KZ0tHUXk5?=
 =?utf-8?B?R1UzZ0VPS3RuanE2NTZObHY5MlBWcnF0dHVJK2FLbDJvU09DOTU0NzZJWFhW?=
 =?utf-8?B?eHBlUmFPb2R6ZHhRYU52eHpZeWRKSktvL3Ztb080WjRCMERVcXNTUlhvRUxU?=
 =?utf-8?B?MG1pM1d1Y3IzWGV3VE1zYnp2Q1E4QW81ME43a2NTS0RWZllub2NqL0UwaEky?=
 =?utf-8?B?OUYrdjdWaU5LOGgvSHdtcVVYc2I3VDF5V2E0bDluRER3TU5rQzZWdGFXMUlz?=
 =?utf-8?B?RHhLY01VTG1LdzdqNVo1cEllbkxmY0tNdXp1VzM3YStmVEtpWjdVaTRLb3A0?=
 =?utf-8?Q?v7/p6Z2CpEaTnJpcNY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 897b8b1d-6db4-45e2-749d-08dec4e43bb8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 22:29:26.7761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qKrf8+0l6noK2Wnhig8ke2DCgOXGUFqkra31JVypFk9raRsnIj7LCcDYPArCv59P
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407

Hi Andy,

On 07/06/2026 08:50, Andy Shevchenko wrote:
> 
> On Sat, Jun 06, 2026 at 06:17:07AM +0100, Salih Erim wrote:
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
> 
> ...
> 
>> +static int sysmon_set_avg_enable(struct sysmon *sysmon,
>> +                              u32 base, u32 count, u32 val)
>> +{
>> +     int ret;
>> +
>> +     for (unsigned int i = 0; i < count; i++) {
>> +             ret = regmap_write(sysmon->regmap,
>> +                                base + (i * SYSMON_REG_STRIDE), val);
> 
> Unneeded parentheses.

Accepted.
> 
>> +             if (ret)
>> +                     return ret;
>> +     }
> 
> Also you can use temporary for regmap
> 
>          struct regmap *map = sysmon->regmap;
>          int ret;
> 
>          for (unsigned int i = 0; i < count; i++) {
>                  ret = regmap_write(map, base + i * SYSMON_REG_STRIDE, val);
>                  if (ret)
>                          return ret;
>          }
> 
>> +     return 0;
>> +}
> 
> And use this trick in other places where appropriate, it makes code easier
> to read.

Accepted. Will use a local regmap pointer in functions with
repeated sysmon->regmap access.

> 
> ...
> 
>> +static int sysmon_osr_write(struct sysmon *sysmon, int channel_type, int val)
>> +{
>> +     /*
>> +      * HW register encoding is sample_count / 2:
>> +      * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
>> +      */
>> +     int hw_val = val >> 1;
>> +     int ret;
>> +
>> +     if (channel_type == IIO_TEMP) {
>> +             ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
>> +                                     SYSMON_CONFIG_TEMP_SAT_OSR,
>> +                                     FIELD_PREP(SYSMON_CONFIG_TEMP_SAT_OSR,
>> +                                                hw_val));
>> +             if (ret)
>> +                     return ret;
>> +
>> +             return sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
>> +                                          SYSMON_TEMP_EN_AVG_COUNT,
>> +                                          hw_val ? ~0U : 0);
> 
>> +     }
>> +
>> +     if (channel_type == IIO_VOLTAGE) {
> 
> Can channel_type be both TEMP and VOLTAGE here? No. Why do we check it twice?

Good point. Will restructure to use switch or if/else to
make it clear only one path executes.

Thanks,
Salih
> 
>> +             ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
>> +                                     SYSMON_CONFIG_SUPPLY_OSR,
>> +                                     FIELD_PREP(SYSMON_CONFIG_SUPPLY_OSR,
>> +                                                hw_val));
>> +             if (ret)
>> +                     return ret;
>> +
>> +             return sysmon_set_avg_enable(sysmon, SYSMON_SUPPLY_EN_AVG_BASE,
>> +                                          SYSMON_SUPPLY_EN_AVG_COUNT,
>> +                                          hw_val ? ~0U : 0);
>> +     }
>> +     return -EINVAL;
>> +}
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

