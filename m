Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013040.outbound.protection.outlook.com [40.93.196.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131A4384254;
	Tue, 23 Jun 2026 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782174868; cv=fail; b=uIO0WJ0c31Wp8yLC/yblO5SVbdMRNtQUCP28hXroqafEadviofTUoHnlofgWKqNnvD/1ZmiOdKePZMgUzRGw+bckkBMy0hGvk2le9HRriULCySiJ/ZCYidGh+dTVwAdn7gAZH4szSZ1yQo3Jeb6s7Ht9InTy8XgPeJUPNxK7b2I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782174868; c=relaxed/simple;
	bh=0NBveg5yf8cej7wW6vbF3wxpUkQ/YMdb4Htv7duRHb4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PfeeHaniKhn+3MouAWpf/r446yVPfR1acXdpE1b99j5yp8APqKA/1vtlZXVQaMbVbtQaQHb6vNbhy+Uu2Eta6pDLk4pcBwyVQWskYMauORax9MAbHa2tncV6J679YTFtXyeGEvmu3avypT92eiaFFbuy1zFdt8IJCo+4xFV/eHU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WZReK5OW; arc=fail smtp.client-ip=40.93.196.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WZReK5OW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EtbzGLVI92DS2sU06bQrQ9OKFGe7FkMjZVpjORItw5gXlbXCnlpxLhO0SWJ2GqtkXSxpOHaLC+4oYJiL681BqC4v61pknOrHVcbJyGesFFYWgO3dQlF8RTqb8Gc7bkTiDrAp+DhhwB4/Ww1c1xD3SyF8DIFnklTIYH7yuV7mIk3qbsrRXZZqlaib8xxRHSw4k/ESw8IkXt5y1fAH4s9E4inpKFWkjCXhwM92Gh0obxX/2ZbHwswJKojZMRKBlcHYhI1YnexBc9NEs6iPeCkivr7/aABICa+GoGrBL4kk2rKSsMkbDurvwB5xySpnKpOKR7vKR1BbArr4T8qs7BGy7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KVdGO45pl5u+MeDLmMNePiyToyEjGnz2zuO4qSD1KNY=;
 b=D08ctZeht0u0WAXMY8aocedHVfMFXbUYKbAn2cDtsq93T6CcXiQ2snd4rJTTwWW+TMqypJH/GxNPuE8Lflpprp6KqnhOYG/SKcNo0W9hiT5p3tLhWaRotEg1gV8+a6x8wxZyRRJiKc22P3CMlcXov8ruxA+ANYu+4tjFvAwwaWDDzrAhnNvOXsKeUqh+aiGrIeKt4wkefBQXPSEqvnyucuAhWc9V21ZTHj6I2vYYHsfLfB5sUGuu4gg+Gorkh4mS+nb3H1n9Ejm7jinoPu+vn1xovs8BTF2k17IJ8U1EcgL5BqWEQZKTpK6+SxhuFmN02QXmVKTkNIvv/pvhJWy4DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KVdGO45pl5u+MeDLmMNePiyToyEjGnz2zuO4qSD1KNY=;
 b=WZReK5OWsRsRIo6SMPXe99oSlujg3ESrM7a2f8NKj56McPHSDjM6dP2XPAKhD3Lbh+hF/X1dogUy3tmnXYoXPMVgzynmM1lZkDUCfL4QP1va61uRrMexFY+1s+8AblFDD1zev1tkjpsexetW6u8rmVwn0lrSfQ8yZmVQ3uxXMNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by CH3PR12MB9123.namprd12.prod.outlook.com (2603:10b6:610:1a4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.12; Tue, 23 Jun
 2026 00:34:21 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 00:34:21 +0000
Message-ID: <eaebd577-165e-4111-b27e-d63858c22856@amd.com>
Date: Tue, 23 Jun 2026 01:34:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/5] iio: adc: versal-sysmon: add oversampling support
To: jic23@kernel.org, andy@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, conall.ogriofa@amd.com,
 michal.simek@amd.com, linux@roeck-us.net, erimsalih@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260618101414.3462934-1-salih.erim@amd.com>
 <20260618101414.3462934-6-salih.erim@amd.com>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260618101414.3462934-6-salih.erim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0126.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::7) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|CH3PR12MB9123:EE_
X-MS-Office365-Filtering-Correlation-Id: 601ceefb-955c-4734-fa2f-08ded0bf2b1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|56012099006|6133799003|11063799006|5023799004|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info:
	nxtZaWqC5e/W/cpFqm7gp5aqQ5VNWwOUrQ56vtzZMLHDzvm8itEA3BR4KfipTcn8xsdFIbuCuHWfzeW6AE/Dp0oThn3IsuyKkYeWVvmq0AmBOKFrZRyznGfqjdiQFYFNxCNuLcv3IvwDK+erXB4MoEi0URKVN4nyZE2YPuOz9mHDKndi/XeSfbCsONbkutZCEwXndgJXOZEj8r9uzFPIjTb3woCMQW41gNJ9vHDI2kLIR0YkNrAB22lIpPGJOYSeiY5z0Qj8lO35n4NpfF/RtksKL3LiWvX6Px0tXAxK79KIyO8Lkrcci5n0CX1ScC/yGyCW2EnfBaEm6JUyJas35ShjR+J8Vj7N/bje0J/uYFGZgQZvujBdp+shDEOvLup+Qo3P4DKaspVIhaBVzq8fzpQ1DXbjU+AdudQ23VxRQ3Z2qC9FnEAsWlKI4J+uh5C1y9W74YLIzkvdJ+567XWlx8h3BmArbGTZCuU2LQWY/1Hu4CJ5bVHM4D9U8yp1lNZrWjoYWy6Kf4zJkUNSioAhhwIyURZLhrnj0Yvk92CL4RpBgESC5kJTKbokgxWdZovVqpHwaKPT47c6LFQLlBq0nnf1gurhwhHPc9KT4Fk6BfgapBI1I+w3Z1Iv/6ynWR+m/vUmC4tY2r9k6Q6E41YEAcGzLvYJa73hNgCkoBDBcp0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(56012099006)(6133799003)(11063799006)(5023799004)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NlcrRHJQUjE1eXJmdnJsaDd6a0hYNDI5UUMyemVOVDhwci9tZml3WnJyRmR3?=
 =?utf-8?B?a2NhWFJ4Vm5LcEY1c3dpZmtlelNrWk9neTBjSnNGSWYvZXlWc3VLOU1TMXVR?=
 =?utf-8?B?Wm9EdHpSL28zWHo2enJOaE1peHBwVDB3cnFLS01CZzRhMnQ5Z1Z5Vkg2R2xQ?=
 =?utf-8?B?THhIbUNyMUtSdUJ4WmlqUGoxY1I0ZlMxVFVvWVF3MEkxMmlnWU1WQUlJajVB?=
 =?utf-8?B?TGdNVzRuVjRScGQ0TFh4Z00waVpjdkVVdjRYbU16bFRsOTRjaWhqbXpTMEcz?=
 =?utf-8?B?dTV5VHZLUWVpR1l6R2JRU21pUnBnZjJOa3d5YlY5d1d3d21FblFtQk82d0lE?=
 =?utf-8?B?ZVJ4a0pMeTEzdSsrNlBYS0o1c0lieDVwKzdGZCtpNTJ4M0RsTERCV2hGc1I4?=
 =?utf-8?B?dWNUQmFZWm40d1JCSDVKRlBmNzVuV0h2WDdiR080NmQ1azczeGdkdjN1ZXVV?=
 =?utf-8?B?SWdqMXEwSEhhVjBGVnJjeGpNRzU5UGxxaXhGSkNNOEh4aWhFTmQwRzFBS25T?=
 =?utf-8?B?WGZ3Zjg0Wko4dG1CLzZuazR0a1RGVHgxQmQ4dEJwc1pZb0tQV3Bhdmo4a3pY?=
 =?utf-8?B?YkhQb29TWjRsNTNIQklIVDNMRGtpaUcyMXlhM3FFamREaFFnbElZZVY1RnRu?=
 =?utf-8?B?WmtJMlZMUWlTeEFZTk56eGpNejQveWszYjNERzNoMzU5S0MydWxZNng0cTRJ?=
 =?utf-8?B?eVpMcnpRSWEya1RDeUkwMFpEYmxDaUx1MnlDcnBwb25BWkIyQ1lhOEUxOWxm?=
 =?utf-8?B?bldhRTN6ZWh6anpPQVJpRHl0QWkwWXlzNVhpaTZsUENST0pVRVlNbSs3Y1Y5?=
 =?utf-8?B?SGx1YmRwbTZONzFPa0plSnpTVzcvbzlSQ2cxRFhUTGJGaTJQMWQ2bE9XOTVY?=
 =?utf-8?B?cDgyek1rK0F6c1N2cys4K2dQM0VSSElVb0REOUdZYmdRN3BBWTNuWEtadCtT?=
 =?utf-8?B?SkJPZDdBdmZOZ3RrRDBTd2xYaHAzNWQ5ekg0ei96QTJXR0luOEFpYzl6azYz?=
 =?utf-8?B?UmdtbU42bXpyZm1iNm5saS95cWZBcko0YUh3ZGFSeFRDSnhvLzJJb01zdWJq?=
 =?utf-8?B?cmNZcG9VS3hGUytTYys0Q3UrSXBBRWFMb1JGVEM4QktXSGdNTVZVUEw2MjN2?=
 =?utf-8?B?Z0w4V0xVcE1LSXdlSGw3T044TzhEQkFTUk9YaXA4N2IrTkFUQ0ZEV0FJeTdJ?=
 =?utf-8?B?T2N3R2haT1dqUXEycWNpNStvZ21lbjBBQ3JWRk5GQ09VdG9tKy9GemtqbTZh?=
 =?utf-8?B?ZjZSb0ltTFlneGhockoyZ0IzcFVEcVpEZHRrN3p4eG8yaWNNVnFLYkFWU1hn?=
 =?utf-8?B?M3l4dXBnRE4zdGMzY294OURrS0hBSkF4cm1MSk9QODRJWG9GSUpaTlloejl4?=
 =?utf-8?B?TUNLYm0wQU5UbGYxWXF4cldEZFFYVmJnK2Zkby9QYmtJUjllUm1FN2l3c3dO?=
 =?utf-8?B?bmNtVGFrZW1vTG1jbzZKOHJRVnRLUlFsZnBZMzRwOERaRDgwNk40ZDM4SGNl?=
 =?utf-8?B?ck9EL2FHT3FSUHdqcHhzZmZhR250cnUyZXd1NEt0bUtmMFBPMmhqSm9Mejlo?=
 =?utf-8?B?M1praVR5dWdXMFNPQnpsYjhLZmEvSnh5YTYrWGFqdDF1N2NGTmpReTlKMTJY?=
 =?utf-8?B?cFdVVkpaSXFjODlQTS8rdEFQdjZyR3llVkVnTkFLb2loNDA1aUlWUnRCa1Ix?=
 =?utf-8?B?MXA4SG1HOWZXMWUvajhPTkM3MXdYaDVzSC9WVk5FQ1h5VkZUVjU0aHNMN0NN?=
 =?utf-8?B?WFVDWnpvSW9IVkU4OUN4YkZhZlZQQzhvaWxVZnRZWEs2U2VHVWs2cDBoQ3FW?=
 =?utf-8?B?T0xVMi9xUjNPRXRzOTY4ZkkrSXZNQU5rZkNqdHhEUHlvSGNBcGduRXRiQS8r?=
 =?utf-8?B?bUdZZHovQnpDY3loYld0MVNuWmtIbnQzVHZ5QXRsUk5rbHR2c0FURUUwTWpi?=
 =?utf-8?B?ZHBsMDdaMkpsMUhXRE1TZ1EzSTRQWEtFUi9zU0FHMkhtNU9SZ3NaZG9CQ2pp?=
 =?utf-8?B?bnprK2hUdExVMmt2aWdqUGxPSHdPNzlxNks0U2pTSElmN1BsTXdMUGtrN1E0?=
 =?utf-8?B?NEdIbFlzd1hQMnMzeklsSGExK3E1M1l5QllLczlSL0Ivb1lIZENaNEQzdWhM?=
 =?utf-8?B?a0xQelJpRDZQdjFsYytsS2ZtTms4OStHQ3JnNTVnU2xzdFpxM3NOUFlQcHpo?=
 =?utf-8?B?QlRLOXJ4NFlCMnJWZWlvaFkvaUZrTnArN3djVU5qWEx6cmJrQlFaRWJHRjQz?=
 =?utf-8?B?UjBtcmVEbGltMThpLzdzMGs5VlVCOGZSdU9kMjR0N1lDajJxa3RTaW1WaTBM?=
 =?utf-8?Q?jYvTcDPSNuWuiVrTp0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 601ceefb-955c-4734-fa2f-08ded0bf2b1a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 00:34:21.5913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajgOn5VSU1gvy/tCk9MTxU8Ffwo5uyVlyU3JdUq7hPI56hTnSg/lQXqgujyLBHwO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9123

Addressing Sashiko findings on this patch:

- [Medium] Temperature oversampling sysfs attribute is hidden if
   no satellite channels are defined.

   Agreed. Will add oversampling info_mask bits to the static
   temperature channel macro in v11.

- [Medium] Hardware and software state desynchronization at
   initialization for oversampling ratios.

   Not a bug. The driver does not own the hardware state at probe
   time, writing a default could interfere with bootloader (PLM)
   configuration. The cache initializes to 1 (no averaging), which
   matches the hardware reset default. Discussed and dismissed in
   v6 review.

Thanks,
Salih

On 18/06/2026 11:14, Salih Erim wrote:
> Add support for reading and writing the oversampling ratio through
> the IIO oversampling_ratio attribute. The hardware supports averaging
> 2, 4, 8, or 16 samples, plus a ratio of 1 (no averaging).
> 
> Temperature and supply channels share oversampling configuration at
> the type level (all temperature channels share one ratio, all supply
> channels share another), exposed through info_mask_shared_by_type.
> 
> The hardware encoding uses sample_count / 2 in a 4-bit field within
> the CONFIG register. Per-channel averaging enable registers must also
> be updated to activate or deactivate averaging.
> 
> Signed-off-by: Salih Erim <salih.erim@amd.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
> Changes in v10:
>    - No code changes
> 
> Changes in v9:
>    - Add Reviewed-by tag from Andy Shevchenko
>    - No code changes
> 
> Changes in v8:
>    - Use unsigned int for val parameter and hw_val in both
>      osr_write helpers (Andy)
>    - Use ~0 instead of ~0U for avg enable bitmask (Andy)
> 
> Changes in v7:
>    - Split sysmon_osr_write into sysmon_osr_write_temp and
>      sysmon_osr_write_supply; caller dispatches with if/else
>      on chan->type (Jonathan)
>    - Restore HW encoding comment in both helpers; fix
>      cross-reference in sysmon_osr_write_supply
> 
> Changes in v6:
>    - Fix FIELD_PREP indentation in sysmon_osr_write (Andy)
>    - unsigned int for loop index in sysmon_write_raw (Andy)
> 
> Changes in v5:
>    - Remove unneeded parentheses in i * SYSMON_REG_STRIDE (Andy)
>    - Use struct regmap *map local variable in
>      sysmon_set_avg_enable (Andy)
>    - switch instead of redundant if/if on channel_type (Andy)
>    - Add CONFIG register readback fence after oversampling update
>      to prevent NoC bus hang from posted writes (found during
>      hardware stress testing)
> 
> Changes in v4:
>    - Return directly from sysmon_set_avg_enable calls, remove
>      else after early returns, drop unreachable return 0 (Jonathan)
>    - Rename mask defines to SYSMON_CONFIG_SUPPLY_OSR and
>      SYSMON_CONFIG_TEMP_SAT_OSR (Jonathan)
>    - Drop "bits X:Y" from GENMASK comments (Jonathan)
>    - Blank lines after if (ret) return ret blocks (Jonathan)
>    - Move oversampling read inside guard(mutex) scope
> 
> Changes in v3:
>    - No changes
> 
> Changes in v2:
>    - EN_AVG per-channel bitmask registers written with all-ones
>      instead of boolean 1 when oversampling is enabled
>    - EN_AVG write errors propagated to userspace
>    - Oversampling limited to satellite temp and supply channels;
>      static temp channels do not participate
>    - Oversampling exposes actual sample counts (1,2,4,8,16) to
>      userspace with internal HW register translation
>    - write_raw_get_fmt returns IIO_VAL_INT for oversampling ratio
>    - HW encoding documented (sample_count/2, not log2)
>    - oversampling_avail is const int[] (type match fix)
>   drivers/iio/adc/versal-sysmon-core.c | 153 ++++++++++++++++++++++++++-
>   drivers/iio/adc/versal-sysmon.h      |  17 +++
>   2 files changed, 169 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> index 50b5228aa22..bae229f27c6 100644
> --- a/drivers/iio/adc/versal-sysmon-core.c
> +++ b/drivers/iio/adc/versal-sysmon-core.c
> @@ -28,6 +28,12 @@
>   
>   #include "versal-sysmon.h"
>   
> +/*
> + * Oversampling ratio values exposed to userspace via IIO.
> + * Actual number of samples averaged: 1=none, 2=2x, 4=4x, 8=8x, 16=16x.
> + */
> +static const int sysmon_oversampling_avail[] = { 1, 2, 4, 8, 16 };
> +
>   /* TEMP hysteresis mode bit in SYSMON_TEMP_EV_CFG */
>   #define SYSMON_TEMP_HYST_MASK		BIT(1)
>   
> @@ -166,6 +172,12 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
>   
>   	guard(mutex)(&sysmon->lock);
>   
> +	if (mask == IIO_CHAN_INFO_OVERSAMPLING_RATIO) {
> +		*val = (chan->type == IIO_TEMP) ? sysmon->temp_oversampling :
> +						 sysmon->supply_oversampling;
> +		return IIO_VAL_INT;
> +	}
> +
>   	switch (chan->type) {
>   	case IIO_TEMP:
>   		if (mask == IIO_CHAN_INFO_SCALE) {
> @@ -452,6 +464,132 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
>   	}
>   }
>   
> +static int sysmon_set_avg_enable(struct sysmon *sysmon,
> +				 u32 base, u32 count, u32 val)
> +{
> +	struct regmap *map = sysmon->regmap;
> +	int ret;
> +
> +	for (unsigned int i = 0; i < count; i++) {
> +		ret = regmap_write(map, base + i * SYSMON_REG_STRIDE, val);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sysmon_osr_write_temp(struct sysmon *sysmon, unsigned int val)
> +{
> +	/*
> +	 * HW register encoding is sample_count / 2:
> +	 * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
> +	 */
> +	unsigned int hw_val = val >> 1;
> +	unsigned int readback;
> +	int ret;
> +
> +	ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
> +				SYSMON_CONFIG_TEMP_SAT_OSR,
> +				FIELD_PREP(SYSMON_CONFIG_TEMP_SAT_OSR, hw_val));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Readback fence: the SysMon CONFIG register resides in the
> +	 * PMC domain behind the NoC. A posted write may not reach the
> +	 * hardware before the next MMIO access. Reading the register
> +	 * back forces the interconnect to complete the write, preventing
> +	 * a bus hang on the subsequent access.
> +	 */
> +	regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
> +
> +	return sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
> +				     SYSMON_TEMP_EN_AVG_COUNT,
> +				     hw_val ? ~0 : 0);
> +}
> +
> +static int sysmon_osr_write_supply(struct sysmon *sysmon, unsigned int val)
> +{
> +	/* HW encoding: sample_count / 2 (see sysmon_osr_write_temp) */
> +	unsigned int hw_val = val >> 1;
> +	unsigned int readback;
> +	int ret;
> +
> +	ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
> +				SYSMON_CONFIG_SUPPLY_OSR,
> +				FIELD_PREP(SYSMON_CONFIG_SUPPLY_OSR, hw_val));
> +	if (ret)
> +		return ret;
> +
> +	/* Readback fence -- see sysmon_osr_write_temp for details */
> +	regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
> +
> +	return sysmon_set_avg_enable(sysmon, SYSMON_SUPPLY_EN_AVG_BASE,
> +				     SYSMON_SUPPLY_EN_AVG_COUNT,
> +				     hw_val ? ~0 : 0);
> +}
> +
> +static int sysmon_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long mask)
> +{
> +	struct sysmon *sysmon = iio_priv(indio_dev);
> +	unsigned int i;
> +	int ret;
> +
> +	if (mask != IIO_CHAN_INFO_OVERSAMPLING_RATIO)
> +		return -EINVAL;
> +
> +	for (i = 0; i < ARRAY_SIZE(sysmon_oversampling_avail); i++) {
> +		if (val == sysmon_oversampling_avail[i])
> +			break;
> +	}
> +	if (i == ARRAY_SIZE(sysmon_oversampling_avail))
> +		return -EINVAL;
> +
> +	guard(mutex)(&sysmon->lock);
> +
> +	if (chan->type == IIO_TEMP) {
> +		ret = sysmon_osr_write_temp(sysmon, val);
> +		if (ret)
> +			return ret;
> +		sysmon->temp_oversampling = val;
> +	} else {
> +		ret = sysmon_osr_write_supply(sysmon, val);
> +		if (ret)
> +			return ret;
> +		sysmon->supply_oversampling = val;
> +	}
> +
> +	return 0;
> +}
> +
> +static int sysmon_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan,
> +				    long mask)
> +{
> +	if (mask == IIO_CHAN_INFO_OVERSAMPLING_RATIO)
> +		return IIO_VAL_INT;
> +
> +	return -EINVAL;
> +}
> +
> +static int sysmon_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type,
> +			     int *length, long mask)
> +{
> +	if (mask != IIO_CHAN_INFO_OVERSAMPLING_RATIO)
> +		return -EINVAL;
> +
> +	*vals = sysmon_oversampling_avail;
> +	*type = IIO_VAL_INT;
> +	*length = ARRAY_SIZE(sysmon_oversampling_avail);
> +
> +	return IIO_AVAIL_LIST;
> +}
> +
>   static int sysmon_read_label(struct iio_dev *indio_dev,
>   			     struct iio_chan_spec const *chan,
>   			     char *label)
> @@ -464,6 +602,9 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
>   
>   static const struct iio_info sysmon_iio_info = {
>   	.read_raw = sysmon_read_raw,
> +	.write_raw = sysmon_write_raw,
> +	.write_raw_get_fmt = sysmon_write_raw_get_fmt,
> +	.read_avail = sysmon_read_avail,
>   	.read_label = sysmon_read_label,
>   	.read_event_config = sysmon_read_event_config,
>   	.write_event_config = sysmon_write_event_config,
> @@ -755,6 +896,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
>   			.indexed = 1,
>   			.address = reg,
>   			.info_mask_separate = BIT(IIO_CHAN_INFO_PROCESSED),
> +			.info_mask_shared_by_type =
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +			.info_mask_shared_by_type_available =
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>   			.event_spec = irq > 0 ?
>   				sysmon_supply_events : NULL,
>   			.num_event_specs = irq > 0 ?
> @@ -786,7 +931,11 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
>   			.address = SYSMON_TEMP_SAT_BASE +
>   				   (reg - 1) * SYSMON_REG_STRIDE,
>   			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> -			.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +			.info_mask_shared_by_type =
> +				BIT(IIO_CHAN_INFO_SCALE) |
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> +			.info_mask_shared_by_type_available =
> +				BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
>   			.datasheet_name = label,
>   		};
>   	}
> @@ -833,6 +982,8 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
>   
>   	sysmon = iio_priv(indio_dev);
>   	sysmon->regmap = regmap;
> +	sysmon->temp_oversampling = 1;
> +	sysmon->supply_oversampling = 1;
>   
>   	ret = devm_mutex_init(dev, &sysmon->lock);
>   	if (ret)
> diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
> index 9fe2793757a..bb9a75bf71c 100644
> --- a/drivers/iio/adc/versal-sysmon.h
> +++ b/drivers/iio/adc/versal-sysmon.h
> @@ -23,11 +23,13 @@ struct regmap;
>   #define SYSMON_IMR			0x0048
>   #define SYSMON_IER			0x004C
>   #define SYSMON_IDR			0x0050
> +#define SYSMON_CONFIG			0x0100
>   #define SYSMON_TEMP_MAX			0x1030
>   #define SYSMON_TEMP_MIN			0x1034
>   #define SYSMON_SUPPLY_BASE		0x1040
>   #define SYSMON_ALARM_FLAG		0x1018
>   #define SYSMON_ALARM_REG		0x1940
> +#define SYSMON_SUPPLY_EN_AVG_BASE	0x1958
>   #define SYSMON_TEMP_TH_LOW		0x1970
>   #define SYSMON_TEMP_TH_UP		0x1974
>   #define SYSMON_SUPPLY_TH_LOW		0x1980
> @@ -37,6 +39,7 @@ struct regmap;
>   #define SYSMON_TEMP_MAX_MAX		0x1F90
>   #define SYSMON_STATUS_RESET		0x1F94
>   #define SYSMON_TEMP_SAT_BASE		0x1FAC
> +#define SYSMON_TEMP_EN_AVG_BASE		0x24B4
>   #define SYSMON_MAX_REG			0x24C0
>   
>   /* NPI unlock value written to SYSMON_NPI_LOCK */
> @@ -53,6 +56,16 @@ struct regmap;
>   /* ISR/IMR temperature alarm mask (bit 9) */
>   #define SYSMON_TEMP_INTR_MASK		BIT(9)
>   
> +/* SYSMON_CONFIG: supply oversampling ratio */
> +#define SYSMON_CONFIG_SUPPLY_OSR	GENMASK(17, 14)
> +
> +/* SYSMON_CONFIG: temperature satellite oversampling ratio */
> +#define SYSMON_CONFIG_TEMP_SAT_OSR	GENMASK(27, 24)
> +
> +/* Per-channel averaging enable register counts */
> +#define SYSMON_SUPPLY_EN_AVG_COUNT	5
> +#define SYSMON_TEMP_EN_AVG_COUNT	2
> +
>   /* Supply voltage conversion register fields */
>   #define SYSMON_MANTISSA_MASK		GENMASK(15, 0)
>   #define SYSMON_FMT_MASK			BIT(16)
> @@ -77,6 +90,8 @@ struct regmap;
>    * @temp_mask: temperature interrupt configuration mask
>    * @temp_hysteresis: cached DEVICE_TEMP hysteresis in millicelsius
>    * @sysmon_unmask_work: re-enables events after alarm condition clears
> + * @temp_oversampling: current temp oversampling ratio
> + * @supply_oversampling: current supply oversampling ratio
>    */
>   struct sysmon {
>   	struct regmap *regmap;
> @@ -96,6 +111,8 @@ struct sysmon {
>   	unsigned int temp_mask;
>   	int temp_hysteresis;
>   	struct delayed_work sysmon_unmask_work;
> +	unsigned int temp_oversampling;
> +	unsigned int supply_oversampling;
>   };
>   
>   int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap);

