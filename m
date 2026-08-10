Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15563E5EEA;
	Mon, 10 Aug 2026 15:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374377; cv=fail; b=lE87nOKqc4SlzTF1lxmGE2orPYEacTVHAZM9VQve2UUMajoPvzrHxRAiDe8w+an7UHhHqsxLw98KPKip17/0sZFzC773ldvuZJ/cp5/aYgihVLwzhu/YzqYf+yIaX1VccUjaxW6uaZWy98P3itMdLkWLr2iJ+Rq451LXKnqdAm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374377; c=relaxed/simple;
	bh=jnzqfWxk18GSXcKCUtDYld7/JirG+hv4I7KDASDla9M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fjPaAx5/c5/mkK8ZEsqVz3Tj6oMoEKvT9rV4bJHAKHR0ByZa5Ud0W+FYXRH5LeUrEOGH7uKh1Y0ZWiV6yNlFFl8DOwvZR4jN4/iY8GVe00ODQcBIGRqf76U4EiL8h7HKOJa6g5TkH9+f5EiNh4jSd/30ISpmXOihl61zuTesXqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wE97TYNg; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wE97TYNg"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACsJC51464309;
	Mon, 10 Aug 2026 11:05:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=mYjUd
	3+UL4DboWJl4kvEBAi8f6UUsDI81thwviL6Cv0=; b=wE97TYNgYYLRSGXEgLtQ2
	3wuIN6/TNe382tgHhhgtIzcih1+Bf5qAkZdtgk+5DBgz/Lzipwlp+51cn1+b3YX/
	6xceJN9rDAKGJaYkThNKdTITLHFYjVn9G+kUAjQWnL5flmD/MoRkT+xQ3uh119qZ
	2yB8yDgOZtIsiVr7kaxyUcZs3s1Yk2fvuoWpyZA9gd5MVly6qfp/4gCDVAJHghrq
	iJctNiLFkWhSTKFqVA45B9TALO72XtMdtpVDAABBs8lNDolfJeLOrE8Dt3f5qSzT
	kdf1wtgTDWHx8X4BVOld2fsPkgi5LvM4PiaJ5q595/gZT4VSwmv7ccybrVjIrh68
	w==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012036.outbound.protection.outlook.com [40.93.195.36])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4fxjse5ast-6
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:05:53 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMKJn/WsY4HP6eJj9HiNPkFH6xJw5klKk6IYAIb18Kg6Gpy/v4jGbx6YMPp0nFEoCBzzfaJ01HN19JDg0G+a2mQ2XMZpKiD1/RC8HijRcl0coimE6IgApzhoIh5qIjWcKODOUspu5x1NmBMnW5uCyzUGlQ9oc8O1ugqbgWfbHGFirBW6Z4fTPhLNA9zVZAio+J+1pe9hhpWwxdVXP9hEpyX/zoXtU0sKDA0jOIpMUlEuaXkaDCOxQ1b9jx2y6buXRNXNCXKRV//JOHnbS35eGTCuG14d8hdG5bNPw3A1h5kH9XD7jklJw0ZpzFetMoCzv5lzClA8mh0ic1H/TzK1Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mYjUd3+UL4DboWJl4kvEBAi8f6UUsDI81thwviL6Cv0=;
 b=HYoyIkDv7UBccImdB96LobUpsR8A4N2Wl065Z4fjlGs3jgbyljuqDqaLa/rsDNghu7hlQbynT9/2r88isFWXxhKtZLEfq6wtMBx5OCFX6bFMVwBBEwNbuGuX43mwGWBlYV/jxL8VH7DzZf4xNNGz7o7wgyuX6RnKAOiZKw4nLVtgWkEO5TN00C4WOv2/YM0BbUzbQknRz381zVDwRbSjmq1fmiNNAzMXOUVVPfXIpscmMs0kCJKl+ArLS5ONjuQ855B5N9ySEJIdOUhSuPxbj9LHXvKHABU8CFgMoF0VGbR70avRUbKv8DcKSXTtLM0BXwP9opitpV+zlFhbRLSXtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DS7PR03MB8170.namprd03.prod.outlook.com (2603:10b6:8:266::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:05:41 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:05:41 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 10 Aug 2026 16:06:43 +0100
Subject: [PATCH v2 2/9] dmaengine: dma-axi-dmac: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260810-dmaengine-support-wider-dma-masks-v2-2-1f7b798d035f@analog.com>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786374404; l=1817;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=jnzqfWxk18GSXcKCUtDYld7/JirG+hv4I7KDASDla9M=;
 b=K5zfYvXH2QqcTw1LNU/uF78fge+8/5zwtAuJu5iroj/9woVIzfZilezF5S9Xaxkz5KdCROS2X
 aA2l344WuyYA9ruPVvJajmJCSNUlz8dW4H9wQqmW/3N9EMpUCf0RZWY
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0044.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::9) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DS7PR03MB8170:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e0f1acb-36fe-4d1e-5659-08def6f0d837
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 Nos8ULqlLroqDjRT2YkOY8BDbQpUh3epMfnyk0lNxVsvdMoN0X6an8FvgUpYIuO0nvBBtQAdsM8RAjLrKtbk7piBRzTRvDW/JELl51qdpYJeprDRNm0cRsFr+VDKQYcQSTKQV5oyncRySDW1clvugH8SO7nUg0DcqubdoBXaEWHP/NPYueeDWiYXdOLXThuwy9FmUHDBRCtjoqHBptRo9cmoNE9CmVvYuh3YXstJAySmI13OyfaCVMYgmZe0LRTCtroKGFPiRI0FVb9hSuLy1ornsvXHpm9clj5eK4NSVKQk0j7GlJX1DTxLWoa8kjmh8454rtoCJUIe35cTGEs3ND5ScC1qBMe/may7SMNuuaj3rPOyfXSEnCXYLRpWBAV1rQSIJnm+xllB21VH7PoEfqmVcR3a6BnEfaFq3UvDlS6ldAeeqmdWSdjIkLZonuTDE5lODDEXxaKPtGciFDqlOBnrB3bjDfDM/255/N25BkbOE51Y4lvPSCR3qzQHgEv0i9u6jwFAY2Ou3dboaMMQe/53YrXnQYTlIx1K7fsyBavyXLc4M6inptoJMHHsU0xEGwKGD5699QK+ze+sKcvNhVd4/2sbnCeWRJcz7PzQazQMX8GpYC3k6B/nWO8Ij+8aozRHfnQC5gHyP25KDgi0AotUYZycbKEFCHVbIusCTgo=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Yk8xRlZkT3dPR3J1ZTFSRTNxcUtob29DQ3N2OG5TbVM1czJhOGlXM0dhQ3ZF?=
 =?utf-8?B?MWFvVHhGbmRqRTBIMEdvM0lDeGJjS3pXR3dLQ3RrK2NGdjNmTzVSNm5HY2hK?=
 =?utf-8?B?K0JIRGYzVkVZNVVsSElHM2tRQzc3U1NVMTg3ZnZzUnhsTzdONHlmYUJnNHIz?=
 =?utf-8?B?elRvNHlKMWM5VDgrVGE5T09oTWdiVkhCQkVOM3o2YUNYa1RhclJQS0dWVThK?=
 =?utf-8?B?Rm9udFUvcjlPMGhUSGhkcFJLUFdYVStuU25ZWUUwamNxVEprbHdkQ0hzVXla?=
 =?utf-8?B?eUpMSld6ZmRiOFJIV1ZRYSttZGRBblhLbjF3Z1Nrdnd2RnM4bG1GVllscTFt?=
 =?utf-8?B?U3ZlWFhCK3VjQ3FMZ2p4L29yemFYUzlEbG9yUjI1Mk4yaUcrRmhvckFNTjZu?=
 =?utf-8?B?QzdFRzdtS2lPdmZnc3Y4OVMyQXRCMVJ1Mm9mYVJkOGRYd1VNcW1EQ2pObnEx?=
 =?utf-8?B?K1RSVUpFMjhGeVZ5WENiZTdlVXcvQmxrYmhNV2FwR2dWUlgzVjRzbVR6R0tn?=
 =?utf-8?B?MFdaenQ0L0FVU3ZQNkl0UkxOVkUxbE1RQU1MZVQxUE1oS0ZjYW1oZllqUzl0?=
 =?utf-8?B?T01tTTVreFFhdDM1bmJXVEhibEJRQnlrZlNETlQwY1ZZVGFEQXZwZW5wZFVN?=
 =?utf-8?B?OHdFZkgxdkhxTDlVcU1LYkxINjdyTk5tWU9YbDdFRU5LU1FESlZpMDlIdXpo?=
 =?utf-8?B?TkJqN2RNcG11UGNlV1o5RVhPVVowVGhDQllEYVF1RGN4Z3Y5UHZKZ2paWDBh?=
 =?utf-8?B?SjVzeFp4SzRPZkpIUG5uOC9KaGJnNFIzRkJiZUxnS3luaXR5VWRhTTczZTZh?=
 =?utf-8?B?WGY1Z01LTGRJTUYvSk43RWd1dG0xVlRVMEpMVmNCMXRSVlQ5UmRyRGROME1U?=
 =?utf-8?B?WlBFR1RodnQ5bFIzVDk1ZzNzZVhNczBKU1J1NlNQRXJTMlZuWFJDaU5vSEhC?=
 =?utf-8?B?U1RCWVlUSXlGa3RrcXJiTFhkbE5RcWk4bnFiQllualA0U0NmRk5JL3NySllJ?=
 =?utf-8?B?cUErLzEwRGxmdHlEemlxK3hDMXFZWjR4TmZpbGZxeVBKSTMxcGZhOHFPMHlD?=
 =?utf-8?B?TkVCU09MZm05eS8rU1hqR09sSFFmN05pdStIelZqOXNpRFdVRGdTUkdueGRZ?=
 =?utf-8?B?M1pybStqV3JwUnQvM2ZLV2ZPQ2o5WEtuaXZqWGZidk9mTEJiazVNdXZEZVNl?=
 =?utf-8?B?dnpGNWx0TVBKUElQN096ZVVMc0lZcW9vWElCeW05dVJnME5YTVVmYWJ2V204?=
 =?utf-8?B?RjFibGUyb3VpTTZVQUJVVzdRQ0pNU3dHT0sxZkcvOTRqblNNcVloTjFFdEZU?=
 =?utf-8?B?Um8rNGNhaWNhZm9VaWRSOUlBMUZpZVFiVElFdDYvYmIwSVRjOWNOQVROMllP?=
 =?utf-8?B?cGNUMFhkdWt3K2lrKytlMHBSTHpXRTBYM0pMUnA0KzFIc0h6QzdDYzhKdG0v?=
 =?utf-8?B?VFhMNkRGS2JkejBJb0p5R01iTVBrQ283Ymw2LzVpaHRCTWVNL1BIY3FTOVJq?=
 =?utf-8?B?QWtXV0tTK01OZ2d6SXRkTlVqTWxWd053NnB1aUc4ejhnSStGaDJES1N3RExk?=
 =?utf-8?B?RDZjSFpXK1pVd0ZhNXFhNzlOTHI4b2NvaThxazM2Z3ViMzI0dzR3bG9KMmFH?=
 =?utf-8?B?cTgxdDVobmtXS2I0UjR5dEhSMlU4Y3RCcGMrcy9oVTd3S1lvVVlGNGloSXJR?=
 =?utf-8?B?WW5Hb05yQVZLSmRaMHRzRmpzNEo3a2JXa2svRW9IVVY1cHY3QVJubWdYVE1i?=
 =?utf-8?B?cEh5UlRsM3VYMGJWa2NiM3d1SHZIU1lFM2dZTVByTm1ML01OMWZXY05DREhx?=
 =?utf-8?B?WkpCUUZVUk0zbnJIVkhUQXpkSlVENDNCZ3NSV3JsdHIvSDFYV2Q2cU1QWVAz?=
 =?utf-8?B?SlZZQkltVXFGa09BVWN1b3FDb2pYMVZyeXNHUm5lQVN0dENVcTQrb0pCUEdE?=
 =?utf-8?B?VDM1U2g1bVF3WnBjZU9ycHJ0U0RjVm1jbTVDVUlVMEF1SDE5TXBXMy9EKzcr?=
 =?utf-8?B?NjhCMjNpcktSdmNBTllmaEV4MEJCMDcycjhDM1pyWkhYeE1RdUZVYTlMSGd1?=
 =?utf-8?B?d0VyUk56R20rS3preHRVVG5uazMrOHF0WG9PNGlNenBXWmdhZUs2dVgrTktJ?=
 =?utf-8?B?VlZRV0hJZ0NkMDVTR1NveU1Jemtsam1CZmRwUUNtZ1VnMnIrelBaekNWZllh?=
 =?utf-8?B?SEVBVnVKTDlBMDA0dy9NMzZIUG5VclVkYkh5MjNKN1p5bEpFRm1yS0RVdFdk?=
 =?utf-8?B?OEpnYTlTQnZDN2hFakJCQ2laUlVyeEVQOEFUU0FHdkdHZkRFV1JMM0piUWdk?=
 =?utf-8?B?SEplbzk3dVdUSjMzK0JLY090eVZYNEJMcDlyUjRrOWZURjlIZFdJdz09?=
X-Exchange-RoutingPolicyChecked:
	Db3314cB1Pq/nnHnGBXJcTu7RfKu/1NpS3X0Mp/Py29ffAbQj7WEI5wP3QMWIM4jcjiAzwA3Ib6aI2RUFXfOuANuXFR/V01JSoBUAkA/GDs7OIrNCf1yW+x0pgBHKsopfZcLZ1OtXGQUogMXqaR9sB9XrX6s3oP3K/LmucNaeMtxW85/0yNDBBp+LGn1XfzrBRAOMZCubGonFbOTkvQI3l5lgi7yj5bo9Arh1FFUzXt1j5Ro6tL7rBhKA9/qveOzre5qHvwsfb9yE9775sFbGcbBrk69extiFj5Mqk+6w2rmJdpy2OpTrr7UV5j/je6xUsfCHhLJ4bMybBhpaHDbBg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0f1acb-36fe-4d1e-5659-08def6f0d837
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:05:41.4357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QDRMSmyfV4EXjB5yiG3CG//pyPrBp52Yii7GIM6PMEkbXIzvRZB0nStjdhj9/xoljp51lgviy5D6s4MaqAhmhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR03MB8170
X-Proofpoint-ORIG-GUID: lFr1CNB8BKat9uVutZrV0GyvqIZNnP9e
X-Proofpoint-GUID: lFr1CNB8BKat9uVutZrV0GyvqIZNnP9e
X-Authority-Analysis: v=2.4 cv=MLBQXsZl c=1 sm=1 tr=0 ts=6a79e8d2 cx=c_pps
 a=1PMvcOD3Mx+UKTR1GZf1Bw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=VO7gjKh9a35wxgc9tPQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfXw3MQE2+68uK0
 D1KRjFYCRdSmE94Sj+NHyYwG384VjGVdVU4+rIEijHQhq1hfoEIqS4tqSKdbDjN+cXIb7KzFxeF
 qxXjsS8Kri14We+uq0qW12Hr+5V1O1/Oh/YOWzL1VEMrUcqclcA94DI3DD9Xqat9fpQi/PIZABP
 79CKt50CG2dMa2h9cHYGck71O6s9FF4TIpTyjwKm9ioJHvHfmPOFUli4A5oF7L5NA5vwrmY6CH1
 yPwKuX90+6xAgOfL9+51kh/XD50yBP5Cdi8rAQr29o8OGqM/eEXWmQGbTz+cdRCPwykXqILLId7
 XSIp+7gRkm9Q7beYzvxZAkI4rpnCCwaCXGdp4ZKw+dueCKq7mhmow/zU2GEIVqaraASqPdMk12/
 TvRl+f1/dwOyhHp/X6yR2vcv5okyBGM19RrO5DNMB+KQmeZVBfRkL2txcSy+yzI5CzLPrCdP5BV
 sfSuUYxaCXsedyseBJA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfX5NtSMXqaZNUQ
 Mo4rjQ43w+fYCLY4KHHqfTYzKibFya98VGJufOLvQeTz1nvQPQ2sKchI65znsyj35eKVEUVODLR
 yEyeJVC3T9909VzkCNuCC1iwRD/XPPxUXY0R31SXxBU6LECXUv/7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100130

Advertise the source and destination bus widths through the new
dma_set_{src,dst}_bus_width() helpers instead of open-coding the legacy
BIT() mask. This moves the driver onto the representation that can
express widths of 32 bytes and above while keeping the legacy u32 fields
populated during the transition.

While at it, give the channel width members their proper
enum dma_slave_buswidth type.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index d47ff27e1408..26912330e3c8 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -152,8 +152,8 @@ struct axi_dmac_chan {
 	struct list_head active_descs;
 	enum dma_transfer_direction direction;
 
-	unsigned int src_width;
-	unsigned int dest_width;
+	enum dma_slave_buswidth src_width;
+	enum dma_slave_buswidth dest_width;
 	unsigned int src_type;
 	unsigned int dest_type;
 
@@ -1262,8 +1262,13 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
 	dma_dev->device_synchronize = axi_dmac_synchronize;
 	dma_dev->dev = &pdev->dev;
-	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
-	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
+	ret = dma_set_src_bus_width(dma_dev, dmac->chan.src_width);
+	if (ret)
+		return ret;
+
+	ret = dma_set_dst_bus_width(dma_dev, dmac->chan.dest_width);
+	if (ret)
+		return ret;
 	dma_dev->directions = BIT(dmac->chan.direction);
 	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */

-- 
2.55.0

