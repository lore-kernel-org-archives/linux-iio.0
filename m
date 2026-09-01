Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C046C85D;
	Tue,  1 Sep 2026 08:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788251105; cv=fail; b=F94+8zWV84K5F+/2xnhE0D+2gFK/EjXFpiNDIyWwA+e/erclH4Yt1N64xFUL1HZkeUWidMA2gvweLGhMJVdlvWgi0NZr9OexK6te5fuSiiH41gUgM0p1xj1MUD6C0Equ+n/lcQnGfmY9ksukVQ4RGfMpAIXgOCZHdRw3Blz7Vos=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788251105; c=relaxed/simple;
	bh=rcxVOWV2gO4BAt1EtIkeFpXBrxxtFKYKkOm+7P80sc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PZe8M+P0IUAyZP4nfhCs1We1zEdtyKHDDobFLmxG1B02cGiviaEYurGxQLVfx6HQ3g90WXYHOyUGCcXvk/dOCIk/K6IhRcMwgSNVp+sbQ7BwAWSS8E4n6Rhh8OsOgx7lSNRF7mIZPFpfvbD/sjUd2DiNv26qn4Kpq6lMvba50RY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=dxi9piO2; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="dxi9piO2"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6817C1ip2805706;
	Tue, 1 Sep 2026 04:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=TgNFL
	yvt0IK2VAnYuI5z5Qhqprmps/QQc7WY6xXK4GM=; b=dxi9piO2U1/BAiMzuOngr
	s9p0tIE7M59CprJYTlSqMKCSBSS1vDQx8pEcNYkLfm229hq89e9n7GiChMiCG0yt
	RGSHTKTdeCxJ0mpb0Io54AiP0m2kVgN+oKHMBuVlUjC4lYVrLMcrPSASSXtxRPG0
	CiwDr1pcWrOAIfYMvJfJVcTd/rDyMarILtE4nxCCBaKnTnMej6ExatfwziueA/YH
	+oPYQiJYQpqN5bfXoNAak8ogpX3iZgPCNA3pGcavPkRLVLBo2iuaGiI6ha2GTwnZ
	D6L15N9BywujHSLaPxDdd1LCFDQ2R7RX1eV1w/QZIJyve7iPZ4Uc/l7on8QApZxj
	Q==
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gcdrds0pe-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 04:24:20 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=puV6G6qWcZIPPaJ1CQgPSPm9Hw0wpouU6RxViBipC0O6cjtztY3k8DT/LOUNQyucmmVJoygAy4i+KFf80ba1GAC4GUKecigD7ZKUKkfRoKRtbPVXpMPFII5H5nhmSEFiJkO233YflOXS21uFJzqt24ob+wTDLrSRicH/is9ofIJOWrC5Y0pz8NQBXuEI0xuJszx3Pr30gPTy41zdmMRH7Sj9Gz7LS/UgN0qxOy5lqB3sVEy5wGG6f9G4RuccPN4O6MSoLfyJy7uII0A7onYcjIMSD88UoJm+iA3WS1p0a5mF3hs8WwUdA0Xtu8sVeET/WL14DssgCEzVnJ7RQiHPFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TgNFLyvt0IK2VAnYuI5z5Qhqprmps/QQc7WY6xXK4GM=;
 b=YJgSBntfcSbiaQfnJlfdyDoTdkfgtqrvyn0NKuQPr+gzTNU4LRu2oBykIt+P0wV/VnJpQBcNGI4UlHj+8OJLBGaJYmuDSLprGl6zQCNTWZkK0ilo8lDm71rLjC9ku5gIYdZAfRUKvhsDjmwvSMH/IKOqgYcTwO9vI3ce2zSy5AKiB/1n83j7tjJKIOXxkSVMrj/3xSuKKzYdy8vAPlF9YIrY3gXbcKjwJurcvigeK41jI+1w4V0SURgSCxo+DwgrpYdQvyYGq8bZXHRkuye1cuSin3BNxKfeskv6pptYJicYvNoFGcgEu6dBMWmLcPHC1GbBRwB9mauaLvqPtRvopg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA1PR03MB989244.namprd03.prod.outlook.com (2603:10b6:806:4f6::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 08:24:17 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 08:24:17 +0000
Date: Tue, 1 Sep 2026 09:25:10 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Amelie Delaunay <amelie.delaunay@foss.st.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 5/9] dmaengine: stm32-dma3: Use bus width capability
 helpers
Message-ID: <apaKbjer_IZKJ7H9@nsa>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
 <20260831-dmaengine-support-wider-dma-masks-v3-5-507d97496f2d@analog.com>
 <eb9fa2ed-e59d-4ad4-9218-f7473ceb9f9b@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb9fa2ed-e59d-4ad4-9218-f7473ceb9f9b@foss.st.com>
X-ClientProxiedBy: MA3P292CA0045.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:48::10) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA1PR03MB989244:EE_
X-MS-Office365-Filtering-Correlation-Id: b238f1e9-e962-4475-cdad-08df08026a32
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|23010399003|7416014|376014|1800799024|6133799003|56012099006|10067099003|4143699003|11063799006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 e/lzwW8jyk6Zs/7i2OIJi/vnMr66Z3vjLVv8k1TztPATr4IWBXsDlyAGaaccAONZzcSznHfjzr7ZfwJaeUQPipw0P5D8SBKOtLETTPJ1yuCHHW//szueotPR6c0LmuiTfw0ZCjVTw49/7oONlTKbndMY8Em8gdICQwMg3WymlXy+ZDv9B9TpFZF0o0ic3wlmlj3yNERJDeboD+QnktfM0gtIjUQUfwLo+4jrS8wKq9a3D3v4E3+532Z85DHvO2BvbGBo76N9z7kvFGJvQ2/7dqt5VboHDRofu675WUXjVH5MYRBp+hlTQrsGVcGiYjmExjwMgGZgdiBSEzAWcBB8R9kylyBlc/68b9gDHHoJtkOwR5g27EDt3q5XtK4j+FMFcUsEJm7haC00ET46XL7zPAszKyf2eaORYBB57j1X9vo9hxa/pVm+eBpUiYvMRZEJFqYEU8LIJTjeo8a4ICgN1fy70BIj66i/KlMP5EbuB+S0R+FCR3znbGOvtnTZxVGVSqAf64GGxISFOlObgDCDmA3Ggg+eErpA0IYwzsNwLgddDNKEFyiL5JWmResfTBAJWddyNaCgM7mv3HnOD5+eCYOKRVgsPbncb1lP4HzyiVt2r3Kb7rZNiyordeTD6CIAf1pA8bEzRQaMVWwyWScv4g+iWduWLrFpojY0Es1jUU0=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(7416014)(376014)(1800799024)(6133799003)(56012099006)(10067099003)(4143699003)(11063799006)(5023799004)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UC9ON2pMQzRsTGE3M29Ba0xUTmhhOEdubTZ6Q3FQRjlWWUd3Uk1XWWpqd3ls?=
 =?utf-8?B?d0p0RHRSRGQ5bEtXY3ZEb1FPb1FJcitQbzhvNUFBSC9Od25BdC9KR0JNZ2Nm?=
 =?utf-8?B?TWcxQVI3a3ZLT010K3d0V1F3N3h6MldKMHF1WUVyenFndVR3VlVGT0VxNnNo?=
 =?utf-8?B?UWZ3NGpVVjEzWlFCYWlsb1FVUVhVOGx3Y2tHNk9GNVd6WjVNNXhNLzdtc2hj?=
 =?utf-8?B?UkxYcjdnamxaV1M0U2xmZDNEeVROd0tNeHloR3kwSVB4b2c1L09MVjhGYmxR?=
 =?utf-8?B?cjRleCtMZXdCWXpTRXR0ZE95L0V3ZUZnSldGTlVsRG1JRmlzVEh2S3JPUjBn?=
 =?utf-8?B?VzhpNGNEcUlCbCtLczZ0OGttSU9SeTBsSm5ZTWdiWnpVMnBNZld1dlN5NzE0?=
 =?utf-8?B?M2FyMGluTktNZWlWeDk2V1VCM2Y0SUtyMDV4UFdtOEc5c3BFQzBRY2lFends?=
 =?utf-8?B?QXc5ZVZTUlN1WEJIVjFuMWNLUFJzZVE0RzJyY3JKWnFoa1VWanFsM0pHeDNj?=
 =?utf-8?B?S3hGOVZkUzVnZnExWWIzaDNxY0RPZGM0akxqdnA3OHIwTEFDdFBnbFk4SjZJ?=
 =?utf-8?B?U201ZmdBSkprbzk4bXFkSmhsekZhVnVBWDl4cUlIbk1xN0lxdkYxSVdMaWxy?=
 =?utf-8?B?TUk0T1RmWHVVUzJ6MzlkNjB5TFpJVE9YajZzSEFkZDFsb3lWRnZFVEZLeTRR?=
 =?utf-8?B?ZkdwbXVkTmM3WmlXYUlvR1pYYmdMck5ocDR4SlRpZG00ZzJ6UUlxQTl4V2JR?=
 =?utf-8?B?ckhtSkMxQVprYlFOTmVxVjc2cjUweFRZY1Qxd2RHMm44TzBrRUV5R3VyTjBG?=
 =?utf-8?B?R2FIVUZnWHkzZTZpOGpsMjM5bVBNQTg1d1JKWGVjM0hxemtlREhSczVEUjZj?=
 =?utf-8?B?WlZ4UnlnZnZIc2lPU2pCbmF4WUJJRmRCaUo1ekFDR3lIcjdLcGdpUEVzSlo2?=
 =?utf-8?B?Y2d3bTk5SUJHL1BwdUFaMFJKYWY4V244TWl4SUxMbXZUNjNDV3R6djVzaVNN?=
 =?utf-8?B?OHdFY2NqcHh6QmM2T3M2anBvcHVZK3pubmR4eUI0andBTFJ0NGRUeHhxWkxl?=
 =?utf-8?B?c0N1NERiVFNrWU9vclRXZGxQSnRINStsN01rUkZ4Yk1Bd09BMG1xcjhudnU3?=
 =?utf-8?B?UjdsSnNTbkJIZnZJY2ROVTUrUWxHK0lwZVgxMDc2dWg2eldicENDaFV2bVJz?=
 =?utf-8?B?WThhL0ZpMmI3a3M1ZzM2d2lhelg0R0U3SmVNTmhTL3V0UTdidnJZZXA0em1W?=
 =?utf-8?B?M3g2YkJHakFJQXB2ZjVzREw2SGhkaDRZdlBmQmNSdkJPVmlteFRHcTRTQW5s?=
 =?utf-8?B?SWVjZnUrK2lmUmRWSVo4M3daUUhvM0NUUTEvNGlVVEk5OXdHQUNLTTVXZE56?=
 =?utf-8?B?MGVHaWJpYUQrOHRVaHQ0Ri8wcFFLaXNQbkFRTGxrRlpVUW12SWh2VXZBSWFx?=
 =?utf-8?B?VGtPZWtIM2ZjRU9iU0JlV3Zpa3h3Y29kdit5RXBRcGJWQldNZHJiNXliZFEw?=
 =?utf-8?B?dzJ3eDBna2M3cjlGdFVEZDQzTCtnU3RBOFB6ZnZVckM3MWxtQW83V0FDQlhG?=
 =?utf-8?B?cWRpZlpDd0pYM1ZxdHNsVEhibnZlbHltUWVCeTBZdnpqcjJjYnNCUktwNGpV?=
 =?utf-8?B?bzY3eEsxNER2OVI1ekVQZVY3ajBLMlJqaU5JNTNlaXJHbkpRVkhiY2o2UXRv?=
 =?utf-8?B?Qjh6U3FvWUloUDF0OFRVY3MrVmsrU0ZhaTc2TXJIKzdJZ3lMWXdvT0l6TWxQ?=
 =?utf-8?B?TnNibzBsWGIyZHBINUZqbFZnVzVTdjJqaUE1bmRvbDhSbjRodE52Rm1xSy9l?=
 =?utf-8?B?dHhLNUVzbGtFRUZiTW5BNHpQdC81eEgvOGJEWllCYVhGRXVHbFNsOG9lOGQz?=
 =?utf-8?B?WmxHU1BmSmtTeUllQmtSeXV3a0R0VzhteGFiaHIwVk5tMVE1ZGo0YjlwMnd6?=
 =?utf-8?B?OFJEN215TTUwSkx4Vy9FV0Y0S1dUb2ZWOVhIbWVuVFZnanE5VUp2NVhjakpB?=
 =?utf-8?B?c3p3VmpRckl3ZTY2d3pUUjN4NW9GS1ZWM2M1d3lWd0hhdEI5OHBNcmF0Tnlr?=
 =?utf-8?B?c3Q2djFJU2tEUWJmbGlENWZQN0Ric0dJNitySzYzTDNSYlFXaTRVZFRUWFFF?=
 =?utf-8?B?SUNvSnBZRkZrUGc4c0RmUDExNHF6MitSbzc1d1ZTSXNKdTdiTkJiR1Q1NitE?=
 =?utf-8?B?TkxOcUx2eDc4aThSVnhWK0tiSHR5QVlndkx3d2U4cmh5SDZueTlpRGpYYzYr?=
 =?utf-8?B?QWxHalJqUWgwdU1PTVdGcXkyUWxHL0tueVBIV2pIa2Z3Z1A0bGNQajI0L0hW?=
 =?utf-8?B?ZXYyZG9Ta01SOUtETUpkVCtMdTVRMmU0cmFDaEpzNnRnQWZjNDNaUT09?=
X-Exchange-RoutingPolicyChecked:
	uepLlXKTZ49q9tpstdN4VPiklCAbums6/SfSWPkmdgn52pT7Yfb5XcvUTaoyrbeGI0FcGcpGdVKo4lOXcXaAhdhkmmpHEAr+2cgSZP991ynUSePVxff9qiPjZVazlwsCW/U5OmjQhtN1EoluTZeaCHNvRmEcAoBMCM03qG2v6c6FbOFFl+jj7JnDoWcG9K0tFVZsUZkXRSmzhoyclnv06ByjWdnOYHUk5Sl7tj+yy+nIpXt/l0O9U4pYTJBE99hQOVOs2EMpSEX/4dXKwl2u+juu35nhdBx/wNCBlpgAUbwlmAexI59tWXhmWRoI1r+3Q2fjaPLqyq9mCx2+UZP/Bw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b238f1e9-e962-4475-cdad-08df08026a32
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 08:24:17.6359
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fglFz+UIv2f5dpK/Y77zKg2N+4y6iXUlgrdZtU/WGQ+ukLJ+V4k9bwTWQRstUdZN7H5R0VnwvmEqtgqy9eKaAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB989244
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA3NCBTYWx0ZWRfX7P81rc5Xuy/Y
 uhh+Jx8035SuphPED1KLn2XkG7acTec+lmbPlqoLa6cKLY1xjgsjifir2bvBj620yp9diqJVexA
 FXgS3ZF33xfa7yMIt7kjmIGvDXeP7sKmaDbwFMrbLRuyEIlvNxUo
X-Authority-Analysis: v=2.4 cv=feSdDUQF c=1 sm=1 tr=0 ts=6a968bb4 cx=c_pps
 a=bt8r0o3PvT4lvF5YbTRm1A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=8b9GpE9nAAAA:8 a=b3kx_tIP8Hl93w7_1YYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-ORIG-GUID: Z5ffrIhSkICIWS6rXvgtTtB8sVKEtB5-
X-Proofpoint-GUID: Z5ffrIhSkICIWS6rXvgtTtB8sVKEtB5-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA3NCBTYWx0ZWRfX/+Ggo4dKl3tQ
 81GTYgK4uV/TSZ3q6lFFsLFDLXtEAKCiQPNdfEEguFNjgXZ5OOxqVhT4kJ57eGHGblfB4JeZDFt
 SPmvuCtT6uWDUxMWPb1gYS265DrefEC3kwmjdPusTFSYI7h+ErH+wHFHNANczm6c32ZxPGtnCro
 tpPGUXKGCpKYt/y3vNdF5kE55T+nDAYma7Wpw4D/ESA5DyESd0ufpgjOVdlqqui2f5mO7ecTLkZ
 +tpaNwf4+GLfwUtc40wSxG+7wk5kAfmcuzKgBm5MYBLKfxmj+ok7JdXD1SwBrP5ZEDFgp/5hlB2
 cQx1JbLhN/VJl2zu8FdP5xI7SiLJM3nlpN6vudxK2I038SX6W+zXdxjNh65HVa47qcdZKN7xU6o
 R8Wi2XdEFRkm6ElcOHLF/Ym9/ZvLNGXzJvQVCTH5rGYygq0iLs1G41P5+jOAdzgzTXRI3BEED/E
 SryaqaRE3lvKaGL4bXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010074

On Mon, Aug 31, 2026 at 04:01:24PM +0200, Amelie Delaunay wrote:
> Hi,
> 
> Thanks for the updates!
> 
> On 8/31/26 13:46, Nuno Sá wrote:
> > Advertise the controller-wide bus width capabilities through the new
> > dma_bus_width_set_many() helper and clear the per-channel unsupported
> > widths through dma_bus_width_clear().
> > 
> > While at it, validate the requested transfer bus widths against the new
> > capability mask instead of the legacy u32 one. Besides not depending on
> > the legacy field anymore, this also stops BIT() from being fed a bus
> > width coming from the device tree without any bound check.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> > ---
> >   drivers/dma/stm32/stm32-dma3.c | 34 +++++++++++++++++++++-------------
> >   1 file changed, 21 insertions(+), 13 deletions(-)
> > 
> > diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
> > index 4724e7fa0008..0689aeb7cff5 100644
> > --- a/drivers/dma/stm32/stm32-dma3.c
> > +++ b/drivers/dma/stm32/stm32-dma3.c
> > @@ -9,6 +9,7 @@
> >   #include <linux/bitfield.h>
> >   #include <linux/clk.h>
> >   #include <linux/dma-mapping.h>
> > +#include <linux/dma/engine/widthmask.h>
> >   #include <linux/dmaengine.h>
> >   #include <linux/dmapool.h>
> >   #include <linux/init.h>
> > @@ -588,7 +589,8 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
> >   	dbl_max = chan->dma_config.dst_maxburst ? : 1;
> >   	/* Following conditions would raise User Setting Error interrupt */
> > -	if (!(dma_device.src_addr_widths & BIT(sdw)) || !(dma_device.dst_addr_widths & BIT(ddw))) {
> > +	if (!dma_bus_width_test(dma_device.src_bus_widths, sdw) ||
> > +	    !dma_bus_width_test(dma_device.dst_bus_widths, ddw)) {
> 
> Just to come back to one point you mentioned in your cover letter, "this
> stops BIT() from being fed an unvalidated device tree bus width". Here, sdw
> and ddw are set either by dma_config.[src|dst]_addr_width, or forced to
> DMA_SLAVE_BUSWIDTH_4_BYTES or DMA_SLAVE_BUSWIDTH_8_BYTES depending on the
> channel capabilities. So, unless I'm missing something, they do not come
> from an "unvalidated *device tree* bus width".

Yeah, nowadays I let commits and covers be written mainly by AI (I do
review it though) and I guess that slipped. I mean, it's not wrong but I
guess it should be not in the cover as it's very focused on the ADI dmac
controller (and in a legacy path which used to read DT).

I'll probably drop that from the cover.

> Anyway, it's great to see another use of the new API.
> 
> 
> >   		dev_err(chan2dev(chan), "Bus width (src=%u, dst=%u) not supported\n", sdw, ddw);
> >   		return -EINVAL;
> >   	}
> > @@ -1469,14 +1471,14 @@ static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
> >   	if (!chan->fifo_size) {
> >   		caps->max_burst = 0;
> > -		caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > -		caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > +		dma_bus_width_clear(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
> > +		dma_bus_width_clear(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
> >   	} else {
> >   		/* Burst transfer should not exceed half of the fifo size */
> >   		caps->max_burst = chan->max_burst;
> >   		if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
> > -			caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > -			caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > +			dma_bus_width_clear(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
> > +			dma_bus_width_clear(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
> >   		}
> >   	}
> >   }
> > @@ -1734,6 +1736,12 @@ static int stm32_dma3_probe(struct platform_device *pdev)
> >   	struct reset_control *reset;
> >   	struct stm32_dma3_chan *chan;
> >   	struct dma_device *dma_dev;
> > +	enum dma_slave_buswidth buswidths[] = {
> > +		DMA_SLAVE_BUSWIDTH_1_BYTE,
> > +		DMA_SLAVE_BUSWIDTH_2_BYTES,
> > +		DMA_SLAVE_BUSWIDTH_4_BYTES,
> > +		DMA_SLAVE_BUSWIDTH_8_BYTES,
> > +	};
> >   	u32 master_ports, chan_reserved, i, verr;
> >   	u64 hwcfgr;
> >   	int ret;
> > @@ -1775,14 +1783,14 @@ static int stm32_dma3_probe(struct platform_device *pdev)
> >   	 * channel, and can only access address at even boundaries, multiple of the buswidth.
> >   	 */
> >   	dma_dev->copy_align = DMAENGINE_ALIGN_8_BYTES;
> > -	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > -				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > -				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> > -				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > -	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
> > -				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
> > -				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
> > -				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
> > +	ret = dma_bus_width_set_many(dma_dev->src_bus_widths, buswidths, ARRAY_SIZE(buswidths));
> > +	if (ret)
> > +		goto err_clk_disable;
> > +
> > +	ret = dma_bus_width_set_many(dma_dev->dst_bus_widths, buswidths, ARRAY_SIZE(buswidths));
> > +	if (ret)
> > +		goto err_clk_disable;
> > +
> >   	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
> >   	dma_dev->descriptor_reuse = true;
> > 
> 
> It looks nicer this way. Thanks!
> 
> Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

Thx!

- Nuno Sá

> Regards,
> Amelie
