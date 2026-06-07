Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012017.outbound.protection.outlook.com [40.107.200.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3A53224D6;
	Sun,  7 Jun 2026 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780865752; cv=fail; b=XBKk+jVWGzsIaTgGljNUrOATVJ8ky0V9mKUQVGAluR9neIVbVIC0TsUhBlIAHGmsdWULjIdQRu78UYmA0p1mD8Na5m0Jd/8TVIAUFFxx2R6bWVqwB57DNcpb5vGGg/tBYp1xcJXPB5S8qGRl4M9aRrHFeuarLnlwptbqC5jT/9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780865752; c=relaxed/simple;
	bh=FHH9zqUzeBxvHcaUglP1/htWTtFGK455X9KadJMQrDc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MqXc/WmT8BbH7VWl0G8RviFG+DgzFNs+jyn3ee82nvXhqZ0fId+NeSG4Wyxm2oHDrzTOercnYhJoIasZdVv1sfx9B0UNKoOy6fn+0MjiorlZEKQp2fbwNQvFhdRnbiiUXyeLMp8zrRoU8YXKUPAgz8QbYegq8b5irFOufYk1+AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cWOdSXBz; arc=fail smtp.client-ip=40.107.200.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cWOdSXBz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbvX38nlztbk02t74WPVVOW2ep0j6+ydJlrwI0QU9I4U0zGNkGwp92Muhzwaeizv+kECxnGFok/RO3yXW3nghwpjelBWCejUuJYtm3U+Uuw4EFFifvY5FshdWiIRoNLHbhZxpLql3BWZrcLC9Cti7Qzq8cQXL6QFt69cnkv6rkRbpy43DuBoD2ZeGRpHK7jlwYvvAHKSoEOdKQ909O36MD2fXoxsBgwsH4ozpiHx5e5f9np8ltGdW4UDhiRtncaJKSY7BkQKufw/J+I8uYe8l7aR8+dN90qZMDKPTjA2Z5xSukQYodmZxxQSCn7ds3XGW8c5WXK3mo3njRcjTe7F7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wGE7T1SjVO8Nv/6KTmyox6qQ8T13tmCXANWYPzzFZnM=;
 b=j/uv5PyNIKfGZ0kDWR7QEre5v/tHfLJUGWndqcy1Jc7FCqLZUph/cG0hJ6JlYSqxTIgE8jjGtoOwWUjp6LhuVkWQucoHSVmxw06Y+y5J/2MLYuoyrgynD5YLItBv7Dw3EY9kCEtGTRAIjH59k/FOB9DXi6xQHczdz7dreQNajHmMH/a+ynYUFndCtKT/3nmNzpE54+iH7AZZaZ+COIgl1QawZ1iD7wqtc0+i8mSS/CJvR2ZBSRFGFs9FZZCl7jXD4pYkJTkFh83KngR5XWZ19fwN6oblRvcMP/mJzITiQpH/frka963loXdayN+cj9edNPPJR1Gi4AsrttDpQg9f6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wGE7T1SjVO8Nv/6KTmyox6qQ8T13tmCXANWYPzzFZnM=;
 b=cWOdSXBz10bIgdyrJHTKf87vfaILpSOgPRCwFsFrhiMBN9JIbtUlbPwiz97r/IRmCw9tD6+w0kzqD8PECYCj3qXfFIo03qtBFVWHVLyaMlYn9Zh3yiIOxSH0JVFHDAQU87w+5s5a90L9bIjBdbUWr6IT1j+sostZi+WzPmK2nCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Sun, 7 Jun 2026
 20:55:48 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0092.011; Sun, 7 Jun 2026
 20:55:47 +0000
Message-ID: <9dc9f575-b5de-4135-bdee-468b7448687d@amd.com>
Date: Sun, 7 Jun 2026 21:55:44 +0100
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
 <aiUmb0WMPHi0D6GH@ashevche-desk.local> <aiUm5vmG7EHmp52x@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <aiUm5vmG7EHmp52x@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0472.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::9) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 0477162c-cee6-41de-9764-08dec4d72681
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	lkAdPsJQ6W1sV5UGZiZV2cVndU9pNryncegdqhmV3sbFvXWcKpKupnLkoRTeS47GYRdD7Myn8qQlUtKyz0kp+RBYDg21hkdfr7Pf2I/HCcc5Gi+1MVxGAgm1quGAV4fPvcgvBcw3H+BQsfFQ/KSbC0dCVMEq+pPHL9/X0TCPqSWgnDchpzTjVtZ6iKV0Ty2Z65S5tRU0Z2Va5dtGl2SJmH+JP4aqDpynyn6O0LKEGyGRrfGU4GQL1KemDQJNC32mjH4x6cG9sQTsByVKP7PJUN2p9cDSyf2NuM+G3n54ZtAAr1OPh5DZ9cuKgnHhDYQRIsr+v+Lt5kj/dAXacaUfqH4kajkKSd/c+L6Sfhz9HsffjpYHoxvrdWl5jf00HmUIZWw1fF9AwKbIogpZmuCCNCBSriEdtJJ1j4Pn80lp8Y3VAll9cQlLR4e1ZuW2AP7lOfiOUsoQ97pGAe6YKVRW0ZLoQRQY7RMdrOS80fwyme6wSo3ULC1J2ohmfaU5bhc93E0BoVj/JHFLAUBjnNKkgYhifsGka+EpRtAaOf0eblbwmGMyQpzwuU9DCp2Rogq/7KqxQZXTlUYPg8AWJPUF9lcv6c8adedmO2jpqy9ISl18N1J/Ahh3dwKxLX5KyeHpB2ZvX9153SuDS4T7VnhcxvkBixzxd+Tp8gyFP6NiWySFpWWW2h2V8RUkUaLbIOwU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OVJGNkZQZWV1YURqK3dRTU5lNkRYRUVkTC9FbGp5Smc3cWI4VndqTXgrMWJC?=
 =?utf-8?B?ek9jU2RrZTdjaEVOVUdRRGZibFlzOWcyQjdGZW0yaUNmUmNGSzREL0ZRS0pB?=
 =?utf-8?B?NWczYWUrMXV6UXY5dDhPczNsRkhtWWtlcjI3d25jNmJEcTRvNHpPZW80QzEy?=
 =?utf-8?B?cDJLd1V3c0tZaUNuWTllY1hIVmtwZlJ0NEpYelh2bHUzUVBzbEZTKzNzcEw2?=
 =?utf-8?B?eEMvQnBnZHpGR3ZhWmVpZTFFWDVUbldmTzM0ZnRUVVpCMUZHY3hDZDZlYy82?=
 =?utf-8?B?QTZLZ0JnaDQybitIKzAwWXRBL0gyK014dGtvcjEwL2ZDaWd6VG1aYWpSR0xY?=
 =?utf-8?B?eXM4cWlza3huajJsQjIycGYySExkU2pxM1NkUk1JTXNaNXk1SVJwOS9Falho?=
 =?utf-8?B?akZXc2VrODVXZXJVUGZDWXE5a1Q4eEFJaWd0WUV5Z3lDcTRNNThCZmRwVzVq?=
 =?utf-8?B?STVROVoyV1dSRlh6MFZMSmxnVzY0K1JTQ1lra1lXSHBRSG9wYis3c0xUWm9I?=
 =?utf-8?B?U1d1OGpwYjZPWUQzYnhzWVdYM0g0MmlXR2FTajdJNUpvQlJKZnhxRHEzZW43?=
 =?utf-8?B?YUJKSm04TmlLcUpqbXkwdDQrUmI2dExhKzJqZFo3SFFOY0pKaDdNT0RJL2Ez?=
 =?utf-8?B?Zk0zWklHUkFSblpuQWhXZ0psV1VJUkdXdlJMWmpJOVE5RTBmb3hpODRxQTZY?=
 =?utf-8?B?VGUydU9CTUlldWx5VGprN0RnL3I0ZVh4eHVkV291RjNXRjlqSjBXYjdscmlK?=
 =?utf-8?B?eStDb0lkRzVwcjBaaDFkdVVkUURNc0xXMGhIQnJFUmxPYjNva1VtT2prak5n?=
 =?utf-8?B?MG9mcEppcEorQ1I4YWpid28wcFBNVDl3aWpxS1phTkFiemhLeWcrT3doc096?=
 =?utf-8?B?YWdYaFJuUXQvcXRycDA4MXNLNkRCQlBsQ2krZFFKY25jYXBhL0lNdDhHRExZ?=
 =?utf-8?B?VzhlZEsrb2x3a1lHUWNycndOQ1FNcHpsWlI1WHhrWEFpWDZvci9DNmJaTEdQ?=
 =?utf-8?B?MGFuNVMrejJRMEd1dStOK3R0Q2ZTMmovRHBLdmZkRnFwcnMxMngybnk3a3dr?=
 =?utf-8?B?eXluUDBkZnppUkpTZzIwazk2MFM2TEwxS0tNV1UwSWFxUVQ0U1lyRnY2dHBv?=
 =?utf-8?B?c0lGUVRIMkZZb1ZRL3FyMGVlQ3R6K2hlNE1zZTJ2djhFckNTQzRZc1U0UFUw?=
 =?utf-8?B?QXZyOGorQkRzNkkvVEw2N3NnTjByOGhoNndmWkI2dGRpUlZ4dnVacXhjdXNS?=
 =?utf-8?B?Q0pqZUNEbVJzYmVMZE5HVUloN1Bqbk5MZGVaTDVsdllCcXgyaUdTQTFDWWY5?=
 =?utf-8?B?K1F5WEpyYkVGYVhPS2tFakdNMXZkVXJJcHZlT2lsYWY5YjVDai95dGpTN0Uy?=
 =?utf-8?B?SFppSFlpSWpGaWJUQy8xd0N6UWRhSC82WC9iM2pRZy9xeXh0TkxEdFNiQ0o3?=
 =?utf-8?B?ekVjNG0rb2VTNVI0b2tUUlBQNENvQTVVS3ptSWhBaFhZWXhCZzV5bFpjQnp0?=
 =?utf-8?B?Kyt2OEdYa2JHZ0dSSWd3ajFVa3RwMHpLUGdBSVlOSVVEMndWbFVKWkI2RWQ0?=
 =?utf-8?B?cmxGSU9PS2Y5dFcvMiszM21LeGtSQWF4Mk91WjFiRGx1NklGSmE2N3dGU1Fr?=
 =?utf-8?B?QklLeXBlQ09PMmVOaCt5R2lBckNNYjQzdHVZSldMejMwVHk2YUhSVzVDdCtq?=
 =?utf-8?B?MjB2Z3JBdnMyMXpPeXFFQmpKaXVING5QSGwxZGNsbGR4NjVZRGRWb056dU4r?=
 =?utf-8?B?eWJuL0RoOE9YNFpaZkplOEUraFlLempydHE0amorNFBQL0IrRm8wUGZQZnlL?=
 =?utf-8?B?WmlBc2htNXdrT2dRd05KR0pFdXBwa1QzemV2cTJhbENpNlNrc2ZkcTlscTFM?=
 =?utf-8?B?bTg4amRHVjVVOVN0Z0RNQllVd0ZYRnZnSTJ1MjFFRzUzcUdDSVJidTFEdllh?=
 =?utf-8?B?NjNKVTM3U3FYQnhQbXZTRE9vKzlxL2dJTUMva3hkRzhFRXJrRzl0NUpSbE1Y?=
 =?utf-8?B?amRWUmIvTmkvZHRseXlxSC96Z01IbU1iU3NRVDgyR0dlTGtGY1pXSjArdlAy?=
 =?utf-8?B?QjZjVGlzK0hCTm9ENlpTTE9DUFl4K3UrTW9yMDdnQkgyWW0xcE0zQzNBN0lG?=
 =?utf-8?B?SkRBUDl1RE85aWMxazlhZDB5UU81Qm5lNlAyUUxQejJDcWV6VkxOSjBhOUIr?=
 =?utf-8?B?anlIV0Q1OGxhdlV5dUNyeVBpUEkyQXZsVWM0dHZ6TlN6bXcyMHh0UFlUQmZL?=
 =?utf-8?B?elROYS9UaVhkcFNyaERHbi92TUZOTjFqTTU5L1hYQWFNT1FjN1pRazBVL1Zv?=
 =?utf-8?Q?BN7KcH1tnz9qbH4Yxj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0477162c-cee6-41de-9764-08dec4d72681
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2026 20:55:47.8048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VdDaa9L37RNBzLtRwmhacBNrH+LryPYUqJfCideFWkj0+7yGr03U3scFH3aSk4+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912

Hi Andy,

On 07/06/2026 09:08, Andy Shevchenko wrote:
> 
> On Sun, Jun 07, 2026 at 11:06:13AM +0300, Andy Shevchenko wrote:
>> On Sat, Jun 06, 2026 at 06:17:04AM +0100, Salih Erim wrote:
> 
> Ah, and missed part below.
> 
> ...
> 
>>> +#ifndef _VERSAL_SYSMON_H_
>>> +#define _VERSAL_SYSMON_H_
>>> +
>>> +#include <linux/bits.h>
>>> +#include <linux/mutex.h>
> 
>>> +#include <linux/types.h>
> 
> types.h is not used here.

Accepted. Will remove from P2 and add in P4 where struct
members first need it.

> 
>>> +struct device;
> 
>>> +struct iio_dev;
> 
> Neither this forward declaration.

Accepted. struct iio_dev is never referenced in the header.
Will remove.

Thanks,
Salih
> 
>>> +struct regmap;
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

