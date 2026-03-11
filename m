Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011018.outbound.protection.outlook.com [52.101.62.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032B6285056;
	Wed, 11 Mar 2026 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773223824; cv=fail; b=LAHhLvr5UeXlEI2TWlRY1mruewd95tFtEulY9kWFp+aGFEJWTdEmphjJabImx2ry5jHE0qzZGU+chgrG0xZKCVZV9GEEAzq03YBOHr+Y82q2S2YHjxlRQBPedwrMTc7/WAGtdfH2nhFC36aXhYZsbHMcw2OmAZ6bMSK1C5e8Yb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773223824; c=relaxed/simple;
	bh=B20Oyf97D3iTAZ5O+GB/7go+wHpEBck1DZsCjqzbLbU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vg6CAb7WnpvR02KH41uR5P3ckuZLRPcSX4I+0nT27ginmSP5u4DBZe99Ynoh4ENDXZnv83cst5q8O8rRtxBn5X+52PkyE6BbX3ABbD1NPmgNv/wmQI9/gn0ktj5faecJkmNDfBq2EwV+Wt074eifppeoTeO03PXeXwKwokHHQk0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ve6monkl; arc=fail smtp.client-ip=52.101.62.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ve6monkl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JpWnzVBBIMw47n/opu9MkSDvy5TKMM+t8+RUQBHnn9iMX7zITgra58riuwVU3+lGflz9nWSZcZWO3qW9EfGf8+5ysfmEaQfOcv75kA1GdmnCkG+wabCkdGWMViJNAPXo6igglnRte7ckX70wZkd9CLIvuyr8d5mLHjOvlpF3IzLPpUBW+YpgW7r5wer3QKWgMFrrzTF2CUyeqQkFrBbneYgMv3P1IVxxgzqrWjbNGOoOk8NbWisTDkP5DFYJOK1V1YldGxRjURmLt4MsJZNovYNaPMKHggfBFZc6d7BrGZjnvRw8jhMZ/HbynZlSDMtae/WXM5JYvlwq/KDrm/0Lew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Caa/m/jbHPcGMZtrxbXKA8KqCD05YLMvyd+DJXOarg=;
 b=laV8l5MT9bHy7hdI0cFuInq8Ferv7NdUalrPVKGHgb9CaJ9D6kQCguiGJGvR/KtsiTNib4JGHvuVUhIUM7unr/gqQgRNc/Q6FKpMfrlCketlLo57ECWioQnWoWOIgrP0pQOzC0YGaSu+cqRCSyoXBBa4oULLECPIoYKj0uUT3c+i3YxLF0afnGiOR9ondN8skZ4oVrJQfJLhH6B56CPS6Mu4Sorex0NvaqGCyGUmx/jyJBbwc4+qJGlexSr/1DmGf3XFO6k/YWn5hr9A1+ckz2hsu4JrUK/8tteCr7quWCAgMiOMeCDImie1PYUfMmmK/vRLjQRt1+J42QgYqUZv3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=nxp.com smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Caa/m/jbHPcGMZtrxbXKA8KqCD05YLMvyd+DJXOarg=;
 b=ve6monklucYbj2M6LXTwgmehkvEDwszhfCvi/MeKjjzM/atVVCVGdYQWeJf5Sm8HTBUsMjxUYJRkk9lJG/jJj+7EdkXbGy2iytxCooPmqZVBVEhruUe8DJYS9V/dTbVdOB5UwhMqTFDc4K2n1H9anAU0KgnWzy2XnAhCTLFDKCw=
Received: from SJ0PR05CA0061.namprd05.prod.outlook.com (2603:10b6:a03:332::6)
 by CH3PR10MB7502.namprd10.prod.outlook.com (2603:10b6:610:163::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 10:10:20 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::e6) by SJ0PR05CA0061.outlook.office365.com
 (2603:10b6:a03:332::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Wed,
 11 Mar 2026 10:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 11 Mar 2026 10:10:18 +0000
Received: from DFLE202.ent.ti.com (10.64.6.60) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 05:10:09 -0500
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE202.ent.ti.com
 (10.64.6.60) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 11 Mar
 2026 05:10:09 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 11 Mar 2026 05:10:09 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62BAA8AH654755;
	Wed, 11 Mar 2026 05:10:09 -0500
Date: Wed, 11 Mar 2026 15:40:07 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Shi Hao <i.shihao.999@gmail.com>
CC: <andriy.shevchenko@intel.com>, <andy@kernel.org>, <dlechner@baylibre.com>,
	<jic23@kernel.org>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <marcelo.schmitt@analog.com>,
	<nuno.sa@analog.com>, <mazziesaccount@gmail.com>, <daniel.baluta@nxp.com>,
	<simona.toaca@nxp.com>
Subject: Re: [PATCH v4 0/6] iio: fix spelling mistakes in comments
Message-ID: <20260311101007.gaqcner4fzamyirm@lcpd911>
References: <20260311093933.21333-1-i.shihao.999@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260311093933.21333-1-i.shihao.999@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CH3PR10MB7502:EE_
X-MS-Office365-Filtering-Correlation-Id: 7bfc5d6b-6d2c-4be7-f945-08de7f566628
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|7416014|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	Sp65nA3e3hbg4zPxVzUQ9jwG/bPEjsVA7APcHGbcDv5VpA0Qu6/78AcPRxy6Axtqq2Pjj/UpBqNX+LOkdt799UVPnAzgMdmp1+yMPqOz7wEbHZmcQBbsIrEP3v+DGJrUhmDgM9fhrbjRs3z6wOZo9PZ+1BWKXdDPxOUy+rVnXOAHQ9qFbe1UrN9qPyhnberd8UMWYCKoS26epUiMRXsgXJPdPvG8x18BJK+VJyoyCvwSeu9EXj4vKkuX+yxeBKmJec+Xr8Q8TjMusNhi4XhECkWBambtKe7MJh94klgkVeWmvu8cKcnpEPaUKkxT4scrW31+WrjgLgjVf5xj3D7BjrErgSVk9iLzdjqke+edkGZFjPYsIZpvgbsv0PC8Y/69h20rDKZBUivQnmvxZdKen9p9CqqfSSdHAZtjFMYxj8cHXfgQglVJ/Sp3y/8o8CQNZUjFo6g2oGqiKb5GP+HYBFWHyPaiyROutJRlJAY9yhTPLOTU8BYT346Aj3/PBnAsluQYJEoFuZfo3oRGnJPxsywZhzr3NeGRZdAJCGANjqQZORQyqEFI77V9TkYy+DtX5j7R0ziCASQe5fmRhhmkLhX+xlAgoZhqu2lYevsYP2L2IIpdIgUN32SmLPO1DE1L4hBFgYWC2STUeNyvUAFy7TG8iKCj0wjVlhiI/eFnGtnJlCcfLz7qaUzyJTrj3wo6s54+z3vgXauZOLKb206ukMP0gxPW+FVAc9BydfEHQT4zQFxMNg6/Ox49HlbI8Tpu8h+hOZsg4wbCz1VNxf4eCw==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(7416014)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wIvynzk2koKIOV5F7UAdWKOuWzQG3HnRRtyhj6b8KFpR0SVspsm854dTZIQDDLZ4kpfBLU0oQUpDZITazpo8JHXWlnoBuwu47adybRrnK+GcBstpc/g9/jTyAKV5/NlqgRdvMbqddEspD9snfvW/VXxY9T0clDREFnfNRT49whi+OIvCSrkWjXITef/PJIsDxhnqcLx/8dRGH3pHd0qL6B/XCfnYGEv4Wn0JeIDVr09hejP1hrNhgrxivVBIfIh8N7MKwALO380wMM5OCbNieGnWDakOUm3fjr5xQ/J78kdSt7McCunYRt8hNgaEo4Hc0bA0VAJImrK54/LhrfsYLqpAEQkQn4/AhV/ky4UoxmBS4wIJzR0zmrcOdNAZYf3GdDjIJpBw47FRYIN4KpMviT+JxN8nL17UucMT+UGq7KcqVCRAsitzZAG47wvaNeQK
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2026 10:10:18.9814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bfc5d6b-6d2c-4be7-f945-08de7f566628
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7502

On Mar 11, 2026 at 15:09:27 +0530, Shi Hao wrote:
> This series fixes spelling mistakes in comments across several IIO
> subsystems to improve readability and code consistency.

I just tried applying this series locally, on top of linux-next tag: next-20260310

Could you please make sure to use git format-patch with the option --base HEAD~N
where N is the number of your patches?
This will help identify what you used as the base commit for all your
changes. Make sure it's usually on top of the latest linux-next.

I also ran checkpatch on them, and saw a bunch of errors and warnings,
not sure if you've run it on your end and ensured it's clean?

> 
> v4:
> 
> - Fix commit message grammar and punctuation across patches
> - Keep 'whilst' instead of 'while'
> - Rephrase sentence in chemical driver comment
> - Capitalize IIO in comments

Also, in the changelog, please add links to your previous revisions.
This make reviewing things and getting context much easier.

> 
> v3:
> 
> - Change commit subjects as per changes
> - Capitalize proper acronyms (IRQ) and Celsius
> - Fix short wrap in commit body
> 
> v2:
> 
> - Split original patch into 6 commits
> - Fixed commit message formatting and typos
> - Added necessary tags in commits
> - Added more fixes then previous
> 
> Shi Hao (6):
>   iio: accel: fix typo celcius to Celsius
>   iio: adc: fix spelling mistakes in comments
>   iio: amplifiers: fix typo Curren to Current
>   iio: cdc: fix spelling mistakes in comments
>   iio: chemical: rephrase sentence and fix typo in comment
>   iio: common: fix spelling mistakes in comments
> 
>  drivers/iio/accel/adis16201.c                          | 2 +-
>  drivers/iio/accel/adis16209.c                          | 2 +-
>  drivers/iio/adc/ad4030.c                               | 2 +-
>  drivers/iio/adc/ad4170-4.c                             | 6 +++---
>  drivers/iio/adc/ad7380.c                               | 2 +-
>  drivers/iio/adc/ad7887.c                               | 2 +-
>  drivers/iio/adc/ad7923.c                               | 4 ++--
>  drivers/iio/adc/at91_adc.c                             | 4 ++--
>  drivers/iio/adc/max1363.c                              | 2 +-
>  drivers/iio/adc/mcp3564.c                              | 2 +-
>  drivers/iio/adc/men_z188_adc.c                         | 2 +-
>  drivers/iio/adc/npcm_adc.c                             | 2 +-
>  drivers/iio/adc/palmas_gpadc.c                         | 2 +-
>  drivers/iio/adc/rohm-bd79124.c                         | 4 ++--
>  drivers/iio/adc/spear_adc.c                            | 2 +-
>  drivers/iio/adc/stm32-adc-core.c                       | 2 +-
>  drivers/iio/adc/stm32-adc.c                            | 2 +-
>  drivers/iio/adc/sun20i-gpadc-iio.c                     | 2 +-
>  drivers/iio/adc/ti_am335x_adc.c                        | 2 +-
>  drivers/iio/adc/twl4030-madc.c                         | 2 +-
>  drivers/iio/adc/twl6030-gpadc.c                        | 4 ++--
>  drivers/iio/amplifiers/ada4250.c                       | 2 +-
>  drivers/iio/cdc/ad7150.c                               | 2 +-
>  drivers/iio/cdc/ad7746.c                               | 2 +-
>  drivers/iio/chemical/bme680_core.c                     | 2 +-
>  drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c   | 2 +-
>  drivers/iio/common/hid-sensors/hid-sensor-attributes.c | 2 +-
>  drivers/iio/common/inv_sensors/inv_sensors_timestamp.c | 2 +-
>  drivers/iio/common/ms_sensors/ms_sensors_i2c.c         | 2 +-
>  29 files changed, 35 insertions(+), 35 deletions(-)
> 
> --
> 2.53.0

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
