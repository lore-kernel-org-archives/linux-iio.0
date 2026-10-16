Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94433444708;
	Fri, 16 Oct 2026 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139824; cv=fail; b=leOAqaBrXxdZBTa1Xh9cn0JHo2axVVbB64/G1S3RJ0LVZJVrmt3111n0NR2J78oBYVwh+CMBaq8tuhfIcQvi9KBN1jCsyos+QuO0jxDSyLS6kErJE3CMF5wntBf8j56ePOUDNxH8kxlVp2W53HfN1vBSi7EozYUDoAxqVabqdn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139824; c=relaxed/simple;
	bh=iEvkWNdRevZrcMl4o8jjSBJnq4Hb6tO2XKEnlEQ7wBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=esvEJGwzcWio98sEeLy7tPSCw9J3ptfiuP1qT29qmG+qjv7z2bgcT0hL86JpEB/bZSbLBblsoDBNpywIn2xd9GwSZhNYkGe6cRRyyHxi9bJGHQ0b5qkuUJby0ZAyCgd47Xs9coBFGC6ly8HwOkjCmBDCSqOgEcyvBqJJqV65T3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=lQncvwGC; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=z1EdkC9j; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="lQncvwGC";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="z1EdkC9j"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69G7V6KV2303896;
	Fri, 16 Oct 2026 04:36:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=/eU5rQKx0E0dO2uPms/ybfBgu+GmENOZycx2PcXZ/aY=; b=lQncvwG
	CjqBbGmQMaW3l1VCDMoVkFT8CtZv7yDZedfrC38f0dFOoqys8AwR7qcf5NNXIAzR
	5TgqJ/9Q8gMiYGkFMu2kFNOi87gxvF1w6o3Z/MPBqSxvtGl1e5suFLQd/kP856cS
	7rjpk2jiCjHTy8vgwTsKIGob+XO+Jr6gsPdrnsYnKBoOj0tRPtLnWIXIqYUsDX9Z
	2MPOsBC2DPu5+l0Z4lYMH7G8gr/VaebXMj38ZP67k4DIdV854O1gqLw9NvElA5EZ
	2ANdkfm4A7KsCkZAkWo6z0Pfn2u/ar9WkfqgD9xvR32MW51Ls43j9zsm7XzuqWU/
	yJOmCXEo10KOKWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=/eU5r
	QKx0E0dO2uPms/ybfBgu+GmENOZycx2PcXZ/aY=; b=z1EdkC9jf4R6fxtcz18zC
	bFUvitF+M5KwIGi5sATDMVwajird87dIh29tTcbQ4AuH+NvrNNXTbWLLRHg64TEG
	lP08e20wez6TKqArRLxEpl1CQ/1xuQO89p/A2COO4Nk+SGswU2aa6bp9mhzBiJ6E
	Bh6PWOnhUmOD621vcLdXozECz8geTgihlQOquYTZrPW7dsl4o9OyjyCEor0+bz/j
	QgebRyvi3OJ1Mq+DmPMpJ02T/0gBBVQQaQof3viz+fighdDIknnHYcs5uxbSeTKC
	zXz47Scuc8e15YgDTiwfU7hjuMaVKQuct/M4L3FxmHhKtuPiH5a11vV/jnUOcj9j
	g==
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012067.outbound.protection.outlook.com [52.101.48.67])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hannd90c8-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 04:36:44 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IN06fysqJYBXBEpxEaCoRcmmNmT5doCXX6kNS1fsv3fON7qjAvtfOc4lGZqlvZT6GHedwz3oAJzxCw/JX8Oyax/xxHGpZJXXMCZ3mzv4I3BGlPvq21c4GaPcaKjR0yHVailX9b6sGTldMKXeO39pR70EZs4vqBkNPxT/1DTf7h/l/PREEzPT8xpDSV2MO3yLUjKUaEMwBa6gG8vLfycfMsLiJjW8yAJkOv0PanRfgGwd47YsXJ/CoVO8/SOHhAB8dp8ws27fldFKrfTtskamWRdSIl4y5RZqytTH9mtue4/Wk0id7+JzqvZcc+TC/7r1bv7F0f5ridOOuYLF1M5y5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eU5rQKx0E0dO2uPms/ybfBgu+GmENOZycx2PcXZ/aY=;
 b=reA77mni3ktmOLR4NDZ1jfJrikXEgz1J9E/aqZ5SCPCPQCN7iO4gecbCfD1AVj0Gg1PD7y1n3e2RAqm7pxy7vXHENOKuIKKItPk/qSO2YHE9HvMwk9OJ9yvnVQDbOzYpx5DEq/CMdHfOKSRzzct+lUz5VDiwYdx23M2TD2H4ZEsFdKlLwCBVqEkvWbjvo37MKpliqrisyCVGbcP3naSYPPdg/v7qLR1Y9B91RWxpP+aIXTlVizvgg/ww5RHPOBtsOUyR7R3u1jIBRwKCl0Fip5AEcRH1wJCuMthk9sDIq5LKx5t/aDY1hBOE+J+s1MAiL5AQIfPyCsN+6EivSLu7yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA1PR03MB6564.namprd03.prod.outlook.com (2603:10b6:806:1cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 08:36:41 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0522.013; Fri, 16 Oct 2026
 08:36:41 +0000
Date: Fri, 16 Oct 2026 09:37:54 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, jic23@kernel.org,
        andy@kernel.org, dlechner@baylibre.com
Subject: Re: [PATCH v1 1/1] iio: Allow device drivers to specify IIO event
 unit type
Message-ID: <atHhvhEahMT7TonZ@nsa>
References: <e359fa003ebc61c8b0e37ba9810a04c70e5a300e.1791437050.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e359fa003ebc61c8b0e37ba9810a04c70e5a300e.1791437050.git.marcelo.schmitt@analog.com>
X-ClientProxiedBy: PR3P250CA0030.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:102:57::35) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA1PR03MB6564:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f4d3f7e-90bf-4a1b-6fad-08df2b6099de
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|56012099006|11063799006|261009223027099003|260925022911599003|260925021911599003|260925021311599003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 PMNqUrefABhLBhq6YnOtHJ62ehkVVIsuB6CI3JIOD2GtOCemjc6WWNmrpaKUd9mRCUBsBaTOGJKw3NMi3tyh+JClNwpn3L+i6hAO96C2vjgZMPfK5nin+ipl0xtnhwrcMMbbuHOn6gOOfg+4FPSmxFY4cfUPT6oe4xQb5r/O3fTsWUYmD/zwNLbZnolTIXefjvqkIqkRhAxbgpfleS4qp/VTmU0R8iFTtnPIFLe9SSSDfsT7Fr32vttNE1C4qkfHBVKYISXUguF73UBqB0PxwGDNUmj068sRdFM389VA7evwuI/fZbcHWi2lml3uWqi3hEf2TYLq3UD3wJiV3MZIxLXEN0GbILIhM//o37dWFi63AgSi8b3HoUkrboph0fILV0Xn8s0OrzjwCqj8yihHfIFVUpqbO/4JNvKPjL8LAgVwBojMOzGIs8D1XUvcrxnKfBcZjzBmWv/MiPdjCqtAIQ/mkgVtgOhJy8b5ZM15G5QlGAqyB1a3H9j/2/RykqzM1aOPjm2O7PWoQ0Fr/BE48HKbtG9rnhZzkVC0O2tgOKFxNUY5PWxekN/c6UCeUg6aufbibhVyocD8kPkgf62DbvvHe3Z5HC5sv00U0kOXbI5dqspZBXGvihC+jWzqHmwO
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(56012099006)(11063799006)(261009223027099003)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?anBqZXpZMDVuNVdQcS9DT0tiNkQvSGRRKzMzbDBqTWpMWGFLdjBWZlZ2cGdZ?=
 =?utf-8?B?bkRUUjhRSE42WEUzU2U5bUw4VHlKeHR2RGNTWndybFF5SldJY1JmVlZwUktC?=
 =?utf-8?B?d2R3bkg1aFZIbmpEbG14S1M5bU1vVis3NS9IM3NYSGRibmJDOFFlSGp4NmR1?=
 =?utf-8?B?NFlmSXE1cE9PUXd6WDl5Nm5EMTNtRUtWSWl6TGE0MVFzdHlYM3JQd3RsTlBM?=
 =?utf-8?B?SWFFVG04MXNXK0Y4b256UmxFZXJqSjcyVFovMm5oVXpwQndwWWIvdGcvNGhk?=
 =?utf-8?B?ZVlqRTJZeXNaSVNjVy9UME1lY2h5TDZoV0k4RmNPN3R3UWxJUmdRR2Eyakxh?=
 =?utf-8?B?ZXV4cXVuNmoxNmF1VW5QdmtKeTFFTDBWb29GVFZsT3F6SEFQUmkyU01KR3RL?=
 =?utf-8?B?QnAwdHpWaXNsemY2MmMvczVFWDVBZWpaWWdOankxc2JzcWN4WWhNK2dVN2hW?=
 =?utf-8?B?REdybElDVmR0anNUMFJFUnNZMTVKcHlTL1gvV0k4MmczajUxcGNDWTNEL2h5?=
 =?utf-8?B?N1ZtQmdyT1EvemxxdWVRNW15aXRqaVkwbGJTOWxQVWxFL05WeFlkdnhaWkdG?=
 =?utf-8?B?S0kvemNyajR5eDhJUURxK01DWmhLelBLWGFxM3ZBUHM4YWRRN3RoWlBCM0hw?=
 =?utf-8?B?QlhraWg5bENiS09qWE5Hbmk5TWQrb3FwS3Z1WGhRZzZKTldWSm9HQy9RdFh6?=
 =?utf-8?B?MkNtQlAybmQrY2xlOXYvcGdNN3BsVVRzb3hYamxPZkVwZkZlQk1seXEraDJZ?=
 =?utf-8?B?NEZnQWVoQUhMYTNFc0pTREZ0VnFlWlptcERqQ3FjbVE1SE1ZUUZyT01weHZK?=
 =?utf-8?B?RG1CMzFZeVlRTXFpaUJpb3B3KzB6dGhBb3VWb29wcDlpTXZTNnVrbWRDbXhO?=
 =?utf-8?B?ZGRvVXZxeGlXR3dDUElqd2g2Zmt4bG5MTDY0K2xMZHpidElWd291dmI2QlhK?=
 =?utf-8?B?ays4OEJwQk5zZlg2aG5jei96Ly9Jck1yYzdjS0Y2Y3ZOWWJqTFJudFRiWWdH?=
 =?utf-8?B?TFZDZlhXZ2ZkUWFXNjR3Z0JuTGFJZHE0ZmdtRTV1bGtmdEg4elBWa2NGWWgr?=
 =?utf-8?B?YjJmOVZXMFdMTjF5UUtRQ1VWbG15MzFaVXVFLzdLUzVnTE93VzdKam1NWUdt?=
 =?utf-8?B?U21aOTRmeWNTaGRDV3VYN3FnUXA5YjAyNzZua2FTeHk0QnE2Q2JVVkJsdWxo?=
 =?utf-8?B?L0tleE1aTTN2UUhiV1R5dlJycnVESktIVUt3VkNkWTdKMExrcFNJTjRDRlpL?=
 =?utf-8?B?QWVKMDhLYk1pTWJjUytSa2FIUFNqVk1NamVtdVFKRllBUEhYMXRlbTBmZEZY?=
 =?utf-8?B?cjVKZjdHOUpmdkNybGptR2xJcXNhTkxEOHRlSmVPQjh6RmQ4eVNlRDlvVm9U?=
 =?utf-8?B?TjlFNXVzbmhtMzRJd1MycG9KRXhvUXIrcGE4SkVvbUtENVRWRVJxT3MwVEo1?=
 =?utf-8?B?dy9UYVdYR3Q1dGEyVmhEcUhtejZOckREMnRqaEpzdTdDRUlUbkU4U3JqcmJZ?=
 =?utf-8?B?MytwQkVReGhJVUhieWcxRmdyM3F6MWpxWkJZOUNKZTFkeTFTZG1VMmE5VGtj?=
 =?utf-8?B?V3NRV3o2ZFVyZ2NFSjN4ck52NHNpQjJsT2xqNDNCQnA0anhDNXNIZTk3cGVX?=
 =?utf-8?B?S2N1WDVuZ2R0YjgyK2ZTdjRMNysvVDVkT1dXRm5TYklNbWVTNEg0MjVuKytp?=
 =?utf-8?B?TWdoMGJYVXllZ3BIUWdmVHRYSkxSdHVVdDN5TFdHNFVLd1c4UVdCWUloNHpP?=
 =?utf-8?B?eGI1MmYxNGRoczVUdk0ycTd1aUtiYzdNSkpNOXVaZmlQWm9obDVZT0lLQm9E?=
 =?utf-8?B?ODBJS3NOVVI4VWo3bHBkRGNmS2JTRmN6UzIrb21USmw4SEFCQXAvRDZ6OGtW?=
 =?utf-8?B?Tld5Qmd3b0NTdXJMQVZNRno4U2hOZ3lhcU1TZURNMVM4ZSt1NTR5VGFmbGww?=
 =?utf-8?B?T1ZJQVpzWlNMMTVEQzVvcCtEY0psaDVvYVlEbE4rU2xJbUpmdGt3MW10SXhz?=
 =?utf-8?B?N01sT3RQRUNab01xd2lXZ2lLcWpZcVQwTEZjaE9oOXE4cEljN2xKRzNWWGdW?=
 =?utf-8?B?SjZmbEJXd0s2VVFObVBndFV6d2V2VnJ5cC90UUVydG9aT25BNWZERmpUY1RD?=
 =?utf-8?B?T00yaEFNd3RiUGdxTXE4SEdZSHNjajdIS2tlN2ZQeDI5Uis1RUYyczZocy9R?=
 =?utf-8?B?TmVqTDB4NU9LMGRnaUgxR2lnRTExWVc0YjljRWxHM1pzTlF0L2VtUnd3Wi92?=
 =?utf-8?B?OHRKeHRMaGtTS0NsYmFRK25HWGs0NlcrUXJhOS9qc01wWFBCTmRaRk5DS3R3?=
 =?utf-8?B?dDVXdTQrdHNOc1gwdWpDdEFVSXUrSWN5ZitERi9KSTZ3dnd3cGhzZz09?=
X-Exchange-RoutingPolicyChecked:
	ku1+cCnam77GYD/VqTf8e24TKn288GzvrqNMFNwQlzKutkF3dUt0Ho+71IvYbTP4qrUfCVMXj/VfmaUWqhD8mejMAZ69QJjaRgVTQVYNG49cRLugO3RH6tHwkrln36PA++IpSvHmAdN6CYx5j529cIo8NV6125sUJMjy5GEe6KV/NwL0pPQPGQBgYqET61hX1Jpie5RuoRVOftgL9ISUyYupc8T5TpWnV2qN8KsicYmtTbBhZ62F1YoVgZtaAs12xmFcJ7JA8qZnI1eEqujiBY3fIz/CjM2R9USYqPF8BOhuKxr4oikNHQZXHdNYX5+FmAYR88rECItXK9aIqbPQjw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4d3f7e-90bf-4a1b-6fad-08df2b6099de
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 08:36:41.0559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bYwsQeLVtaJC1cpBu0jkQ6ucG3gjeQ5Dpop+bBHp5hE4Zu6Z7pV/nY5zKNnxFzdtk55ogTauMmOyC3GE9GOu+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR03MB6564
X-Proofpoint-GUID: ncRU1Q7NRFGRKy1bEjwQdMQMIAtBCZAu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfX/xQ7VNH36Nbr
 0hyG10wXfxpaWWbTzTxcEQbSd4ar6GQxh+u2YxKdzMfr2WNNsZ3vjuXQQf2jZWnN+vbCKsDrr5v
 RTZYJT5SZhT03t7FXVHH2W2TWa+O7QHfTZlMdNeuDJOhlPFWDUOO
X-Proofpoint-ORIG-GUID: ncRU1Q7NRFGRKy1bEjwQdMQMIAtBCZAu
X-Authority-Analysis: v=2.4 cv=YfkodARf c=1 sm=1 tr=0 ts=6ad1e21c cx=c_pps
 a=9ZCHOKVckkl3mlSiZqIMSA==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=KEO6vybOaMN2idIX2PAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDAzNCBTYWx0ZWRfXyOL9Y4vj/nbU
 ayh48LtDJSa+w6NbE2pwAv1+Y3ZjsmS64sl9JBnGzRyqAQPy07ot9ScGFvCFQZ9UYkC1f+l6Sxr
 qRjl/btIF6zj6FdWLhGsxMgx0leQXvSoMlSGXhEWGXA9EpeP2S9WT4JQBmzqAdcGVb6xKTlKDPw
 bUMGxxPEaGmLSESyNqUwftS7yCfRIqelyRm4/wn5eZS1WOmpV9N2P3je/gPA+/7rgE4R6BRzwi5
 6XIRZKQlsas0NR2wyFiYdIHNMVIAAfvBm+TUkSS+BS1M1uhPDml9vBi7tcFnikAQBln9+mkQZuV
 n/lPc2M5uUAwLul7yuOTvn4iET8RNGbTEPi9eWRkd8Ij+bwTRTEKp1i2GP77xQoZQBA6hA1OCrH
 A1EosV9TkAnnNZtLLDD3hbL1YnceYhh56ygYFNQ+pXb28xzJZ1Op0UCb2iwqoosjVaKKqWFCYq2
 1oTxoH4PD+UkQfkuFuA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 adultscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160034

On Thu, Oct 08, 2026 at 02:27:15AM -0300, Marcelo Schmitt wrote:
> The IIO event ABI documentation distinguishes between interfaces that
> handle values in device-specific units (_raw) and event interfaces that
> handle values in real-world units (e.g. meters, Joules, lux, etc).
> However, the IIO event code infrastructure had never really implemented the
> bits to distinguish between those two types of interfaces.
> 
> Because distinguishing between device (_raw) and real-world (_input) units
> only makes sense for value and hysteresis info, only add complementary enum
> item for those.
> 
> Users of the IIO event ABI should, as much as possible, match the event
> unit type with the channel unit type. I.e. device drivers that present
> device-specific raw units for their channels ought to also provide event
> interfaces that handle raw units. Conversely, when IIO channels provide
> processed (_input) data, IIO events will generally be expected to operate
> over real-world units as well.
> 
> Complement the IIO event info enum, allowing IIO drivers to specify what
> type of event info is used for their event interfaces.
> 
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> ---
> This was originally a patch series [1], but the suggestions provided back then
> allowed it to be greatly simplified.
> 
> [1]: https://lore.kernel.org/linux-iio/cover.1768759292.git.marcelo.schmitt1@gmail.com/
> 
>  include/linux/iio/types.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
> index d8944c9e5e90..bf03eb498753 100644
> --- a/include/linux/iio/types.h
> +++ b/include/linux/iio/types.h
> @@ -15,7 +15,11 @@
>  enum iio_event_info {
>  	IIO_EV_INFO_ENABLE,
>  	IIO_EV_INFO_VALUE,
> +	IIO_EV_INFO_VALUE_RAW,
> +	IIO_EV_INFO_VALUE_INPUT,
>  	IIO_EV_INFO_HYSTERESIS,
> +	IIO_EV_INFO_HYSTERESIS_RAW,
> +	IIO_EV_INFO_HYSTERESIS_INPUT,

I might be missing something but how will the new values be different in
terms of ABI? Shouldn't we expose different interfaces depending on RAW
vs INPUT? Naturally we need to keep the old IIO_EV_INFO_VALUE ABI for
existing drivers and encourage new ones to use the new one. And if any
existing one wants to convert to the new thing, needs to keep both.

- Nuno Sá

>  	IIO_EV_INFO_PERIOD,
>  	IIO_EV_INFO_HIGH_PASS_FILTER_3DB,
>  	IIO_EV_INFO_LOW_PASS_FILTER_3DB,
> 
> base-commit: 04434a1d0f311d76b1f15fa987918b471a0b8c6a
> -- 
> 2.53.0
> 
