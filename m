Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8972454EEA5;
	Mon, 31 Aug 2026 15:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788191744; cv=fail; b=E0zSXZoX9G1rr3lMPGU/yUwAt1Br7rsfx3DYa34/1RWg/oRRGamCfA9c3DOrpFGES/U+NtiuHfX93uMiw2cx6Q8GuogFQCMX9qGQTPCu/H0HozxR8V0InYs1F2I9K1Oh+SWBwY3XPB5GwI6ox+OEVC+r8dus9Nn+GNCgsZtfF68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788191744; c=relaxed/simple;
	bh=7k9YIld6QzpvYVC+Y2Fdn9PZ+2R3i1d6Hql2GGSv8Zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=klIOFkH6TpYuH+iXJsbtidEsoCv+bU6gxc9eKMmCb8eeiU9dRCHldLbSDazkymd777I/Hd69wj5P0qv1TCuJ3fR0woyuHjiyypCS3kOBJ797w2FeSjE57JfYePLoba0rrPKmzn5/+OoPWrc8tYBbehs2p6en6DW6HcFyDQPlG6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CpPzIwci; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CpPzIwci"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VFonIP1530818;
	Mon, 31 Aug 2026 11:55:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=dlUvh
	KrtghcI1HbKSDU/BTMC32LPULfqoK3R2qJiegk=; b=CpPzIwciKO/4y7tUZObVg
	+559d6HtTGYx+qnTKD+2I77aqThUdKN0Kl/ED/fYKTMDQFeQ6RiJLZr19yKBTzhr
	HDagFY4MCR33lsGa6WcVzxj3i43pdI7miq+LbQXvzhISdNs4eb9gIsmeqgHfd7Da
	NlSfIb1p7GiGJmofuzsvlrCZD3WSHddFwlO95pYWdTg4cg0On42NUR0fFL3nfvF1
	tAn/8SGqUlWeAqNhzKkT6FAsnwUrFAgKieFXlM4JnCGA4+jXLdGuvxfJwCA4tOb+
	e88UgmVIhBHlPAhUTxCsgeLl+83ZGvAmRIl4+E6zqJQM1HJX1srNq62XITuKJuVr
	g==
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012065.outbound.protection.outlook.com [52.101.53.65])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gbvb2r50g-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 11:55:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DdhweVUfv4FIYF3ywaqKkKtOygn6u9icxwmB4kuOmlcOcYacWanu+HLg6C5Pium8BEfnK40vB3Ow79xts7zwH9vgo7TLFAOheHvqHYnKEHrG7a54n5FOsQyi7nvMAu69iKvQ0hGtze3VxrjEgs/oqRmOfv33pP7/f9kZdBRM6AQ7h2Nv0mqLAsrvwkl5q3vFEczfJPU0uYxHRN9eBuY+3a1BaGb8ok2cABUb8MK0amnc2/JMbHaCEb6pmA8w9Lve5i4jLjp334xTLNAvW5XCX7h5yFeORpcnNLcprG/MZlTyuSVACF6YAEt656u4hyHv4bhSXqrRblQc0fyvQ9aWfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dlUvhKrtghcI1HbKSDU/BTMC32LPULfqoK3R2qJiegk=;
 b=w5hhAgXC9vra1rJTdQLBIQW2qoamXBmftEB5fANmHjgLBD4VOgW8VziBblPx5ULChV/SRNfT+FG/7oNvAc0pqRldOCABgH798a/q1ZjMW+ACVK1CGqjJJM+yapKFQU9CG4arZZzymbDkuyfAyqBey+ClkSDfgOE1goSbytWTJiTEglFnfQZ8jhJUnj6lOPlkpIo4qnuSKZ/uAXALBU4a2kxFY3IqdYO5G0lG21TurDMzPGn2uetpmP3IgTSgZ0A6R1V+SO1TQOH7tmnZycxTRm0irDCnc5/f1Oop8PzISRRyQT75vpkxXj7CIzp6rOQlzoFSOLDkCOkUI8Ns20oRCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH0PR03MB5928.namprd03.prod.outlook.com (2603:10b6:510:31::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 15:55:04 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 15:55:04 +0000
Date: Mon, 31 Aug 2026 16:56:18 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?Q?Am=C3=A9lie?= Delaunay <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 1/9] dmaengine: Support bus widths of 32 bytes and
 above
Message-ID: <apWjMBvGA6yo_nCZ@nsa>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
 <20260831-dmaengine-support-wider-dma-masks-v3-1-507d97496f2d@analog.com>
 <apWFa4BFoAL2AhG3@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <apWFa4BFoAL2AhG3@ashevche-desk.local>
X-ClientProxiedBy: MA3P292CA0055.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:48::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH0PR03MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 397a8ade-9e0a-478f-08aa-08df07783913
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|366016|6133799003|10067099003|4143699003|11063799006|5023799004|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 TOJirWRNzfCxHWxeQU10ASf4cKJHJiOZR7VA5cZ1mY6lvvcGyr4/lvUmjQeb9m592jOQ45BPzEYs+iUVousxCuVLPXULxG3233IbyGoiUY4g/+vqLZqxSWyckn6dXKXDf+K+CDMTfFgI6zesWWIV9pjF8B7GiOQlAo6mQoKoLyQ1gDdumyJMTd7wpGeuPYoupDbSytQkxX82o2f7bSkE629hnlX90v13XXClrTZf8bwFadQNvsPlljUt5G40H9DcBn60ueyCGVCzEVEXhXz119n9kbcpF5KVaSVZ2VR7CKOsSlY4XaqOoaRROvhR3cSrahJPLm3ZyhixNFEDz0XOtSobn41sCmfnj1/s2fZ/C7+FWhah+0DkTszA5Iy0G+mh0h+NVShxglLLK3EdxpiLkJ5ubisJOHEDQMQXxXPToJC7KltIZkLk8TVQEWq6xH7ls3VUA3g2v+/BCa5I4qcR1RrRbOEm1EbE1zG5wbUzZxhqrW4CiNfFFqnCWfxtVhDy7Pz51s1Mb5s3PSMVCSqPODtV99t+/MTbLSiUVwKgMK6NsOv3M7MLbUFadyNyEQ8w10WbaiD8JQHKCeCwAFXaaGQf+2ISKHcCgM+LhfDPmdo3EG14BAyrUFtTVpOON3hptvjNZUazIlnl7RYjKs3bRCAtihDa/8tvjBGgEzzEu+w=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(6133799003)(10067099003)(4143699003)(11063799006)(5023799004)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Zmo1emVKU2xoRERTNEFyUkZKdE40cVd1VGp0M080MmxKemUzZ0U2Q3FrNTdO?=
 =?utf-8?B?U2tCMXZNTng2a1lsRlRyYUZObmxwT0ZhUU1oMCtpQWNUS3hlZmFObUYyd1JM?=
 =?utf-8?B?b3JRTlpReW4xMDk0anVhV2FnOWZZL0g3UnNNMmNqMENqMzh2M0M0VXdUWVJU?=
 =?utf-8?B?UEdRU21NNi9PMTdNSjZTK0hvejZEWWkzREthUCt6NkpocGhzejJLc1RYcXMw?=
 =?utf-8?B?aldsQllFTUtlWUZlSTJSUnlTZzk4S1hMc0NlakNpNXVpc0FxN3Y0WW8zVWwv?=
 =?utf-8?B?SWpQN0R0ZnNhdW9IYitRcUkzSFJUaDlnUTE4RWNFMEI0UXlsaTZ0eVUveHEy?=
 =?utf-8?B?MVQ3TFVZUnQzQ3AzU2NUb2tvNjBDZk96a3pza2RhRmx2dG4vSWVoTDdDaGdQ?=
 =?utf-8?B?cVFJY0lUSTZCaTJxMklVSEJNN3JxMlU3QVhyVWtCWG8zUzBXNlVNRzMwUHRm?=
 =?utf-8?B?Q3g5amJOWXF0M0FrWDBsWjN0WnFBVkJEV1FxYThKb2docDlpVEZWMVd4UGVL?=
 =?utf-8?B?NjhUN0tFVkZpNEFOZTlzWi9iMWtvYjJ4WTR5UXF4bUl1cE1oQUo3UHdjU1Bt?=
 =?utf-8?B?MEN3TmYwQTVRR1ZMbWExOUxSUlp6cVBwSVppNlNjbWFZU2tBZis5RXRXOWFD?=
 =?utf-8?B?ekEzSDVRNWhKeVE5ZGxqWU8yVnJkL1YzclNpVzRvRDJLeFRvZDhwaEJVNXBG?=
 =?utf-8?B?M0NKNkZKMkRVTGs1VDlqcFp3QkJuK0NpWlhYN2FCK3M3T2xTeW5LbnBRM3p5?=
 =?utf-8?B?YWNjOFZwWG0yaFAxQ2gzQnVxcTlidWlhWVdROUo4T2NMbFpXbXljT2RkY2p0?=
 =?utf-8?B?d0FmSTFKamNObkJXd1p4bndBZEJGZzNrQWlBaTk1MHRFbW5JcmQzd1p4SHhu?=
 =?utf-8?B?K0x3dXR6S3VZeEF0QUlDTk5wK3p6WmphUkM3UGdCTnI5MEx2YUlENEdwWGF5?=
 =?utf-8?B?WnlpZ3JZOTA4L3RtMHQvQjUyZHg1LzJZdk51YTN0Yjk5V1FpK3Z2c044SFAx?=
 =?utf-8?B?MmRzM1VjeU1NSDZHQ3ZnaWo3eVBJS3pVbng0a2lpZEZubi9wOE5GelgrM0Np?=
 =?utf-8?B?Y2FFK204T00vSTJrL0gzQ2RCZXJONW1sditSRmt4OThLY0lGS3kyN252Um9k?=
 =?utf-8?B?NFZWRkFRQkc1ZDNORU1jenQreERZL1BNeUFPRFQ1cTlGY25OeTZSMDRoQmZH?=
 =?utf-8?B?WWsvdmg4YklZNzRCQmNkeVNWU2xyc3R3YVZNQ3VHZFBDK1kvWDFYVGkxVFBE?=
 =?utf-8?B?dlVidENkWTVXSVJKRnp5dVpZNHhSbzJOdHFOaGhJY1ZubWVOc1Zpby9SdktW?=
 =?utf-8?B?RXlXd2h2bThtTWJFem82bUZjTEhINkMzNTVjazZFUjZpejZQOWhQN0pVVVUw?=
 =?utf-8?B?ZlpzdDJOOFRrUWlkblpDSUpmeXBLejhFZTVHUWR2SUVtcThENURRV0p1dVln?=
 =?utf-8?B?RFFhWTBxTWdiYTMvSyt6eVoxNmJKVHM0N3VOL1UyVFlMQk12akc2YmhvblVZ?=
 =?utf-8?B?cjBTbmFBK3ZVOTlUN0lMMnBFQ2UzSWxyVkV3VXBucjR2OERhOUJtUXVmdXd1?=
 =?utf-8?B?aVh2Ky84REpiaUxhVVZJL0h1YmJXdm1Ub1NMK3pITGc1WG44Y3NPWExJSm1I?=
 =?utf-8?B?RnQ5S3AvNTR3SjdQWXZCeU95TTVKR0NPUVlmc0h5SXJpeDVxS2ZEb1kxa053?=
 =?utf-8?B?bXVNa0tsYXBmaE1wVEhNZ2ExVDY0bE9ZU3F3clFFTk9DcEZOdEJUNkg3UGhy?=
 =?utf-8?B?OG84YTVZa3VwWmZRUzBsZDhOcHAyRVpBaVcxNGxGMGZLREdWd1pPb0pSZjJ6?=
 =?utf-8?B?YUc2aTkyNFNkeURIRndxVVNEUGcyM0EzaHRjQ0RDbm52Szh4V1lncGFLOUhv?=
 =?utf-8?B?aTJwVEdXbm5lbWtSaXRRUTZuZnFVMnJjS1pOYk54QlF5Vm5GZ0lLckZsVksv?=
 =?utf-8?B?ME5xM29ISDRsaXZzajBSb3NOQmJkVHpFSUtJKzhQYnJ2NXpnYnBYc1d2M3VV?=
 =?utf-8?B?NGVwUktjSGlma0RsY0VRTzBoNU9nT25CeE96M0dPTTIwRG9WWUhVV2RYQWEw?=
 =?utf-8?B?ZUcwdnBHYWZhOUhnY0NrUjNNYnZOR25tbFJoSGRpeElwamcxSkhMTjgwaFFL?=
 =?utf-8?B?YzRzRGYvZ083UTdJdS9udUN6bmRZeHAxckY2MGVVTDRWZmRuTmJzeCtka21G?=
 =?utf-8?B?RkU5R0x2V241ZEdvYllrakYvdDV4RUpVUzhNRE0vaENuYXg0RTBoKys1VTFP?=
 =?utf-8?B?RGZKMDc3dEQyNVRneU1saEpwNWU1azdaV01nSEc3R2hGZ0JPNTdRRCtsUDNt?=
 =?utf-8?B?S084d21zS2gzUUpwS3BxTm9oYm9RYlQzeWhJNHdIZGdZK2ZoYWNXdz09?=
X-Exchange-RoutingPolicyChecked:
	2BF2u5WjJr/E/K8+TdVnElNRNrrtAUwJPHNEZSXfKPYrHDtyj6pujEipeUmT3XRSstlYnN44dQyI8zoBC3F5MsjVufcoWECbdjt/nB/9bvH/YsQq+VH7xdvQdwZxlZ9cn3FwwKGwF5o9x4TULWJlAWgMjWwFTLoOHEI4Yf5IkUeNzeyBmxqoNauiwX0TSPKOhXTk+Bm0Y6mIPC0n3oWhxqXovlmndOLnYXapyFV00et1Qt5e+SriqmTCN9NPNhoFCVtrw4R9NxxDdocJtsokcdZfqFFqmRsKZq36Aatb4MoR44HsN41tU0CF+a9eE7QR98bqUhctB8Z+f9IbUw3Y3w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 397a8ade-9e0a-478f-08aa-08df07783913
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 15:55:04.6278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mxXgioXUfQbUPBN4soN1vTuvCFT9e6e8L/kYPlbHWTWAE9dXUyaEqyNn+UydeH1VaAB5DLu+Q8Usf1ia8EEPAA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR03MB5928
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEzNiBTYWx0ZWRfX+2H2GnRCzUpQ
 Rs7mvVcPySfESt6ZGjsKAm3BywJEC+Opat6VhcXGOnW+0VStPPGUKgr2uqs1hzmR09FF+SvJZAA
 sj/bt6AkfLYC06P9wn+NTCxSUQzs4YH+eAttNWp6VoEJr+QHg91e
X-Authority-Analysis: v=2.4 cv=QopuG1yd c=1 sm=1 tr=0 ts=6a95a3db cx=c_pps
 a=MDD208LlbW4bdEb8q+7A1g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=FbesEFgkzma1jrDct1gA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEzNiBTYWx0ZWRfX0548NFrG/QxO
 IM34kDvB0kJIshG/wiq8fTAlJIg0DTjHajZnE0Hv+eUiLzo8GZjbZfZDN8n7mj3bnz2ulUKhBRM
 L4TQF9qqstwwnWxN31ZVr7MNw6W3l+5YJdmfnbOKINJ71m73XUtT1cZfSbjuwppMh5dvaPGcNFA
 FumSv0KgpPBKQFxbX9kvTpod0yx57udhavuC0UnWzrGfEFkJYZ3eW+6e8Lv9+GLKFa5iZvqDdJ1
 bQq6asYn1b0+/9A9CofgX+nKmNCX6KD3STDhf0fk20+OmpuoK9lpMF4b2iTuMTeJzY4EX5I48N2
 c5sbfJdCJya14IXSUUOS2kqY15Hrru1cSQI1qIjcn2mdCrr4sNWBXgVJ9ZtwpqprcnW2TUG+yii
 RISUqNR9Vl+wnaKHHdzZIi/51wh7xJL86d+8eD2+rLmXT7pzbGKHibrrSW4mPIXItYH2U95sUi2
 JeANaAYDMiKA0PVyP5g==
X-Proofpoint-GUID: dms78dHmCA93bXzSbos3yw-IWnAxqpDV
X-Proofpoint-ORIG-GUID: dms78dHmCA93bXzSbos3yw-IWnAxqpDV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_05,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310136

On Mon, Aug 31, 2026 at 04:45:15PM +0300, Andy Shevchenko wrote:
> On Mon, Aug 31, 2026 at 12:46:38PM +0100, Nuno Sá wrote:
> > The src_addr_widths and dst_addr_widths capability masks encode each
> > supported width as a bit whose position equals the corresponding
> > enum dma_slave_buswidth value (e.g. DMA_SLAVE_BUSWIDTH_4_BYTES sets bit
> > 4). As these masks are plain u32, widths of 32 bytes and above
> > (DMA_SLAVE_BUSWIDTH_32/64/128_BYTES map to bits 32, 64 and 128) cannot
> > be represented at all.
> > 
> > Introduce bitmap-based bus width capabilities that span the full enum
> > range, through a new dma_buswidth_mask_t type modeled after
> > dma_cap_mask_t. To allow DMA controller drivers to be converted
> > incrementally, the legacy dma_device u32 fields are kept alongside the
> > new masks and the core folds a legacy-only driver's u32 into the mask
> > when the device is registered, so consumers only ever have to look at
> > the mask.
> > 
> > The new interface lives in two new headers under a new
> > include/linux/dma/engine/ directory instead of growing
> > linux/dmaengine.h, which is included nearly everywhere:
> > 
> >  - dma/engine/types.h holds enum dma_slave_buswidth and the new
> >    dma_buswidth_mask_t type. Like dma_cap_mask_t, the type only needs
> >    DECLARE_BITMAP();
> > 
> >  - dma/engine/widthmask.h holds the accessors which are based on the new
> >    dma_buswidth_mask_t type. This gives us freedom to change the core
> >    without affecting consumers as they only see (and should only use) the
> >    new type.
> > 
> > Note the fold only has to happen in one direction on the producer side:
> > nothing outside a controller driver reads the legacy dma_device fields,
> > so a converted driver's mask is not mirrored back into them. The legacy
> > dma_slave_caps fields are different, as consumers not converted yet
> > still read them: dma_get_slave_caps() derives them from the mask when a
> > device_caps() callback adjusted it. Both go away with the legacy fields.
> 
> ...
> 
> >  F:	drivers/dma/
> >  F:	include/dt-bindings/dma/
> >  F:	include/linux/dma/
> > +F:	include/linux/dma/engine/
> >  F:	include/linux/dmaengine.h
> >  F:	include/linux/of_dma.h
> 
> Unneeded, previous entry includes recursively.
> 

Checkpatch complains so I guess we assume it's a tool issue?

> ...
> 
> > +/*
> > + * Basic types shared by the DMA engine interfaces.
> > + */
> > +#ifndef LINUX_DMA_ENGINE_TYPES_H
> > +#define LINUX_DMA_ENGINE_TYPES_H
> > +
> > +#include <linux/bitops.h>
> 
> Not yet? Perhaps next changes will use it, then they can add it.

Should be dropped!

> 
> > +#include <linux/types.h>
> > +
> > +/**
> > + * enum dma_slave_buswidth - defines bus width of the DMA slave
> > + * device, source or target buses
> 
> I would describe the _UNDEFINED case, it might require some clarification on
> what behaviour is to expect with this one.

Yeah, here I can of just copy pasted what we had. Also not completely
sure what's the undefined case is about. I can do some search though.

> 
> > + */
> 
> > +enum dma_slave_buswidth {
> > +	DMA_SLAVE_BUSWIDTH_UNDEFINED = 0,
> > +	DMA_SLAVE_BUSWIDTH_1_BYTE = 1,
> > +	DMA_SLAVE_BUSWIDTH_2_BYTES = 2,
> > +	DMA_SLAVE_BUSWIDTH_3_BYTES = 3,
> > +	DMA_SLAVE_BUSWIDTH_4_BYTES = 4,
> > +	DMA_SLAVE_BUSWIDTH_8_BYTES = 8,
> > +	DMA_SLAVE_BUSWIDTH_16_BYTES = 16,
> > +	DMA_SLAVE_BUSWIDTH_32_BYTES = 32,
> > +	DMA_SLAVE_BUSWIDTH_64_BYTES = 64,
> > +	DMA_SLAVE_BUSWIDTH_128_BYTES = 128,
> > +	DMA_SLAVE_BUSWIDTH_MAX
> > +};
> 
> > +/**
> > + * typedef dma_buswidth_mask_t - bus width capabilities bitmap modeled after
> > + * dma_cap_mask_t.
> > + *
> > + * Each supported bus width is represented by the bit whose position equals the
> > + * corresponding enum dma_slave_buswidth value, e.g. a device supporting a bus
> > + * width of 4 bytes has bit 4 set.
> > + */
> > +typedef struct {
> > +	DECLARE_BITMAP(bits, DMA_SLAVE_BUSWIDTH_MAX);
> > +} dma_buswidth_mask_t;
> > +
> > +#endif /* LINUX_DMA_ENGINE_TYPES_H */
> 
> ...
> 
> > +/*
> > + * Bus width capabilities of DMA engine devices and channels.
> > + */
> > +#ifndef LINUX_DMA_ENGINE_WIDTHMASK_H
> > +#define LINUX_DMA_ENGINE_WIDTHMASK_H
> > +
> > +#include <linux/bitmap.h>
> > +#include <linux/dma/engine/types.h>
> 
> + errno.h

ack

> 
> > +#include <linux/types.h>
> 
> I would group subsystem ones.
> 
> #include <linux/bitmap.h>
> #include <linux/errno.h>
> #include <linux/types.h>
> 
> #include <linux/dma/engine/types.h>

Can do that, yes.

> 
> ...
> 
> > +static inline enum dma_slave_buswidth
> > +__dma_bus_width_min(const dma_buswidth_mask_t *mask)
> > +{
> > +	enum dma_slave_buswidth width = find_first_bit(mask->bits,
> > +						       DMA_SLAVE_BUSWIDTH_MAX);
> > +
> 
> For easier maintenance better to split the assignment.
> 
> 	enum dma_slave_buswidth width;
> 
> 	width = find_first_bit(mask->bits, DMA_SLAVE_BUSWIDTH_MAX);
> 

No strong feelings so sure.

> > +	if (width == DMA_SLAVE_BUSWIDTH_MAX)
> > +		return DMA_SLAVE_BUSWIDTH_UNDEFINED;
> > +
> > +	return width;
> > +}
> 
> ...
> 
> >  #ifndef LINUX_DMAENGINE_H
> >  #define LINUX_DMAENGINE_H
> >  
> > +#include <linux/bitops.h>
> >  #include <linux/device.h>
> 
> > +#include <linux/dma/engine/types.h>
> 
> Same, group them after generic linux/*.h.
> 
> >  #include <linux/err.h>
> >  #include <linux/uio.h>
> >  #include <linux/bug.h>
> 
> ...
> 
> It's possible to split this patch to two:
> - move the existing type into a new types.h header
> - add support for the new API

Yeah I thought about that but this still looked simple enough to go
together but I can split in the next version.

- Nuno Sá
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
