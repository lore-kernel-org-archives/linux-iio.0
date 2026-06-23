Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11022096.outbound.protection.outlook.com [52.101.53.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6143CB919;
	Tue, 23 Jun 2026 08:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782203448; cv=fail; b=aWnl3PsZaXT4KxI6L7WsCXn7xc/jsjuI7WFAyDWc5R72C7RxJw4uj0WUPK0H3E5YpSRd377e8Gl6xZNpb520zit39z/9ji8gDOHhu7jBKaRmJJadN8NIOo/NWeTjw4bE2a1q0PBM14DIPxJJj/y4Gw0Sgy1ucMjGOstQx1vrJcs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782203448; c=relaxed/simple;
	bh=lvMu1Mc1EzZV0jSdlm+S6D+I11bVFM3H0aoS432UAV8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tVTdn2dgiDaBgvwF2ZlZJkVbjbsmqBb6b0IuX88PHqWEh8cytuWh4uLy6pESRIL7XLmd9/M1u/ZqZpLRtDMid0XpnsQkxglsVDNNLtzOF8eDqdx/cfl5Q6lmihimonSAJstKKFiSXPwZcjYkekhvJjBfeVZYh0DI3s3sISXVj2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=AlFbfmVW; arc=fail smtp.client-ip=52.101.53.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="AlFbfmVW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rwKAMy+kUDYFoyGJ7QbUiwqBhTRrGvsc4TIQdoR6PSYhLDixHE36taiqswB3cyk15TnHv3va9F5wbjU6oLwvHbLVlGjLpTxF89V6MmxyhSx7RA2FH5hLP3T9NPobavuqollixUh1ddnOFVquUPHQ9oSO6h4ow8YjHTRZKSWbcV4Cxm7SzbXoQEVNExZ7BJoOmNa3an4z/uuID4kDKdUWxJUKvipQ15UMWjt7lmzf0dw5sD7HhAt5Bc5qxJpd0xfgy9TL/Nl6KwE4UX8YPGrnu2R7h0rQdQr4fchIu46Mzy9Kima/kmEs0LMCrLsIWRtmCYUuBOLJutF4QG2K8WMvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nv3NplkJNFSckQXBlKvOwLN77y8GZNmrJXbvNmv+Bvc=;
 b=Cqy2ZOFor4EPG1EF1nOm72Ho1GfmNR8bgHOKyG5DYHMHTOV8LyINmLIYNhJcMoCc9C51/LMz1Sy5slKRMztIAvj1zXHG0dtF8qdaYUwKFlaXgSNLgPVTM2E76TlASwf80UD9/3pjA1Av2d38JhB+TcIDP/Wvo4YuXWSxim3/Nu8WuxonLdSGH8tjNRryzBEN3jbenZovfalp9RR86V40N5VQsaeFQStRni984TgelSPtW2MCEmew6nhs1sDWEB6uy9B5HXhvHEYIkekEvrLLiD+/rEqFLYPpOl4Ri7mi+oGeb9uUpAh5vp2vZZL9Xwv0+JqteE5owvkgKtrk3DJJuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nv3NplkJNFSckQXBlKvOwLN77y8GZNmrJXbvNmv+Bvc=;
 b=AlFbfmVWnxyBPgr2sm2S5khaOcnGi0RvPxFJjjNafclU/uCLshx8sGRX4ha7htXWqsBVTDXK3DTDowlKKlSfVe7XsvPY8zt1fnlYNppiYHJarm1KOlKKQpshiDgCZnLz+sGyCSjZYMrq47wtUCczqrgCKKZuvJcQHugCLQr4Ug9nwWhZIiPwQrj8zQZMP4r+4NRxE36dFkdHPyFh2k2Muip2b7X05b5Q0VNg06iDalxxJYKa8zPhbM2l2XUyhzJDL+sa7R3piNpvbLrYvmbk913OH7/LAZwhb5xrzQ/CL7q2X/8jI5YtQbXTO1EpeBtX8A1ZTIJtFWI2TObVl1CY+g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from DM4PR18MB4144.namprd18.prod.outlook.com (2603:10b6:5:38b::8) by
 PH0PR18MB4391.namprd18.prod.outlook.com (2603:10b6:510:49::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.20; Tue, 23 Jun 2026 08:30:43 +0000
Received: from DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11]) by DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11%6]) with mapi id 15.21.0113.015; Tue, 23 Jun 2026
 08:30:43 +0000
Message-ID: <5e84024c-041b-4e2b-9a91-6c0bb9fb3bb2@axiado.com>
Date: Tue, 23 Jun 2026 10:30:37 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: add Axiado SARADC driver
Content-Language: en-GB
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Akhila Kavi <akavi@axiado.com>, Prasad Bolisetty <pbolisetty@axiado.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260622-axiado-ax3000-ax3005-saradc-v3-0-e57c7c7ae675@axiado.com>
 <20260622-axiado-ax3000-ax3005-saradc-v3-2-e57c7c7ae675@axiado.com>
 <20260622115554.000036a9@gmail.com>
From: Petar Stepanovic <pstepanovic@axiado.com>
In-Reply-To: <20260622115554.000036a9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P189CA0055.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:20b:659::22) To DM4PR18MB4144.namprd18.prod.outlook.com
 (2603:10b6:5:38b::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR18MB4144:EE_|PH0PR18MB4391:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d6aeb24-05fd-4cc6-7016-08ded101b72c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|366016|376014|7416014|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	XwsrVoDiKwyYIIe7Hdj64URCuUDwveiJbkdHrPeZWu7L6AMibZysF2GhjVdK982iGoMLmSJxfcKWe7ftrijLCEkddwOu4vcVaF/4gUBsS8bYH20YEoTbQmPaUiuAz7PYRp4Q9YJmthLPfuGKwDIslxdrVFggGvcOHoJKENT+laoI/Hb2HzB0UX9blAvzu+I6ADk4gGKbzVwSThaO2DYIiNbUztquSPgX9QVsGM8j0s4T9Nw0V1JGZ86j+0gHskhoTueAkIkQBUPBhCWrMhXpU6tYTo5tcbUZ7V23hhtvPmuxZMQwEiq1s0wt8RbtF86fJZLWRa/4TENyv+r4h3n1OVbjeN74Mq0pob5h2En7Ap/XfaSzNLE5MuMywWfB8WTKST0dNIcs8QDhyU0K7BGxI8IEW9amkLvnNlZHySQqWcFcJQB6Vv2BdRQqQzEPdU+VrGBBKA0v4aadtImGO4pk2cqF2sBR1V92bYQ7/Bk58ymhelylMh/8mbzGbyaJalgmMlegPj1AAupnGZQm3AUzI3AbO5oKWS1fqgtxG4p+8gMeoC6xLWr1UDfmzHDFPk1+hMQ+jTodqJDs5aIVki3PfUyxWBi8ObPBJ8RyqH4vv5pXzdQvTzY9+CLSXKluGy7+pYqLGK08fcKD2M5s125BqD8iyZG95X+/gtSoQi0ZHwk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4144.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(7416014)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YnlWMU5SRGE4aEpXaXBCeWxQdnduWjZzTFBMaTkxODhlZ0tBOHJvWFN0MmEy?=
 =?utf-8?B?UFFMYjR5ei9oQkpQQTRiQWZTRndwVzhLRCs2L01KaW94YjYxa2VwcDliUHAz?=
 =?utf-8?B?b3d1REI0UHdJZnlyNUp6SWsrd3NEQmNCZWtaR0JpQzNtYXZCQXg1RzJtZldw?=
 =?utf-8?B?eVd2ejJ1R0ZOK1krT2hkQUdBQm01YTQ0cUNGbFFrMFVxU0diRENOMXdDeldC?=
 =?utf-8?B?RWg4ZEVhWmFDMFRXeGtkdEJJcHBVR3EyYTFFTHBNdWp4a1hMT3A2WW8vWTY0?=
 =?utf-8?B?WTJud1dvajdaSCtyTU5zRHpEajRlNFlYQlNFWDIvdFJ6QnFxSjBadUdXb1JE?=
 =?utf-8?B?d2hBK0ZSdnhkTnBYZmJwODl2eXYvR3JvcDcrbEZ1Z3NzcmFDRkJZaHprTDRB?=
 =?utf-8?B?R2Q1cTZnczZ5YzZrR1Zzb1RaczVSYnlQdUo5YXBjbzRJNzVJa0cxUlBWL1Nu?=
 =?utf-8?B?enV3SnJteGxmRkNsa2gzb3BmMWJtQjhWYU4xTkpCVGdlNEJnVXBYTjB0ckdB?=
 =?utf-8?B?UU1sbFdDWjNBNUxpM2QvWmRNcmRCcm1OTDVDUU41SmpIU1BiVEF3NkdGMGNB?=
 =?utf-8?B?NW9aWTJDcnFSZTY3Mjl0NC9XU1BFdUZMS0hGSkdMVzBQempKUC9rMjR4YXg5?=
 =?utf-8?B?Q1FkKzk2MWpiOHE5STFDMjRmZUUwU2xhY203VnhiMnNaK3JSYkFvT1NnVExp?=
 =?utf-8?B?OGwwY1FPc3I4SU9KWXY2RldKMnZiY25NbGJsaytGaHRFUDQ3alZFSCtmT3gr?=
 =?utf-8?B?MjV2RnRvRFV0K08zcUQyd05zWmZ1SjI0NVdSVGp3REVCbEQ0cDlrM0ZYRFJt?=
 =?utf-8?B?THRndGowM0RxTW5OREZWa2hQVXpiN2NGaWQvT3VySTc1Ni9NVUZ6YndwZUJs?=
 =?utf-8?B?MWFPazRITmRybmw3NGFCRTlZRCt5bmU4dFU4ckRxMG1RbXJCMFlQSy9HaVEz?=
 =?utf-8?B?MVZIakFvMzltSDJ5R2piWHkyMGowUWxSYnJyZXV5czVpYyszZUpWVWN2QSti?=
 =?utf-8?B?M3hEdzNtS3dQc0JCNEp3VnRCZkJaeW5PTU01VGExL1cyZko2b29HcEdDaHhK?=
 =?utf-8?B?K1JWNTJmZmxUZ1FtZEpqY3l3MHBZL1RpUEF0V3FySGVrWmQ1NnRWZ0F0MU9F?=
 =?utf-8?B?aHBRZUh3ZkdTYVFZV3NWL0E0ZGs3enUvOGNZV2JaTU1tRHFNcGRqS3k1QzYx?=
 =?utf-8?B?aEtSa3Bqb1VCNWQyUXpCVUUyczhoYUt4MDVadnpUM0wvSDNmT1p6VU91SlR4?=
 =?utf-8?B?MXIrdmY0WE5EdGJxTTR4dS9UOHBWNndpalViS3pkOGtnWXk5aUpQbnVVeTdC?=
 =?utf-8?B?REVTcitEMXZjaElyWE1iTEh2YXJ2c1ExMUVaa3BCWTlUclNPQXdkZDZpN240?=
 =?utf-8?B?Szh3UmhvWUdlUTdvSFo5REhJektiZ01TaUx0WlVCMjhZTGhDbVROR3JoaXUy?=
 =?utf-8?B?TkgyWDEzcnhvVEl6ZW9qZCtHUUlhSHcyZCtaSEFQb2liZ1h2WjJxYitnS3hm?=
 =?utf-8?B?NkNSUm5mRWgwZVRyc3BZNWY4bitZZTJHWFdUN1Bkb3lvT3UxcmZGR0VhM0V4?=
 =?utf-8?B?NW5aUmRTdW5MdEFPRGMzYWhNcWtTQVFMOTN2dk5nZm55NEk2ZzFISHZMNk5C?=
 =?utf-8?B?T0tlcFFiRWVUSnRUVis4RVFRcjNZTlFxVGV2dUE0eVFyTmx0SkVyQmVqelpm?=
 =?utf-8?B?VCtBamdkZ1hRVWlEa0J5bmZxelFBay9HQzBFNHkyVFNpUWsvdm1zOEJPb0Q0?=
 =?utf-8?B?YWF1MUhWaldnaS92ZWhlNnY0UXN6MnA2Y1JQYWVBVE1yMERUb1FGUHRwT0RX?=
 =?utf-8?B?endHMHpKOVQ2eVhiYkJLeG5mYVBvaWYvR3BMRlZSWGo2Mlk4QzB2RVFzaCsy?=
 =?utf-8?B?VEswcTZZbFo2cWVEbUU5Y1A1akUrcWxpZG9JTzBuT2htWGYyQTd4aWFqMnc0?=
 =?utf-8?B?ZmhqTGkweVQxN0R5SzJvajdMN3JTb0tnVUpubDM3RUkrVnFwb2FqSHNKKzQ1?=
 =?utf-8?B?YVk0TVk5amJ6em82aDJaNDBnNUFRS2FxUEx5VkJhTGVHRmZ4K3BKcTBRbmxC?=
 =?utf-8?B?cXdzb2NRbHprK04rTUFWMllMSTVLeU5XVjNGVmVISE1leEtaeXFGdUtvUWEv?=
 =?utf-8?B?cXoxNnJiTkhuTDhmS1lib3V6NEVuR1hrdC9SM25LMWNHZCtxS2liMkJPUGd5?=
 =?utf-8?B?a0tvQVFzZmZMUC9lbzFjWnVQNmNDMDR3Z25aUytvWGNxK2ZjRGtTdjNBVVo2?=
 =?utf-8?B?ZmUzYlJnTlQ3S0RLTkUySGI2L2Q2cmRFZnNlUFVNUzRSZXF1Ym9aZUF2bDR2?=
 =?utf-8?B?c0xNd3VHRjM2TDM0WlRNYnRtWHdvQWdjMVQ4V2c3NW1MTXBZYks4dz09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d6aeb24-05fd-4cc6-7016-08ded101b72c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4144.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 08:30:43.4038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyznyBP+jNBHvmvJuY43kqoYNgimi3nzhCSH6jJ5xDCRkta2OYooHU2AMhva6c/+0CcZBLVc7YzidWh7YX3B9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4391


On 6/22/2026 11:55 AM, Joshua Crofts wrote:
> CAUTION: This email originated from outside of the organization. Do not click links or open attachments unless you recognize the sender and know the content is safe.
>
>
> On Mon, 22 Jun 2026 00:47:28 -0700
> Petar Stepanovic <pstepanovic@axiado.com> wrote:
>
>> Add support for the SARADC controller found on Axiado AX3000 and
>> AX3005 SoCs.
>>
>> The driver supports single-shot voltage reads through the IIO
>> subsystem. The number of available input channels is selected from
>> the SoC match data, allowing AX3000 and AX3005 variants to use the
>> same driver.
>>
>> Signed-off-by: Petar Stepanovic <pstepanovic@axiado.com>
>> ---
>> +     info->clk_rate = clk_get_rate(info->clk);
>> +     if (!info->clk_rate)
>> +             return dev_err_probe(dev, -EINVAL, "invalid clock rate\n");
>> +
>> +     ret = devm_regulator_get_enable_read_voltage(dev, "vref");
>> +     if (ret < 0)
>> +             return dev_err_probe(dev, info->vref_uV,
>> +                                  "failed to get vref voltage\n");
> Sashiko raised an issue that I've missed on previous reads - why
> are you using info->vref_uV in dev_err_probe()? The info struct
> is not zeroed out on initialization, which means that dev_err_probe
> will return a different value each time when read_voltage() fails.
> It was designed to accept the retval from whatever function we're
> checking.

Thank you for catching this.
You are right, |dev_err_probe()| should use the return value from |devm_regulator_get_enable_read_voltage()|, not |info->vref_uV|.
I will fix this in the next version by passing |ret| to |dev_err_probe()| and assigning |info->vref_uV| only after the call succeeds.

Regards,
Petar


