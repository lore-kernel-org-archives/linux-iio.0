Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012034.outbound.protection.outlook.com [40.107.209.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F43B5DF9;
	Tue, 12 May 2026 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596463; cv=fail; b=Cb/9d2PRxW3omdwEL/1WCVJz0ohGHuHWRt3Fx+7LF1Dr9UmdY/B2u/eCJXas7mHwNpZZfoYiSNUq0zNiT2MHcyv/CPdYrWOXOCdKt6k/7unf3s1AZIj5pB6wD8xzqJXuaZWmnRnnxt2mil0GQ3PN8jJ2pLc+rA6S5U8EqS4n8oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596463; c=relaxed/simple;
	bh=lpjVyqsUJva7V3S4YEdSeSPb8zrQvrD600B6FFp1Dac=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uxszlf8ZhVCPHADl5sSIJNTrFM75g0HtKUs3+qBT/+VODPCJpepuukrd/63IDfIhBO/sbPKv4w4kJzXaR5Lh90reaHYnb4q7Bu+98MJzFLJ+OTG/Siuo9NIhjRaCYYBCGR6fZ3Jcx4XGfTGQJ84yWoWBBNpY5cpbS1pDOsI8tHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GYKfb85T; arc=fail smtp.client-ip=40.107.209.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GYKfb85T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gb5rZdJlTR51tzVmOXtkwHDaxJHxEc3kpVL5s2pQxM94XAPss7DlNb/GTRAom+FhO1+g1pByD6KMuRktlJeKRkEbmvTniWmGfLHQ1tIFTlQCsZT6mNBN07QL/37Bw6nri2q6SWf4y3eUO7Zqv5ZcNJmntuBRd1pas0rYvM0q8ZIGeyHDXWICychBlkKGgbaMtY1SPvtxHM0fIjVNTTpmKhh9GL6S+GB8XF2bYoP2BFTNppko1MuYowU++1S/okc++ETw2Wzc558FIAU0x4/uTPddnU64Mln2s9wAlhZyuLdGSUz9Y9ujThNa36zPAcUdCgc7uQH0IVaidwlsCrKthw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5tJ4DlWdWYbJgVru1dea+/ts/cXr3egAdHUOOsuBYM=;
 b=tPcswU0JeSeKKwD0clpeeqhTnj68HFxTC8iKPSyLTAGLFzVYcvtg4l2Wj6A8hPnBxbzf1XGOlHlAhssyR4K+X7MlHXxwGZBw0M7sGQzNOgM/mbCNChYlmUtsPP2E/yc2O7JErJZ21snLWKEIQRvZ/YFo7X5K5Jg4SMxFXLFJ+hp5kP9M2OqO2HohtCIfXBCdc/incutMp154sk6EAHm0MDBntgcnOyPSHyOzOVCx6oG4lwzTi7au3uEO/xqh0EB4pdOm0qVih3RC6mpCMSOP+Jvt+xoDeLBKK86ylej4lbhtHdxjLFzFpSgZIKFoxzspIewRVg031QBS2cLKeVBz6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5tJ4DlWdWYbJgVru1dea+/ts/cXr3egAdHUOOsuBYM=;
 b=GYKfb85TV7piXJM3NxbHjCiyZbREEnehGh+go0alev0DEa5sjN6UjF3g9OyL2ygZ2VxihxYjURm9IFlO22aYEKBIc/favJ6S8qLEZuMRf4qFYy/Gos8jNfl5ESyIG9SB10hDPOGfOR9AHwM3YLhg4Gx4jFgN0z1O5d3ht+nIKEU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB7736.namprd12.prod.outlook.com (2603:10b6:208:420::15)
 by MN0PR12MB5883.namprd12.prod.outlook.com (2603:10b6:208:37b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.23; Tue, 12 May
 2026 14:34:17 +0000
Received: from IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550]) by IA1PR12MB7736.namprd12.prod.outlook.com
 ([fe80::2274:9fed:8f3:8550%6]) with mapi id 15.20.9891.021; Tue, 12 May 2026
 14:34:17 +0000
Message-ID: <e84d98dd-c81c-418d-8cbe-5867f8bdd4c3@amd.com>
Date: Tue, 12 May 2026 15:34:13 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iio: adc: xilinx-ams: refactor alarm mapping to
 table-driven approach
To: Guilherme Ivo Bozi <guilherme.bozi@usp.br>,
 Conall O'Griofa <conall.ogriofa@amd.com>, Jonathan Cameron
 <jic23@kernel.org>, Michal Simek <michal.simek@amd.com>
Cc: David Lechner <dlechner@baylibre.com>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260414224245.8493-1-guilherme.bozi@usp.br>
 <20260414224245.8493-4-guilherme.bozi@usp.br>
Content-Language: en-US
From: Salih Erim <salih.erim@amd.com>
In-Reply-To: <20260414224245.8493-4-guilherme.bozi@usp.br>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0003.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::10) To IA1PR12MB7736.namprd12.prod.outlook.com
 (2603:10b6:208:420::15)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7736:EE_|MN0PR12MB5883:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c161b5e-4462-4e90-55de-08deb0338c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|11063799003|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	RqEI2gqDhw+jlS6avMkRVeYF4Kn8un+Ns92wRLAcdRRB9zfYZzBK0UOHd5F1XIPGPOIW1ar3Y4GBRfZHPus9hfVsGLotJnaUELtE7msLY5AKQ8CkqGcuAuqrw5jKY5TnPl2ZVYYBrDy3gdBBzRJny+LrNK6XpxJiooxz41TWAyF5n8e3v8Ya/OdiAShQKV00QpnAyh1uvpfnmQWeq4giThXxd3uiRplel3bFaRWHVHuagB0iyDw95uLYlXMrY17gL85XyAQI8xc/m8Xs1x3V0ddDD6GieFoPh6G6xNne1bxcAeScmQllCCv930S3YvKDmLtPhMDqxlFeY+WsBZcTowD8wRoyAS0zpNfnZ2sQmIqqyrqxLDKzyYMwpizWZQQKpAlmsv5NJboeGfUhEQ4OFr8sbVj3aMif80Yxl2sO1kcO1Ju+hs+qGAjzVUGpBi8pcuqwgVN7nkGzYOK2aue9Fo+9omfNa5KrnhrwG6cr6t/aZ/DqzSc1bd/o5UlhM/cu5j6ckIsmi5YiKQFjOWkfe0DMt6e3jYw7oLD0Xv49XOZ70EFeaaZ+8UnaGG3jJR5kkqJzaU4zjJoS0Uxj+DHYhy6jiPpBtwwH7fJ50Qgt39aS9/nrgv8YZyoV7ep3EbQ9SK9gCib/i0tLsXI/IPiT0mnMEIbCmKB2d6tp1GL03fn3Nvvy+xJxj6T7MlNaPGfH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7736.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(11063799003)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZXB4M1FKVk05V2t0Z3NZODNQVnVXYVl2NGxQcUtGaXY4M3dMeXBoSU5OclhT?=
 =?utf-8?B?VVI3bldQV2NXTXo1d2QrSG9MZE1BMW0wWm1DRnVzK1Y5eWhMMElpajlsUGE0?=
 =?utf-8?B?RURuUGl3d0ppNFJad1R5OUJvZFBXZVcybnk2ZXZSOFoyYlNMcTJWVjd6Q0Ev?=
 =?utf-8?B?TTE1Q0RMaVVRMEN0dWJBUm43MWEwa1RwdngxTldWcmpud3ExSUtZR2FOMVFi?=
 =?utf-8?B?aVMrRk1aUTZxY2padVFKZVgxUWR1NzNMV1AxWlpXMm10cmhmMFdNeUVrODRZ?=
 =?utf-8?B?a2R2eDdQOHlFVmVSRldTTXh0Y0dGZHhUN3daRG91ajV0bjhmUnA0RFZYemxJ?=
 =?utf-8?B?TkE3QXV0RVU0aGxYM1VsaGEyeHRpbWhaNFpzM015dlh6QlY2OXc0cEw3clls?=
 =?utf-8?B?akhJc3hwcG11TVZjbTBJS2s3VGx2Z3lnK2ZiTmZ3bm9GSGlsRklud29Pc0o0?=
 =?utf-8?B?SFlIZnJuTWd0bExILzhUZk14eVNjZnNBQ2x3V1VzQXBMQTl4VzNlakNSN0Y4?=
 =?utf-8?B?NDc0cTljOXNjMGxxMVk0bUU2cWluTlUvOFM2YVFvVDVxcFhIQmZVbStFRDFw?=
 =?utf-8?B?WGk5QmVoWFNvcEpPTmNUMU1VMGh4STBKNnN4Ykt1dGkvNVRRYVBjNk55MkM2?=
 =?utf-8?B?RGNUS3V6N1NGMlJxaWk2WWJ1bndSSDFzbWtRK2NWVXd4bjdDZ3l5ZzQ0UXJG?=
 =?utf-8?B?RUpVQ2luOFVnYmgyNDN5Y0tPSzdva0kwamxPeUlpN0lkVW9pZG15REpjcE1L?=
 =?utf-8?B?ajBSSXlPcEFYMytpK3ZSUDZXQzZ6bTFNUUYxckovdmdXY0gzMTd3RmdWbk5J?=
 =?utf-8?B?RzY0T05leUIxTzFWR0oxY3VacFlpZFpCOERIT2hGM2Z1R0FHVHNzUzh3VytD?=
 =?utf-8?B?M0FoUXE1ZlJBQjI0WVkrOG05eTdiM0VWZi9IVEVBSGpFZ1NKRUpvNFV6aGtS?=
 =?utf-8?B?aWFKaFB5MjZ6blpsQ2RlYi84YlZ1RXdXMW9RT29mR3pJRFduNFBlOVlqV1Vm?=
 =?utf-8?B?UUhqWGFNeUFMZUhLVXJFUldxSUZuNVpTQ0lwb0lwSHNDNEtpK1Vkb3dMdm4x?=
 =?utf-8?B?WHJhT2UzYVFDYSt3dkxMYTFRQ2l1TFRZSTl3amRUekdGaWZBaWpBZUxpOVo1?=
 =?utf-8?B?OTNkZDJWckJRTHE0dTJiTUdjM3lGQnFHTmhJSFhBZ1VialJzWDdVMms2ZnAw?=
 =?utf-8?B?MjZCZHZyR01YTE1aRnRieER1SWdESWdYTkhMTDF5TWY1QlZHSlFyd3llMkZQ?=
 =?utf-8?B?OXlZb2VUUHNaUlFWRDJIUkplVWlxTk84ZFkxTVNiMGp4dnM5eXpGemlGTnpa?=
 =?utf-8?B?UHpvMEZqQmJiZjhiV3FXNDY4bXRaUlFRYUhzTExsNzZZNHNvK2FKMFIzdFFT?=
 =?utf-8?B?enRwdlRlU2ptWW5mZitma3oyUzQvR0NvRytEQ1lJN3dNWWVyemZLb3l6cm1l?=
 =?utf-8?B?d1Fwbnp6d0tCWWowNUtNQk9PTU9vakVlYTJJcHRtT25CK0ZIMll3TjcrSFpt?=
 =?utf-8?B?b3dNeWUzQTg2VlA3MlpRVGFaam43b1BjbHRlWVNaYjFGVS9md3p0Vzc2QjJh?=
 =?utf-8?B?Z3lFN1FMQlk5bUlHdEVpWmtraDdHclRDeG9sbGc2UjRqUGtRcmlxR29Eamdk?=
 =?utf-8?B?TXRPQWU1SmFRNmgrMFZNM3hWWUFlSVlBc1FtZURpMEkzMy9namhFSlpZSUdO?=
 =?utf-8?B?OWtwd0tUeUk3Sk9nVW9OUTBtOVV4YmVnYzBTNzhla1RLT3puY00wT05LcXJh?=
 =?utf-8?B?Ri8wR21XeVVnWENjclZKb1FOMjJubjduL3F3RHZoSUdjLzkwa3Q1eGgwOURO?=
 =?utf-8?B?bDBWLzFYaGlKOWY4alc3YU5sRlBQNGlOSE1ueFgrOWRwUUxmZlpKSW5mVFVB?=
 =?utf-8?B?UnA3Nm5TQXRoc3BSeUs0OGNlK0lrdml1NmhDVWN4WTFmYlZQVUFVK3lxeFBY?=
 =?utf-8?B?U054K0FhUkFxejBKSnB3V2hJYTc1TGZSWUVHakJXV3BGWDhZQzNNNUpTejdN?=
 =?utf-8?B?ak9oeDYwakdsVlUzTGZDNmZGeG1WL3RiQWJocDVqN3JaV1B6VmdpbkxTOTdo?=
 =?utf-8?B?SWhLMDNsWmpVckJtYi9ISHVwOWRNWE1VWDZJUEpMMHYxcjFpNkEyNEljaTRI?=
 =?utf-8?B?Kzc4U3BQVU0zNTJKNVJJUURhTHk2eE12OHZIeU00WENDbWVoZ211Qk8yM3RE?=
 =?utf-8?B?Ny9RNjFJMjN0Z3JsbjZkOHhXOVVUN2YySjlGRHFjMkpYZWtXTXZOQ2pWVkNz?=
 =?utf-8?B?RktOdXpIVnowcHl4VWJWK1ZBNEFvdTZLb1BuaWpGclF6b2F1ZjF0OEkzSlJS?=
 =?utf-8?Q?cRgkVpFuYZI2ZAuaoa?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c161b5e-4462-4e90-55de-08deb0338c0f
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7736.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 14:34:17.6377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ois2OXuTOR8SUBqqb2EhYqExaIOIefcv5XruAVImbzr5dxos2Xbk8HhjdVuNhz3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5883

Hi,

On 4/14/2026 11:40 PM, Guilherme Ivo Bozi wrote:
> Replace multiple open-coded switch statements that map between
> scan_index, alarm bits, and register offsets with a centralized
> table-driven approach.
> 
> Introduce a struct-based alarm_map to describe the relationship
> between scan indices and alarm offsets, and add a helper to
> translate scan_index to event IDs. This removes duplicated logic
> across ams_get_alarm_offset(), ams_event_to_channel(), and
> ams_get_alarm_mask().
> 
> The new approach improves maintainability, reduces code size,
> and makes it easier to extend or modify alarm mappings in the
> future, while preserving existing behavior.
> 
> Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
> ---
>   drivers/iio/adc/xilinx-ams.c | 161 +++++++++++++----------------------
>   1 file changed, 58 insertions(+), 103 deletions(-)

Two issues:

1) Same tabs-vs-spaces indentation problem as patches 1 and 2.

2) In ams_event_to_channel():

> +       if (event < 0 || event >= ARRAY_SIZE(alarm_map))
> +               return NULL;

The 'event' parameter is u32, so 'event < 0' is always false.
Either drop the < 0 check or change the parameter type to int
if you intend to handle negative values.

Salih
