Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010017.outbound.protection.outlook.com [52.101.85.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1860368D7B;
	Thu, 28 May 2026 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780007228; cv=fail; b=IS3J+fSWIg8pBE+bl6z57NOU62Mx4XsBToQVBmg2uhnRkTIaymHju85AJFnVYLhynExNx+tchYF+upueY1hukitq8QQ0OE3D2or31H0dH0p46vwL7YOWqyyU44V4idLFyRtZFPURPfAJKuqPhMw2bPS5SPsIlL0bX7UvWW9JEkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780007228; c=relaxed/simple;
	bh=iH1Q1O3Dt958U4Bbqj/bDBCav3/H/b9/NANaBmpkXzw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=aCqfvPOow2TrTwSF+VaTNyIOUcW2PuMHoG9woShvnwpNdhTANFYNnA2hsxWLa9spsKvc46OwjWSf9XCWh4ldVpEyppVppqwDCmXls2wKyv1a1Yz0jNLQ1KXabBoGC0ECkhTSgVckUTjB9SvDRY7QhoouiOO+veiEVeBZTqQqQnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SwLcPX9g; arc=fail smtp.client-ip=52.101.85.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SwLcPX9g"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aaRYYUdiOjYYnTymK+6dbx1JeuGsNGc+Q4qsYYN8PgPzWoKF93XQcaSgghuYqdgD+N7fdsZ8wQ03TDPXC6nY0QIiUM0lM1C2j5t4rKYGUAgzVMTgmtIXqX+nVoIAo4o3DgdKimodqOLDM/lvK2grX5WmblBvPgu23KB0pXn6PY0JGlxxpugVVspkW/J9EcuGdN9DzZrVrWkUf/7hK9/2qUHWQ6B4/rBuVcUu6CWqUdCuTgbgbiSjLjqirRqUerUeid5fLdPo4vmAUXJXqCuyec6JaVNjxALRdlXC8SDYqSj8I2ChulQEr6bcqnaCmM6/fOA/YWiU1sLNKfqvo/Lj8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yNBfvPnEAF48MJfa6neakee4WzQ4my85p09RdwHSocE=;
 b=eS41XFgTDXIITdYZwsJM9MLA0RbnzJSFdOIZbUVRr0+JTe+98bKEi0sqDDlZ4dbBs0WEOsGSbwZYcmDaWi6LIGwhC6FtXqkqXUF16gMxXNFq+wSEoEmYJVo0boq8j7hil2RFzV9obuJCiNOEqJZg9qGoJEeN5bveRV7WigcD9K3hXNKTVKn8HDhB7dwiYQMfKCAsYMavmeAeSTUUZMb8wXuBVFFYSEhDCqajL/pFUeiPNjlKOSTlk58s5LSo0aT4o4pZ6PzQFDq4ujDOl89e7fsFK+PbcwvlEuRQA6Mo1owYxBZxU6vf7gGsr2rVs8sDaySpiQiMMkhHCWBjQFMXUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yNBfvPnEAF48MJfa6neakee4WzQ4my85p09RdwHSocE=;
 b=SwLcPX9g36R5vXxtwpFZfsSfazv0cqubcPKKFqmu0f3+xyV9V6o6dQlbz+envZJwwvajKn9TYU/bae4qp5eY1oOmbU3i3M1G/+Q4heTvQv9uvtq/oypsrXivrAOEnmA/LBtqz83JDMS/+fIEy750U/KpcxSWdj1SGwN+ZIIr9Ec=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by IA0PR12MB7626.namprd12.prod.outlook.com (2603:10b6:208:438::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.13; Thu, 28 May
 2026 22:27:03 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 22:27:03 +0000
Message-ID: <21f8bfeb-3f8f-4396-a72b-8ec81c179041@amd.com>
Date: Thu, 28 May 2026 23:27:01 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] iio: adc: versal-sysmon: add oversampling support
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
 <20260527114211.174288-6-salih.erim@amd.com>
 <20260528140526.78434dde@jic23-huawei>
Content-Language: en-US
From: "Erim, Salih" <salih.erim@amd.com>
In-Reply-To: <20260528140526.78434dde@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0673.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::8) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|IA0PR12MB7626:EE_
X-MS-Office365-Filtering-Correlation-Id: 35ccbecb-94fa-46f8-5bf9-08debd083e2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|6133799003|4143699003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	mS/kAySevCFinH+0nM9gPc7crAEjfla0O2RVkdAtHHTQT/U2yTHII4qDASgF0frT51ksVv651phWOCInz6Zn8H+Y7wwjio4p6m592LYC0qfZhRSz7AN8Gr/ZbMCAyWh9MjF1H4Sk1QJS3rrVyFEC4eH3VShKis8N7ABwwGUke6F7+YETGrfHFoXoaqK8Yqd/cf+Yj8DjfVZpho0aHK9NwChAcXhLMwI+32eyEolzEw0cZaXx3aRV4hqHnsapLKeDaypq/uBuISF4NCU1sVAB1a8+vnKGmT1ummDxmheACBhxBAWIuG3tPivTNAjVTakLfTl7Ni267m1UmY1MCeZ9qdRn5cftpwnMkwM1W7lLQUI3W0EPC0b9mONenYvP0xowlCBVVtCY3V5mB1cKqagy8YdRPD+pYsWAbeSJRcUdwdsa/PPyp1AtnhVjRvjRvjL/nYu8ySsCnUVR/PomoUM5dW8e4gNx7oZHCylVFsaCvpC9c7pA/Md5SeeCsLaqvzmIiFLbQeSBGSfNdQTybSbSbHiN39ZYoUYvNgIPC4DuQYwHNzGLkxh9E8bMzx9KGJ1bUCdCUJHz1wm0ClXoykhyAEQo4cDz7V7u4QjrtPoVBWIcad8LegGUgHMK1XWMExb1ry7ei9dh+qhOAZhl5ADq1Ur1SdjKDJV+XLr+XKvFF3tjYJPKauqpT3sAB6BhAD6I
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(6133799003)(4143699003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UmQrZmNvdU40Ry9GUHgwVGdFdjk3QWRvaXcrYTQweHZ1eDZvbzZUZGVGSjJW?=
 =?utf-8?B?NXM0aXpZUm8wc0RTbHRMR2lWVUt6M2NJWFRHZVMrMEZtcUlHMUhQeWV4aE9D?=
 =?utf-8?B?NElEZXhQaG5qYlRPRkZwTEZHR0pyWGVLeFRxWVlMNkIyUkJON3lTa1JydnZH?=
 =?utf-8?B?bVVMZXJ0L3d1dy8zRUJIVk5xV3ZSb29UR1k2T3lGMlRYR1lwRG1hVlRPNFoy?=
 =?utf-8?B?eDZrcktQOEtxbTBvcFVDMTVtVmdLUDIxcWNuY0hrYVFoY0FpZlpTQTJ2VHRv?=
 =?utf-8?B?eWI0M1Z4RmpxV3ZYcHhGNUYxUTE5YmxVNjlicjVlT0hGMlBiVGFCK0VQRkJ3?=
 =?utf-8?B?NEZSbXlLL2dYa0ovcTU5d29iOWNONENETysrTG40bkNsaWxjVTZnNVh1ZGR2?=
 =?utf-8?B?SngyYVNMbVZxajk0M0dBZjlnVDlIMjkrVDV1bXNlSGg0ckdjSUwrWnBkeXRE?=
 =?utf-8?B?aVI4VjYrTkkxMGFNNkE5bHk3MEZXMitrSmIvd0I2ZHBOZ0c2bHYxUVB1M1Ax?=
 =?utf-8?B?bnlGeXY4QklRVk5WVDRYK2F4aitnM2RjeFlSSVgzZDBmWjZqbWFUMlNhV0lN?=
 =?utf-8?B?YXdLNlJFNkF2NDJmWHpGZWdzWmtPejRLTUN2ckZVYklQa0RzWDBiUFRkSmdi?=
 =?utf-8?B?Znk1amY5ZTJmWU9kQWFGbXgycGM1SURvU2s4Qk45d2dYWkVzemFQOU5yc0dw?=
 =?utf-8?B?Y1FvNis5WEZYV0VoNENVYklETy9xMngzTlpLVmpYYTVVaVU1YXJNS1F2cm43?=
 =?utf-8?B?VHNFZFRnSzRJSklqSUdjcCs0ZG1RakMyOHFrbVZ1akNhaUpZT1g1bHBQQnZr?=
 =?utf-8?B?WFhCMnJKZ25YM2lpT1hBRzBaaUFiMWIvK2s0NVNMc2xIM1IrdXVQVTJRL2s2?=
 =?utf-8?B?clhXMVcvaWdpeFhtODFXV1FWaS8rcDdJY2JQRG5GY1h4Q3E3VjUxV0ROblFX?=
 =?utf-8?B?ZFUxUWVIUHJDRENJSmVBS3NMU2NYUGp6cVljZ1o2VWpTV2NoQjZ6ajRaN2RO?=
 =?utf-8?B?OW90RGhNaWNOZXljYlUwcTBlNHNYdy9QOXZ0Y05ZZGkveEh6d2czalNGQi9s?=
 =?utf-8?B?VWROdHIrZHRFVDlVNWVGaDBqeERpcWUvdGxOanBpcHR0cktoMElEbTZpbDh4?=
 =?utf-8?B?OWRKMEllL0pkcXBnL0k2TkV5TlE0Tm8ybjAxbWxzSFM4QTZsZlJxa00vcm94?=
 =?utf-8?B?ampsVVJiK2J4eEkxejlmZyszZitvQThYekRBTEt3eDJ5Q29VTHBWSnBpd29h?=
 =?utf-8?B?dDhaK3ZTaXEzWkdzL0pCckJ3am05VnoxS2xaYysyeWlDVFB4YlVQTlVoMmlU?=
 =?utf-8?B?cTBUd1QyLzVRRWtVd1dOdkFjaHN3Rkgxa1VvU0R0OVR3ODZ4cm1lU2ZZYzZh?=
 =?utf-8?B?K3BRdEFGelZtdS9OQnNjZDcya1FsSERJT0tnbFl4Y2lldDBLbWdhbUJXYWZp?=
 =?utf-8?B?WXpZL2FkeDBUclhUaGxETkk4cGRYUkVucVBrWHRLWXo1N3BEVWl3czdjcjNm?=
 =?utf-8?B?SGRqbG4reGtPWUExZ1Y3Z3BqOVBPUnlUUWk1czhQbm9ob2U5T2FoQ1htNldE?=
 =?utf-8?B?RzdzcVZEeU10THRXTzZ0QXA0SGFnWFB4R0VRRjlxa25RazhpUEpYcWdIUnlT?=
 =?utf-8?B?RTVpc2ZpSE1ZaW1LK1ZUbjNYUVB3UVpqQWtJd1dhRWxzZDhoQTd2Z0JTaC9p?=
 =?utf-8?B?MUNFazdqSnd6cEtnSWJmcG5OQTl4YythSnZ3VktQUjE4cVJJcWUyREVubXZ3?=
 =?utf-8?B?NUNSeXdvWjdRMGVUZ1g2MkJ5SXRWZTIrU1hVeEJGaFBHWFVEcFdWbE9UcGRW?=
 =?utf-8?B?bG9JOUtzTnZGbzF4TVJLbkdQeHNOTGxJYmtYUXlzc0tFdDFFbDdMVnFxbUJa?=
 =?utf-8?B?Nm1CdHNmbHgzYWxMUHBVbzhYR0Y4VTNmc29kclJBdW9OZXh1ajZveEdvanoy?=
 =?utf-8?B?Y0ZWQjZkZEw0SVdGNi9adFVRcFlRWnY2eGZHTTdUelFWaVRBMmU5Y0tVYlBR?=
 =?utf-8?B?anpna29Xa1BSbEYxNjlmWC9OakdCbUdSNVdERTJNR1owVjRqK2lyNTB2bWRm?=
 =?utf-8?B?ekVydTBKL1lHSGV4SmtjSVdka0RxNk1aRGhIMCs1RUxSeWsvVE9LL09lZzBl?=
 =?utf-8?B?T25odmpUa3NqdmJBV2tRNHp0eUFuZEZmTlFESlViUzRaSXk0WmVDdjdmbXdU?=
 =?utf-8?B?TmlVV2w2b1JtL0xMYUZqWnRpcFFBVkFmdWRpdnlqNVF6eXdGZE16OWRpakRo?=
 =?utf-8?B?N3JRWmtxUmlqSUJqdTN1dUVJZFphZDMyVE52WlB5dzRtQ3VnUW5EVGFIMklF?=
 =?utf-8?Q?HJh32QMTiaYzhsVPZe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35ccbecb-94fa-46f8-5bf9-08debd083e2f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 22:27:03.5533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cP6Z997PBSRebNPtVRJXHMIvjDNUBBa+1SThvdXbRh+HorktDUMCuxn8imrFCDmC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7626

Hi Jonathan,

On 28/05/2026 14:05, Jonathan Cameron wrote:
> 
> 
> On Wed, 27 May 2026 12:42:11 +0100
> Salih Erim <salih.erim@amd.com> wrote:
> 
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
>>
>> Signed-off-by: Salih Erim <salih.erim@amd.com>
> Really minor stuff from a reread

Thanks for all reviews, it has been really teachful every time.

> 
>> +static int sysmon_osr_write(struct sysmon *sysmon, int channel_type, int val)
>> +{
>> +     /*
>> +      * HW register encoding is sample_count / 2:
>> +      * 0=none, 1=2x, 2=4x, 4=8x, 8=16x (not log2-based).
>> +      */
>> +     int hw_val = val >> 1;
>> +     int ret;
>> +
>> +     if (channel_type == IIO_TEMP) {
>> +             ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
>> +                                     SYSMON_TEMP_SAT_CONFIG_MASK,
>> +                                     FIELD_PREP(SYSMON_TEMP_SAT_CONFIG_MASK,
>> +                                                hw_val));
>> +             if (ret)
>> +                     return ret;
> blank line

Accepted.

>> +             ret = sysmon_set_avg_enable(sysmon, SYSMON_TEMP_EN_AVG_BASE,
>> +                                         SYSMON_TEMP_EN_AVG_COUNT,
>> +                                         hw_val ? ~0U : 0);
>> +             if (ret)
>> +                     return ret;
>                  return sysmon_set...

Accepted. Will return directly.

> 
>> +     } else if (channel_type == IIO_VOLTAGE) {
> Won't need the else if returned already.

Accepted.

>> +             ret = regmap_update_bits(sysmon->regmap, SYSMON_CONFIG,
>> +                                     SYSMON_SUPPLY_CONFIG_MASK,
>> +                                     FIELD_PREP(SYSMON_SUPPLY_CONFIG_MASK,
>> +                                                hw_val));
>> +             if (ret)
>> +                     return ret;
> blank line

Accepted.

>> +             ret = sysmon_set_avg_enable(sysmon, SYSMON_SUPPLY_EN_AVG_BASE,
>> +                                         SYSMON_SUPPLY_EN_AVG_COUNT,
>> +                                         hw_val ? ~0U : 0);
>> +             if (ret)
>> +                     return ret;
>                  return sysmon_set...

Accepted.

> 
>> +     } else {
> No else needed here either

Accepted.

> 
>> +             return -EINVAL;
>> +     }
>> +
>> +     return 0
> And this isn't needed at all.

Accepted.

> 
>> +}
> 
>> diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
>> index a78362f95e6..cf69be62709 100644
>> --- a/drivers/iio/adc/versal-sysmon.h
>> +++ b/drivers/iio/adc/versal-sysmon.h
>> @@ -25,11 +25,13 @@ struct regmap;
>>   #define SYSMON_IMR                   0x0048
>>   #define SYSMON_IER                   0x004C
>>   #define SYSMON_IDR                   0x0050
>> +#define SYSMON_CONFIG                        0x0100
>>   #define SYSMON_TEMP_MAX                      0x1030
>>   #define SYSMON_TEMP_MIN                      0x1034
>>   #define SYSMON_SUPPLY_BASE           0x1040
>>   #define SYSMON_ALARM_FLAG            0x1018
>>   #define SYSMON_ALARM_REG             0x1940
>> +#define SYSMON_SUPPLY_EN_AVG_BASE    0x1958
>>   #define SYSMON_TEMP_TH_LOW           0x1970
>>   #define SYSMON_TEMP_TH_UP            0x1974
>>   #define SYSMON_OT_TH_LOW             0x1978
>> @@ -41,6 +43,7 @@ struct regmap;
>>   #define SYSMON_TEMP_MAX_MAX          0x1F90
>>   #define SYSMON_STATUS_RESET          0x1F94
>>   #define SYSMON_TEMP_SAT_BASE         0x1FAC
>> +#define SYSMON_TEMP_EN_AVG_BASE              0x24B4
>>   #define SYSMON_MAX_REG                       0x24C0
>>
>>   /* NPI unlock value written to SYSMON_NPI_LOCK */
>> @@ -57,6 +60,16 @@ struct regmap;
>>   /* ISR/IMR temperature and OT alarm mask (bits 9:8) */
>>   #define SYSMON_TEMP_INTR_MASK                GENMASK(9, 8)
>>
>> +/* Config register: supply oversampling field (bits 17:14) */
>> +#define SYSMON_SUPPLY_CONFIG_MASK    GENMASK(17, 14)
>> +
>> +/* Config register: temp satellite oversampling field (bits 27:24) */
> 
> I missed this before, but given the GENMASK just below the bits part
> of these comments is pointles. Drop it.
> 
> Ideally also name them in a way that makes it clear what register
> they are fields of.

Accepted. Will drop the "bits X:Y" comments and rename to
make the register association clear.

All items will be addressed in v4.

Salih

> 
>> +#define SYSMON_TEMP_SAT_CONFIG_MASK  GENMASK(27, 24)
> 
> 

