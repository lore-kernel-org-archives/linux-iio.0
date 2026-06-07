Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743A74071CB;
	Sun,  7 Jun 2026 20:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780865161; cv=fail; b=OhHUJILL2BW4s4VSA3AiLSeC/1nxTsB5NogS0D3CqDp2a5fP7mO+kA5Mg8gg1srMRKnefnTAqfLMb210Dfz5yoRMiI79x7gEqc7BojOi3skuzi3ZrKd/I7GVu6bQoKq6Ozt093tTmRwvF/fGr517JjBQebEeXBKWKowujrNCPPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780865161; c=relaxed/simple;
	bh=iDg+vuoBaMtHjCMAjoHM85WbHX7IqF0NavjI4NDdB14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MraQjx+xfCTLXqhClgtaNvvNnOWIAZlTzhv21qoXgDRCUFLRrRlA1KicpUjzB1wisG6/nYgJ7Pb6dyKkz2PI232sXcYxN/fay+UHy23sEAPbEspWTkz64pWK9EDNN+1oNk1q55U9/YlsHfZoX2MtSHgV24RJM7rHt61CQjJ9+lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T+xx2roS; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T+xx2roS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DrnG2cJ23w48Ax4yUL6ywoT2CvGstZerzUSbl+8xR6yAqGz6Xc4B3iVXha7nGXmn4U/aPV1doVBj8Jdtw8GU5C5Iu2ka8ol+vMRdQ/mD9XHOsTknlbT1rhqGq2ZuljMJRoWUrc43V0/iX3ZRWhRjMnLZammgh6IHxZ5Tynm4Mr96W/QXXKXYqhW3mSRqFbM9xqBu4+p5cNViJrrhJzpyycNz261lFyvp66hcDDqfvSbkD3X7Os8JySKOfMZ1z3Q8lDQ/e2xN9atgHlLxzkcNGAFOoM2RhWTI0ObBuajye2nxpCouLIjBGKv4mIeNu7oXdQ0tX4GBf2DUTSs+6625cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SKMH+90TavRZbjH/EGIE6mLpVFyKE4MdCofd8pVh5q8=;
 b=TckfAqhrHRZfFMxpWdU3FV+ZG+rV94yaWCNmDDWR7Fka+2CGqeH4WbDgrEXX1+jMmRP4/8GxeXy2+ujRbPYaq6ZQ9uHcTezzzCwFyM8UoJqRedE0IYLAP/D+VVYRS7MwI+xX/wZf4Mjez+4a58Ha4klSbxQLhiHmpFPhKUqDWaNCU2dwE1Gtl/UxBGPUJGW6SoVMf6Xzlq1q3BQT7NLypFYuFbE7VnMi/nlE0R9rCiEy5zuYwNyqWAB2JzuazySklDYVa3lo1crFSeCbZjqQm5cmdtpsvZnfgI+jXEAmyrsG1FQLTs7Qbpq/POhm/2IHyUs0KlwvlEdMZzJMHngTQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SKMH+90TavRZbjH/EGIE6mLpVFyKE4MdCofd8pVh5q8=;
 b=T+xx2roSjr0oNn4U5+33DvBZ4+ksDn+XmiJibCq1uSe2BEOJgxZWmQelt59GvQPjuKttfQeWukcn/CSc/lYrhhSwmXBKkREnPSN/xkD6qK9+dOAb8pJPkAbwaLX6BMMAzkcijsJpsF00Y/G+Uuq6fKgGKNPzFre0XBYxICdC+fE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 20:45:54 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 20:45:54 +0000
Message-ID: <cabc05f6-9a01-4827-b2a3-9267da1e6932@amd.com>
Date: Sun, 7 Jun 2026 21:45:50 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/5] iio: adc: add Versal SysMon driver
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
 <20260606051707.535281-3-salih.erim@amd.com>
 <aiUmb0WMPHi0D6GH@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <aiUmb0WMPHi0D6GH@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0471.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::8) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 19811fdb-2ec0-4441-8ca6-08dec4d5c4b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|3023799007|6133799003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	mb870VN8UsGBGK36DUFoN7sTdlMDyxQV7tg2i3yxK41gnVEzWSgx3PzqrEbGLT3D7kf9HimOGVHd3R/bCw927hAtM+Et/VV3BldAgihXuLFtlMX+4kzqmcYG/zBhxtA3KDNzCGCWMwgY7o1pvH5Cd4h1pPfu03oGs9colD5mxL7Zb9F0IkiGkNBxjmtRT1QGDVRytItsEZ/0pTaCodMRDm8xz/GHhpk3LopvHkz5Tge4PAgwcVh+BjllwJaHpWDUMH/AAzxUSPycHhtnIURVzAD9Q+5VJGKirR+4wBapWGJ04RefREhViVdxnSrC6KHm+elrN8wHFQipH7uoeigGTKkWg37NyPwoDm52GYZUUgZpC9byV8N4/kMGcaM8NbC8GZdoHY7UITiaioR6IjhvZunhhP/NvxEQKFfYv7wpoeSTPKab4OoomwYaVwmoXUtmFw9LV5RywbOWVyMLhFpHMoyDhcMx7qNhSu+ENAr8p3/7wBmO+isxId57kMxFVcmhaWxKQPJyUFGl4I9B9pQBobCdER8RKLQziptuqzvThgP4sxU1P+pgwQEmain70oQcNCbiHj64qRJ3VbUUE5NH/nCX/eMynNnMEyuWXhsa5uwCygM3tlfRjQOyJQ+PI0y2emR3i1r1G0U/D4Jdp5MHpOhXUeYHkq15KtHoL0XhEkGbZjRiKeBXBF1vBv8ZqBrM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(3023799007)(6133799003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVpaM1VGREJoQ0dDRzdMTjQ4cVZTMVF1ajU3QVFQd1FFMW05enI4eTFNNFcy?=
 =?utf-8?B?WFJTQlAveER4czJSWWRsNHRCazMxK05KdHRiVURkUkhOaTBsa1U5SURGbkZM?=
 =?utf-8?B?b1lDZlNmaExZSnpmVkJJdWphNXFsMEZPQWlVcVBsUnhTd0x5UFl6YTBVL25v?=
 =?utf-8?B?RmduSStlYmk3L1JzaDY0ZzkvUWxMeTB5M1RoWTNabHhRM1Z2Qy9mMnprTnRp?=
 =?utf-8?B?bDNhOFNmUVNJb21OZ3p6VTdMSC9UUWFxRmt5NzJDVENIbEVlZENCSnMvemox?=
 =?utf-8?B?RGJGNE5XdkQwZDJocnBlRi9VTHVORHRYdlRuczBMdko3OGkyNGx3cG15NWEx?=
 =?utf-8?B?UWJxM0l1OHB1cVBjdzQwVlNKd1BSZjlIM1BmYnlYNWJZSjVVc1o4OFFWTUZ3?=
 =?utf-8?B?N1Jxbm1Yb1g5c0VTcU1pNmNFT1A0dVU4cGxnemZ2ZmErSGlUaS82K0Zrakpm?=
 =?utf-8?B?SWNJcERUTnpKNGNaWW1SNTg2L1JGZ3gzSndCakFMK0NzaFJCS3hTTVQyWm15?=
 =?utf-8?B?ejBjSTZablY4MjJmRzM5ZUl2emFsTmZuejBCVjZVcGdGTkpCQndVZHhKQ3Vo?=
 =?utf-8?B?dDZnTUtQUnZDODFFdDZyRzdsZ2Z6YkhqUTRGclZYcko5d1JiMUdVUnptNzR1?=
 =?utf-8?B?OGxQa2lrb2NQbDBUM0NSa0NLWVZyREJjSTZ2cnpISDF3TmNKdW5VVmpUVysr?=
 =?utf-8?B?UGlKbklTSTFCSWZCaFZVMkpoNDFaaHlBM3dQVWwzYkV6UVBlQTRNUTVqT25h?=
 =?utf-8?B?UzhkMlVCNFFBN2VTSVV0OSt3dGlrL0V4OW5BV0loMkYzRFgxdU41THNmTDdP?=
 =?utf-8?B?UkdzMDRya0E5UDI2QzlHVFRaY1VJV1ZSNWFUazhCQWtzcXpNQ1VKcTNUbkZM?=
 =?utf-8?B?RlByUEtoQlVNUnlwQkhSUWd3ejl3QU4wNmdJWDRpTEhoQmNOQ1l5T0tJV1Nn?=
 =?utf-8?B?ek5oYTBIU0l0ejkzcVdMYnZpUVlVUXlxdHI3U0tRcmcvbmRycTlaYTRNU3FP?=
 =?utf-8?B?dDk2cnVDTGkyczhiczVrK0FHY3U5TW82Y2JXTUVWc2hIQjlxeTAvKzhLWWFB?=
 =?utf-8?B?aE9KSVZrSW5JUXBWWWtlNUlaK3dwa3FUcWZQUXZ3akp0UkdyREFpdS9hTGc0?=
 =?utf-8?B?RC9lTis2aVM2d2hFWEx4S0tSSU5jd2FtcUFpV2VFaEFZbDB5cmdYaGNYZ2NV?=
 =?utf-8?B?MktjRUtJQnM2bFBUM3FlYUZjbGpCNWNrdk0zcG9LZHc1Z2c4Wldma09aMTla?=
 =?utf-8?B?VjkyUXlSMStwTFdEUmtLaHNma2M5NTZnQ09JcnFveWw4RSs4czVpY2FBSGla?=
 =?utf-8?B?Nk5Hay82dkhsRU9aMGNlS1dSUUN5ZDgwOXpNVHRJQUhIcU5ZLy9vZU5jWWVh?=
 =?utf-8?B?S2VxeFY5NkdQS3lsSmY5UU5uc3IzV05vL3NoRit1aENxRENDQ1VlZlNLclE0?=
 =?utf-8?B?V2tXL3dWVkxzSGIvUlllaWdOcnRzcW40NFZFVmVOU0c2eGJZRnNlOXBWN2Ri?=
 =?utf-8?B?WUVUUkV3R3VSTnI3eVFIN3dZU1BaelR5RC94ZndZbHNSWHErOWlRbVY3WkVS?=
 =?utf-8?B?YjBBSm5ZUUhYL0UwSjltRHBtNTZNOGlxbllrcUozbGZ1OXNQRG9RYkE5bXU5?=
 =?utf-8?B?NnJUVk9IWXZ5YnJjYWNKMTRYYzhWSjdPaStCYjVzQ0cyVUt3YnhIb01tRWlN?=
 =?utf-8?B?MGdKTFYvamNMSFRRWktyT2dkUVJiUVFzL2M0eW9SemxGRDBOalhnRWlsNmpy?=
 =?utf-8?B?ZmpqQ1ZSa2tWN1hVYjJTQnJlcmFPNXpPanRjM2ExRUFTdjJYYVczNkxOT0FV?=
 =?utf-8?B?cW9pbGdYSVNmTUpFT0JpQldSbjczUEo0dnprOFFmcTVZOUltS2dmYjhtSHNi?=
 =?utf-8?B?VzlXT0lNZHBpNEoyVTNYZnFyWXQweHBDZlYyUjVoUUdVc2JWc2x0RjZLdVNJ?=
 =?utf-8?B?eHZ5UVd1Ni91SHhhUUM2ejhhdlc3Y0lzUkJTSm8wUUdoWFFVOWNtazE2eGR0?=
 =?utf-8?B?Y1VkQWJrQ1lqOVFxMzhrYmEzTjJGbHk5THNDWGlPMlk2bERkQU8wZkU5Wloz?=
 =?utf-8?B?SENNclp6Zm9Oak50eFk1MGo5WEdEK3ZhOHhONkt2QkZpMzJsVXk0TXdmQ25G?=
 =?utf-8?B?b1l2cWtTQ3RxNzNlb0h1eENMcXNjcG55aVBXTVluMmVreUd1NkVVNEgzNDhr?=
 =?utf-8?B?cG56NDhEQmRzMGZveDVnWFNhVDB3WnQxSVBab3BPbnlYYTBUSWRqNWlwcVhI?=
 =?utf-8?B?VUtEamphM2ZJT2kybUp4akVjWW1MaWoyRHNvdnc0VGcrNE81NFh2R2IvTURu?=
 =?utf-8?Q?/PGqvAHMdv/WtXdsAA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19811fdb-2ec0-4441-8ca6-08dec4d5c4b0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 20:45:54.2026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K19hnyVcSB6PIV4VNnsk8WrIE/dbL6QFqcQaWg56LZyTJZyCNTS7lwztbDa2kt7B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912

Hi Andy,

Thanks for review, replies are inline.

On 07/06/2026 09:06, Andy Shevchenko wrote:
> 
> On Sat, Jun 06, 2026 at 06:17:04AM +0100, Salih Erim wrote:
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
> 
> ...
> 
>> +#include <linux/array_size.h>
>> +#include <linux/bitfield.h>
>> +#include <linux/bitops.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/device.h>
> 
> + err.h

Accepted.
> 
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
> 
> ...
> 
>> +static int sysmon_read_raw(struct iio_dev *indio_dev,
>> +                        struct iio_chan_spec const *chan,
>> +                        int *val, int *val2, long mask)
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int regval;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     switch (chan->type) {
>> +     case IIO_TEMP:
>> +             if (mask == IIO_CHAN_INFO_SCALE) {
>> +                     /* Q8.7 to millicelsius: raw * 1000 / 128 */
>> +                     *val = (int)MILLI;
> 
> Casting is not required here.

Accepted. Will drop (int) cast in the scale assignment.

> 
>> +                     *val2 = BIT(SYSMON_FRACTIONAL_SHIFT);
>> +                     return IIO_VAL_FRACTIONAL;
>> +             }
>> +             if (mask != IIO_CHAN_INFO_RAW)
>> +                     return -EINVAL;
>> +
>> +             ret = regmap_read(sysmon->regmap, chan->address, &regval);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             *val = (s16)regval;
> 
> Basically you want to use sign_extend32(regval, 15) for consistency.

Accepted.

> 
>> +             return IIO_VAL_INT;
>> +
>> +     case IIO_VOLTAGE:
>> +             if (mask != IIO_CHAN_INFO_PROCESSED)
>> +                     return -EINVAL;
>> +
>> +             ret = regmap_read(sysmon->regmap,
>> +                               (chan->address * SYSMON_REG_STRIDE) +
> 
> Unneeded parentheses.

Accepted. Will remove throughout.

> 
>> +                               SYSMON_SUPPLY_BASE, &regval);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             sysmon_supply_rawtoprocessed(regval, val);
>> +             return IIO_VAL_INT;
>> +
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +}
> 
> ...
> 
>> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
>> +{
>> +     unsigned int num_supply = 0, num_temp = 0;
>> +     unsigned int idx, temp_chan_idx, volt_chan_idx;
>> +     struct iio_chan_spec *sysmon_channels;
>> +     const char *label;
>> +     u32 reg;
>> +     int ret;
>> +
>> +     struct fwnode_handle *supply_node __free(fwnode_handle) =
>> +             device_get_named_child_node(dev, "voltage-channels");
> 
>> +     if (supply_node)
> 
> Do you need this check? IIRC the below is NULL-aware.

You're right, fwnode_get_child_node_count() handles NULL
(fwnode_get_next_child_node returns NULL for NULL fwnode).
Will drop both checks.
  >
>> +             num_supply = fwnode_get_child_node_count(supply_node);
>> +
>> +     struct fwnode_handle *temp_node __free(fwnode_handle) =
>> +             device_get_named_child_node(dev, "temperature-channels");
>> +     if (temp_node)
> 
> Same Q here?

Will drop this check too.
> 
>> +             num_temp = fwnode_get_child_node_count(temp_node);
>> +
>> +     sysmon_channels = devm_kcalloc(dev,
>> +                                    size_add(ARRAY_SIZE(temp_channels),
>> +                                             num_supply + num_temp),
> 
> size_add() should be called twice.

Accepted.
> 
>> +                                    sizeof(*sysmon_channels), GFP_KERNEL);
>> +     if (!sysmon_channels)
>> +             return -ENOMEM;
> 
> ...
> 
>> +     /* Temperature satellite channels from DT */
>> +     fwnode_for_each_child_node_scoped(temp_node, child) {
>> +             ret = fwnode_property_read_u32(child, "reg", &reg);
>> +             if (ret < 0)
> 
> Can fwnode APIs like this return positive? If so, what is the meaning of that
> and why do we ignore it?

They cannot return positive. fwnode_property_read_u32() returns
0 on success or negative errno. Will change to if (ret) for
consistency.

> 
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
> 
> Too many parentheses.

Accepted. (reg - 1) needs parens for precedence, will remove the
outer pair.

> 
>> +                     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +                     .info_mask_shared_by_type =
>> +                             BIT(IIO_CHAN_INFO_SCALE),
>> +                     .datasheet_name = label,
>> +             };
>> +     }
> 
> ...
> 
>> +     for (idx = 0; idx < indio_dev->num_channels; idx++) {
> 
>          for (unsigned int idx = 0; idx < indio_dev->num_channels; idx++) {
> 
> ?

Accepted.
> 
>> +             if (sysmon_channels[idx].type == IIO_TEMP)
>> +                     sysmon_channels[idx].channel = temp_chan_idx++;
>> +             else
>> +                     sysmon_channels[idx].channel = volt_chan_idx++;
>> +     }
> 
> ...
> 
>> +/**
>> + * sysmon_core_probe() - Initialize Versal SysMon core
>> + * @dev: Parent device
>> + * @regmap: Register map for hardware access
>> + *
>> + * Return: 0 on success, negative errno on failure.
>> + */
>> +int sysmon_core_probe(struct device *dev, struct regmap *regmap)
> 
> I'm wondering if the @regmap is the same as you can get from @dev via
> respective API.

Yes, dev_get_regmap(dev, NULL) would work since devm_regmap_init
registers it with devres. However, the explicit parameter makes
the dependency clear and avoids coupling core_probe to the devres
registration order. Happy to change if you prefer dev_get_regmap().

> 
> ...
> 
> + err.h // covers IS_ERR(), -Exxx

Accepted.

> 
>> +#include <linux/io.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
> 
> + types.h // covers NULL, __iomem
> 
> IWYU, please.

Accepted.

> 
>> +#include "versal-sysmon.h"
>> +
>> +struct sysmon_mmio {
>> +     void __iomem *base;
> 
> __iomem is not defined in the above headers.

Accepted, covered by types.h above.

> 
>> +};
> 
> ...
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
> 
> IS_ERR() is not provided in the headers included.

Accepted, covered by err.h above.

> 
>> +
>> +     regmap = devm_regmap_init(dev, NULL, mmio, &sysmon_mmio_regmap_config);
> 
> NULL is not defined in the above headers.

Accepted, covered by types.h above.

Salih

...

