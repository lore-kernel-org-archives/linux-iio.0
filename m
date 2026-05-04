Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010024.outbound.protection.outlook.com [40.93.198.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801483914EB;
	Mon,  4 May 2026 15:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777909819; cv=fail; b=PqnafpPm9vPUs5M8S0FglnO5E0wZW44bLh9/QGCzxwy6ENTbZeDjYFQ6zd3K/6CNC55eJvRwtpyELYIbnlRG+2MrFLrHb0GqCifT4ztmnu8Spdhuykbs/JSbFzNWnIX3eNH4o1VdU7bDluQkgdMxCowiXG0KRfl8jcCcvyXhj6E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777909819; c=relaxed/simple;
	bh=yFZhqWEj/EGOZkg//8m6LARkuSrOHBle1Ur/Zq69jDQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=B3eV6GDIFhPgM13D5IckyjC+sjQmE8ETHStAXNCwrhU9SHte/NyieWz4e8n+vbZi5MD5J+PBnKxbOudnWNQJe91aF2CwV1rQmC0/yNn7NZ7jsW1onVzmRrGsD/hTlKM+Kyg/T/f/g6Xub7sqV3+H15yvI64LTv4LH2R88pTXuiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BRaRL40f; arc=fail smtp.client-ip=40.93.198.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BRaRL40f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y81QlpDqhRVQHjb7zY5c5BjfRyve9WRzW3isblkgLBppNJZhv9TT1xP8062wsTI717h5SdUfOioi4amrgFZBcJ1qC3NnWnG/HmrXW0lAaugGFcc5YDnyu0D6ymFJAzcU2ZwM9QwUQlFTGEYT567jgfecvwDXURSyV9RnqafLNWvZPvhYhmyWFTtgYxHwlnRTPkOlG+MrHXbBNUGlTaPeM4ptsn+Z0l+LAWBYW5jk0JhqBRAtmuiISpsdbPTWDwzqslXnIR/HSv1lwMSLrd79/TfVbttqRwZW35DSsQ2fD+arGHI5JyYhJE2MZ0cVck/b3gw9Qwh27qUnHAjI2gwiZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5xlSWVPo+tUAA6QlPuLZdFF0E93XFZaG5qXIxuhHVTw=;
 b=SgILgT8kcPDbN0j8JkUaotZssroOBGFA+8DKAd423/MDwJjclLnbh1H41fuHziBWKrWBmyoYwdafQncB4A1TWmDxtYzV9pzWu1jfQeu1qJXbxgeeRF1M65kG07ANHCjQAoz4sBIYlbzVKY4WcBowoNIRTqOxaJnQnrByHGrHxIlZdKL8Nh6Wl5oAeW4Ma27y90t24YHE/VhLj8G09Cs1ufFk7JkwYSYiZi4Q3MXiHZCz/xbrlpY3mg4xdE0oMy5w8LD0CYJ6Damdlh/ZhnohW86G6OENcz1l0vPHim3WTmgVC+xk8+IMfe5QG3RVDSVrOjs07lUOQ0d9dNXOMC+1Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5xlSWVPo+tUAA6QlPuLZdFF0E93XFZaG5qXIxuhHVTw=;
 b=BRaRL40fq0iuktT8kPZpvdB2ONWwBq+4R28XGYMJldKZQKJ2tD2zuG1toAwfnzu4i1txwC4b3XiSL6fVhxaDDmPK7kmAngeMMvXenpmZNX90xiaJC70+QrnxQvFKLtzJWLGrTaXTNRb2KTiOYgfBGPCAniaTBoSHEr5IyaVsSAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by SJ0PR12MB8138.namprd12.prod.outlook.com (2603:10b6:a03:4e0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 15:50:10 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 15:50:10 +0000
Message-ID: <8d0ed33d-deab-4aa3-a7bf-3aaf84f4583f@amd.com>
Date: Mon, 4 May 2026 16:50:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] iio: adc: add Versal SysMon driver
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, git@amd.com, nuno.sa@analog.com, andy@kernel.org,
 dlechner@baylibre.com, michal.simek@amd.com, conall.ogriofa@amd.com,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-3-salih.erim@amd.com>
 <afhyiW_5embow_hx@ashevche-desk.local>
Content-Language: en-US
From: Salih Erim <salih.erim@amd.com>
In-Reply-To: <afhyiW_5embow_hx@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0055.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::6) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|SJ0PR12MB8138:EE_
X-MS-Office365-Filtering-Correlation-Id: f9889b01-aea8-4ab4-6a72-08dea9f4d2ad
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	P6VzZo3s6s23fYaSsY6vdd50pVOsavftwcmX2TBbcKmLnQlWbTXsjsxzX6w1Tgz6Tu8wSdYDJbgKiHnMuwhzoHaR3OWwJkzqg+o2dLFV2/OVSZxWQTaBQr7BBZTqFBBJ6aCY3BJ6J4TBxNfJUn2Ss+sWEKIFmrrn+lRQn4r5+I+iMdGhAP3fWd6k8JBP66TL4BtSikyuQ8GdTUB805MDyB1jOtY41BYMIfcWGWLyZ4BwZUggzaYxvsrSoQdLocaL5UxW5lvHBube+IpH03Phd2zZuFIxN7N08AdrSCBYNOfdiAWyo8257LYF9vF/6+z/hC7fWFBjtDMXovDyfqdweBmzNQmczPJJXgAU7Gu+tTIAEOKFedD74jJ06q1JR9ZQ/jTDKfVFO6gTFrIjnPhTMiFWpOmc/nyc5ehzRorlZDwWHx9cbYu1Etee7cXfGs/+vBtPB7lREQYZkj70xOr/1VOn5QBre4naUfF9kBpNp8LOnwYeTx0UbQFDyWhMWGTJVm4r3gt05ruNtDWZskXsXl8dkevJpD0YKMND2tvxF9GJnjP79zKQio40GmEiODEIZg1EMJBM0OoDRqx2yagdEw7cDve4J2r3YcFdKlDIhmMUOum7gBZrm7/6X0RuUYIm7vLmFd+PkZsAbTsV3Yp9xldSgEBFs3DVYp+3NFRk191sUGUNweBwWxl7sEZ1F0Fe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek9nOHNLUjlmYVJZaExSSmFPTnVhS3VDRDhUK2xZWitXaTc5NmJ2VWtpUyty?=
 =?utf-8?B?TjdmTDRxajBITURNbHd6TzYwWWc0MSswZ1dCZ0ZLZFB6cEV2TVowS21oNWtQ?=
 =?utf-8?B?RjRpSWtoM1pNRDNsdTB5WmljMVJzdW5XN1k3dTZ3TDhBd0NKVllseFp4M2p2?=
 =?utf-8?B?SHpwZDFNelVITU8xNERtaHhRM3BuRDNMZnJjc3N5c2E5REI5bEwzN21XaHM2?=
 =?utf-8?B?N0lsWUVVa3MvLytZZy9WTGpOOWVvUTF2dFBmOFRpaTI1NUM5U09aSjl3Y21j?=
 =?utf-8?B?Y0RPZHIrOHdsREluMkk2REJJdUtsRkNUSWRMcmpuRVRQczhFMmdrMG5UN0li?=
 =?utf-8?B?MkhtU1M0UHZuZTNCalRUSCtkcnJwUnBJSUx0SlNsTTlQSDBUT0swS3NQNHJC?=
 =?utf-8?B?UGtXMDA1NDlHYVpyV2dOSlEvS1kwSjlobDBydzFsWGxsT3pnWEdPUVp2Wk5v?=
 =?utf-8?B?VGM0emZHanJiaXAyR01rVW1KbndkTnNpRi9ZT1BZdlRVK3N4Qjk2TnlJanRD?=
 =?utf-8?B?ais2OUxIL2F6SFBPdkhPSityaExpdSsvaE01cGwvSlB5aWJKeGV4WVZDUmRM?=
 =?utf-8?B?Q2pCUDlRWXREZkpYUk5HUzlCUHpCT1NuWW9YNmZZNjVMUjhlT296Rk1HTkZh?=
 =?utf-8?B?bW1qTFNmQzdqN1c5Y3B1VUYyMnVORjBEUmpEMmZBREtHYzhmZUtCbnptRW9P?=
 =?utf-8?B?NHBDd1VFK0V1TmpTNHJTK2twa21ObysyWENHaHUybndYb2laTXN4cUcxSDRQ?=
 =?utf-8?B?aC9jQWNuaFNLRlBCM0IxcjZZNGxpeHc2T1U5Nm1tTzRIbnl1Sk1yRUdGTjhM?=
 =?utf-8?B?anhxSlQxbzNHSUxRVFhaTE9scDhUYXRxeVpMVGpFYU1aaUZ2RDNwNEZzb09T?=
 =?utf-8?B?aVlBTTUxNmM4TGtVaXZ1QVhuYlltdDlGc3RyY1hTbDJXNXlndjVrMnJ6Sm1v?=
 =?utf-8?B?Zk15ZjNQS1hnUTZPU0E4Yzh0dEVpSldSQjZ2T3BObEJKVGRLMHlXWVVDMWVl?=
 =?utf-8?B?eTRXams1bzJRZlJkZXN0elBrU3Zia3VRSFZZU3dTNUMvUGVBcEp3NkxnL05X?=
 =?utf-8?B?UHJwV2x6QnZsMDBaRXhZL2FCeUVzV0dmOFBIWTc0V0NaNGtKcDluZVptbXo3?=
 =?utf-8?B?TEFzSFRLcURhUXFQeU5EckplNW0zak9HMEdBbXQwYlBXYzRURXlsMiszbEJs?=
 =?utf-8?B?TEhCejBGSWU4YjVCMDVDRmJIdFozckt3aWJkQXI5SnkvaXpYclRvMG1JamU0?=
 =?utf-8?B?T1NyTnl6ZjM0OWZUeGFOcjVmZUZScm4xUFpEeEM4R3lyYzZIMS85SnRpZ3Q0?=
 =?utf-8?B?S25pVEZvakJ1bFpWWnl0Z1hyaXBRbUo0L0pqOVdJZFdvK0lRVSs3WmYxcGRQ?=
 =?utf-8?B?NituSE5KOFJBRTg3RUNEUU0wTmdrbU53ak1tZThLRW8vOVVtT3ErSzJpMUNi?=
 =?utf-8?B?TTVMUnZ6L0NkTWwvYXAyNnN4T0RDUndFR0xNU3RtUUNvOFdGMUp3cWdEcGdJ?=
 =?utf-8?B?QjdiR2VBR2FUYlVLUEVmZmZoaUlIMDV1SjB4SzUwMFJHL2w0MDBQSWV2bjN5?=
 =?utf-8?B?WDE3dk5ja2xJS3N2cllBYzl5NkFuazVmb2FMdzdrN1JKeG45ZUw5cnMvdGhL?=
 =?utf-8?B?cUxJME9ydDlLSjNCRjYwbFhLekNBVEQxbmpGOTU1Rm1SSTlaWlNCZnNJdVZ3?=
 =?utf-8?B?bCt3VmJmemRVZndZUFErcWI2MmxDa3BoaFhVRHVwY21FYnNCcW9GK3JiYTh5?=
 =?utf-8?B?ZHJiTEg3YTlkUC9neCtjRkFsWXB0VVZhSDF2SFo4ZjAyVXNIc2c0aXMyUlV5?=
 =?utf-8?B?K1g4QitHeDFmYlU3OUkxZlZCYXEvQnErVFlkNC9TVlVNRjBhaVZpcnV4T1BT?=
 =?utf-8?B?NGROOTF2MGxsMGpUQVhRQmNVVEFoelRBT0V2UG5CNFRJbkdDdzMrRWl2NFJt?=
 =?utf-8?B?d0ZxZ01STUdXN2NKcEpnd1hrajdqOVpFamg0NExKVncvYTdsV2Z0VnFIb1No?=
 =?utf-8?B?R2tXVUNOVk03SGVWMklZUG50RTJyMWRzZnh4SHdtMUw4bitQaWM1TTNKbXhj?=
 =?utf-8?B?SGhUZmZJUHFFTmNzcm9NVlBoT1RJZDgxU0xUeFMzVVZRUDlYN2dycEpsNTVj?=
 =?utf-8?B?V3VqRWI3djNYZEZsdFNkcXBNbUhjekdsZ1ZLYTVIa0llNklNUlhEbGRFWk9M?=
 =?utf-8?B?dnV3eVllRVpnYitsTkVBaWNNYjRxUUJmdWdSWk9DNzY5TEJiZ3VUVmgvYzJR?=
 =?utf-8?B?UEl0Vjg1TDY0enZYNEZ0SWxNNDF5Tm5jdFV6aVV3RTE5QU1ERUVaaGwwTEFD?=
 =?utf-8?Q?VK02IuyR4Xj++nDmFt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9889b01-aea8-4ab4-6a72-08dea9f4d2ad
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 15:50:10.6953
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: brdg1nvYIHXJn9kqXigsZFQohw6CyYR1IvjWaz7OGHyD9uVGTkLkeR9RGY7TQN01
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB8138

Hi Andy,

Thanks for the review, replies inline.

On 5/4/2026 11:18 AM, Andy Shevchenko wrote:
> On Sat, May 02, 2026 at 12:19:48PM +0100, Salih Erim wrote:
>> Add the AMD/Xilinx Versal System Monitor (SysMon) IIO driver.
>>
>> The driver is split into a bus-agnostic core module
>> (versal-sysmon-core) and a memory-mapped I/O platform driver
>> (versal-sysmon). The core uses the regmap API so that different
>> bus implementations can share the same IIO logic.
>>
>> The core provides:
>>    - Static temperature channels (current max/min, peak max/min)
>>    - Supply voltage channels parsed from DT container nodes
>>    - Temperature satellite channels parsed from DT container nodes
>>    - read_raw for IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_PROCESSED
>>    - read_label using the DT label property
>>
>> The MMIO platform driver provides:
>>    - Memory-mapped register access via custom regmap callbacks
>>    - NPI unlock before every register write (platform management
>>      controller may re-lock NPI unpredictably on Versal devices)
>>
>> Threshold events, oversampling, and I2C bus support are added in
>> subsequent patches.
> 
> ...
> 
> IWYU please:
> 
> + array_size.h
> 
>> +#include <linux/bitfield.h>
>> +#include <linux/bits.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/module.h>
>> +#include <linux/property.h>
>> +#include <linux/regmap.h>
> 
> + string.h
> + types.h
> 
> (and maybe more that I missed).

Accepted. Will audit all three files (core, MMIO, header) for IWYU
and add missing includes.

> 
> 
> ...
> 
>> +#define SYSMON_CHAN_TEMP(_chan, _address, _ext) {            \
>> +     .type = IIO_TEMP,                                       \
>> +     .indexed = 1,                                           \
>> +     .address = _address,                                    \
>> +     .channel = _chan,                                       \
> 
>> +     .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |          \
>> +             BIT(IIO_CHAN_INFO_PROCESSED),                   \
> 
> It's better to use the following style:
> 
>          .info_mask_separate =                                   \
>                  BIT(IIO_CHAN_INFO_RAW) |                        \
>                  BIT(IIO_CHAN_INFO_PROCESSED),                   \

Accepted.

> 
> 
>> +     .scan_type = {                                          \
>> +             .sign = 's',                                    \
>> +             .realbits = 15,                                 \
>> +             .storagebits = 16,                              \
>> +             .endianness = IIO_CPU,                          \
>> +     },                                                      \
>> +     .datasheet_name = _ext,                                 \
>> +}
> 
> ...
> 
>> +static void sysmon_q8p7_to_millicelsius(int raw_data, int *val)
>> +{
>> +     *val = ((s16)raw_data * SYSMON_MILLI) >> SYSMON_FRACTIONAL_SHIFT;
> 
> No casting is needed, just make the type s16 to begin with.

Accepted. Will change the parameter type to s16.

> 
>> +}
> 
> ...
> 
>> +static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
>> +{
>> +     int mantissa, format, exponent;
>> +
>> +     mantissa = FIELD_GET(SYSMON_MANTISSA_MASK, raw_data);
>> +     exponent = SYSMON_SUPPLY_MANTISSA_BITS - FIELD_GET(SYSMON_MODE_MASK, raw_data);
>> +     format = FIELD_GET(SYSMON_FMT_MASK, raw_data);
>> +     /*
>> +      * When format bit is set the mantissa is two's complement
>> +      * (per hardware spec); sign-extend to int for correct arithmetic.
>> +      */
>> +     if (format)
>> +             mantissa = (int)(s16)mantissa;
> 
> Potential user of FIELD_GET_SIGNED(), but for now just use explicit call to
> sign_extend32().

Accepted. Will use sign_extend32(mantissa, 15).

> 
>> +     *val = (mantissa * SYSMON_MILLI) >> exponent;
>> +}
> 
> ...
> 
>> +static int sysmon_read_raw(struct iio_dev *indio_dev,
>> +                        struct iio_chan_spec const *chan, int *val,
>> +                        int *val2, long mask)
> 
> Use logical split:

Accepted. Will use:

static int sysmon_read_raw(struct iio_dev *indio_dev,
                            struct iio_chan_spec const *chan,
                            int *val, int *val2, long mask)

> 
> static int sysmon_read_raw(struct iio_dev *indio_dev,
>                             struct iio_chan_spec const *chan, int *val, int *val2,
>                             long mask)
> 
> OR (to be strict in 80 limit)
> 
> static int sysmon_read_raw(struct iio_dev *indio_dev,
>                             struct iio_chan_spec const *chan,
>                             int *val, int *val2, long mask)
> 
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int regval;
>> +     int ret;
>> +
>> +     if (mask != IIO_CHAN_INFO_RAW && mask != IIO_CHAN_INFO_PROCESSED)
>> +             return -EINVAL;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     switch (chan->type) {
>> +     case IIO_TEMP:
>> +             ret = regmap_read(sysmon->regmap, chan->address, &regval);
>> +             if (ret)
>> +                     return ret;
>> +             if (mask == IIO_CHAN_INFO_PROCESSED)
>> +                     sysmon_q8p7_to_millicelsius(regval, val);
>> +             else
>> +                     *val = (int)regval;
> 
> Why casting?

Unneccessary, will remove.

> 
>> +             return IIO_VAL_INT;
>> +
>> +     case IIO_VOLTAGE:
>> +             ret = regmap_read(sysmon->regmap,
>> +                               (chan->address * SYSMON_REG_STRIDE) + SYSMON_SUPPLY_BASE,
>> +                               &regval);
>> +             if (ret)
>> +                     return ret;
>> +             if (mask == IIO_CHAN_INFO_PROCESSED)
>> +                     sysmon_supply_rawtoprocessed(regval, val);
>> +             else
>> +                     *val = (int)regval;
> 
> Ditto.
> 
>> +             return IIO_VAL_INT;
>> +
>> +     default:
>> +             return -EINVAL;
>> +     }
>> +}
> 
> ...
> 
>> +/**
>> + * sysmon_parse_fw() - Parse firmware nodes and configure IIO channels.
>> + * @indio_dev: IIO device instance
>> + * @dev: Parent device
>> + *
>> + * Reads supply-channels and temperature-channels container nodes from
>> + * firmware and builds the IIO channel array. Static temperature channels
>> + * are prepended, followed by supply and satellite channels from DT.
>> + *
>> + * Return: 0 on success, negative errno on failure.
>> + */
>> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
>> +{
>> +     unsigned int idx, temp_chan_idx, volt_chan_idx;
>> +     struct fwnode_handle *supply_node, *temp_node;
> 
>> +     unsigned int num_supply = 0, num_temp = 0;
> 
> Better for maintenance to split these assignments and perform them when they
> are really needed.

Accepted.
> 
>> +     struct iio_chan_spec *sysmon_channels;
>> +     const char *label;
>> +     u32 reg;
>> +     int ret;
> 
>> +     supply_node = device_get_named_child_node(dev, "supply-channels");
> 
> Use what cleanup.h provides you,

Accepted. Will use __free(fwnode_handle) for both supply_node and 
temp_node, eliminating the goto err_put pattern.

> 
>> +     if (supply_node)
>> +             num_supply = fwnode_get_child_node_count(supply_node);
>> +
>> +     temp_node = device_get_named_child_node(dev, "temperature-channels");
>> +     if (temp_node)
>> +             num_temp = fwnode_get_child_node_count(temp_node);
> 
> As per above.
> 
>> +     sysmon_channels = devm_kcalloc(dev,
>> +                                    ARRAY_SIZE(temp_channels) +
>> +                                    num_supply + num_temp,
> 
> Each of num_supply and num_temp may lead to overflow on 32-bit machines.

Will use size_add() for the allocation size computation.

> 
>> +                                    sizeof(*sysmon_channels), GFP_KERNEL);
>> +     if (!sysmon_channels) {
>> +             ret = -ENOMEM;
>> +             goto err_put;
>> +     }
>> +
>> +     /* Static temperature channels first (fixed indices) */
>> +     idx = 0;
>> +     memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
>> +     idx += ARRAY_SIZE(temp_channels);
>> +
>> +     /* Supply channels from DT */
> 
>> +     if (supply_node) {
> 
> Why? Do you expect the below loop to go on this being NULL?

With _free(fwnode_handle), the NULL guard becomes unnecessary since 
fwnode_for_each_child_node_scoped handles NULL parent. Will remove.

> 
>> +             fwnode_for_each_child_node_scoped(supply_node, child) {
>> +                     ret = fwnode_property_read_u32(child, "reg", &reg);
>> +                     if (ret < 0)
>> +                             goto err_put;
>> +
>> +                     if (reg > SYSMON_SUPPLY_IDX_MAX) {
>> +                             ret = -EINVAL;
>> +                             dev_err(dev, "supply reg %u exceeds max %u\n",
>> +                                     reg, SYSMON_SUPPLY_IDX_MAX);
>> +                             goto err_put;
>> +                     }
>> +
>> +                     ret = fwnode_property_read_string(child, "label",
>> +                                                       &label);
>> +                     if (ret < 0)
>> +                             goto err_put;
>> +
>> +                     sysmon_channels[idx++] = (struct iio_chan_spec) {
>> +                             .type = IIO_VOLTAGE,
>> +                             .indexed = 1,
>> +                             .address = reg,
>> +                             .info_mask_separate =
>> +                                     BIT(IIO_CHAN_INFO_RAW) |
>> +                                     BIT(IIO_CHAN_INFO_PROCESSED),
>> +                             .scan_type = {
>> +                                     .realbits = 19,
>> +                                     .storagebits = 32,
>> +                                     .endianness = IIO_CPU,
>> +                                     .sign = fwnode_property_read_bool(child,
>> +                                             "bipolar") ? 's' : 'u',
>> +                             },
>> +                             .datasheet_name = label,
>> +                     };
>> +             }
>> +             fwnode_handle_put(supply_node);
>> +             supply_node = NULL;
>> +     }
>> +
>> +     /* Temperature satellite channels from DT */
>> +     if (temp_node) {
> 
> As per above.
> 
>> +             fwnode_for_each_child_node_scoped(temp_node, child) {
>> +                     ret = fwnode_property_read_u32(child, "reg", &reg);
>> +                     if (ret < 0)
>> +                             goto err_put;
>> +
>> +                     if (reg < 1 || reg > SYSMON_TEMP_SAT_MAX) {
>> +                             ret = -EINVAL;
>> +                             dev_err(dev, "temp reg %u out of range [1..%u]\n",
>> +                                     reg, SYSMON_TEMP_SAT_MAX);
>> +                             goto err_put;
>> +                     }
>> +
>> +                     ret = fwnode_property_read_string(child, "label",
>> +                                                       &label);
>> +                     if (ret < 0)
>> +                             goto err_put;
>> +
>> +                     sysmon_channels[idx++] = (struct iio_chan_spec) {
>> +                             .type = IIO_TEMP,
>> +                             .indexed = 1,
>> +                             .address = SYSMON_TEMP_SAT_BASE +
>> +                                        ((reg - 1) * SYSMON_REG_STRIDE),
>> +                             .info_mask_separate =
>> +                                     BIT(IIO_CHAN_INFO_RAW) |
>> +                                     BIT(IIO_CHAN_INFO_PROCESSED),
>> +                             .scan_type = {
>> +                                     .sign = 's',
>> +                                     .realbits = 15,
>> +                                     .storagebits = 16,
>> +                                     .endianness = IIO_CPU,
>> +                             },
>> +                             .datasheet_name = label,
>> +                     };
>> +             }
>> +             fwnode_handle_put(temp_node);
>> +             temp_node = NULL;
>> +     }
>> +
>> +     indio_dev->num_channels = idx;
>> +     indio_dev->info = &sysmon_iio_info;
>> +
>> +     /*
>> +      * Assign per-type sequential channel numbers.
>> +      * IIO sysfs uses type prefix (in_tempN, in_voltageN)
>> +      * so numbers only need to be unique within each type.
>> +      */
>> +     temp_chan_idx = 0;
>> +     volt_chan_idx = 0;
>> +     for (idx = 0; idx < indio_dev->num_channels; idx++) {
>> +             if (sysmon_channels[idx].type == IIO_TEMP)
>> +                     sysmon_channels[idx].channel = temp_chan_idx++;
>> +             else
>> +                     sysmon_channels[idx].channel = volt_chan_idx++;
>> +     }
>> +
>> +     indio_dev->channels = sysmon_channels;
>> +
>> +     return 0;
>> +
>> +err_put:
>> +     fwnode_handle_put(supply_node);
>> +     fwnode_handle_put(temp_node);
>> +     return ret;
>> +}
> 
> ...
> 
>> +#include <linux/io.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/module.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
> 
> As per above, please respect and follow IWYU principle.

Will audit the MMIO driver and header for IWYU as well.

> 
> ...
> 
>> +static int sysmon_platform_probe(struct platform_device *pdev)
>> +{
>> +     struct sysmon_mmio *mmio;
>> +     struct regmap *regmap;
>> +     int irq;
>> +
>> +     mmio = devm_kzalloc(&pdev->dev, sizeof(*mmio), GFP_KERNEL);
>> +     if (!mmio)
>> +             return -ENOMEM;
>> +
>> +     mmio->base = devm_platform_ioremap_resource(pdev, 0);
>> +     if (IS_ERR(mmio->base))
>> +             return PTR_ERR(mmio->base);
>> +
>> +     regmap = devm_regmap_init(&pdev->dev, NULL, mmio,
> 
> Using
> 
>          struct device *dev = &pdev->dev;
> 
> at the top of the function makes this code neater and probably a single line.

Accepted.

> 
>> +                               &sysmon_mmio_regmap_config);
>> +     if (IS_ERR(regmap))
>> +             return PTR_ERR(regmap);
>> +
>> +     irq = platform_get_irq_optional(pdev, 0);
>> +
>> +     return sysmon_core_probe(&pdev->dev, regmap, irq);
>> +}
> 
> ...
> 
>> +#include <linux/iio/iio.h>
>> +#include <linux/mutex.h>
>> +#include <linux/regmap.h>
> 
> Ditto for the header files, use and follow the IWYU principle.
> 
> ...
> 
>> +/* Signed milli scale (MILLI from linux/units.h is unsigned long) */
>> +#define SYSMON_MILLI                 1000
> 
> I think you want a different approach. I already forgot how it's being used,
> but there shouldn't be a new (re-)definition just because of this.

The issue is that MILLI from units.h is 1000UL, which causes unsigned
promotion when multiplied with signed int values (e.g. negative
temperatures or two's complement mantissa). There is
MILLIDEGREE_PER_DEGREE (signed 1000) but using it for voltage
channel conversions would be semantically wrong. Will either use
(int)MILLI at the call sites or just use literal 1000 -- happy to
go with whichever you prefer.

> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 
All items will be addressed in v3.

Salih
