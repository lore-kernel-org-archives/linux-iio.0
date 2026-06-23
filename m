Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5062772D;
	Tue, 23 Jun 2026 11:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214631; cv=fail; b=RsCeSpH1ltejisD9k8MQvT5Gc7GncX15LlK1dZaiG0JctqSOYYB0VQGKnSEeLtERcMb6x8eNJNDKmZ66GUmSuirMUL2pFBCTsTuLHzZ/Ct6HrrnfEoPHk+97PatqDCyIiit4VCxNFN/CBSK/H5ij2WQSN4YsZvPBK1JHgY+C3nE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214631; c=relaxed/simple;
	bh=tZZfTyDM+8F5NGnFlC+qjhFZkiRGZ1UeuC1Qo/KsUho=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cfTXQt9fF0X0D/0zhafwhZgaJI53+1t5OyADaVGc3rmbpxp8eyff2AMTJMghxgbD5I6Vl0q1Kvv3j+lNiKLpHv0uBkJT778mGB7sRbMXAIp2dR6vOQzXFoPIgU321HNw0qBIPbVZmM7thUTpKnX0nnyus6FxIDEW1UZm/45pMZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vUXsEFbM; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vUXsEFbM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/U4qaB+E/S8qsA+gTRK7kfZxaLpaSSxBGTFU/jG/WN//M/OByVUtke8ppV3pyRTPBY94d7RD7b1Qi5mReb9b3GBorS+6Jx0hPLtsK0macG950L+b8s4JOQnNT21pQ/grKCvPicQ1Al57zJ8+thCazax4783rxaQK0IIH7z/h9nB9hkt2t1o5NhTBddGXuzIrSRIwE4eBBepNyEjEjhZ9RTHTCabw/wPgaBoyZfdi5BAg+lOVAdvTSVBRdmQc1z8vuWFy5g20882A2FmCFFEe914NlODRKl3j0b+BX8WBWUnv6fH+Z/RPrINTQo9ZPR1Jz5OqVDFQaNPZSOa2N0vHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MJT6L78nt19Nubqi6B9mHsocj0gvgI7dJFcqKynNKKM=;
 b=F5jvAnjjAWVY/OH/CcOKwpRNWZcXleMthVGKXpxwg8Png63guQ0jrkXiK0m0thCEmM1HbBDJFVA8pnYxWXg+/RJNDpkxXh4sbSsMU8QTrH/g+Vz1+F702VoUgNfMTPdVb7qerKy6DKG1h3v3af6NTwbvS4l/1IrUcSOCX+h+qLlzeJvtUz9e4cYYXfWpkMGoVEqq1m69gfrFpjsIGF9fvkHPqejv8BISoROiURTPn1Tg8UtO7dQ6QEFs9g4AaNEgEaCq/YxGtMCmQek0oJPcqGEjmqSrX5FWfXhsFneioo8J8pYZXB8M5H70OmbZcS5bNB12L2ZzVD4kswljtProrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MJT6L78nt19Nubqi6B9mHsocj0gvgI7dJFcqKynNKKM=;
 b=vUXsEFbMnxVUjLtKj6RKYLSP8WZofkwLHuwFdFUemJnkqDb1wUZ//3slD5iS9yS4KYGMsVcWiTCJ8bVUsxmiVO+173YjAbzD+NDD+UeCHSYX/fmgJ6rcHH70p6d2Y0gpH0atQ1mZEY1wPczAhuNOoCV0dGyIpybv2wvMZBpNv1o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:37:04 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 11:37:04 +0000
Message-ID: <c31d6842-a1b6-4a51-acdc-d1a601a294bf@amd.com>
Date: Tue, 23 Jun 2026 12:36:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 4/5] iio: adc: versal-sysmon: add threshold event
 support
To: jic23@kernel.org, andy@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, conall.ogriofa@amd.com,
 michal.simek@amd.com, linux@roeck-us.net, erimsalih@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260623014036.3865402-1-salih.erim@amd.com>
 <20260623014036.3865402-5-salih.erim@amd.com>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260623014036.3865402-5-salih.erim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0060.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::20) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 66e74a20-c68f-4d4b-d359-08ded11bbf94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|6133799003|3023799007|18002099003|18092099006|22082099003|11063799006|5023799004|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jBUZWb/XroZONHpl1drig+7/8JGMKDckq+8tO6FbdbzM/eITkD30cuDhLdjiFqQbSzjuktNYaPkm5Ihvujqt3LARrdi30cQinH6lV2ho2RBVlvFIrHYpQDvSEtucP9Yc2BO/T3W/WY2yBcsDOwcwpwXtTCbsLSOR4B8aM5Pp1NLpjXpjWkImjqI7FW2RO1JIYZ165C7AnKTpZRVWsNoqv9z5390LjB/8mOVSue/zwiX8VnWW2WE/pwnVsyF7EeHCtZN+fjSGprVAHoXlY5VdJJZq1KgG94nyoQuDG7QxSEK5xxU9kS0IW4Ng763FuUB8bz6iV9oo0lUbCxKB5srwxXuUIfMtFNMArdS3aAj1JJJnAOaE2PeEC4uzNiMM6gIM3stUTru8Z9mHM0g3AyGKH9OFLpEDXlU5B8zwiqnexPtENMwjZPIv6aaZxmJixBi+PH0IzPGyQc6PX7emgWQ2vmmwqoa5PrDYTgO3RKbV4W3V1vIPsLIvvyv0AS4m2h0AobdK6EbdAWoGhjkjG5p8TGIIRAmI+2zfU0eP6u+hvEwrGqSC23DgbZwg7ox26+EHx7HZIue1w7qwIkiUQEtQ80mlUDiw0tPDjKjVKNfu6dtWM1OCiEVt9Oa6F29aLnTc8yUwCIhONDGhCHdqMK8YZZBGTOV2j1jQ+YLGPJL7Jck=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(6133799003)(3023799007)(18002099003)(18092099006)(22082099003)(11063799006)(5023799004)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cW1TUlYzMlVnUGMxeW9RellCV2NSd01LL1lrNWZnaXFvOW5tTERXWENuckZn?=
 =?utf-8?B?aVdwUGF3OHZyKzAydk5iS2JMMGw4KzltOFUrRTdINk5DTlV1akVKYzFldlBL?=
 =?utf-8?B?SXc5QjNUNEdQbWJJUXZoeEo2RCtWUWVHckN0UitXendUTzZtL0xIV3EzUGd2?=
 =?utf-8?B?TVBmR3RUSkhJRm94QTRSKzZvck5WSWN4aFdXSW5MeE9RMkdLcWdKem9vWjBi?=
 =?utf-8?B?VVczU2tDWjkySmlSclFkZnpRbjhhTG1pcWVOVnFOcndpY2hwMDhscFdISW5v?=
 =?utf-8?B?MUtPOWdkTXRmOHIyMEtlKzFoUGY0eTYvb0JFTHVWdklJTWVIeVNXVjF6R2dY?=
 =?utf-8?B?R1VkNmZUVWVvazUvck12WXlYYnhhZDRDOEFuYXpJSTlDbEN2V255UVBXNGYr?=
 =?utf-8?B?T2xDZDBJMkdUUW1aVUJ4cHZpSkdGeHduT200V0FkSXgrYmM4SGxnZUpxZlVk?=
 =?utf-8?B?WlpKWkNYZDgzeTZyNHcyWk1nVTRyd0pnY1V2WWZaUmkxeVJ6MjJzOGZTc0kw?=
 =?utf-8?B?Q2xRUmh6SlRuOFBUdzJFOUQ1QnY4RjJvdnhpOVU4cERPVEhWbkdGSWVYbjU2?=
 =?utf-8?B?eWVRdjNOSGdqTlM1Z040UnlmdTVHcWZvWlJ5Z1pQK3d4THhHcExKZUo1dE9w?=
 =?utf-8?B?L1dROVB5Q09vWnVzNlBPcllmOTJmRk05S00wczlPTHRsWmorVkFMQW5TZkpU?=
 =?utf-8?B?c0J4eVZ0S1lYd2ZLOFUxTHpNN3NsQ05EYzBDSFVRVDR6ZGNrRloyNEwzOEZL?=
 =?utf-8?B?eFBWaDJwaDFmRm5vM2pWR2RZSi95WUg4aGx3dGJteCtoOGt0RGk0YWQ0Z3N2?=
 =?utf-8?B?aDB0NlFmcWs1ZXJaZnVQWUxEeTFQNmF6WGJKSzNIcDNtRlZJbDZydXFGYTZ1?=
 =?utf-8?B?azJ0Tk1CNnlwd3NYV0RIVkJvUERIdVVQaERMbGJLNTF2YmlUYk1mbG9ZYmN6?=
 =?utf-8?B?MktjQ3FTWlhxWWwzbndYbU1XRlZuaEVTUkRpelBEMU95b2U0VlVWa1ZpODF3?=
 =?utf-8?B?VXRlK1grcEE1T1VZREd0akFaaG5ORU9CcjhKaStnemVoZ0dUVkxKZ3JhSnZo?=
 =?utf-8?B?SmM5a2NvM0VhdXg2MGtSWkdKb1Q2UEp3SFVJbmlIQmNNdHZObVY2ZnVzT3Y4?=
 =?utf-8?B?U1QvNlpic2lRa3lWdzdRM0ZzM3R2ZkVVTW1tQnJaU2NERUh2YmJ5cjN5OE5s?=
 =?utf-8?B?QytkazM0bUNQaVVSOWc1UEVneWYvV3J2a1hlRWxNMlduSmlseTlQcHVlZ2JJ?=
 =?utf-8?B?TmxFZHB1S1JSNjNRQ3RvMW1vUElHWjlhZU4rR1NLSjA3SlNKV1RNcUlGNERs?=
 =?utf-8?B?ODNNeS9OdkdWWmhoakU2U0QvT0pOUUt2UXVPMmRnZmVWa2oxeFViSXlVWG9L?=
 =?utf-8?B?MXFWSTFtcGs2ZmxJajBmOEdDVTh2OWFDUldvZ3RpOHgrejlGMVNJMnFmd0Fn?=
 =?utf-8?B?ZlE5TGVJOHExRHkwM085V2xkNFlWNHdtZUpvRmRiQ2kza1hBM3UzNlpVazcv?=
 =?utf-8?B?Z29qb3BOMW5CKzdnSExKMitLT05xUk5GRTB0NVRNMXZpWXZ5QWMrU0tHUnBM?=
 =?utf-8?B?TzlTdzk4OTkvWWRlQVAySmEveDFtWFpESFBIYjRkdzdxSHhQL2Y5ays3MHY4?=
 =?utf-8?B?YUFUamYzU0JGNWk5SDRMVzVOQUVKREZOM1IyWVQ2dS94Z0FuOFo1V0tKcGpv?=
 =?utf-8?B?bUFsVWR5ajk2WjZHcm8wQnpHRzJsbEV3Q1ZnbC9zRXUxNlFYelFBZXV1VUdO?=
 =?utf-8?B?UGJla1FqZ3U3SXg1YUpESXh0RndLdGxYM2xaU2h1Y3k4SUtsVVIxS0JFZHR5?=
 =?utf-8?B?NmVKdjMzdkVjVGtIUEdxV3ZWMUpQaFgyMnR1bVordm9sZnR2MG13bWUvcFF6?=
 =?utf-8?B?aWx3MkIyTFRCNnhmSFVGTkFzK1NOWDRGTUpPQllOVHVER3l6d3B1bXdZTFk2?=
 =?utf-8?B?U2RLRysyMEYrLzQ4dGd1WlgweEQzRGxXVHZYNWJxZGpBN2huMm1ieFlHRTZO?=
 =?utf-8?B?SmNWaHM0YU5JbXlOeHlNc3hRdWNaZEl2Nzd2V2Z4Z3hySWlaZ2FWSVNHaC9E?=
 =?utf-8?B?TFhKUXo0NWlRcWk2dDg3cG9GUFRTZjhCckQ1ZVZVQUoxUlFqa1RMTTh1cVly?=
 =?utf-8?B?QjM4azFvRE10bXJCTGRiWVJ4U2ZuVGJHekxiUUVzb0J1NnJEL01BRm5PRDdk?=
 =?utf-8?B?UDl2SlM5dUNERkRlcTJqakkyaEt4K1pvS1M3Z05kSkhDZkRON2hsYW1KaXQw?=
 =?utf-8?B?ZSsyZ3pqSzl5SmhpYUpRbXI3TzRKRnZrSjhtMXZITUtuQ0JKbml6dEVhOENi?=
 =?utf-8?Q?ul52g9dCGpnUFQJDDN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 66e74a20-c68f-4d4b-d359-08ded11bbf94
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:37:04.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KXXDHLj1+ULOyZvFGYDg1BjfZQFB0lwRBT2RWybVw9Ew1OGYYPUz2aKBbfd9aruc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321

Addressing Sashiko findings on this patch:

- [High] Use-After-Free due to flawed devres initialization order
   for the delayed worker.

   sysmon_disable_interrupts masks all interrupts via SYSMON_IDR
   before cancelling the worker. Once masked, no new interrupts
   fire and the handler cannot re-schedule the work. The IRQ
   handler only schedules work after processing active ISR bits,
   which requires unmasked interrupts. No issue.

- [High] Error paths in the IRQ handler skip clearing hardware
   flags but unconditionally return IRQ_HANDLED.

   Theoretical only. The regmap uses MMIO with fast_io, so
   regmap_write cannot fail. The error paths exist for API
   correctness. No change needed.

- [High] The delayed worker clears all pending interrupts,
   causing voltage alarms to be lost.

   The worker only runs when temperature interrupts are masked.
   Supply alarms are handled directly in the IRQ handler and are
   never masked. A concurrent voltage alarm between the worker's
   ISR read and write could theoretically be cleared but the
   window is narrow and not observed in testing. No change needed.

- [Medium] Atomic context violation on I2C devices.

   The I2C path does not register an IRQ handler.
   fwnode_irq_get() returns 0 for I2C nodes and
   sysmon_init_interrupt skips IRQ registration. Not applicable.

- [Medium] Negative temperatures invoke undefined left-shift
   behavior and are not masked to 16 bits.

   Addressed in v11 with bounds checking. Temperature threshold
   writes are now validated against the Q8.7 range (-256000 to
   255992 mC) before conversion. Out-of-range values return
   -EINVAL. The computed lower threshold is also clamped.

- [Medium] Race condition between sysfs event disable and the
   unmask worker.

   The worker runs on a 500ms delayed schedule. The race window
   between the IDR write and temp_mask update is microseconds.
   If the worker runs in this window, it self-corrects on the
   next cycle. No change needed.

- [Medium] Cached hysteresis value is not reverted if the
   hardware threshold write fails.

   The regmap uses MMIO with fast_io. MMIO writes cannot fail.
   The error path exists for API correctness. No change needed.

Thanks,
Salih


On 23/06/2026 02:40, Salih Erim wrote:
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
> Changes in v11:
>    - Add bounds check for temperature threshold writes; return
>      -EINVAL if out of Q8.7 range (Jonathan)
>    - Add bounds check for supply voltage threshold writes to
>      prevent integer overflow (Jonathan)
>    - Clamp computed lower threshold to Q8.7 range in
>      sysmon_update_temp_lower (found during audit)
>    - Add comment explaining that threshold register upper bits
>      (FMT/MODE) are ignored on write (Jonathan)
> 
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
>   drivers/iio/adc/versal-sysmon-core.c | 613 ++++++++++++++++++++++++++-
>   drivers/iio/adc/versal-sysmon.h      |  36 ++
>   2 files changed, 645 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> index 03a745d3fb4..8f2c502d9cb 100644
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
> @@ -115,6 +202,269 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
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
> +	lower_mc = clamp(upper_mc - sysmon->temp_hysteresis, -256000, 255992);
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
> +			/* Q8.7 signed range: -256000 to +255992 mC */
> +			if (val < -256000 || val > 255992)
> +				return -EINVAL;
> +
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
> +		/* Clamp to prevent overflow in processedtoraw conversion */
> +		if (val < -32768 || val > 32767)
> +			return -EINVAL;
> +
> +		sysmon_supply_processedtoraw(val, reg_val, &raw_val);
> +
> +		/*
> +		 * The hardware threshold register returns FMT and MODE
> +		 * bits in the upper 16 bits on read, but only the lower
> +		 * 16-bit mantissa is used on write.
> +		 */
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
> @@ -128,20 +478,242 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
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
> @@ -164,8 +736,14 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
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
> @@ -190,6 +768,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
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
> @@ -255,6 +837,7 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
>   {
>   	struct iio_dev *indio_dev;
>   	struct sysmon *sysmon;
> +	int irq;
>   	int ret;
>   
>   	indio_dev = devm_iio_device_alloc(dev, sizeof(*sysmon));
> @@ -267,6 +850,7 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
>   	ret = devm_mutex_init(dev, &sysmon->lock);
>   	if (ret)
>   		return ret;
> +	spin_lock_init(&sysmon->irq_lock);
>   
>   	/* Disable all interrupts and clear pending status */
>   	ret = regmap_write(sysmon->regmap, SYSMON_IDR, SYSMON_INTR_ALL_MASK);
> @@ -276,13 +860,34 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
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

