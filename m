Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E371F1891A9;
	Thu, 28 May 2026 22:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006746; cv=fail; b=P2znIdIBxOhWrIMRFJhcBkPcV6DQ9ui9sCu9lrr7XiTn2tuPdznYSyXgyXmbLTM/VMN3WJfQfvlue9B7cZa61zkYy7RFwsyKHTcv7PTiC62KY0EPhRDmCVYTSLoXoomUW2b5L3HR2lRNH0lhBj53Du5S1eMzgOac+DwuVf2p8jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006746; c=relaxed/simple;
	bh=jk4dUUv28693syezCH8aGb6Ex+5kQnGzhy3hmzXXd2E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZEHYUNqQLLCBNE0xC3hdOzHUEVs7NQlp3z/MQ+BMafolzbpWU5uOSrb7B0mawjU3kjtVFErpU9Om15eKYENgtqQ/vWntQD41Sh2NjBBOr70Yg70ZAUsO+ER+YqL5KC+4nu9eHWjCzSttS5YzxXymd1ifhNV3V+nPUskv0PEADhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ap2lCPtz; arc=fail smtp.client-ip=40.107.208.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ap2lCPtz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YN6I2vFH+3eDK3UhPya2Xi/CGo11u3km9qhD7s6bcOSHz7n7jybWKyZVK/rPSBA4rDZXi953RmqgTl2ZgoTiaHjOrCSv9L3O9CIT6/N2E0sFtuncTYcImnILpJI2NSXYmUOGGLbnqWkXyye7634qjoK48upauP69zfT/0v9V8tUywWjZDrw7W2bAE4zKTPXMRWCmDZzXUPB0CjyF7UP0ajHQYiZuBvgDpNhaR0z1E1m5FukGR75Oa1TfEXI5AIishKAEmw3DfCJ3tYutlLJnD/RqHYfTnWWREZtpXVi3sQvfpE8sqursEh+2g1roX5oaJ1fbxUoE1ueGPlWizHCiwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBM/N5l8Rrn9sUueq1AlmksHVETDPKqgwFoBZrDwdsU=;
 b=v4ddibhAfyjm5x2anJy4p/5AZteG9HgyZxtaNgI060CBdaGo2SXuK5QZUB/U++uSGd0rXNTMa4InygMbnvYkTUM0Zu8eJKrhlq5FvwXN/2PNlijFgfpTrDtCRp0GCZN1klf0rTr5+Vw0p7KT8yKqrDHwlSpv3+99duoon/RzvqmRrax+y34BnmgWIHHG8H1UJqy9ndC2VQCCbpuB21b+Q2lgSYlTPQfUPiRGgUbwdFyU8RMAQnq3QIls74ggpB5QQe6swhPQ2L6CHrEZa9TJAPemgK36MRZs9lb24u0KxiYdYZKmpaWbR3lS8PGy11AixwdUfs2e20d92wyBPf7YoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBM/N5l8Rrn9sUueq1AlmksHVETDPKqgwFoBZrDwdsU=;
 b=ap2lCPtzHZlnzJ/mII9DRHdOOUJ147LfM7gpBaq1BpREJUJ7gDV/wkMN3j9DesnEoGwna9vgASgs8JLWJuNgMrs83SGe+dALbCjCE4M0H2Aoev6ogzrcKSoy6OgnRl6KGAiKN4BBroIX9be7IfWnsoVlmGqILK/Sjc1lyAd3+uw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Thu, 28 May
 2026 22:19:01 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 22:19:01 +0000
Message-ID: <95c462c5-eb71-43ef-9c44-e3d8b07886e0@amd.com>
Date: Thu, 28 May 2026 23:18:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] iio: adc: versal-sysmon: add threshold event
 support
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
 <20260527114211.174288-5-salih.erim@amd.com>
 <20260528140156.5cab0eda@jic23-huawei>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260528140156.5cab0eda@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR3P191CA0053.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:55::28) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fc1b499-73c6-4938-7bc0-08debd071ea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|4143699003|11063799006|6133799003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	lcgpGQLo9i5XsAWZtwWOjqeugkdf7I234pP7kmzuaIrXIz2efd5QDiE61lYP/LHl4n9EBf5Xf6Mfp6GXYXx3s9HSVnFOv0iBMvNczKrC778dkT00sr/0Q6c3CpfNf/74J1Iu3Z/7XbriBjlYUREbrAygVl7WtRarky2c+gH6Ms0dU0f9KJqcYbRWrqquXnFPo/kSvI5Ga3gNH+lz+20PVrorFMoTPJ0tng+xpgOG6cOV3ace2q7/ZhyJkMKxNHK67J+cPwj6c321w0UWuiZM9rWj7OqUX0WSDehXe9yNKAfGYA7/WpZhFKHV2RDo1FooyhkgpKaUIHyq9uV3j7J5L8cOxqrpeeALw0jt6Y3kTSxO/DujJVkW/1bZzexsISCRQlTbZnk32+dyyygIMBoMAcSpGOgwI5RfX9ziui62Y52oh0eeqUaJTqz4l322AksY8iBgsrzXhuBcn9KiqipGVtu/ZpzrJUxV3C49ocajEjB8MEYsm4cNg1wC+OGkTkgMJs36qsSM+341j2J1L4/Aexx6vzwbNKM2ILJWLlMudm9qcUbuaEdRT6BKidkwf8h700yWYPwqFmykO76aKLPQKWGtmcDa76ngT+PKjL/f4QZJKWTtN7QdL4PT99nLSSPe+Ej9WvXYBGfEtCeSdd9QqWQVmzOA6l/Y2MzqZ6SKiQdPLGRvUBCsu6zAg69gIiiq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(4143699003)(11063799006)(6133799003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmpKZElBcmhYRnBNaUZKSTk2RXZKNERvdGo1YmpKT2hPQlJDVE9NS29JaUpT?=
 =?utf-8?B?VXdPcHdUYkpVMGdSUHZTczgyaVRhTkxBYmZzOEZDdHE3dk5mbGU0QWJlcEZX?=
 =?utf-8?B?TnNGdkNHb2ErQ3l5Q1h4ancyOFBGMTdHdUdqbUdxNi9aUHNJa2I5ZnMvS05Z?=
 =?utf-8?B?WjVKSmhQVDNSWVE2a243YkZqWU11bFhET1dqZ0VyVEI4ZmVmV2dZWGxTVlZV?=
 =?utf-8?B?TjZjbjluaTNJNDhkMnRERlFSR2JGSHJpRDQ3YWQ2Q0tjQklxWkNiZ2IwQWU4?=
 =?utf-8?B?WnNQSzBhUWZadW9HTS9BVFVtMWNWZ0lxcGk5MFlWc09lMDlHblRHdDRxWDRM?=
 =?utf-8?B?cWZXakNNa2xCbVNVcjVKY1RvL0hqK0pGZFZxb1l0eVkzWUMyaGtLd1kxSnZX?=
 =?utf-8?B?K0dsR0d3ME1Yb2R3SGNoSnd1YVNucXBpL3R0eDJDOVhXbEU3aHZZRHJiMmE5?=
 =?utf-8?B?RTVRTTNnNktTdWpHVDlCYmE3eThzTGVIRTQwVVBaSmpQRWg1UDVWb1gwSnND?=
 =?utf-8?B?d0pIUkJCYVkzS1hYN3E0alFmY3dKck9zdTVWY01WU3hBSkVzTnc1OTdtUUdt?=
 =?utf-8?B?bGxWZkhvVVhsTGpqM2drNWlJYlZzbWorWFdFb05zQVVudXk1RklUUjNPNUsr?=
 =?utf-8?B?eGU5Q3Y4cTNTbmgrVXgyUTZxVWc1dkJsMDQxdEZMeTFmRkxsWitkL3FDcHZp?=
 =?utf-8?B?TzhwQSttalJlNW5GbktYM0I4RldQMC83RzgwS2UwRVlnZUJYaVh0S3lDTWdJ?=
 =?utf-8?B?bTVZalBQOFU5eVFIUlh2cXRGT2ZnamFkL0VCNUlnektqeWY5NXQxM0c0Wis1?=
 =?utf-8?B?RCtaTGcyK2VpNmc1NWFlV3dFL1hXZmNjSFJQZ0tJWDdhUXRDeG9TUk9ZM0ti?=
 =?utf-8?B?Ylh1MzlIUXl0WkFCdEdZMUxoNDk4U1dyWW5HajdqN2Z2UC9aU3ZzR0ZFV2tD?=
 =?utf-8?B?R0hOdDhzaDRhakxPVndVbndESmR2V3lYeDVVUVpQREVrQ1FCK0hjWGgvRlJH?=
 =?utf-8?B?d2pRRXNiTVhOejg3VnNsT3dMakdMM2Vqejc3RncwRG5sS2lWTFEwaFpnejJV?=
 =?utf-8?B?L1Z1R2dzai85YS9BWEdHd2d5VEFDK0FERVk0SEVaK3BXbDNVaHdOaG1FSkR5?=
 =?utf-8?B?SEh6N2RMNzdFMkxXanRQRTJhL0dQcXMyUVpoSUl2STE5OGl4U0pudXM1R2tR?=
 =?utf-8?B?RGg0czJpdlFoM3ZsNnoybDVpdUEwZ3JzU3BaNVZCMkVyN1doaGY5VDU5eFdr?=
 =?utf-8?B?ZUk1eGk0RlNOWFdyQ20zVjVFRjZHSCtPMFM0cTFLdUN2YU4xWEV2VDRMaUJG?=
 =?utf-8?B?RFp1UU9iK0Y0SS9xTFNCRnlnQlN4VlhFQW5KMmZUWUtqd0JkMk9ydDJHWGZO?=
 =?utf-8?B?TFdPMVNaS0FNS1JuSnlDVzlNUXFUL1l2NnVLZWFoK1NReExjVGJ3aVdoRFFD?=
 =?utf-8?B?ajRHYWNORFJOZ1h2Si9ZTUpOSGRIYmt0SDJFMktQWm4vMFJ4aFpEOE1mazRV?=
 =?utf-8?B?Snd5b2ZQdDAwTlRYdmNXZ1FhT3NGQUVBNjZPU0ZiUi9YTzVjOHlMLzcyb21W?=
 =?utf-8?B?WGd0bXlJeE5Ib1lXNkVhWGp0SDNjZDRmQUhQSjh1ZEpiK0NiRlJsL3U0WGVN?=
 =?utf-8?B?NllDZlcwZ3RZS2Z6SjhYbjI1Nit0YkRXeXhEZDFoeDNUL0k4S3dRMSsxY1FB?=
 =?utf-8?B?cGlWK1VEN3g0ZGJ6REZuMjNxY2V5Ni92RmpwNzliQllKRVdvM3ZrdXNXL2wy?=
 =?utf-8?B?ZGFvbEdwSWxKM1FJMzd6MzlSUUFTWU5JTVBPVjkrMWpKRVJSdEdMN0lMK1Rw?=
 =?utf-8?B?aGxHbzQ0UmduRnN0SlhjRUVIL2k4eUdaZkkyclF0cGZBNlRYWWVrMDlibFpY?=
 =?utf-8?B?TFNYME5DNHdSamtJbFd1VDl3ZkxpZnJ2MGV3WU9WYW5lRk44MjhlVkxhT3NJ?=
 =?utf-8?B?aWtoL1Q4OE9IaGlvcXVhU3hJUVRMNlFhcnp1UDFURVFoZkZQY0RKMzMzYzVQ?=
 =?utf-8?B?aFp0SVR0NGloVWxFRmZwSjBpYmNQbFhqL0ZFVzNvUWtoMDM5RWhheHcvRmtN?=
 =?utf-8?B?N3dtRzRDMjZ1L3hiSjB5dXZQd0FQUVMwNjJNcU9ENUluWDYxcTd2b0xXZDk0?=
 =?utf-8?B?SG8yczZWb1FRMTVxSDBsS01MWW1TQUhXaXlpZW0vV080dUlwM2Jpblk4MlZt?=
 =?utf-8?B?dFZ6eU1IYWUvektDeERsdE5PQU9nanFrTk81c1pvV0ZCNXhVclJPLzJzSTQw?=
 =?utf-8?B?dGlyTjBULzRScisxcERaTW1oUG5HQURnTFpuQzhBb1MvYlhZdWprdDZyNzAv?=
 =?utf-8?Q?U64vtVRS+xvcIYcLfX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc1b499-73c6-4938-7bc0-08debd071ea2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 22:19:01.1589
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B95eJa3AHozlvQZZugIqAD9GSFBgT9fLwDDJyXjQ7gZj9ZjevHJWMtYDh9IZ7jO2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492

Hi Jonathan,

On 28/05/2026 14:01, Jonathan Cameron wrote:
> 
> 
> On Wed, 27 May 2026 12:42:10 +0100
> Salih Erim <salih.erim@amd.com> wrote:
> 
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
>>
>> Signed-off-by: Salih Erim <salih.erim@amd.com>
> Hi Salih
> 
> Main thing in here is related to earlier question on _PROCESSED + _RAW.
> I can't see a reason to have _RAW.

Agreed. Will drop RAW, keep PROCESSED only.

> 
> Various minor things inline. In many case they apply in other places I haven't
> called out so look for repeats
> 
> Jonathan
> 
>>   drivers/iio/adc/versal-sysmon-core.c | 655 ++++++++++++++++++++++++++-
>>   drivers/iio/adc/versal-sysmon.h      |  48 +-
>>   2 files changed, 697 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
>> index ebe052f6982..04977c9c887 100644
>> --- a/drivers/iio/adc/versal-sysmon-core.c
>> +++ b/drivers/iio/adc/versal-sysmon-core.c
>> @@ -11,6 +11,8 @@
>>   #include <linux/bitops.h>
>>   #include <linux/cleanup.h>
>>   #include <linux/device.h>
>> +#include <linux/devm-helpers.h>
>> +#include <linux/interrupt.h>
>>   #include <linux/module.h>
>>   #include <linux/property.h>
>>   #include <linux/regmap.h>
>> @@ -18,10 +20,19 @@
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
>>   /*
>>    * Both RAW and PROCESSED are exposed: RAW is needed for event thresholds
>>    * (which operate in hardware register format), PROCESSED gives userspace
>> @@ -44,6 +55,62 @@
>>        .datasheet_name = _name,                                \
>>   }
>>
>> +#define SYSMON_CHAN_TEMP_EVENT(_chan, _address, _name, _events) {\
>> +     .type = IIO_TEMP,                                       \
>> +     .indexed = 1,                                           \
> 
> Why do you needs separate channel for events?  Can't we add the event
> spec to existing channels? For the constant ones you may need to
> have two arrays to pick between depending on whether the irq is available or not.

Accepted. Will merge event specs into the static temp channels
and use two arrays (with/without events) based on has_irq.

> 
> 
>> +     .address = _address,                                    \
>> +     .channel = _chan,                                       \
>> +     .event_spec = _events,                                  \
>> +     .num_event_specs = ARRAY_SIZE(_events),                 \
>> +     .scan_type = {                                          \
>> +             .sign = 's',                                    \
>> +             .realbits = 15,                                 \
>> +             .storagebits = 16,                              \
>> +             .endianness = IIO_CPU,                          \
>> +     },                                                      \
>> +     .datasheet_name = _name,                                \
>> +}
>> +
>          *raw_data = (u16)tmp;
>> +}
> 
>> +
>> +/*
>> + * Recompute the lower threshold register from upper threshold and
>> + * cached hysteresis. Called when either upper threshold or hysteresis
>> + * is written.
>> + */
>> +static int sysmon_update_temp_lower(struct sysmon *sysmon, int address)
>> +{
>> +     unsigned int upper_reg;
>> +     int upper_mc, lower_mc, hysteresis;
>> +     u32 raw_val;
>> +     int upper_off, lower_off, ret;
>> +
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
>> +     sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
>> +
>> +     lower_mc = upper_mc - hysteresis;
>> +     sysmon_millicelsius_to_q8p7(&raw_val, lower_mc);
> 
> So all the manipulation is in the units of _PROCESSED. Hence
> I'd drop _RAW.

Accepted.
> 
>> +
>> +     return regmap_write(sysmon->regmap, lower_off, raw_val);
>> +}
>> +
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
> I'd add a blank line here.
>> +                     ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +                     if (ret)
>> +                             return ret;
> here
>> +                     sysmon_q8p7_to_millicelsius(reg_val, val);
> and here
> 
> Generally keep block of call + error check for one thing separate from code
> before and after.  Slightly nicer to read.
> 
> Lots of other places this applies but it's a very minor thing.

Accepted. Will add blank lines throughout between call+error-check
blocks.
> 
>> +                     return IIO_VAL_INT;
>> +             }
>> +             if (info == IIO_EV_INFO_HYSTERESIS) {
>> +                     if (chan->address == SYSMON_ADDR_OT_EVENT)
>> +                             *val = sysmon->ot_hysteresis;
>> +                     else
>> +                             *val = sysmon->temp_hysteresis;
>> +                     return IIO_VAL_INT;
>> +             }
>> +     }
>> +
>> +     if (chan->type == IIO_VOLTAGE) {
>> +             offset = sysmon_supply_thresh_offset(chan->address, dir);
>> +             if (offset < 0)
>> +                     return offset;
>> +             ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +             if (ret)
>> +                     return ret;
>> +             sysmon_supply_rawtoprocessed(reg_val, val);
>> +             return IIO_VAL_INT;
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
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
> 
>> +
>> +     if (chan->type == IIO_TEMP) {
>> +             if (info == IIO_EV_INFO_VALUE) {
>> +                     /* Only rising threshold is exposed */
>> +                     offset = sysmon_temp_thresh_offset(chan->address,
>> +                                                        IIO_EV_DIR_RISING);
>> +                     if (offset < 0)
>> +                             return offset;
>> +                     sysmon_millicelsius_to_q8p7(&raw_val, val);
>> +                     ret = regmap_write(sysmon->regmap, offset, raw_val);
>> +                     if (ret)
>> +                             return ret;
>> +                     /* Recompute lower = upper - hysteresis */
>> +                     return sysmon_update_temp_lower(sysmon,
>> +                                                     chan->address);
> 
> Under 80 chars on one line.  Check for cases of this and feel free to go a bit
> over if it helps readability.

Accepted.

> 
>> +                     return sysmon_update_temp_lower(sysmon, chan->address);
> 
>> +             }
>> +             if (info == IIO_EV_INFO_HYSTERESIS) {
>> +                     if (val < 0)
>> +                             return -EINVAL;
>> +                     if (chan->address == SYSMON_ADDR_OT_EVENT)
>> +                             sysmon->ot_hysteresis = val;
>> +                     else
>> +                             sysmon->temp_hysteresis = val;
>> +                     return sysmon_update_temp_lower(sysmon,
>> +                                                     chan->address);
> 
> As above.

Accepted.

> 
>> +             }
>> +     }
>> +
>> +     if (chan->type == IIO_VOLTAGE) {
>> +             offset = sysmon_supply_thresh_offset(chan->address, dir);
>> +             if (offset < 0)
>> +                     return offset;
>> +             ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +             if (ret)
>> +                     return ret;
>> +             sysmon_supply_processedtoraw(val, reg_val, &raw_val);
>> +             return regmap_write(sysmon->regmap, offset, raw_val);
>> +     }
>> +
>> +     return -EINVAL;
>> +}
> 
>> +static int sysmon_handle_event(struct iio_dev *indio_dev, u32 event)
>> +{
>> +     u32 alarm_flag_offset = SYSMON_ALARM_FLAG + (event * SYSMON_REG_STRIDE);
>> +     u32 alarm_reg_offset = SYSMON_ALARM_REG + (event * SYSMON_REG_STRIDE);
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned long alarm_flag_reg;
>> +     unsigned int reg_val;
>> +     u32 address, bit;
>> +     int ret;
>> +
>> +     switch (event) {
>> +     case SYSMON_BIT_TEMP:
>> +             sysmon_push_event(indio_dev, SYSMON_ADDR_TEMP_EVENT);
>> +             ret = regmap_write(sysmon->regmap, SYSMON_IDR,
>> +                                BIT(SYSMON_BIT_TEMP));
>> +             if (ret)
>> +                     return ret;
>> +             sysmon->masked_temp |= BIT(SYSMON_BIT_TEMP);
>> +             break;
>> +
>> +     case SYSMON_BIT_OT:
>> +             sysmon_push_event(indio_dev, SYSMON_ADDR_OT_EVENT);
>> +             ret = regmap_write(sysmon->regmap, SYSMON_IDR,
>> +                                BIT(SYSMON_BIT_OT));
>> +             if (ret)
>> +                     return ret;
>> +             sysmon->masked_temp |= BIT(SYSMON_BIT_OT);
>> +             break;
>> +
>> +     case SYSMON_BIT_ALARM0:
>> +     case SYSMON_BIT_ALARM1:
>> +     case SYSMON_BIT_ALARM2:
>> +     case SYSMON_BIT_ALARM3:
>> +     case SYSMON_BIT_ALARM4:
>> +             ret = regmap_read(sysmon->regmap, alarm_flag_offset, &reg_val);
>> +             if (ret)
>> +                     return ret;
>> +             alarm_flag_reg = reg_val;
>> +
>> +             for_each_set_bit(bit, &alarm_flag_reg,
>> +                              SYSMON_ALARM_BITS_PER_REG) {
>> +                     address = bit + (SYSMON_ALARM_BITS_PER_REG * event);
>> +                     sysmon_push_event(indio_dev, address);
>> +                     ret = regmap_update_bits(sysmon->regmap,
>> +                                              alarm_reg_offset,
>> +                                              BIT(bit), 0);
>> +                     if (ret)
>> +                             return ret;
>> +             }
>> +             ret = regmap_write(sysmon->regmap, alarm_flag_offset,
>> +                                alarm_flag_reg);
>> +             if (ret)
>> +                     return ret;
>> +             break;
>                  return regmap_write();
>> +
>> +     default:
>> +             break;
> 
> Why is this not an error?

Good point. Will return -EINVAL from the default case.

> 
>> +     }
>> +
>> +     return 0;
> Might as well return early in the various paths.

Accepted. Will restructure to return from each case directly.

>> +}
> ...
> 
>> +static irqreturn_t sysmon_iio_irq(int irq, void *data)
>> +{
>> +     struct iio_dev *indio_dev = data;
>> +     struct sysmon *sysmon;
>> +     unsigned int isr, imr;
>> +
>> +     sysmon = iio_priv(indio_dev);
>> +     spin_lock(&sysmon->irq_lock);
> 
> guard() here would eman you can just return if (!isr)

Accepted.

All items will be addressed in v4.

Salih

> 
>> +
>> +     regmap_read(sysmon->regmap, SYSMON_ISR, &isr);
>> +     regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
>> +
>> +     isr &= ~imr;
>> +     regmap_write(sysmon->regmap, SYSMON_ISR, isr);
>> +
>> +     if (isr) {
>> +             sysmon_handle_events(indio_dev, isr);
>> +             schedule_delayed_work(&sysmon->sysmon_unmask_work,
>> +                                   msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
>> +     }
>> +
>> +     spin_unlock(&sysmon->irq_lock);
>> +
>> +     return IRQ_RETVAL(isr);
>> +}

