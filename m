Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012006.outbound.protection.outlook.com [52.101.53.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121D41C5F27;
	Sun,  7 Jun 2026 10:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780828049; cv=fail; b=ovVuMimPWuKEpDIKmqAKs+a3uItwyiSf2H3O5XvX9u3hRR8zPracJ94mRaa2lx9AWT5Z2YR30v0ZCzicc+FiaocV7sr3kOY2w//ofPDOobcGlyItTD3C9rrbUBVmPb2t+KRTlpqAah3bQoxnNetP19YqDcaVfssRjVTgaWKkf0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780828049; c=relaxed/simple;
	bh=5+r8bpUCsMISGNvtEtxt/FZnod3tEe6VnMd8ES/htCM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tzWsY38xceGKeQhh8559saJS83PYw0+OeUC2dXK6wk3/IEQVrfXcL3a58PXsLAdQuqNeFAwXoUqZtlnHPcXORJ6FGypspyOajZy+DYUcxu9O5AFmiULeOgWx/UkPnv50lMf/bn7Zb+HOQu+O9t5DPAK9a8EO1r5NZFfXAiP150s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=g6t9d8yU; arc=fail smtp.client-ip=52.101.53.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="g6t9d8yU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVngu7wZ6HCY+jw1mo5D4xzs8c5MY09ugg8cvwQz3taUXP4jxPqZmb/IHz3AZKAf0EkOBKVZb0I/iiKgFNGfpThpr/MvqqSVoYINXG3LIYWFcbmzwO5PFtzDstfp3ClmQnu848ILwm64MnrYkpS1fV8HIoJQH+LY7Dhc91e3q59Uwk2ihBSYOVDdHlEprU/dG27IbiuV5imZMkdAoXBhPWk19OOzcFrfFjlzoppaoI2HbSq7/+kxClIFrKdUAtlUs0yE4aie8RLldab7wh6RmV3MJ7eLo+xB2TyXcROQyEfioiBvQ0RuQq4hfwauARyM7/LLrRUOMTMNdPcYby4r9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SLhej37+8jE34vAeg4dFJPgmVl8ViPXXKNReix/1NYQ=;
 b=YwMmFzp/+n6OhlBQROkr80iGz+5nV6YUig5VjugzEGgDxv0zbszhElAOboXXXgKyQZijndAfpYuro9lzw134xY5vPTGiE0BRIXPotNbWEpBkemOJnmE9X4LfvyBV7qt2xnWZx3sfHj/1Kg+JKzmNBOUpWc0D1py9OGDoPe9HRRTZl383beeC81drfDLYF7yD73n2qde809v71VE0QR4u9XP/gv8a0z42b2WXkX/AjdULAX7z7deH3XN/B7IrhnCDl17IBg2VQ7DKL3JHfNeVKPUqZQ6seFJdn6uAwpklHUdv3fbqOriMy0z88tHRzD/gdmxSh71U2BNU7zZ3WVoPRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SLhej37+8jE34vAeg4dFJPgmVl8ViPXXKNReix/1NYQ=;
 b=g6t9d8yUSABXqs9ri7gj+LikzZj+0bjcKwjH5Xk+LM9ctBw6Qef5xuSZsLEFHibkwzIpkOg/w6s02K/pAlgHCqhUO/Bm/NL5/Oq2yTnLyVUG0F9eZWLftxT+XsHyXN7HRHEpfyB4LkYCYDPUHzj9oV2RCo5Uuq3LT4wc/9AzXCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by MN6PR12MB8592.namprd12.prod.outlook.com (2603:10b6:208:478::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 10:27:23 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0092.010; Sun, 7 Jun 2026
 10:27:23 +0000
Message-ID: <1d336058-7930-49f4-8bef-5e4f3438bda0@amd.com>
Date: Sun, 7 Jun 2026 11:27:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/5] iio: adc: versal-sysmon: add I2C driver
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
 <20260606051707.535281-4-salih.erim@amd.com>
 <aiRoOnyMG2g6BU_a@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <aiRoOnyMG2g6BU_a@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0511.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::12) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|MN6PR12MB8592:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b52d1fd-3848-4efa-9cae-08dec47f5cbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|22082099003|18002099003|11063799006|4143699003|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info:
	u6zdK2mTK/JSnsWkuxbkFbRaub02d/klyUbWoX93WNoNB/mV9y6TtGr7ipHTHoOGO+DasGUTw3aQvTqWWFvcXbcnGpu6CpLQFVXc7bepUSJ10lq868edUsvsAv6FjPIm8A/fIano0OSkyD5F1QC67RL5KXlMNhql2HFc/eKqDKKfZ9waqBTVhvkQ7c9ew2ZX3qDR2sJatrkL64YYOVSkvQjj8ep3iZAJy6EpQAfXKrLbfIHyzccvp1z3wo+F/w+wXvtGhldyO0VTTsy0aw22pYdy+cVGvI+wOPHF2asrDHQySti84VBK55OMwxpCfYvMsVmQBHewzmCJkinAYhuqntTRfFV4m7pKi9tEkdI5ch82dnF0n0dGa7yBzqBEXq3ZEjK/sQAxj6U+9CqhhWOLAakKlH2J2cORZjHtmjxbU5cume/aZhAxEawwXa10GWj5YwjZSoN1FpLL9UE/wj2kfPgJHgwQbDZbVe7BkZ4Wd6a8UuHknDnp05CnpL3sZjqfzXfFjwPLdTTJ6KSkoWOfdGnWIflvCSsEnkyVvH5/VoSh59k2jPQotVvp423QAPF8BqsdKg/bc+u7S8ttpP6NvqgaSyTiwAOwqHHsewcsWSwdqqF+NZjjijB9C0AZWNrAUk9hjcwwMiPTz9w9fiYPvAXCCVwJx7TT5l3E4CFwQSl+DZBbESfc+j22rfPS4cp9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(22082099003)(18002099003)(11063799006)(4143699003)(56012099006)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bjRza2UyMjdBS1ZSRHVzRzRvYjYrVndycWRJck1iZ3dhSm9xTWZYT2xlbUFk?=
 =?utf-8?B?RHVjazEyUWl3MnRZaVhRLzRvckZ5eVVPOTVkNU9DeGJ0Ynd1T1FQUm5YN3Z4?=
 =?utf-8?B?VXM5elNBb3Z5dHBXOUZIL0ZZSnY0VERnZ2VQWWNZNUdUakFSZlZwc0Q2akVJ?=
 =?utf-8?B?UURjV2sxcHpKVGpJYWkwTDhpV25PWjcwOXlIWjY2Z2JnTkhTN3ZnRjV3R0I5?=
 =?utf-8?B?M0JNV3dTZys5NURwVGdHYUNXcFk3YWd3ZHh0emMvSUpKY1JWb1h5bTQ0QTgz?=
 =?utf-8?B?V0k5YzZZdFRKOVQ2OW05cWNkMmdYalhUUjdkTWhwRnFBSWp3QjJuMFJ5WnB4?=
 =?utf-8?B?WW1ES0pjQlhoOHpGRTY1c3k0alVHbFN2c2YrTkNtQ2VDTlJtWXk5WjY2aTd4?=
 =?utf-8?B?L2dPa3Vjc3pTYnhmbDhvcEhUOUNaL1R0ODV4UmNsUkhTQUpRSklHNTVwSkZt?=
 =?utf-8?B?cW51YnlxQjRLSXI4cGpOZHJ6aU0rdWs2TExTcDVpU1FRMXJkWHR5V01aV3dq?=
 =?utf-8?B?MEo2cEt6TDlZQ1hHT01rS0JTT0gwVUdhbjVXU1B2UlNmT3RYa1lOSC9McEFS?=
 =?utf-8?B?NkFhcUVaY0wyV0x3SWlxQ0JFZm10U3pqZHE5OHMvSnZhZFV3OThjM0ZKRktG?=
 =?utf-8?B?SE8ybFUrd0pvVlNEMmRmcURrWlRJazk4ZTBxaUVya2xqSUp1dXZqUktrak40?=
 =?utf-8?B?YTdYRmZLcjYwMVBWWGxiem9hcmpiLzZlOWRkK1NpZ2Rzc3YxUW0yWVZXVk9q?=
 =?utf-8?B?UTRnZjdESnpGc3hRb3paV0JueXlWb3poU1RiVWZKRlN0WEZTdDJpVlcrNitC?=
 =?utf-8?B?Q05GQU9ka1JXS1pNazhraHh5VmFKWmhrK2NDUGdqaGR5eUg3cHE4aVpoRlpq?=
 =?utf-8?B?dGs3N3dXdWtPRGhsT0YrNk9jaFVhRmdLaGs2NlNjYXBMKzFJbVh1Rnk3Ylo1?=
 =?utf-8?B?cHlCbXBSeHo0a1dvSStzNm40QXQzTnU3MjVJUG1EdENmbDdkci9VajVYNjNu?=
 =?utf-8?B?OFJYTlpselZJVjI0U1FtaWsxRDU5aGR3YWpIM3c0cDg1MmNBUWw3TTdzOXc5?=
 =?utf-8?B?ZC9kYWxYQjdLbFE3N3JZUDZjQ0JUZGZqZXlTaWhSOGgwNjBSa0dYWG9VU2RK?=
 =?utf-8?B?enY5eGIzRzl2enBleXFFYzlHVzFORWM3WGZQbnFUcmFLL1pEYVFHVHJQbno5?=
 =?utf-8?B?cjJNbS9hR3JXWS9CWUF4UzgxelNPUFFiaVE1Vmpja250MHBaTzlOOStzYWZK?=
 =?utf-8?B?MmUvUndGWFIvbVFVRXBZaWRURjBZd2J4N1pjUzhXZGVhZFZNdnk3c05mYlZC?=
 =?utf-8?B?OForYllENHZzUVpuUUxOVE5zNjZtcytuQ1NKMmRSVmFSL1p1OGE4OVlKTUJV?=
 =?utf-8?B?NEM0WEdrb0lMcWFuR1Z3MDRjeVNNRVJIMS9jNDVPbjlaelJMb214bjBPT09a?=
 =?utf-8?B?bW5DenJyOWp4Q2s3My9ocGFrZXd2UEl4RkVmbTBMb1dMbHpDWnJmaE9ZTkRU?=
 =?utf-8?B?Nis1akxOKzZ6cCtVUW43ZUxWdmFJYUhrVks5YmZ3bFBHU2pTV0cySmdwb0p3?=
 =?utf-8?B?YlpyRktEYmIzNUZ4NG94M3Uwam14WldrdkpsaHJ2UndPN1lIaGQ3U3pzY2Z6?=
 =?utf-8?B?ekFWcFUwUmJWVDdmQSs4dTE3MWJuSTdVanN4TVp6aDNBSWIxa0cycGoyR0hm?=
 =?utf-8?B?TG1NRGpLR2htdXlaaEd1cERML2RjR0FiUmlEWXlrZjhGOUY3bFNnVGVQYm00?=
 =?utf-8?B?Z011eVZZL250VURDYlhPQzlmVHhSYkhqMGhaaDFXZHZTVTlPbFBwbmVEbzFv?=
 =?utf-8?B?ZUpLcHJSOXRpRmNTd2dVY1pnSFdlMTZSWElweGQ2TzlPcmlMWXBxSDNWRUdX?=
 =?utf-8?B?aDFUaXhQL1YvYjYzN09Oc2FnUFVqb2EwdDAwVW5tNGRTNytPbmFTMFh1NEd2?=
 =?utf-8?B?UHIwVzZBbnZzQk9IUWZFdmg2b05UY1JJQWNyQ2xpNkU1SUNIeHcwZ0FMRWZU?=
 =?utf-8?B?UU9wdDRuN3h6THlRUXNTQjRsT3dPdzNTR2Vrd3lqNlJFT2dkRForN09WQ0tY?=
 =?utf-8?B?YWJ6azdKeUcyZjFvckoyRFdmc09pNkUrTElPTnJpbkpIYm5ZVVVqbHRkR2xt?=
 =?utf-8?B?dEtWVWI5UVEwVU5MV3Z2cXJ5WjFkOHlid2VwWWVseUFFd2EvcjI3ZnUyb3lL?=
 =?utf-8?B?M2ZVQm5OZlhIeXBkS3pWbjRMQUlNRzhSVWZ5a3ZrNDRHdWw3dWovZUtaZEtK?=
 =?utf-8?B?dFJXaHVuMG5hbDdPZVFlaDQzQ3M5V2hjZnphWVRFcnFqVzRITndVWXpqOE5C?=
 =?utf-8?Q?drB76HLIG9k1y2wxvp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b52d1fd-3848-4efa-9cae-08dec47f5cbb
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 10:27:23.0709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nmq32pIOo1hRnvaI5USrzxL7mdCc+sGuRHVl4voNznSqHVZknq9ozZQ1iwx/vJKk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8592

Hi Andy,

Thanks for all reviews.

On 06/06/2026 19:34, Andy Shevchenko wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On Sat, Jun 06, 2026 at 06:17:05AM +0100, Salih Erim wrote:
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
> 
> ...
> 
>> +#include <linux/bits.h>
>> +#include <linux/i2c.h>
>> +#include <linux/module.h>
>> +#include <linux/regmap.h>
>> +#include <linux/unaligned.h>
> 
> There are headers absent, please, follow IWYU principle.
> 
> IS_ERR() ? struct of_device_id ?

Accepted. Will add linux/err.h and linux/mod_devicetable.h in v5.

Salih.
> 
>> +#include "versal-sysmon.h"
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

