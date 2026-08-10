Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDAB43F0AB8;
	Mon, 10 Aug 2026 15:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374397; cv=fail; b=La9EeiZ7aNshiif536tTO+iTpwjuI1ol+IOmarCjaSNuxSxY5VS4Nouv9Hu8VW6t1msk03UUZkPy29/ecBq0AtZnkPQJ01n8/QaXrhgebPK/hGOg3NdIMyK+erEECWV2IZ8A0MTOuvvpcYOkv/341Fg61fjfADTnItsIyafUyig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374397; c=relaxed/simple;
	bh=V7Q8vh1w/RuFldeBfcIrsCu3FddF510QwhMo2wzFAqs=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=eHpRguXbsjcC25fR+qnuZX2Y5HORN/S2vxO0DwZQPgjW6+bLcZogM+LDwVr0YWh3EeQl8ehxWMMNeiwyvUqMP0bRo1fWyq2fQ18qaTr9oXwsZlF4Ks0V5+TSRV9a0krR0VIlVZ2j1p56omx6EAhpRvY7vT1VlM9z6MKdI/NOY+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=PhokUUh1; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="PhokUUh1"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACsHLG3474289;
	Mon, 10 Aug 2026 11:06:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eVPGv
	y56EOMu20Do5qjWqH16yOgyTfrV5pTWXcSXQAY=; b=PhokUUh1Rcj4mJGZRtSeI
	Fmw0NmnC2BVeKLiPvR82boPBVxIXy35TUyL1NmN4sPapOcUhbKiZPuxEFiEHQbUG
	nGApygfTAv4Um/mHEFnrkORwUsADBVoVhxTfqOgTZI3NnBdIPm+Ovpfn82/6k/cR
	GnJux592HBh1QYY/qYJ5Qfh400D4x38NZplygYTZZzFrE4jyP32jIKRy9rBCFpYc
	i7dfEQIgeVt5BQGNJ1OTFrXu+P8P2qWKPLa7Aga5MeX+Gyk7Hjx8IAXgTrPyA/iA
	Ip0i5oSamGv0IXU9eAYNAiy7rWSkbmeiFoYDZ2vOoeGGBjRBOtWuKCt659QkahrI
	A==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012040.outbound.protection.outlook.com [52.101.53.40])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fxn2jbwfm-5
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:06:08 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jTOHCXAoddLZaPKfRtBdiizeH23HR7hQHfa9fI4ax0jwPTY+8xxukvvIr+VuRYx9+VIWlXX0nqV07ythJpt6XMo00enxH2P8bH2teh0znGAXXdG7SgRFrUWkRAykJ5HWFOJgNutVOlC2ZtCQnYvxjuYISs2ICbfrjEwK0502PQpr2P3kDiAr4YvUM6+IXkwQooFfu1MuxdRsDWbq7u+8GsGMdImYBJItCCMfrL/gou1wjJtsGZ6c+zEo5Hy4m3u/gFPMjoYDXw8e8DeWmHHMUFrMRrwSlRs5nOO8bvX+GkPKnV/2asfkmqFvNcJTFDNnLrI+UdywWERPCyMfKcFh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVPGvy56EOMu20Do5qjWqH16yOgyTfrV5pTWXcSXQAY=;
 b=T9EWn8ItACvD6WXbj3AkDx/NgRWOB9Q+oCVPndi8LgiW3bsMyAkj0l6ZMSuVoWwTPT9mndYQOnypK9yBVFtiJdIiV+g/MmxnZQLb48oMOJLgGNt6734xfgDYW6syKIlWT1zsGCNI5ihe2lvmmFFEt4vBXC0vWwTjX+E5wL4tKURalGYMuUDbCyn0HsN/go2GOudGDNOmDfmEd/KCjASyQSBNGvVcORBCg4AQl8J+W36S1KhO5oM7Sc0TbcPp7tmT9v+rAzklp4dlnV0HUMd2MYszMCYWs05X03pDy/iIX3eCd0oMfM/1cuOFZPfPlZQDB98E066Ee1LNPqXurQOu2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB8170.namprd03.prod.outlook.com (2603:10b6:8:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:05:58 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:05:58 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 10 Aug 2026 16:06:47 +0100
Subject: [PATCH v2 6/9] iio: buffer-dmaengine: Use dma_slave_caps bus width
 accessors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260810-dmaengine-support-wider-dma-masks-v2-6-1f7b798d035f@analog.com>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786374404; l=1595;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=V7Q8vh1w/RuFldeBfcIrsCu3FddF510QwhMo2wzFAqs=;
 b=L5IawyqqI3AKmDJPDHnliZcIpeI0ESNPBJ0O5CpNrG9pQEkN5yCv6N95TZTCJ0qtvNr9f88Go
 FjgD0vlhmrdCnrK3TQ38RgE3b5h/WUWpEI3XZnom7st93Lg+efKgUIC
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0130.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:51::23) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a359207-921a-4447-8a7b-08def6f0e21f
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 nOVqmIJgnNUQaMfLVtqhMyjV9XIZSiuU1Vp3aKvFLVLeKcpFw8OH1VD+HAxt2Dmxc6rCdKAWmWTXoqvqL7b3wkYm/aDVuxqH1asWh5upNIWctOLetav42XadLtH1cnpre6pygMd3NtzkyqpY13SNVwh3axXCVuIY4vnkwex28XebvQgybIZ7nb2pPxckhj1iB4JQDuGMU5hmiVh5MGB0srbFP64Mkloy9IufL3C3RIBBTLD4xmAAzZ9lIxsqk/gRspy+UQCoiNZTNqkOdDofZw/ujwXLcn2HTPXZxBO8DH5oUv4aJGRz2q+5VuszBJ4DsguKCDbuQdeKLM7u4Tv6OEGT71jHiOCGdzp/pqWbfPn1eHdufJHYyw+PyAVRH8reAG6/7o2owkhYsovNNlAJqtoj+0J7zgnKM5j2bJmkOxuWF7FNXu+nFkZpq4rd/Hn3yE0qvrckxDTBRzz7tI+mkOQMcyDaygEm2qy3C1ZW5kKGVOIqAXt1nPpL1YQe//5NDzUOYa8Jf5WQevszciNpRuy+9t/4v4tteVtQ8y15LToDaspjAyvckudmxmt6sttqVrVI5Com3irtnfC6aWjqRuHqvPulh5/+qjzZHdH50ypu3vJvsrLa/H9FkRBngzil9+V18/IzcVs5O7SQ15ehQkjxTNk+AGge1jgZ4OYgCgw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bkFSczlJSXR6SFl4eTJJbVpFM0hFVzhCYzZ6M3NLbU1Yc3R0WVhuZHk3Q3Vv?=
 =?utf-8?B?NysxRFFqUUJqUGx4bXJXUS84Mm1RUGhXaDJ2OEoxWTh5R01wSTRlRG14d2hK?=
 =?utf-8?B?eU5LQTdHWXNGU2hhTUFLbWpNeFdVOVpnOXNnWXcwenpDdmp2UWM3a01aWHVM?=
 =?utf-8?B?aEs2YnMrTmtTSnV2NVJuNk5sbW5zOFhMNDBTbkFaK3JGeGo5MmtMMS9SUHp6?=
 =?utf-8?B?Q0t5WUdpc2J2YnRIKzdUZHYzZXhRczUyQWw3SWlGZGVUcDV4NVNxSGVIM0Rl?=
 =?utf-8?B?Z0Z2Z3ozYjkvYWErRDlaQWFNU040ZUs1MWJRRUViclRKdWRSa1NxaFU2clJF?=
 =?utf-8?B?RWt3MGFjRjhTZWg3UFZPSkFmNjR0dmVKNDdheWdvUkVNRG9FcUs1am45aEo5?=
 =?utf-8?B?cVpxdzNWaGU2SkhJRnY5dFRjTWdHeEZnR2hZOHc1elRUckhkRHo2d2pKUHh1?=
 =?utf-8?B?WkdvTEhrbXFGTWFqa2RoelpNZ0xNS3phWGVURWZLMHcrUDlDUENHMXgxYkNl?=
 =?utf-8?B?OWxoMXJ5c3JVODZtZ08zYkxWQUtXQ3FoaDRXb1VPclRya1d6TFhtYVhudlJK?=
 =?utf-8?B?UjQyOWFBR1hBZTFETEs3b1U2YmYzaFVWb08wWk53L2dMOU00cUdGbGtsSUU1?=
 =?utf-8?B?NmVjdDZtV0NzMnIxaEg4VFhPN3MyaTEvK2ZhVEY5TlhNTlhKek5rTEpwR3py?=
 =?utf-8?B?WnpxMGdWczBwcFF3V0tKSW1TTDY0M2Irc1F1cC9NUXBLWDlXTEU2bE1WYlNV?=
 =?utf-8?B?MFdJQXRmMEk3UTNuTHFyK0gvb0ZIZVQzSDBtVmRBazZsTmF6SklRWjFLZ25v?=
 =?utf-8?B?SURzK1NHY3d3WmlaajdZdHZEMFp1QTZGVFpzb3Yzc1lTOGhsa05BeGd5b0VD?=
 =?utf-8?B?eHl6b0w2WTE3V0hlR1JPN3QzNXREMnpROWJxNkEwbEovOUIvNVl1b0NaZUkz?=
 =?utf-8?B?VTFzWVN5S2Z1RHViRzhzNEVwbmxMMW94U0JLV1hIcHdjZTNGeC9CWXI1ZWdq?=
 =?utf-8?B?Z1lyMkYrbG0wdmczNkxjQW4vUnI2bjE5aUVIOWZleGR3eWtQTmpDeWhCTUQ2?=
 =?utf-8?B?NGxvK2xvUGZGMjdOWVVCMTB0NGQ5Q3pWc1ZLbC9BVDlQb1d5cXA3MFltNkwy?=
 =?utf-8?B?eC9UZUR4YXhiNEJlN3laazIzMzVMeE4zWGs0VUFDSHQ2WXZhc21EUk1JbGZh?=
 =?utf-8?B?SWxLMDlDaWdRTXFxMlErN1FmZ3hXOGU4QitRRmNueWRlQ05lTk83VXV5RlVF?=
 =?utf-8?B?OFNtTUtFSlFpQmRFdDlBMzdNbU4zeC80K1ZzRU5YMk9EVkkzd1RxdzB1d3Fn?=
 =?utf-8?B?a2llVVNGWVkwY3dyL3E2UGtnMUhtK21NNFN1MmRDdDRiMFNaQWhxTmRVZVdP?=
 =?utf-8?B?M0NVUnNsUjRHQlF4YWtNblRkTnhycGtYclY1N3V3ck9Pbi9hM1hCbCswRHlG?=
 =?utf-8?B?RFg4UUxaVEFBNllHWng1Z1lXY2NUTStuVTY1eDhEam5nbUV4dzB6TlZqT3F6?=
 =?utf-8?B?eS91TVBEVlk4SUFBT1VBd0RBYVh5aVBRRmJoVy9NNlNHYmR2eTE4WTFiakJa?=
 =?utf-8?B?aHFjMll6UUZjSks3ZnJjd0pkNHVtd3IxeHhRTUs4Nk4xYURLWVJ0eFpsS0N0?=
 =?utf-8?B?MlVxazQ2aXJIeUZ4aXF5dVpHZ1YrbFVkOGM1OER3cm9lV2dhNldTa1RYODNw?=
 =?utf-8?B?UnVrbE03S2V2bWdOQmhWVW5acDJPUUwzRkN1ZlNCVVhGaVRXc1BWaTN5Mlh1?=
 =?utf-8?B?MVk1RU9IU05mT1c4SU82Ti82YWYvcStIRFQwSCtEM0VSY1Z4L0JEd09pSWVJ?=
 =?utf-8?B?RjI3WGpGbUlHYWJaMUNNUUlHdHF5bHZHMnI2WnlvK1l0M2dISW50SDlIQmJm?=
 =?utf-8?B?US9paGJaVTh5Qit4Tjg1TE8wUjZnWHpMMEFqZ3M0akw3N0VOTWxYS09UWGdN?=
 =?utf-8?B?VkN3QVltUWpUVUhBcUg0c3JZY0lpTitZOGd0SXUwNGtSN0x3RjJiL0RGNFVO?=
 =?utf-8?B?ZVhuZlpadmtSbmNWOWlSZ1BCS0pXSGlieEl6QWd3clIvcGV2RERma1ZrRGY1?=
 =?utf-8?B?ZVR0S1pUMU5jaElIeDlGMkZ3eGlMQW9ta0FtRmU1RGJ3M3lNUkduOFpsWmJI?=
 =?utf-8?B?djZacjJjRUlybk82OWJ2T1JzVFErSWtMTEUzSDljS1hBODZmeTNlWGEzN1R4?=
 =?utf-8?B?ZDZQWlZkMHhiWjJxOE82b3NjODFkWTNJbHh3SXBEZE5SMURxUFRsYkxXTU5Z?=
 =?utf-8?B?SUxmQjJjVEVQUFVGMS81VWgzZW84Nkd2bVBrOVZ5bVdoRGFHRXZ5VzErK1dz?=
 =?utf-8?B?eUZrQVEwZkQzcDdzVXFFR3R0TEpvMHpBTDh5czBqYkk3SlhWZk5tUT09?=
X-Exchange-RoutingPolicyChecked:
	NFnkEb283l3T3bWcC5w1o2X9phxg4syGDJqXG4cO4eohY/KldgIZPL6WNic9ReaU+0SHgGVTUQjUAnKYXdojqNpdaPWdaY0bqoy3hyXEgVM9d0pddJXf6vFSws82846wIlO4PPKbSAY2e3oCVyRNDil9t+KHAmzQ8NJmMwtSQQHp1wJXlfr1bwH4ENmqtnVyYQIZHF293ehbWf/0qP3eVQ76P7g2/pDNnqThzvoNiWlyrTPQr3hcP2eyraHap0M+rcz8JpEre1SURARZtFY99EaCgm+Xn5H6BL3AJFEwGRFpTD40AyKXyQ+bs1qudEUOdutxzZEIXOSBbetuj+LFtA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a359207-921a-4447-8a7b-08def6f0e21f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:05:58.0679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PBuig+GN+xBLlyFywx8MCS4JySIrIUIwKOWROSNJbal5iSnHBDkhy3SU4yLMZK1YYu7QtyhKlklmHlDxrL7JaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8170
X-Proofpoint-ORIG-GUID: 2uviEcpZq5vIqc8FeKsnfyk_iJyUoqfA
X-Authority-Analysis: v=2.4 cv=SJ1ykuvH c=1 sm=1 tr=0 ts=6a79e8e0 cx=c_pps
 a=94FLU6K3oGZrB1XHaeOsDA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=tDM7BdKeoruSKJMCeIQA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX2i2lDc4oUMKa
 zguKk0fzR2HXZUTi3E0ZugYECQdRlT7nGnb6zwTT03ynu5eO/Q2xTF/AKzqeJPd70LxZF/SgHJm
 S5MZXaQO5KlJ9DRILIheqV6/NgzmzL4Ve+lmPXAL3OX8ELBzSHWE1O7qqWoLXChC+LfGtyK15wW
 bPW/Z9VP5Xzg5lbkL1Gl9o98rM9/4sKWM9B4uynfITqsVI9H+DtTTBFuFj+AHHwRNLfvwBIpas7
 Lu6inO7bKa/YTNsdqNwXhobH1iB3D41oa1iE+CZ0G2UejPR2FWrPILoLdQFeX5AvICMijUyyqgK
 Zov5ZMe/s98Kf8CGyW6GuD7goZjDkSD2/17oYmwB7d6/rwwdM6cliRkbcr5R5jUaXjE1d16Ry2c
 b50gDrCO5KG1+flE8pVoGROsXiAS7cQPnIFE676ore+JnWgY/e71YbBgGoVYge7/VIGXswIiYe9
 RrxaZDN0yJpY76Lv+CQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX4ztBkjYAq7p/
 I0AUpGsLyBga039YbXdU9ReAfDpkKZ/PCz9Xb3x8O82pn7MfbLV2c/rcb3qDxmc+ijBypyiOsPp
 QKPqWmRDYxpaq2YqbUpIvjkH5sJMkAilqS6hOeCMue/F3b4fOUBo
X-Proofpoint-GUID: 2uviEcpZq5vIqc8FeKsnfyk_iJyUoqfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100130

Query the minimum supported source and destination bus widths through
the new dma_slave_caps_get_{src,dst}_width_min() helpers rather than
decoding the raw legacy u32 width masks. This keeps the buffer working
with DMA controllers that advertise bus widths via the new bitmap
representation.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 98acce909854..855e3662cd3d 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -229,14 +229,13 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan)
 		return ERR_PTR(-ENOMEM);
 
 	/* Needs to be aligned to the maximum of the minimums */
-	if (caps.src_addr_widths)
-		src_width = __ffs(caps.src_addr_widths);
-	else
-		src_width = 1;
-	if (caps.dst_addr_widths)
-		dest_width = __ffs(caps.dst_addr_widths);
-	else
-		dest_width = 1;
+	src_width = dma_slave_caps_get_src_width_min(&caps);
+	if (src_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		src_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dest_width = dma_slave_caps_get_dst_width_min(&caps);
+	if (dest_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		dest_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
 	width = max(src_width, dest_width);
 
 	INIT_LIST_HEAD(&dmaengine_buffer->active);

-- 
2.55.0

