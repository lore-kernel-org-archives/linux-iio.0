Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B317B4CDDE7;
	Wed, 30 Sep 2026 12:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770318; cv=fail; b=DEURcftqbk8p667HXGVjuTlsmxD9KX5f3ibOwABjlpNT6lrKGCgqVL/FQCWyHn3uI+G9gsDyNpDRmmqj1tRDOjqd71kDxwvhrFJrRMwpVoxakepgvS+DhEnZaNV85WOgJ8D6T0UkV03CLr0sCCcsD+yE9ln+v+4ylkxiPyBXiOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770318; c=relaxed/simple;
	bh=b7O8QhNylGxl+3cwbUVWYCXWKx7QH20oLW5bCkMCk4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z0YHOTmbgyF4hUDZVAIp3ovrtGUOR+Hh0pkDFtRW+pQv+6VHdrBbi1L7N2tofhaWMlZFJTWETVrTLzwH5zWtUDDokZ4B3Frif5ycUJI6aeLDvcxeaThMCxmIkMqVWW5p8r5fVDbK/ZHqMnpAq/nqxZm9YgcQWJ0gAK35ZNLxjUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=vuzv6YnG; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="vuzv6YnG"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68UBBgRb1641762;
	Wed, 30 Sep 2026 08:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8MEdZ
	Q5vBGrit9LXK7Wkoth/d3UTY9+PUAON9Khf8W8=; b=vuzv6YnGPKOawtqUGbBnQ
	QK397Qu3/o9tzG7sJQaZ43MHcDvv+LWn/9VVnGDY1i4BmhemnqXgQxmL5CX7Vvf0
	3YKhzZ4msKm9xwsCaAQ2cOqKPzBxKkk4hd5N6+TfDLf/GyykX03AfALw+rAUxS98
	yHeIhxPEPrB1zMmE3E6WnK1PIUX6yhf8aFaQ8HjP0lnl1WAoAHNIbH76hvlOYX91
	lPlhKSm/qTzDfPY1ep8D0KXN80Yy1l73koyA1YlDwQCsTymrcKkqL66WzsxQvOMY
	kVjnibCPsXWjKZokka24dd8jSauA3Ijgt5YRaRHeN1VjviYYFytgVX25iKyXnG+j
	Q==
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013049.outbound.protection.outlook.com [40.93.201.49])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h0jhsdb80-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 30 Sep 2026 08:11:46 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GyiJhdYAlE+1QrSqem87twdF7kN0khbU+4c3LKgBp4oqMwZLwY9iwACLexhaTvH8k/bysJLVuQOurl4+8Fzl2jvU9JH44br2Oc6imX/KpvMfnAxNnw6MYmQu20BAe3fDwdwDPc9cVLCFRhAsFuDuYxvl7LFJvDkeNvFUXhu6UQ502PzwBVyDUGWOJvYFVOh5R+PO4UK93Bhm5CthdhUtjVCtbGyxH9/rHKq/55UcY2b/OLGKdn7WCVU5wgS+N7m4/cCsRKHKu2oC8LYnbNzEUy0pN7DD93FLreDnvvt2GWrQorSPZ+hxlBu6KHQNVhcVdNyX6JN4EtVVlAt4UsIBFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8MEdZQ5vBGrit9LXK7Wkoth/d3UTY9+PUAON9Khf8W8=;
 b=S093Gji9orhehDB100j7x24toCx8qNEr7tC77qYHC8diFEi/TzIrEcNWNY2uALn1nzetsRW79h1yo9ZOX+8+Zh8ToFjhRGIppGq29OvFJakfv7gWRQ06gccuJKtvxL3IePd3iwSqNYv/mfxStBEbGk/hTFx0KpBgE+Qr9Ad2UYC6IHqB2ACTYR69O+6G7TjFdvxBt8kgZx/CsH79prXZUvUEg9xMNaESivGYusi7TPuYxsvHkmEwAaCzOFVFilQcgzj93YVQzt4+BUsIdZVdrTP5nmxTqtPTO9dkPnxB35/w+9/xiGMCEtSBUfVMDljsbLPjyDkgKF9Wyr52uXi4AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by PH7PR03MB7391.namprd03.prod.outlook.com (2603:10b6:510:2e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 12:11:44 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 12:11:44 +0000
Date: Wed, 30 Sep 2026 13:13:01 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: cdcp206@gmail.com, Nathan Chancellor <nathan@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Liviu Stan <liviu.stan@analog.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: temperature: ltc2983: avoid string comparison for
 leak detector
Message-ID: <arz6WU9HoRVDQCv0@nsa>
References: <20260929-iio-ltc2983-fix-string-compare-v1-1-d67d612d6ddd@gmail.com>
 <arzb0JQxkJAsLsEa@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <arzb0JQxkJAsLsEa@ashevche-desk.local>
X-ClientProxiedBy: MA4P292CA0013.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|PH7PR03MB7391:EE_
X-MS-Office365-Filtering-Correlation-Id: 14f0a0a8-23f3-4532-4e5d-08df1eebfd45
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|23010399003|11063799006|56012099006|5023799004|6133799003|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 7wvSK/odYTCbgEtXdBzlVuFbUcEh3WKzN0+Nyhmw3f5hZrFK2CQoToj2dDe/uXuK3hwY99lL1Y9Qq6sHWm4HBmT59cnRxEO9OyYOkbdDN7oQSffHwGevsLkQv9hThFXrNvkPdsmULzjpu3i6GWUbSI37Q1VLYngRh3emaMzZcAzhGXwQ4AUV1oO7g8K5UCOdEmbGCv+As+7LKV1J2dV/27AUEjTSc0WnAGd5QC65Q0ZIEm3/ckV2Csxd+0Wh8dLTJKjUndIpVsykLuhicdisHdogHxqwDbm3aF+gVuy3rPa8aVJeaXi/9wbmpzxk72tj1Dp2iEgoFxC8AURQMJA0S0YG43TBmJLZ9l6sUeBQEbQxPpAefa1IVjeQZOQBpCmZ87cFWsQZLmLsjUiTe27f2hLaD0pKHRmPGXzeEu8gzJCZD+XEWe7qtB1z+2gkHwMO6lx4SMQ6VTNAo6rA81DpzuWYkOf1rD2g6ZeeGg/EedftYhgCJwBLLT9Qx5BL0YGujkyw+BMbhlTAMp8Ugoe50tB65eYHsz1egtko5VFRNYTuTjnBuCmsVvUBjENdiowqKAg10YAw+iAhX7FjRNpwoKs9D9WYS+gYC5kKIl5ecCFkgqcrlRVL5/4pVf5FwSTDcOsc65oTUWVY7s6t2QEbUyDCIwOhrigAC2k0QE8f/xw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(56012099006)(5023799004)(6133799003)(10067099003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NHVkUXNMTDBtMVlVQUs0dDBwaSsxZWorUDNmemtRRm9zekQ3d01FdFRQdnNX?=
 =?utf-8?B?Z2Z3UHpodTRiTzJnOXVuZkxFallnZ05Cd0szSWc2NVQ1MDU3MlhZTjlLWnZx?=
 =?utf-8?B?aWVhTFVoL1hHd1pMaWFiRXRjNU9rYm0zQlF5RFdnRDJ5M3VsUGtmVUJkcFd6?=
 =?utf-8?B?UnpBMWpvMHdUekM0d2ttb1ZSNjhNVUxLK3pzUG5mdUYzSDYwL1I0dy9WalBy?=
 =?utf-8?B?SGgyNWJpeUhtMVdHSmFqWExCVzV3aE5oVy9teThwNlRGQllrNERCYjVPbFpW?=
 =?utf-8?B?ZkUyMTN5YnhxeElrYUVhOXZUVXNjOWtNcjBuM1VPVml1bDBLUnZFa1B2N2dI?=
 =?utf-8?B?NUFRL2x6UzJoTTFDTHZ2MUQxcW1TZFdqQ0psTWttTE9XVHJWWnZ3M3VuM1hN?=
 =?utf-8?B?eDR1SHpPRXUzQzg5WDRqR1VGcmJuQStScnBqemdJL0pGY3BBbnd1YVFtY0Nm?=
 =?utf-8?B?Qk5vM2RieEI5Wmp1UFRldHk3K3YrNzZia3FJdlNDSTRmeDRSUExFd3dkc09t?=
 =?utf-8?B?S2xDNmhURnBlekg4djVzOGs3WkhNSWZwWkY3ZFlrSUNqcE1qT1hZcVlDOVQy?=
 =?utf-8?B?REZRK0ovL1JKTGVRZUt3ei9SZUp3RHJVem94YjA0NnlUaVBCNlZHU1lSSi9C?=
 =?utf-8?B?V1A4aG1RNFlGNkgxbyt6aGtHZGszZWVHbWQzN0FQcDRvYUU3UGpqdUlTSGhL?=
 =?utf-8?B?SGVoUWFuSjQrb29VT08yR0hYQXkrUFZZa2UrNkdVaGtQNjdGUTVsck94QXNP?=
 =?utf-8?B?OGNtaWVHcnZiS1ErbWZTTzZLS1hzUklSV0pFRnJsSjlReHJIM3RQeVZkSCsw?=
 =?utf-8?B?WDVRTS9IdWJZTHd0Ump1dXpHVzlrMzVmOUpFeUxwbmRNTTkxMmtJOGszZmlk?=
 =?utf-8?B?bDhxWHR2bFRjUDBtZXhjRTduNmNXZDd3cTFzRktzZi9oNXlYNTlZc1llU1gv?=
 =?utf-8?B?ZmNMMmRwb211R2RwclNJRDZSelpmcDVjMHdzMGNUSmN6LzJRdlkyLzhDR21U?=
 =?utf-8?B?WUltbWZzbVhzUGRwajNjeUhNdEpiTUhFbUNxSlRVYndKRmYxc2xYdE5PU3lr?=
 =?utf-8?B?Y1FZWW9WM0hKQUpicWoyb0hyMEUxQlo4TGhkT0g5blpWNXlnRU9xY2Z6WXpl?=
 =?utf-8?B?TDAyQVZDbmh3VEgyb0lEaldhMVY2VnZXcVliMFVtc1RHNnRqc0phdnlRQ0VF?=
 =?utf-8?B?Zkh6SEFlSmJjUTQvd3JwNlNpNklaMTBjVXlpV1dleDdZamxtOHNXbVErZ3pK?=
 =?utf-8?B?cmZUVVhvSEZpRWl5WkxkOWNmclRJQ0xJS2JDZmJCNUE4UHNCNml0aXVsRkFY?=
 =?utf-8?B?emJXTEhHSC95OUp3Rmlway9acFNFTk9TOGVsRE9GYTF5cVkrSWZXenNGcHlr?=
 =?utf-8?B?UUZsOVZxWGJYTnU1U2xSN3FZbzFtTUwxb0RCRDRvK09od2dNZmJ1eWliYi84?=
 =?utf-8?B?d0E5T29FWWxhRVphMGRmYzdHZGV2OEU0SnZLTzBrejN3YklGUVd0cDNic0k0?=
 =?utf-8?B?UkFMM3Z2eWRIbFliWGpYVHZSMFBRRGVIcjZVWW04NlduL2xuZ1VUdW9ubk5k?=
 =?utf-8?B?UnRHOEZyYjZXQ1JFS2J2ditHL2VDK3k5eDZtRTA2YmtkZ3hJRFlZWjg0cHBs?=
 =?utf-8?B?YmJuQXNtWGNLeTM0WU05eFhPcStRcnp3WU1vWVBGcWp1dmx5K1lzSDJXTXBh?=
 =?utf-8?B?MS9SZWxpRXoxZ0F4c2JibkJCRWJNLzdMbkZ3RWZqaXFpQTVQNEtaelAzY3Bw?=
 =?utf-8?B?Vk4yZ0QrTEJBTXNEd1k4anNsUkVWUmFZc1ZXTndtNTVwTlczR042Qm01WFZN?=
 =?utf-8?B?Zml0TE5NRFVmbzlmZmZhVHdXMEN6UUtOaXZEcTRIVWk1MGY4QjBobzNNaXI0?=
 =?utf-8?B?NEtmMU85NHhVQllUa2p6NHBiT3dLNFJUdTZlYWtzZk1FakVBNWdsaXFQYzJN?=
 =?utf-8?B?WHppTjhGbk9VNGs5L1JQeTRCY0U0YldETFZOcUxwYi9KcVJ4ZUZFUEFSUEF1?=
 =?utf-8?B?ZTNWU3BUbzdvNGFtRmVDOTZwZGdXd2loNW1MbjFSWk9ERDBHbjVtVkJLemRS?=
 =?utf-8?B?aFR5TFI4MUpic0RpbjNwYlVyRnljZytDbUt3YnQxa0tTQ3ZPMnVQM0YxbFJ1?=
 =?utf-8?B?Rlh3Z0p2WTRMU2JsWW1uYnRrbW5JdVFLVWQ5QmNNcjVFUElYL1plV2hxTmhQ?=
 =?utf-8?B?MFYzRTYvdHQzRVVDUENtUVF0ZU40TDczNGVGVGdBRFFYVGxQenZxZXVuSlEv?=
 =?utf-8?B?NFdOakprL0tyMDFHZ1VCV1ZMTnVOTCtrRWgwOWtGbTNHNVk5RHJoOVpwejJT?=
 =?utf-8?B?T1lvcUZkR1FlWU5uUVRicW5ibngxVWFITkhmQUhaQ0diRUxqbFkrUT09?=
X-Exchange-RoutingPolicyChecked:
	Ck0zh5hlBeSKDTLQJqtULCGwJIjZ/Zqu9CRPT4v0zTqwZbOzsclOCfPZIvD2ix/dd2bSmf8xPyF6DjFsoBZyBcU/CPlMcwbzURqHSQwfiOLfxph+LPZZnXcimDL0mV2qQcnM/qsR/+fe4MEMvBnbN3X2l0voAzps5Yh4hsPuVZchB64YnKuNMXcV92Q7QFeUf+XDODQmyGKsYqjEjkxEo8yy4nd6l7jpKy1kUPQghg7Des+QU97saRNxoQQJUvADiAmedZ18ilQjBgq1roIxnQq/C0dS5glmo5DTcQn3Q/twi9fSS/Kc2TrK7DXWTED9S3JOEhyeRuhzftUfKysKww==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f0a0a8-23f3-4532-4e5d-08df1eebfd45
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 12:11:43.9089
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LZWwlJpwBxw8gMyJNM6Kc/1JapJlTKe+WO11sRR99ywxv2enzAHAqIQDHH1AnTHdfa5wGsIZj2Q3OmjAwESMEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR03MB7391
X-Authority-Analysis: v=2.4 cv=ZbeIpcVA c=1 sm=1 tr=0 ts=6abcfc82 cx=c_pps
 a=onUmW/TBZy4T/WhMO3N4DQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=uOqCmISiiaLf-by294MA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: C_ATh-HIUvnlUdYDfeOohjiZXePyRvAx
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA0OCBTYWx0ZWRfX7FPdErAqOzfm
 pAK1k6KbHCkw2NRwBCkjbZXSKqmKiLOOGMI27iz55iaaEMfrOOaclp1oS2rS5YWS2a0noaxz0MA
 +haaWSqFh2qTigm0oZfnhKBPcYiFrhEgbcuLQqWHvf6EWjxOXCl9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA0OCBTYWx0ZWRfX6APahnZ2MF8X
 d/oO4Xpp3ra2HxxsYvoTsCbdhlS4zt6qdROYjPQ+THzBl4NCD5KJo/Bqw4otn14/gPAg519zqQg
 SSsNwLnNEreS2N7q0772ltRkacejLRXxAVnaKBnz7rCaQxNbuYg59Iz/lWewX9ZEOu4AwftJKEC
 h+4GSOVZW6/JExnA8u6FxvRx5b+1voLSmiAMKain2mloM1gG94EVtrVo92dKNOm0xe+aVZ8hNTX
 ToyPSg3uGQoXslgsnRKk9OB4/RcMyjmq6ouNvswTzrYCrG2/RbKSPt2DQ1Egc5GCilMvsdkp7Ps
 xjYGDweXVBGfZgYViwC9iJpwY1XcPHx7xEPuKgrjy/lkP4IpVUGTKSs/NiXZ4IeJ0L5uOqZgE9B
 zEO9QCTI3s7Md85FoZ2xO6e6tSFnjbRTAy39aClbZt2XZ+tHsM3sEk/UEgSJfKr2lBDpMbIzBLe
 FW8of3xp0sRf9GlKtdg==
X-Proofpoint-ORIG-GUID: C_ATh-HIUvnlUdYDfeOohjiZXePyRvAx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300048

On Wed, Sep 30, 2026 at 12:52:16PM +0300, Andy Shevchenko wrote:
> On Tue, Sep 29, 2026 at 12:38:22PM -0500, Carlos Casadiego via B4 Relay wrote:
> 
> +Cc: Nathan
> 
> > GCC can determine at compile time that propname cannot match
> > "adi,custom-leak-detector" when __ltc2983_custom_sensor_new() is
> > inlined for some callers, triggering a -Wstring-compare warning.
> > 
> > Pass an explicit flag for leak detectors instead of deriving the sensor
> > type from the firmware property name. This preserves the existing
> > conversion behavior and avoids the constant string comparison.
> 
> ...
> 
> >  __ltc2983_custom_sensor_new(struct ltc2983_data *st, const struct fwnode_handle *fn,
> >  			    const char *propname, const bool is_steinhart,
> > -			    const u32 resolution, const bool has_signed)
> > +			    const u32 resolution, const bool has_signed,
> > +			    const bool is_leak_detector)
> 
> Can we get rid of those strange const qualifiers for booleans. What are they for?

Obviously nothing. They came from a time where I thought they added some readability
value :).

> 
> ...
> 
> > -			if ((index % 2) != 0 && !strcmp(propname, "adi,custom-leak-detector"))
> > +			if ((index % 2) != 0 && is_leak_detector)
> >  				temp = temp * 1000000 + 273150000;
> 
> Hmm... I consider that the compiler warning is just a noise which we should
> ignore or disable. It's doubtfully useful as if it may prove the always false
> or always true cases, it doesn't mean there won't be other cases in the future.
> Do we have any discussion on that warning before?
> 

While I agree with the above, I'm not against the change of having the
boolean against the string comparison (and the warning would be just a
side effect and not the main motivation for the change).

- Nuno Sá

> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
