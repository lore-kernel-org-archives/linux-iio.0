Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010031.outbound.protection.outlook.com [52.101.85.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F474BCADF;
	Wed, 29 Jul 2026 13:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785332640; cv=fail; b=SDSb2Nl0szyU4WA7cwkJqdy1H0Pg+Roup43yQ8lh77qPLooPT6YpOTCYH5szzrars5HhL7Yrg5D19hPKER51TUn3QHLuN5N9nD9kgO6L2qXPXtbKbDFLQLogAhbW0iS/XNMdf/I4rmlnaIICFLCjA+EQDohLnTl5qKHamJX77bU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785332640; c=relaxed/simple;
	bh=Mwju4Viikyv/mfS6fwdCNx14giF0NSKIEhwlVo88LzQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MWjUnw0SG9DUTU0DsMeO4461e6aSyA0ZxO8LtexV3gKEfTQbVavQwXF49qi1HGytn/+keuYBbGr5yNBC85gWPDD9Ynib4RFnNkG3bLzVb0YkMJJOC3I7lY3+KApldh/Qp2oS3O1StbDFfeZTZP9xk10GphtRikQGVRhkQW2YwVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jz4Of7Dz; arc=fail smtp.client-ip=52.101.85.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jz4Of7Dz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrDQuvl1q5BLyp9XgPpZiehXZW72x6SYpvMTqA72oxM8XxQjY4C3FFq77f0zpremEjYODFdTLJovyGVTqU7JF5Alj0nMqg8zlutnkpc7ZuwjNcsE+Zf/P0fXDLiiQ8QeaTsgfMEDdml00vBwXqe0DJIKBcMER9v0nzw2uqiNfM8jhQEGtIvinERe1e0SXBNDZwr5p274S7SpGfcRleA8XnoJZ8M9IBilwhsBfM9vZtiFbgU2eAVfKwxs30LRkniLF3wMMHmz2Ml8ZCwsQUCaT6nUbdptk78P8PB/oKrG1hob7wWr9tr97TlW3L07WJgbJEMypnErRpjB4qZNRG8nMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/97upkWJ+n0TP9DLQ33kJwlsLxFPwFaFqEPB5W8fDg=;
 b=waLQsYsxa9j1YaqkMcilJMOZ2Y+Z3ZIh3EhuCyYSpN21Zn6qX4vee95BT79r3het0EaoeKPvdZh1i700PeiH9dQV5JWqDq3UMQb3ZY5/gdsXhC8yVCSHEQjzPLEL1aoG3jDSb0UQ9qR2zWz1V0MzrGjNz5o9Adl+AFHVAVVp36eIittnIQVNRK/eAocpiLwzQFq+QNUJRQS2ra1k/0FuO7HcxtjhJxlsH5y4obuBcfX15PRAakuhDJvYhQli5NaDlpLzvepTZo1S4JVcx72xty+E8goF6J9F4JXUJkU6SpmNL4MskPXz0jlgjAn9k3zJNKWI40rOifzF9MbXN3P+4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/97upkWJ+n0TP9DLQ33kJwlsLxFPwFaFqEPB5W8fDg=;
 b=jz4Of7DzE86dZzq26BcszQDDP6fqN2srubGC4Xlaqc6imOQcY5HycLl66GCWhKWX//awm+9OsrJbRNvWE032URXychqshmcel6+5BSicysq/vTiF+cmzItweR6PL++LgY/2JH9gXZIwaD4gAsMA2W+XLNrwRqgTDjzUXJugt7Zc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CY1PR12MB9697.namprd12.prod.outlook.com (2603:10b6:930:107::6)
 by SAWPR12MB999269.namprd12.prod.outlook.com (2603:10b6:806:55e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 13:43:52 +0000
Received: from CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d]) by CY1PR12MB9697.namprd12.prod.outlook.com
 ([fe80::3a41:55a0:8203:596d%6]) with mapi id 15.21.0270.009; Wed, 29 Jul 2026
 13:43:52 +0000
Message-ID: <56c6d6f7-c1fb-4e17-8440-0fa202717a30@amd.com>
Date: Wed, 29 Jul 2026 19:13:44 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] iio: adc: xilinx-xadc: Modernize driver code
To: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
 Conall O'Griofa <conall.ogriofa@amd.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, git@amd.com,
 Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
References: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
 <20260729125455.95893-2-DileepKumar.Nagavarapu@amd.com>
Content-Language: en-US
From: "Pandey, Radhey Shyam" <radheys@amd.com>
In-Reply-To: <20260729125455.95893-2-DileepKumar.Nagavarapu@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0055.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::8) To CY1PR12MB9697.namprd12.prod.outlook.com
 (2603:10b6:930:107::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY1PR12MB9697:EE_|SAWPR12MB999269:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f737a01-71fa-48f3-cf49-08deed776d26
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zOBA6asdZUQsSosD50zjCR42fTEkxksuGu+zH9sC8WblmTPZIOnW961E3rvi0MQ8HNADZC73fbL2Z32gRJK0P6A0BtF3U/xGQmEeZ4TBuNp1IgsPYJyJhz81icvnzNgiUK0/kdh2eS2AXE8wbmP8rfIiD60FgDHtC88jctG0UzEnOTgtrYAwgnNoz3s+8a7hNeg0m2ip3MY/xlUlKIyqU6yrHGnUo3TyE1lex8DmRELNZT5T6ApRjejUUFQintdBesJq5Gyc3R6asyBDmI7Clxnh0/Zh3Pw1pEDD9c3kEe69DbyDAtCxmVb8mcqf282N2uyfb5NqSfXzr4AIXSZVR4lPyrxiJiEPPzN8q0vO7/+dpORsvS+AE3s/MmcquSYrjFKfF4b5DDCzAw7BUBwZ+7up0Agc+ZgEDcvlpnqJfxHA3jaeGUm0zbMBTzut8g2w9X1jZ53KI8/itrwsD7fKpjJfURYi33bb0H0Dpyq7uVRcIUOsJnFjjp67sW3YTe7kL1aEWc8Sax5LPVnLIxSjFZv8MDA8mSraIDNr+ShD/cnw4Z6Y6n4K4XF1l28/mxv/XtNkuw+xFdSTnSoswFpz37obJreOIpL8qPxxjMSEKykUaHNPoPrZqAwF5DjlInbp7rijBRrU4KsmT8uGUEpf/qQRp7Vlg5NvtLP7a3VpCs0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY1PR12MB9697.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006)(6133799003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REIwOGJURnpjUjlmUUVIYkZUeXBIcHlhQ0ZiVm5teWNKVzNNMitPakx0YXVx?=
 =?utf-8?B?ZEZlR1lCYm8rbCtGSWw5c0lZcGR3ZG9PcXFZdU05M2dEMEN0MTBaR043b3ZB?=
 =?utf-8?B?N2ozckJZRUxnRmhqUnJKUFVrRU1NSzBhSS94SGdiMnlNQmhqMDU0eE5sTzFY?=
 =?utf-8?B?R0JpbHJMRDRYTGxoUGhGZUF6b2hsNEJ1SFFVSldwVHVzMDlrNWh6QU5wVUNZ?=
 =?utf-8?B?SExDRHZ2V1ZNRjVwVzVOaitJa2lQNXYrZWZ1eHVCdGVXNHl0dGZOckJjOHl1?=
 =?utf-8?B?V0F0YVNFaThnM2FtNXR0d05CeG9YMXpLRklGOWxOcERaaFI3d0JJNFpaWXlJ?=
 =?utf-8?B?M0Jab2RIV2pPYVYvR2ljd25HcDl6TlBMaGppNEpTSythRXFJS1J5N0NYTDAx?=
 =?utf-8?B?TTVNalJPN3p0anYzZXFxYWNYdUdpSWhSbmtQcHVDTjJ0MUxmbE03RkVnUjUw?=
 =?utf-8?B?Q2p2MW5SbnhoWGJFVWZPVVl4Y3NuOHArRTBSWnRFejVQcGo4dTFnV012ZWlU?=
 =?utf-8?B?WTl3a01uVGVyOFJzREJnQXBvdlcwU08yQjlkWWJkSTEwNTBHRG9OSDlPcmtF?=
 =?utf-8?B?Ui9SNzMrUXBiekFtWmdJT3ZoK3NvR1BhMFVidG03TDBsU2NZNnJUZmhybFBD?=
 =?utf-8?B?WjUrWk1xakcvR1k5Y05LbEhqdDNBM0FxUkFRTEJ6RGRwQ0ZIVkZUYnU0S2xk?=
 =?utf-8?B?T2xkM29zMDZtVzdEOEpmNUV0MStqTEpZc1pGNUNoS2VKZFJEejJsWHFmeE02?=
 =?utf-8?B?SWVkd2hTaVhxTjlRblVSdkQ5eWZZczgxMUR1ZHRIZXpBYXdCTXVGYk5pTU4v?=
 =?utf-8?B?QldMY1BmN0FhYzZ5dUhrVXFVMGJuWHRqUXF0Z3pxT2lyVW1DdVEvYUU1WmVD?=
 =?utf-8?B?dXBoaVU4enJpTDVia3R0dUlSeC9SSjR2OWdGOS9oNTdHb1J4VEJoL0syWXlM?=
 =?utf-8?B?V1VzTi8xNDlZd3k5TWxjZVlNVTNHSVY3NTB5MXNHZy8vQXRWd1RVNUorNnJy?=
 =?utf-8?B?Z0F6c0ZhQjZmc1NHOXY1R0R4UjRQQmpTUnovYWIwMW5GblU1RFBVWFcreU5F?=
 =?utf-8?B?SjBjbDhJRWlqa1ppRHVmR0VhQUpHc2w3S2Z2WVE3TFIzY1lZYnUrSzR1NWNx?=
 =?utf-8?B?aVJ0U1ZpbHNpditIb0tyOFhOUGVmQVNzdEtxbnUyMCs4eXRvOVhFRFI1STJu?=
 =?utf-8?B?eTlOcVdhMlB1TXhncHNncGsrcExibFUyNDRpMEdqZmx6eXRQZytVMndjck9W?=
 =?utf-8?B?UE1WVHVIVVhOYklZYlZ2M2ZUNGhiR1cvWTdvQS9nZGpTczNjUU8vcG1MbStt?=
 =?utf-8?B?Zmt2RllaQXdWT3NqR3NDVEdkZm1wZGlMVXFGYldwSHFSR0tzVmdoa215ZFla?=
 =?utf-8?B?MFhYNWdYWmdDS2JiYjh4Mm1LUklLNEpEQzZpM3NaOS90YW1mSXlLMUZubzNU?=
 =?utf-8?B?UXIreFZxSUlTU2JieWdwM3lvUFpEbmhKRnpxRTVEZ3lqZlBOOFNLdUJlUTdJ?=
 =?utf-8?B?azNxb1ZvblJzcWZ1ME1xZWM1NWJmUWpVNDhIaC9YeVFzYTVnTjFLUkZRWE9C?=
 =?utf-8?B?S1FqWUFiSlRNSVFFUW1YRE5zSEJ0QjJoVjZlYytNRHNZWEVOQnp5SC9hSXh0?=
 =?utf-8?B?NnFhVytnekZITVM2UlJ0Zy9HUDFLTW9yTzhaZW5SR2ttb1BnMU1HRHZ0UUNQ?=
 =?utf-8?B?RUtQQkN4Mjh3WEtkdEhBTCtwcldvMFB3RUtuUnU2MnNUV0ZwVjUyVWgwWEpP?=
 =?utf-8?B?Nmswa3NEM3N5SkU3WEhIVFB1bmpzd0Mzdit3R3hGbUZOVS9zajlSaWhOTzYr?=
 =?utf-8?B?dVVlb0hjei9GYjBtYlg0cmJ3a0JSZHFBQU5UejIxWURvbkNmT2ZrVHplaGd4?=
 =?utf-8?B?Zy8yT3RIaXNqNzBhamh2Y0hMckRiNUE5YjRwcGZINVR0enh0c3I4TlJOeko5?=
 =?utf-8?B?UGIyeGtRalR1M2hJNWlScm5jSFpzVHNyZ3Y5TkJBZkh5R0l0dHhpSGVKaFIx?=
 =?utf-8?B?dzJVK3NYWDJubU1wcUJqcXh3S0FiZTh5b0V2K2xUNm1hWkdLRVRHRVl2L3JQ?=
 =?utf-8?B?dktGWi9RK3pjMVAyU21aa3VqdGpUQXhIeHc3K0g0RnZYK0xhSFhTZXM4dWNC?=
 =?utf-8?B?YmFNY1BRaXhOa2MzQjBwcWsyUGZHUlVIZnRMZldQMVhSUDhxNlg1MlBWNXNV?=
 =?utf-8?B?cUM0bGRjamFqN1NJb1dIeXR0VG5Da1dKMlcyLzBSUGpZaWE2UXF6NHZwaEN1?=
 =?utf-8?B?bDZ2MW1hVHN2QTM5a3U3WUhtWm1nQWlDUGptekJuejc2N0tmN1VYUGp1UVQz?=
 =?utf-8?B?TjMvTmMvdlNXQ0NYaTJPdWpRSHhnb0ljLzlRVXN5TEl6K1JtSnkxUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f737a01-71fa-48f3-cf49-08deed776d26
X-MS-Exchange-CrossTenant-AuthSource: CY1PR12MB9697.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 13:43:52.5462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QL0N8WK7QvA50pBHDW/Q+M/QAbyRP6ns763MiUN+YWlb1NIbKX47jAcrWZvY81Bd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999269

On 7/29/2026 6:24 PM, Dileep Kumar Nagavarapu wrote:
> Modernize the XADC driver by updating the code to follow current
> kernel development practices.
> 
> The changes include:
> - Switching to kernel integer types (u16, u32)
> - Replacing open-coded bit manipulation with GENMASK(),
>    and FIELD_GET() helpers
> - Using cleanup and guard helpers where appropriate
> - Addressing coding style issues reported by checkpatch.pl
> - Removing legacy coding patterns and simplifying the code
> - Added MAINTAINERS entry for the Xilinx XADC driver
> 
> These updates improve readability, maintainability, and consistency
> with modern kernel APIs without changing functionality.

Too many changes in single patch. Separate each logical change into a
separate patch.

> 
> No functional change intended.
> 
> Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> Signed-off-by: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
> ---
>   MAINTAINERS                          |   7 +
>   drivers/iio/adc/xilinx-xadc-core.c   | 351 ++++++++++++---------------
>   drivers/iio/adc/xilinx-xadc-events.c |  53 ++--
>   drivers/iio/adc/xilinx-xadc.h        |  78 +++---
>   4 files changed, 222 insertions(+), 267 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2b1ec46c5919..7868de9c8fac 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29647,6 +29647,13 @@ F:	Documentation/devicetree/bindings/watchdog/xlnx,xps-timebase-wdt.yaml
>   F:	drivers/watchdog/of_xilinx_wdt.c
>   F:	drivers/watchdog/xilinx_wwdt.c
>   
> +XILINX XADC DRIVER
> +M:	Conall O'Griofa <conall.ogriofa@amd.com>
> +M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	drivers/iio/adc/xilinx-xadc*
> +
>   XILINX XDMA DRIVER
>   M:	Lizhi Hou <lizhi.hou@amd.com>
>   M:	Brian Xu <brian.xu@amd.com>
> diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
> index cab66bb8cc1c..b468179736f7 100644
> --- a/drivers/iio/adc/xilinx-xadc-core.c
> +++ b/drivers/iio/adc/xilinx-xadc-core.c
> @@ -11,6 +11,9 @@
>    *  - AXI XADC interface: Xilinx PG019
>    */
>   
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
>   #include <linux/clk.h>
>   #include <linux/device.h>
>   #include <linux/err.h>
> @@ -34,7 +37,7 @@
>   
>   #include "xilinx-xadc.h"
>   
> -static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
> +static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT_MS = 500;
>   
>   /* ZYNQ register definitions */
>   #define XADC_ZYNQ_REG_CFG	0x00
> @@ -46,28 +49,28 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
>   #define XADC_ZYNQ_REG_CTL		0x18
>   
>   #define XADC_ZYNQ_CFG_ENABLE		BIT(31)
> -#define XADC_ZYNQ_CFG_CFIFOTH_MASK	(0xf << 20)
> +#define XADC_ZYNQ_CFG_CFIFOTH_MASK	GENMASK(23, 20)
>   #define XADC_ZYNQ_CFG_CFIFOTH_OFFSET	20
> -#define XADC_ZYNQ_CFG_DFIFOTH_MASK	(0xf << 16)
> +#define XADC_ZYNQ_CFG_DFIFOTH_MASK	GENMASK(19, 16)
>   #define XADC_ZYNQ_CFG_DFIFOTH_OFFSET	16
>   #define XADC_ZYNQ_CFG_WEDGE		BIT(13)
>   #define XADC_ZYNQ_CFG_REDGE		BIT(12)
> -#define XADC_ZYNQ_CFG_TCKRATE_MASK	(0x3 << 8)
> -#define XADC_ZYNQ_CFG_TCKRATE_DIV2	(0x0 << 8)
> -#define XADC_ZYNQ_CFG_TCKRATE_DIV4	(0x1 << 8)
> -#define XADC_ZYNQ_CFG_TCKRATE_DIV8	(0x2 << 8)
> -#define XADC_ZYNQ_CFG_TCKRATE_DIV16	(0x3 << 8)
> -#define XADC_ZYNQ_CFG_IGAP_MASK		0x1f
> +#define XADC_ZYNQ_CFG_TCKRATE_MASK	GENMASK(9, 8)
> +#define XADC_ZYNQ_CFG_TCKRATE_DIV2	0
> +#define XADC_ZYNQ_CFG_TCKRATE_DIV4	BIT(8)
> +#define XADC_ZYNQ_CFG_TCKRATE_DIV8	BIT(9)
> +#define XADC_ZYNQ_CFG_TCKRATE_DIV16	GENMASK(9, 8)
> +#define XADC_ZYNQ_CFG_IGAP_MASK		GENMASK(4, 0)
>   #define XADC_ZYNQ_CFG_IGAP(x)		(x)
>   
>   #define XADC_ZYNQ_INT_CFIFO_LTH		BIT(9)
>   #define XADC_ZYNQ_INT_DFIFO_GTH		BIT(8)
> -#define XADC_ZYNQ_INT_ALARM_MASK	0xff
> +#define XADC_ZYNQ_INT_ALARM_MASK	GENMASK(7, 0)
>   #define XADC_ZYNQ_INT_ALARM_OFFSET	0
>   
> -#define XADC_ZYNQ_STATUS_CFIFO_LVL_MASK	(0xf << 16)
> +#define XADC_ZYNQ_STATUS_CFIFO_LVL_MASK	GENMASK(19, 16)
>   #define XADC_ZYNQ_STATUS_CFIFO_LVL_OFFSET	16
> -#define XADC_ZYNQ_STATUS_DFIFO_LVL_MASK	(0xf << 12)
> +#define XADC_ZYNQ_STATUS_DFIFO_LVL_MASK	GENMASK(15, 12)
>   #define XADC_ZYNQ_STATUS_DFIFO_LVL_OFFSET	12
>   #define XADC_ZYNQ_STATUS_CFIFOF		BIT(11)
>   #define XADC_ZYNQ_STATUS_CFIFOE		BIT(10)
> @@ -104,7 +107,7 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
>   #define XADC_AXI_GIER_ENABLE		BIT(31)
>   
>   #define XADC_AXI_INT_EOS		BIT(4)
> -#define XADC_AXI_INT_ALARM_MASK		0x3c0f
> +#define XADC_AXI_INT_ALARM_MASK		(GENMASK(13, 10) | GENMASK(3, 0))
>   
>   #define XADC_FLAGS_BUFFERED BIT(0)
>   #define XADC_FLAGS_IRQ_OPTIONAL BIT(1)
> @@ -117,16 +120,14 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
>    * limits the maximum samplerate 150kSPS. At this rate the CPU is fairly busy,
>    * but still responsive.
>    */
> -#define XADC_MAX_SAMPLERATE 150000
> +#define XADC_MAX_SAMPLERATE_SPS 150000
>   
> -static void xadc_write_reg(struct xadc *xadc, unsigned int reg,
> -	uint32_t val)
> +static void xadc_write_reg(struct xadc *xadc, unsigned int reg, u32 val)
>   {
>   	writel(val, xadc->base + reg);
>   }
>   
> -static void xadc_read_reg(struct xadc *xadc, unsigned int reg,
> -	uint32_t *val)
> +static void xadc_read_reg(struct xadc *xadc, unsigned int reg, u32 *val)
>   {
>   	*val = readl(xadc->base + reg);
>   }
> @@ -140,60 +141,55 @@ static void xadc_read_reg(struct xadc *xadc, unsigned int reg,
>    * sleep and wait for an interrupt that signals that a response is available in
>    * the data FIFO.
>    */
> -
> -static void xadc_zynq_write_fifo(struct xadc *xadc, uint32_t *cmd,
> -	unsigned int n)
> +static void xadc_zynq_write_fifo(struct xadc *xadc, u32 *cmd, unsigned int n)
>   {
> -	unsigned int i;
> -
> -	for (i = 0; i < n; i++)
> +	for (unsigned int i = 0; i < n; i++)
>   		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFIFO, cmd[i]);
>   }
>   
>   static void xadc_zynq_drain_fifo(struct xadc *xadc)
>   {
> -	uint32_t status, tmp;
> +	u32 status, tmp;
>   
>   	xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
>   
> +	/*
> +	 * Reading XADC_ZYNQ_REG_DFIFO pops one entry from the data FIFO.
> +	 * The loop therefore removes one pending entry per iteration and
> +	 * terminates once the hardware reports the FIFO empty.
> +	 */
>   	while (!(status & XADC_ZYNQ_STATUS_DFIFOE)) {
>   		xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
>   		xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
>   	}
>   }
>   
> -static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask,
> -	unsigned int val)
> +static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask, unsigned int val)
>   {
> -	xadc->zynq_intmask &= ~mask;
> -	xadc->zynq_intmask |= val;
> +	xadc->zynq_intmask = (xadc->zynq_intmask & ~mask) | (val & mask);
>   
> -	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK,
> -		xadc->zynq_intmask | xadc->zynq_masked_alarm);
> +	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask | xadc->zynq_masked_alarm);
>   }
>   
> -static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg,
> -	uint16_t val)
> +static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
>   {
> -	uint32_t cmd[1];
> -	uint32_t tmp;
> +	u32 cmd[1];
> +	u32 tmp;
>   	int ret;
>   
> -	spin_lock_irq(&xadc->lock);
> -	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
> -			XADC_ZYNQ_INT_DFIFO_GTH);
> +	scoped_guard(spinlock_irq, &xadc->lock) {
> +		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
>   
> -	reinit_completion(&xadc->completion);
> +		reinit_completion(&xadc->completion);
>   
> -	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_WRITE, reg, val);
> -	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
> -	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
> -	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
> -	tmp |= 0 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
> -	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
> +		cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_WRITE, reg, val);
> +		xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
> +		xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
> +		tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
> +		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
>   
> -	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
> -	spin_unlock_irq(&xadc->lock);
> +		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
> +	}
>   
>   	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
>   	if (ret == 0)
> @@ -206,49 +202,50 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg,
>   	return ret;
>   }
>   
> -static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
> -	uint16_t *val)
> +static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
>   {
> -	uint32_t cmd[2];
> -	uint32_t resp, tmp;
> +	u32 cmd[2];
> +	u32 resp, tmp;
>   	int ret;
>   
>   	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_READ, reg, 0);
>   	cmd[1] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_NOP, 0, 0);
>   
> -	spin_lock_irq(&xadc->lock);
> -	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
> -			XADC_ZYNQ_INT_DFIFO_GTH);
> -	xadc_zynq_drain_fifo(xadc);
> -	reinit_completion(&xadc->completion);
> +	scoped_guard(spinlock_irq, &xadc->lock) {
> +		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
> +		xadc_zynq_drain_fifo(xadc);
> +		reinit_completion(&xadc->completion);
>   
> -	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
> -	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
> -	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
> -	tmp |= 1 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
> -	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
> +		xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
> +		xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
> +		tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
> +		tmp |= FIELD_PREP(XADC_ZYNQ_CFG_DFIFOTH_MASK, 1);
> +		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
>   
> -	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
> -	spin_unlock_irq(&xadc->lock);
> +		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
> +	}
>   	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
>   	if (ret == 0)
>   		ret = -EIO;
> +
>   	if (ret < 0)
>   		return ret;
>   
>   	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
>   	xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &resp);
>   
> -	*val = resp & 0xffff;
> +	*val = resp;
>   
>   	return 0;
>   }
>   
>   static unsigned int xadc_zynq_transform_alarm(unsigned int alarm)
>   {
> -	return ((alarm & 0x80) >> 4) |
> -		((alarm & 0x78) << 1) |
> -		(alarm & 0x07);
> +	/*
> +	 * Reorder the Zynq PS-XADC alarm bits defined in UG585 to match the common
> +	 * XADC driver alarm layout.
> +	 */
> +	return ((alarm & 0x80) >> 4) | ((alarm & 0x78) << 1) | (alarm & 0x07);
>   }
>   
>   /*
> @@ -268,35 +265,32 @@ static void xadc_zynq_unmask_worker(struct work_struct *work)
>   
>   	misc_sts &= XADC_ZYNQ_INT_ALARM_MASK;
>   
> -	spin_lock_irq(&xadc->lock);
> +	scoped_guard(spinlock_irq, &xadc->lock) {
> +		/* Clear those bits which are not active anymore */
> +		unmask = (xadc->zynq_masked_alarm ^ misc_sts) & xadc->zynq_masked_alarm;
> +		xadc->zynq_masked_alarm &= misc_sts;
>   
> -	/* Clear those bits which are not active anymore */
> -	unmask = (xadc->zynq_masked_alarm ^ misc_sts) & xadc->zynq_masked_alarm;
> -	xadc->zynq_masked_alarm &= misc_sts;
> +		/* Also clear those which are masked out anyway */
> +		xadc->zynq_masked_alarm &= ~xadc->zynq_intmask;
>   
> -	/* Also clear those which are masked out anyway */
> -	xadc->zynq_masked_alarm &= ~xadc->zynq_intmask;
> +		/* Clear the interrupts before we unmask them */
> +		xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, unmask);
>   
> -	/* Clear the interrupts before we unmask them */
> -	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, unmask);
> -
> -	xadc_zynq_update_intmsk(xadc, 0, 0);
> -
> -	spin_unlock_irq(&xadc->lock);
> +		xadc_zynq_update_intmsk(xadc, 0, 0);
> +	}
>   
>   	/* if still pending some alarm re-trigger the timer */
>   	if (xadc->zynq_masked_alarm) {
>   		schedule_delayed_work(&xadc->zynq_unmask_work,
> -				msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
> +				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT_MS));
>   	}
> -
>   }
>   
>   static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
>   {
>   	struct iio_dev *indio_dev = devid;
>   	struct xadc *xadc = iio_priv(indio_dev);
> -	uint32_t status;
> +	u32 status;
>   
>   	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
>   
> @@ -305,13 +299,12 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
>   	if (!status)
>   		return IRQ_NONE;
>   
> -	spin_lock(&xadc->lock);
> +	guard(spinlock)(&xadc->lock);
>   
>   	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status);
>   
>   	if (status & XADC_ZYNQ_INT_DFIFO_GTH) {
> -		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
> -			XADC_ZYNQ_INT_DFIFO_GTH);
> +		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
>   		complete(&xadc->completion);
>   	}
>   
> @@ -324,24 +317,21 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
>   		 */
>   		xadc_zynq_update_intmsk(xadc, 0, 0);
>   
> -		xadc_handle_events(indio_dev,
> -				xadc_zynq_transform_alarm(status));
> +		xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(status));
>   
>   		/* unmask the required interrupts in timer. */
>   		schedule_delayed_work(&xadc->zynq_unmask_work,
> -				msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
> +				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT_MS));
>   	}
> -	spin_unlock(&xadc->lock);
>   
>   	return IRQ_HANDLED;
>   }
>   
> -#define XADC_ZYNQ_TCK_RATE_MAX 50000000
> -#define XADC_ZYNQ_IGAP_DEFAULT 20
> -#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
> +#define XADC_ZYNQ_TCK_RATE_MAX_HZ 50000000
> +#define XADC_ZYNQ_IGAP_DEFAULT_CYCLES 20
> +#define XADC_ZYNQ_PCAP_RATE_MAX_HZ 200000000
>   
> -static int xadc_zynq_setup(struct platform_device *pdev,
> -	struct iio_dev *indio_dev, int irq)
> +static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
>   {
>   	struct xadc *xadc = iio_priv(indio_dev);
>   	unsigned long pcap_rate;
> @@ -352,8 +342,8 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>   	int ret;
>   
>   	/* TODO: Figure out how to make igap and tck_rate configurable */
> -	igap = XADC_ZYNQ_IGAP_DEFAULT;
> -	tck_rate = XADC_ZYNQ_TCK_RATE_MAX;
> +	igap = XADC_ZYNQ_IGAP_DEFAULT_CYCLES;
> +	tck_rate = XADC_ZYNQ_TCK_RATE_MAX_HZ;
>   
>   	xadc->zynq_intmask = ~0;
>   
> @@ -361,9 +351,8 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>   	if (!pcap_rate)
>   		return -EINVAL;
>   
> -	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> -		ret = clk_set_rate(xadc->clk,
> -				   (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
> +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX_HZ) {
> +		ret = clk_set_rate(xadc->clk, (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX_HZ);
>   		if (ret)
>   			return ret;
>   	}
> @@ -372,7 +361,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>   		div = 2;
>   	} else {
>   		div = pcap_rate / tck_rate;
> -		if (pcap_rate / div > XADC_ZYNQ_TCK_RATE_MAX)
> +		if (pcap_rate / div > XADC_ZYNQ_TCK_RATE_MAX_HZ)
>   			div++;
>   	}
>   
> @@ -389,11 +378,10 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>   	xadc_write_reg(xadc, XADC_ZYNQ_REG_CTL, 0);
>   	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
>   	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
> -	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE |
> -			XADC_ZYNQ_CFG_REDGE | XADC_ZYNQ_CFG_WEDGE |
> -			tck_div | XADC_ZYNQ_CFG_IGAP(igap));
> +	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE | XADC_ZYNQ_CFG_REDGE |
> +			       XADC_ZYNQ_CFG_WEDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
>   
> -	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
> +	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX_HZ) {
>   		ret = clk_set_rate(xadc->clk, pcap_rate);
>   		if (ret)
>   			return ret;
> @@ -405,7 +393,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
>   static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
>   {
>   	unsigned int div;
> -	uint32_t val;
> +	u32 val;
>   
>   	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &val);
>   
> @@ -429,22 +417,18 @@ static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
>   
>   static void xadc_zynq_update_alarm(struct xadc *xadc, unsigned int alarm)
>   {
> -	unsigned long flags;
> -	uint32_t status;
> +	u32 status;
>   
>   	/* Move OT to bit 7 */
>   	alarm = ((alarm & 0x08) << 4) | ((alarm & 0xf0) >> 1) | (alarm & 0x07);
>   
> -	spin_lock_irqsave(&xadc->lock, flags);
> +	guard(spinlock_irqsave)(&xadc->lock);
>   
>   	/* Clear previous interrupts if any. */
>   	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
>   	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status & alarm);
>   
> -	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK,
> -		~alarm & XADC_ZYNQ_INT_ALARM_MASK);
> -
> -	spin_unlock_irqrestore(&xadc->lock, flags);
> +	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK, ~alarm & XADC_ZYNQ_INT_ALARM_MASK);
>   }
>   
>   static const struct xadc_ops xadc_zynq_ops = {
> @@ -465,29 +449,24 @@ static const unsigned int xadc_axi_reg_offsets[] = {
>   	[XADC_TYPE_US] = XADC_US_AXI_ADC_REG_OFFSET,
>   };
>   
> -static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg,
> -	uint16_t *val)
> +static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
>   {
> -	uint32_t val32;
> +	u32 val32;
>   
> -	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4,
> -		&val32);
> -	*val = val32 & 0xffff;
> +	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, &val32);
> +	*val = val32;
>   
>   	return 0;
>   }
>   
> -static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg,
> -	uint16_t val)
> +static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
>   {
> -	xadc_write_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4,
> -		val);
> +	xadc_write_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, val);
>   
>   	return 0;
>   }
>   
> -static int xadc_axi_setup(struct platform_device *pdev,
> -	struct iio_dev *indio_dev, int irq)
> +static int xadc_axi_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
>   {
>   	struct xadc *xadc = iio_priv(indio_dev);
>   
> @@ -501,7 +480,7 @@ static irqreturn_t xadc_axi_interrupt_handler(int irq, void *devid)
>   {
>   	struct iio_dev *indio_dev = devid;
>   	struct xadc *xadc = iio_priv(indio_dev);
> -	uint32_t status, mask;
> +	u32 status, mask;
>   	unsigned int events;
>   
>   	xadc_read_reg(xadc, XADC_AXI_REG_IPISR, &status);
> @@ -534,8 +513,7 @@ static irqreturn_t xadc_axi_interrupt_handler(int irq, void *devid)
>   
>   static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
>   {
> -	uint32_t val;
> -	unsigned long flags;
> +	u32 val;
>   
>   	/*
>   	 * The order of the bits in the AXI-XADC status register does not match
> @@ -543,15 +521,13 @@ static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
>   	 * passed the alarm mask in the same order as in the XADC alarm enable
>   	 * register.
>   	 */
> -	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) |
> -			((alarm & 0xf0) << 6);
> +	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) | ((alarm & 0xf0) << 6);
>   
> -	spin_lock_irqsave(&xadc->lock, flags);
> +	guard(spinlock_irqsave)(&xadc->lock);
>   	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
>   	val &= ~XADC_AXI_INT_ALARM_MASK;
>   	val |= alarm;
>   	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
> -	spin_unlock_irqrestore(&xadc->lock, flags);
>   }
>   
>   static unsigned long xadc_axi_get_dclk(struct xadc *xadc)
> @@ -590,10 +566,9 @@ static const struct xadc_ops xadc_us_axi_ops = {
>   	.temp_offset = 280231,
>   };
>   
> -static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
> -	uint16_t mask, uint16_t val)
> +static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)
>   {
> -	uint16_t tmp;
> +	u16 tmp;
>   	int ret;
>   
>   	ret = _xadc_read_adc_reg(xadc, reg, &tmp);
> @@ -603,8 +578,7 @@ static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
>   	return _xadc_write_adc_reg(xadc, reg, (tmp & ~mask) | val);
>   }
>   
> -static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
> -	uint16_t mask, uint16_t val)
> +static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)
>   {
>   	int ret;
>   
> @@ -620,17 +594,16 @@ static unsigned long xadc_get_dclk_rate(struct xadc *xadc)
>   	return xadc->ops->get_dclk_rate(xadc);
>   }
>   
> -static int xadc_update_scan_mode(struct iio_dev *indio_dev,
> -	const unsigned long *mask)
> +static int xadc_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *mask)
>   {
>   	struct xadc *xadc = iio_priv(indio_dev);
> -	size_t n;
>   	void *data;
> +	size_t n;
>   
>   	n = bitmap_weight(mask, iio_get_masklength(indio_dev));
>   
> -	data = devm_krealloc_array(indio_dev->dev.parent, xadc->data,
> -				   n, sizeof(*xadc->data), GFP_KERNEL);
> +	data = devm_krealloc_array(indio_dev->dev.parent, xadc->data, n,
> +				   sizeof(*xadc->data), GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
>   
> @@ -697,7 +670,6 @@ static irqreturn_t xadc_trigger_handler(int irq, void *p)
>   static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
>   {
>   	struct xadc *xadc = iio_trigger_get_drvdata(trigger);
> -	unsigned long flags;
>   	unsigned int convst;
>   	unsigned int val;
>   	int ret = 0;
> @@ -706,7 +678,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
>   
>   	if (state) {
>   		/* Only one of the two triggers can be active at a time. */
> -		if (xadc->trigger != NULL) {
> +		if (xadc->trigger) {
>   			ret = -EBUSY;
>   			goto err_out;
>   		} else {
> @@ -716,23 +688,22 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
>   			else
>   				convst = 0;
>   		}
> -		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC,
> -					convst);
> +		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC, convst);
>   		if (ret)
>   			goto err_out;
>   	} else {
>   		xadc->trigger = NULL;
>   	}
>   
> -	spin_lock_irqsave(&xadc->lock, flags);
> -	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
> -	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
> -	if (state)
> -		val |= XADC_AXI_INT_EOS;
> -	else
> -		val &= ~XADC_AXI_INT_EOS;
> -	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
> -	spin_unlock_irqrestore(&xadc->lock, flags);
> +	scoped_guard(spinlock_irqsave, &xadc->lock) {
> +		xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
> +		xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
> +		if (state)
> +			val |= XADC_AXI_INT_EOS;
> +		else
> +			val &= ~XADC_AXI_INT_EOS;
> +		xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
> +	}
>   
>   err_out:
>   	mutex_unlock(&xadc->mutex);
> @@ -744,8 +715,7 @@ static const struct iio_trigger_ops xadc_trigger_ops = {
>   	.set_trigger_state = &xadc_trigger_set_state,
>   };
>   
> -static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
> -	const char *name)
> +static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev, const char *name)
>   {
>   	struct device *dev = indio_dev->dev.parent;
>   	struct iio_trigger *trig;
> @@ -753,7 +723,7 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
>   
>   	trig = devm_iio_trigger_alloc(dev, "%s%d-%s", indio_dev->name,
>   				      iio_device_id(indio_dev), name);
> -	if (trig == NULL)
> +	if (!trig)
>   		return ERR_PTR(-ENOMEM);
>   
>   	trig->ops = &xadc_trigger_ops;
> @@ -768,7 +738,7 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
>   
>   static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
>   {
> -	uint16_t val;
> +	u16 val;
>   
>   	/*
>   	 * As per datasheet the power-down bits are don't care in the
> @@ -790,8 +760,7 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
>   		break;
>   	}
>   
> -	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK,
> -		val);
> +	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK, val);
>   }
>   
>   static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
> @@ -805,8 +774,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
>   	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
>   		return XADC_CONF1_SEQ_SIMULTANEOUS;
>   
> -	if ((aux_scan_mode & 0xff00) == 0 ||
> -		(aux_scan_mode & 0x00ff) == 0)
> +	if (!(aux_scan_mode & 0xff00) || !(aux_scan_mode & 0x00ff))
>   		return XADC_CONF1_SEQ_CONTINUOUS;
>   
>   	return XADC_CONF1_SEQ_SIMULTANEOUS;
> @@ -839,8 +807,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
>   	if (ret)
>   		return ret;
>   
> -	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
> -				  seq_mode);
> +	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK, seq_mode);
>   	if (ret)
>   		return ret;
>   
> @@ -855,7 +822,7 @@ static int xadc_preenable(struct iio_dev *indio_dev)
>   	int ret;
>   
>   	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
> -		XADC_CONF1_SEQ_DEFAULT);
> +				  XADC_CONF1_SEQ_DEFAULT);
>   	if (ret)
>   		goto err;
>   
> @@ -884,8 +851,7 @@ static int xadc_preenable(struct iio_dev *indio_dev)
>   	if (ret)
>   		goto err;
>   
> -	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
> -		seq_mode);
> +	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK, seq_mode);
>   	if (ret)
>   		goto err;
>   
> @@ -903,14 +869,14 @@ static const struct iio_buffer_setup_ops xadc_buffer_ops = {
>   static int xadc_read_samplerate(struct xadc *xadc)
>   {
>   	unsigned int div;
> -	uint16_t val16;
> +	u16 val16;
>   	int ret;
>   
>   	ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
>   	if (ret)
>   		return ret;
>   
> -	div = (val16 & XADC_CONF2_DIV_MASK) >> XADC_CONF2_DIV_OFFSET;
> +	div = FIELD_GET(XADC_CONF2_DIV_MASK, val16);
>   	if (div < 2)
>   		div = 2;
>   
> @@ -918,11 +884,11 @@ static int xadc_read_samplerate(struct xadc *xadc)
>   }
>   
>   static int xadc_read_raw(struct iio_dev *indio_dev,
> -	struct iio_chan_spec const *chan, int *val, int *val2, long info)
> +			 struct iio_chan_spec const *chan, int *val, int *val2, long info)
>   {
>   	struct xadc *xadc = iio_priv(indio_dev);
>   	unsigned int bits = chan->scan_type.realbits;
> -	uint16_t val16;
> +	u16 val16;
>   	int ret;
>   
>   	switch (info) {
> @@ -996,8 +962,8 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
>   		return -EINVAL;
>   
>   	/* Max. 150 kSPS */
> -	if (val > XADC_MAX_SAMPLERATE)
> -		val = XADC_MAX_SAMPLERATE;
> +	if (val > XADC_MAX_SAMPLERATE_SPS)
> +		val = XADC_MAX_SAMPLERATE_SPS;
>   
>   	val *= 26;
>   
> @@ -1010,7 +976,7 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
>   	 * limit.
>   	 */
>   	div = clk_rate / val;
> -	if (clk_rate / div / 26 > XADC_MAX_SAMPLERATE)
> +	if (clk_rate / div / 26 > XADC_MAX_SAMPLERATE_SPS)
>   		div++;
>   	if (div < 2)
>   		div = 2;
> @@ -1018,11 +984,11 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
>   		div = 0xff;
>   
>   	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_DIV_MASK,
> -		div << XADC_CONF2_DIV_OFFSET);
> +				   div << XADC_CONF2_DIV_OFFSET);
>   }
>   
>   static int xadc_write_raw(struct iio_dev *indio_dev,
> -	struct iio_chan_spec const *chan, int val, int val2, long info)
> +			  struct iio_chan_spec const *chan, int val, int val2, long info)
>   {
>   	struct xadc *xadc = iio_priv(indio_dev);
>   
> @@ -1037,8 +1003,8 @@ static const struct iio_event_spec xadc_temp_events[] = {
>   		.type = IIO_EV_TYPE_THRESH,
>   		.dir = IIO_EV_DIR_RISING,
>   		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
> -				BIT(IIO_EV_INFO_VALUE) |
> -				BIT(IIO_EV_INFO_HYSTERESIS),
> +				 BIT(IIO_EV_INFO_VALUE) |
> +				 BIT(IIO_EV_INFO_HYSTERESIS),
>   	},
>   };
>   
> @@ -1294,9 +1260,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
>   	}
>   
>   	indio_dev->num_channels = num_channels;
> -	indio_dev->channels = devm_krealloc_array(dev, channels,
> -						  num_channels, sizeof(*channels),
> -						  GFP_KERNEL);
> +	indio_dev->channels = devm_krealloc_array(dev, channels, num_channels,
> +						  sizeof(*channels), GFP_KERNEL);
>   	/* If we can't resize the channels array, just use the original */
>   	if (!indio_dev->channels)
>   		indio_dev->channels = channels;
> @@ -1304,7 +1269,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
>   	return 0;
>   }
>   
> -static const char * const xadc_type_names[] = {
> +static const char *const xadc_type_names[] = {
>   	[XADC_TYPE_S7] = "xadc",
>   	[XADC_TYPE_US] = "xilinx-system-monitor",
>   };
> @@ -1333,8 +1298,7 @@ static int xadc_probe(struct platform_device *pdev)
>   		return -EINVAL;
>   
>   	irq = platform_get_irq_optional(pdev, 0);
> -	if (irq < 0 &&
> -	    (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
> +	if (irq < 0 && (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
>   		return irq;
>   
>   	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
> @@ -1361,10 +1325,8 @@ static int xadc_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
> -		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -						      &iio_pollfunc_store_time,
> -						      &xadc_trigger_handler,
> -						      &xadc_buffer_ops);
> +		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, &iio_pollfunc_store_time,
> +						      &xadc_trigger_handler, &xadc_buffer_ops);
>   		if (ret)
>   			return ret;
>   
> @@ -1373,8 +1335,7 @@ static int xadc_probe(struct platform_device *pdev)
>   			if (IS_ERR(xadc->convst_trigger))
>   				return PTR_ERR(xadc->convst_trigger);
>   
> -			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
> -				"samplerate");
> +			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev, "samplerate");
>   			if (IS_ERR(xadc->samplerate_trigger))
>   				return PTR_ERR(xadc->samplerate_trigger);
>   		}
> @@ -1393,8 +1354,8 @@ static int xadc_probe(struct platform_device *pdev)
>   		if (ret < 0)
>   			return ret;
>   
> -		if (ret > XADC_MAX_SAMPLERATE) {
> -			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE);
> +		if (ret > XADC_MAX_SAMPLERATE_SPS) {
> +			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE_SPS);
>   			if (ret < 0)
>   				return ret;
>   		}
> @@ -1417,8 +1378,7 @@ static int xadc_probe(struct platform_device *pdev)
>   		return ret;
>   
>   	for (i = 0; i < 16; i++)
> -		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
> -			&xadc->threshold[i]);
> +		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i), &xadc->threshold[i]);
>   
>   	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
>   	if (ret)
> @@ -1434,8 +1394,7 @@ static int xadc_probe(struct platform_device *pdev)
>   	if (ret)
>   		return ret;
>   
> -	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1),
> -		bipolar_mask >> 16);
> +	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1), bipolar_mask >> 16);
>   	if (ret)
>   		return ret;
>   
> diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
> index c188d3dcab48..e0e1195b7017 100644
> --- a/drivers/iio/adc/xilinx-xadc-events.c
> +++ b/drivers/iio/adc/xilinx-xadc-events.c
> @@ -8,12 +8,11 @@
>   
>   #include <linux/iio/events.h>
>   #include <linux/iio/iio.h>
> -#include <linux/kernel.h>
>   
>   #include "xilinx-xadc.h"
>   
> -static const struct iio_chan_spec *xadc_event_to_channel(
> -	struct iio_dev *indio_dev, unsigned int event)
> +static const struct iio_chan_spec *xadc_event_to_channel
> +		  (struct iio_dev *indio_dev, unsigned int event)
>   {
>   	switch (event) {
>   	case XADC_THRESHOLD_OT_MAX:
> @@ -23,7 +22,7 @@ static const struct iio_chan_spec *xadc_event_to_channel(
>   	case XADC_THRESHOLD_VCCAUX_MAX:
>   		return &indio_dev->channels[event];
>   	default:
> -		return &indio_dev->channels[event-1];
> +		return &indio_dev->channels[event - 1];
>   	}
>   }
>   
> @@ -43,9 +42,10 @@ static void xadc_handle_event(struct iio_dev *indio_dev, unsigned int event)
>   		 * events.
>   		 */
>   		iio_push_event(indio_dev,
> -			IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
> -				IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
> -			iio_get_time_ns(indio_dev));
> +			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_RISING),
> +			       iio_get_time_ns(indio_dev));
>   	} else {
>   		/*
>   		 * For other channels we don't know whether it is a upper or
> @@ -53,9 +53,10 @@ static void xadc_handle_event(struct iio_dev *indio_dev, unsigned int event)
>   		 * channel value if it wants to know.
>   		 */
>   		iio_push_event(indio_dev,
> -			IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
> -				IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
> -			iio_get_time_ns(indio_dev));
> +			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
> +						    IIO_EV_TYPE_THRESH,
> +						    IIO_EV_DIR_EITHER),
> +			       iio_get_time_ns(indio_dev));
>   	}
>   }
>   
> @@ -68,7 +69,7 @@ void xadc_handle_events(struct iio_dev *indio_dev, unsigned long events)
>   }
>   
>   static unsigned int xadc_get_threshold_offset(const struct iio_chan_spec *chan,
> -	enum iio_event_direction dir)
> +					      enum iio_event_direction dir)
>   {
>   	unsigned int offset;
>   
> @@ -110,22 +111,20 @@ static unsigned int xadc_get_alarm_mask(const struct iio_chan_spec *chan)
>   	}
>   }
>   
> -int xadc_read_event_config(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, enum iio_event_type type,
> -	enum iio_event_direction dir)
> +int xadc_read_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +			   enum iio_event_type type, enum iio_event_direction dir)
>   {
>   	struct xadc *xadc = iio_priv(indio_dev);
>   
>   	return (bool)(xadc->alarm_mask & xadc_get_alarm_mask(chan));
>   }
>   
> -int xadc_write_event_config(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, enum iio_event_type type,
> -	enum iio_event_direction dir, bool state)
> +int xadc_write_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +			    enum iio_event_type type, enum iio_event_direction dir, bool state)
>   {
>   	unsigned int alarm = xadc_get_alarm_mask(chan);
>   	struct xadc *xadc = iio_priv(indio_dev);
> -	uint16_t cfg, old_cfg;
> +	u16 cfg, old_cfg;
>   	int ret;
>   
>   	mutex_lock(&xadc->mutex);
> @@ -155,10 +154,9 @@ int xadc_write_event_config(struct iio_dev *indio_dev,
>   	return ret;
>   }
>   
> -int xadc_read_event_value(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, enum iio_event_type type,
> -	enum iio_event_direction dir, enum iio_event_info info,
> -	int *val, int *val2)
> +int xadc_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +			  enum iio_event_type type, enum iio_event_direction dir,
> +			  enum iio_event_info info, int *val, int *val2)
>   {
>   	unsigned int offset = xadc_get_threshold_offset(chan, dir);
>   	struct xadc *xadc = iio_priv(indio_dev);
> @@ -180,10 +178,9 @@ int xadc_read_event_value(struct iio_dev *indio_dev,
>   	return IIO_VAL_INT;
>   }
>   
> -int xadc_write_event_value(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, enum iio_event_type type,
> -	enum iio_event_direction dir, enum iio_event_info info,
> -	int val, int val2)
> +int xadc_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +			   enum iio_event_type type, enum iio_event_direction dir,
> +			   enum iio_event_info info, int val, int val2)
>   {
>   	unsigned int offset = xadc_get_threshold_offset(chan, dir);
>   	struct xadc *xadc = iio_priv(indio_dev);
> @@ -227,9 +224,9 @@ int xadc_write_event_value(struct iio_dev *indio_dev,
>   			xadc->threshold[offset + 4] = 0;
>   		else
>   			xadc->threshold[offset + 4] = xadc->threshold[offset] -
> -					xadc->temp_hysteresis;
> +				xadc->temp_hysteresis;
>   		ret = _xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(offset + 4),
> -			xadc->threshold[offset + 4]);
> +					  xadc->threshold[offset + 4]);
>   		if (ret)
>   			goto out_unlock;
>   	}
> diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
> index b4d9d4683117..7830135a499f 100644
> --- a/drivers/iio/adc/xilinx-xadc.h
> +++ b/drivers/iio/adc/xilinx-xadc.h
> @@ -19,21 +19,16 @@ struct xadc_ops;
>   struct platform_device;
>   
>   void xadc_handle_events(struct iio_dev *indio_dev, unsigned long events);
> -
> -int xadc_read_event_config(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, enum iio_event_type type,
> -	enum iio_event_direction dir);
> -int xadc_write_event_config(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, enum iio_event_type type,
> -	enum iio_event_direction dir, bool state);
> -int xadc_read_event_value(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, enum iio_event_type type,
> -	enum iio_event_direction dir, enum iio_event_info info,
> -	int *val, int *val2);
> -int xadc_write_event_value(struct iio_dev *indio_dev,
> -	const struct iio_chan_spec *chan, enum iio_event_type type,
> -	enum iio_event_direction dir, enum iio_event_info info,
> -	int val, int val2);
> +int xadc_read_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +			   enum iio_event_type type, enum iio_event_direction dir);
> +int xadc_write_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +			    enum iio_event_type type, enum iio_event_direction dir, bool state);
> +int xadc_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +			  enum iio_event_type type, enum iio_event_direction dir,
> +			  enum iio_event_info info, int *val, int *val2);
> +int xadc_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
> +			   enum iio_event_type type, enum iio_event_direction dir,
> +			   enum iio_event_info info, int val, int val2);
>   
>   enum xadc_external_mux_mode {
>   	XADC_EXTERNAL_MUX_NONE,
> @@ -47,11 +42,11 @@ struct xadc {
>   
>   	const struct xadc_ops *ops;
>   
> -	uint16_t threshold[16];
> -	uint16_t temp_hysteresis;
> +	u16 threshold[16];
> +	u16 temp_hysteresis;
>   	unsigned int alarm_mask;
>   
> -	uint16_t *data;
> +	u16 *data;
>   
>   	struct iio_trigger *trigger;
>   	struct iio_trigger *convst_trigger;
> @@ -63,7 +58,9 @@ struct xadc {
>   	unsigned int zynq_intmask;
>   	struct delayed_work zynq_unmask_work;
>   
> +	/* Serializes register access and device configuration updates */
>   	struct mutex mutex;
> +	/* Protects interrupt state and FIFO operations */
>   	spinlock_t lock;
>   
>   	struct completion completion;
> @@ -75,10 +72,9 @@ enum xadc_type {
>   };
>   
>   struct xadc_ops {
> -	int (*read)(struct xadc *xadc, unsigned int reg, uint16_t *val);
> -	int (*write)(struct xadc *xadc, unsigned int reg, uint16_t val);
> -	int (*setup)(struct platform_device *pdev, struct iio_dev *indio_dev,
> -			int irq);
> +	int (*read)(struct xadc *xadc, unsigned int reg, u16 *val);
> +	int (*write)(struct xadc *xadc, unsigned int reg, u16 val);
> +	int (*setup)(struct platform_device *pdev, struct iio_dev *indio_dev, int irq);
>   	void (*update_alarm)(struct xadc *xadc, unsigned int alarm);
>   	unsigned long (*get_dclk_rate)(struct xadc *xadc);
>   	irqreturn_t (*interrupt_handler)(int irq, void *devid);
> @@ -89,22 +85,19 @@ struct xadc_ops {
>   	int temp_offset;
>   };
>   
> -static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
> -	uint16_t *val)
> +static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
>   {
>   	lockdep_assert_held(&xadc->mutex);
>   	return xadc->ops->read(xadc, reg, val);
>   }
>   
> -static inline int _xadc_write_adc_reg(struct xadc *xadc, unsigned int reg,
> -	uint16_t val)
> +static inline int _xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
>   {
>   	lockdep_assert_held(&xadc->mutex);
>   	return xadc->ops->write(xadc, reg, val);
>   }
>   
> -static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
> -	uint16_t *val)
> +static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
>   {
>   	int ret;
>   
> @@ -114,8 +107,7 @@ static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
>   	return ret;
>   }
>   
> -static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg,
> -	uint16_t val)
> +static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
>   {
>   	int ret;
>   
> @@ -168,22 +160,22 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg,
>   #define XADC_CONF0_MUX			BIT(11)
>   #define XADC_CONF0_CHAN(x)		(x)
>   
> -#define XADC_CONF1_SEQ_MASK		(0xf << 12)
> -#define XADC_CONF1_SEQ_DEFAULT		(0 << 12)
> -#define XADC_CONF1_SEQ_SINGLE_PASS	(1 << 12)
> -#define XADC_CONF1_SEQ_CONTINUOUS	(2 << 12)
> -#define XADC_CONF1_SEQ_SINGLE_CHANNEL	(3 << 12)
> -#define XADC_CONF1_SEQ_SIMULTANEOUS	(4 << 12)
> -#define XADC_CONF1_SEQ_INDEPENDENT	(8 << 12)
> -#define XADC_CONF1_ALARM_MASK		0x0f0f
> +#define XADC_CONF1_SEQ_MASK		GENMASK(15, 12)
> +#define XADC_CONF1_SEQ_DEFAULT		0
> +#define XADC_CONF1_SEQ_SINGLE_PASS	BIT(12)
> +#define XADC_CONF1_SEQ_CONTINUOUS	BIT(13)
> +#define XADC_CONF1_SEQ_SINGLE_CHANNEL	GENMASK(13, 12)
> +#define XADC_CONF1_SEQ_SIMULTANEOUS	BIT(14)
> +#define XADC_CONF1_SEQ_INDEPENDENT	BIT(15)
> +#define XADC_CONF1_ALARM_MASK		(GENMASK(11, 8) | GENMASK(3, 0))
>   
> -#define XADC_CONF2_DIV_MASK	0xff00
> +#define XADC_CONF2_DIV_MASK	GENMASK(15, 8)
>   #define XADC_CONF2_DIV_OFFSET	8
>   
> -#define XADC_CONF2_PD_MASK	(0x3 << 4)
> -#define XADC_CONF2_PD_NONE	(0x0 << 4)
> -#define XADC_CONF2_PD_ADC_B	(0x2 << 4)
> -#define XADC_CONF2_PD_BOTH	(0x3 << 4)
> +#define XADC_CONF2_PD_MASK	GENMASK(5, 4)
> +#define XADC_CONF2_PD_NONE	0
> +#define XADC_CONF2_PD_ADC_B	BIT(5)
> +#define XADC_CONF2_PD_BOTH	GENMASK(5, 4)
>   
>   #define XADC_ALARM_TEMP_MASK		BIT(0)
>   #define XADC_ALARM_VCCINT_MASK		BIT(1)

