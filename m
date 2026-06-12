Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013013.outbound.protection.outlook.com [40.93.196.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A73368296;
	Fri, 12 Jun 2026 13:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271562; cv=fail; b=r9GMZisXZ9rk7e4qK08sBL1ATHL5eTPOc5NYBKPKsz6ZPbPX4cVPDbDCRfpSEAGgCgmkbwCrxh9J6Kfcy5gE6v4HQAVsDtt364kVYkQFdtZnxeY9U0GglpZ8HOusA3p6+tFX2oNgjFONo/4+GaIxSfc8wIUrL5pCLXn9kkO4rbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271562; c=relaxed/simple;
	bh=lGFOvV37Gs4O7cFh8x9BLM+WIaYHBGgFDaG9na7qy2U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V/k/CwnXOT9gjsRnMRKUci+UA73LfsrL7hn/eceEZ9uA/DyINyJVytu3dlpGi3uYlFQ7H2RiT6OLuwSfUXshI6bCfyN099w/W3RneZHTXfAjgZll30eLTHfnKATNuAGrXBN9ZlgiKQbY3tqKQCS7RV/HEpyaeHR4FgQVUbvhySg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KjBt67lC; arc=fail smtp.client-ip=40.93.196.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KjBt67lC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZfDQJ0LE6HzVrjys7iRDKRhUmc9W6mSfK2X5ePrJoPkuX/Juwp9eFLNmWSqox5EA9UG8ltfFVeMc2qs57dTTAX8fGySuwsZooXRNmOY9fZjiMGSExr+QAkerJbZOlbI9TEDpkZ8OZyEefO/Ac+sCIztH8znDpjYhaFmys8vEJWuHcAOUs3zF7Dae4HpeMbe4wpYMD85T2z18rEcKmcRGlvEY1URwLKbcYk6fhBs14yNywpZV0ZaNqfAGQH63TybDNwMYQWyljCALQE8Q9R37wIyR9lb5WHlyjRICzUhXAjJRphJZg5HrH6ElaaSVop+NQhcYW2Oc7CQJBZWBOUfEZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w3+4dR9dKfLBFwa/KRyast3aRE24w6DpI/bJd2ecBE=;
 b=jcx0l4wnNjmScG4Wnqw8yFDfdZf9aQBWD8qfSLnD/RU/VyV3lFwgL79KYLkzn88gRNbkTwi4nExTFmFVuBpsSVH1j5xZtmcE6CAQHNouGMOYoPKelJhZ5DfJRru8D0rjiZ1MZsGdVe6C7BdLkx4FJpnCaYAVQ3Rxb+IcWHW7W+sVBLivw329hfPUzQb0AfT7sMXlshm6h4dHUx1p9UfBR1JpUST1ihRkcUOXkcn5IBR3sy4kTFYDO163+26qBoKLDWtiK6Q48U6cF5f8F6zHDVPweg5rxgYDxz7chJ+TIO9EPuLkMjFQJZ4Avq6d12xzMeeQXMI0vMpVbcLhc2coyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3w3+4dR9dKfLBFwa/KRyast3aRE24w6DpI/bJd2ecBE=;
 b=KjBt67lCRZKEVIoMWVvb4ZKa63eaQZpBHR2qhQddSLSAcBFJz3hBEofeYekHIXEqRQnRQzaSHLoywTU1MILruc3PDLQCHA7zGonmT2B3UT8zUhKaytUgsEvzEW/D2GIig/vd5N5kUPnS7LtRBv49etpskn6IUY3GBB6ag2ew1Nc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.11; Fri, 12 Jun
 2026 13:39:15 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 13:39:15 +0000
Message-ID: <bd6299ae-cd02-4914-ab1b-f6bb9d3d1b9a@amd.com>
Date: Fri, 12 Jun 2026 14:39:12 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] iio: adc: versal-sysmon: add threshold event
 support
To: Jonathan Cameron <jic23@kernel.org>
Cc: andy@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 conall.ogriofa@amd.com, michal.simek@amd.com, linux@roeck-us.net,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260611222738.2035062-1-salih.erim@amd.com>
 <20260611222738.2035062-5-salih.erim@amd.com>
 <20260612135222.0cec353b@jic23-huawei>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260612135222.0cec353b@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0077.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::10) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: d6b99447-3298-4a7b-b324-08dec887feba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|23010399003|56012099006|11063799006|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	lBZMA6gyjR5T+aIXsrseG5jln//Gkuy0qHdQ3l1zqqrYM6iKfNq5yYJJje7n4Kcd4YkndjtWRmXSlLlr6WzWwFThl1NuxtA6pm3CwsEmB2VHLHEoNSVrxutc2Jvv+wuZAbKd1oCGoqlfJUV5bxxibbNfIndrQirdEzDPpcWvVgNb7Jtd3m4xMC1xh/Kc1ZF/VAnywTt0cOAwtWOmNZ1pgROTEUkIOjCNgG/cDopSBb8kZNkHr24SmKW+637gydoLHGibZHrGNXvvTFl+IPh+vDI81COLGHUr5MpmhhY7v5Wh2q1JXcYzByQAmTO01AyQZA0kuuixJboNN+0F8nO7/jZjiMtr5RPTADiyi57wkSDCnD+eQKBz+U5hTpvJgdJTA25/HU8HiOTwjMpA3YlNjQbAFJZUf8fGncqeDbmRJcrBO67P44CXX9Ivjw+fTzqe9kofnRCb2W3E5IFzWVNR24KxM/eKLClq0qN993wBO2EXW87Kerkp+4MMMOTHt3iAh8P+ppm+3KXR8yP3KRMM+wajWC3o9UqCEKAfhVXKFDmBT0hd/kpo4/ApZJysrIO+t8tNKsmc6GbvdJ6XPiB4/SFy39kvrp5Vb909zxJVuLeV2emmsUHljaq53lAtj5VM/VcjsSinGMPpS/UAYLrI/A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(23010399003)(56012099006)(11063799006)(4143699003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VS80eUZ5eHpVSFBUQ0RVVkExcG5WYUQ4eUdKdUIzUG52NmxBeTliTEk2dWx1?=
 =?utf-8?B?SzNOeGdRVGhkM0kvQXNwOGRvSFRPdy9OUytTSUowZ0I3eHN1SmJHVm9nb2gx?=
 =?utf-8?B?V3oyeUQ3MkR3MkMyRkpDU1p3NTZzOCtWT3UvcnlaUzBUOGN5Q01OZVFjRTFP?=
 =?utf-8?B?dE1OeitRaVFibk1BNTcrdTcwYUVBc20rMFlwM1JCSktLTEhITEFpZjh3VUdY?=
 =?utf-8?B?Ny90c2FiRmtuNURraWZlc0lTeXRtY0V5SzRYc05KWVJKaVhzRE9DWExlTkFu?=
 =?utf-8?B?NzBoNmJoYXY3Ry9KU0dkRm95eW4wbm1oN0xXWENTaWxrUXlubEZjMjdhajRT?=
 =?utf-8?B?L2gvbWhOZjdEQlk1MjhFamFUdHFOUWI5QVdUbGhhclBTcXhzaTlsRHllUjJk?=
 =?utf-8?B?cDlTSWlwcjYwdjRoazVsR1ZZYmdrdnNGb0RDbjdXQmw3WG9xbWVxaE9TM2h5?=
 =?utf-8?B?RnhOTTh4clY4MkRVK0RwWEFZcFg4cEs0U2I2Y3J2U2ZoOWFqOHlPT1d6UWxJ?=
 =?utf-8?B?dHRuR0haRnJ1NkRtRlBnbzdLOXVGTEF0a0pyQTFlWWY0cUJCb2llUTVla0M2?=
 =?utf-8?B?MGo0dUI0WWNrOHora2hRRm1aZGdFOE1GY3p0VnZ3Z3dKditia3hySGZzb3hu?=
 =?utf-8?B?QmJlc3k4dWR2UmZpdXo0d21Rd0FISnJ6d2FlMFhhTDJsSkJwK01mblFoL3FD?=
 =?utf-8?B?VkgxNERaUjV1dzdoSVUwUkNKL0ZOSGRCa1U0NVpJd1R6eXlRQThRMXFjS3pY?=
 =?utf-8?B?aG9HcEJ4MWlGRGZVMmMyU2lSdS9LcGVjNHk0MGVZWVhMQVJUQ3hYZXNsZzR5?=
 =?utf-8?B?QWtJVzh4eFprYXU1VytmTHpjMnBKNy9oZVNPN3daanBNT3pESjQwWStPNUg2?=
 =?utf-8?B?bDdRalBCYWNTU016QjlCbzBLVVVtRmhLdmJqSGFyTW5DdnA1T0lQZ3NHcjRv?=
 =?utf-8?B?eFBZZ0QvRDQ1RWhjQXNoUm9CZ09TQzVxLy9DbzZUNVdxKzZWRng4L2lZTmNJ?=
 =?utf-8?B?R21mTGQzemU1Umk5S1FHdTBGS0JsbEpGb2wwdGxUdHFoSC9OeTdmcmlkdE9Y?=
 =?utf-8?B?OXkrcENlSUpMVUpZK1Q1RkNzNnlDckE5eXR2dmllSUl6TVZOYjBFY2o4K0t2?=
 =?utf-8?B?YXdmYnlnNU5vVFVRWk96MnFGTEFPNGNoTFVMV1MwT2hyZlRwTkU0WkxKRHNU?=
 =?utf-8?B?bUlHYTBEenhwT1hVOXdyQytpZml1WmppcHg4dXhtSFFYeHg0akZ6dk1DMzFh?=
 =?utf-8?B?WTFzMDlnUGdidDNGMm9IbzhndHhldGh4OEdCQTR5R0RSdXhTeTZQeUxaOElR?=
 =?utf-8?B?WStkNHN0RXMxa2Y5OVdFNEc5S1RGQmxVVjhCMHQzdUhnb0RuM0tVN0NvZzd6?=
 =?utf-8?B?VHVmTURaNE5sMlV1RUZCZ1U4L2ZpTnV5Rys3SlNsQkV2Tmo3R3RIUG0xUXpR?=
 =?utf-8?B?UnozdWc2ZitWUTRLUXNrWGNlaHVpMERRMDUrNmZDUzB2dkFSQTVYMHJsaU5P?=
 =?utf-8?B?b0VBZ3ZoK3NFbng4Wk9hMitYSURwcThsSVBxZ2psanQyMGpFdTdBVEZGV080?=
 =?utf-8?B?ekhGcE9URG9hZ1JoOTliRDJDck94VEQyRlR1dmloOVVDaWFCUHlxM0VTOXpy?=
 =?utf-8?B?Rmh0d3hmUlJKWGFBMS9oc3BoWjRZV1gvYmxVU0QvRG0relo3UG8xODNMZmxa?=
 =?utf-8?B?dHhPQWdaM2g4ZGdWeVZVV2U3UUZaWEQ3Q2VUeTRzcmF6U3hHa1ZiVHJyR1hK?=
 =?utf-8?B?bWs4OG1rclhFaUZqL2FINVlhazg1WjRmREduNlU5NVlhdFFaRW1JbFVUdW5h?=
 =?utf-8?B?UCtJczVwVlRoTVl6MUtFcHNDSlRtK1ZCTmhQQ2syWHNZaytMYU4yY2gwTmNu?=
 =?utf-8?B?dE1xZk1nd2lTMk0vWWJONkNzZ2RtOFRXYjlwdy9LVEdsQS9ndlJGWTFEOERx?=
 =?utf-8?B?NkhTSGtHMS9IK2EyemR6OSthdzJ1cU5EeGNtU2puaGdtZlErVHJpSVpvRlhV?=
 =?utf-8?B?cmtkc3lGS2NJbWJkcmJzTWFCRlYxWWRSZGpXWmhvV29MVWI2ZjVzM1pvVDhW?=
 =?utf-8?B?aDNrRVR3dlJqS21yU2lZNStzQXhsRXJ5VlA0S1JhTytJd2FGcUdGSEZWR2lV?=
 =?utf-8?B?L2ZBNTJwVHRzYXQ2elBmRVJnTVFtcVlWeStPSGdISmNhQ0pGZk9JNERZditO?=
 =?utf-8?B?MUZjeXo5VDVTQkh4Q0V6R01iREFXWDZnWGNpbXNkY08vWng4ckpqTFpLQzQy?=
 =?utf-8?B?WTZLWEVTT3RsUmZKMk5Tak9yYlA0cm82SnZ0Vksvd1J5anF4WXNsZDY2eGl0?=
 =?utf-8?Q?80EIjyiyPcCSIrt0Ps?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6b99447-3298-4a7b-b324-08dec887feba
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 13:39:15.4802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DOysjC7G62wrmqG5jy2WfsV+1JHVIMMKbnad51CeQe/CG1bPtLoZDu3zJFMiXI6F
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978

Hi Jonathan,

Thanks for reviews, replies are inline.

On 12/06/2026 13:52, Jonathan Cameron wrote:
> On Thu, 11 Jun 2026 23:27:37 +0100
> Salih Erim <salih.erim@amd.com> wrote:
> 
>> Add threshold event support for temperature and supply voltage
>> channels.
>>
>> Temperature events:
>>    - Rising threshold with configurable value
>>    - Over-temperature (OT) alarm with separate threshold
> 
> Ah. I ask about this below.  If this applies to the same channel
> as the main threshold we generally don't support that in IIO and
> definitely not by introducing a 'magic' extra channel.
> See below.
> 
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
>>
>> Signed-off-by: Salih Erim <salih.erim@amd.com>
> 
> Some follow on questions on the temperature channels and one thing
> Sashiko noticed that looks real.
> 
>> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
>> index c875d156dbe..20fd3a87d44 100644
>> --- a/drivers/iio/adc/versal-sysmon-core.c
>> +++ b/drivers/iio/adc/versal-sysmon-core.c
>> @@ -11,7 +11,9 @@
>>   #include <linux/bitops.h>
>>   #include <linux/cleanup.h>
>>   #include <linux/device.h>
>> +#include <linux/devm-helpers.h>
>>   #include <linux/err.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/module.h>
>>   #include <linux/property.h>
>>   #include <linux/regmap.h>
>> @@ -19,10 +21,19 @@
>>   #include <linux/sysfs.h>
>>   #include <linux/units.h>
>>
>> +#include <linux/iio/events.h>
>>   #include <linux/iio/iio.h>
>>
>>   #include "versal-sysmon.h"
>>
>> +/* OT and TEMP hysteresis mode bits in SYSMON_TEMP_EV_CFG */
>> +#define SYSMON_OT_HYST_MASK          BIT(0)
>> +#define SYSMON_TEMP_HYST_MASK                BIT(1)
>> +
>> +/* Compute alarm register offset from a channel address */
>> +#define SYSMON_ALARM_OFFSET(addr) \
>> +     (SYSMON_ALARM_REG + ((addr) / SYSMON_ALARM_BITS_PER_REG) * SYSMON_REG_STRIDE)
>> +
>>   #define SYSMON_CHAN_TEMP(_chan, _address, _name)             \
>>   {                                                            \
>>        .type = IIO_TEMP,                                       \
>> @@ -34,14 +45,87 @@
>>        .datasheet_name = _name,                                \
>>   }
>>
>> +#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _name, _events)      \
>> +{                                                            \
>> +     .type = IIO_TEMP,                                       \
>> +     .indexed = 1,                                           \
>> +     .address = _address,                                    \
>> +     .channel = _chan,                                       \
>> +     .event_spec = _events,                                  \
>> +     .num_event_specs = ARRAY_SIZE(_events),                 \
>> +     .datasheet_name = _name,                                \
>> +}
>> +
>> +enum sysmon_alarm_bit {
>> +     SYSMON_BIT_ALARM0 = 0,
>> +     SYSMON_BIT_ALARM1 = 1,
>> +     SYSMON_BIT_ALARM2 = 2,
>> +     SYSMON_BIT_ALARM3 = 3,
>> +     SYSMON_BIT_ALARM4 = 4,
>> +     SYSMON_BIT_OT = 8,
>> +     SYSMON_BIT_TEMP = 9,
>> +};
> 
>>   /* Static temperature channels (always present) */
>> -static const struct iio_chan_spec temp_channels[] = {
>> +static const struct iio_chan_spec temp_channels_no_events[] = {
>>        SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
>>        SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
>>        SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
>>        SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
>>   };
>>
>> +/* Static temperature channels with event support (when IRQ available) */
>> +static const struct iio_chan_spec temp_channels_with_events[] = {
>> +     SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
>> +     SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
>> +     SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
>> +     SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
>> +     SYSMON_CHAN_TEMP_EVENT(4, SYSMON_ADDR_TEMP_EVENT, "temp",
>> +                           sysmon_temp_events),
> Is this not an event on channel 0?  Why does it need a separate one?

The hardware has two independent threshold register pairs on the
same DEVICE_TEMP_MAX measurement: a TEMP threshold (ISR bit 9)
and an OT threshold (ISR bit 8), each with its own hysteresis.
We modelled them as separate event-only channels because of the
independent HW registers.

However, you're right that they don't necessarily need separate
channels. Both monitor the same value that channel 0 reads, so
the TEMP event spec belongs directly on channel 0.

>> +     SYSMON_CHAN_TEMP_EVENT(5, SYSMON_ADDR_OT_EVENT, "ot",
> 
> Why two separate channels for events? Are we dealing with two separate
> events on the same signal? Generally we don't support that for IIO because
> it's largely meaningless except in hwmon usecases - what is the point in two
> thresholds if they are reported through the same path?  Just use one and update
> it if you want to add another level of detection.

Yes, both are thresholds on the same physical measurement. OT is
a higher-severity threshold that can trigger the platform
management controller to initiate a hardware shutdown sequence.

If you agree, I'd propose for v7:
   - Move TEMP threshold event spec onto channel 0 directly
   - Drop OT as a separate IIO channel, since it's a hardware
     safety mechanism better suited for the thermal framework
     as a critical trip point (planned for the follow-up
     thermal series)

Happy to take a different direction if you prefer.

> 
>> +                           sysmon_temp_events),
>> +};
> 
>> +
>> +static int sysmon_read_event_config(struct iio_dev *indio_dev,
>> +                                 const struct iio_chan_spec *chan,
>> +                                 enum iio_event_type type,
>> +                                 enum iio_event_direction dir)
>> +{
>> +     u32 alarm_event_mask = sysmon_get_event_mask(chan->address);
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int imr;
>> +     int config_value;
>> +     int ret;
>> +
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
>> +             return config_value && (imr & alarm_event_mask);
>> +
>> +     case IIO_TEMP:
>> +             return !!(imr & alarm_event_mask);
> 
> Sashiko made a perhaps insightful observation here.  When the interrupt
> is masked between sending an event and the worker reenabling it does
> this give an unexpected value to userspace?  I think that condition
> we'd kind of expect this to return 0.
> https://sashiko.dev/#/patchset/20260611222738.2035062-1-salih.erim%40amd.com

Agreed. read_event_config currently reads the hardware IMR which
shows transient masking state during the 500ms polling window.
Will fix to return the administrative state from temp_mask instead.

> 
> I think the rest of the feedback is probably false positives or debatable
> stuff but this one rang true. Please do take a look at the other stuff
> as I may have missed something (maybe the comment about needing to disable
> event interrupt generation is true?)

Good point. Will investigate whether a devm_add_action to
write SYSMON_IDR is needed on unbind and add it if so.

Reviewed the remaining Sashiko findings:

   - Integer overflow in threshold conversions: for temperature,
     the Q8.7 register range is -256C to +255C, so any
     reasonable millicelsius input fits after the shift. For
     supply, val * scale can overflow int32 above ~32V, but
     supply rails on Versal are well under 4V. Extreme sysfs
     inputs are outside the hardware range.

   - I2C + IRQ panic on misconfigured DT: if an I2C node
     incorrectly specifies an interrupts property, the driver
     would register a hardirq handler on a sleeping regmap.
     The binding does not list interrupts for I2C, so this
     would be a DT authoring error.

Thanks,
Salih

> 
>> +
>> +     default:
>> +             return -EINVAL;
>> +     }
> 
> 
> 
> 
>> +
> 

