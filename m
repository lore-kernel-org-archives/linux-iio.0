Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F73EDE48;
	Wed, 10 Jun 2026 12:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781093580; cv=fail; b=n6IfQRFCC7sYaexoRC0cdlLYC7K9ixzp9psTIYPvMbyef+ex9UTeuBpOoUVXe3W6mVKfIka9eNxzMs/Z3aE0waFHyGoXHjb01yVhyakbAVeOdahhPv5d/3sdR88Go1Omr13sFgS/gTwgq5+IcidAQxKJ5VETqJBxliEDPDFVfcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781093580; c=relaxed/simple;
	bh=T3J9a7iTgepqSa6YaJk6RilZDOcxhUCMgBTHlMm4Eks=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pLKGfP82NeADIxWgvTp2Xm6qghgiZ44VNFP7B782Gfud32eA0kji+A1CDJcYBfwygn3DoO7apJH7AxXBZu4vw+wjW1hVKd6OtOl9WdAsertF4L8blw/26DgQ+bcLNIhPqAQZnNTW/kVBgW8UpPtKhYAbnVChFcVUd7TySu0INzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sr5Znz9v; arc=fail smtp.client-ip=52.101.201.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sr5Znz9v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DhHXe7lNw7w5BmOcmnkfrH8Xdkr3hsQ57MVOrk8Xqwqo7bYqVtIWYuM4T9Z5mgkkhJwrgeGwCo22BtUupWF0940pU4uZoZKKrqhiKQCCiOYWsxNh0Msr3J6TN09k9Z3Vu5/0mkyEHtNZK/jvZdUyMOVLI33PHODGuUAwNQZ4RBny+X/whhH/z1mtmGVH8RibTTMvj7Z5ngUzrJffvlHNkXzwC/aK21EFOcwFmMK0XS7Fj/5Oj9WnvIsnwsLY5ymO4EP170lReeeMt0y19Q4yXwGx0EkrwbsQR7Ef4PYq/oDS7l2+r3UL4f0QTz5he6Nr9z6Vyl6xRzePrJFfylNQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8od+/gsoRDa58dZDprUbb4vsp8MTgA1/Dj/zqh78bYg=;
 b=EXzW9HVTSYBbjKsSF3M+ZRpDUKnzHGPpJd+3ULxnL779FXU9PzleHUqTubgf91Kx2Jw3pMtMN1493/FzNF7nqcHk/nRngxRvJXZ9rN4wEhsJ4qdM28uoDxOwSO9Zeku0WxfIzLSLIULPsP7Mk/Leul+z7+MmrA59R6rpQmN3GtmD2etdZlCaDFvXGmpsq7QAfvOahIq5WQBPfn4CY3AuyIHh8Zt5fLvjCalJ0G8/T1bx4rIwrlNigmmDppP/Q9HjJBO3uMYb8RmLepTSasItEK5tckkgZl3tc5m0gklBYI0cf1IxMHhBkK1655igbqmLZGIsvQF6n9zkcRmxJtNhEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8od+/gsoRDa58dZDprUbb4vsp8MTgA1/Dj/zqh78bYg=;
 b=sr5Znz9vIFAcpwaH1Nkd5uth1JjH8Vq+JaXYtmOeuoe+Pl2N8bYcrD6DbtVJMGog436Thh/CHiZplV4tr37UyKUTL07fYUavEXKi8vSZWm9k2BB64ebsdJstq4VelOh6+I0mie7ULREfADtkIz5uuha05OYdYjIAKRzeRmxjMSI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by DS7PR12MB8203.namprd12.prod.outlook.com (2603:10b6:8:e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Wed, 10 Jun
 2026 12:12:55 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 12:12:55 +0000
Message-ID: <04f2529f-d0e8-4288-936a-5cac6a5fc286@amd.com>
Date: Wed, 10 Jun 2026 13:12:52 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] iio: adc: versal-sysmon: add oversampling support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, andy@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, conall.ogriofa@amd.com, michal.simek@amd.com,
 linux@roeck-us.net, erimsalih@gmail.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260608183801.1257051-1-salih.erim@amd.com>
 <20260608183801.1257051-6-salih.erim@amd.com>
 <aihUJ9D7BAQd6iGZ@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <aihUJ9D7BAQd6iGZ@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0537.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:2c5::17) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|DS7PR12MB8203:EE_
X-MS-Office365-Filtering-Correlation-Id: 39934e64-5dd8-4f7e-1d76-08dec6e99a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|366016|1800799024|11063799006|4143699003|6133799003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	Q4bKuViC2pYNIlOo9vXZZqkTiZgwLrrzvcFfW1Rlws6JYlKds9olRstC1RaSpsJZSCIu7E7ZiOOA6CjTYb0hsr3dctkUduNf7EKYelXDRJG1IkeJSOTkeFDzAj7rzDpzZmehwD3S3gDpUChq95LAPNOQ9mm28QWXt40prz0G7net78zszHBLOXslzhndMw9UNWf0jmFYoTuJ7qOz5GSiF8SuLentf4K83NjRk3KOVm+3vosFIF2Gtf3b1fGCq1LCsYCHCTmLXl9V8hfzW3eUjowjE1UY8CplKgksjl0kA3AM6K2zbHEVaOaNu1m2Mk3Ljav81hwXwBxjTFS2fPE9zgrMw1BE8bu1CO9ayspUFeTGiznaHmSCNcnkuEhRopptio2Vz3IPUwiSjoDHcsPLRNa+VIGfOaHLyElO1372R2p5xz6ccELFAzVqsIkvMepdthHHvOn1WYtlrLA105ovLH3dTa/zk+JjKc5NNfeIiTztNTALdblHmHdHZUkV2/XN7+OA/zt9S+oLkBBTp3lXhB3YQGEhF3f+nFOPPdRBStRECzXxFSeCXRtenzwP2PoXK3YNaq2IwAmOjuIUggmGzVRH6OkkbuU8SO0e34Otjk60ed6XC2JZwQRre0U05ovqqnu/Oj8WRANOOZRIvy3+lglnxiOAJtWEdOI996hMgTPRdQFeFPBVB33QfhhMMf7z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(11063799006)(4143699003)(6133799003)(18002099003)(22082099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZlNwT01tVmtsd0JPQUp4RnhBQVlROHViZFJaeG1aS1cyZjkyVlRGaGl3aTk0?=
 =?utf-8?B?MlUrSEQ1QTY5M2loSXJYVU4xMnJaVm5JWmkyWlFTZHBWUHVjRlFaZDZ6Y0NC?=
 =?utf-8?B?M041dExwSDRPYW5lSW9CVk9uWjhQa0JsU3JZOUJkRnVTYXpwbHB2NHk3TGhu?=
 =?utf-8?B?SlhrRExBbVVJYzJ1eW5hS2NSRUpkVmlJS2tWZmEzQlo5U0VZMDlkdG5hZ2NW?=
 =?utf-8?B?Y1lGTHlraGtCMGNtdmE5WHhLMFZJUGxHVkRHOUZ3THlBNDBjdWVEdFlGaXJu?=
 =?utf-8?B?d3BmUGx1NEtzTDBNdnBtS29RTlorb2IvTHNxaWU2R3Q1cXYzd0g0NUVIb2sy?=
 =?utf-8?B?TzFuNGpMS0N2c3dGd1E3aldFVjI3UzhuYzQvc0ZNR1RPQmRnV3NuajJXSzBm?=
 =?utf-8?B?MFN3VmVNb0pZRDZTL2lTSzlzUWxEWEVac2ljYkJLUnA3U2g5ZVpPMTNCSHBn?=
 =?utf-8?B?YWdxcTNMNU9UdE9tZURZWTZpdXB5SWR4UDFMc1QxSmIvS0ZkeDM4b2pVRFpT?=
 =?utf-8?B?Q241M3RXQmI5MTJlcXZuY0I2TjM0S0IvMktkWC8vVVNCbkphalhNaC9mUXRL?=
 =?utf-8?B?SERKVTA0OHlKekdacjd0bkFROTBqOTBidktjVzB2d2RCS0E2OGpMTklVSFRF?=
 =?utf-8?B?dk1GYVVtRHlxQXJ6cTNuZFdObXBYQjdmTDBhMDFzUWE2UVZuM0RTMER6YW1l?=
 =?utf-8?B?YVd5NTRrL20rL3dPTHJWWWh6TmZUeVFIUFFqVUp1TTlpVmRmTUxtNXdPQzI5?=
 =?utf-8?B?OWdRMjhXUExsMFVsYm5XTmljYzM2dDV3eEdrZHZ5WHRjWHc0cDVwc2RZR0lm?=
 =?utf-8?B?RmI4QkFpNFR2cXo5cDBFRGp5WDdiclo3dUFhM3JHUkVTb3BjUzQzWGJBZTh2?=
 =?utf-8?B?RjNBRUJhTkRULzNZL3ZYOGNDUmxTKzRDcDdnVExPTXdSRE15YkIzcFI4eGpq?=
 =?utf-8?B?SHhiaGFhb1I1d0V1dnBrUHA4c2crR0xodHpTbHllaTVjUXdidEV0S2JNejRn?=
 =?utf-8?B?bE5tSCtoVG5jK3EwVGdMeUV4K0xtbTNMeHcwVXVEYXBLeldzNDN3dmxEZjN1?=
 =?utf-8?B?YzVXcllTWDZUVjl0NmM4N3Y5S2xId3hheXhPbWszVlZDeDBzaWVVYjh3ZnRB?=
 =?utf-8?B?RWRmd3BjUnJXejRDeDR3bHpWSzhaSDQxdHlIWU42ZUZqTGhMUUpGa3FIQi9M?=
 =?utf-8?B?L1RHRmNrRG5kWVk2Mk1ldG8vMGJkL3BHWUZIdWJGYnh1dFlQNVNvTjh3Yklq?=
 =?utf-8?B?TnF6UUV4UzVvaEgzeVh2MjdMUS9Gbm9xYlE5Qi84QzNQRnFFQjRpL0lvQkJM?=
 =?utf-8?B?dVFtRDJCRTBMWEJmZTBXSTYrbUR2WUFsUGZVNUx5bW5mMzQ1VkhxTDdjbU9L?=
 =?utf-8?B?cWsycUtmUVRRVVJBb0tsS0IvL0pSVGxRaUhoUGZjbmhUMVZ3dDlhOWI3ZS9O?=
 =?utf-8?B?bmY5S3Nyc3Facjd5RkdReWxqQ2VpVGZxR09nUTZXTkNJNGdzUy9FWmhmTkx5?=
 =?utf-8?B?Wnl3N0VieEUwaUo0K0VLMFhveFdkVEpRN2RLT1hZdjVaeXE3WDFYUmpMTDFr?=
 =?utf-8?B?ck1vQUpqSTM3alpheVdnL2lXQnZNS0VFOE5EeVdMN01XU0Rab1p6SFArOUpO?=
 =?utf-8?B?WGdNUkVJVWFGWjhaZVJsbVM0SHRBTkR0MkZmTnFlZXM2b01RWVlCQUJwbWJz?=
 =?utf-8?B?d3k3eEF6dUxXL2xqYmxZbmxZTW1EVVRlMmNlRTJ2U0lzUGo3K01EeWp6YXRW?=
 =?utf-8?B?clh6eXQ2dlpkczVUSFpsaEVibGxLNm1UaExMeFBsZUpmbE5zOWF6MzQ1NzRr?=
 =?utf-8?B?WW9MQ2c4cFZRME1zWDNxV0FoOWJjLzNqclBEaHUyd0VQeUVaSWR4ZWkxbU8y?=
 =?utf-8?B?aVdKd0JFT3VZOFNkM3pLNTZVbkxabkdmUFgzVXZpRDQ1ZnJXNjhaOWdJNmxR?=
 =?utf-8?B?dk15OWRFM1RFVDNFdDdYYm1KUzBwN1FHMGsyUVJubnZpSWxxaWRNOVN4d1J6?=
 =?utf-8?B?bW5LQnd5QzFaeVNvNDk3SGd1TWo2NXVDajBGYUU2dng1Z1hHdEpqTk1sWEZJ?=
 =?utf-8?B?MVgvM0ttY2pLV21tQWVLNVRuTVdVSGErU3ZUbTVnbUY0UGlzTy9Rdlc4Tkw5?=
 =?utf-8?B?cDNoQXhSUG8xS09HcWtxZFZPais5eG5CeU9nSDFhUFl4Z3lYanlyd2gxTXhq?=
 =?utf-8?B?VG4xYk1ZNi9NaUlqMTlaNjd1d3dTVE1SNVZ2L2s3TmxXdXJGTHgxUUJPbnYw?=
 =?utf-8?B?R2JFNDZLR1RGWHM2b0pJR1hVd1pFYTdIdFloMFQ5cDNRekE4dTdvNnJuSmxZ?=
 =?utf-8?Q?aSRrdBVvZjLQjhwF/E?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39934e64-5dd8-4f7e-1d76-08dec6e99a42
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 12:12:55.2973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1RG1gtERdjrGAf4kWbEjh0FlZ0xTLHe3iPJKXfAs6gkqM/VhjZB62IcuCr8lIa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8203

Hi Andy,

On 09/06/2026 18:57, Andy Shevchenko wrote:
> On Mon, Jun 08, 2026 at 07:38:01PM +0100, Salih Erim wrote:
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
>> +static int sysmon_osr_write(struct sysmon *sysmon, int channel_type, int val)
>> +{
>> +     /*
>> +      * HW register encoding is sample_count / 2:
>> +      * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
>> +      */
>> +     int hw_val = val >> 1;
>> +     unsigned int readback;
>> +     int ret;
>> +
>> +     switch (channel_type) {
>> +     case IIO_TEMP:
>> +             ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
>> +                                     SYSMON_CONFIG_TEMP_SAT_OSR,
>> +                                     FIELD_PREP(SYSMON_CONFIG_TEMP_SAT_OSR,
>> +                                                hw_val));
> 
> Broken indentation.

Accepted. Sorry for all.
> 
> 
>> +             if (ret)
>> +                     return ret;
>> +
>> +             /*
>> +              * Readback fence: the SysMon CONFIG register resides in the
>> +              * PMC domain behind the NoC. A posted write may not reach the
>> +              * hardware before the next MMIO access. Reading the register
>> +              * back forces the interconnect to complete the write, preventing
>> +              * a bus hang on the subsequent access.
>> +              */
>> +             regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
>> +
>> +             return sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
>> +                                          SYSMON_TEMP_EN_AVG_COUNT,
>> +                                          hw_val ? ~0U : 0);
>> +     case IIO_VOLTAGE:
>> +             ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
>> +                                     SYSMON_CONFIG_SUPPLY_OSR,
>> +                                     FIELD_PREP(SYSMON_CONFIG_SUPPLY_OSR,
>> +                                                hw_val));
> 
> Ditto.

Accepted.

> 
>> +             if (ret)
>> +                     return ret;
>> +
>> +             /* Readback fence -- see above */
>> +             regmap_read(sysmon->regmap, SYSMON_CONFIG, &readback);
>> +
>> +             return sysmon_set_avg_enable(sysmon, SYSMON_SUPPLY_EN_AVG_BASE,
>> +                                          SYSMON_SUPPLY_EN_AVG_COUNT,
>> +                                          hw_val ? ~0U : 0);
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +}
> 
> ...
> 
>> +static int sysmon_write_raw(struct iio_dev *indio_dev,
>> +                         struct iio_chan_spec const *chan,
>> +                         int val, int val2, long mask)
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     int i, ret;
> 
> Why is 'i' signed?

No reason. Will change to unsigned int.

Thanks,
Salih.

> 
>> +
>> +     if (mask != IIO_CHAN_INFO_OVERSAMPLING_RATIO)
>> +             return -EINVAL;
>> +
>> +     for (i = 0; i < ARRAY_SIZE(sysmon_oversampling_avail); i++) {
>> +             if (val == sysmon_oversampling_avail[i])
>> +                     break;
>> +     }
>> +     if (i == ARRAY_SIZE(sysmon_oversampling_avail))
>> +             return -EINVAL;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     ret = sysmon_osr_write(sysmon, chan->type, val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     if (chan->type == IIO_TEMP)
>> +             sysmon->temp_oversampling = val;
>> +     else
>> +             sysmon->supply_oversampling = val;
>> +
>> +     return 0;
>> +}
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

