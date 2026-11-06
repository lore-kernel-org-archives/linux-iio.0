Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.87
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794003938;
	b=zk8/qi10toeW+Jn5lbhM6alVLnEf0j19vxRTCcih6UtpfHJq1HTaPUIXLR9EBhOber0E
	 rAA+EwZhOL4WBNWDH+5Yd2/Ul15fDQdvQRPfbllVxK4bZ5Oy2+LCALo1Abb3CTzfcjtFH
	 5eT3CRYGdllrvUUJ5UPkpa9KKkl3sq9ziFXgFFziVdgH/cuy6AJ4UtWKTjRV76d5j9GCP
	 w/tGqFTpdLBp0HvtyTiFsbxbSazQ3fDrNEpemi0FvLkt7p8TpTxQsXiUFPB04LB/0xlYf
	 tnXzs/duwzu74xp5xdRlngFGtqFPuwXwmnT67WZwkLhsHK89lRrM6mEYB7EcHzNa5xg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794003938;
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
	bh=U34laXFy1ddLBiik6yOhiPqXltDopEhd2ewSrYeRGBI=;
	b=zbg8qZsa1fW+Jm6IZ60g3xOKQvpOaLwAYUEH+mk+Ow1U49lqDtb2+eNOf35ld9n6F4WI
	 yhttIxPyjSRkXvm+G1BL6gRo0yeX4BwiSpag8PzGNw7I20rJ14Dbx2BqQGVyIBjZ4PoIu
	 5tcAsNJor92DL/4F3c9bGA5Y4NmrtFLlR/MUd8XXkkgGAQfuZ+peTyDLLEckS1t2Qnte9
	 vGDdF30+Vk2MjjgmTolGuSNFsCDut0+BgK2S/znt2mDZQI8anUVX7KOS4pEv1j6n9gTzF
	 yxZEcC7KhXh2yzbs97XsEoubAHbTLUFWBxz+xIZMxABl+iQYhj2yWMRqovOgTBjiVjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=outlook.com;
	spf=pass smtp.mailfrom=outlook.com;
	dkim=pass header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=fu0Fqi0N;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.103.7.87
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19013087.outbound.protection.outlook.com [52.103.7.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E9F606A326;
	Fri,  6 Nov 2026 22:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2E9F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=outlook.com header.i=@outlook.com header.a=rsa-sha256 header.s=selector1 header.b=fu0Fqi0N
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sA5gWC3Zf56wGnqmYNmSRM4LByCWjkxkuJRsjsJoNPAnKBHqA5epHelkaLc3ZaRV7Umv1UYZsO1H9GmIXoni1kw+uWcKONpclfjEtkl9qaXO0pkbLxSqxwtofn76uJcnSReXDsJwYE3TmXd1sl9cAhlTaqQzlTQ6igkKv/XP1MPlCu0Y4mHrdLOl15/y779rWFUjTGsw14xJZaKozYwCWoIrkJLWuepantHkqGAnrJC0cgCyXN/FQeFD9rbD/Q5Gs8DORgh3DD2fQ6htOHvsH4ZciF9ubUEfVNqmbuul8YQx7FVY4jRFjtqM2dSHhRaC6etnG7NIkuhVHudxaHX7Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U34laXFy1ddLBiik6yOhiPqXltDopEhd2ewSrYeRGBI=;
 b=rXtPWTq/hZJj1AXP1y6GYnzejJ4DUvW8s9SGSkiMdmRNQBdeUzJdOOeehWEXUkoOXx/ZzorL1E5QoLNlX83mqCjaR4AIkUitw3x5qDtxWoKnKDLvqpZJRy7V6pHLQ3WchCG3mgfiTkiblvbIiNdSsHiKivqds88jOVLitALSzhewaiUfyTKmLDhIODwOKmKSZZ9qxabObQ6bDnFGWQYfDwJ1fyFogtAH71wejaiD03U+8ijy6JruSHNEGesZnwYD7LFcXHC9pykNyJSYDq2FqJf3QJVwCaFXy9giBBKW0C5s1goz7ZLxdTKcQg5nUtH7QuRNmMYTGSxKBwgIWzHqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U34laXFy1ddLBiik6yOhiPqXltDopEhd2ewSrYeRGBI=;
 b=fu0Fqi0NRdwjlilFb6fXA20C6EwWJYXsAONIefw5Q/h+gyQK2xykoYtY0XUJK0sXFf+PV4YeFKJHMZDhYPdVozLnr9iaEst5wgIP8DYUwBenyYAME6nZ8Yszf/33vwvJOUM6Qy7+JibtN8K8yONpc6lq3u7xXqO2r6cQ7vCIQwbqOFINdjKcJT61dTHNbZ3+mDHu5973yFsrN5GKcMDq3zGlLwwpmW/gGJFjqyt9/W/QfaHX4JJSKta/RrN9pWr8Wv2q/7Hz0yr/i3Q5R1s/jcMCJN4LrplQQ57TmCOevJ97w3iNEouzzbMKgvnp2gMGi7jAckLrEHdARGhAyln/dw==
Received: from SN1PR12MB2528.namprd12.prod.outlook.com (2603:10b6:802:28::33)
 by CY5PR12MB6430.namprd12.prod.outlook.com (2603:10b6:930:3a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 22:25:33 +0000
Received: from SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a]) by SN1PR12MB2528.namprd12.prod.outlook.com
 ([fe80::9875:58c0:928e:cf0a%6]) with mapi id 15.21.0592.009; Fri, 6 Nov 2026
 22:25:33 +0000
From: Victor Chernyakin <chernyakin.victor.j@outlook.com>
To: lkp@intel.com
Cc: andy@kernel.org,
	chernyakin.victor.j@outlook.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nuno.sa@analog.com,
	oe-kbuild-all@lists.linux.dev
Subject: Re: [PATCH v5 4/4] iio: cdc: add Texas Instruments FDC1004 driver
Date: Fri,  6 Nov 2026 16:25:22 -0600
Message-ID:
 <SN1PR12MB252803226E23A0F6A7CB0384A5762@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <202611070503.6fdgeWCZ-lkp@intel.com>
References: <202611070503.6fdgeWCZ-lkp@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:610:cc::24) To SN1PR12MB2528.namprd12.prod.outlook.com
 (2603:10b6:802:28::33)
X-Microsoft-Original-Message-ID:
 <20261106222523.900754-1-chernyakin.victor.j@outlook.com>
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
X-MS-TrafficTypeDiagnostic: SN1PR12MB2528:EE_|CY5PR12MB6430:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2485fc-9ce1-4d28-7870-08df3c54dea9
X-Microsoft-Antispam:
	BCL:0;ARA:14566002|19110799012|15080799012|260925184616899003|8060799015|24121999003|22091999003|23021999003|24021099003|25010399006|5072599009|4140399003|40105399003|52005399003|440099028|3412199025|26121999007|1710799026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tG4kA9FkcJvRomPNAHviiBli8uCgDR39UM2c/CbqwwtpzutCafhcuTWeBVAJ?=
 =?us-ascii?Q?pLcb4zUvPTyHlkfswpytNZCUxxkcCggdWmtwXBinKmsMFM7y4bskL44Wpgcm?=
 =?us-ascii?Q?HX4gs0T9lVBr6Z0FSKxg77g6MX+SwXthQbNACPJ9BTdsJa89BfOK2KGCAty/?=
 =?us-ascii?Q?jLqHQ3YRMH/TxDk/btj3/2r5ufDtSCca2qO3xpi+bXK9CxVKyfZwgVZL38w7?=
 =?us-ascii?Q?kpYmKdihdGGEEqJEPH42n4nJ1YHVqLc7wiJ66h4mpGoj1obLyFNgFn9QRe0i?=
 =?us-ascii?Q?0bIL+WMHBWsH/NWfYxXuw/kQXtpDjYV15hcyrhzPjj5PVWQbm2ByPE1Yz2uH?=
 =?us-ascii?Q?7eLlA5o9BvhKqQlxcUKNb6y1kTbe8L1v3T/dBNiBeeS8e2QTQpcHsrlmsOnI?=
 =?us-ascii?Q?pKJYBrtqBydatFQX7cU/14L31xxQVGcMHxUR4yT2P7g1PLCX2inIuqZ1Gvrn?=
 =?us-ascii?Q?sABYAuKRKqAqL+3/xwZVa0WRCyLljTNITH7sTKsw8spfzJGXubNbFBhF16x/?=
 =?us-ascii?Q?onbm5QbBRE8CamzYOUncjLxpvVWo2ewdOZk8uvTKQMSXobFFqX09KvJM5RKB?=
 =?us-ascii?Q?NcgAhqITXOpI55+mCbSp7j4tIHolFQ69IHAZWmF7we3HvFbDueDcW9y2ipex?=
 =?us-ascii?Q?bPsF6l16/FqXLywWzqvEEmBfT25DjfE4uxFZsVs4FqoBHxHPWqRDqXlvw9Cp?=
 =?us-ascii?Q?h6Ao50mX/GmTRv897ww8omCpheLKZBg82WSL7IBxoRljpBuuxX1IfWY4jLa8?=
 =?us-ascii?Q?S9qDiucloDytXgzDSBJWaFUFpvTJOI5OELcF2Ffw/pCdovBIYjtG2ht46rOy?=
 =?us-ascii?Q?S0tXKov1Iv5G8cXT0nbBu0jUPRXgP/vxVyzZVByFe4PoI7EVf8xt6LlHzKpx?=
 =?us-ascii?Q?3LHfBiFnqX8M0Sb9PsDoFgvyLUf3If9w0/h8KLjnnDIeFJLVZwdjULlmwEcc?=
 =?us-ascii?Q?K0YYOygjXTfR4KOSo1FCMnLLi1Ry0Uq6i02pUfUTSrqBRYQ03qVbT4yFJD2m?=
 =?us-ascii?Q?pJ8CupvxcCbGyFVVDMwOo6qYGJdFUim2359FX3yFKnQBYccjrADtc7uQFEg4?=
 =?us-ascii?Q?jV+stkbh?=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z+ZTpr/1/EEuu/bIwZm8uQlOFsKO5VbhSxNpRAlEneQWNZP6H9Olprn7SmJC?=
 =?us-ascii?Q?y14G9PpnF6ua7pgPboxCrY+wwGe9i/GyIMh+3C9dNZtIJGYzGrTglLqduCXF?=
 =?us-ascii?Q?aaHPWypN2mw73e60NTsLWTJF0GNBoshmOdiy5PpSR2WcvVReWn+wb1Z5AR40?=
 =?us-ascii?Q?2PtlQxaVV9qih3kCvqw1WQcF3ffaJgW+mhMkB1epcWoVJwLfMotjdG+H2SMC?=
 =?us-ascii?Q?CRe+cEuGm4qiygYqT1N2WK/MkI3db/SrlHYBejFl2YoTH3pAc8GeR2gTF7NL?=
 =?us-ascii?Q?jPnBIPMH119mVZOAravuu2wRmp6oU7hZWubmecFyTfxshy/PWHk0Uy0SqCp2?=
 =?us-ascii?Q?uTnz/0m15WdgNGwG9m4rM/96tvMKuyj5a7qWt3HnEnbbTUiKC6Gtgd/anOPN?=
 =?us-ascii?Q?LV1VDNiYWatU+N+hUOixAXwmw6M9An5UldXO96n10w6d23WtKuS2LMjBD5YW?=
 =?us-ascii?Q?wDbtS23tEzNUzkf/AL673hcYyQ5DSo3fzMb+WaQMsS9DDKXtk+EhTGI8kfiB?=
 =?us-ascii?Q?rYNiL81EaVDY4eCDbqLz7Ne47mwkTOKbThNUwC5ekcYoaGqgk5JSlbVW63Ji?=
 =?us-ascii?Q?J8/DC0HwdFI9B9wreZW1b0qbbJs4uKA4jz/oj2XjrBoO6aLOKZmtY9hGMZFB?=
 =?us-ascii?Q?xFNn6foRmJ2SQ30VswCjDpzJNUulOH6yfUzmEx7Co5mLwrMEeVgoxlXJd+oB?=
 =?us-ascii?Q?NTut4mJHeOTkKMZ39htv3cIoFoO66ZZyYoXxiqScHDM/AsmsSFlZKrDQkFwq?=
 =?us-ascii?Q?dqk0Px7Wd9lmX2TtpxThvxJe0iqqLRHGObulGy9COeqRdoE9bLQWh4YOPxVQ?=
 =?us-ascii?Q?5shMHhnkH8OHpJDRnxjuhIYW/gnDOQ7DC0gNGCrcC55VmnSXMLigbLHQIR9Z?=
 =?us-ascii?Q?Qszpa5ZlsCY+kslaPnPtW3/hRnwhvBfk9zkq1XTqFTnbsWD3ExSiUf7075Ec?=
 =?us-ascii?Q?LxmiGTWubNPy0ZuaqQ/Ha6jAAOGiqeCjjv02H0y5wwHMbqzz/AxWFclsJCXi?=
 =?us-ascii?Q?fcRN2avxn/og+jq0dg+/AMBN+MJVmFCdx3AJ6Z6z3cDT0ATzU8C4HVEUhprE?=
 =?us-ascii?Q?W3KcxcfmRD4SspxwymlzIKxwUe/NGOdeP0b7s+gzZ4G8j6Fzlm+5cL9J8u4w?=
 =?us-ascii?Q?gJnMFvB4486FXTPlhPMHvC5HesXmNxbe3KKa1Npvd+Mvzm3x3i2TDthGyOR/?=
 =?us-ascii?Q?fmc79r4mMGIJdzaJQ7vp7gr0AshALrJwqko/d+AshWSM+DUASnj8ZmKVgKcw?=
 =?us-ascii?Q?RyhNXH2fb/nYzryy2xrMMJXUuQmmwrlUZGKoY1ln9QvGD4ZxoHnaxMjJSJcP?=
 =?us-ascii?Q?LqTKVpQazGlLiMoz0QSgiKNFmiW5yz+/YYh2P8f6heVsQ2KVDrU/nPKbcH+m?=
 =?us-ascii?Q?enyiuElGenCIyittYo8z1cod0YyhDvEJPkesxeIl83ViAsmYXQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2485fc-9ce1-4d28-7870-08df3c54dea9
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2528.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 22:25:33.2718
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6430

> >> drivers/iio/cdc/fdc1004.c:67:10: warning: integer overflow in expression of type 'long int' results in '-1246822400' [-Woverflow]
>      -0x8000 * 488281250L, /* min */
>              ^
>    drivers/iio/cdc/fdc1004.c:69:10: warning: integer overflow in expression of type 'long int' results in '758541150' [-Woverflow]
>      +0x7FFF * 488281250L, /* max */

Switched suffixes to LL for v6.
