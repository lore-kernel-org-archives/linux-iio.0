Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011000.outbound.protection.outlook.com [52.101.52.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFE933B6D3;
	Thu, 28 May 2026 21:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780004826; cv=fail; b=qjHqpke4ANcFL0Q2uUGrNzOxAWs6MYCAwg/DrEYp8dvJAkrMFjP+0kvnmYRKnkm8YDhNsEWmqKfYhD9l24w9qnXfkyeP28rcW2hDgY1vaovKZTrR8OmoOCjAN/FdwkdJoXEDM5YpZ2g1QVeGzLJ1jLL5Kvx/+G3FBXZH6LFIbd8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780004826; c=relaxed/simple;
	bh=D5BGIISri6H0dWJ7kufiJx8QWv5UYxD/zsdygBNC0UY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=fbNAw+xEfH6ZzNL0VC9DyxrIk2KM7Dv4uL0It2YG0rhM8Im4+HFaNiQ7Lj6jBuKIr/b9F6Pqzv2Sz9uLjPpthODd9Hvayf6KZ31uQljTn/hdlfuOQ/AzfIcOOkxERyYEvUmrbJFvZ1nIN2hE/94aGYlrkjhUyY6R0I+M9FWDWV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oC8BuA3S; arc=fail smtp.client-ip=52.101.52.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oC8BuA3S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOaAAlRXeZa4UA+h7JyZD6I/cmnwTsioNjNI+xOxxbp5kWVmTp2BaETxqMfOEObDdiAWiiD5t6rnO4SNbFpPeTF2/iPhoQAUBoGtlAAnsgy63BXeLx+SXl4kG7tCnD588cMFqrj1Eycdu2PHvMSbCVwzUUMmRNaANROl6tKCBbeRjPh/4zRjBp38ZdXQAAl24JXM/cldP9WCWLh+KdZhHFAlsGDIV35/HeYfRvSDxVA6ZhPlUQaGGvlIwG3b3CUEta1kpUyGuoRK66dDpQ1kw2Uo4NB67b74jImb3Lyiy5/ra3gLHpihh1ZjOw431+rYCGCWv6oTj0xshLnpxu5JmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsrmZcU2JW8lgOhz2nwCLv71aiVBW17Fo1YycLWpwHU=;
 b=BiUl1Js1SKBGCEzsGo6GfaFe1saGkMhXSE77GIBcy2IjsHre+PweGPWppvAZD8OO9gY/yJXq7Bc79/L/SwdCEYY4XoYP/0u6T+CuyXd8mqxS6TyqfOvc+0x16sLANyV+2UkXkTXygTUctt5rvP6d/nnOA4/4P3/gv0JfudAlfMZZsawHRXbTMyvrBZxy6LKwW5i0FWF3ao4l9meoPeS9LfQ7R1xZFzF/yYhb4so81+QgqTiBKRVvWAn6Q9x/lFBDXJefpQJS1PRi9gsjH9XPoyCStZB+9GOpB+Cl9JTf0TXgBeJSzkuwPcyMtst/jfrtZ8sYHAcyAvzHiY9eI6sKSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsrmZcU2JW8lgOhz2nwCLv71aiVBW17Fo1YycLWpwHU=;
 b=oC8BuA3Sayp1rT8CTmTZZAji4rbzTFoK7hJqiP4BRjVKKf7ERilncr+vZUQVW5ljvfWyZc7HPdw45BTgzZqbsImKmKRyZ6QHVpgfmir/rOr4VKaNDKRSm62WrbiZFxpd21fVbH2uh4IYqLouGbsoXIDFBSMO4Gncago6m8034Lc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DS7PR12MB8420.namprd12.prod.outlook.com (2603:10b6:8:e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 21:47:01 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 21:47:00 +0000
Message-ID: <d579623e-b799-4caa-aeec-7d070a972aae@amd.com>
Date: Thu, 28 May 2026 22:46:58 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] iio: adc: add AMD/Xilinx Versal SysMon driver
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
 <20260528130600.25e401a7@jic23-huawei>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260528130600.25e401a7@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0116.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::13) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DS7PR12MB8420:EE_
X-MS-Office365-Filtering-Correlation-Id: f19340ec-f5f1-4950-c57a-08debd02a5d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|56012099006|11063799006|4143699003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	i3kI1ASRlfvwcaZAyo4Ujn+ZuzBd5Cs5+nT8hYmkwi0ZPDcDp3P4WWKIYUEijVQI1GADRiee48aSO5xvYoKW2OaYb0wAOIRilCFHYfuHyunLoMm9ntYRTMgWI+2meu732VvL+VRRR2W3C1NrugsC3lxhtQR3HcezYQKHa/F3ltZbvdDiDToiNcJPYfp/NmiH0P0sER83NTHeHawQS+GRHSBFDvwCw1xpjeYgD5DNZE+LKL18Z2KYTRme3oRUhG9Ngaxjesfi/TY6UoqTZNVicx7CCs/g7VMe77IcbMxjSXZ5uPtZb8hSA9cWblC7/vWVRjf5Pc96ogCN9H27mDwkauuxxqmxCGd8RqUJZi4FrEiPcihts0SPeqbp6tt3eeGpQy0CzHwKtHIUnqa8Fe7xdlNF3R3TXh8sgkLSy9bUQF1e/Ru6f3a6wu04p7uo3Kf4xHg/bVVlZCUW/6GnXFmntQc/FCkjxZc9fm32Q6oRIg2dJ2DYDtVcwAIvAmb0Plj+UzJg9T+PLQJJSQpnu4qHa2yjX+SacEVEQ3ceDI/8eJL0/pYy9w6OiuYPZO7JyPuUan+xwbQVPE2JiIfMtkgCX/gdD/pqX+5BcGcq8VRBJd+nIqSRgiHMBUqkAjp4HNyM+VfMIfDaXlQrTmWZSFNR9A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TGRaT1ZqaGRCcHdJSmFlVmNRUWxJbEhtcjdjUUZSN0ZybXRsdlVWVVN6YzE0?=
 =?utf-8?B?cDA1VW5ZaS95aEJqeXRpZDFua1Q3bjEyUVhBT2FWNzNlWU8zK0huamdCakdK?=
 =?utf-8?B?UVYxUjAxNnRESFU3aHpFMVRTWEVzN0NDZnI5bThLZXRYNjdMTVRoSDhWZTNS?=
 =?utf-8?B?MnhlL0FpOTBPU3lZZ3dGbzZPclVBNDhMZTFldEJ1UFNOdDEzZmhzSjdRWDBt?=
 =?utf-8?B?bC9IWHEyVXprUHdOM0IvZVFvQ3pmY1ZXTkI5ZXRKNlRveWtWbkxQbGlIbm9L?=
 =?utf-8?B?Z004eVVnOWpZR2d0UWUzeXBNdkFBbkpSM3hXUUswTVFhZGhFZDh5UDNEdWl3?=
 =?utf-8?B?MmJmUDl6MFpmNUNwRTlPbm5GREoyNi9QVHZwWkxIalRONWtGZGxad0pNOWxt?=
 =?utf-8?B?WEhIckNDQlFXOUhMZXVqSXZqaHlkRU9VVENlWEUvY0YwNFlMcVhaeFE3bkgv?=
 =?utf-8?B?WXZodVdqd0FQWVBTZmFJNyswT0daM2NjbUtPL2tFY0kzQ095MDM5dWhuZElZ?=
 =?utf-8?B?dGlwc1V5L1Z0akp5US80NmdsN09VWjZFSlc0TzlVakk1Um9PRjFNcGd3b1kr?=
 =?utf-8?B?c2c5ellyZ3Q3c1NIWDJTZnFaUzZGN3h4Zzc3dTIySXpTRzgrWG1jRkIxOTl5?=
 =?utf-8?B?WU1zcCtvT0lrRFRmMWpleGQ2VkoxaVovcHRmVTdjWkllRjN4OTFHT1dpZnl6?=
 =?utf-8?B?R2taVldLYWk2QUt0bjZKT21jMVJiL0NZaCtNQUM5eXl3ME9TVFVPdGhsaGJ3?=
 =?utf-8?B?WldCVFY2MkxtNXBkYStUcVVZVXhFRGNoYXBsT1NJWXg2SDJENkhBWmc4S3Bu?=
 =?utf-8?B?VTF3aTgvRTZJYndiclg0V0lTMnZMR1ZMelIzQkYwUDFCZkdJVjZVNnFBTlhG?=
 =?utf-8?B?eGVMM2toS0grVDZFTTgrb2VGMVBJOEg1NW85eXRQQi9LbURRU2psRVpJeXFu?=
 =?utf-8?B?dThqVmpaczhpRUo2WE9FeFBFSm1QTlVtZ2hDZ2VGcWZkRWx6M1M0RGlqMnA2?=
 =?utf-8?B?QUlXeTJ4VjVPTUtjcHI3OWFEQ2RXbEFrampKWllJcXY0bThEOHpRRUpLODJB?=
 =?utf-8?B?UldjTFhLOEo3WWtLWWdnODY1RXVwbktJemdhRW5BN0orR0JWa3lHc0U5bkxj?=
 =?utf-8?B?L3NVSjVEd29rUzIzOHZFQzRPUmdlbXBLWW9SZGM2c2g2L1p6VjhHZ3FmNHJE?=
 =?utf-8?B?THU4SlR5R0xuTE5QYjJkRXh1TmJqRzIyYmZMcXRpSFd2Z0NpSzZEYjRCdmJ4?=
 =?utf-8?B?TW4rTTUzZTVLYThiU2JXalp0aHY3WGpvWExmY0dVMmNwTURSYi9sN0JXTGpv?=
 =?utf-8?B?MEpHTXFUZjV5NDQyYXJrZ1l1NExyTXZEUzVnOTE0VUkvUFpocGVMRXBnNkY3?=
 =?utf-8?B?YnlqdEdXZjRCa21RMVFzbkZwVndiY0hxVDhUV05rZmU3S2dxZldCdm1UNHk1?=
 =?utf-8?B?MDI2eTlaOTVMMjZOVWxvUWlWQzZHcHBxdXdCNGZpeHZTUUlMZjl0aVJyZitz?=
 =?utf-8?B?aE4wU2E1YjF3dTNaUVRaY3B2aWdzU0I5ei9NYU1peG1iYStHSk1XRnJYSEJl?=
 =?utf-8?B?SDZ1dGVrRk12RDBvcGZBRVZPWlNHd2F2Q1ByajZNL2dpdUQ5VlVxTkVWNkZP?=
 =?utf-8?B?ODNSYVRuR3h5cDRCZzMrZzFod05Ud0FYN2kxVll4Zm9IaTQzN1NwblFGbGFR?=
 =?utf-8?B?dG9zV0ZiNUZaS0ZyK2h3eTJaVHU5ZEtmZHZZL2IyUFBqQ0hEcDJINWZ0Vi9Y?=
 =?utf-8?B?b21qL3lUK2dWVERuQnVCWDRhbEtoZkJ1QzhQMVBHRzdVYnNYb2pYM0xaeWZ6?=
 =?utf-8?B?TTk4N1NQV29CamxlMk5KejJFcDZBWjIyNW5mL1A0WTI1bmsxdWlFSHYzSmIw?=
 =?utf-8?B?TTFoQStaeXJKYWFSbGtyVDlzMmFCcjNTVnNQS0NEenJveElodEhESDNNRDdq?=
 =?utf-8?B?Q0dFYldhTW5yK0poUUVuUGdSdlp5cUtJK2hCZEZUVXo3cEV3VGF6eHJsQmJQ?=
 =?utf-8?B?ZytRTUNkY2ZvcTBIbzJrcUd5NXNycWdEUjNORWMxUEZxSGxRM1ZYMEVVeCtm?=
 =?utf-8?B?UGtjZjJuY1gzMlJBZXhqSkFiR3ZwazRNa2pydEc1RTBJNFBJUXB1VVYvQWV3?=
 =?utf-8?B?dkp2b1IyWHZWMlZ0RzZIN3hONjA4bWpjSjlJRGxNSThZNVM4akNDbmZORWxR?=
 =?utf-8?B?NXpyOW01d2p4blFzU0Nsc3dnUndrVExYczkzMXB1RGpLTkoyWk5rQzFvM2h4?=
 =?utf-8?B?elVFVUM2SURyRFF4eVlpc1k5R1VTaGpETkY5QTZ3NUM2T3hKMUhxNzVpVU1o?=
 =?utf-8?Q?EJUin7+z5nlNNUw7L5?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f19340ec-f5f1-4950-c57a-08debd02a5d6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 21:47:00.4869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oWXX5BhzvZUdFrfWKVAOztCq01RzCDCmIOm9K/q78sNtZ/dEd5F9G5sgbAOwBB84
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8420

Hi Jonathan,

On 28/05/2026 13:06, Jonathan Cameron wrote:
> 
> 
> On Wed, 27 May 2026 12:42:06 +0100
> Salih Erim <salih.erim@amd.com> wrote:
> 
>> This series adds a new IIO driver for the AMD/Xilinx Versal System
>> Monitor (SysMon), providing on-chip voltage and temperature monitoring.
>>
>> The Versal SysMon measures up to 160 supply voltages and reads up to
>> 64 temperature satellites distributed across the SoC. The hardware
>> also provides aggregated device temperature registers: the current
>> max and min across all active satellites, and peak/trough values
>> recorded since last hardware reset. The device can be accessed via
>> memory-mapped I/O or via an I2C interface.
>>
>> The driver is split into a bus-agnostic core module using the regmap
>> API, an MMIO platform driver, and an I2C driver. This allows the
>> same IIO logic to be shared across different bus transports.
>>
>> Previous submissions:
>>    v2: https://lore.kernel.org/all/cover.1746182670.git.salih.erim@amd.com/
>>    v1: https://lore.kernel.org/all/cover.1757061697.git.michal.simek@amd.com/
>>
> https://sashiko.dev/#/patchset/20260527114211.174288-1-salih.erim%40amd.com
> Quite a bit of feedback.  Some of which is clearly garbage, like the
> ARCH_VERSAL suggestion, but take a close look as it does tend to pick up on
> stuff that humans miss.

Thanks Jonathan. I've gone through all the Sashiko findings.

False positives:
- ARCH_VERSAL: doesn't exist in mainline; all Versal drivers use
   ARCH_ZYNQMP (EDAC_VERSAL, Versal TRNG, etc.)
- I2C bus atomicity: the SysMon I2C slave protocol requires a
   STOP between command and response; the vendor driver uses the
   same send/recv sequence
- Hardirq on I2C: IRQ handler is never registered on the I2C
   path (has_irq is false when fwnode_irq_get returns negative)
- Voltage threshold clobbering format bits: threshold registers
   only use the mantissa (bits 15:0); vendor driver does the same
- IRQ storm on regmap error: ISR is cleared before handle_events
   is called, so the interrupt won't re-fire
- VERSAL_SYSMON_I2C missing ARCH: no I2C ADC driver in the
   kernel has an ARCH dependency; I2C clients are bus-agnostic

Reviewed but keeping as-is:
- Left-shift of negative in millicelsius_to_q8p7: GCC defines
   this behavior and it's consistent with the read direction
   (right-shift); Andy asked for this symmetry in v2
- Oversampling read without mutex: reading a single int is
   atomic on arm64; adding contention for no practical benefit
- Voltage alarms one-shot: follows the IIO event model where
   userspace re-arms via write_event_config
- Event config reads 0 during masked alarm: standard behavior,
   xilinx-ams does the same
- TOCTOU on masked_temp after spinlock drop: benign; worst case
   the worker reschedules one extra cycle
- Interrupts not disabled on teardown: devm_request_irq frees
   the IRQ handler; probe already disables all interrupts via
   IDR at init, and LIFO devm ordering is correct
- Oversampling shared_by_type for all temp: this is a per-type
   HW setting; static channels report the aggregate result
- val*scale overflow in processedtoraw: realistic voltages
   (< 3.3V) are well within int32 range; overflow requires
   > 32V input which is beyond the ADC range
- sysmon_update_temp_lower underflow: hysteresis is validated
   as non-negative and realistic thresholds keep the subtraction
   well within Q8.7 range

Will address in v4:
- scan_type: dropping entirely (no buffered support), which
   also resolves the realbits question
- RAW + PROCESSED: dropping RAW for voltage (PROCESSED only),
   and using RAW + SCALE for temperature (linear Q8.7)
- temp_mask: take irq_lock in write_event_config to
   synchronize with the unmask worker

Happy to fold these into v4 along with your review feedback.

Thanks,
Salih
