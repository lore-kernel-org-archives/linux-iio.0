Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012006.outbound.protection.outlook.com [52.101.48.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6623672AB;
	Thu, 28 May 2026 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006351; cv=fail; b=aIegk0iPM4ydIWwshlleUoa/NwuwDc0wfoqJL6vCIVJCWu7a9HIgs/EsYHdTa0OLk75QH5UeIskarYzuo5wkBJv5qsBYBenj896x22AgOuBhclL3aigRK/woeP3Dn6rff/sMu1I89dt6BZPepfM3HDQV7oMF/foWOLVcZm77LHA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006351; c=relaxed/simple;
	bh=TdsEMFN/ExIRezDsmIlpS6paX/a74UiOped79HybJ0Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iM2BVMccFO012pakV1vjwGIkI49HzO0+5kCvZnXxQawhS5eEkAtXQ8789a1boPT/Ldl4Io711+3BwWhe2KsszM5BN+m2OcywLrz7bb6kORhE8YMbvtNB43uiLZBv/YpOV3jO+A36/9o3PlNb4wJoKHX9xirxLFsl29otg4uXzow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uMXVhm/X; arc=fail smtp.client-ip=52.101.48.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uMXVhm/X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HEpOkvtQNUOYsffVe+51E4saIMnEndlYD7vkTCIvXatz3S7xgv6Qjni8bxEmU01zRQaOoG+/KgEjHBrkYx4PTrLZ8N1ak3aIP4NW/6O5jNoIW/CjOtMhRWh0sdGKGkjc2OnimS45pm3Cg5ZgzEzPZWvoGUlHDUEGsMblIKr+jU32XsRb48wIMYoL5Ep+MwNL2ETs5/RQL6eRHfkrW2Q/TVtYEk+WXq+Vh/PAvqyDn7e5FeWyBKQ0N1w/7oxjrpLfo+58+xoagf0mskTNEt9vROjM1a/fFSquU3BdrVm1kmgvsd0a+eOVDFrOG4c0z8ARIEa+FckYoVdkQ5ZjXQvp0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fC0I4R+ymKFg1g282WpfjPQ97ICzC24RkJzIZirkMD4=;
 b=svKSHixxJ4J3o7bT4IrhTxcOlXoDjQnG2hbmbsO4dGgwcPpT8aS9OEHp5haMZduViVHmFltqVDx63w9uKbMW9KpbkcriHeCAbPhI8ju0oyWPitAMI9CIXQcnTAl8/cdoSfS7OTmFHhvV8V97OBjJpHuhHnH+CDzAplmVGINQIncMwPB0vx3WYqHj0RnPdEOan+4wDb42RlWlRWbP53Pl3IebjpoHBvlPHMYh6It19fZYgvuWzHTjon/YgUdwYJl4voQq8TLzhHvc7PMm39ImN2tA/AGDIFYlYPvLj+0OTQeiT4B87aMHKmFnibZPaibWFe8a53SlDNRhsgRYniJfOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fC0I4R+ymKFg1g282WpfjPQ97ICzC24RkJzIZirkMD4=;
 b=uMXVhm/X5Q7Sq/ye2RgK+8vuV/Cj49mSTKGDLcH8alcuJSXcKe9TlL2d3zS5TfErHoLRNzz5ubYA/hQ0Gu7tnrhlMSMKrfPr/tNYNny7qGcVjIRdJIPzJXZVzwK+T8lILQKfnY7x4tLfqsrcCjxyKITjPxMAf0uVouLq+yCEzsE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 22:12:26 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 22:12:26 +0000
Message-ID: <45456430-93d2-4674-bd5b-24808dbb56a9@amd.com>
Date: Thu, 28 May 2026 23:12:23 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] iio: adc: versal-sysmon: add I2C driver
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
 <20260527114211.174288-4-salih.erim@amd.com>
 <20260528134211.259d8c19@jic23-huawei>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260528134211.259d8c19@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0382.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::9) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: c854f240-eb74-40ab-eca6-08debd063324
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|17096099006|18002099003|56012099006|11063799006|4143699003|18096099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	ZAuRT3t90jR1lK2Z3tMPTaA0+fTq0VEdGB8I9VJPDMAGZ/fYFDDu3g+I/0bfWJLFZ6BaCCYPgfIZAYBgf2grG5ozp3VZ1/tYAOV1goUijN53EWoUHpJc1nhG9u1+wA4oJtSchR/1c9OJJWrcQTGS2fgHEKWL1S5rnKQdWTgp6LqhNpPneYI++8KkYNiwd7vYBtMNGJgE+wCxDWEN+6e1oWb9Jo699cbf/WwFE88LI0mQduS54pmbq7CndTAl+Acoo5PT+ir4+3V21MIEuZeZgaAWnuwrxTwDLEugvf+L6K9L9PTAav0kIcmVytWYPzeeXgM8u8MINLPw8CvujNZFINqHKvFQ5SZs1oU1+Ksu5iZL67BFNuwK+Tw7IyeXk7D9o+UqWR54W8CqUvbUR8QgEDzoNsCXqs6ohBCI2L8asGq3Gluz9NbeIxy0/onBK1cFid0p/9IXs8QO9NV1t4qVeYmz7p2kP/EYv/41C8XL2IVAL5wc73j+9cRbWjJafEUqVcLPePWygJ3rpBXbONaH4hyIhNWNumsYrjeZKHTmHGi7P0nD09ePmoXVw81mECMzSM4zS9wQJus5mABXr95vG8xN3SSb5ZPKR+q9rbhar82UW466utRQf8xUMX0zdObYkif72gVUKsfobozAZTmWSyRRP5VmQh5jNhXcCNYy+p0AdlH/Ie5fr0DSO3+pFFdN
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(17096099006)(18002099003)(56012099006)(11063799006)(4143699003)(18096099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q2J1NHBwSU5Hd0UycnNnMWNDRGt3ZnRKZHZBS3Q4N1dKTEFBTE1tb1BQWWVp?=
 =?utf-8?B?R2NDMWRROTZaajBzSWtVWFpBVDdXNm0wOGFJUDYxQjFMdGdOdEpvcTNUYXQr?=
 =?utf-8?B?TGhSYkdHa2JQUVk4T2pJb0xzeVBheGNTVmJvdTNja1p6NkVvSkltV0ZQZFFZ?=
 =?utf-8?B?OEtuOENJQnlyZnFwU0NISFlLSktCR2UzVzk5Rms1cHpCdEtobUtldE92SVhD?=
 =?utf-8?B?cnhZZHRRZFJxUXpIUHZNWTRuaUloM2JsVG9wai9YZVUvaldvMVpaNWc0Tmx2?=
 =?utf-8?B?T20wY0EwMnAyL3F4UEpicTBPbGdXVDJuRWtjNkdJMzlJbUN5NUdCR3pGano0?=
 =?utf-8?B?ek50eDRScWdzZ3p0dVNsQVNZZS94aWVORDJQVWx1eVlvb2ZaeUNKSzFVVHNZ?=
 =?utf-8?B?WWluUTBCN1R0Tkd1bE1jUkxveHBxTHcramhlYU9FZ2VNNDNRdmlFQndib3Ex?=
 =?utf-8?B?aWo3RTFGUGlDcmFxUHIxMGZGQkthZ1NJRk84ZDN4MnZDUW9wUlNUTVI5ZXZh?=
 =?utf-8?B?TksvNWtIZy9icFEyb0xBNVNiZTVhWE9qTElJL2xEWS9mYVo0dnJUQmN1d3NC?=
 =?utf-8?B?UlR2UCs5QjB6OGkzOGdrOUZLTEg5cFNWQS83N0QwQzNwaGxESFd3bVhwcTVn?=
 =?utf-8?B?dmljNFE2M0RTeHQvZXlBWk85NmE1OUxXcHB2YUlrYmZkUmRjMnBVei9WbWta?=
 =?utf-8?B?VG9aSlBOOVpDbERqR2tyc0pBMXZKSjlnSXVybDdSSXBLd3J6SmJ2cXNhNGpQ?=
 =?utf-8?B?b0lJeWx3Z3VLbXVLMFNpSUd3LzJ2OEIvOUdkdk8wNGNUUS9wd2ZEZkg4V04w?=
 =?utf-8?B?OHFrS1Z2ZkFIU1FzTTlka3AvZjdLSkpOWGx4QndTWjEyTlUxQTVla1ptMmR4?=
 =?utf-8?B?cjBLbklBZDVRaGZyRFRQNS94MnlaWHhhbnRwZGZwYzVSTldzNUEwVGMwd3ow?=
 =?utf-8?B?UUt2eDZ4SFg4djAzbE5ueXNyRGJDa3FUUTZvWmJCUW5ad3hrRHNFeDhnYmJL?=
 =?utf-8?B?VGV1UkY5SERxUyt0T3k1MXY1UmdUVXJBeTROa3BYTGpaOVBWVnFJY1hsbnlp?=
 =?utf-8?B?d1lVc05URVMxWHBQZmNWd0dTTnlURzVJeUd3YmIvSndmTjZuTVZKZkRieUhx?=
 =?utf-8?B?b3RSOFJrclhxUUovamFUYlN1ZUd3SEhlcXdoWGZEeG1ra0hHMGtja3ZmMmZu?=
 =?utf-8?B?ekFXVSsrN1RWQXJIeERZQW5OYU9DTzJTZDhsT0F4d251dzNTNXN0alZMZEl5?=
 =?utf-8?B?d25TNVhDcXNrSmhjRkhudm5GbWRHaXlOdHRQV2ZjYnlXR0J0VHJqQlFPSy8v?=
 =?utf-8?B?azl3QmhGdWQvMmFRdENzcDd3SGk3azdBN2VJTEtjeG9idVZ0ci9rb1g4SnpG?=
 =?utf-8?B?Nmx5OUIwODFMd3QyUy9wRVhTVWh5MHczdVhuNzNQYjNVNGZvYndxR0xXczR0?=
 =?utf-8?B?NlA1WXVjOUd4YzRmYW5LZUhiVGJiWlhESTk4TXlvQWtIeGtFRytCSklkZi9t?=
 =?utf-8?B?K1pvL05sUjJ6N1B0a3lTRnBiTG9OcUtyS1VYS3F4SzBuc3QvQ0FUb2xjNzdw?=
 =?utf-8?B?by9jUjNHS3pCT1E0N3JudGVIcXpqY0txMk9wUkhLbXFyWUtQbFRicDY4QVA2?=
 =?utf-8?B?N3lSbHJuZ3lBOWR6OWppMjl4WjNRbjJGdXNGQ1FIdWoxKzRxaldqU1lZVDFu?=
 =?utf-8?B?OFJOT3psUWVuTTJRMHgwZnNnMGRRRDRHTnJCRDdzZmsrV1pST0NMcit1RUs2?=
 =?utf-8?B?VG5kOVZQYjZ5dzdIOFFhSFAwdEZsWTlSNitaYW01VUZFK1pSa3ZyUUJid2hY?=
 =?utf-8?B?ZUdOdTR5VkNQN2NZejcrZ0g4REhDcmpQZDN5OUpjd1dPRmFrcll4QnV2YjF5?=
 =?utf-8?B?cGpQUVdlZjlRdTdwZ0FYMzZhSUVoVkZ0VUp3SGxhNmY3YVdmeTM3N2sxQWhP?=
 =?utf-8?B?QXBZTnZJZHdxcTAySTJsWDA1U01aYzBOcUc4b0NRMzg1ZlhWdldWaXFNaUw1?=
 =?utf-8?B?OTVVL1ZxTklMVlJ5U2ZkY05lbmtmTHFyclBEYk9hSnJ6bmhwSUNnc1lFZlZW?=
 =?utf-8?B?UFh3NERuZkJZSzlxOUpDNFVjMENwNExNdGFkR2xtZGtycmJBMFRPV0N6eStE?=
 =?utf-8?B?UlBhc0ptK0JMcHU3TGtFL1dQZU9QUkRDbUp5Yks2NGJqR2U1dzE4ek5DUkp4?=
 =?utf-8?B?cFM2WncrejVqcDRWcjJxTlowQnFtWks3RGJQb2ZkREl2Z0ZUMElUL0hqK0dI?=
 =?utf-8?B?dElrVzBEWDJOZEtRVUxxR1VFUUlXNlF6SkNBbkZIaHRrakY3cGNIQnQ4VVhn?=
 =?utf-8?Q?d4s7nQ0CPv4jf6n3lw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c854f240-eb74-40ab-eca6-08debd063324
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 22:12:25.9923
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jyNfoprVhiAPWYot7zvWP2YngtVQavft0kgLXhfxgoyOXT/trDVO6NKbuaV2h+Nb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414

Hi Jonathan,

On 28/05/2026 13:42, Jonathan Cameron wrote:
> 
> 
> On Wed, 27 May 2026 12:42:09 +0100
> Salih Erim <salih.erim@amd.com> wrote:
> 
>> Add an I2C transport driver for the Versal SysMon block. The SysMon
>> provides an I2C slave interface that allows an external master to
>> read voltage and temperature measurements through the same register
>> map used by the MMIO path.
>>
>> The I2C command frame is an 8-byte structure containing a 4-byte data
>> payload, a 2-byte register offset, and a 1-byte instruction field.
>> Read operations send the frame with a read instruction, then receive
>> a 4-byte response containing the register value.
>>
>> Events are not supported on the I2C path because there is no
>> interrupt line and the I2C regmap backend cannot be called from
>> atomic context.
>>
>> Co-developed-by: Conall O'Griofa <conall.ogriofa@amd.com>
>> Signed-off-by: Conall O'Griofa <conall.ogriofa@amd.com>
>> Signed-off-by: Salih Erim <salih.erim@amd.com>
> A few minor things inline.
> 
>> diff --git a/drivers/iio/adc/versal-sysmon-i2c.c b/drivers/iio/adc/versal-sysmon-i2c.c
>> new file mode 100644
>> index 00000000000..92d149f517e
>> --- /dev/null
>> +++ b/drivers/iio/adc/versal-sysmon-i2c.c
>> @@ -0,0 +1,153 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * AMD Versal SysMon I2C driver
>> + *
>> + * Copyright (C) 2023 - 2026, Advanced Micro Devices, Inc.
>> + */
>> +
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +
>> +#include "versal-sysmon.h"
>> +
>> +#define SYSMON_I2C_INSTR_READ        BIT(2)
>> +#define SYSMON_I2C_INSTR_WRITE       BIT(3)
>> +
>> +#define SYSMON_I2C_DATA0_MASK        GENMASK(7, 0)
>> +#define SYSMON_I2C_DATA1_MASK        GENMASK(15, 8)
>> +#define SYSMON_I2C_DATA2_MASK        GENMASK(23, 16)
>> +#define SYSMON_I2C_DATA3_MASK        GENMASK(31, 24)
>> +
>> +#define SYSMON_I2C_OFS_LOW_MASK              GENMASK(9, 2)
>> +#define SYSMON_I2C_OFS_HIGH_MASK     GENMASK(15, 10)
>> +
>> +/* Byte positions within the 8-byte I2C command frame (HW-defined) */
>> +enum sysmon_i2c_payload_idx {
>> +     SYSMON_I2C_DATA0_IDX = 0,
>> +     SYSMON_I2C_DATA1_IDX = 1,
>> +     SYSMON_I2C_DATA2_IDX = 2,
>> +     SYSMON_I2C_DATA3_IDX = 3,
>> +     SYSMON_I2C_OFS_LOW_IDX = 4,
>> +     SYSMON_I2C_OFS_HIGH_IDX = 5,
> 
> With changes suggested below I think you only need the two base
> offsets and the final one.  As such maybe 3 defines makes more sense
> than an enum

Accepted. Will switch to defines.

> 
>> +     SYSMON_I2C_INSTR_IDX = 6,
> If you do keep an enum, it would be good to add an entry for the final
> byte to give some indication of why it is 8 bytes. Even if that is
> reserved0

Switching to defines as above.

>> +};
>> +
>> +static int sysmon_i2c_reg_read(void *context, unsigned int reg,
>> +                            unsigned int *val)
>> +{
>> +     struct i2c_client *client = context;
>> +     u8 write_buf[8] = { };
>> +     u8 read_buf[4];
>> +     int ret;
>> +
>> +     write_buf[SYSMON_I2C_OFS_LOW_IDX] =
>> +             FIELD_GET(SYSMON_I2C_OFS_LOW_MASK, reg);
>> +     write_buf[SYSMON_I2C_OFS_HIGH_IDX] =
>> +             FIELD_GET(SYSMON_I2C_OFS_HIGH_MASK, reg);
> 
> I'd guess an unaligned put works here a well? though you'll need
> to do a FIELD_GET() to extract the slightly shifted content.

Accepted.

> 
>> +     write_buf[SYSMON_I2C_INSTR_IDX] = SYSMON_I2C_INSTR_READ;
>> +
>> +     ret = i2c_master_send(client, write_buf, sizeof(write_buf));
>> +     if (ret < 0)
>> +             return ret;
>> +     if (ret != sizeof(write_buf))
>> +             return -EIO;
>> +
>> +     ret = i2c_master_recv(client, read_buf, sizeof(read_buf));
>> +     if (ret < 0)
>> +             return ret;
>> +     if (ret != sizeof(read_buf))
>> +             return -EIO;
>> +
>> +     *val = FIELD_PREP(SYSMON_I2C_DATA0_MASK,
>> +                       read_buf[SYSMON_I2C_DATA0_IDX]) |
>> +            FIELD_PREP(SYSMON_I2C_DATA1_MASK,
>> +                       read_buf[SYSMON_I2C_DATA1_IDX]) |
>> +            FIELD_PREP(SYSMON_I2C_DATA2_MASK,
>> +                       read_buf[SYSMON_I2C_DATA2_IDX]) |
>> +            FIELD_PREP(SYSMON_I2C_DATA3_MASK,
>> +                       read_buf[SYSMON_I2C_DATA3_IDX]);
> Very complex way to express what I think is
>          *val = get_unaligned_le32(&read_buf[0]);

Accepted.

>> +
>> +     return 0;
>> +}
>> +
>> +static int sysmon_i2c_reg_write(void *context, unsigned int reg,
>> +                             unsigned int val)
>> +{
>> +     struct i2c_client *client = context;
>> +     u8 write_buf[8] = { };
> 
>> +     int ret;
>> +
>> +     write_buf[SYSMON_I2C_DATA0_IDX] =
>> +             FIELD_GET(SYSMON_I2C_DATA0_MASK, val);
>> +     write_buf[SYSMON_I2C_DATA1_IDX] =
>> +             FIELD_GET(SYSMON_I2C_DATA1_MASK, val);
>> +     write_buf[SYSMON_I2C_DATA2_IDX] =
>> +             FIELD_GET(SYSMON_I2C_DATA2_MASK, val);
>> +     write_buf[SYSMON_I2C_DATA3_IDX] =
>> +             FIELD_GET(SYSMON_I2C_DATA3_MASK, val);
> 
> That's a put_unaligned_le32() I think?

Accepted.

> 
>> +     write_buf[SYSMON_I2C_OFS_LOW_IDX] =
>> +             FIELD_GET(SYSMON_I2C_OFS_LOW_MASK, reg);
>> +     write_buf[SYSMON_I2C_OFS_HIGH_IDX] =
>> +             FIELD_GET(SYSMON_I2C_OFS_HIGH_MASK, reg);
> 
> I'd guess put_unaligned_le16()? Will need a a FIELD_PREP()
> for the full thing though.

Accepted.

> 
>> +     write_buf[SYSMON_I2C_INSTR_IDX] = SYSMON_I2C_INSTR_WRITE;
>> +
>> +     ret = i2c_master_send(client, write_buf, sizeof(write_buf));
>> +     if (ret < 0)
>> +             return ret;
>> +     if (ret != sizeof(write_buf))
>> +             return -EIO;
>> +
>> +     return 0;
>> +}
> 
>> +static const struct of_device_id sysmon_i2c_of_match_table[] = {
>> +     { .compatible = "xlnx,versal-sysmon" },
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(of, sysmon_i2c_of_match_table);
>> +
>> +static const struct i2c_device_id sysmon_i2c_id_table[] = {
>> +     { "versal-sysmon" },
> 
> Named initializer for this.  Uwe is cleaning these up across IIO;
> let us not add another one!

Accepted. Will use { .name = "versal-sysmon" }.

All items will be addressed in v4.

Salih
> 
>> +     { }
>> +};
>> +MODULE_DEVICE_TABLE(i2c, sysmon_i2c_id_table);
>> +
>> +static struct i2c_driver sysmon_i2c_driver = {
>> +     .probe = sysmon_i2c_probe,
>> +     .driver = {
>> +             .name = "versal-sysmon-i2c",
>> +             .of_match_table = sysmon_i2c_of_match_table,
>> +     },
>> +     .id_table = sysmon_i2c_id_table,
>> +};
>> +module_i2c_driver(sysmon_i2c_driver);
>> +
>> +MODULE_LICENSE("GPL");
>> +MODULE_DESCRIPTION("AMD Versal SysMon I2C Driver");
>> +MODULE_AUTHOR("Conall O'Griofa <conall.ogriofa@amd.com>");
>> +MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>");
> 

