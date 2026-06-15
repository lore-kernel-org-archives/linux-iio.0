Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012054.outbound.protection.outlook.com [40.107.209.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812C94071EA;
	Mon, 15 Jun 2026 15:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538610; cv=fail; b=If4O0+ZoMe+6hhErTU2GSuOiE0S0e3LUQTuPfY45auHtaYms8oS7VCDKMqlbWNzStFytYntDRmQbWQc8QcvNJ0XsUSQXSsyTCJWJGXjaYdDTF9KWBVEUI+Jp0PNtuDmaBOdlPYrMmxd3Nq1luVaVfUOmb5ZCqX6Ya4GvZE+COuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538610; c=relaxed/simple;
	bh=uDzEUbqgKLyIa2snU4trDjKeDDPZ8lxNY7Dba7gU0ZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=shIEFtTq3fYTch+DTlcpO+xE3nKLzDNEcRU8ILKCFN1CYQICXPqN1SJrgBo9KZvx6dOWAdVy2c+NZwcmyDxeX8xhqacut9AMJPMuAk1sGJOXZih9LHDvKZe1Ibz3+9kWkm3RTrx6fO3ln10Q9JmiF9UgS3Qp57JzlTQ81OvI578=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tj/fqrZs; arc=fail smtp.client-ip=40.107.209.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tj/fqrZs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4sbzxggyl+Kz5Ad/cOjpPnwu/LlCr22hfJcnG0z+f1ZbRD+vqlDXTAYXKZFURbV7668MMbYyD9kDO3uy4rZWyQB8o7Qsv/nwDLk2dxKBRJzjd9VsVdKotw59+zkjcVT2Hc3+nZEoz0wO6K89RxlmFmsA2Lxisuvq+OgDr6w9oSWhcMsup+5QwqX9fa2HZF0rOYMbbM4gHo9QqmajHwxrfqdnbumPAjJhgmOc6FoDrfGahjbKJrWOIfusjMxfHu6wZcCCPvEku4RlPZf6FqzD7cnKa8tOdIJgTwhoDDpQwfKGqw/dAJimFou10tob/8gyd+m18T96BzMpXpw6bmfAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WPRhLpr8yH2ge1lvgU1hek4qRmQFfCP52FQ+ntXMYs0=;
 b=I7A2uRPjG8fAXXYAtkgpsxDyDIHB599sXhZu3K0aZcZjafAULeL76evT2NCRS9FyNP/r5QmYpgRQKc4aXFACegHTf9BQMTB1EQBXIWK8gx/AobyZutaZU6Wct8ejcIjW1jMqGjlsgvfATNQy15448wH06u4LNLi0FybYnOLS2LFxgNOJ91Qv7reUkFeJkxsnF0eQ8/VRHApRh/7zy7JW5o2Z9rlEpN0AqfF894KbHrkfvEtnOYSHgSKHmji2m1gaMJCPbm62DIwWgN3qyeFkSS0j/bJYFBJSzlxCLspc1S3la60iH4uN5xdibdk5c303HE3vAMoRdEmD+ciCiKDESw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WPRhLpr8yH2ge1lvgU1hek4qRmQFfCP52FQ+ntXMYs0=;
 b=tj/fqrZsxjmWhzcZR/BTyM8O12qGISUKRfyL/L5i9en1HVJFcz21+4NmV6tKHIC0bpX0OzqgTlFB01aXRRGZ3p2UeynKkuOrjK5sQgh75Gc1o1tpydjRRiSFtP5mkBCKatJ0lTCoFQR2iusrkvEDNJbC7kdWvf1OLPJPYV0hfs4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by BL4PR12MB9721.namprd12.prod.outlook.com (2603:10b6:208:4ed::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 15:50:06 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 15:50:06 +0000
Message-ID: <1c00fb53-b72e-4d19-bc4e-4f68e6cd7305@amd.com>
Date: Mon, 15 Jun 2026 16:50:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 5/5] iio: adc: versal-sysmon: add oversampling support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260614233722.2603459-1-salih.erim@amd.com>
 <20260614233722.2603459-6-salih.erim@amd.com>
 <ajAL__3jUtSgSb7r@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <ajAL__3jUtSgSb7r@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0307.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::15) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|BL4PR12MB9721:EE_
X-MS-Office365-Filtering-Correlation-Id: a7d52f8d-d2f9-49ec-371f-08decaf5c5b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|18002099003|22082099003|11063799006|4143699003|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	gJsMODLFeOaW40igB55LMWeD/0dcdCt7xgCEiJJzaOYaTfsReaDbujxaJXNte3D7imLU3ONG+B7vl+Ni/rqP9iA0yn5uRwXiESSExC5dFm0qR0hBIVnYloe4JHWdcuG+mjMA2ZaNQBesdb2gL/MtqjZ9nbfJYgiBARllxDJFeFiUa1ZZ3w8w60P6XvzmAiW17i2VEY2w4hPq5yPQI1/yIkFgCHprK1ch+e/Rqu8G3jeZk8tcIcp5LOtN+mEluTMz18S9+VcepBqqj9CS9Ba3ODxEAybAGTZNiu4ahE1IpNs6Mvnqh4XPTWquSbsu92XfX8RdcoGnRtFTNMTqKubneCH6Z/5dX8ujL9QMZBqjkV78u+EaSR5P32XLQBzM70KzPGZil2pF6knSD3UISCgEpucIUSI7kIstoigYGeeU6azgZpvH66IEzW0sSyrg9znBsTAOAfryMqU+rr1QwNUNHIGGoOw1vsdA1rtV4Xcu9O74SSWB/N0MKVEwfiHq4v1h/o9fjHMRHZrm3wSFk+vkcBjRVTwJiPzoNbEYBlHtKCjWpTNANTnYZg3VVhGF0zyNR1Wog/BDkV624LaS1SAJTLYNgxRSuCUG30bAlj5KGTxIYrQKqqb/Mo3MycfRhYE8OwryODMmEdBklNIiq6RxggW+O7BqEcLO8rXIkBfTf0U1Czyk/sz5tQi3iRSh5mwp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(18002099003)(22082099003)(11063799006)(4143699003)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YTEzK1VQSXlsaFhwZE16WU9UWStPSlFqcVJWRW9sdFdlRkJuSFQxaGIrSnBY?=
 =?utf-8?B?ekFTekRkaEl3TlY5Ti8xZFJCdis3bit0Y2JLa0REajdKOVo0NjlnemVvcG1F?=
 =?utf-8?B?QXVzU2JJdU04bXRVYmdaV0hWRFNQSVFscjdQNi9yL2tSYjRKYnZ4ZW5GY3JL?=
 =?utf-8?B?MVNRY3hDRkt6aVp1OW1BeUlBeERZTUh2KzBuYUhqdFMySDYvNkpweFd6eGxE?=
 =?utf-8?B?ZEo0MzZQSWdUQkFoZWRLQkZGQ2dpdUtvdGkwaWZzZDkzMEdET2ZjZVJVdjE1?=
 =?utf-8?B?OTBWdEcvRmV4T1J3MzhlMWtFY3dpOXpMY0M4a29TT3NLSTZxM3FlQ1IzMjR0?=
 =?utf-8?B?MjZJZnNKcmNOMitjTWV5eVhpUG1YQ3c1QXRpU0J0Njg3QVZZZ1NFelBFbk9L?=
 =?utf-8?B?THM2cFQ1WUdhUGdUeVYxL1JsWS90UGhmMytYeGNWaWhNUEo3OTlneldrSW5J?=
 =?utf-8?B?eEtNazhDNUcydVdnaGVuYlByRmtnbUFTT2ltSmRKQTUzUklMVnEzZkN3Zm9I?=
 =?utf-8?B?MnRmWXE5K3NyY3ZFZXFqSG9nVGt6WitsdGtCQjF5cVlJTFZaSTBaVmYzaGp1?=
 =?utf-8?B?eENpUHBtbW5ZTUttbk0vR0Q4ZVNvMmR2cFM0anJlczBNOCszU2ExZEhXMThO?=
 =?utf-8?B?amppU01vS2d5SkZ0N280UnlxMThxQzVjOGliZFp3OUNETUxxVE5WdmNIcXhB?=
 =?utf-8?B?QWgzUGg3UXVyZ2w2YU5oNzZYSFVYVm9HbG9ZUldSNFFzdTl3Mm1OeWZ1aFdP?=
 =?utf-8?B?RDIxNlE1TS9wa21mMVZ4L2lBQ0hvNjNtTEhINm04c2N2YUMvUTRiWjJvSkdC?=
 =?utf-8?B?UDNxQjBOM2VCcDcxb0NVK3h2Q2o5TE9ndkI5cTVrM2hBNmlWUE5vS21VVkIw?=
 =?utf-8?B?ZXdxaHEvd3BNMGg2eHZWeFlnTXc3d0cwQytvZUJNWkZhdURXWmtZRXpiQ2dm?=
 =?utf-8?B?Q0k4SlV2VXVjQVB3c2NtVHQ0OXEycm9ua3BaaGFJQ1B0M1N3NmxSNHRwQks3?=
 =?utf-8?B?MzJQbzI3YTdmd3FzTkYvSjlUWjlqZUZZVjhXRUNaRjgreXRMSWxHWVJtd1dk?=
 =?utf-8?B?YVdKR2xyQk5ZVTU2N2pnbllQdWtpMVQ0SllzaTRWZEFmN281Ym9TZXBQREpw?=
 =?utf-8?B?OU1hVW93ZDBlWUpYb2g5OGlsa0FLQVdJR2R0MUdueUJzMUZRa3pQc2N6MVY1?=
 =?utf-8?B?RlJKcWNyaVcrMm56TFV3N3dKSjE4YUthQm5ZNlVaV2FLdmpHMlNOS1VUUU45?=
 =?utf-8?B?bWtLdHZMeDRjVEo2azlGTXdLRUROSmwzL2Y4TVkvU0tlVnNQOEU5UFlhUUVN?=
 =?utf-8?B?ZWRwWmJCQ0FLSlAzU0dJMmRLTlUxaWdybTFvRzJDenBIQjdzc1VJSnkwU0E0?=
 =?utf-8?B?dW1uTXgrWmFJdkxDTU90R25yckt5SXZLekVBbVZpOXJFK2hxSEc3YjdvTFBj?=
 =?utf-8?B?NGo4dzZQOUE2dHcrKzkwUW1qaEM1TE1YQkF6SDBjbXYrQzZJZzd0anBwWUR1?=
 =?utf-8?B?aGt3ZU9rck4rdUY0L3B0enpUWUZHcEl4dkI5bndLK2pSZkZ0bXh2YW1RWWw3?=
 =?utf-8?B?elRvVUgxUGk4QmpKNjNyVzkxbkZ5UDZvblZibXY3cDNad1lGb1ZKaVpYeVVj?=
 =?utf-8?B?Wm45ZnRncjMrQldQTkd2SmFDelZhR3lkZ3R0K0pVa0k5YUd2Z0tVSGU2TnZt?=
 =?utf-8?B?U3k5YmV6UjV2ZElPZDhHcVlCeFQ5NEQ3MnZHR2VyR0tmdEdBYWJTYWdDY1ZH?=
 =?utf-8?B?UE45cHdhaDlGcG93SmFsc0oveWlkL1JubHpsZXFQR2cyQUxzVkpEOU8vT0hl?=
 =?utf-8?B?Z1YxN2ROU28zL2NTQlZpaFdCcGNqblc3YmhIYm1CYnlObFE3ekJLYlhrT3VY?=
 =?utf-8?B?dzgxQmV6TWVQK3p1eFJWaHhwNTZoUmdQcjlQampHVHc2UGtjTGZxSnV2Ujlx?=
 =?utf-8?B?SXZBV29CeFRJZzRqMVZEMWgrcGo0WTd6eC8wNnYxakt1dVZvdUsrUWx2V2lR?=
 =?utf-8?B?QmpTM2tIVHhhTit1cVVXUXBaVFNyWjMzWG1SUVBsWWtGenBpVGlTS1NYOXlr?=
 =?utf-8?B?WEZLdzQzQUJyK3BTMmJEanVsM2dWQVBNQjBraUhrRDQyNjBPOHZ2NXJMVGU2?=
 =?utf-8?B?TDlKTkl4c0lUU0tVZ3BHQmV0WGJnWDk3Zm9RVGFxWXlKMHNBL1FjM3dNbm1M?=
 =?utf-8?B?NFVsMk9tS1FVMXoxdGFiTExnUDQ3b0t4eWF1SzlZbmZWNHk4enc0aGpkK01K?=
 =?utf-8?B?RC8wZldlQUNDK2U4dkk5K09sUHkzRHJ5WEk3Y1Z3SVo5cnc2NnRvbG9wbzJS?=
 =?utf-8?Q?TJHvAhtomzqjfT2cEb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7d52f8d-d2f9-49ec-371f-08decaf5c5b6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 15:50:06.7957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Wy8NYU+ZWGN/JanPdUXyGUIkC2NWnJaoAiv5M8U8OcnHEW8woEjzQX8JFssIcoPO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9721

Hi Andy,

Thanks for the review, replies inline.

On 15/06/2026 15:28, Andy Shevchenko wrote:
> On Mon, Jun 15, 2026 at 12:37:22AM +0100, Salih Erim wrote:
>> Add support for reading and writing the oversampling ratio through
>> the IIO oversampling_ratio attribute. The hardware supports averaging
>> 2, 4, 8, or 16 samples, plus a ratio of 1 (no averaging).
>>
>> Temperature and supply channels share oversampling configuration at
>> the type level (all temperature channels share one ratio, all supply
>> channels share another), exposed through info_mask_shared_by_type.
>>
>> The hardware encoding uses sample_count / 2 in a 4-bit field within
>> the CONFIG register. Per-channel averaging enable registers must also
>> be updated to activate or deactivate averaging.
> 
> ...
> 
>> +static int sysmon_osr_write_temp(struct sysmon *sysmon, int val)
>> +{
>> +     /*
>> +      * HW register encoding is sample_count / 2:
>> +      * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
>> +      */
>> +     int hw_val = val >> 1;
> 
> If, for some reason, val happens to be a small negative number, here might be
> a surprising behaviour.

The caller validates val against the oversampling_avail list
{1, 2, 4, 8, 16} before calling, so negatives never reach here.
But the parameter should be unsigned int to make that obvious.
Will change in v8.

> 
>> +     unsigned int readback;
>> +     int ret;
>> +
>> +     ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
>> +                             SYSMON_CONFIG_TEMP_SAT_OSR,
>> +                             FIELD_PREP(SYSMON_CONFIG_TEMP_SAT_OSR, hw_val));
>> +     if (ret)
>> +             return ret;
>> +
>> +     /*
>> +      * Readback fence: the SysMon CONFIG register resides in the
>> +      * PMC domain behind the NoC. A posted write may not reach the
>> +      * hardware before the next MMIO access. Reading the register
>> +      * back forces the interconnect to complete the write, preventing
>> +      * a bus hang on the subsequent access.
>> +      */
>> +     regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
>> +
>> +     return sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
>> +                                  SYSMON_TEMP_EN_AVG_COUNT,
>> +                                  hw_val ? ~0U : 0);
> 
> Is the last parameter > 32-bit? If not, drop 'U' as it might have a nice
> side-effect in case this become actually > 32-bit. Same for other cases.
> In other words, using ~0U should be quite cautious.

Will change to ~0. Same for both call sites.

Thanks,
Salih

> 
>> +}
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

