Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011068.outbound.protection.outlook.com [52.101.62.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09ACA78F39;
	Thu, 18 Jun 2026 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776392; cv=fail; b=pPrOXzj3Xe5/XXNTq1pCK51s5M9dHr58Tk74ZNQmW+Y9AK1VUTSFtVVxAgU2CwSSCDRDi8Y8cGyO4Sb1/SQx7ke6FMXlE+xYq/kkjdODmoUyh1UlBqZH1g2mQjnDRf5R82wbK2/vWPgtimyYzPNLzKJP35sfgRZ7AOQXYwz9SAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776392; c=relaxed/simple;
	bh=RzPtrwYj6oLQxcymsSvPtneIjZjFXmnjZMzFxlgoFx4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cCx3ogzrTk7VxiXPzWHfzcmGl0q9xYYuEaujceOvxko6NU62QqcdHzM64AqLLuXGAA+kGUSsKbKnFxhFZ0S/wMzwMqabbRxIcaQhLxaEejpnoa6Jzb0M5zNmVuV/uQVZnB3+iFyo7PIsucuNhE67YzQ97p0guG2yJ6Wp2FPS4WU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lIt/sX6f; arc=fail smtp.client-ip=52.101.62.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lIt/sX6f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cD43s0CCZjyVTEV+IOA7JbO7pdAJJU1/oYJ3AjZ2iZo34ohAoplDJGzLePdrKWqgWRCl9cnQn3Vi1DumtkWkLSX47s5n3VROWgt/gAg5zG0zlNS+ssgf/75vH0nxh34bnAuNQpUrniJjL26YPePGj9SMgeuZbOf3Uxu26YP3b4tyWt2MSqGX5Z8D9ioXxOzJIYVczOJm2R/ZPreAs2NsFpl2uKtZWwcyPOHq490phcIUPVMgSazpq2aMDeq6KEGJKMuHbb2bjDiMb2lfma2ObZaLO20RyEZrtgVPDjaaDPJRQAVFlD/5eRVRR2/+JVtNmwBzw8NeLE0/fVvdQlD+FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DuX9Ex0M2PDJd4ngTDTAueXq/8SdlLnJMKP+p67YvBg=;
 b=Q/KGx0qJPraA6+3Orj6qnL41HtHULJSiRypfnhbEVA+wH6o9d9acPpTPTQw9akNOrzDlHuZd0jdOKMyXfVwSOD3uInKH0BxzpdNjiXCsNMNJSkhaOZPUdetHraoN3dPJr/eBcUpR8oR4+QpHHZ74RT4ZLQksDOQal8FNQXuk2z/GTBdULVE1337pj9/zWOMX0hoLEooJFgB7Q5oOKXa5itayqZgmVDkZ4z5TLBMnQgFJPoJmR53dAsxhNtCX6dixgp8vo7m6hzpHuAx8M/JKEBL/31z4uXKPXzENacEgN7+FpjWHYyZwYQLs7zxq1iM7vX1nJ1ZJGuYgUEoy5JFh0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DuX9Ex0M2PDJd4ngTDTAueXq/8SdlLnJMKP+p67YvBg=;
 b=lIt/sX6facu+f79tTC62dFH+rL8Vyks7vOQfMmnW128KC8hkGmtpVDzrhXH7wQZgEOhRjotuoON56Itl+n57lX9NsMVtC7q7VnHHyAVfokX+0IpAvxB9kmAZOR63j1pGd8VDF6RLZglZdPqhYbDR3sgqOKrQUk01elEGmix6Epc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Thu, 18 Jun
 2026 09:53:05 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.009; Thu, 18 Jun 2026
 09:53:05 +0000
Message-ID: <015fb0c8-278b-4181-bfde-a741aa6688b8@amd.com>
Date: Thu, 18 Jun 2026 10:53:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 4/5] iio: adc: versal-sysmon: add threshold event
 support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260617180147.3370346-1-salih.erim@amd.com>
 <20260617180147.3370346-5-salih.erim@amd.com>
 <ajOZmLSyaZuoPcbI@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <ajOZmLSyaZuoPcbI@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR18CA0007.namprd18.prod.outlook.com
 (2603:10b6:610:4f::17) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 48f0b304-4580-4784-c85c-08decd1f64c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|11063799006|56012099006|6133799003|4143699003;
X-Microsoft-Antispam-Message-Info:
	8+jFfpi/vfUSbnrYvdSA9SCZTKg7O8jARIJtlZgaG3N1Q+XpUcQEnRifqAtdzAqQf8eokX/DOqXnBBwWQujAvxq2ZdNkjTZXqeYnWiaQpYepmkjkJ1s8XyLMlyh9Yr02hlImacgBCT4P+RGwxeoo8BHsdbuz7aZPgfuMsB29E+crJYsff2maDZi6eUBH6swBiZDXpDMIVTJBkEvY1eY4cK5nclhINjl73t1HYzhLjJSM72dY7Y9IGWYACs6TkgeTcV+ANB73j+6SuStuG6O3lJoVRQJ89m62xYXf3vMGVYfnCK1yKsy1oGV0GYj+orw55TNxCF3THfQ0qrM9bXwIGQjMPuI/banPQa80Pr+St6NsCc1FOHiocUWzHWJtZ44rBpYavcEF/L0lXR7V/G4NIn5/KDs9E9MLuhRc4XgMpLi5Yi1AYx7PS1aiC3aWM8S8eISR/BJcnax5/bFY3iIThN28tfAcLdAmOq+IS1lV6f1wmJR/hMdNFvM0RVLvvRCcV85m2Tl6rHxbPM+X7/VtJdiyMnyNLtU4ujSLi5qD4uVcgZdt5l680PIg1XwaxHARUHLuUqprKA35Kk4REzOXxRhfZyrjVCwqzImJBdoGmRs9w0Q7HbTyWzZPnQH0YB+NcUIMsmuoqrLRFB3ksyn1q6fPSHUtPHR2EDViFKSHDSSC6DB9mu61UZbrAsBMKDsB
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUJxcnFHSTcwRzlwK21CckFkSTM4L2NnODZXRG5kYVlBaThXQnlMMmtKdEEv?=
 =?utf-8?B?MUhtM2paNnc3Mkp1TVcxS3czMFl6OGowaGNFemd5eEsyUzU0YXc4ZTJ6amZ0?=
 =?utf-8?B?NVIrQjVtSE5sOERFemFodHIzNXhBZXdFblRCenFRSERMMGhjZTNYSVhNb1g4?=
 =?utf-8?B?and0cEpFVGhHV0NkYzRnTFdkKzlvYVl4Z0NMbkVRRDFIcllUSnZ1ckcxTGtR?=
 =?utf-8?B?SWhIZFJuNzVqRWNHQXBmSEdoQ2tyYjJPcytpcDQ5Y2tDVS9xUGJJVTZhS1Va?=
 =?utf-8?B?ZzNnd1RZbmRMUm9vVEdTRmw4ekpnVTFKTzRXcE9QZ2x6UDZ5N0loV2JqbzBY?=
 =?utf-8?B?T0hrTDBJb1JlbHVlaXpwM1REWFczbVBWWWJOVHBiR2NTRFFRTmhER005Z01G?=
 =?utf-8?B?bzZhdCtnYXQ2cGJyRVV1UUFDeWJnSHRHQllTaVNadUxuU0NSbitUSTI4VTBB?=
 =?utf-8?B?ZlRzZW41UlliNHJUTWlvVUl2d2pnN1dpdnlDaHo1TTJKL0hlcXZUVExpVURm?=
 =?utf-8?B?UzNqMUdrVFdtN3VZOHB0dkUvVURQa3ZHUXdGMW94b2FPUzlnQm1GdUZneHc0?=
 =?utf-8?B?c2RXRElZTlpKa1VKeW01VkFKdDhYWkFFcENjMzJaWHJZanV0RDJLK1NZQjEx?=
 =?utf-8?B?K0VSa1pmNkhQNnFLcGRQeGIyL3FNVmx5M01weDFuTzI0WEVxVGR4TTVhVFk1?=
 =?utf-8?B?aWRHK0dqTE02bFhUZUZzamhLL1FJZzFDVk42TFJCSG0vSm9SLzB2elV6eHpQ?=
 =?utf-8?B?RHpPaDIrQnpsd1lHYm5TdWx1cjJMTEpCYkN0VWlyTGhjUnlOQUhhTjhCU284?=
 =?utf-8?B?NTgvYnREaE4xU05ibXgyMEpQUFpJZ1lBY0NlU3hkSUVnL0NsYXpNNHgraVBF?=
 =?utf-8?B?SlhjdFJqTHZZb3hzM25XWkJiK0dHbW5FcFFJSEtrVExpRWoxSTh2WFJDbEFq?=
 =?utf-8?B?aU9yOHFjVlNlZDFJdGlZc0R4VlJWajRjclBUMm8yaFRtbVdad1lxL2twa3lU?=
 =?utf-8?B?U0NXdmZtM0FOemZVZ0l1bWFuZ1FwSnRNbjQxT1pDb3hvaE9jT3pvMXRMRXVV?=
 =?utf-8?B?aGU0ZUEyU3BBZUZ6NTdUeGorbHV3WWtDa1JvQmtRU3Ayd3lWSFg2dW9WNVNH?=
 =?utf-8?B?bjNFZ3FqemlyY3NkWmJqOGdleFRDMGo4aTNuV1BTc21samxtdE11TnhVVFBJ?=
 =?utf-8?B?MWZEelBINUhmVEtRbHhramZSdlA3ZHh2UWpKMmhiREExRXRwQmFhYmRtSVlM?=
 =?utf-8?B?Mk9hMnkxQXFHaTNEcVNYUDZXUVh5TXcxSDh0NjIrUjZXWGsrZHVXbFA0ZHFQ?=
 =?utf-8?B?d1pKTzBUVjlrSmRYck11bVRwOXVZYUxDMlhsRmZZd29qR1Zoc2pnVEYvWk1K?=
 =?utf-8?B?VWN5UU1Ga1VaejgrNjF1b1Q2Z0daU0NQalZZeVdqTVVJTUs0NWNHVStxTGoz?=
 =?utf-8?B?RU1QMWlnTVdZMkQxL2JZTWNUTUJOcmV2bVpBZ21wNERYY09WRnJZU2dGS0U3?=
 =?utf-8?B?QUMyM1BleHEyWWMzY2szRlV4aGhrS3NiNmpiQ2hxaU1Qbi8rbXlnczdFNTNy?=
 =?utf-8?B?aWdSWXF6TGptcVpYZS9CN0t5bkpUYnRFRXliSE4yK1VFSVd4b0lab1ZpZEZj?=
 =?utf-8?B?dXFrSzM5UDR2bnYveDQxbDdhd2p5ZU5nTzhuMUlVOUlXNTcranE5WlNJS1d0?=
 =?utf-8?B?Z1VNZFJRMC9QM2daL1U5b1ZFMlNMWTUvVms3MG0rM01vU1JjT2VDRXZHd0JL?=
 =?utf-8?B?dURwNmV0YzBJVEdtemkycXlZbVVrbkFHOWlEeE9VU0VWR285TDJIWEVtVmEx?=
 =?utf-8?B?NVFLRktVY3FzenVNQ09qN05oVGljdG93bXFERHFNak9lZTlMRE9xbkEzZnR4?=
 =?utf-8?B?VDBrQ05jT2kyVGdmbHBSRzU4bDFrTW44ejA5bEw0Ykw2TTZhL3crcHkxL0NY?=
 =?utf-8?B?eDBRTTA1a2FpZzh0NEZ4clFXcU5JM0tVZGFPdzFNZCtvZGFXdDFxSkcrNzRR?=
 =?utf-8?B?aThFN3VHTnJCc1QybGx3aldtczk0emRTSUNOd0M0cTRaWk5uWGljR1dVWnlx?=
 =?utf-8?B?TFI0TVY4NjJzdms1cUlTYUlVVnhDL3l1d3BxWHNjZlVGSTl6NXNsU0ordGJp?=
 =?utf-8?B?UzdpOG8xOStSU0k0b0RyQ0pmNHArT3ZRUlNraXlFWGI2bWJpeDFnSDR0b05T?=
 =?utf-8?B?NzRGRDZEZ2IxWEh6NmF5UW40NkhJNHNLMlZwSGpjL1VGazNGdmozZ3FEbk01?=
 =?utf-8?B?QWREMHNOTGU1T0MvVXJYVVhTR2d1cTNMYUEzZVQxL3BHTXY3NjdiNHBFZkNw?=
 =?utf-8?Q?GLuiAG0lwPIZRJ9Ns+?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48f0b304-4580-4784-c85c-08decd1f64c9
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 09:53:05.3320
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7kIdHfLOu0KHARyTb7lYZfL87p54XsDEIkAx7OhRy/O5WVLLWJ5hm/ep5PErx1IE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736

Hi Andy,

On 18/06/2026 08:09, Andy Shevchenko wrote:
> On Wed, Jun 17, 2026 at 07:01:46PM +0100, Salih Erim wrote:
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
> A couple of nit-picks below, otherwise
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Thank you for the review!

> 
> ...
> 
>>   #include <linux/cleanup.h>
>>   #include <linux/device.h>
>>   #include <linux/err.h>
>> +#include <linux/interrupt.h>
> 
> + limits.h // U16_MAX, et cetera

Will add.
> 
>> +#include <linux/minmax.h>
>>   #include <linux/module.h>
>>   #include <linux/overflow.h>
>>   #include <linux/property.h>
> 
> ...
> 
>> -static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
>> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int irq)
>>   {
>>        unsigned int num_chan, num_static, idx, temp_chan_idx, volt_chan_idx;
>> -     unsigned int num_supply, num_temp;
>>        struct iio_chan_spec *sysmon_channels;
>> +     unsigned int num_supply, num_temp;
> 
> Stray change, and I would expect to see all num_* on one line, and
> all *_idx on another.
> 
>          unsigned int num_chan, num_static, num_supply, num_temp;
>          unsigned int idx, temp_chan_idx, volt_chan_idx;
>          struct iio_chan_spec *sysmon_channels;
> 
> TL;DR:
> in this patch the above should not be modified as the previous one should
> provide already a nice structure.

Accepted. Will restructure in P2 so P4 inherits cleanly.

Thanks,
Salih

> 
>>        const char *label;
>>        u32 reg;
>>        int ret;
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

