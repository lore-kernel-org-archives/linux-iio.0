Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11022136.outbound.protection.outlook.com [40.107.209.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19BAA2AD16;
	Mon, 29 Jun 2026 02:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782700395; cv=fail; b=MJtFn56AxCoZBcWH7bpoiJPt7MBXrWBdsZYrymVUW3Lc7c2NVSeGRJPFGXUXCxowAsafOp0HQn1IP6js1Z66PwJN2o0a9Fx0DmCji3LiL7CQP6WIXxa9Y3LZUHcWp2US/PjNTq22Xc3ZeU+QNXT0ZesbBW3furdd+u8EtweDwuw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782700395; c=relaxed/simple;
	bh=j1MY889VqHYWV4SLt9Lrbri4pMn3qiPikxszS7IDz7Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l/Bi/67VponSF3B9/jyo4s2NeNbOMxWxDw9ROq+ka34q5o6tNC/L/ry0wp6z96P6vBRQ1GaO0EorQniFfMw+aBE3bNRTmZK0rvZD4u9t0wfGylmKQyLe1T78x3mh2UClYcmyLRBBGuL4CXirpGzyFji+SZ1239wK8ojIcDR6evM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com; spf=pass smtp.mailfrom=axiado.com; dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b=IKlrQ1Hq; arc=fail smtp.client-ip=40.107.209.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axiado.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axiado.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=axiado.com header.i=@axiado.com header.b="IKlrQ1Hq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=syJ4z7TmpQVraZh6VlCuPebICa6OW5NP4MlnTQo6Sn15y7/9m88lkWPyBBxprTzfvltikpTM4I3KojXAExCB3l22niZHWaPegxSrQuBHWLZdBEiVScMmjjDq+Q8QBrF6hhPe/+qhjM7WipBSG73iQ36h/CIMMOk0S523ME1D83u7uC8m2W83abL6rt2cyUCivYPD6SPDHWHjZNPTQvn+yKdVjY+zcFjyY/tDpp67UC5Ic0lAxgqXmFVO5edmMV1w3vL2ZSl1v4VEmMzKUFlfmYPnePf/9FWP5TXgvyFCP4maJaPjRQ3l5id1sXPRqo9X8pmUbgqt7NqN5gubi5sLzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dacamVFvYbmUXcOTJC81AWlVcR/x9NLV8/LgoViUUgo=;
 b=PO7GSlDxnLP5auqf13b87GqsC9e1r+XKegNKowxZcNxdR80hKMcMO8hh9OJRuHOtqEJHHVD/jAhX+WTb3yKAewFX8TKW8GpT5Ahd+LQ9gvIM5aVXDkUBtLDOaVRUWm+RTDPt6S8HpzGjsZ68bnk1ZFXsZQiKChN5r6iEJd8Hy+47wVRCBrkNYDPDd5o8NavJ7erpFYRL0/TePZA+tnDfzUbrfe3ioEbIKgy+bYx5/GngGPwM5Vnf+El03Ut+9TKO6UOnc1w4XsQbc7u2yYldC/gZOG/AZDSyo7+Qc/nEYMuhnUka17mUCAFDOllXrxQ5a6+1rMRwYZ61UKFPR1ZcIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axiado.com; dmarc=pass action=none header.from=axiado.com;
 dkim=pass header.d=axiado.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axiado.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dacamVFvYbmUXcOTJC81AWlVcR/x9NLV8/LgoViUUgo=;
 b=IKlrQ1Hq+FzB3Fh3mTU2037TkMZ8FkZmNuW0AxNLgvOQFMXuBeDvbvtKEzh5+xV9gFH0lPS8YwfwrWkHAAF6Q+3He0zgNfHTZd4y4nMOP3UtYY0F7PkBQr5djfXuEtDGlbx9ZPLXa9Xecs4hKbsmQeYoGThfJdR4YdGINAbi0NSxoaevwGSlRY2Z2+BthLn55ietPKbuSvAXK8Yloe37EfmmEIxMkiz8idp4ZPw6nm5tUCqK+yOFYXTD9nkD1HcLSB4HL7JR9wj04mVgkX1xFlktU0YDV9rkOCxMX/cuMtanslE1y9a0MKl9u9FktaziYzfo1tjsj47f9WDI60wl/g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axiado.com;
Received: from DM4PR18MB4144.namprd18.prod.outlook.com (2603:10b6:5:38b::8) by
 PH7PR18MB5131.namprd18.prod.outlook.com (2603:10b6:510:15a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 02:33:10 +0000
Received: from DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11]) by DM4PR18MB4144.namprd18.prod.outlook.com
 ([fe80::cb97:ca8a:e55a:b11%6]) with mapi id 15.21.0113.015; Mon, 29 Jun 2026
 02:33:10 +0000
Message-ID: <b06005e0-b7bc-4967-ac7b-cb170219f131@axiado.com>
Date: Mon, 29 Jun 2026 04:33:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: adc: add Axiado SARADC driver
To: David Lechner <dlechner@baylibre.com>, Akhila Kavi <akavi@axiado.com>,
 Prasad Bolisetty <pbolisetty@axiado.com>, Jonathan Cameron
 <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Harshit Shah <hshah@axiado.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260622-axiado-ax3000-ax3005-saradc-v3-0-e57c7c7ae675@axiado.com>
 <20260622-axiado-ax3000-ax3005-saradc-v3-2-e57c7c7ae675@axiado.com>
 <6770a7af-06cc-4240-9b20-c299e7080ab1@baylibre.com>
Content-Language: en-GB
From: Petar Stepanovic <pstepanovic@axiado.com>
In-Reply-To: <6770a7af-06cc-4240-9b20-c299e7080ab1@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JN3P275CA0155.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:cd::13)
 To DM4PR18MB4144.namprd18.prod.outlook.com (2603:10b6:5:38b::8)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR18MB4144:EE_|PH7PR18MB5131:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d71eafa-f638-4b29-7dfa-08ded586c299
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|22082099003|18002099003|4143699003|56012099006|921020;
X-Microsoft-Antispam-Message-Info:
	pH90/ORuCWepO/UHOEUmobNO4C+kRZOI6TlYmu7lAy7X4EI6HvN+M+lSwuabdzsjiOPAn0vRdcpstZxSZTw6SNOcRveScjT+jT5oyFtOFjAdvUadTbN8AR2nlk725srh+ll8Zcg7Q7gy/PKMyb6+bO+LxV59KvYwxohH17U4xjBQEbFRvrVlf3YOxJEfCnZe9uCM52gfeB3v9cY5rSaa9uuZ7BVkq1A/MfiP3f6q3ZAH/LF82MjxYJhSsM+CAfCRt8tYc9QkB1hregSG7Oa0anxHFifMkpBV01Rs0H7NDIIEsV6MIkVUkBF9XC1XQSqoM0xFWEzCYzCAngB1goIK9hmqkVzh6eLX2L4Zi1+WH7QEVea3N8tln9Ed84B93RalFIenXTsxhYgRRT0YOpdEapKBeAe6upaFR69FAdOoY4sqQI0DT5+IDV2pJC412YkPX8wHewyzR4+Yvuin2ZnBaTPqjDxW9E3OH8dPKlCHoHAf9iYX2BOaPJ2Nl5TRV0pUYv8gDLPM2CxM4KdVZU7lJmbrwAmsIRtrGf6mmbEfiGvw8LmoSF/+6y9h2mWnlE6TKxrMc1dK6Cq2zNI+BlECCCZfpOQb/H+fu8wyAMhOtOG3iA0HnJZLX3HtOM3dDRd/44Jy3MgXfFAmuv0vo5dHrRwNPB3Ft5oon0d72njWCO2ZhV2suosNsggQhbpZCcQppbt7TFCVoCfbrxuB7VDYqA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB4144.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(22082099003)(18002099003)(4143699003)(56012099006)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?d1RSaUQ5Smdjb0hzTFVXYjl0M1pERUhHSEVLbEVzN1BIaEJiM2JaVUE2YSta?=
 =?utf-8?B?K1BjUXA3WlphN0ljeTFuQllRYkxROGxsM09IWFZzVk0rRmpFcDhlUkJXRTFa?=
 =?utf-8?B?clF1d0p3WnRqbWlYNnpDYWlRUHRTM1NPZXlNTWlseGpaVHFyT1JxLzdCY3I0?=
 =?utf-8?B?aWhzU0FyOVN5YWMxLzdXeTZoclpOZHFibjMzd1NXQWlQYkZmV3pjWkhYL0x6?=
 =?utf-8?B?dG5PSVdnTU95bGpPZSt1ZWNUQWRxUFBmY1laeVM0eGFBQTJ4YVI1dnFzdHhm?=
 =?utf-8?B?MGpHeVlJSXlNcTdHVms1UndxdDEvOSt4M2prbDZxd3E3OWxaS2tRZEhLaEhV?=
 =?utf-8?B?aHg5bkNVaHVteWpwd0ZyRTFnMDhkQVl1OXl0aXlIZzRLQnZtYnhyaW1DVnRJ?=
 =?utf-8?B?ZjRBdkJjcERXVnVMNXR4OVJBQ1Y3QVZUTzBsNzNzMXVGTDhWQUx0QU16L0R0?=
 =?utf-8?B?Um9KUDFJdFpZQWVBWE1Ba0JkUFN0Rk1yTmVrS1g3Zi83TjFYYmpISEY4b25U?=
 =?utf-8?B?RVFRMEdlSzBHNm15YzZlV2FNQTlxWVBJeURGNmpLZDU3MFVzL2FVdFNBa1Nr?=
 =?utf-8?B?bVlKQXVUc0lkQVNhamlBOUwvemZqRzVEbFMyWWNqREhINitMekdqaHNpc3dz?=
 =?utf-8?B?eEFKakZnUHJ5WnRiNXpncTZ4ODF2UnY1Y283UllDMmJreHFIUU5Jc0xhWGFp?=
 =?utf-8?B?TndVVGY0NElZUnpFUVo2a21VRmZyTGo3OWV6cy9EeEpFbVg1UmQwZkhGU3Rs?=
 =?utf-8?B?a0tSRTFHK2pUd3lXdUF6NmFzaS9vNEcrLzF1b3RnQWtFTGlyeWJuWlUxaHpT?=
 =?utf-8?B?WnBRQTdxdlRqM29LazkrK3FYQXpDZGxnMCs4aUZkTlNJMG1HdEdPRVB2V0k5?=
 =?utf-8?B?Q0RnL1BiLzVvT1dCZjB3a2ZzN2wxYVptZ3JqbTRicUNoaHM3ZkhCOE00U09u?=
 =?utf-8?B?VXV4NjZUR29yNXp6RDF6dVoxd0U0eDNxcFBIZE9nZVBjcmxnZ3RsNEZUNmtJ?=
 =?utf-8?B?SFZkaC9JQ0VWd0FDV3ArRFdjZ3F1aGxDZU5nZTUzMjdabHg5YlRqYXBVS0Fs?=
 =?utf-8?B?dVFjQXVwZnBwbWJsYWF1WG0va0ZzZXlyS0lrako1dEJIdUJYdFRueFA2YzJs?=
 =?utf-8?B?Q21Bd0dwdFlRc3VhN1ZlRlZvejM5dmpiYTlGL093TEordHJ2OVU2MVdVYkQw?=
 =?utf-8?B?eUVLNTliNkdFMlFmd0hYVEE0ako3RHVxTk0ranpPNnY0SEFwSTF4NnlodmRC?=
 =?utf-8?B?dWxjdXhIQzFqYXpseHVWVTk0c2ZzMFF4b0lFeGJxL1RXdzdKRVU2TmV2RXB0?=
 =?utf-8?B?T2NjOUJRY2hjbWhya3R5WXNsMHNRNnAvcHJpd1JMOWplRForbmdYQVQ1UzFr?=
 =?utf-8?B?VEZybkRKQmltV1dqTnVzenJzWWY5UGpIQUpGYWhwWHRvaTFtRmJ4aUVMeHpY?=
 =?utf-8?B?d2lwV1NyRGViWHptTmREcTNZdmViVWZOSnZtZVhUMFlMOUttWHhnS3E1Sjlk?=
 =?utf-8?B?aytWSXNFYUdPeWRjYkF1TmFBb1o2ODN2MjhjY1hxczZ6WUl5SjZtekEzTURV?=
 =?utf-8?B?WXcrb2lsSEdPT2hqd2ZxdmlUc2N4UVlnc2haL1k2WEh1V3pVUk1nMGU1QzhW?=
 =?utf-8?B?QURRMkJTMGVjYmdGMW5KaWliYzk4N1hBczhMWjFmZjNQZGxQWDJFcUtZVGhw?=
 =?utf-8?B?THliMEE3ak9jVjFmcDBPRWw0cjQzNUZWVnBGaGxsVWxMQ1RZYTEwZWlDb3Vn?=
 =?utf-8?B?S0NKQ0M2L2ExclZCYjZ2QVJzM3FuTzBITGUxOVpTNDNmSFEyUEdTQTBaSXJu?=
 =?utf-8?B?bVpGWG85UGxCekt5RUlpaG1RaWpIQ2R2M0lnR1ZPWWtQV0J2ZFQ2MUc0M1Bu?=
 =?utf-8?B?eVhwQ2w3R1M1cUlsTGtveGJpanFaTG1jNVRoYWJSbEpTNWlSM0o4NmUzL2xK?=
 =?utf-8?B?WFNlTTNJZUFyVkJqeFRsSlZBTTRxOU94eEl0WnRQckJZNGdoV2ZUalBaK2Ry?=
 =?utf-8?B?dW92R2x0RVErMGdSUmxDYm9pbys3eTNHeHBELytrY20yUUpNL2wrTkwwT29H?=
 =?utf-8?B?ek5ZSGpGSHZCbHdFQkNJbGkvcmV6U3RnQ1g2NnBlTDhwVnBJbkRMUkM5eTJ4?=
 =?utf-8?B?V0xTelNaVjQzMkJRNXBYd0Z0SFhLUU1jMEhaZkdzL1hNTmtvcVF4NXNlNFdB?=
 =?utf-8?B?enJHNzFFSVBNNVk1SDYyd1RpMFIwQ2JqTkNZbWl4M3V6SmU1LzIrcks1Z1Fx?=
 =?utf-8?B?eTVoK3Rjd0pldnJMRGRPbmVuOHN3cUV2Mmw2U1JyK2gzdVZMZzk5UzZsWm5D?=
 =?utf-8?B?c0pMV1lHY1pQS2V0aW9UZW5LL3NUb000ak1OMjE2SlRIN0hUeDZRQT09?=
X-OriginatorOrg: axiado.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d71eafa-f638-4b29-7dfa-08ded586c299
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB4144.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 02:33:10.3979
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: ff2db17c-4338-408e-9036-2dee8e3e17d7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lP92wH6/nRN/tE171MaZleKv+X5Wv70QuEbSWCpHGzYhVBOEMHSNTxEy+r0SzS+/O4aK62+SwRfqPJJrAISeuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5131


On 6/28/2026 1:07 AM, David Lechner wrote:
>> +#define AX_SARADC_CH(_index, _id)                                       \
>> +     {                                                               \
>> +             .type = IIO_VOLTAGE,                                    \
>> +             .indexed = 1,                                           \
>> +             .channel = (_index),                                    \
>> +             .info_mask_separate = BIT(IIO_CHAN_INFO_RAW),           \
>> +             .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),   \
>> +             .datasheet_name = (_id),                                \
> This could probably be:
>
>                 .datasheet_name = "adc" #_index,
>
> and avoid the need for _id.

Thanks for the review, David.
Yes, that makes sense. I will update this and remove the extra _id
argument.

>> +     }
>> +
>> +static const struct iio_chan_spec axiado_saradc_iio_channels[] = {
>> +     AX_SARADC_CH(0, "adc0"),   AX_SARADC_CH(1, "adc1"),
>> +     AX_SARADC_CH(2, "adc2"),   AX_SARADC_CH(3, "adc3"),
>> +     AX_SARADC_CH(4, "adc4"),   AX_SARADC_CH(5, "adc5"),
>> +     AX_SARADC_CH(6, "adc6"),   AX_SARADC_CH(7, "adc7"),
>> +     AX_SARADC_CH(8, "adc8"),   AX_SARADC_CH(9, "adc9"),
>> +     AX_SARADC_CH(10, "adc10"), AX_SARADC_CH(11, "adc11"),
>> +     AX_SARADC_CH(12, "adc12"), AX_SARADC_CH(13, "adc13"),
>> +     AX_SARADC_CH(14, "adc14"), AX_SARADC_CH(15, "adc15"),
> Two columns looks a bit odd.

I will also reformat the channel table to one entry per line.

>> +};
>> +
>> +static void axiado_saradc_disable(void *data)
>> +{
>> +     struct axiado_saradc *info = data;
>> +
>> +     writel(AX_SARADC_GLOBAL_CTRL_PD, info->regs + AX_SARADC_GLOBAL_CTRL_REG);
> People usual make read and write wrappers or use regmap to avoid having
> to write `info->regs + AX_SARADC_GLOBAL_CTRL_REG` so many times.

My understanding is that simple read/write wrappers are not always
preferred unless they provide additional value. Would switching the
driver to regmap be acceptable here to avoid repeating the base address
calculation?

Regards,
Petar

