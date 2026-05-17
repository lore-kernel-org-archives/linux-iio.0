Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013064.outbound.protection.outlook.com [40.107.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161662236EE;
	Sun, 17 May 2026 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779061700; cv=fail; b=e+oXqhY14KQ0F7JpwVgqaIXnY7Q2X37B1RkGnM/gsgOF7DbDUKNPunJch0NfV0M++oLbuDORuMqokwoLj7XxK/EC7mZJPIGEM2w3WHL+tjfMiLtNjhgxPHLmBOf5SuuOUunHCCT4mJmd72ZxRw/2ClAIWuepIygHypAfdGlVBSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779061700; c=relaxed/simple;
	bh=IfvvPNJJY3ODuPrl+G8/7e9jr4C8KpyEb6TISzNf6pw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=AX/I02VoQGVp+TkQNeJ4IzxmrMOPY8ky5ZKanytSU6mLnvW7g4RwKJ2kFQi+/5KsKNlAYivLzcY/wGCUa2MLZRC5tp88SSjw51uQhItFIFqDyGdoJ53rMWrl9H1EVUoyDdELKks76wy5ZFpm1EebwnEedKea2lyLoEms9wUtN50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ihppi2Mr; arc=fail smtp.client-ip=40.107.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ihppi2Mr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjwQlKeHg2pvVtU+Aeb0sF4a51ObBA4tWq3Ko92h+PCpPmaw/XRtzYBSaM1EcHuzZp6v5/JFC3/n6VQ4StZD4a7wJk3+hjhtaNWVE4pNMtxWdY3wNf8bUA/8LnQG4mSLn/p4x1J0jep+SL77LmiI45xITUSdzUC/S6j0oFu2e8pz5YvF3pleUkInvffrZZowaQ2cOx8PuIwunQDutI9nE0b4rDtHk5IQryWqg0lE7dtoCDds8OR1e2CDCf4DQiMw4w0u6giFxM41lDfv3DLX87glkCdUPhj3yZGM7LfwEiDrSSOisdzOjkdwkXuCZbzh+XlCvHa9hF4tETlp9R0OpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RLFp0GvUG8v/1QpQ+B32/QW6AtBiSSvb1Qw48IMs7M=;
 b=BpX7ojCxjeKQOPkpy0enm4/3vBbFO/n0rUpk0L7txScclGCafB5dkzp9lX7Fj8gro6fuGnwJ1TDIYrm6LHMe+DlqHMFJSm8ILa/F083c9jt+wmy6troTxJ0onKHrBJVL9OX2K+hf3+X0bGo+zMyISymXmDXenj45yN49a2/mlP6eLlF3F879fFSixgHWWndLdZTwe7WWQ72PWUhhbCvOFFQg+24qvfsFYFDS/4gogkm/th61/4SslV6HlG41wuc8BdzsBLGUEBUQNtQ9CKvBz+5XMy1WnEXT91ew8dkgdyE36H3rHMHmuP86fy41xwlYkLkRap1bF3K1FzD2gKz7bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RLFp0GvUG8v/1QpQ+B32/QW6AtBiSSvb1Qw48IMs7M=;
 b=ihppi2MrJUfV80z6OSG/YODYgyFvZ0Yixtuh/RwhXpCNFljn3r4KpJyThhS6AsJYyDnjb3bRjCfNglfe0kCO3Ysq9j1CLMWpkpLtjdwkz3NjBW40eDKN3e+xBo79sSxW+aePnSgxIxTr4we+hmfOku+Wu8yszbSCsXO6RVayU+M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by PH8PR12MB7278.namprd12.prod.outlook.com (2603:10b6:510:222::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Sun, 17 May
 2026 23:48:09 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0025.016; Sun, 17 May 2026
 23:48:08 +0000
Message-ID: <7c7f59af-ec64-469c-9a66-7a02bfbf902a@amd.com>
Date: Mon, 18 May 2026 00:48:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] iio: adc: versal-sysmon: add threshold event
 support
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, git@amd.com, nuno.sa@analog.com, andy@kernel.org,
 dlechner@baylibre.com, michal.simek@amd.com, conall.ogriofa@amd.com,
 erimsalih@gmail.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260502111951.538488-1-salih.erim@amd.com>
 <20260502111951.538488-5-salih.erim@amd.com>
 <afh6fgnRy1KQRkTl@ashevche-desk.local>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <afh6fgnRy1KQRkTl@ashevche-desk.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0515.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::7) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|PH8PR12MB7278:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c2c605f-45ea-4b6e-dfc8-08deb46ebf98
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|4143699003|56012099003|22082099003|18002099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	SM6Sb9/7bX6VEbldM0QwsT6+Ac1ZvNYJD2I0VrbJamgUPnIP4kdJqbtbdPHKsYw+3JvcDWiKAtHawoT8r120bKUTxYpO8vPT4yLMqxXtfgt+OaajMesyUQyuU5LWYSIt+hPHa85lZ/2b9O/vtqKipPlO7L3P6zYKBjgKppIqPGxdFs78I/wxZ+mkvy3hBZeCshgk2PT8Tg7D4+txKUMm4LH6x/S93TJykIUo1XbJgqhwr9+qnc4Di5XwROWWf5b50tSUWdZZOFQ1LMxj+GKiZk11TLLJ3QTsrgjoEoAupMT1+qipsveDumx9+/jkg46CS1zRV8Ku2+i9PPsc0At19AB2EpKLQYz7YwO8kVjELJJYeZP4Dix2Wn3PJ9EonVJWxi3UalneFPQW6O4c3erlRaiXuxtXdnrv1c4WD6FkMJWiGDal87QqWRXY+LUPAI9pfMOTiWi6d+i6NqgboDXWy0U4wz4NNSiV6c4rXKB8M9Q0+uYFkG37C/uXxOz2CgdxWVXZuQtuSeNz5cnncKkArV8VZ9BUfD5oRfYHDZ3tZ0TFuQdWn/+n8PcJ/IdAuOby8LWh5cZ50tIrF77zBItZJSXeky6boK69ugTCcMS1gNgojzpb6SRlHJQTDp1Iq20Qzw5IHfIOIEiyQJW5aFJGBUkezvZoj54WUJGxgUZqxX+E48BWQb+VDWwe2fgjT6Ea
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(4143699003)(56012099003)(22082099003)(18002099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QkxhMmdnMGczNkg0TmYyVEUzT2NzSlFhVzdMc2Z3SmphOUNSeFZna09FQ2Zh?=
 =?utf-8?B?eHAvWnZtWGtaWlZqQ3lpVUtBNnQ3NkkzWkVMaERMRUE3bG5oVWJhZ3NiOW5y?=
 =?utf-8?B?bzFqWXo1RmQwakRpQi9xVi81NHVJRXhlVTBiV3FiSFhCeU5kaWcrZmRrbGpk?=
 =?utf-8?B?aGVkM3N2ckR5d05HY0xWWEhQQnpEU1A4ZHI0MElGMWc5MVdJMEpsZkR4Qzk1?=
 =?utf-8?B?bHM2Q0pLckhiSHI0MEtqeW1nRHBLbllFUmtmMzBGeXIwOW9xc0tNSjR3Q1o5?=
 =?utf-8?B?WWZQK201OXlZNHFPSjFSSVpTS2pNNTNOaFV0TUhPd0RxcVIzaXIzdXFCOVdr?=
 =?utf-8?B?OTdibTNUY3BVQUVyR0FRTHVzWTR1ZzNZSEFsNXgrR3I3am84eTQvaFFCa1dT?=
 =?utf-8?B?eVpTQmRTL1FoUW9nOHRpNHFsaUlXekpFWmVEaG9oUkcrTnpjV244bkpWNjFt?=
 =?utf-8?B?NHdIOFFvNk4ydHp2MFVtTVFhNHV6MnRYdkNMSVh1UTJydDgrR1dNWGMxVWFq?=
 =?utf-8?B?Qmh5akxCZEhORGc5aCtsU1pEcGx3Nk5id25OZlQzbFRKbWVkc092bXB2U0hz?=
 =?utf-8?B?c1lqNFFna3Q0ZDZJWjZKUDNqRjZ2L3J6dUdFQWZHWmpHeDZtYmFUclBxYkhW?=
 =?utf-8?B?eGk2c2RJbmhpMFcyQ2d4UnA0YTRFM0lBaURJalVRd2N1UEJHb0VFN2VaNEdN?=
 =?utf-8?B?Z0VQVWlFM25pT1Z6Nlh1cUFlUUs4cHAxYkpTQytlWVErMkszYTdIQ0MyL0NY?=
 =?utf-8?B?TU1NN0tzWHJhdmgyQUVPYVJpV3BwbzNPeEdnb0kxcEtOOTJFVWQzK1NGdUNH?=
 =?utf-8?B?TGFmdzdRU3U5cE1IKzV1Z3V1dklEdDJ6WUFVTlVwelBVMkVXQmpySm5abGJT?=
 =?utf-8?B?WkhDUkVJeFBvODBGbFd3TUxuV3kwaWk2OXJyb3gweGZ1KzNHdGRTV1M4U2NY?=
 =?utf-8?B?cG5aWFJPNXJ2MkVCTWhieFkrYzVueEZwQ3k5WG9Wbmd3ZUFwS0NNcXVjNTE1?=
 =?utf-8?B?NzVmTHFCVFdHM3RpRHdIRzF5WisxcVFGUkwzVHhrSCtUTnZ3TnU5K2VsTkdU?=
 =?utf-8?B?d3g4cGw3Z0ptRUh5QWlFTmc2OXpwUXFoeituZUtPc21vWjFobTdGeVJuQXRY?=
 =?utf-8?B?UmQvTDFhM2E1STlaZFFjaXZHNkdrRFlnTGp1QmJleDU2bGNyRjZDNU9HZ21Z?=
 =?utf-8?B?QTYyc1VqU3BWaGd2WlNlRE8yOFJ1ZDh5ODFaU1dKWEpvWmlXYVg2aDFOeW9k?=
 =?utf-8?B?dTNxQXhGKzllRStHbzhocitDMnU4ZzE5MUNHTDdKQTR1VlQxRFhEbVZ3MUln?=
 =?utf-8?B?ZkxhTHdLNmt4dFVTenpyRzhReHJDNVFQVGRlaGpiRG9LNDZpMWJ0RWs1MmJk?=
 =?utf-8?B?M2Y2d0hwbzZJa1o4cGNLWkE1dXhTamtManJkdHJRRDFnRjQvSy9XblRod2Nq?=
 =?utf-8?B?SW9iV3dXU2FvU014cGVXd0NTWkpOck1Ia3d6SVJScm00RlZ4UVlxME1PUkdZ?=
 =?utf-8?B?NXY3NmhhU1o5SDdDdUZ6dGZFbE5BWHN2S1pDcFR6RlVMVTEzeFRUeUEwdXg2?=
 =?utf-8?B?YWNsWHlnUDVyb040am5hZDgzQU9wUnJ5ZlZxemdBRHBWQm0yL1RHbzJoWW1j?=
 =?utf-8?B?eHRJUENXRGRvenpBd2ZoaGJjU1ZSVFliMjY0REVtVi8yZVA4aTNvVzhmTEg2?=
 =?utf-8?B?M1ZlR0luRXpabTZBbmdIbTJjMmxZNDN3WnQwUFpXKzFNOHpXL1pzNkQ2ajM5?=
 =?utf-8?B?dm12Z05LNVlkemNORWlmSTBrZHdDTGhNM3A5OUxob094bC9najJTTGd2aElK?=
 =?utf-8?B?azltdCs3YTI1dC92YlFyM3JiVEsrbVJWZ2FYNlNLUGdBbElwb1BUMXFoTWh2?=
 =?utf-8?B?cWU1Z295YWJYRVpDQVA4NFBobkF4ckJraEU3WU5LaXJBMUIzeXZMRFhPd3pj?=
 =?utf-8?B?K2dpc1ozTFBLbVZFZms1UW5rL0E3a09uWHp6ejdESkJ0VWJpcFhVTzdSNXJy?=
 =?utf-8?B?bkM0bnNtcjl3ZXh1VWZ1d0VoVDN4TnJCalQvUFVXcUY1T2trWWJVOW90ZVZk?=
 =?utf-8?B?TDB6ZHhpcThQT1hzSDhKWGNqNzZ3OHl0ZTAxU3VUOVAxU0QvZVFUNDlKQ3lw?=
 =?utf-8?B?QkNQcFowQjJLTzJMU1h2MHYyQ3lHUksvZGNBbEp5QVhQUE8wUnZtOWdzSmJB?=
 =?utf-8?B?ZXpSVEc5OEZLbTFzVDEyVlI4a1Z3WkRsbmVjb2xST2JTMnhvN2oxZkNKWTdt?=
 =?utf-8?B?OEFHa0YzY29uUE5aWFNnL2l1OXN4dlJCbGRWOG8zc1BTTmlZUGxGSTJsUVBO?=
 =?utf-8?Q?dsEo1pHrorF8wPWOXj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c2c605f-45ea-4b6e-dfc8-08deb46ebf98
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2026 23:48:08.8501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOzua86/92JerouUiNkW/BmFBHHoiAPDAwWmNOf0hycn3oOCcZ4ca1cCYlnpeaWw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7278

Hi Andy,

On 04/05/2026 11:52, Andy Shevchenko wrote:

> 
> On Sat, May 02, 2026 at 12:19:50PM +0100, Salih Erim wrote:
>> Add threshold event support for temperature and supply voltage
>> channels.
>>
>> Temperature events:
>>    - Rising/falling threshold with configurable values
>>    - Over-temperature (OT) alarm with separate thresholds
>>    - Per-channel hysteresis configuration
>>
>> Supply voltage events:
>>    - Rising/falling threshold per supply channel
>>    - Per-channel alarm enable via alarm configuration registers
>>
>> The interrupt handler masks active threshold interrupts (which are
>> level-sensitive) and schedules a delayed worker to poll for condition
>> clear before unmasking. When no hardware IRQ is available (irq <= 0),
>> event channels are not created and interrupt init is skipped, since
>> the I2C regmap backend cannot be called from atomic context.
>>
>> When disabling a supply channel alarm, the group interrupt remains
>> active if any other channel in the same alarm group still has an
>> alarm enabled.
>>
>> Named constants replace magic numbers for hysteresis bit positions
>> (SYSMON_OT_HYST_BIT, SYSMON_TEMP_HYST_BIT) and alarm register width
>> (SYSMON_ALARM_BITS_PER_REG).
>>
>> Hysteresis values are validated to single-bit range (0 or 1) before
>> writing to the hardware register.
> 
> ...
> 
>>   #include <linux/bitfield.h>
>>   #include <linux/bits.h>
>>   #include <linux/cleanup.h>
> 
>> +#include <linux/iio/events.h>
>>   #include <linux/iio/iio.h>
> 
> It's better from the start make it as a separate group of headers...

Accepted. Will group linux/iio/* headers together seperated by blank 
lines from the rest.

> 
>> +#include <linux/interrupt.h>
>> +#include <linux/limits.h>
>>   #include <linux/module.h>
>>   #include <linux/property.h>
>>   #include <linux/regmap.h>
>>
> 
> ...like here (after blank line!)
> 
> ...those linux/iio/*...
> +blank line.
> 
>>   #include "versal-sysmon.h"
> 
> Also follow IWYU.

Accepted.

> 
> ...
> 
>>   static void sysmon_q8p7_to_millicelsius(int raw_data, int *val)
>>   {
>>        *val = ((s16)raw_data * SYSMON_MILLI) >> SYSMON_FRACTIONAL_SHIFT;
>>   }
>>
>> +static void sysmon_millicelsius_to_q8p7(u32 *raw_data, int val)
>> +{
>> +     *raw_data = (u16)((val * (int)BIT(SYSMON_FRACTIONAL_SHIFT)) / SYSMON_MILLI);
>> +}
> 
> Too many explicit castings... Think how to reduce amount of them. Also this
> SYSMON_MILLI shouldn't be defined.
> 
> Besides that it's inconsistent to use right-shift in one case and BIT() in
> the other.

Accpeted. Will make both directions consistent (use right-shift or BIT 
in both) and reduce casts by using proper types in parameters.

> 
> ...
> 
>> +static void sysmon_supply_processedtoraw(int val, u32 reg_val, u32 *raw_data)
>> +{
>> +     int exponent = FIELD_GET(SYSMON_MODE_MASK, reg_val);
>> +     int format = FIELD_GET(SYSMON_FMT_MASK, reg_val);
>> +     int scale, tmp;
>> +
>> +     scale = BIT(SYSMON_SUPPLY_MANTISSA_BITS - exponent);
>> +     tmp = (val * scale) / SYSMON_MILLI;
>> +
>> +     if (format)
>> +             tmp = clamp(tmp, (int)S16_MIN, (int)S16_MAX);
>> +     else
>> +             tmp = clamp(tmp, 0, (int)U16_MAX);
> 
> No, the use of clamp() assumes it should not have explicit casts.

Will use clamp_t(int, ...) or declare typed contants to avoid the casts.

> 
>> +     *raw_data = tmp & U16_MAX;
> 
> Why?! The previous clamp() guarantees that, no?

Correct, clamp already bounds it. Will remove the mask.

> 
>> +}
> 
> ...
> 
>> +static int sysmon_read_alarm_config(struct sysmon *sysmon,
>> +                                 unsigned long address)
>> +{
>> +     u32 shift = address % SYSMON_ALARM_BITS_PER_REG;
>> +     u32 offset = SYSMON_ALARM_OFFSET(address);
>> +     unsigned int reg_val;
>> +     int ret;
>> +
>> +     ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +     if (ret)
>> +             return ret;
>> +
>> +     return reg_val & BIT(shift);
> 
> This won't work in case shift becomes 31. Because the returned value will be
> considered by the callers as negative error code.

Good catch. Will use !!(reg_val & BIT(shift)) to ensure the return 0 or 1.

> 
>> +}
> 
> ...
> 
>> +static int sysmon_write_alarm_config(struct sysmon *sysmon,
>> +                                  unsigned long address, u32 val)
>> +{
>> +     u32 shift = address % SYSMON_ALARM_BITS_PER_REG;
>> +     u32 offset = SYSMON_ALARM_OFFSET(address);
>> +
>> +     return regmap_update_bits(sysmon->regmap, offset,
>> +                               BIT(shift), val << shift);
> 
> Looks like regmap_set_bits().

The val parameter is 0 or 1, so this needs to both set and clear.
Will use regmap_set_bits() when val is true and regmap_clear_bits() when 
val is false.

> 
>> +}
> 
> ...
> 
>> +static int sysmon_read_event_config(struct iio_dev *indio_dev,
>> +                                 const struct iio_chan_spec *chan,
>> +                                 enum iio_event_type type,
>> +                                 enum iio_event_direction dir)
>> +{
>> +     u32 alarm_event_mask = sysmon_get_event_mask(chan->address);
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int imr;
>> +     int config_value;
>> +     int ret;
>> +
>> +     ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
>> +     if (ret)
>> +             return ret;
> 
> + blank line and a comment why imr is negated.

Accepted. IMR is the interrupt mask register where 1 = masked. Negating 
gives the enabled interrupts. Will add a comment.

> 
>> +     imr = ~imr;
>> +
>> +     if (chan->type == IIO_VOLTAGE) {
>> +             config_value = sysmon_read_alarm_config(sysmon, chan->address);
>> +             if (config_value < 0)
>> +                     return config_value;
>> +             return config_value && (imr & alarm_event_mask);
>> +     }
>> +
>> +     return !!(imr & alarm_event_mask);
>> +}
> 
> ...
> 
>> +static int sysmon_write_event_config(struct iio_dev *indio_dev,
>> +                                  const struct iio_chan_spec *chan,
>> +                                  enum iio_event_type type,
>> +                                  enum iio_event_direction dir, bool state)
>> +{
>> +     u32 offset = SYSMON_ALARM_OFFSET(chan->address);
>> +     u32 ier = sysmon_get_event_mask(chan->address);
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int alarm_config;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
> 
>> +     guard(spinlock_irqsave)(&sysmon->irq_lock);
> 
> This is wrong (imagine I²C driver calling this...).

Events are only created when irq > 0, and the I2C driver passes irq = 0 
so event channels are never registered. This function cannot be reached 
from the I2C path. Will add a comment clarifying this. However if you 
prefer, can restructure to avoid spinlock in this entirely.

> 
>> +
>> +     if (chan->type == IIO_VOLTAGE) {
>> +             ret = sysmon_write_alarm_config(sysmon, chan->address, state);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             ret = regmap_read(sysmon->regmap, offset, &alarm_config);
>> +             if (ret)
>> +                     return ret;
>> +
>> +             if (alarm_config)
>> +                     return regmap_write(sysmon->regmap, SYSMON_IER, ier);
>> +             else
>> +                     return regmap_write(sysmon->regmap, SYSMON_IDR, ier);
>> +     } else if (chan->type == IIO_TEMP) {
>> +             if (state) {
>> +                     ret = regmap_write(sysmon->regmap, SYSMON_IER, ier);
>> +                     if (ret)
>> +                             return ret;
>> +                     sysmon->temp_mask &= ~ier;
>> +             } else {
>> +                     ret = regmap_write(sysmon->regmap, SYSMON_IDR, ier);
>> +                     if (ret)
>> +                             return ret;
>> +                     sysmon->temp_mask |= ier;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
> 
> ...
> 
>> +static int sysmon_read_event_value(struct iio_dev *indio_dev,
>> +                                const struct iio_chan_spec *chan,
>> +                                enum iio_event_type type,
>> +                                enum iio_event_direction dir,
>> +                                enum iio_event_info info, int *val,
>> +                                int *val2)
> 
> Logical split, please (move int val to the next line, or int val2 to the
> previous).

Accepted.

> 
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int reg_val;
>> +     u32 mask, shift;
>> +     int offset;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     if (chan->type == IIO_TEMP) {
>> +             if (info == IIO_EV_INFO_VALUE) {
>> +                     offset = sysmon_temp_thresh_offset(chan->address, dir);
>> +                     if (offset < 0)
>> +                             return offset;
>> +                     ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +                     if (ret)
>> +                             return ret;
>> +                     sysmon_q8p7_to_millicelsius(reg_val, val);
>> +                     return IIO_VAL_INT;
>> +             }
>> +             if (info == IIO_EV_INFO_HYSTERESIS) {
>> +                     mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
>> +                             SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;
> 
> No need to calculate mask if regmap_read() fails.

Accepted. Will move mask/shift computation after the regmap_read() error 
check.

> 
>> +                     shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;
> 
> Ditto.
> 
>> +                     ret = regmap_read(sysmon->regmap, SYSMON_TEMP_EV_CFG,
>> +                                       &reg_val);
>> +                     if (ret)
>> +                             return ret;
>> +                     *val = (reg_val & mask) >> shift;
>> +                     return IIO_VAL_INT;
>> +             }
> 
>> +     } else if (chan->type == IIO_VOLTAGE) {
> 
> Redundant 'else'.

Accepted. Will remove.

> 
>> +             offset = sysmon_supply_thresh_offset(chan->address, dir);
>> +             if (offset < 0)
>> +                     return offset;
>> +             ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +             if (ret)
>> +                     return ret;
>> +             sysmon_supply_rawtoprocessed(reg_val, val);
>> +             return IIO_VAL_INT;
>> +     }
>> +
>> +     return -EINVAL;
>> +}
>> +
>> +static int sysmon_write_event_value(struct iio_dev *indio_dev,
>> +                                 const struct iio_chan_spec *chan,
>> +                                 enum iio_event_type type,
>> +                                 enum iio_event_direction dir,
>> +                                 enum iio_event_info info, int val, int val2)
>> +{
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned int reg_val;
>> +     u32 mask, shift;
>> +     u32 raw_val;
>> +     int offset;
>> +     int ret;
>> +
>> +     guard(mutex)(&sysmon->lock);
>> +
>> +     if (chan->type == IIO_TEMP) {
>> +             if (info == IIO_EV_INFO_VALUE) {
>> +                     offset = sysmon_temp_thresh_offset(chan->address, dir);
>> +                     if (offset < 0)
>> +                             return offset;
>> +                     sysmon_millicelsius_to_q8p7(&raw_val, val);
>> +                     return regmap_write(sysmon->regmap, offset, raw_val);
>> +             }
>> +             if (info == IIO_EV_INFO_HYSTERESIS) {
>> +                     mask = (chan->address == SYSMON_ADDR_OT_EVENT) ?
>> +                             SYSMON_OT_HYST_BIT : SYSMON_TEMP_HYST_BIT;
>> +                     shift = (chan->address == SYSMON_ADDR_OT_EVENT) ? 0 : 1;
> 
> Similar comments as per above.

Accepted.

> 
>> +                     if (val & ~1)
> 
> BIT(0), but still magic.

Will use a named constant or add a comment. The intent is to validate 
that val is a single-bit value (0 or 1).

> 
>> +                             return -EINVAL;
>> +                     return regmap_update_bits(sysmon->regmap,
>> +                                               SYSMON_TEMP_EV_CFG,
>> +                                               mask, val << shift);
> 
> Also seems like a regmap_set_bits(). and instead of that ugly ternary just make
> it if-else or similar.

Accepted. Will use if-else with regmap_set_bits()/regmap_clear_bits() 
and remove the ternary.

> 
>> +             }
>> +     } else if (chan->type == IIO_VOLTAGE) {
> 
> Redundant 'else'.
> 
>> +             offset = sysmon_supply_thresh_offset(chan->address, dir);
>> +             if (offset < 0)
>> +                     return offset;
>> +             ret = regmap_read(sysmon->regmap, offset, &reg_val);
>> +             if (ret)
>> +                     return ret;
>> +             sysmon_supply_processedtoraw(val, reg_val, &raw_val);
>> +             return regmap_write(sysmon->regmap, offset, raw_val);
>> +     }
>> +
>> +     return -EINVAL;
>> +}
> 
> ...
> 
>> +static void sysmon_push_event(struct iio_dev *indio_dev, u32 address)
>> +{
>> +     const struct iio_chan_spec *chan;
> 
>> +     unsigned int i;
> 
> Seems not used outside of the loop, hence...

Accepted.
> 
>> +     for (i = 0; i < indio_dev->num_channels; i++) {
> 
>          for (unsigned int i = 0; i < indio_dev->num_channels; i++) {
> 
>> +             if (indio_dev->channels[i].address != address)
>> +                     continue;
>> +
>> +             chan = &indio_dev->channels[i];
>> +             iio_push_event(indio_dev,
>> +                            IIO_UNMOD_EVENT_CODE(chan->type,
>> +                                                 chan->channel,
>> +                                                 IIO_EV_TYPE_THRESH,
>> +                                                 IIO_EV_DIR_EITHER),
>> +                            iio_get_time_ns(indio_dev));
>> +     }
>> +}
> 
> ...
> 
>> +static void sysmon_handle_event(struct iio_dev *indio_dev, u32 event)
>> +{
> 
> Why no checks for error from IO accessors in this function?

THis runs from the IRQ handler under spinlock. Will add error checks and 
bail out on failure.
> 
>> +     u32 alarm_flag_offset = SYSMON_ALARM_FLAG + (event * SYSMON_REG_STRIDE);
>> +     u32 alarm_reg_offset = SYSMON_ALARM_REG + (event * SYSMON_REG_STRIDE);
>> +     struct sysmon *sysmon = iio_priv(indio_dev);
>> +     unsigned long alarm_flag_reg;
>> +     unsigned int reg_val;
>> +     u32 address, bit;
>> +
>> +     switch (event) {
>> +     case SYSMON_BIT_TEMP:
>> +             sysmon_push_event(indio_dev, SYSMON_ADDR_TEMP_EVENT);
>> +             regmap_write(sysmon->regmap, SYSMON_IDR, BIT(SYSMON_BIT_TEMP));
>> +             sysmon->masked_temp |= BIT(SYSMON_BIT_TEMP);
>> +             break;
>> +
>> +     case SYSMON_BIT_OT:
>> +             sysmon_push_event(indio_dev, SYSMON_ADDR_OT_EVENT);
>> +             regmap_write(sysmon->regmap, SYSMON_IDR, BIT(SYSMON_BIT_OT));
>> +             sysmon->masked_temp |= BIT(SYSMON_BIT_OT);
>> +             break;
>> +
>> +     case SYSMON_BIT_ALARM0:
>> +     case SYSMON_BIT_ALARM1:
>> +     case SYSMON_BIT_ALARM2:
>> +     case SYSMON_BIT_ALARM3:
>> +     case SYSMON_BIT_ALARM4:
>> +             regmap_read(sysmon->regmap, alarm_flag_offset, &reg_val);
>> +             alarm_flag_reg = (unsigned long)reg_val;
>> +
>> +             for_each_set_bit(bit, &alarm_flag_reg,
>> +                              SYSMON_ALARM_BITS_PER_REG) {
>> +                     address = bit + (SYSMON_ALARM_BITS_PER_REG * event);
>> +                     sysmon_push_event(indio_dev, address);
>> +                     regmap_update_bits(sysmon->regmap, alarm_reg_offset,
>> +                                        BIT(bit), 0);
>> +             }
>> +             regmap_write(sysmon->regmap, alarm_flag_offset, alarm_flag_reg);
>> +             break;
>> +
>> +     default:
>> +             break;
>> +     }
>> +}
> 
> ...
> 
>> +     return isr ? IRQ_HANDLED : IRQ_NONE;
> 
> There is a macro for this. IIRC IRQ_RETVAL().

Accepted. Will use IRQ_RETVAL().

> 
> ...
> 
>> +static int sysmon_init_interrupt(struct sysmon *sysmon)
>> +{
>> +     unsigned int imr;
>> +     int ret;
>> +
>> +     /* Events not supported without IRQ (e.g. I2C path) */
>> +     if (sysmon->irq <= 0)
> 
> When can '=' happen?

irq == 0 comes from the I2C backend, which passes 0 explicitly to 
sysmon_core_probe() to indicate no IRQ is available. 
platform_get_irq_optional() itself returns only positive values or 
negative error codes. Will change to if (!sysmon->irq) for clarity.

> 
>> +             return 0;
>> +
>> +     INIT_DELAYED_WORK(&sysmon->sysmon_unmask_work, sysmon_unmask_worker);
>> +
>> +     ret = regmap_read(sysmon->regmap, SYSMON_IMR, &imr);
>> +     if (ret)
>> +             return ret;
>> +     sysmon->temp_mask = imr & SYSMON_TEMP_INTR_MASK;
>> +
>> +     ret = devm_add_action_or_reset(sysmon->dev, sysmon_cancel_work,
>> +                                    sysmon);
>> +     if (ret)
>> +             return ret;
> 
> Don't we have include/linux/devm-helpers.h?

Yes. Will use devm_delayed_work_autocancel() instead of manual 
INIT_DELAYED_WORK + devm_add_action_or_reset.
> 
>> +     return devm_request_irq(sysmon->dev, sysmon->irq,
>> +                             sysmon_iio_irq, 0, "sysmon-irq",
>> +                             sysmon->indio_dev);
>> +}
> 
> --
> With Best Regards,
> Andy Shevchenko
> 
> 

All items will be addressed in v3.

Thanks,
Salih.

