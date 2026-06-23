Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89950384250;
	Tue, 23 Jun 2026 00:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782175447; cv=fail; b=cmzzgALsiSNkjb4XpVrwvOE4uEf6jdgSY0a21yR/70NTRL8jooDtC3waASx547Mz57JDmlXm8cuRzc20wSUboB1Nf28nSUQUlalLnhea1xbkK13vNmxvFaIRPv5lA4Xezh5g540OywuvbN4kPpcK+l/WeJo+1Iv0yOg/XNqKRKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782175447; c=relaxed/simple;
	bh=oaCaa4LRpz8tQ3vNzKEXeXuefu66WqRxmHC2/5/QXrE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U5/NAobk7UaY0wVAdEoQ5q7KLaLRVwYbfiKfKuukxuk/Vvffb5BKvnOUB1/1yiFbpB9mDVRglG7yx+9hiihymp/3j8T7SJlic1rYWRlWiqt5bnNBva+E/NMtmcrByrIaHqmTZHxlxWbHNQisMUCN/KVTHgIYf2SGN52J5JhEMjI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PhdI4mbl; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PhdI4mbl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lBL73Lgxbu0XzRE1Q+5eiBP5v//LJPgs29QbE7V0xeaTNZHZybk8mckekov+4dx/EegfByRbd8bXF60EP3rMGGiM1BbLYQzFwgJRS0kTOwOd98PSHjbfv95q4O8hkYSOZjkgpnZvlCGelLu/V5ovPanepQegg/0xkCossfXUgmazMe311nFemgsFNhHOjTLpqwZZSd9qLvd8kjP77lZJzGCKFQSI6WYrD5/RsQaE+yRuczxAMZNE/DI6Bo8OVyFlK6E3UlleJZ5oFeSrbOSCJwE9ovd1/fnZfRkPlaS0U0luNYTigK3TS6ucIXib06RWI5iZOuFIahKOJXjZVjJZSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe4Gbnw8/pS2oLIzeW+yLWwz8N4SaX8Kb7bDPNqR5fo=;
 b=waE9bIt0WnHZxk9oqYlvz6ati8XvbWVwLK0+XI9MoVaGkC6QsUz++vbj8hE/pXqj7WFt0iBFtkHNgr+5yAqG4DzR7JPu2imxqPdcph6O0yYUlWlHjP7IYiLVBTK2s2AuD2jdpNhfuUKiRWhnfuh1N1g40kCHVQp6QnJNIELruT8QzChv5KLQm3cAuMBt/gWWnuAHOXmBazBdODHaOZv80EOwdX2Z77Zjd0r1nyYFAH/evIDOgDT5/p2K0n5U0RFwU39Q0TokzwDj8VM7ML1RZ313C4t0zqYxXmLIQVYLXl43Z/gTCTqJVmifAShEbs/H+63lUI7VveU6fD4USHv3FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe4Gbnw8/pS2oLIzeW+yLWwz8N4SaX8Kb7bDPNqR5fo=;
 b=PhdI4mblDREpuxYeu52rxeRy/3eCazfiDJTRadhGKUIhEVz9pOGx2BgTKLzYQCxymf19Q7eze8Xq8x0IYRLYxgC9hlSibdNunvtnhzfyoFklYKG/xhJeEiHDDBCtKqsgfyD8hClQ6PYOHVvvt8neovL026tyUNWo+w137cxN9l4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by CH3PR12MB8850.namprd12.prod.outlook.com (2603:10b6:610:167::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 00:43:58 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 00:43:58 +0000
Message-ID: <8a5fa9fc-406f-40d4-ba0e-7c9a8caff3cb@amd.com>
Date: Tue, 23 Jun 2026 01:43:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 4/5] iio: adc: versal-sysmon: add threshold event
 support
To: jic23@kernel.org, andy@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, conall.ogriofa@amd.com,
 michal.simek@amd.com, linux@roeck-us.net, erimsalih@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260618101414.3462934-1-salih.erim@amd.com>
 <20260618101414.3462934-5-salih.erim@amd.com>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260618101414.3462934-5-salih.erim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0183.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::19) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|CH3PR12MB8850:EE_
X-MS-Office365-Filtering-Correlation-Id: a09df08e-c217-4418-ed56-08ded0c082cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|18002099003|18092099006|22082099003|6133799003|56012099006|3023799007|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	IKhFF6ycBlj/5qgaUN99C3Ty/IBoa8TJs7ct3JMzaGgqoVc+a1gfRdZe7pQG8CMaTZpLvVQmrqt2Txyq+NSq1a1uvQGY9BsLCHy58FdDAT57CMsNUshe03bzkdEYZLa0dOcKbNnJ90Y4mTlO1YAzQerwVNJUn6JKeh4WEXbn6AbBphxYiSeiX2zFxaqXAP5UU/fvvj3V6bPLULCPU2ecIdSUUKmtOzas1Q61e7t/B4Q8A65AqW8151rkzSoX/q+wS1zEF5hJ3N9OHA/RgY8XE4xhvMTS1aIRFrIUExDUJlvgjX19sFrJqeMuZIWXnEiSILblogp1UZUYlfWiGJJi7Ku7BYEOOkDrjCBIBYbPlwPCOq1CMyS3MzYEjELNsLIg9gcN1Cbt87mwiHy0ENz270CVfzHfvCwoKevfcIkrBySLMyQfQnqVxLyqMAR++NzIMMZOeSOr8eozoMHBoLEdSOnRQZmTuGwEmQjp3pJgxMtAoztjhA/HZpU7nWHfB5zZKdkhkk3TSXSNpuJgJdfKxid4Pcx1O/2CZ5qK1lDVOF2KDsZsWh6AOyHr+aMZbzxlUvoNIPKhyY84L9QbrbRGuMSIZvGIuerYvvZNTySUtT2HmrDEwQV7zHxcy/LL/gsYEAXtPLExaYh7MVC/ol9lG/zE2Cnj+RJbraLdqCqCtZ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(18002099003)(18092099006)(22082099003)(6133799003)(56012099006)(3023799007)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkZaTG0vT2ZlanBSc0FoMzZpei82NWp6RW5MQjJmSzhuaXdkdkZ1bHBtMlI3?=
 =?utf-8?B?N2hjSzFyK0xnTHBDOWZ2dlFEME1TVWxGVlJJM3NBZXN4cGl4SzNlcU96djNP?=
 =?utf-8?B?NWJNWG1yMXFaMXZtT0NMUk16TVRLM3JBM0dIQ0V4U3JQL1pucklXelJ3aUdr?=
 =?utf-8?B?SlFtZ0lzNmFBZG5wYTR3cXBxSEFqRFpZcDRHQXlVMUQxS2YrOG5UTjg0YTJy?=
 =?utf-8?B?enNHWnoraFdzU1RQNTBvVFB0TUZ1Qy9Ma0RkU0g5N0RlOE9KL25GVmFFV0xU?=
 =?utf-8?B?ZXJpZ3NXbkJ5S0NHMzNmeGZJaXZPVUxwSGFTOVU3L1hXK1JQOTZtRTJHT3Jz?=
 =?utf-8?B?TGNPbThlMW1ZcTBIZnI4ekh6TkFBY1pmdnl1YkZ5L2xkWGMwVnhqTll3RXdE?=
 =?utf-8?B?d0toSXJxV0pETHJVZkJ3WkV0c0xtdEUrWFRwbDlmRUtGcFQzUXJsaGFNcXNm?=
 =?utf-8?B?QSt3cUt3YXMrWUdjWTRINWlVWmZwU2g1bTdFUlpzVUprRGFkeG9MRmt3WWRo?=
 =?utf-8?B?d29qVG80TVBsWVBmSG9NQzB3U3Q0Q1ZXREtPNks5ald0K1NqYkNNWEVMRTRv?=
 =?utf-8?B?NGhPK3dJb0NqeXUzd1dmTU83eU04YmVJWlpLMWxzTThDOGdBeGNEWE8xTWhI?=
 =?utf-8?B?QkliTkFxeDMwbWR1ZElGdlltbXA0QXZzQ1JiSTZsRUhJeHBtRmJrVnZ4SmJR?=
 =?utf-8?B?UVBVRW5zZEppL1BzV29hWCtmdDVhZzJWTE5HMzExaEl2dGhaL1NCdXRKVk5P?=
 =?utf-8?B?QjB0c1F6S004SGhValQvK2JhRHZXR1pIL0h2Q3l4eHZFMFhTVGdaVktnTDVX?=
 =?utf-8?B?My94YTExaG5nNFFjVjRjS0QzRUU3RHN2cEg3eUVZSFMzRG04aEFzNXVWbWNT?=
 =?utf-8?B?eldDb0JDM2E2WkVhUEppREVnSGJTekVhTGd1QktZdEtsTHl3c1lYQXlLU0Rn?=
 =?utf-8?B?dkh5aWR4dkV3NE91MVJsaUE1MC9TTHBJUXlyNjNDaytZTmxnS0VKNUlMR1ps?=
 =?utf-8?B?ZXFWSko2cGh2WFlndXdXTDlEdUVHVFZjREZDRUxHN0JWYWNkWVZURk1XeUdB?=
 =?utf-8?B?c252ZGFpS2dwRTBPMEgwRUE4MjhQeTBnQVdyZFpkS0loVDI1MjJJc0lmUGkr?=
 =?utf-8?B?WHdvQi9Kbm5OZGJaWU1acFBYWU55bDdlcyt2dXJoL0dwd2U0TGRnUU1DUjJB?=
 =?utf-8?B?cFJOamxhMGlFS1I1Tmd1WFZQRjZvdDhPcVRkS1k0ODZEY0dRWXRkMEgwMjN0?=
 =?utf-8?B?Zmc1bCtoQ0FlYy9pVWVFd01qR2FPTGd2Wms4K2trVXhRZGd3c0pnTlhvSzVX?=
 =?utf-8?B?Z1lDOTdVMkRSQjQvYkZKcm9GRWZWYnk5YXNhVjNNc2xSbExBTW1TQ2lQSXZE?=
 =?utf-8?B?S1Vzeit3eEdEazhIVWN5NEFweURCTUNBQkJEdUYyZllVZ0pNNVdYR05EV284?=
 =?utf-8?B?ZFp0MHZGT2FTcVJETSt5b2pxTUtYc0RJSmxEVVRVM3lOOUl0TXYrdDJlZ3hh?=
 =?utf-8?B?WTJFWXVGR1UzRnZyS0ZENVRYa3ljZDBjc1pqTTd2TnNmZTZsZ2paWjZQZlNP?=
 =?utf-8?B?bWtJV0s2MkFrc0pTcnFwem9EKy82WkFRNnNFL2pjSnd1ZnhGNWZQQkhTOUJi?=
 =?utf-8?B?ZmFpcGc2S3Y5a2xWcmRyTitKZ0NTWEI4V1Bwb1NKdFo3c0t4NHlFc2ZNd2Ez?=
 =?utf-8?B?UWhxRFRBYXROWkk4ZmRmNWs2Rmg2d29tcE8rWUNKUWNZNmhaNjFpL2RYeFJJ?=
 =?utf-8?B?dll1MGliSG5kMnFKRTdsbTU4RDkxRkZLcVB4QnpmV0F4NnVGWW9wLzJOOHB5?=
 =?utf-8?B?VzNVQUgySnFKc3ZkcldLUkpZRVQ5ck1vbVJ0R0psV0hmeXRab0RqcU9wZlZB?=
 =?utf-8?B?RWpGS3Biak5rZm1jQVFIN0FiZ2ZTSUNmSmdVYzdvTTgzdEI2M2Z5Tmg2MjY2?=
 =?utf-8?B?N3lQU2hLQmd4U0x2cmhaUWFvNjFqd0RIRlpjNG5GWmU3NHNYMVk1a08yRGtM?=
 =?utf-8?B?a2NzRFhzVHBIRzlUMVIzUDQ5bXNNNVdZK3Nwc1JlMmhSaTdHTUVwbzg4SFhY?=
 =?utf-8?B?ZEV3UFV6ZDJ2Rmx2bzIvcEk4Rnl4blcwV3NieGIxWEQ5UVc4QXIvTU83Y1Iy?=
 =?utf-8?B?YWFvdHN2cnJCRXJNb09kY2JiK2tzMDFOdDc0VGRaYWN4UjVKYlF0N0pkbXBQ?=
 =?utf-8?B?K1FNUkdHc3g5NlcrZjdUWThtNWl1dW4ybCtCU0RpY0Z2TExXQ1BwL1Z6M1RI?=
 =?utf-8?B?R1I0QUhFN3d4bENXeHNvT2JqcDQ2bUZ3U3ZmRklreWt2QmNtMTZmamF1eHpv?=
 =?utf-8?Q?qVq4EnKLqkRTkMng0k?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a09df08e-c217-4418-ed56-08ded0c082cc
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 00:43:58.2152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kJSsFlpQUVWRgbrLkADnk/U8wUiEU3FTuUiePrxbWEEA6JbAcS0O0dkZa29dyvhN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8850

Addressing Sashiko findings on this patch:

- [High] Missing bounds checking in threshold value conversion
   leads to integer overflow and hardware register corruption.

   Agreed. Will add bounds checking for both temperature and
   supply voltage threshold writes in v11.

- [High] Writing a supply voltage threshold silently clears the
   format (FMT) and mode (MODE) bits in the threshold register.

   Not a bug. The threshold registers have separate read and write
   semantics. The upper bits (FMT/MODE) are returned on read but
   only the lower 16-bit mantissa is used on write. Will add a
   comment explaining this.

- [High] The delayed worker sysmon_unmask_worker silently clears
   all pending hardware interrupts, causing concurrent voltage
   alarm events to be permanently dropped.

   The worker only runs when temperature interrupts are masked and
   only processes temperature bits. A concurrent voltage alarm
   could theoretically be cleared but the window is narrow and
   not observed in hardware testing. No change needed.

- [High] Voltage alarm handler incorrectly disables the alarm
   configuration and early returns leak ISR status.

   By design. The alarm bit is cleared to prevent re-triggering
   on level-sensitive interrupts. The event is reported to
   userspace first. Userspace re-enables via write_event_config
   if needed. The early return on regmap failure is theoretical
   as MMIO regmap writes cannot fail. No change needed.

- [High] The hardirq handler sysmon_iio_irq takes a spinlock and
   sleeps when using an I2C regmap.

   Same as P3 finding. The I2C path never registers an IRQ
   handler. Not applicable.

- [High] Race condition between interrupt configuration/teardown
   and the unmask worker.

   The teardown masks all interrupts, clears masked_temp under
   spinlock, then calls cancel_delayed_work_sync. This ordering
   prevents the race. No change needed.

- [Medium] Unconditional execution of the delayed worker resets
   hardware tracking status on voltage alarms.

   STATUS_RESET is only written when masked_temp is 0, meaning
   all temperature conditions have cleared. Intended behaviour.
   No change needed.

Thanks,
Salih

On 18/06/2026 11:14, Salih Erim wrote:
> Add threshold event support for temperature and supply voltage
> channels.
> 
> Temperature events:
>    - Rising threshold with configurable value on the device
>      temperature channel (current max across all satellites)
>    - Per-channel hysteresis as a millicelsius value
>    - Event direction is IIO_EV_DIR_RISING (hysteresis mode)
> 
> Supply voltage events:
>    - Rising/falling threshold per supply channel
>    - Per-channel alarm enable via alarm configuration registers
> 
> The hardware supports both window and hysteresis alarm modes for
> temperature. This driver uses hysteresis mode, where the upper
> threshold triggers the alarm and the lower threshold clears it
> (re-arm point). The hardware has a single ISR bit per temperature
> channel with no indication of which threshold was crossed, so
> hysteresis mode is the natural fit. The lower threshold register
> is computed internally as (upper - hysteresis).
> 
> Hysteresis is stored in the driver as a millicelsius value,
> initialized from the hardware registers at probe. Writing the
> rising threshold or hysteresis recomputes the lower register.
> ALARM_CONFIG is hard-coded to hysteresis mode during init.
> 
> The hardware also provides a separate over-temperature (OT)
> threshold, but it is not exposed through IIO as it serves as a
> hardware safety mechanism for platform shutdown. OT will be
> exposed through the thermal framework in a follow-up series.
> 
> The interrupt handler masks active threshold interrupts (which are
> level-sensitive) and schedules a delayed worker to poll for condition
> clear before unmasking. When no hardware IRQ is available, event
> specs are not attached and interrupt init is skipped, since the
> I2C regmap backend cannot be called from atomic context.
> 
> When disabling a supply channel alarm, the group interrupt remains
> active if any other channel in the same alarm group still has an
> alarm enabled.
> 
> A devm cleanup action masks all interrupts on driver unbind to
> prevent unhandled interrupt storms after the IRQ handler is freed.
> 
> Signed-off-by: Salih Erim <salih.erim@amd.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> Changes in v10:
>    - Add Reviewed-by tag from Andy Shevchenko
>    - Add limits.h include for U16_MAX, S16_MIN, S16_MAX (Andy)
> 
> Changes in v9:
>    - Add minmax.h include for clamp() (Andy)
>    - Join sysmon_supply_thresh_offset to one line, change address
>      parameter to unsigned long for consistency (Andy)
>    - Combine mask declaration with initialization in
>      sysmon_read_event_config (Andy)
>    - Rename ier to mask in sysmon_write_event_config for
>      consistency with sysmon_read_event_config (Andy)
>    - Remove blank line in sysmon_update_temp_lower between
>      semantically coupled lines (Andy)
>    - Rename unmask to ier (u32) in sysmon_unmask_temp (Andy)
>    - Variable name and type consistency audit across all
>      event functions (Andy)
> 
> Changes in v8:
>    - Use MILLIDEGREE_PER_DEGREE in q8p7 conversion functions (Andy)
>    - Use regmap_test_bits() in sysmon_read_alarm_config (Andy)
>    - Join sysmon_parse_fw signature onto one line (Andy)
>    - Fix devm teardown race: replace devm_delayed_work_autocancel
>      with INIT_DELAYED_WORK; fold cancel_delayed_work_sync into
>      sysmon_disable_interrupts to prevent the worker from
>      re-enabling interrupts after the IRQ handler is freed (Sashiko)
>    - Drop devm-helpers.h include (no longer needed)
> 
> Changes in v7:
>    - Move TEMP threshold event onto channel 0; drop OT as
>      separate IIO channel -- OT is a hardware safety mechanism
>      better suited for the thermal framework follow-up (Jonathan)
>    - Use single temp_channels array; attach event spec to
>      channel 0 at runtime when IRQ is available, matching the
>      pattern used for supply channels (Jonathan)
>    - Remove sysmon_temp_thresh_offset; use SYSMON_TEMP_TH_UP
>      and SYSMON_TEMP_TH_LOW defines directly at call sites
>    - Return administrative state from temp_mask in
>      read_event_config instead of transient hardware IMR
>      (Jonathan, Sashiko)
>    - Add devm_add_action_or_reset to mask all HW interrupts
>      on driver unbind (Sashiko)
>    - Remove SYSMON_CHAN_TEMP_EVENT macro, SYSMON_ADDR_TEMP_EVENT,
>      SYSMON_ADDR_OT_EVENT, SYSMON_BIT_OT, SYSMON_OT_HYST_MASK,
>      OT_TH_LOW/UP registers, ot_hysteresis from struct
>    - Simplify sysmon_get_event_mask, sysmon_update_temp_lower,
>      sysmon_init_hysteresis -- all now operate on single TEMP
>      channel only
> 
> 
> Changes in v6:
>    - Remove types.h from header (not needed at any stage) (Andy)
>    - Macro brace on separate line for SYSMON_CHAN_TEMP_EVENT (Andy)
>    - switch(chan->type) in all event functions instead of cascading
>      if statements (Andy)
>    - switch(info) in read/write_event_value for nested
>      dispatch (Andy)
>    - Reversed xmas tree in sysmon_update_temp_lower and
>      sysmon_init_hysteresis (Andy)
>    - scoped_guard(spinlock_irq) with error check in
>      sysmon_unmask_worker (Andy)
>    - Combined regmap_read error check with || in
>      sysmon_iio_irq (Andy)
>    - Join devm_request_irq on one line (Andy)
>    - Fix fwnode_irq_get() to propagate only -EPROBE_DEFER;
>      treating all negatives as fatal broke probe on I2C nodes
>      without interrupts property
> 
> Changes in v5:
>    - clamp() instead of clamp_t() (Andy)
>    - regmap_assign_bits() instead of separate set/clear (Andy)
>    - Remove unneeded parentheses (2 places) (Andy)
>    - for_each_set_bit on single line (Andy)
>    - regmap_clear_bits() instead of regmap_update_bits() (Andy)
>    - Simplify unmask XOR to ~status & masked_temp (Andy)
>    - Add comment explaining unmask &= ~temp_mask logic (Andy)
>    - Split container_of across two lines (Andy)
>    - Move ISR write after !isr check to avoid writing 0 (Andy)
>    - unsigned int for init_hysteresis address param (Andy)
>    - Add comment explaining error check policy in worker/IRQ (Andy)
>    - Nested size_add() for overflow-safe allocation (Andy)
>    - Propagate negative from fwnode_irq_get() for
>      EPROBE_DEFER (Andy)
>    - Pass irq instead of has_irq to sysmon_parse_fw (Andy)
> 
> Changes in v4:
>    - Merge event channels into static temp array; two arrays
>      (with/without events) selected by has_irq (Jonathan)
>    - Event-only channels have no info_mask; their addresses are
>      logical identifiers, not readable registers
>    - Drop RAW for voltage events, keep PROCESSED only (Jonathan)
>    - Drop scan_type from event channel macro (Jonathan)
>    - Blank lines between call+error-check blocks (Jonathan)
>    - Fit under 80 chars on one line where possible (Jonathan)
>    - default case returns -EINVAL instead of break (Jonathan)
>    - sysmon_handle_event: return early in each case (Jonathan)
>    - guard(spinlock) in sysmon_iio_irq, return IRQ_NONE/IRQ_HANDLED
>      directly (Jonathan)
>    - Take irq_lock in write_event_config for temp_mask updates to
>      synchronize with unmask worker (Sashiko)
> 
> Changes in v3:
>    - IWYU: add new includes, group iio headers with blank line (Andy)
>    - Reduce casts in millicelsius_to_q8p7, consistent style with
>      q8p7_to_millicelsius (Andy)
>    - Use clamp_t with typed constants, remove tmp & U16_MAX (Andy)
>    - Use !! to return 0/1 from read_alarm_config (Andy)
>    - Use regmap_set_bits/clear_bits in write_alarm_config (Andy)
>    - Add comment explaining spinlock is safe (I2C never reaches
>      event code path) (Andy)
>    - Add comment explaining IMR negation logic (Andy)
>    - Split read_event_value/write_event_value parameters logically
>      across lines (Andy)
>    - Move mask/shift after regmap_read error check (Andy)
>    - Remove redundant else in read_event_value and
>      write_event_value (Andy)
>    - Use named constant for hysteresis bit, if-else not ternary
>      (Andy)
>    - Loop variable declared in for() scope (Andy)
>    - Add error checks in sysmon_handle_event (Andy)
>    - Use IRQ_RETVAL() macro (Andy)
>    - Use devm_delayed_work_autocancel instead of manual INIT +
>      devm_add_action (Andy)
>    - Use FIELD_GET/FIELD_PREP for hysteresis register bits
>      (Jonathan)
>    - Split OT vs TEMP handling with FIELD_GET (Jonathan)
>    - Rework hysteresis: store as millicelsius value, hardcode
>      ALARM_CONFIG to hysteresis mode, compute lower threshold
>      from (upper - hysteresis), initialize from HW at probe
>      (Jonathan)
>    - Remove falling threshold for temperature; single event
>      spec per channel with IIO_EV_DIR_RISING (Jonathan)
>    - Push IIO_EV_DIR_RISING events for temperature,
>      IIO_EV_DIR_EITHER for voltage (Jonathan)
> 
> Changes in v2:
>    - Reverse Christmas Tree variable ordering in all functions
>    - Named constants for hysteresis bits: SYSMON_OT_HYST_BIT,
>      SYSMON_TEMP_HYST_BIT instead of magic 0x1/0x2
>    - SYSMON_ALARM_BITS_PER_REG replaces magic number 32
>    - SYSMON_ALARM_OFFSET() helper macro deduplicates alarm register
>      offset computation
>    - BIT() macro for shift expressions in conversion functions
>    - Hysteresis input validated to single-bit range (0 or 1)
>    - Event channels only created when irq > 0 (I2C safety)
>    - Group alarm interrupt stays active while any channel in the
>      group has an alarm enabled
>    - write_event_value returns -EINVAL for unhandled types
>    - IRQ_NONE returned for spurious interrupts
>    - Q8.7 write path uses multiplication instead of left-shift
>      to avoid undefined behavior with negative temperatures
>    - (u16) mask prevents garbage in reserved register bits
>    - regmap_write return values checked for IER/IDR writes
>    - devm cleanup ordering: cancel_work before request_irq
>   drivers/iio/adc/versal-sysmon-core.c | 600 ++++++++++++++++++++++++++-
>   drivers/iio/adc/versal-sysmon.h      |  36 ++
>   2 files changed, 632 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> index 03a745d3fb4..50b5228aa22 100644
> --- a/drivers/iio/adc/versal-sysmon-core.c
> +++ b/drivers/iio/adc/versal-sysmon-core.c
> @@ -12,6 +12,9 @@
>   #include <linux/cleanup.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
> +#include <linux/interrupt.h>
> +#include <linux/limits.h>
> +#include <linux/minmax.h>
>   #include <linux/module.h>
>   #include <linux/overflow.h>
>   #include <linux/property.h>
> @@ -20,10 +23,18 @@
>   #include <linux/sysfs.h>
>   #include <linux/units.h>
>   
> +#include <linux/iio/events.h>
>   #include <linux/iio/iio.h>
>   
>   #include "versal-sysmon.h"
>   
> +/* TEMP hysteresis mode bit in SYSMON_TEMP_EV_CFG */
> +#define SYSMON_TEMP_HYST_MASK		BIT(1)
> +
> +/* Compute alarm register offset from a channel address */
> +#define SYSMON_ALARM_OFFSET(addr) \
> +	(SYSMON_ALARM_REG + ((addr) / SYSMON_ALARM_BITS_PER_REG) * SYSMON_REG_STRIDE)
> +
>   #define SYSMON_CHAN_TEMP(_chan, _address, _name)		\
>   {								\
>   	.type = IIO_TEMP,					\
> @@ -35,6 +46,45 @@
>   	.datasheet_name = _name,				\
>   }
>   
> +enum sysmon_alarm_bit {
> +	SYSMON_BIT_ALARM0 = 0,
> +	SYSMON_BIT_ALARM1 = 1,
> +	SYSMON_BIT_ALARM2 = 2,
> +	SYSMON_BIT_ALARM3 = 3,
> +	SYSMON_BIT_ALARM4 = 4,
> +	SYSMON_BIT_TEMP = 9,
> +};
> +
> +/* Temperature event specification: rising threshold + hysteresis only */
> +static const struct iio_event_spec sysmon_temp_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> +				 BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_HYSTERESIS),
> +	},
> +};
> +
> +/* Supply event specifications */
> +static const struct iio_event_spec sysmon_supply_events[] = {
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_RISING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_FALLING,
> +		.mask_separate = BIT(IIO_EV_INFO_VALUE),
> +	},
> +	{
> +		.type = IIO_EV_TYPE_THRESH,
> +		.dir = IIO_EV_DIR_EITHER,
> +		.mask_separate = BIT(IIO_EV_INFO_ENABLE),
> +	},
> +};
> +
>   /*
>    * Static temperature channels (always present).
>    *
> @@ -52,6 +102,16 @@ static const struct iio_chan_spec temp_channels[] = {
>   	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
>   };
>   
> +static void sysmon_q8p7_to_millicelsius(s16 raw_data, int *val)
> +{
> +	*val = (raw_data * MILLIDEGREE_PER_DEGREE) >> SYSMON_FRACTIONAL_SHIFT;
> +}
> +
> +static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val)
> +{
> +	*raw_data = (val << SYSMON_FRACTIONAL_SHIFT) / MILLIDEGREE_PER_DEGREE;
> +}
> +
>   static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
>   {
>   	int mantissa, format, exponent;
> @@ -69,6 +129,33 @@ static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
>   	*val = (mantissa * (int)MILLI) >> exponent;
>   }
>   
> +static void sysmon_supply_processedtoraw(int val, u32 reg_val, u32 *raw_data)
> +{
> +	int exponent = FIELD_GET(SYSMON_MODE_MASK, reg_val);
> +	int format = FIELD_GET(SYSMON_FMT_MASK, reg_val);
> +	int scale, tmp;
> +
> +	scale = BIT(SYSMON_SUPPLY_MANTISSA_BITS - exponent);
> +	tmp = (val * scale) / (int)MILLI;
> +
> +	if (format)
> +		tmp = clamp(tmp, S16_MIN, S16_MAX);
> +	else
> +		tmp = clamp(tmp, 0, U16_MAX);
> +
> +	*raw_data = (u16)tmp;
> +}
> +
> +static int sysmon_supply_thresh_offset(unsigned long address, enum iio_event_direction dir)
> +{
> +	if (dir == IIO_EV_DIR_RISING)
> +		return (address * SYSMON_REG_STRIDE) + SYSMON_SUPPLY_TH_UP;
> +	if (dir == IIO_EV_DIR_FALLING)
> +		return (address * SYSMON_REG_STRIDE) + SYSMON_SUPPLY_TH_LOW;
> +
> +	return -EINVAL;
> +}
> +
>   static int sysmon_read_raw(struct iio_dev *indio_dev,
>   			   struct iio_chan_spec const *chan,
>   			   int *val, int *val2, long mask)
> @@ -115,6 +202,256 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
>   	}
>   }
>   
> +static u32 sysmon_get_event_mask(const struct iio_chan_spec *chan)
> +{
> +	if (chan->type == IIO_TEMP)
> +		return BIT(SYSMON_BIT_TEMP);
> +
> +	return BIT(chan->address / SYSMON_ALARM_BITS_PER_REG);
> +}
> +
> +static int sysmon_read_alarm_config(struct sysmon *sysmon,
> +				    unsigned long address)
> +{
> +	u32 shift = address % SYSMON_ALARM_BITS_PER_REG;
> +	u32 offset = SYSMON_ALARM_OFFSET(address);
> +
> +	return regmap_test_bits(sysmon->regmap, offset, BIT(shift));
> +}
> +
> +static int sysmon_write_alarm_config(struct sysmon *sysmon,
> +				     unsigned long address, bool enable)
> +{
> +	u32 shift = address % SYSMON_ALARM_BITS_PER_REG;
> +	u32 offset = SYSMON_ALARM_OFFSET(address);
> +
> +	return regmap_assign_bits(sysmon->regmap, offset, BIT(shift), enable);
> +}
> +
> +static int sysmon_read_event_config(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	u32 mask = sysmon_get_event_mask(chan);
> +	unsigned int imr;
> +	int config_value;
> +	int ret;
> +
> +	ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
> +	if (ret)
> +		return ret;
> +
> +	/* IMR bits are 1=masked, invert to get 1=enabled */
> +	imr = ~imr;
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		config_value = sysmon_read_alarm_config(sysmon, chan->address);
> +		if (config_value < 0)
> +			return config_value;
> +		return config_value && (imr & mask);
> +
> +	case IIO_TEMP:
> +		/*
> +		 * Return the administrative state, not the hardware IMR.
> +		 * The IRQ handler temporarily masks the interrupt during
> +		 * the polling window; reading IMR would show it as disabled.
> +		 * temp_mask bit is set when administratively disabled.
> +		 */
> +		return !(sysmon->temp_mask & mask);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int sysmon_write_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     bool state)
> +{
> +	u32 offset = SYSMON_ALARM_OFFSET(chan->address);
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	u32 mask = sysmon_get_event_mask(chan);
> +	unsigned int alarm_config;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	switch (chan->type) {
> +	case IIO_VOLTAGE:
> +		ret = sysmon_write_alarm_config(sysmon, chan->address, state);
> +		if (ret)
> +			return ret;
> +
> +		ret = regmap_read(sysmon->regmap, offset, &alarm_config);
> +		if (ret)
> +			return ret;
> +
> +		if (alarm_config)
> +			return regmap_write(sysmon->regmap, SYSMON_IER, mask);
> +
> +		return regmap_write(sysmon->regmap, SYSMON_IDR, mask);
> +
> +	case IIO_TEMP:
> +		if (state) {
> +			ret = regmap_write(sysmon->regmap, SYSMON_IER, mask);
> +			if (ret)
> +				return ret;
> +
> +			scoped_guard(spinlock_irq, &sysmon->irq_lock)
> +				sysmon->temp_mask &= ~mask;
> +		} else {
> +			ret = regmap_write(sysmon->regmap, SYSMON_IDR, mask);
> +			if (ret)
> +				return ret;
> +
> +			scoped_guard(spinlock_irq, &sysmon->irq_lock)
> +				sysmon->temp_mask |= mask;
> +		}
> +		return 0;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +/*
> + * Recompute the lower threshold register from upper threshold and
> + * cached hysteresis. Called when either upper threshold or hysteresis
> + * is written.
> + */
> +static int sysmon_update_temp_lower(struct sysmon *sysmon)
> +{
> +	unsigned int upper_reg;
> +	int upper_mc, lower_mc;
> +	u32 raw_val;
> +	int ret;
> +
> +	ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &upper_reg);
> +	if (ret)
> +		return ret;
> +
> +	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
> +	lower_mc = upper_mc - sysmon->temp_hysteresis;
> +	sysmon_millicelsius_to_q8p7(&raw_val, lower_mc);
> +
> +	return regmap_write(sysmon->regmap, SYSMON_TEMP_TH_LOW, raw_val);
> +}
> +
> +static int sysmon_read_event_value(struct iio_dev *indio_dev,
> +				   const struct iio_chan_spec *chan,
> +				   enum iio_event_type type,
> +				   enum iio_event_direction dir,
> +				   enum iio_event_info info,
> +				   int *val, int *val2)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	int offset;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	switch (chan->type) {
> +	case IIO_TEMP:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &reg_val);
> +			if (ret)
> +				return ret;
> +
> +			sysmon_q8p7_to_millicelsius(reg_val, val);
> +
> +			return IIO_VAL_INT;
> +
> +		case IIO_EV_INFO_HYSTERESIS:
> +			*val = sysmon->temp_hysteresis;
> +			return IIO_VAL_INT;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_VOLTAGE:
> +		offset = sysmon_supply_thresh_offset(chan->address, dir);
> +		if (offset < 0)
> +			return offset;
> +
> +		ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		sysmon_supply_rawtoprocessed(reg_val, val);
> +
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int sysmon_write_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int val, int val2)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int reg_val;
> +	u32 raw_val;
> +	int offset;
> +	int ret;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	switch (chan->type) {
> +	case IIO_TEMP:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			sysmon_millicelsius_to_q8p7(&raw_val, val);
> +
> +			ret = regmap_write(sysmon->regmap, SYSMON_TEMP_TH_UP, raw_val);
> +			if (ret)
> +				return ret;
> +
> +			/* Recompute lower = upper - hysteresis */
> +			return sysmon_update_temp_lower(sysmon);
> +
> +		case IIO_EV_INFO_HYSTERESIS:
> +			if (val < 0)
> +				return -EINVAL;
> +
> +			sysmon->temp_hysteresis = val;
> +
> +			return sysmon_update_temp_lower(sysmon);
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_VOLTAGE:
> +		offset = sysmon_supply_thresh_offset(chan->address, dir);
> +		if (offset < 0)
> +			return offset;
> +
> +		ret = regmap_read(sysmon->regmap, offset, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		sysmon_supply_processedtoraw(val, reg_val, &raw_val);
> +
> +		return regmap_write(sysmon->regmap, offset, raw_val);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>   static int sysmon_read_label(struct iio_dev *indio_dev,
>   			     struct iio_chan_spec const *chan,
>   			     char *label)
> @@ -128,20 +465,242 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
>   static const struct iio_info sysmon_iio_info = {
>   	.read_raw = sysmon_read_raw,
>   	.read_label = sysmon_read_label,
> +	.read_event_config = sysmon_read_event_config,
> +	.write_event_config = sysmon_write_event_config,
> +	.read_event_value = sysmon_read_event_value,
> +	.write_event_value = sysmon_write_event_value,
>   };
>   
> +static void sysmon_push_event(struct iio_dev *indio_dev, u32 address)
> +{
> +	const struct iio_chan_spec *chan;
> +	enum iio_event_direction dir;
> +
> +	for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
> +		if (indio_dev->channels[i].address != address)
> +			continue;
> +
> +		chan = &indio_dev->channels[i];
> +		/* Temp uses hysteresis mode (rising only), voltage uses window */
> +		dir = (chan->type == IIO_TEMP) ? IIO_EV_DIR_RISING :
> +						 IIO_EV_DIR_EITHER;
> +		iio_push_event(indio_dev,
> +			       IIO_UNMOD_EVENT_CODE(chan->type,
> +						    chan->channel,
> +						    IIO_EV_TYPE_THRESH,
> +						    dir),
> +			       iio_get_time_ns(indio_dev));
> +	}
> +}
> +
> +static int sysmon_handle_event(struct iio_dev *indio_dev, u32 event)
> +{
> +	u32 alarm_flag_offset = SYSMON_ALARM_FLAG + event * SYSMON_REG_STRIDE;
> +	u32 alarm_reg_offset = SYSMON_ALARM_REG + event * SYSMON_REG_STRIDE;
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned long alarm_flag_reg;
> +	unsigned int reg_val;
> +	u32 address, bit;
> +	int ret;
> +
> +	switch (event) {
> +	case SYSMON_BIT_TEMP:
> +		sysmon_push_event(indio_dev, SYSMON_TEMP_MAX);
> +
> +		ret = regmap_write(sysmon->regmap, SYSMON_IDR, BIT(SYSMON_BIT_TEMP));
> +		if (ret)
> +			return ret;
> +
> +		sysmon->masked_temp |= BIT(SYSMON_BIT_TEMP);
> +		return 0;
> +
> +	case SYSMON_BIT_ALARM0:
> +	case SYSMON_BIT_ALARM1:
> +	case SYSMON_BIT_ALARM2:
> +	case SYSMON_BIT_ALARM3:
> +	case SYSMON_BIT_ALARM4:
> +		ret = regmap_read(sysmon->regmap, alarm_flag_offset, &reg_val);
> +		if (ret)
> +			return ret;
> +
> +		alarm_flag_reg = reg_val;
> +
> +		for_each_set_bit(bit, &alarm_flag_reg, SYSMON_ALARM_BITS_PER_REG) {
> +			address = bit + SYSMON_ALARM_BITS_PER_REG * event;
> +			sysmon_push_event(indio_dev, address);
> +			ret = regmap_clear_bits(sysmon->regmap, alarm_reg_offset, BIT(bit));
> +			if (ret)
> +				return ret;
> +		}
> +
> +		return regmap_write(sysmon->regmap, alarm_flag_offset, alarm_flag_reg);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void sysmon_handle_events(struct iio_dev *indio_dev,
> +				 unsigned long events)
> +{
> +	unsigned int bit;
> +
> +	for_each_set_bit(bit, &events, SYSMON_NO_OF_EVENTS)
> +		sysmon_handle_event(indio_dev, bit);
> +}
> +
> +static void sysmon_unmask_temp(struct sysmon *sysmon, unsigned int isr)
> +{
> +	unsigned int status;
> +	u32 ier;
> +
> +	status = isr & SYSMON_TEMP_INTR_MASK;
> +
> +	ier = ~status & sysmon->masked_temp;
> +	sysmon->masked_temp &= status;
> +
> +	/* Only unmask if not administratively disabled by userspace */
> +	ier &= ~sysmon->temp_mask;
> +
> +	regmap_write(sysmon->regmap, SYSMON_IER, ier);
> +}
> +
> +/*
> + * Versal threshold interrupts are level-sensitive. Active threshold
> + * interrupts are masked in the handler and polled via delayed work
> + * until the condition clears, then unmasked.
> + */
> +static void sysmon_unmask_worker(struct work_struct *work)
> +{
> +	struct sysmon *sysmon =
> +		container_of(work, struct sysmon, sysmon_unmask_work.work);
> +	unsigned int isr;
> +
> +	/*
> +	 * If the ISR read fails, skip processing to avoid acting
> +	 * on undefined data.
> +	 */
> +	scoped_guard(spinlock_irq, &sysmon->irq_lock) {
> +		if (regmap_read(sysmon->regmap, SYSMON_ISR, &isr))
> +			break;
> +		regmap_write(sysmon->regmap, SYSMON_ISR, isr);
> +		sysmon_unmask_temp(sysmon, isr);
> +	}
> +
> +	if (sysmon->masked_temp)
> +		schedule_delayed_work(&sysmon->sysmon_unmask_work,
> +				      msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
> +	else
> +		regmap_write(sysmon->regmap, SYSMON_STATUS_RESET, 1);
> +}
> +
> +static irqreturn_t sysmon_iio_irq(int irq, void *data)
> +{
> +	struct iio_dev *indio_dev = data;
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int isr, imr;
> +
> +	guard(spinlock)(&sysmon->irq_lock);
> +
> +	if (regmap_read(sysmon->regmap, SYSMON_ISR, &isr) ||
> +	    regmap_read(sysmon->regmap, SYSMON_IMR, &imr))
> +		return IRQ_NONE;
> +
> +	isr &= ~imr;
> +	if (!isr)
> +		return IRQ_NONE;
> +
> +	regmap_write(sysmon->regmap, SYSMON_ISR, isr);
> +
> +	sysmon_handle_events(indio_dev, isr);
> +	schedule_delayed_work(&sysmon->sysmon_unmask_work,
> +			      msecs_to_jiffies(SYSMON_UNMASK_WORK_DELAY_MS));
> +
> +	return IRQ_HANDLED;
> +}
> +
> +static void sysmon_disable_interrupts(void *data)
> +{
> +	struct sysmon *sysmon = data;
> +
> +	regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
> +
> +	scoped_guard(spinlock_irq, &sysmon->irq_lock)
> +		sysmon->masked_temp = 0;
> +
> +	cancel_delayed_work_sync(&sysmon->sysmon_unmask_work);
> +}
> +
> +static int sysmon_init_interrupt(struct sysmon *sysmon,
> +				 struct device *dev,
> +				 struct iio_dev *indio_dev,
> +				 int irq)
> +{
> +	unsigned int imr;
> +	int ret;
> +
> +	/* Events not supported without IRQ (e.g. I2C path) */
> +	if (!irq)
> +		return 0;
> +
> +	INIT_DELAYED_WORK(&sysmon->sysmon_unmask_work, sysmon_unmask_worker);
> +
> +	ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
> +	if (ret)
> +		return ret;
> +	sysmon->temp_mask = imr & SYSMON_TEMP_INTR_MASK;
> +
> +	ret = devm_request_irq(dev, irq, sysmon_iio_irq, 0, "sysmon-irq", indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_add_action_or_reset(dev, sysmon_disable_interrupts, sysmon);
> +}
> +
> +/*
> + * Initialize the cached hysteresis for a temperature channel from the
> + * current hardware threshold registers: hysteresis = upper - lower.
> + */
> +static int sysmon_init_hysteresis(struct sysmon *sysmon, int *hysteresis)
> +{
> +	unsigned int upper_reg, lower_reg;
> +	int upper_mc, lower_mc;
> +	int ret;
> +
> +	ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_UP, &upper_reg);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(sysmon->regmap, SYSMON_TEMP_TH_LOW, &lower_reg);
> +	if (ret)
> +		return ret;
> +
> +	sysmon_q8p7_to_millicelsius(upper_reg, &upper_mc);
> +	sysmon_q8p7_to_millicelsius(lower_reg, &lower_mc);
> +	*hysteresis = upper_mc - lower_mc;
> +
> +	return 0;
> +}
> +
>   /**
>    * sysmon_parse_fw() - Parse firmware nodes and configure IIO channels.
>    * @indio_dev: IIO device instance
>    * @dev: Parent device
> + * @irq: IRQ number (positive enables event channels, 0 disables)
>    *
>    * Reads voltage-channels and temperature-channels container nodes from
>    * firmware and builds the IIO channel array. Static temperature channels
> - * are prepended, followed by supply and satellite channels from DT.
> + * and event channels are prepended, followed by supply and satellite
> + * channels from DT.
> + *
> + * Event channels and per-channel event specs are only added when the
> + * device has an IRQ. I2C devices have no interrupt line, and the I2C
> + * regmap cannot be called from atomic context, so events are not
> + * supported on that path.
>    *
>    * Return: 0 on success, negative errno on failure.
>    */
> -static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int irq)
>   {
>   	unsigned int num_chan, num_static, num_supply, num_temp;
>   	unsigned int idx, temp_chan_idx, volt_chan_idx;
> @@ -164,8 +723,14 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
>   	if (!sysmon_channels)
>   		return -ENOMEM;
>   
> -	/* Static temperature channels first */
>   	memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
> +
> +	/* Attach event spec to channel 0 when IRQ is available */
> +	if (irq > 0) {
> +		sysmon_channels[0].event_spec = sysmon_temp_events;
> +		sysmon_channels[0].num_event_specs = ARRAY_SIZE(sysmon_temp_events);
> +	}
> +
>   	idx = num_static;
>   
>   	/* Supply channels from DT */
> @@ -190,6 +755,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
>   			.indexed = 1,
>   			.address = reg,
>   			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +			.event_spec = irq > 0 ?
> +				sysmon_supply_events : NULL,
> +			.num_event_specs = irq > 0 ?
> +				ARRAY_SIZE(sysmon_supply_events) : 0,
>   			.datasheet_name = label,
>   		};
>   	}
> @@ -255,6 +824,7 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
>   {
>   	struct iio_dev *indio_dev;
>   	struct sysmon *sysmon;
> +	int irq;
>   	int ret;
>   
>   	indio_dev = devm_iio_device_alloc(dev, sizeof(*sysmon));
> @@ -267,6 +837,7 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
>   	ret = devm_mutex_init(dev, &sysmon->lock);
>   	if (ret)
>   		return ret;
> +	spin_lock_init(&sysmon->irq_lock);
>   
>   	/* Disable all interrupts and clear pending status */
>   	ret = regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
> @@ -276,13 +847,34 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
>   	if (ret)
>   		return ret;
>   
> +	irq = fwnode_irq_get(dev_fwnode(dev), 0);
> +	if (irq == -EPROBE_DEFER)
> +		return dev_err_probe(dev, irq, "failed to get IRQ\n");
> +
>   	indio_dev->name = "versal-sysmon";
>   	indio_dev->modes = INDIO_DIRECT_MODE;
>   
> -	ret = sysmon_parse_fw(indio_dev, dev);
> +	ret = sysmon_parse_fw(indio_dev, dev, irq);
>   	if (ret)
>   		return ret;
>   
> +	if (irq > 0) {
> +		/* Set hysteresis mode for temperature threshold */
> +		ret = regmap_set_bits(sysmon->regmap, SYSMON_TEMP_EV_CFG,
> +				      SYSMON_TEMP_HYST_MASK);
> +		if (ret)
> +			return ret;
> +
> +		/* Initialize cached hysteresis from hardware registers */
> +		ret = sysmon_init_hysteresis(sysmon, &sysmon->temp_hysteresis);
> +		if (ret)
> +			return ret;
> +
> +		ret = sysmon_init_interrupt(sysmon, dev, indio_dev, irq);
> +		if (ret)
> +			return ret;
> +	}
> +
>   	return devm_iio_device_register(dev, indio_dev);
>   }
>   EXPORT_SYMBOL_NS_GPL(devm_versal_sysmon_core_probe, "VERSAL_SYSMON");
> diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
> index e27a5357575..9fe2793757a 100644
> --- a/drivers/iio/adc/versal-sysmon.h
> +++ b/drivers/iio/adc/versal-sysmon.h
> @@ -11,6 +11,8 @@
>   
>   #include <linux/bits.h>
>   #include <linux/mutex.h>
> +#include <linux/spinlock_types.h>
> +#include <linux/workqueue.h>
>   
>   struct device;
>   struct regmap;
> @@ -18,12 +20,22 @@ struct regmap;
>   /* Register offsets (sorted by address) */
>   #define SYSMON_NPI_LOCK			0x000C
>   #define SYSMON_ISR			0x0044
> +#define SYSMON_IMR			0x0048
> +#define SYSMON_IER			0x004C
>   #define SYSMON_IDR			0x0050
>   #define SYSMON_TEMP_MAX			0x1030
>   #define SYSMON_TEMP_MIN			0x1034
>   #define SYSMON_SUPPLY_BASE		0x1040
> +#define SYSMON_ALARM_FLAG		0x1018
> +#define SYSMON_ALARM_REG		0x1940
> +#define SYSMON_TEMP_TH_LOW		0x1970
> +#define SYSMON_TEMP_TH_UP		0x1974
> +#define SYSMON_SUPPLY_TH_LOW		0x1980
> +#define SYSMON_SUPPLY_TH_UP		0x1C80
> +#define SYSMON_TEMP_EV_CFG		0x1F84
>   #define SYSMON_TEMP_MIN_MIN		0x1F8C
>   #define SYSMON_TEMP_MAX_MAX		0x1F90
> +#define SYSMON_STATUS_RESET		0x1F94
>   #define SYSMON_TEMP_SAT_BASE		0x1FAC
>   #define SYSMON_MAX_REG			0x24C0
>   
> @@ -35,8 +47,12 @@ struct regmap;
>   
>   #define SYSMON_SUPPLY_IDX_MAX		159
>   #define SYSMON_TEMP_SAT_MAX		64
> +#define SYSMON_NO_OF_EVENTS		32
>   #define SYSMON_INTR_ALL_MASK		GENMASK(31, 0)
>   
> +/* ISR/IMR temperature alarm mask (bit 9) */
> +#define SYSMON_TEMP_INTR_MASK		BIT(9)
> +
>   /* Supply voltage conversion register fields */
>   #define SYSMON_MANTISSA_MASK		GENMASK(15, 0)
>   #define SYSMON_FMT_MASK			BIT(16)
> @@ -46,11 +62,21 @@ struct regmap;
>   #define SYSMON_FRACTIONAL_SHIFT		7U
>   #define SYSMON_SUPPLY_MANTISSA_BITS	16
>   
> +/* Bits per alarm register */
> +#define SYSMON_ALARM_BITS_PER_REG	32
> +
> +#define SYSMON_UNMASK_WORK_DELAY_MS	500
> +
>   /**
>    * struct sysmon - Driver data for Versal SysMon
>    * @regmap: register map for hardware access
>    * @lock: protects read-modify-write sequences on threshold registers
>    *        and cached state that spans multiple regmap calls
> + * @irq_lock: protects interrupt mask register updates (MMIO path only)
> + * @masked_temp: currently masked temperature alarm bits
> + * @temp_mask: temperature interrupt configuration mask
> + * @temp_hysteresis: cached DEVICE_TEMP hysteresis in millicelsius
> + * @sysmon_unmask_work: re-enables events after alarm condition clears
>    */
>   struct sysmon {
>   	struct regmap *regmap;
> @@ -60,6 +86,16 @@ struct sysmon {
>   	 * that spans multiple regmap calls.
>   	 */
>   	struct mutex lock;
> +	/*
> +	 * Protects interrupt mask register updates.  Only used on the
> +	 * MMIO path (fast_io regmap); I2C has no IRQ and never reaches
> +	 * the event code that takes this lock.
> +	 */
> +	spinlock_t irq_lock;
> +	unsigned int masked_temp;
> +	unsigned int temp_mask;
> +	int temp_hysteresis;
> +	struct delayed_work sysmon_unmask_work;
>   };
>   
>   int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap);

