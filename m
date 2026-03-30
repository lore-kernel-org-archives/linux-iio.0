Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11021123.outbound.protection.outlook.com [40.107.130.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2825A3C344D;
	Mon, 30 Mar 2026 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774872152; cv=fail; b=oKVpHJH2rydLqMzEp3uxdVyFo6KWdnIPYV+zFQBT97P/UeyfumiZJ3N4jISy402B/58kOQqZfTklHn8ajhlLbLGaJRgVDpCiB7tHdCtwMQ/YO2X2ufO/+N+VIfJMIKp/FfYcfJeOpmgFTs2uD5aQqvgmMJwZPJE2AAV08nzxLqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774872152; c=relaxed/simple;
	bh=xMJoVFGWbuZMxs9t04DXpXO4Zuypvi8nUv+eDCupBFc=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eCm6xC5sf4RRnyBn2yenHXVeBknR3dDfoG8C3DKNEPQNyBu/oFUFXgaqVbL1fcI+IyVd9/HoFsz7AMqv1lcUMv8fK3t/WHXvX5UgR5wKvB3fNer3pQ0QmjNlXbX79V3HfRs53dJYY4NKT8TEB7Vk+FAowKBjABVY0dniD/o3qUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com; spf=pass smtp.mailfrom=vaisala.com; dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b=ytGzpRiZ; arc=fail smtp.client-ip=40.107.130.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vaisala.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vaisala.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vaisala.com header.i=@vaisala.com header.b="ytGzpRiZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vr58tZQSELjzwTdOvsGQ5wVoUa9QnEKIJRnSq1jtyT1r/abrZQ4YMZK7pfnq3aQ35Fz6chv6OurEuvGLYdERvOtaq1kPrx3ptU3bzHBaVq7iWO5L1wIchwFrF+/Cy6zHwhSkkFMycLyJpOi8N6ofNsoSl0Lkbn6N99dTmMrGV+T+iKoeoBm1CaOLzrBEr8OTr4LiXljUHtE2U7t8rKNpCitdnWqLe9EGc3LBU86S/HlfcyHV8emQYcG/1BV1Xb44yc5MGtmnm5U/wLpoJYPI0zjYWgnYyhs5ZQxFtBjLLE0nIeyBwUYZQmbIbTsys5YHVH6W7ZGpgpVomnWxkEPCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pErJ+C9RR37ejBjxvSlSVhu/FW4KVsm8oFgweZcBT30=;
 b=xvCNiYphXsvTwNmvI26heeCIg6WBfLwJzDdviPV3lm1MFQnnQT+QQnS3p3Uxx6ulIuOG0tw8x5vFa/GicYNBIQl6nYJEq/qzqD8TZYmAKir4GQ89qOcNEJ21XiGjJgIEgXST80CV9eB9HqGXq29bD1Rw4457SxzWDvql7ZUcd5mxS6EyZZd5Kyk/38hiw+npj4ndBKGzYmXYcDvC0/mSvCvSnLbHeIQgEAHemzxKIfYoGG9ChmsYcbXHUl14iswMLiDQFFT21yt02pJGsQsuUahbfbeH9XEeJ7jtSNs09xrTAT/M+4xdsflnh4qHRsuaHNZLdONxly/yDhkhXHYaqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vaisala.com; dmarc=pass action=none header.from=vaisala.com;
 dkim=pass header.d=vaisala.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vaisala.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pErJ+C9RR37ejBjxvSlSVhu/FW4KVsm8oFgweZcBT30=;
 b=ytGzpRiZz0ki1bJa9nDCP3mCkNTCZ4MFU8W4X/DOWRtHmpZADggSccEZtrnKjBPSFrP8TEFOgnAuYZl7wq85fq3OhX/hR6um8qxfq2CyLQH/UekkogEtear8xXSBCK7hA/KuhOB1fhMTkLS51NpWzOHg8l0M9Do5KjV54cfShhvOv3DRqlVXTJvWulcXGdQRmDXpjPU3AYxNlwDPXfLw4jgmdoRmXBggHEMMUsww7h5hrKgoCbLSAaBpU7w3EOQgZ48J9Vp8wGeYzAmBnqiMMbB3BUjFpIbpU024+9oLvzE9VbLPeuDvwPOE45lhqAacS0Ml2i4/ozKH1xOZKyjwGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vaisala.com;
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10) by FRZPR06MB11132.eurprd06.prod.outlook.com
 (2603:10a6:d10:1c8::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.27; Mon, 30 Mar
 2026 12:02:20 +0000
Received: from VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee]) by VI0PR06MB10639.eurprd06.prod.outlook.com
 ([fe80::3a41:90d:2091:bfee%4]) with mapi id 15.20.9745.027; Mon, 30 Mar 2026
 12:02:20 +0000
Message-ID: <e7780a82-aa32-4b59-b11f-0124347fcdb2@vaisala.com>
Date: Mon, 30 Mar 2026 15:02:18 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/13] iio: adc: ad9467: use dev_err_probe
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
 Jorge Marques <jorge.marques@analog.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Renato Lui Geh <renatogeh@gmail.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260330111856.121589-1-antoniu.miclaus@analog.com>
 <20260330111856.121589-13-antoniu.miclaus@analog.com>
Content-Language: en-GB
From: Tomas Melin <tomas.melin@vaisala.com>
In-Reply-To: <20260330111856.121589-13-antoniu.miclaus@analog.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00023983.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::368) To VI0PR06MB10639.eurprd06.prod.outlook.com
 (2603:10a6:800:2f4::10)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI0PR06MB10639:EE_|FRZPR06MB11132:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f695696-7c17-4956-89fd-08de8e54322c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	LNVibEYhdK+w2y61XNff7VxeuUCtP60lZHFt5NbLJ5jplSCD5wQrj4x8NM3qy04MMoVJnzddA0dATRe8y0TrZh9i4e0jYkKn0ZCQwprcUTxLssTk92dQG5aR6Fn84NlHmSI6miE9NGjhTJTjd98fNI1funp7u53iwRmAs9mQ+7uzH8Y+1rY4PWB4oXqKMYYNTFmtsxrF3IxRfhHv1+OpEQV9DO0IF0AgUKcrjY3TF/MJVamVqBONfBIeHA3pGKT3r4SY9HNETavpTOUlLb4XSt4OwjoMAYbGiTPKmckwXljeFXmbHpuW1Hnra28mUsUA3de3IPQLdnfzloyHmX2exyPHzF2Wj27QF3lYLbChveW2d3ptuoJFuOdReohvxQNyfv8I1bCo5b2AU/qyVyw/zmHX3Ltpsl9Q6Fq8rirA2527eDfuLJhdfORpSv29lOF9mjX97oj2TT/p65QUr/ojKwcWyG/R9WTv2SqLEtZEFFoGH1iBaLANN9Bh+7/dDGqkFYx4fzoIulXj2vYg51LBnuSt8cR/nzvdNKKkD4Lv0tIs8H2laN5bO5/vaaohdhcTgHAlPRc2zYWLW56TnyStymA147xF4g7d5q81KYQk2qBNbPSPFnsNrdtnDWahQujIvL+qHpOiVhpZj2AsmR88S7WQ+FCNEw67ovA17BC+IzyMheipY2FQ0CvXue734NDO0rf1J12RwXd7A1yUQaXfTAbTporPPKcDhKzWP5PQna4egixAVPThkxC7OtxWMQ30l9J8kerctvt2X6DOFy7uyA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI0PR06MB10639.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alR6TjgvcjlWYW9IdmJtc0ZiM28zUXg4Z0QxTEhaNEs2bHNmTndOejhSY2Vw?=
 =?utf-8?B?ODlHWnMwdmxOTHllSGpSQ2tHMWRUVlNidWQrS29kMC9iTVlLVDRrZzgrSU4r?=
 =?utf-8?B?em9LeG03b0NkQkRZSWJqNGtDK3hHVlJzTkxIbElFKzR3OEVIZHI0TXRSbWtz?=
 =?utf-8?B?V0ZnNE5ub09ZR0lsWmtwNGRpYTNleFIwWlhzcVF6alFvcjdZSURUazFBUzA0?=
 =?utf-8?B?STF5ZkRhRVNFZ0s0elg1MzJ1S0w1d1JGN0tRdkJFZnNnVUVVTFBrcGFOWmVX?=
 =?utf-8?B?VHZYWFNtS2Q5U0hLS3YvTm5hWXlBUUhTcjFCTFRlazJJWFZETkUxbVVRMjNU?=
 =?utf-8?B?OVZKVlY4WnFJSS9NSzdsZ0FncEdpdW05cUtSY0xrZ0VJNVI1M3VyY0MzTjJ3?=
 =?utf-8?B?dndteDd5V1AwYzNLV1VZK3ZseGlZS1ErbHlCNmcwbWxHQ2N2dlpaUEhTTlhW?=
 =?utf-8?B?ZEFGVWg0WDl0RVRsdWZSNWNHM00yR3pNT09FQTMzY054RnBwZ0FjTHZDeVU0?=
 =?utf-8?B?UmxkMCsvdjNhRjJZYTc3K0xLd25UNHdTNGc4VVIxNFJ2SDhGZStPdERWWVVz?=
 =?utf-8?B?ZFJnM3Q3YVM0dWYyTElRUjRHVk1rYVI4K2s1dDdxRTROaDNFNTY2a2ptbURN?=
 =?utf-8?B?YmVEVks0QnB2dDVlbThzT1Q0QTlLTlI4UCtRN2tOblJ0M2NWT2tabDVtTXFl?=
 =?utf-8?B?enM4OXJJQ21sV3JLRjBQOEJDQUdtTkpad2JTUGdjbHhSZW5vdnFOSmxRVldD?=
 =?utf-8?B?WEN3eWdkZm1wYy9wRGU5dE9iSC9vYTU3eEVrbjc2ZnBxSHFzcEZUVWY3cUxn?=
 =?utf-8?B?SjhFMHZlOURhN0dRTjhHTnhjZ1JwM0FrbnJXTEJQSHFQMXpIa3dyNDRVMzJ5?=
 =?utf-8?B?Nm5Mei9lSjhtNHVzRlcxVnUxOUZObk5Vend6OXhVdkhsV2ZWVE9xNUxYZjhV?=
 =?utf-8?B?Mkg1cGtoYmNwZ3FHZGgwY0dpdEgrT3NCdXhUcWVVSFA2bUlDaFRmdzNPS3dD?=
 =?utf-8?B?UzNJalIwd3Y3ZnZsMGxKcDI4dmVmYXp6R1VidE40TExtVFEwOWRuNUYxQVRn?=
 =?utf-8?B?NGI1TWNTZ1MwQ2RtSkhwaDNiRTQ2UmlqRmRocjNiZ25ycjlZaU1qNWVxMS9q?=
 =?utf-8?B?R3lSNnVzSGNweGYvcVpET0F2QmlrWXVPZ3ZwWjZJRmdaSUg4Nm1raVgzMDV2?=
 =?utf-8?B?WTVENWdzK1k0bHlYeU56YVlRTGlyNEtKc01Wa1JwN0JveW16NmtYSmdYMHFJ?=
 =?utf-8?B?TmpVYTcyNFhUQ3MyMk5Sb3VYUWtvcHF2T2JHRGo0S29CMHU1S3FmUmU1SlBE?=
 =?utf-8?B?UlRRMWllOFV2VE5LbU1YbVFsZ1pKbjh4ODRxYi9wVk56Snc5ODdDdUpkQW9T?=
 =?utf-8?B?cjFDbFRPY3NibnR5SnBhUlpORjZZcUdySndmS1JOWFVsYU1Wa1VONW44STd5?=
 =?utf-8?B?SGJ6bFRvcmw1K2EvN3N3b1lOVEVnNWExQk55KzlZYVdGbk51b2pyZG9wWjRy?=
 =?utf-8?B?a0lwWVZDYXQrbjhYS1o4ODV0U0lNeVRHQWxZcUlsNUVXa0FjMHNzNXZUZEox?=
 =?utf-8?B?d3VrR3ZxZis4QmNuUlE5NDZwTnk5U0lkb0NGdG5tczY2UGZtMTVaQzNFaWUr?=
 =?utf-8?B?K05ONUl1RGg2Wk5yWHBldXFPUjZnMWJTeFB4cHBaWC9BemViaXQ4TXJuNEcz?=
 =?utf-8?B?R0hQMkYxMlJBcjJZMUg5bkdGM09QekhKajRzM2cxbUJWbW5EaExsV3J3MzdN?=
 =?utf-8?B?Z0lWdWxWaHQvNGdEYitDUVdONmVWdUJDOHZDN09RNmVENWUrUDRxV0w5WDc2?=
 =?utf-8?B?RVlWVGFCcE1McjNIeThQZDJoYk5GTm8zUWFmQjlVNmZFUkt3Y0pkN1BpR2xi?=
 =?utf-8?B?dm14RytkS2d5R05KSGRJb0l6QTY0eEh0bWdJVjltNlE5QlQ2RDdiYXNGTUpU?=
 =?utf-8?B?VXdlQ3pXa25MalA5alIyT3hHS3V5N2VOOTFJbnlsU1gyT3VPeEFvYm9jallK?=
 =?utf-8?B?K3ZoUk9ueDEzR0REVWRCWWFtQmM0SkNYS3pNaFZEd0QyS0hRMzM5b1lMOENu?=
 =?utf-8?B?TzdZNGpSZlRLNmFiSnJSdmVwYjZ2ZjRCeG9nbC9iZzFBbmN6bjN2QVFDdGd6?=
 =?utf-8?B?TDFxcGpnTHh0RW1FVFpxUGNCekFXSGpzNEl1TkVibnl0ZmFDS1JtTkVHUEx0?=
 =?utf-8?B?S2paMmJSQUxmaXBDaVY1RDBZaFVJbEJ2U2ErL1Y3WDc1K21IZjBhSFpVdXU2?=
 =?utf-8?B?emdKcWlxay8zd0ZZUWlOTEJQdHMveWl1RFRsUjdlTml5SDYvYll2Q3pCNWNm?=
 =?utf-8?B?OGFUTjIrN21HK2pBYVJhSzM0UDF6TkNVVm5iTG54NzlLU2I0eTVRRkU5MW9u?=
 =?utf-8?Q?+00Y1FbX1cY95heg=3D?=
X-OriginatorOrg: vaisala.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f695696-7c17-4956-89fd-08de8e54322c
X-MS-Exchange-CrossTenant-AuthSource: VI0PR06MB10639.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 12:02:20.4670
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6d7393e0-41f5-4c2e-9b12-4c2be5da5c57
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GjqbvNH1/7qUXLiDh8F1U8DG8+OQHV0pfFxWRx9FR57ubm5C6XQBVn2OSvjO4/NtMPRQQKIKQzdBCl+3NtsYhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR06MB11132


On 30/03/2026 14:18, Antoniu Miclaus wrote:
> Use dev_err_probe() instead of dev_err() in the probe path to ensure
> proper handling of deferred probing and to simplify error handling.
>
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

Reviewed-by: Tomas Melin <tomas.melin@vaisala.com>

> ---
>   drivers/iio/adc/ad9467.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/adc/ad9467.c b/drivers/iio/adc/ad9467.c
> index 0bf67437508f..0c377f9a7f25 100644
> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -1349,11 +1349,10 @@ static int ad9467_probe(struct spi_device *spi)
>   		return ret;
>   
>   	id = ad9467_spi_read(st, AN877_ADC_REG_CHIP_ID);
> -	if (id != st->info->id) {
> -		dev_err(dev, "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
> -			id, st->info->id);
> -		return -ENODEV;
> -	}
> +	if (id != st->info->id)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "Mismatch CHIP_ID, got 0x%X, expected 0x%X\n",
> +				     id, st->info->id);
>   
>   	if (st->info->num_scales > 1)
>   		indio_dev->info = &ad9467_info;
