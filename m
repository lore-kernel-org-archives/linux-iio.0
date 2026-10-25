Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.23
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792967210;
	b=3ZnvZwWqyzMNhXOYXtr7665m2U1cu6Ysec5ypPqONeEUICITyBka1DBFhCu279ckyl8x
	 EdwkfOV6FHxvsIlobT/JXod4D5mRNNxy+u7RpB/EcG5AppCajd9J6+nHvxBpSw74WAx9b
	 ROfaTTPiMJrj7d2nG0QjL+0nStVqj7sLj+GkkXX/Whr4uBg0mEhq/iPWPyrTGB441M0Qn
	 pNJDoJOW/2Ger9WMzcNeNRHJ6Rz+6foOT4VxPm5hEYcppLJgz4QbUN11vyspCBARM+gKa
	 L9ld+Lg2N/W4bz/c8yKNxn2X4jr96x/KF2VaHSRcv8LmWH1XbdOihZyOKOJPcwJGGjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792967210;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy:
	 X-Microsoft-Original-Message-ID:MIME-Version:
	 X-MS-Exchange-MessageSentRepresentingType:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=8nQNhfGjtopR/qxs367dp3C2W2YthE7kRwnNGZ7dBnI=;
	b=kqE8dQXg88VT+S5/8HAjOpHto8980ySqkNCNfYr3XtR+jbGpW2QBRB8kCiT2ZE4UoXgj
	 CoFhkjlAqeM684BxdQtQPwsf0iuU3adlm/wkYY65/lFsp+hNhq8e4Lor74oCb9uqLJmSh
	 hMX7Py1tAFgnR0Q8OTGLTVBf4Z+TmTk4Lhlg+jI1FalFu3dN2xQANTuAAQb2gYty+gP2m
	 LeOFFKJg84B7ADN/KXwuoo0ZF+0W5yVNEBLLbE4xtDkGlsa5Te1ytJwW6BVo5TabD0Fqo
	 szSlFgOMfhHwu7tRPyawzuSHFeMTV54vedvxE4Y/7z/GzZW5oHgBqvnTU8yn7/MHcyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=AjvS6QLl;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.12.23
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azolkn19010023.outbound.protection.outlook.com [52.103.12.23])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D1606A31A;
	Sun, 25 Oct 2026 22:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A5D1606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=AjvS6QLl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsXDTi/rzKne1AJe8xV0ytgeUROTX0DXkfbBMGV3qoEpmnTBT9EjWxlphZ4InJbDcW5QVbP2kmT9EB/tj3FwbyWb6IcfmipJqIfnasF8t2znbyDvtTHuwBpcQ1owdYPtQP3564H7W1u40Lic9VDODbTQvWXur6A9jSf0KjUT4DyhKNAX3dqw/J1HPLjJA9VQRGLDbbnv3fD4goNUSuh8XRZQqoeoH+rhVQn9Ur0RuQSHKXxDbO3ylD+K1J0StpyYYA9Doqx3bHPJ2dpD8cSCO53ZzzZolOLwDObZD9uEtGMSXZS/jgX34zJ6buhQFKPjmOqsC4Fb/IrFq5voJmpNxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nQNhfGjtopR/qxs367dp3C2W2YthE7kRwnNGZ7dBnI=;
 b=xuSXo6bMxwjbEP2DEtEcQcDq9md5VXtv0t3wQI622lgLk2xYVu5UDU9ev+7tyBiuz88Z25bPMEj7mxcxYiFl3Rs8kE10Pw/fVyB0UNSIfXhQSmXOM+jUoFVdbYx/vuIz1F2+vcNDJ9IqzXbbqb9i30kcVfL3kBUMk8AtN5HTfuM9YPfMc/0TkUBtDEKBRz7ZrsIKcMVixm3AQtzATDTgjbQInS4i2WFxzamhcIb3bedPcbSfRiJlLnXvyC72FHZsvBweX/90xSHL2LLYlOlvcOa5nfrjDrYvJVGTWam1P5iv1U/YmdfTxd04Ncrl3u02L9Opmmn4hFjVsZKvvjMPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nQNhfGjtopR/qxs367dp3C2W2YthE7kRwnNGZ7dBnI=;
 b=AjvS6QLlMQd0/YTC8GUjXhumjuDGyjZ91ilu92Npr0J/7Dq9F5AsxehxYsDimD5wjfwyH9updLTjc6T77FEWg82NX3DTC5wUuLh94HDdXUqRJHsoQ8K1p95UT6aKCSWKw1P+cFOzoUYV2zNvr2IfrFQsDDpJS5of8O6VWNJmZkhtG4ml9+d8XCJyRJBC2qnPGmR+NPkVtuRb8IeMXFbxJx2RnKq9+cmyDDsuya/bNpPr+rRZiH1AuDksFYTUOafVSYmFJhc79lHp2Rkvi214qAbBA5S3Y6BC/EC78HmkPgVW6VfZ0wCbnbkXtj81IGOzeVuvd5SvON6NlQVoG6BM4g==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by CH3PR12MB7498.namprd12.prod.outlook.com (2603:10b6:610:143::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Sun, 25 Oct
 2026 22:26:47 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0546.021; Sun, 25 Oct 2026
 22:26:47 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: andriy.shevchenko@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com
Subject: Re: [PATCH v2 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Date: Sun, 25 Oct 2026 17:26:37 -0500
Message-ID:
 <SN1PR12MB252873B804429C58E090C563A5622@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <at5qzj89R8W4K5Zc@ashevche-desk.local>
References: <at5qzj89R8W4K5Zc@ashevche-desk.local>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR13CA0056.namprd13.prod.outlook.com
 (2603:10b6:610:b2::31) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261025222637.63425-1-chernyakin.victor.j@outlook.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|CH3PR12MB7498:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bc05da2-aaac-47df-d6a2-08df32e70e55
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|260925184616899003|19110799012|24021099003|8060799015|41001999006|25010399006|4140399003|20031999006|24121999003|39105399006|22091999003|24071999003|15080799012|23021999003|5072599009|40105399003|26121999007|261007181701699018|261005200801699003|11120399003|3412199025|440099028|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?blLAhJtSOgjIOHCyg5fCnHrTwqgp4iR2/blca/MHkwKvfkmJc1FwX4vMKnP/?=
 =?us-ascii?Q?kifYHpROa6gAopf6vQtWhwdNEb24CH/pLnEs3Gkr2R6fhMdGLewWJec9GxbA?=
 =?us-ascii?Q?J8aQJxeAKIW9bXvAF4vN6dnByHFBrSnpz1shu+17QZ2rY10CDIcjXh3KjdUg?=
 =?us-ascii?Q?qOsGUTQ/+SgOwe1gTvEl2Na4+FF38EEzcPwv3uhv/lm3wiX8weUwslJ3aYbC?=
 =?us-ascii?Q?hz8MW0y4OxEIG+Fy7qMFi2jztZSM+8ZPeB1HLMxTjlP5lJCKKUTh15JpeTvZ?=
 =?us-ascii?Q?DA1R7uax0OFOAJgF9AYasd/6SPjZug8mtQ+tnZHd+AnnPTrfHNBlVRnTho3H?=
 =?us-ascii?Q?3NRGQdTFf6Lu3wRTNWAcxi25b78eonz8HKD0XORG+PPJtGFMpAdY5BV7jP+o?=
 =?us-ascii?Q?OhSy08F+DMXlVlomiXCc03KBgEz1EX+zIb1/WscuyrD0tWSfrrKFySjekgV7?=
 =?us-ascii?Q?8vIcFcGYgFS+r9xlIL7e7cLS9K+8s6MUb9BQfqOFOBKWIK20UDW1WMU0R6RM?=
 =?us-ascii?Q?lc0+N17phtixckTXU9MOAzSNBmOYe9MctlsNBBCv3gOuTOxmy9rtvBtizEs8?=
 =?us-ascii?Q?brfZESwUShsVCAuq5YslWzEwPxKlcpiHhAfLFUG/eaEOrQYjEWgccAR83C1A?=
 =?us-ascii?Q?XoLcQ/2kHhjR9KrTzox7lMh/mpYOjMm2oBR0BrTmpm1mWe6+yzHYdkI6YRw+?=
 =?us-ascii?Q?ZNPDnJFg6wa1xlSYQOEi1pF57j2ZCu5Mgxt6jagqBm/pLU6pnTy8wcqOONFv?=
 =?us-ascii?Q?m6K/uV9wU10AoyrOdil75XpDDctwGkURJLjuQClBoGGzV2Jx2iUJJWGMesj9?=
 =?us-ascii?Q?cI9R/Pie/RlzZInA7G9/we6Z+k73fgBanFo1DcLi/ZIHq52OnH5W+UP1K18R?=
 =?us-ascii?Q?VV3pLPZ1ekT1g1BlbdzU6WR7dnoi0Vv5ho651RCtKCy8EXnTOVn11x6Q9U3q?=
 =?us-ascii?Q?rWrY2tHB00+SWu0CS2QyGM+UnhzaXSREp0rmXXGLnu2580Zaf/ocRYbzM0UE?=
 =?us-ascii?Q?6+Z9+KPJzsz5cCy9bzrXiNN83JKmjnjnKOH8LxMKSfTaGp5iOUZ7k1phFgII?=
 =?us-ascii?Q?rcunLh58FmTjlqGSZMBp1cdq+Zek8iLIn8DCdmq7Bj+31dEOsib/Nt6NxTJX?=
 =?us-ascii?Q?T59yrE8i88/4BdFKpcRRv3frhDLYguiQM2955HQ3z8kg9ThruvsyScd/q/mk?=
 =?us-ascii?Q?pwRqzUn7BUmyQpy6Mln8+BVr/vus7LFyGS98wA=3D=3D?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qW0D8rK7E8V8Abh9SZm543xvzvOs6mEvmoXZMvHyA51CKmwAeIlUXYneOkWS?=
 =?us-ascii?Q?31so5i2hfcPpxcMK4rJ2xvxLM1rwY13ktV+gtv03ytZpu4xbcGpf6gkcw/I4?=
 =?us-ascii?Q?L0QK4iKK9GEiihbH5pkILEDPSxY7LsGER9iTxau/oCjR1An0LSvs59rNKqPB?=
 =?us-ascii?Q?9PPqn6fPIp75Gq6NeVutQABf/LMIs2z0QNSWKRn9FeLTvNSWuVzkyrId1RM6?=
 =?us-ascii?Q?KMfGl19Uiq9oCiDP44pFIO+EjOBHlmI/D5wQispVpJWG1TY1+FrSTwfLL4Gu?=
 =?us-ascii?Q?43PGahp9UP1+RsFsR0YmTRX4FCcwblbZ0tJ6JLXIvuPnpJoKCsger5ZkEP1R?=
 =?us-ascii?Q?qhWdv7FaMphehZE/JDNNx/OCjiguwAUfjUBdYhKybCQOMlb5JRnX7fPvkMgl?=
 =?us-ascii?Q?qIsJkJhGLOseciFvNUFj+PBFQWXn+BRZsKBYT++iqEItJHKmUro5Y/pPPkXJ?=
 =?us-ascii?Q?cZmLINM8n+1R/N1ocgcDOOAE/jHR9wH3hn6Dow+9F3U94Eftw6fNxGuev+o7?=
 =?us-ascii?Q?JmPqLPWfdCrzfsLVkGm9sDeYn5G/xtOL3wchSBEGoLP7iUNMiR7NI5qUrq7C?=
 =?us-ascii?Q?8qEAaGtI8t6eNRS9qKPHuOLjJCXdG4eIzAwPsIkhZdZw1RbIw2IJPPxJ/CMs?=
 =?us-ascii?Q?SDfa7SYqhzcZ8/y1oR5e/hATqiMb3a3QAZ6dZtTC7t3XlKjAPN7+mfgk+AgN?=
 =?us-ascii?Q?vF7i7wtL1NaNaXaUb//slMDyYN7FWEpCOQ7+z+6jLkrEi3cP0ZriCbpCKIpU?=
 =?us-ascii?Q?ZEGlv53HrpvuJd0UYhPGRxP9I3dR6Kpywq8lL4tUMaqXqk5kAm8Q1wsoXfcK?=
 =?us-ascii?Q?gZ+RsmiaaKpUl6aWMxdF3L11lN+lUHctxA516QIrBNPbyIJbZIjp9u7W0u0x?=
 =?us-ascii?Q?OKAOUzEuKdmEwaZYidMXhf5Fmwr1lt2pozsYXQl6HWsGsA5BNLAs/xqMf755?=
 =?us-ascii?Q?6NP//WSGHteVb1RAKQTd/dBK6gOzr/RMgsPaqE53bXlaoljqkzoeoOiQjKf8?=
 =?us-ascii?Q?32lg+p+JQPk3pL2V9x9wqs3QtZGdbBkcchtoprixsfqFg3Yq0Ao36Te9X+WQ?=
 =?us-ascii?Q?UCadohLjd0brIgzOWRvETAjojsG7jWf555tL5gy0I1FkAy941I8o6x4Da8+c?=
 =?us-ascii?Q?eYNaKR5HI3w3pzGBMSRZhRmy3bhkp6xWuUpA9cXZsRV3eabxrnPf8SpGRUTK?=
 =?us-ascii?Q?pZ6R0fBkvbZaxJW9RCQUZ//+Ay+KNY6V7ASfrtsusD2IiwShs/nmvBoWN76x?=
 =?us-ascii?Q?4gXno5EjBwrkklip149SAvl4a6MyMrF8+WSI5hNDfoqkIVtU1ckXPZMRCPpE?=
 =?us-ascii?Q?UkuPjHZVV0V443qZBpDtFz3OFCALqSV91z6RCDRvmbT3QxLwkm7hy1cmyjfM?=
 =?us-ascii?Q?kqjJgM/KGiWL9xMRtZhxmoRkk9qZC02U7uXd1LwCmtiqZoVRhw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bc05da2-aaac-47df-d6a2-08df32e70e55
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2026 22:26:47.2253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7498

Anything I don't reply to I've addressed for v3.

> > +/*
> > + * OFFSET_CAL_CINn: 16 bits, signed. Format: IIO_VAL_DECIMAL64_FEMTO.
> > + * 1 step = 1/(2^11) pF = 1/(1000 * 2^11) nF = 0.000000488281250 nF.
> > + */
> > +static const s64 fdc1004_calibbias[] = {
> > +	-0x8000 * 488281250UL, /* min */
> > +	+0x0001 * 488281250UL, /* step */
> > +	+0x7FFF * 488281250UL, /* max */
> > +};
> 
> Can you explain the negative capacitance meaning? Does it mean some vector
> (direction) in the physical world?

If a channel has a parasitic capacitance C, we can set a bias of -C to 
get rid of it.

> > +		/* The datasheet says to read MSB first, LSB second. */
> > +		ret = regmap_bulk_read(data->regmap, FDC1004_REG_MEASn_MSB(0),
> > +				       reg_vals, ARRAY_SIZE(reg_vals));
> > +		if (ret)
> > +			return ret;
> > +
> > +		*val = (sign_extend32(reg_vals[0], 15) << 8) | (reg_vals[1] >> 8);
> 
> So, why the value is not marked as __be32 with the respective conversion?

regmap gives us the two 16-bit registers in native CPU endianness. If the
CPU is little endian, that means the overall 32 bits aren't in
__be32 format (because the two bytes in each of the halves are swapped).

(Hopefully that makes sense? I'm not sure if I explained it poorly.)

> > +static const int fdc1004_calibbias_decomposed[] = {
> > +	lower_32_bits(fdc1004_calibbias[0]), upper_32_bits(fdc1004_calibbias[0]),
> > +	lower_32_bits(fdc1004_calibbias[1]), upper_32_bits(fdc1004_calibbias[1]),
> > +	lower_32_bits(fdc1004_calibbias[2]), upper_32_bits(fdc1004_calibbias[2]),
> > +};
> > +
> > +static const int fdc1004_calibscale_decomposed[] = {
> > +	lower_32_bits(fdc1004_calibscale[0]), upper_32_bits(fdc1004_calibscale[0]),
> > +	lower_32_bits(fdc1004_calibscale[1]), upper_32_bits(fdc1004_calibscale[1]),
> > +	lower_32_bits(fdc1004_calibscale[2]), upper_32_bits(fdc1004_calibscale[2]),
> > +};
> 
> Why do we need these tables while already having them just in different
> format? Perhaps you can always keep the decomposed variant and otherwise
> join them at run-time?

If we only have decomposed variants, the IIO_CHAN_INFO_CALIBBIAS
and IIO_CHAN_INFO_CALIBSCALE branches in fdc1004_write_raw would become
ugly and hard to read, e.g.:

    if (val64 < fdc1004_calibscale[0] || val64 > fdc1004_calibscale[2])
        return -EINVAL;

    return regmap_write(data->regmap,
                        FDC1004_REG_GAIN_CAL_CINn(chan->channel),
                        DIV_ROUND_CLOSEST(val64, fdc1004_calibscale[1]));

versus

    if (val64 < iio_val_s64_compose(fdc1004_calibscale[0], fdc1004_calibscale[1]) ||
        val64 > iio_val_s64_compose(fdc1004_calibscale[4], fdc1004_calibscale[5]))
        return -EINVAL;

    return regmap_write(data->regmap, FDC1004_REG_GAIN_CAL_CINn(chan->channel),
                        DIV_ROUND_CLOSEST(val64,
                                          iio_val_s64_compose(fdc1004_calibscale[2],
                                                              fdc1004_calibscale[3])));

