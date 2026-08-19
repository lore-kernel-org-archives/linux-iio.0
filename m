Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7435178F4A
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787134536; cv=fail; b=b6RiRuKcXSSjxs7UdrC6NTTEZjnO6fUE9kXIKZjBG4i/IOSllbLg01wfYhcLoHVpgeHTnPBMj6VAY5uD8rBgdE8peHrowH0eYB1y7dXGZAKd3s/fTZPQhzc88WXeYfsCwZm12e+UmDDrv/tGu/R0+KdpntbRvXY6AcdBOZCYokU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787134536; c=relaxed/simple;
	bh=TI9KMkPTG76cnZioRWfLTS4bcQ9BkXrifSSu/AmnFvU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jokfsZLqnUMiFjkxVUw7Dl87vMIkvcZu0yFvydrwNL08bYUfJR3RQRHcNeheHtNZGqv6meKC5yEPCB8ORKwc/8vHtc0zyZdQhg+AjjsYoqV6XuOPZu6gsLghqliGX8LOg19MtnLsiy9oi4/5S0vtoJqquqUm5YNy/61k5JGCXKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wiHXm8ew; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wiHXm8ew"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JA5pYW1872796;
	Wed, 19 Aug 2026 06:15:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=5D3Lf
	nOOKNsg0m7IK5Yjpvxm7csx2iYByRcfi/eFQ0w=; b=wiHXm8ewZtSN5Xp4Db4Bk
	FQyGlRxs/RlTQGaohHXtDYyMf87362oZvIdd+N7Ws7OtSpDObB7xorIbZ6s/eRat
	hj06yxK60r2mTXljCbBBcq3e3ahRIZ//VnOi0Uzh3O3g5tWG4bsLtxVYY1qWLGEp
	4PF1WFvfGvcbMEIMMGGRA9RewQtoGrHdy8HTu1Lamcp3dqRRgmomz27ykOPvVUhg
	fXXyU6GsFcQIofxkI+IAK+wtAINndvizaQoYjy9toHFyI7OQLx6M7VItldJpsXcq
	AmrCiSSv4dcYtkHABkpWKmTgdBIr6wZL+WaJBLdUC7k/w+PpLw7b3r5k3ONnnvd3
	g==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012031.outbound.protection.outlook.com [40.107.200.31])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g4yeku5tm-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 06:15:22 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQc3Tl3lY9RjrfxEuvhMKMU+d4hfehiJa/p+nQJaOQbCSQeBM9s7utslJBRa7M0IqHx2NJq8U1/HydEOYVlVllVeNdBmh+m6jVblzCVMgDISiheCMd4djLjYUOWaeD7ma0l6itUVURAJPe9m5p/C3IL2Io6aHGV57e0XECSjpHxBq51DaadS0kDUO597D7oayZi1DGYezW2tUMtXfH28LGmSFbFtf5L7H/zOvhC8151RaeSurzWNmgjqcx+ssMx8XIjCbIcFm1Fi3wre05A+E7rtaDEbx9iZEaBELIrZRotE1mzQcfPZxV0reLznTWvL3qfFyfHGKLLlEITCVOAChA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5D3LfnOOKNsg0m7IK5Yjpvxm7csx2iYByRcfi/eFQ0w=;
 b=beUr7ukDe4HTbG8KKyHZciVs4oS99P1VtqqJiuukFqVzcz1t+mTtGTDfYds7xXOXUyTiLrhr24gFJikZB2lH9Es6Phn2/t4GWzfkWFRdH9UJA0f72Y9oDSC0NS7Aea5V29gAcg7zs0tE3u8T2atjrtJAOzEUmk6kyJDY1+cQA9/m68avKLEvkpecJaxuSrPRUpSF1zT/dRI6S7UvEBjzSN9L7MyFls4Bff/ILYlOW2gy+zJSuiU3Vb8Hk+jSRb0Jh+l6jql+vhf4qhmj4lzzvpac3yoAt6p8kpEDaFO8GssVoa+rjZlg0WwFRpjFHerx5ec5fBex2yFZNlqfsK/XfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN6PR03MB8007.namprd03.prod.outlook.com (2603:10b6:208:501::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 10:15:18 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 10:15:18 +0000
Date: Wed, 19 Aug 2026 11:16:22 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: fix sg entry iteration when
 building dma_vecs
Message-ID: <aoV32knWqL6s4xjF@nsa>
References: <20260818-iio-buffer-dmabuf-iommu-fic-v1-1-4ff1e44a5073@analog.com>
 <20260819014104.56bd4157@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260819014104.56bd4157@jic23-huawei>
X-ClientProxiedBy: MA3P292CA0030.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN6PR03MB8007:EE_
X-MS-Office365-Filtering-Correlation-Id: 77521e9a-9661-4569-9c6d-08defddac4b5
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|56012099006|6133799003|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
 0flRmmjsM6pXXi5TgMr+uuN5o1f+vj/HVR4R4OQrbt8vH8RIUPGSswgj2RD3OGmsWREjfBuHJhgqvcmxCzyu7tpsHaxFcKiuA1feu7QOgTlBYgLYAcI2QSaNUHw1oQVu/ySRESPrdMNbxh75OePV3TvmRDYkb/17kSZ/HWT8i1918w49m8GiywK1HLJdXJKpSpkK4H7ghlNfb2yRhKuDjAD086JwQi4mteLWzxoLHz/HqxrPp3dUsnsd940iCIv+thjmNv4uZd16UuvM9dAggUpsirgj8wzJbkDoH59fnNgO3fAU4PrdzZO453SgH55xrKUelqwAqUu0YeSi9yn0ZXnXMv+9cayD+B5Epf+xKBPnasLVlnkq4IDtZcNp3mdjdSg++2HnKk+TCGiKJBzf2AAePDxoaPJ2au4OXhufLrLTAkgFEow1GscMbpTcOruDEVVRxpzPYACuGnbceSRiYxFmaeTxkNbOTwtUccIvKd3TOos98YSudLEbPrfKDqThguy9ZYlqPxg5dWV0E9Tr71IE+L3B4v1PyvQSTvF4O2HnOzluO8GudtzfrlDg73hpzQ5kKXO28MNSv+vPRtSLdCLsfCcZelbxMLSQsydtCvHC1CCyBPpHTFhV/gGSrT8ymT1Ki+B5t+C8KKWn9pwpzgS8oXpQJee6CZFIfd5yszU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(6133799003)(4143699003)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OWhrTC9ieU5TNlBQcm5kaWp5U1RGQTAwYXRLYVZOQ216UGc1aFkrdWs4WjRa?=
 =?utf-8?B?c1AzbzhmVm9uRWc4alNEWDBEOXlXZXJJOG8zQS9Ha09adXZFVGMxOTZsR3Nm?=
 =?utf-8?B?eG1GODQ4ZC9VQW9kUi9tMVJPNXFiYWxISHNUR2pEQldTY2FqQys1cjdPZloz?=
 =?utf-8?B?azc0RUdxNzcyUmZtUDA0b3pRL0tTazgwNEw2MkRTQjdEL0IxdDNYK1owOEhX?=
 =?utf-8?B?MTFiZXJYbkxHakRSckhPQ1lFc2RaL1hVOUZPN210M0syQ0R4VDFQYXJJUHVB?=
 =?utf-8?B?YkR5MExVSmVOTDJ3dVZSendLR2N4SC9XMnkxMVpFN0lhU0tVK3NpRm9WU1JN?=
 =?utf-8?B?VE5mMGpuenFjcytyb2RndVVURjV2MVBGeEtpeEozRkhOdU1WZWZodU41elUr?=
 =?utf-8?B?SThYMDVtU2NaVlR2SzYvMVNueXZwQmxYT1UxcUhESnRmQSt4VkxwK1I4MHNL?=
 =?utf-8?B?Y3FOenZSa0dLV3ArM1liZWtXV1d3NFNXRHl6ZENpNnQwRGRnNTFtaHJIYlhy?=
 =?utf-8?B?YW82L3FPMit4dEY2b1dyd01QUFFyQVJGWEVtdjY3cGRsZ1E4MXgxbUZkSHVE?=
 =?utf-8?B?TXBQeFpXd3FvYlR2OXlUaDZCTU9EUENDSUVySzY3RzZtVURmNEVWY1VZeDMx?=
 =?utf-8?B?UFp2NDA4SnhoRWFRVlh6ZVVVcldGUDRzallKRm1ZSm5OTFk1UEt2ZVVlR3lk?=
 =?utf-8?B?KzE1K1EwY1E2dURpYUlJaEt5VVBTd3IrRHZXMDE3TldEWnVNRUZoT08wSGhX?=
 =?utf-8?B?eWJrWEhoUnZiZVFQK0p1dWlJTnl5QXBYVXFCc0g0aTF3VktIZEpPV1lmbFcr?=
 =?utf-8?B?N0wvejk2cG02emdHaCszSjFSRU0xek12SFJwb3hlRUhxSXR0c1BsZ29XSWVN?=
 =?utf-8?B?dkVQUjVvMXBQKzVmdHJ5LzlTbFROYi81Vm1MV1UvU01rOWpHamVkaUlIUm91?=
 =?utf-8?B?Qkxkby9MeTBNYmU1OWZSbDJvWkNCUU95RGtJSnNHMGk0TTk0OCsyOC9iTzV3?=
 =?utf-8?B?aVg2TUxCMXJXdVlrRytCVnRYZ1dHZDUyNlVkRzdXcldmNVJDVG1wa3FvaHVP?=
 =?utf-8?B?SkNJb1BGby9iK21LbVJSRkU1S2FzeTZqU2dROUlMNDJqKzRLZ1AwU3BqN2Ix?=
 =?utf-8?B?Yk9tWFFIK1AwWGdOYTNiVTVpaC8zYmVobHY3SmpZN2FqMU5BeERHakR2dXlk?=
 =?utf-8?B?WGZ3TklBVGJVejF0Vit4WEhXVjUwdVNhU29TWVhWR2hGL1BsSnAyWnhxMGdK?=
 =?utf-8?B?SFZTSHJRU1Aza0UwdldLZDkwMVh3eEFlSFFCcmVCcWZieXZhM2FXZ2FQZFFR?=
 =?utf-8?B?eTdVTmMyQWlQdXJTTTFhd3poM3pkTlBVRnRxTUhZZ0lzQkJEN21mTGZVTVM0?=
 =?utf-8?B?QUFZMHlianliQWU2Q3NSV1JTNXRWV0F1TWRhMWVLOGZ0eEhFZDIwSkIvMFJW?=
 =?utf-8?B?c2trVU91NllJbllXQ0FhdUNtc0NyMFJWeVVCLzEwN2lqT3NMVURmd1FVTGx6?=
 =?utf-8?B?L1dRbjlXUEZYOHY0WG5INkxndjk1ZnVTaXgzRnFoZ3pPY0tOUWRTTnUwMHlR?=
 =?utf-8?B?WGhvblJnQzVhTkJzL2Mzbi9lQThka1hJaE5vVHZmOWxpZWpmcDRyMDd1a0hz?=
 =?utf-8?B?Z21kVURyL2VQajAwdGlESEx4VlVKenJhOXVqTlR3U1JmekFkSGppV2xKMndP?=
 =?utf-8?B?bXIrQkozYWxTR01NcFZxNzRmWG9UaXd6UG5MOEV1ekMrV091U0k3UFovdVVz?=
 =?utf-8?B?YmkweVQ1QkhSTkhlOUNDRHh0N0R6R2xRcWdWZEtVMFBQbDg1ME84VVVNQ2w3?=
 =?utf-8?B?Q0dqcWZ4NXhlTXpHYWE3U2RWL0ZmVVhPMXBHQVc3YlRBWnFxbWtRaHcxYjEz?=
 =?utf-8?B?dHhBSUdRcFllRXBVY1MxNU5JY01KVUZrSjlVSWlxTGJjOEYrdjRLRnJHejVo?=
 =?utf-8?B?UnVuN2I4ZWhjYVplYU1FSW1GZkdXRWlER1I4RDkzbC9vWG91RFN3U1I4eE9v?=
 =?utf-8?B?QXlTc0J1M1FjWWtDV1V1enNUbVFPQm9oZ2NWcU5aVlBkc3lKdHhZSG9xYWJl?=
 =?utf-8?B?WlVVSkVvZHhrUFBSVENVZHY2ckZXbmtTblN5NGwzNEVBRkJtNjFtNzNnUk1w?=
 =?utf-8?B?NC9jbUt4M2hmL1dwM3YvNmdyZmZCYmNwUVlHVGVCcGJHMVFCbWxFU0t2bmVL?=
 =?utf-8?B?VFlkM1Y2bmx4Z0h4Vkh0WXVuSG5GV1RjVlJJcDAydVVpbVQveGl0MUREYklU?=
 =?utf-8?B?QVl5cUphQUNRb2tlNldITmNEZUpuNXVHbnhsdXQyMWhidUxtV1JJK0JGQmhk?=
 =?utf-8?B?SklDRVE3Y1hEWHZQM0FGdUxiRW9DclU0VWoxRVdMWmp1M3oxelhlZz09?=
X-Exchange-RoutingPolicyChecked:
	quvMJK80bgD/U9FyFTIA16rel96kF4/Vf1JzVeifkauSGKhf4qNJEu4xMUmr8ipNX7CTbKWSBkb9DzdQcxJ80rlBZw2/lnxPueBYXq8djV7IGHSsGpxQKQh8Yh4WPCwqNGl2f/RXkiKXeIkBG2pSPdRgBy1hJBgdQ8Rag9Fl1dT8W0fuG0BXxuh/g8TGf8EVFzLV/zkaPFWu5O6KOeS0euafXUtZU4UJxiWNXK0OHN/88XWdsF5cLAK1OXHJRwN2hRLiv1w8WTiUPuQmnjkP6JPWnY6YB2c8jjbSAL61A6qTF9PB9/MsxLeVtylQrKa07VwxJhfZR6aJtaD2Vg3k+w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77521e9a-9661-4569-9c6d-08defddac4b5
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 10:15:17.9752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LRrBpW2v78tAW3/QiuWOMy3jqvbnBM3o6VkJK/S+5809zIiK2GF1SVH4fFhlVjLczGkuDYjCm1vQV2PMY6m/jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB8007
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA3OCBTYWx0ZWRfX4V1CJ7MwIVUe
 9A1FO9a4T/btzPCWKpVHyDo9P71YutDHobxAn7QeZF5JmXUrqueslkLWrRAnyUH/bRsa7ime+/d
 jZINYWGVAEk2x5s0qEvN1+nWIYSh8r3PT7FO7i522qG1Iu5Nf0HI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA3OCBTYWx0ZWRfX/gFqTwzuyZ2X
 AOqwOijj3jjGf0MckQOgNHvDqtRydnpwaREaxKD3k+vfvacS/vHt3Rl4NAjV99/oRP5l06XuoCA
 gHVxSVxi3njCBs/gSAiR7CKdDYHLtJcf+l0gJy0theiQLi97myEVLBD9MtGdE6pmGKt79wSOTLD
 aoRdqs/NW7D4ARozsXAoTfW1NwcRKHqkz2MRWdOiH/LepqF2zEQmnL2lwhO1NY5saqZKU1e71qb
 5syRgFB9Zmg+4iOMehZ0T55HXI0wZwCJuUJwAnGIVT22fS4Cd+6ho9vY/v3HCJn4+7SZqNwO2tS
 pKCcipwJ1/whx3eKniuaUM0XoCCzD5iSpL4qBHi2jw63DiNqEqQHxFn/MPDTPRsUDOGDe5/31gS
 0xqxcrsAWdkBlJJ2JYNLmDPxmh5bmsNtgqpJedwWeRoyp1y7jc5k+LZyCZayq0fJa7eJNL/dv5u
 fXloXZOLDzXTINBEu6g==
X-Authority-Analysis: v=2.4 cv=csirVV4i c=1 sm=1 tr=0 ts=6a85823b cx=c_pps
 a=AUZ0YcNXPaZtx/MHT1IOUQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=PVc9NxespNDT0BOkHFIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HxfXmj4uizy8burQz06UG1jaXTmuTRIg
X-Proofpoint-GUID: HxfXmj4uizy8burQz06UG1jaXTmuTRIg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 clxscore=1011 bulkscore=0 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608190078

On Wed, Aug 19, 2026 at 01:41:04AM +0100, Jonathan Cameron wrote:
> On Tue, 18 Aug 2026 17:45:29 +0100
> Nuno Sá <nuno.sa@analog.com> wrote:
> 
> > From: Michael Hennerich <michael.hennerich@analog.com>
> > 
> > iio_dmaengine_buffer_submit_block() counts scatterlist entries with
> > sg_nents_for_len(), which walks the CPU-side lengths (sg->length), but
> > then consumes the DMA-side fields (sg_dma_address()/sg_dma_len()).
> > After dma_map_sgtable() the two views may differ: an IOMMU can coalesce
> > the mapping so that only the first sgt->nents entries carry valid DMA
> > addresses, with nents < orig_nents.
> > 
> > On x86 with an IOMMU enabled, a DMABUF block backed by two 1 MiB
> > system-heap chunks maps to a single 2 MiB IOVA range. The CPU-side
> > count is 2, so the loop reads one entry past the mapped set and emits a
> > garbage vec ({addr = ~0, len = 0}). The DMA engine driver rejects the
> > vec array (prep returns NULL), the fence is signalled with -ENOMEM,
> > which a userspace poller cannot observe, and the block is left in
> > ACTIVE state so every further enqueue of it fails with -EBUSY. The
> > visible symptom is a stream of zero-filled blocks followed by a wedged
> > buffer.
> > 
> > Platforms without an IOMMU never hit this because nents == orig_nents.
> > 
> > Size the vec array with sg_nents_for_dma(), which walks the DMA-mapped
> > view and accounts for max-length splitting, and stop the fill loop once
> > bytes_used is covered - which is allowed to be smaller than the block
> > size - passing the reduced count to dmaengine_prep_peripheral_dma_vec().
> > 
> > Assisted-by: Claude:claude-fable-5
> > Fixes: 7a86d469983a ("iio: buffer-dmaengine: Support new DMABUF based userspace API")
> > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > Signed-off-by: Nuno Sá <nuno.sa@analog.com>
> 
> There are some gremlins nearby in this code...
> In the else just of this context seems max_size is computed again
> having been done just above the code seen here.
> 
> Unless I'm missing something that should be cleaned up as well.

Oh yes! Something I already noticed a couple of times but never sent the
patch right away so I kept forgetting about it.
> 
> Been a while since I got my head into the scatterlist
> stuff, so I might have it wrong below, but I don't think what
> you have here actually works if the merging of entries is
> larger than the max dma entry the hardware supports.
> 

In theory might not be a bug but I'm not sure it's a claim we can fully
take as guarantee.

> 
> > ---
> > Note the Signed-off-by is just because I'm carrying Michael's patch!
> > ---
> >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 16 ++++++++++++----
> >  1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > index ecc02a427b92..bece45381c8c 100644
> > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > @@ -104,10 +104,16 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> >  	if (block->sg_table) {
> >  		unsigned long flags;
> >  
> > +		/*
> > +		 * Use the DMA-mapped view of the sg_table: after mapping
> > +		 * (e.g. through an IOMMU) the DMA entries (sgt->nents) can be
> > +		 * fewer than the CPU entries, and sg_dma_address()/sg_dma_len()
> > +		 * are only valid for the first sgt->nents entries. Counting
> > +		 * with sg_nents_for_len() (CPU lengths) walks past them and
> > +		 * hands garbage vecs to the DMA engine.
> 
> This feels like too much info after the fix is in place.  Talking about other
> stuff that would be wrong is rather unusual.
>

Oh well, I guess LLM over commenting as usual.

> > +		 */
> >  		sgl = block->sg_table->sgl;
> > -		nents = sg_nents_for_len(sgl, block->bytes_used);
> > -		if (nents < 0)
> > -			return nents;
> > +		nents = sg_nents_for_dma(sgl, block->sg_table->nents, max_size);
> 
> So this fun function will generally give us the number of sgl entries, but not
> quite always. It will give us how many chunks of up to max_size fit into
> a particularly large entry.
> 
> >  
> >  		vecs = kmalloc_array(nents, sizeof(*vecs), GFP_ATOMIC);
> >  		if (!vecs)
> > @@ -115,7 +121,7 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> >  
> >  		len_total = block->bytes_used;
> >  
> > -		for (i = 0; i < nents; i++) {
> > +		for (i = 0; i < nents && len_total; i++) {
> So this needs to be more clever as we aren't just iterating entrees and filling
> them in, some of them could at least in theory be too big to fit
> in a single vec - hence you need to do a loop in here that sets
> multiple entries if that occurs.

I see! But I think that merging means that we end up with more nents
(sg_nents_for_len()) entries than DMA ones which was the issue we had
because we were left with vecs with invalid addresses and 0 sized. The other
way around should not happen on the IOMMU path at least given the assumption
that a single sg  entry must not be bigger than max_len [1]. I think in theory
that can actually happen (if we end using a dma provider defaulting to 64K and 
cma dma_bufs) but maybe we can argue that's not our problem? Given
the assumptions of course.

But even if we somehow reach this path with sg_dma_address > max_size
and end up stuffing all of it in say, vec[0], the DMA controller should
also care to make sure it splits each vec if it exceeds the descriptor
max size. That's what both users of (ADI axi_dmac being one them)
.device_prep_peripheral_dma_vec() are doing today. But yes, I agree that
might be a bold assumption.

> 
> If that can't happen for some other reason then I think you can 
> just use block->sgtable->nents instead of the more complex call above.
> 

I was the one suggesting the other call because it seemed what we
actually wanted but I'm fine with just using the above. I'm more tempted
to keep it simple and use 'block->sgtable->nents' rather than jumping in
a more complex subloop without clear evidence we really need it.
Thoughts?

As a fun side note this also made visible another subtle issue. Given
that submitting a block might only happen when enabling the buffer (so
async to enqueueing it) when we hit this issue, we get -ENOMEM and
and go ahead  to wake up poll(). But AFAIK, we can't really propagate
the error code up to userspace so userspace wakes up just to get
garbage and thinking everything is fine. Easy way out would be to treat
this as and hard error and return error when enabling the buffer. But
that also raises the question that other blocks might have been properly
submitted though. Not really sure how to handle this but anyways a problem
for another day :)

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ab2cbeb0ed301a9f0460078e91b09f39958212ef

- Nuno Sá

> >  			vecs[i].addr = sg_dma_address(sgl);
> >  			vecs[i].len = min(sg_dma_len(sgl), len_total);
> >  			len_total -= vecs[i].len;
> > @@ -133,6 +139,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> >  		 * before it can run, so always set the EOT flag.
> >  		 */
> >  		flags |= DMA_PREP_LOAD_EOT;
> > +		nents = i;
> > +
> >  		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
> >  							 vecs, nents, dma_dir,
> >  							 flags);
> > 
> > ---
> > base-commit: b756b143e5391151e577ae645b1378a43f93c2f5
> > change-id: 20260818-iio-buffer-dmabuf-iommu-fic-1b281f15e5a4
> > --
> > 
> > Thanks!
> > - Nuno Sá
> > 
> 
