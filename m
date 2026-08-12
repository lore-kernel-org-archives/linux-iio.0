Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0183AD52A;
	Wed, 12 Aug 2026 09:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525693; cv=fail; b=q4NY6HG6B5SWp2NXRmkK2VJSIqnuKf+eNhjlfFweM8tWAWroQGFWO4T223sYtttCwv8bg26lVvg2632z/IhDHEhsuvfJe8iUYAHg5zzdnmIXhpopO0cohsVSqJv8xxjdzP6yr3LAUDexXowTbBjjeVfS8gIK6j6UF8YQYZ2UMag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525693; c=relaxed/simple;
	bh=9Mj35kBAmwTEVMlDsSyww8tdC4wQLwp8rw0IIKv9Gzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C1BlxdfARG2jsbQw+irolVU8Jm9etGdPH2qBovx73+i8LXSCYGbO7+Xk0ieqWhXdBUnhFYIE43Rz3523F02KsFF9wiBjkMIMI2IwQUgBlOouNr6f+L87gm7rFgtcjpoC0sMKaAUiPhSCyWdbrbWRMOrU922vuF8N5zs/7h6k9SE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=bW5WNzjX; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="bW5WNzjX"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C61DIq4060661;
	Wed, 12 Aug 2026 05:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=WyAgC
	1U69hYShiF2VWQKUCs49KHlYaGvIS5bz9eGzBo=; b=bW5WNzjXsEZVFrKFGwcfU
	rNKpFOaotR487i/a887NtebZ0G/+fxFOjPaqA5U8iHL1CyTfTPvPhytg3/2WkliG
	gXBo3rdcdnHTtJfCrcQg3n0aTZyEdyK/4UtAFQHd+Mkfg0hY1yrr7+mNNfd9XKWK
	ax7BkRzuNW3QoHxlHexricXZwMkvB/wdaD1yqTq8sViG7629EBdUtj3GSK/umi/I
	GXYhLSL08fq2MHX1br1NqVjjDR+cjc1I9mJMzC+xWtrgGra8isj+fK4uFQRjGA4f
	E5BSt8L9qhJkta9kHvfInOosGOq4CAEwI9O/tOH4JztIyTSgE2W7KG9r2evepVlh
	g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012018.outbound.protection.outlook.com [52.101.48.18])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g0jdcgv3c-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 05:07:38 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k3BApgfbVSh9ACwh4rgTizAginqCDIJkBnpQHJDv3AMJAlbz33eRSz8x8WjlD4uynOf/XPTX62oPO844IAXjXXynR/QN5bwcVOtnhY2Chr9Qx3mLC7FKt/zvXVx2Us7H6F69H8ym3I6U0KQ/GIk1nYr+/P0GQWzoiotsMnV47jrKuk9T2qqaPx7DhWbqqvQK8zuGfHjFXQBv/xNiUbnkoUXO+wz2WGVpEGoCCfWS/nayDNReUxzWXqMIIuXE+2zttiuPIITMbdFHMN2nbuu7K0RitwTVswrrUaz34+Nom7wHBL05q+xFI0GjZtdRFE8MYcFu+6YL3hMQpfs0HquFuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyAgC1U69hYShiF2VWQKUCs49KHlYaGvIS5bz9eGzBo=;
 b=ljVquitkuH1Kyu4ygzXXU7qw6NzEnUwGNcFaVgma5rhHuT4oQ6sMse4mM8UiyNXXWJqYUDu0OeuW1FpM0r74uwJuN2kvhdkEyP/UL1VXWdH2wZUfTGqzs5ywzeFfBNTmaN1H7txVNbNBSpxKsoIQrneA8FRaHeqGHIxhOK0IO9HCvx33xzCPdICZKVCmiTHSu7BZiV9mQXCb0qDj/rbJucjyr4OSQlE6Kq5imrOrJupaTDytqkz95Uzu6UJh+4IciSrNH96YSXI7ld4JPpv3T7cbJJQD/gtgi1/ljAZQN4LLaiHh+pEv9xZXLiPMwxwibiK2NLT9kkjN69ISo0EF2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH0PR03MB7142.namprd03.prod.outlook.com (2603:10b6:510:298::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.11; Wed, 12 Aug
 2026 09:07:34 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0315.011; Wed, 12 Aug 2026
 09:07:33 +0000
Date: Wed, 12 Aug 2026 10:08:34 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, dmaengine@vger.kernel.org,
        linux-iio@vger.kernel.org, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v2 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <anwwrvNLP2OujnWd@nsa>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
 <20260810-dmaengine-support-wider-dma-masks-v2-1-1f7b798d035f@analog.com>
 <anoHMANpRU744hPp@ashevche-desk.local>
 <anrgDskNdV7PG-T-@nsa>
 <antirKIhG8iaMqNv@vaman>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <antirKIhG8iaMqNv@vaman>
X-ClientProxiedBy: MA2P292CA0024.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::6)
 To SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH0PR03MB7142:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2b5c99-a922-46d4-9c0c-08def8512521
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|10067099003|56012099006|11063799006|4143699003|5023799004|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info:
 /x8heyHAYLl6BZA+DGcQ7IVkBrtZWxJgmJ4mfsCKgByXCcC2hHFL6jlTs93mhP7NShGE745UqNhawp4K9crJ/lNqFwWGA2Ln61ty2QUVrnaEoPz4fZ4+SdzByGw3IRz7xcBPi79l8kggDbHBe1obNMyfXIE0deS80nbswASjfIkS6wFDgeV/E0NrcmWnbpPSKxyRvOtsCYx3UyR+NgAKUwvKc3JAdAq5szXHi36eccM9i+7iOzcOMXK8hoLIf+Zfrvi2ELblVtQn+Qiol9wOaq09LZA8XszL4omD8/LagQOWePJHhsbFPzxUZ+kekM3tZwWjdmwMfCuE0KdQbW1SufXyzUeKx1oyxIrbk+a+uXEapsbSK8JzS13aZ76vtmaD0dMvEmuRPBWNsf40ILkB018pdxJjbCtOOr5ST6gSdXxXgnS1ILCAmNh73r6FyfLU9VIHqvBzIfEejEttJlejllcGaiK3WnmHr86nMri00QznZhJdzzLu0L592M+qoXcd8v+x7xP4kVLMTRH8ZjjHXkHVzHrUCzKaV98hqpiH++Lb+cjGSOxcW5S/DJ6+jRrUxQt197hez+bsevGTqfFiKbaHZND6SQzA/zW/+jzlLUsABWst3Mw0qdY87WJmD0J8GSKVUSIKOdEsV6gGuFk/8sSRwX6tXCR8u60qeLVep1k=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(5023799004)(18002099003)(6133799003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RGY0REJKM2krWHdrRDd0RFAxdFAzR2Nld2hZWU9NMXBtV0hzUGJKR0d1c3p3?=
 =?utf-8?B?R1AwZ1QycjE4NEpLdFYzT05ENkY2bE02OWR3TEo1UVlXSGRsMXAyWGJCKzlD?=
 =?utf-8?B?TDl2a0d1WCtJTXJPVUJrMGZya25EaGxuSzJrRkNURkxiQm4yQ0hnZmpkcEpL?=
 =?utf-8?B?a24ySSs4MFhCY3hnZWxCWjl5c00zblpMbHhwNUppckxUeHJnbzc0dzd6Zlg3?=
 =?utf-8?B?OEtoYWJtYmEzT3ZINXYyQTNmZW9Ubi9hMGNYejdjcFZ1VU9KeUlqTHM1eDJt?=
 =?utf-8?B?VE8va0VBSlhBSmw5cGo0MTAxaEVLVENyRFp4NzFidjVUQ1E1RFNOTkdWKys4?=
 =?utf-8?B?T0Z0eXJMVzF2cjlJMU1NdkMvRWFCSG5PVElpRUJUa1B1Qmx5cFlEazl6WDM3?=
 =?utf-8?B?WDNaeVhPWnIwYk1VZnN1dkhmR3NidzhDSWxRajljUlp6dFVMQ29Pd2pwWHFK?=
 =?utf-8?B?bVI3SXl2VCthM05PU09TQnp1UU1wTmdqeVIrMXNTRFJBMjVJalhWNUVJaThQ?=
 =?utf-8?B?eFNvcDhjdUdXbm5rTUxwL0J4UjU0WStzWmlCOE9NQ3NqUnJ0MXpCUEx1ZHVt?=
 =?utf-8?B?U055M1JIeXpWRzRPc0ZVSk1jKzR4eDBGUlBkcGRNR1o5M3ZjdkZMeEV1d2Fk?=
 =?utf-8?B?VkRNR0hNQ3hUaUtXbVdZeFBCOWJxaXBjckQyYW1hN3c5eUNleS8wNjc5TUlE?=
 =?utf-8?B?ekJRQzJUZ1BQWUgzbnhudHc3UGVnRW0zWUtpaUNDeGx4RXA1QVVkbFNiT005?=
 =?utf-8?B?QlFlWFRoc3NlekdiYzhNMVVMbjNydkN0aVl5NjFuTW4rL1FXMzVqYzFKU25s?=
 =?utf-8?B?TmR1MGVLQ0hxN2JzQ20wYjRZaUF2L25CdmJ6bVlVV25GV0pCRnVrSnlielVL?=
 =?utf-8?B?dFB0STgvTGg0TjdyZmZoa0UrUDdPUWxkaWhheXJJdUQrWHgyM2Fuc2dzbXRN?=
 =?utf-8?B?aVl6Y2pqRjdSYnFNdk5JSDdMY1Jkc1RUNGdSaGtHK1JKQ21wZGhaWDNjdENt?=
 =?utf-8?B?di9GazRia2tDRDhxWUhqV2w0eUE0VUFKWm91TGlyc1BXelhvTnlLUnFmVGRC?=
 =?utf-8?B?LysxMEFuRDE4YituS2JTcllhRjR2NTRRcEp2Umtqd2I5QkU5dFBRNTE1bFNz?=
 =?utf-8?B?MWsyVkdZMURKdWh5Y2ZwUm5GN2tBSHVvd2cvYTRTQUxiUjAzN3FBQzFFR0Fh?=
 =?utf-8?B?SVNteUZpcCtpODBjaEhrcUJ2Njh6clJsQXZtK1FtU1UzbVR3WVlGR1hmRWFM?=
 =?utf-8?B?M0VKdHZwZE84LzVzamRBdW1sQ2lpck4vWWNNZW1yZlZ4UzJ6V0hOKy84eldD?=
 =?utf-8?B?RFpHaTB2bkduNncxU1FWVzlKQTBScHg4VEliT1VFRFNXSVRaMlc4QUx1RzA2?=
 =?utf-8?B?eGR2SUZMa2V3MGJmNnhVTmFKZWhUeTU3VXMrY1d0YVEwQmgxUjRGUFdDaGo2?=
 =?utf-8?B?NmU1RkJZdE53ZHdtSno0NnRyUlk4anprcmJvakpub0RQYytIY0JUNnpvc1R5?=
 =?utf-8?B?U0UyNjdhRG12ckpHbFliejBMenh5V2x6T204TmRIekNNSllTSkNrdFFHQzUz?=
 =?utf-8?B?MzcrdS9KZzluVFpheG56TVNSQllTNlIrbUFCMWhSdnZyTXVKOEpMVms0ZUly?=
 =?utf-8?B?aDZEM3RWb0FlcVRVdnAxd0VCMkpZWDF6b0pUUnZTOHlaNm5ueEtFeWJmY3R4?=
 =?utf-8?B?d2RrQnlrMkJpNERMOFhWSU1Ncy9xeVZwcUl0c1NKWG9ISkpDejF6cllZTFFR?=
 =?utf-8?B?N2xyK3FLUm41UzFucElFMDdhRy94TXp6UFpGSVBFVXJONDhocHhBNVRDYjBD?=
 =?utf-8?B?V0QvTytqVzM1cnNOejVEZExEb3hjWVlrZjNTeW9yUzNmNVE0cUpqNGNHWG5j?=
 =?utf-8?B?T25Hc3RsNGRYWHRMVEkrWEgrZUhRVWdybjE5YkdQQ3hYTXp4WTRmZTV3Y1Fz?=
 =?utf-8?B?Ti9tZ1Z6OWlCd01iSUt1S2huTTd6aEIvVTU4WSt5b2VsaUVzMmQ3TUVBS3hR?=
 =?utf-8?B?VnFtM0lTVGFXMDcraW5DYTNRN1BvV0F2U0g3WGJEWnRhOWtwUGMvTVNrV3U1?=
 =?utf-8?B?YWphMHRyZXVHRTVXS3laSWZxRzJ5OFZEV1RxenJFQlAyaUJ2NU11eEphTjlB?=
 =?utf-8?B?bFQ4NTBoMkRra3JHQ1lvc1hlMk9oZzdVN0g0WWJ4Q1E0SnVuNFZ6OTNRWitT?=
 =?utf-8?B?RDhxVjVhKzlJazhTbHY2eUt0TEpBM1N2M3dOaDJmdGlpanhCdzBweGdDR05P?=
 =?utf-8?B?ckVwMXNJQ2dhTWdsZGhXM1pXTGtOeUp6TlNjV0c0WUVtL1c3YVJHL1R2NWVO?=
 =?utf-8?B?R2MvNmJ2WGsyWUE2NTNDeUNrRU1rWnFpaW9oYW1lYjlvR20wbzB5dz09?=
X-Exchange-RoutingPolicyChecked:
	NcupoSHsOOunG1EQo3Hf+8EBdzEpdiwv5Y1WioVL1InT+/a+0/s93ri1zJY0ezgCwg4cziKcfMnH3fAm07AQsAdVNlcFwB7Kv67uJU8cYTmv2uu/YRxUzIGm0t+NBpWUKHxLlzS+ev77vPiARnW6DTWG7HsM9L3jIn8Ug52fC7jRTKzdFw30O2n4qhxOGXLMgAQuxNE6igkTJBCSRj0wEAO3jcJSV1aGrG19eY50Ix19rqiTNGUTiKeR/c/q64YQQKmoTiv7dqj/dyMtlJXL72NtGik57eshKLhbWD24mYZUnaJmprh4wmGDE+H8S/O0lYt5wiyhTKwitqj4ORiYKg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2b5c99-a922-46d4-9c0c-08def8512521
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 09:07:33.5332
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ok4brhu/W2MyIxrWjingzD56nmHqmSWXBlYQOClLkJN255LNC3qbDiqsEcUq/A1idcf2n13yXawfsLq9UuLKqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB7142
X-Proofpoint-ORIG-GUID: Mi2G6Sr8ED99N9mD89fJUl5SJzXeVM-j
X-Authority-Analysis: v=2.4 cv=CZk4Irrl c=1 sm=1 tr=0 ts=6a7c37da cx=c_pps
 a=HLJbjerEQdjma44f6ZsklA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=oN7SysUsDoIk6kVyToQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA3MiBTYWx0ZWRfX/7p49hKSCqoB
 qffbgztAEuQIZPBwct02fAQsKtUMKoaRtml4rFAw1onQJFArZAZOCN885voIHwgHkgIYDIjI6/d
 xrNzUkkA3t/Gb/mkrADxh85vDPjovR4nCEvLB4tP9d8oAfq8tCFMnFSpbHG//18NHXLDy01fE37
 QRZxY9QG9xMw8R7cRefGnfUagdcjcdS4ZDGMr9WJxSD+4etvW2so654insk8GMaYMnnZEqUn+OC
 Lepuc+XpZARCpNVcc9NPurfBeZRdtas4rfbC7M7zxzc+2xDqTju/poNzxgG6LnjAxe8/24QJtQW
 +BLOuThx/bg64v2iRWFGl8abj3fsejH3iYhxHOJpzHQcagUbaV0L2CNxv5bcUfo85Bx0dCgKbM4
 cxJqLp/kPhdy8AK/c0UfS3A33St8xiwFGG8xgBfMebyx78YhKozl1mqNASfI7/ZNseDNYoYn3TG
 Wa8AZ4fbewEfQvoSNHA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA3MiBTYWx0ZWRfX2bQLv6wUSBYD
 Nx2zjJtdHYiNuKASRW2Y+wNLPAyatAl4SkIkpBWjMiyVvcKisuXu82fQbEU92w2EOTYCHlu+n7e
 7L1pID7HtxDwmmBVnUAdiWoUUbgR/jbJXTguZoB7iIYffxvrOYwG
X-Proofpoint-GUID: Mi2G6Sr8ED99N9mD89fJUl5SJzXeVM-j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 bulkscore=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120072

On Tue, Aug 11, 2026 at 11:28:04PM +0530, Vinod Koul wrote:
> On 11-08-26, 09:46, Nuno Sá wrote:
> > On Mon, Aug 10, 2026 at 08:15:28PM +0300, Andy Shevchenko wrote:
> > > On Mon, Aug 10, 2026 at 04:06:42PM +0100, Nuno Sá wrote:
> > > > The src_addr_widths and dst_addr_widths capability masks encode each
> > > > supported width as a bit whose position equals the corresponding
> > > > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> > > > 4). As these masks are plain u32, widths of 32 bytes and above
> > > > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > > > be represented at all.
> > > > 
> > > > Introduce bitmap-based bus width capabilities that span the full enum
> > > > range. To allow DMA controller producers to be converted incrementally,
> > > > keep the legacy dma_device u32 fields alongside the new bitmaps:
> > > > producers using the new helpers populate the bitmap and mirror the low
> > > > 32 bits back into the legacy field, while dma_get_slave_caps() folds a
> > > > legacy-only producer's u32 into the returned bitmap.
> > > > 
> > > > Add helpers for producers and consumers so users do not need to depend
> > > > on the bitmap layout directly. Once the remaining producers are
> > > > converted, the legacy dma_device u32 fields can be dropped.
> > > 
> > > ...
> > > 
> > > > +++ b/include/linux/dmaengine.h
> > > 
> > > >  #ifndef LINUX_DMAENGINE_H
> > > >  #define LINUX_DMAENGINE_H
> > > >  
> > > > +#include <linux/bitops.h>
> > > 
> > > Ah, this is unfortunate, this is a wrong header, the correct one is bitmap.h
> > > and I think we may not include it here (see below on why).
> > > 
> > > >  #include <linux/device.h>
> > > >  #include <linux/err.h>
> > > >  #include <linux/uio.h>
> > > 
> > > ...
> > > 
> > > > +static inline enum dma_slave_buswidth
> > > > +__dma_slave_caps_get_width_min(const unsigned long *bus_widths)
> > > > +{
> > > > +	enum dma_slave_buswidth width = find_first_bit(bus_widths,
> > > > +						       DMA_SLAVE_BUSWIDTH_MAX);
> > > 
> > > This is from find.h which is internals of bitmap.h.
> > > 
> > > > +	if (width == DMA_SLAVE_BUSWIDTH_MAX)
> > > > +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > > > +
> > > > +	return width;
> > > > +}
> > > 
> > > The (big) problem is quite a header dependencies hell we have. All my cleanup
> > > work of kernel.h I started on the simplest thing I wanted, id est to make
> > > bitmap_zalloc() and similar to be static inlines. But it's impossible to achieve
> > > (and I think that no one, except may be Ingo, see his 2000+ patch series a few
> > >  years back, is capable of fix that at once). That's why having bitmap.h in the
> > > kernel wide public _header_ is bad, bad idea (at least at the current state of
> > > affairs). So, make it exported function instead and keep bitmap.h in dmaengine.c.
> > > 
> > > ...
> > > 
> > > > +/**
> > > > + * dma_slave_caps_copy_src_widths - copy source bus width capabilities
> > > > + * @caps: DMA slave capabilities
> > > > + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> > > > + */
> > > > +static inline void
> > > > +dma_slave_caps_copy_src_widths(const struct dma_slave_caps *caps,
> > > > +			       unsigned long *bus_widths)
> > > > +{
> > > > +	bitmap_copy(bus_widths, caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> > > > +}
> > > 
> > > > +/**
> > > > + * dma_slave_caps_copy_dst_widths - copy destination bus width capabilities
> > > > + * @caps: DMA slave capabilities
> > > > + * @bus_widths: destination bitmap declared with DECLARE_DMA_BUS_WIDTHS()
> > > > + */
> > > > +static inline void
> > > > +dma_slave_caps_copy_dst_widths(const struct dma_slave_caps *caps,
> > > > +			       unsigned long *bus_widths)
> > > > +{
> > > > +	bitmap_copy(bus_widths, caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
> > > > +}
> > > 
> > > As per above.
> > > 
> > > ...
> > > 
> > > Another (compromise approach) is to split the header that includes bitmap.h to
> > > something like dmaengine-width.h, but I don't know how spread this use is. Do
> > > we have all the users of the current dmaengine.h to use these APIs? If not,
> > > split, if yes, then comment on this in the cover letter and perhaps that will
> > > justify including bitmap.h in the dmaengine.h (but personally I am fully
> > > against that).
> > > 
> > 
> > Hmm I don't think all dmaengine.h will use this API. Maybe on the
> > producer side but even in that case I don't think so. These are all tiny
> > wrappers that make sense to be inlined but OTOH, I don't think any of
> > these needs to be called in any fastpath. And I do understand the header
> > pain in here but honestly, no strong feelings. So, I'll pretty much
> > defer this to Frank or Vinod.
> > 
> > Frank, Vinod any preference?
> 
> This header is where we push stuff in, so I would try to keep it clean,
> so I guess better to go with Andy suggestion here

Andy,

Just remembered that bitmap.h is already included in dmaengine.h anyways. bitops.h
is because of __set/clear_bit().

- Nuno Sá

> 
> -- 
> ~Vinod
