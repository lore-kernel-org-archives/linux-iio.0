Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B5B379C23;
	Tue, 23 Jun 2026 11:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782214676; cv=fail; b=AeLAup5lSqLIt6YOo0K/AW21rSA68qycWyv3estQYIk4W7CenoNoaL5rkfs2kUR8Z/syQ5dwGzsKx3T6uwiTPiaA0l2QWZgICAe70zaMJVvGUPApQXWYx9uDfWOFLunkiYB3CVJR6gAo2jvuBoy4UOmuDm/K02Fq0WU/2tBTg9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782214676; c=relaxed/simple;
	bh=nV4xYJ6utwQNFJaSPlDJfv43AgJVnGV0YWT3MsLkTrs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y6A+fIs/7C161txEG3ZafHeiQ+9NnBGQIOOOMgMpK1j2Aw0tug+z+Iu+2rHUKoaI21+fnxQ3zhy6Bk5w0B0YegGMmGySufINBAFnGJbP7BMm6mRTnlJ5KV9h97G3UZLVGLs6CDHqn6hcR4oI5OzS8KCzjPqAn8hp9BP5BVfbblk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B8yWE4Zi; arc=fail smtp.client-ip=52.101.53.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B8yWE4Zi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiC9o5NGyepajKFjRx9Ut+fIga1ZhBewlfAPSWIJBDf5pdIpQAiXbJemJzFSAGYVk4mAutHBTQeRFMOe3OyttGsESZ1F2C6jDLISFMe5IsnvnX2mxU1edO/HeR3SwW39MroFxcJA6YMA+SUC/TOSorjtk9z/nPFYIpm6bhmYJ0JNXFkjSKf3KO77lf6eZUB8kFewhuAj43IWXeIxwJEvMQwEkEQUDuIAYgbVm50EYEjhiGsEXPucBMTTIkIoJBccHaKb4L/IXqdJhIQNFsSuTfUKnnl/PHDR/Den6gS9XFMN8JGkAhlVGCsP1a+MCJxLP03IsGqsw6q668QWemN8Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vHcHGqgk3C08tMTcZ3Zm9b4cOlUhbumZTrM+5g2H5xU=;
 b=u6vYPT+IWypsZ819pBRbBr04k6VJX1hkalseso9cEGGo+did5E60IHla/TCAe/P8EQl8p8oHBM5DLv8ypIirmqP9lFxTBeAzJNK4BWUeOxi8Ndf4L9ogwAymnVfVKo0DuY141dXHxfYOaHFO2pkRAXGBd0ENZuFRixfAXsT1Bet7MFc8xwVSO45Ixq5QyTiyBUwjbxR3ZHfM4GtTHP7p/NyuC50UOZLWDrCxYy0S8cNCLA5CDoi5KuCbr7HeV6OK0Fr2g3qwGq2X2KzRxf2NGnvEufSZes6KYgIkk1BmbFcgFNAD80PdZd7aFJ3jdfBw9J90/ibTYSigcU9MZtHHOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vHcHGqgk3C08tMTcZ3Zm9b4cOlUhbumZTrM+5g2H5xU=;
 b=B8yWE4ZiAHfgRT7ODmaWRGlqRz9yhSTklx5K87anr3Ow5gYa7Si4CDdFT6veGen6zflVSZfSGbv0MHmuoPgrLeRarMCVGbBdC85Q0Hgh2BFaj7DiQcfqnooAOXAdo81TI9MWlwB+fMLnF2zrzoVMBY6YW1O/ZEUGxkR1r1hC/jw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Tue, 23 Jun
 2026 11:37:50 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0139.018; Tue, 23 Jun 2026
 11:37:50 +0000
Message-ID: <5ce5f340-0f6b-4437-978b-527a0b13548d@amd.com>
Date: Tue, 23 Jun 2026 12:37:45 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 5/5] iio: adc: versal-sysmon: add oversampling support
To: jic23@kernel.org, andy@kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, conall.ogriofa@amd.com,
 michal.simek@amd.com, linux@roeck-us.net, erimsalih@gmail.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Shevchenko <andriy.shevchenko@intel.com>
References: <20260623014036.3865402-1-salih.erim@amd.com>
 <20260623014036.3865402-6-salih.erim@amd.com>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260623014036.3865402-6-salih.erim@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0235.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e9::6) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: f1fd217f-b684-4aaa-fcd0-08ded11bdb28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|376014|7416014|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lWQ+TeSff2LaE2uSBVKueGLGeOlYRr4UFpujhN/4NY1Mx57kqho6oCzF5Kh5Y0Eq6meXygyElxVxorZ/04RB8XY+TcyqyiYMPBVgI1obmTTcClHcIgId2N58j7ZKd8wD5BFC1FcGQRtIDqVDsdivkyvdDjmyIhMH0n1uvOdaL5LOd1Mo9nLLlCiMm2kIqp7Nn0sx81TyJqt7nL3dpFmkrHLQI1JqfC1McbKP1ZDalNJMhdnZQu3X7HDMh+C9kCfkIIJRPE1uyertwwJmAv2/TsIyQHqmO8XfjGitazMdDMIDuqrB9Rx1o3SF1QEc3xLF9eG56uspuvbqMeAR30ULH4WqnFSpP9tgPQbg8b7zvIrm+jPY/J+o+SpVSAzibrU/Wmiea2+yvyDnv5u9MjMpcliF6UHC+wzbgMNa8i0xfICZewoTf1cfb2B5oLBBavNvxuwJvP6WMiUNUKT8FuH0oppKe+8oVYEuLfewDmDd1yBP1YlRm1NhSMaYddyYNc/HVpmYb3KU4piTSqZPMmggO5vN8I2LEoUJraJHK53fTVMxsSR8u6LLh9I5Bno26owA83OXZbX63/JSmyALYcZBN+J+8HfR7H1JzvwgOAdA1uD11wlTpIOxneP5M7EHPDKd0fqUJSSqzbywSgx9cH8vtcWvcNO/0sN7/6QDvpBcPIo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(7416014)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWJwOEtLdXFiWHUyTCtMVzhURjlUSkorWTlSOXpiMXh0b01vRVBtbzNHVG80?=
 =?utf-8?B?dmRCMkgvRVlMOStZb2wvYUNBQXl1N1hWY2dHYVZaUVRXMUd2QjErVTY5TXlk?=
 =?utf-8?B?SytvWG5wczcvNHVRUzRrNXVnQjI2YU1OWVp6Si95QmdlZmUxVVRady95MWly?=
 =?utf-8?B?bFQ1bHZ1Q29NNUFsYWlPMUtOelFDYXRXaHFlU3ExendrUk1pdXQxSTN3cU92?=
 =?utf-8?B?OE5tVW5RM1Z4NjV5cEZHMzdlckM5NGNBR3NYd2g3Sk1zQmFtZXpDR2Z4RWtD?=
 =?utf-8?B?ZU1rRnVuejhpVUJzc092RXJqVExYbm1UVXhxS1VlN2w4V1VFYTNNTnFtKzNK?=
 =?utf-8?B?Z0RObEpCemQvQ29EYXo1Snc5UHJlcm1pTTI1dDNrdkFrdVNZeDh5UHoxRjRC?=
 =?utf-8?B?M3l1T2JXRkJxZitVKzNnc3NueVNTTFh2cTVxS1lWdHVOUzlzUm9tMzNOUmFw?=
 =?utf-8?B?V2xjSHBxQlRVeTIvc09GeHNleHpKSnZlZGVLcUp6TDJucGhDR2FoY2ZPalhy?=
 =?utf-8?B?cmxZQmlvNXdWMUdKK2hBanVjSXk3Mld6OUZkeVhsaHZtQ1RrVUZLMy9lUEl6?=
 =?utf-8?B?N2h3K05UQ01pQVdIYlRyTE00YjFtSWJiN2NqWG1vOXJ5ZEIvSnZWdHlWMEFN?=
 =?utf-8?B?WUU1OUhVcUNFUCtqSXlhVVBYRllTRmt1bXZZbkJ0RXZkeW1aZm9WcE56RVlI?=
 =?utf-8?B?czMybU83RjV0b2JJbHU1R3JFUWp1ZCtOZlZ3OVIwL0JMbGIxK3JhL1EyMjFm?=
 =?utf-8?B?MFUwdlJ5Yk5lZmNGeTJwRkhlL0o2K2liWHdUUXVRSmlCQzJ5bUpaWU9mUFR1?=
 =?utf-8?B?V3B1QVlpSnRWbkFrTno2eU5xSlByTlNjVEhJTGowdFJiUjRwcUZ2MUwyZWdU?=
 =?utf-8?B?U29RelNTYU9qZThnNWoydVJhaG56WnhHN0VCNHNhbDZwRUMwTURVY1B0bGc5?=
 =?utf-8?B?SlF1a3JGcVZORWxjdmMzZUVPeERHTVNFM0x4eFQrZXIrc1lvSzl0ZW5USy9B?=
 =?utf-8?B?MzIrMituS2p0VWhySDdLWUFSREtUcFRDZFUyMkdIa3N1MXJ0TkgyZWVTSFAw?=
 =?utf-8?B?dlhSSFBNOThHcVhSOGttYWJBZXZWZTFaNE55NlkraDlKaVBGSjR4eGhvdHJM?=
 =?utf-8?B?LzRzQkdUekQyaWdGWFVFT0o2VUh5N0NINytuNlIxVVVURDJ0VHA1R0ZpcFRq?=
 =?utf-8?B?RHhKS2Frb2MyMENJVDZsMkpYSXkwa2t6MWNXVEQvWk81ZEhObnZkLzJNeHlz?=
 =?utf-8?B?bnk0cVc3OHJXcUlsOUJBRm1aMTRvSDFMemduc2FOeU9BblVEczFhQ0k5UkZw?=
 =?utf-8?B?a1I5bktBS0d5eG5HY25ZWUw5ZjUxMDBBMTN5RjNMT3JPT1piRWpzVjZBQ0dZ?=
 =?utf-8?B?eEZ4UDlyQVZ2YmJkREVaeTMwRGpEc3BaK1U5YTBCalFoUXVIQjh6Nno5US9z?=
 =?utf-8?B?V0lUcW9pNk1FV1Z4K0hWNjVucHBldDhZQlJjRnlGcDdJUGVNdXNoa3FRdlMy?=
 =?utf-8?B?dTZ2alpiQ2VUa0RZOGdXUWlEaGNzeHArQWpEK2ZpeG5yR1h1Mi9nZWRqRHFP?=
 =?utf-8?B?NXNNZzd0UTR4bXBmbWlZS2tBZTVHL0VVRWNCdXp0S3o5ZTZrc1dJZFpzYnNW?=
 =?utf-8?B?bk1ZdUtsaUtHeGE5VUhVYUNWRTFqbExVRFJMZGg1N3lTRjBOK0NMZDR0L3kv?=
 =?utf-8?B?WFVzNmVzTG1YNVhaODlYcFNWMTlId1pUZXp2WEVkUVpjVGdEUURIR2RPN1Vk?=
 =?utf-8?B?SkdUemhMNkZNOE1ySWgzZVdibUdocVVFYTRwL2VZT0NVQnYyQTloTGNidHJ1?=
 =?utf-8?B?UGptck45SkRlLzY5TTNiNW9vWU1iQjZlMDVtejJ6NTIyNHE5YlB4SGtLNlRI?=
 =?utf-8?B?aURsbTJYVUlVc21UenVMWDhnZW9SOTJXVU85ekVWS1hrTUhjY1JuRDZQZ3BC?=
 =?utf-8?B?aVg5S2t2TGZRbUJ0RThGcnY4anJCalVmaGxsdXNTQkN6Tzc1Rk0xZFhPQWpM?=
 =?utf-8?B?NjBoak56eW9jT2VWZWsyU0R4R24reUlkaXZKZkd2eTFzeGdhelhEdEpvRDBp?=
 =?utf-8?B?M2w0ZUtqZ2NnRGxEQ21BK0hLSlpYOFpidEtjMGJnanl1NFVRQ0c0YlFkV2FX?=
 =?utf-8?B?cGVpWEg2UFkxTGFJcGE1azh0Q2JFbEF5QzhFUlVzRmI2bmxFbE5JSFcyeWN4?=
 =?utf-8?B?Q1IwNWJaNldoQkdFNEVMMHNQSzVtUDVEdUtwWnozdG9hczZ5VFRVQWNPOWVj?=
 =?utf-8?B?ckV4MGxYTS94MkR6bE5USVhpdE9nUTh5UnJxV0lmSlMzQTFPSDZCNXF6M2lI?=
 =?utf-8?Q?0Fn53TcoH5bHpCS906?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1fd217f-b684-4aaa-fcd0-08ded11bdb28
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 11:37:50.6414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HspbUNTbWdwfRqM3CWZLMAd+K0fT+YnJXwUrjRIwyv5EDzVJy9MHDdfTmWrgdJFK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321

Addressing Sashiko findings on this patch:

- [Medium] Missing hardware synchronization for oversampling
   ratio caches during initialization.

   The driver does not own the hardware state at probe time.
   Writing a default could interfere with bootloader (PLM)
   configuration. The cache initializes to 1 (no averaging),
   which matches the hardware reset default. Discussed and
   dismissed in v6 review.

Thanks,
Salih

On 23/06/2026 02:40, Salih Erim wrote:
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
> Changes in v11:
>    - Add oversampling info_mask bits to static SYSMON_CHAN_TEMP
>      macro (Jonathan)
> 
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
>   drivers/iio/adc/versal-sysmon-core.c | 159 ++++++++++++++++++++++++++-
>   drivers/iio/adc/versal-sysmon.h      |  17 +++
>   2 files changed, 174 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> index 8f2c502d9cb..1b55d343982 100644
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
> @@ -42,7 +48,11 @@
>   	.address = _address,					\
>   	.channel = _chan,					\
>   	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +	.info_mask_shared_by_type =				\
> +		BIT(IIO_CHAN_INFO_SCALE) |			\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
> +	.info_mask_shared_by_type_available =			\
> +		BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
>   	.datasheet_name = _name,				\
>   }
>   
> @@ -166,6 +176,12 @@ static int sysmon_read_raw(struct iio_dev *indio_dev,
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
> @@ -465,6 +481,132 @@ static int sysmon_write_event_value(struct iio_dev *indio_dev,
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
> @@ -477,6 +619,9 @@ static int sysmon_read_label(struct iio_dev *indio_dev,
>   
>   static const struct iio_info sysmon_iio_info = {
>   	.read_raw = sysmon_read_raw,
> +	.write_raw = sysmon_write_raw,
> +	.write_raw_get_fmt = sysmon_write_raw_get_fmt,
> +	.read_avail = sysmon_read_avail,
>   	.read_label = sysmon_read_label,
>   	.read_event_config = sysmon_read_event_config,
>   	.write_event_config = sysmon_write_event_config,
> @@ -768,6 +913,10 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
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
> @@ -799,7 +948,11 @@ static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev, int ir
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
> @@ -846,6 +999,8 @@ int devm_versal_sysmon_core_probe(struct device *dev, struct regmap *regmap)
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

