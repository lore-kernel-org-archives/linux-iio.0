Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B1129B78F
	for <linux-iio@vger.kernel.org>; Mon, 24 Aug 2026 10:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787568451; cv=fail; b=FfQYoIyhEJnbJRfpeV/5BOiMQn7I5NjNuYgR9AwDGwDYvu2FqtuSO7A1V5ircvWip2tonW8bDGFy176a9B/2VdWdM9zITXPH/ERiaSYqMoB3l8I5yX1ub6pVzC7yDofx8IDCzdnDcWBi78KXy8htudQVt6z8jBPL9gFeG810t6U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787568451; c=relaxed/simple;
	bh=BCDB3hb8q/W1XAK+fh2LOtTVeQt23Q2eEWKE61zc8BE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=m191LdAnQJJHIfAWEsZJP1puAqu8zPb5BJfVrIA3ezAR+574cSKqw6VgcC3P947VyfQqamX+2JyW7+LqyRH3A2xjj6+m6S+YQrBHHY9VcfDAF5QoVs2qxvtfCMtlm/9JMKwfu2O4/Rpjj6o6I+kwwKsRtB2AlddGva6DVYB3XXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Fjanv55z; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Fjanv55z"
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O9A1NW2876553;
	Mon, 24 Aug 2026 06:47:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=8VRM7
	T5V4PMUhtHMlLCCEh4vt5SJaRw11Hxy6S3BCkw=; b=Fjanv55z/qfGrtCC8UHT1
	UDwcu62xkGwyGzlTShe3EXMQkWWd5cjr9OGxBvA9P6n6ejc59BdLqYTa7ewKQ6SI
	jGXE2P9rXGXTIWgeeEvC1eRadpx/TabkruluMtMdTDX60Jf2DZxprlz4kErwavEy
	Xf8JFIk7nIm1NSEV50TyvwKKnMWiPhk5riEhg+JzvzvDpST57xxvBf9TYePHa0Ov
	nGuy20J6JY/8EqMfB8nTBWhAvxlNJ5fSGoDHcHL9iSJysWNW0LOQZk14Fd/8aCfm
	j7NYgfI+usDesNLExcaw9F9I2Ed5SmUcjSGQ6OWASjI6njEbW3CSjIKdn1sCvscj
	A==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010070.outbound.protection.outlook.com [52.101.201.70])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g7vchb9ba-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 06:47:11 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yoCD8rx8Q84hhlq911WaRiG9iTRK8I2HxBmtStnsOUgrjSXVUZYoFxBS35vO+F5JsO8eZeVxBMF96moe5npScj/M7Vta3FmmGfhgRR1GbbNDgjLe37q+HATX0rTHE2ow9Oyi3webkL/VQbEDFlQdPb/wPEHCEe65MRa+VVZ1D+BswFoNgeYXkQPmS9opAQYPw8/ik6p/RBmdvoLKGkPri8mEWgrbssdYAb79cK26e4+TS9XNEBu7ZECFq3iRppiMGRwLPTXSKuZtIQAwzXRZrzOQ4RKJ6CaoiZoMleULGXluKYcGv6Jb1O9CHdWnRXZHcmOHhZG95aELgeRZxKHnZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8VRM7T5V4PMUhtHMlLCCEh4vt5SJaRw11Hxy6S3BCkw=;
 b=wmUw8hIwN6uY6joAd6m0wgBkPtX4iS98enrBhhkLOgFcvtkxVyC1AWOyoKRDGE8qjvnkk/4NKNbKrcWCSBO8oPTjz9gbtCx8KaYS/fWEBcEy14fjiTZjJR9pSmQyxnvUz+So/bYcvL4fHHWn9A515Qy/b1Ij92/HrdvtR7GE6/vVEZ0Qq19XsyODJg9G+bRBXuzItTq6C9LPD7CYQB/RTL7NbuIkCD2GX6FMNiipmPptfON9hLoCRmHPILw0kdSFY5lKKnr1slfDakAJqpolzCWAa1v9OSIsMM5hO/MRwUqI/hSahKuQmGJ5naaB9R5l3mBT2x+tij5qk6kyJpqGGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BLAPR03MB5444.namprd03.prod.outlook.com (2603:10b6:208:287::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 10:47:09 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0339.007; Mon, 24 Aug 2026
 10:47:09 +0000
Date: Mon, 24 Aug 2026 11:48:13 +0100
From: Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH] iio: buffer-dmaengine: fix sg entry iteration when
 building dma_vecs
Message-ID: <aowddbQh7hYR3_bW@nsa>
References: <20260818-iio-buffer-dmabuf-iommu-fic-v1-1-4ff1e44a5073@analog.com>
 <20260819014104.56bd4157@jic23-huawei>
 <aoV32knWqL6s4xjF@nsa>
 <20260823011618.2176b016@jic23-huawei>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260823011618.2176b016@jic23-huawei>
X-ClientProxiedBy: MR1P264CA0018.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2e::23) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BLAPR03MB5444:EE_
X-MS-Office365-Filtering-Correlation-Id: a6b6191a-df4d-45c5-7051-08df01cd0be4
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|4143699003|6133799003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
 oMfC7MdHc0hsHCkVKs2pG3GHPQ9ZWaOHWKz8szFKXCaw1NLgGqfOn+siARIqMdeC09msQMvgGWOK2wuQteuH0pVFoYfAJ3lh8pdfcKsRBNNrvDOTAq5deogZB7wdYpFoxIAEBylkHSAXQ4E2TbZJbHRlpCLObDzOSNI+4rMNGyfhSFLQWv+ReZGoNA5WgbbIhucIRbJ05LzIT2RUeNoM8PYy5pukoKtk7k/M74anssI7wiDEJEd+9+7rnVVkIJUkJp6z9Ofae7W4pF57pNAo5Bu2QzshBRkr2OaI1MhHZkyWwZvLrbdG2BLgO3LAb1LY8dFI3JC+77wXO0owd/1LfCwBclno89uEWNZVlL8bHMS7AVim/ITeyc6DXUUVb43uqq2z43j2M2vQYH/eBHV0id6ZEylhCU5ZktdC8FWzDPR0eF0CXduSrQa1zSONM18Az+1RcKGIyTrNguuDH08pZg2XwtifCI2ZbWa9jTJxV4xwM61IYnng5HfQZcfZd4Qn3Ua5iVysD9PcMoNj/Ot37AF9bR81IA7n/+BCwInZwww5qywcVTy5fc9Qaryvw7B19Gl5seoWugLh3628Znxv5jwWoF6s5r9LlPOyW3hyCVYdTOlUfjUqIpvjmRCSu8Sd
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NFBYYUJmSURFWGNpSmFHWTBTQUJsTmNvWHRjMUJodkQxQTBBZzVhUlVWN3FL?=
 =?utf-8?B?eUVha1l3ZXlURnQrdDBGVm4vQ05YZFFPcndWSUpWaCtPYUFIaXpjVXpWQWNj?=
 =?utf-8?B?T1FBMDZzcGlMbE9PYmdyTEpUTEgwNHBmVHMwN3FxdFA1aitDTW1QdUdtNnhS?=
 =?utf-8?B?Z3pGS2ZRTTMyZWpvM1BlUkxpRHY0WGZ3K3ErRElmRHpUSGZvclFQRmFyZVBU?=
 =?utf-8?B?dTZyYTVRREF1RmNRRWlDL00yRUtUam1WZGM1ZWhLTFErcXg1dUorMnpIWXVM?=
 =?utf-8?B?akw4VTJJN1pyVGJOeitMMkNtMzJqZzVJdEswRGd1aHJjeTZManlLNjQ4NUVz?=
 =?utf-8?B?MFhqSENtWWlrQk1nNW5CcTRKZmdhaWdFZFRZdW1XaEsrbnFwWDNCbitleFRy?=
 =?utf-8?B?ZWtWbDNmbWt6QklreVhiNENWQzBPa0JlZjFuMlBSL2s0WnNESUJhQStJbzh6?=
 =?utf-8?B?a3dyN0xGdUZrZGlMV0wxUGVlSGpyWnpPVkwzVVc2VkFxN2pVakZSd2NzMnBR?=
 =?utf-8?B?b0tXOTg1ZnQxS2tvNWxCVHRPUTltZC9Kakc3V1dVNlV1aUtWVisyN0Ivc1gv?=
 =?utf-8?B?Qzk3OFlzM3I3cWFObEE5MER6Y2tmdzVyamJDM3pFR0tTdHpOUldRUmxXOXFm?=
 =?utf-8?B?WDZlZVU2WFFpbEtpTGExS0J3M3lpcXIybm1CVG5iaXAzY3lORmppSXZkUStW?=
 =?utf-8?B?OGt4ZGVoYzdKR01wWExxNW5kcnZEdFNLdDYwVlB6Z1FBSW54Nnc2ODZyMTZX?=
 =?utf-8?B?d3M0b1hpalJCbDN1VFEvM29LTmVKNHJ0Z3Z4WnJSUTQ2c1VhSUMxUEFpYjFS?=
 =?utf-8?B?UjhjMzR5eE1kUE9LcFB3T0dIMmhra0FBR1dVdnhXN3dFYVlodTRKVkt6OW8v?=
 =?utf-8?B?eE5xTDQyWlRWM0Izd1JIRnRUWnhLSFhYandRenRkSG5WQ2pTbnJUN2ZrYVBy?=
 =?utf-8?B?WU93YVpISlJndnVlM3RZUEhkTmdPeGY4QXJ5WWErcGlEblFzQVRucXA2RjB4?=
 =?utf-8?B?UHRvM0NOZVlucUZydnpRQ3gyK3FrT2JRRHBPT2x6WXhuWjl5NGNnY3hGaHNj?=
 =?utf-8?B?NkpXb090RnFZVmR2dlhNaUZnb3AyazFTTFo0WFMvemtEU0ZPUHN6R0paMW1R?=
 =?utf-8?B?WUptMndUMnlUVmJBQ2UyU3FINDNzUW8rRE5XeXJ1emxqbS9HSldFL0JvNGVG?=
 =?utf-8?B?OGM3MGoxbU1MY3V3aWR2YkcxRWpKTTEvSnFyY09oOFRZWkhqNXFUenVFdW10?=
 =?utf-8?B?dWFjUWNtQkpkdjZvcklYNnF5b2VaS20zWGxtOGZ1QXlCRjhHbGw5TkdMMDFN?=
 =?utf-8?B?czZNT1JyVWVSSm4xcE5ERHBJL3BxTnliWGxTU0VzMzllZE1RZzdXK0U1RnlB?=
 =?utf-8?B?Mi9Fenl6Njd6SVluak5oeGoyMm8vaDBZNjEyeDR5NEVEcDhoZUVNQXZlSHN1?=
 =?utf-8?B?ZEVkN3E0bnRIa2ZvcU1Uc2NlVjdqTFYzeVZBaVArb3BvNnJCZ2RaUHVFeDBu?=
 =?utf-8?B?QmVPSkpxRFVkRTFsOFBNSk4rQTkrM0N3d0N5TVBBRFI1bitkdTZoT256aFdM?=
 =?utf-8?B?TmtIdXVpZnhhMkhvNDRGTkd3b0hGODFGRzc5WHFqWWJxbk5nN0pUNEt1ei9V?=
 =?utf-8?B?ZEFwRmgyN1RnZGtyNVdWSFJmSHNMdGJZZGxoSGU4NlNZeEhBUFVkV2I1bW8x?=
 =?utf-8?B?SWY5bHhIUEVFOEhWdjRaYXFnWHBmcnlJYVIzbk8yaWlFcUVSMldkdjNKSXJE?=
 =?utf-8?B?V0ovc3lQYVZHSGhQaTlWZ28xdVNrQ2hEYnhOVWpWRXluVU9MV2ZQYTV0UXJW?=
 =?utf-8?B?WWZHK1NLcEtzRnlyU0VMdjZVeHNKQmJxKy9pWUZUZnpZVEZBQ2E2QWJ6czJW?=
 =?utf-8?B?VmZYSXBWT0JMTzBzVlRhc3BqVFdObk56SFpmeVM0Q2ppY1gzNU9FT2lIV1p3?=
 =?utf-8?B?ZTdiYU16RlNBbXgzMEx5czBvUWM4Nk5EZnpzTnBNYSs5d3lGWmZsOTZhdERD?=
 =?utf-8?B?RkM2dXhSb0VzeDRDSVhvdlFQOVNJc2VpenlHY0E2QzRaZW1hS3ltaGRiR2ZC?=
 =?utf-8?B?a0MreG9KVUJUZ2M4cDRkMkZJWjJseFZCc1h5UDAvMXdBN3NhWkxIR0lUVzNi?=
 =?utf-8?B?TVpWYnNNalNtYmZGZDV0aENDK3FXcGpUc2kwd1dtbXJ3MTQwZXcxZEMyc2tR?=
 =?utf-8?B?MWhKVVozTG1FWmRISVdTbFlLNnB2UnNqSkQwQW9idFk2WFMyVlBSTHp5Ri9D?=
 =?utf-8?B?czIyUzR6VTZZT3JQM0Zqb1d0QjFhc2tvUTlaU0NkZHhlUXVWR0trdURoQnE5?=
 =?utf-8?B?bVRIS2o5bndmUmw1a0EwVkVRaXVzUzhtV1VvRWFtOEJRZlhNaTU4QT09?=
X-Exchange-RoutingPolicyChecked:
	r0BoLZBPcWmptTUwil3S7PC2Za3l+RFb46AZGb73GDaJTkFH8AKm/UYEaHlij1eOAXfnbYdvok3h/YYwbkAmCLjOBuoqPBmc/M99dYOmahxU/kAX1MSdHAa6OTkDX5LaWbUz3KfLFByyWYzlMQJubY1smCvgcT+muw4okwJi8/c3QgxN33wYxb92Z56TWE3TjxkvJjC2TuoSbmXCA/wvesEQ9Ncwik8nXMijHw6Kf32fjmjpgs/YDiDbqCIQYFUZFgj2YBhXcahU8JSYSdF3tk4gXXKnUMEiZ+J58y0LQzEzhlYXoeskTeg73fFDZcnkU1ksY4IEGqsmyxus/h3pFA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6b6191a-df4d-45c5-7051-08df01cd0be4
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 10:47:09.2335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aarjqNyxyiw9GO3wRm7rNBiVoYUVjo8N79Ppnb+ErILyVOdFaNsbYwFVsCOOMc1fxp6yf4AjKliBA/majWGyVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR03MB5444
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA4OSBTYWx0ZWRfX9nd4w1kZq2q8
 pJn/lurFwkywsk5d9ga4zxXUHyKZVl9s4p10t88rEh7xQmwNpH+gS1UM9z0JLUosbXdURc+11Ku
 ltVHMUu5d3PZCX2sxjS4mwvWkr5Wih/wJR+4tD4loTkEeHbRV8ZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA4OSBTYWx0ZWRfX528CQU9SULPl
 h+AfWeCdgISfZ997X+QW69gj+QP0VkzMp3Lca7P+HhTdbi3dMVKsNItURcVaTddzBPEQQl5v1QA
 LkJJqsttDGTfS/Vz/rsUPhAqKDuYwJ2EzgdE2fTe+cpFRezQPlc13kmYcxTS6ZGZ0S/WNQtAbpB
 qgtqsmJWmPBV2yahW1rZve/2xOivsEDaFy5/s2j4IPZ2IIcISsDYM93rb4oS9iC9GQ3SOxgwnij
 PT1nIwQXnpvWfnYXku7mwnYOkA8iOkKoiQSIHbF73aGfm3/MCRbMy5tHop8n4QeNY5KNjJlyhuC
 Tnv3rUVir8wKnaQDjHoaGlbv06JE8kmt3k/71yYPJgY9m0YkWPrD8hW73XLf0qQEBABtKxVf9Fh
 UxpOiGKTKGGwjMEdjWO0Ysi9FdDh9Z/00pKYWdSq1RdPKZOQ0BPIoW5VbWFzT87XyGtTKsqquTv
 b1VBn0y93BFER0gP7NQ==
X-Proofpoint-ORIG-GUID: NUbhnfn3fH1y7aisU7ysfhf0R_5TNIAj
X-Authority-Analysis: v=2.4 cv=V7dNF+ni c=1 sm=1 tr=0 ts=6a8c212f cx=c_pps
 a=RGUNHxVObgwraRyadLFC+w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=P-IC7800AAAA:8 a=VwQbUJbxAAAA:8 a=gAnH3GRIAAAA:8 a=FcxW3AirYsxrd5BXfEAA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=d3PnA9EDa4IxuAV0gXij:22
X-Proofpoint-GUID: NUbhnfn3fH1y7aisU7ysfhf0R_5TNIAj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240089

On Sun, Aug 23, 2026 at 01:16:18AM +0100, Jonathan Cameron wrote:
> On Wed, 19 Aug 2026 11:16:22 +0100
> Nuno Sá <nuno.sa@analog.com> wrote:
> 
> > On Wed, Aug 19, 2026 at 01:41:04AM +0100, Jonathan Cameron wrote:
> > > On Tue, 18 Aug 2026 17:45:29 +0100
> > > Nuno Sá <nuno.sa@analog.com> wrote:
> > >   
> > > > From: Michael Hennerich <michael.hennerich@analog.com>
> > > > 
> > > > iio_dmaengine_buffer_submit_block() counts scatterlist entries with
> > > > sg_nents_for_len(), which walks the CPU-side lengths (sg->length), but
> > > > then consumes the DMA-side fields (sg_dma_address()/sg_dma_len()).
> > > > After dma_map_sgtable() the two views may differ: an IOMMU can coalesce
> > > > the mapping so that only the first sgt->nents entries carry valid DMA
> > > > addresses, with nents < orig_nents.
> > > > 
> > > > On x86 with an IOMMU enabled, a DMABUF block backed by two 1 MiB
> > > > system-heap chunks maps to a single 2 MiB IOVA range. The CPU-side
> > > > count is 2, so the loop reads one entry past the mapped set and emits a
> > > > garbage vec ({addr = ~0, len = 0}). The DMA engine driver rejects the
> > > > vec array (prep returns NULL), the fence is signalled with -ENOMEM,
> > > > which a userspace poller cannot observe, and the block is left in
> > > > ACTIVE state so every further enqueue of it fails with -EBUSY. The
> > > > visible symptom is a stream of zero-filled blocks followed by a wedged
> > > > buffer.
> > > > 
> > > > Platforms without an IOMMU never hit this because nents == orig_nents.
> > > > 
> > > > Size the vec array with sg_nents_for_dma(), which walks the DMA-mapped
> > > > view and accounts for max-length splitting, and stop the fill loop once
> > > > bytes_used is covered - which is allowed to be smaller than the block
> > > > size - passing the reduced count to dmaengine_prep_peripheral_dma_vec().
> > > > 
> > > > Assisted-by: Claude:claude-fable-5
> > > > Fixes: 7a86d469983a ("iio: buffer-dmaengine: Support new DMABUF based userspace API")
> > > > Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
> > > > Signed-off-by: Nuno Sá <nuno.sa@analog.com>  
> > > 
> > > There are some gremlins nearby in this code...
> > > In the else just of this context seems max_size is computed again
> > > having been done just above the code seen here.
> > > 
> > > Unless I'm missing something that should be cleaned up as well.  
> > 
> > Oh yes! Something I already noticed a couple of times but never sent the
> > patch right away so I kept forgetting about it.
> > > 
> > > Been a while since I got my head into the scatterlist
> > > stuff, so I might have it wrong below, but I don't think what
> > > you have here actually works if the merging of entries is
> > > larger than the max dma entry the hardware supports.
> > >   
> > 
> > In theory might not be a bug but I'm not sure it's a claim we can fully
> > take as guarantee.
> > 
> > >   
> > > > ---
> > > > Note the Signed-off-by is just because I'm carrying Michael's patch!
> > > > ---
> > > >  drivers/iio/buffer/industrialio-buffer-dmaengine.c | 16 ++++++++++++----
> > > >  1 file changed, 12 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > index ecc02a427b92..bece45381c8c 100644
> > > > --- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > +++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
> > > > @@ -104,10 +104,16 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > >  	if (block->sg_table) {
> > > >  		unsigned long flags;
> > > >  
> > > > +		/*
> > > > +		 * Use the DMA-mapped view of the sg_table: after mapping
> > > > +		 * (e.g. through an IOMMU) the DMA entries (sgt->nents) can be
> > > > +		 * fewer than the CPU entries, and sg_dma_address()/sg_dma_len()
> > > > +		 * are only valid for the first sgt->nents entries. Counting
> > > > +		 * with sg_nents_for_len() (CPU lengths) walks past them and
> > > > +		 * hands garbage vecs to the DMA engine.  
> > > 
> > > This feels like too much info after the fix is in place.  Talking about other
> > > stuff that would be wrong is rather unusual.
> > >  
> > 
> > Oh well, I guess LLM over commenting as usual.
> > 
> > > > +		 */
> > > >  		sgl = block->sg_table->sgl;
> > > > -		nents = sg_nents_for_len(sgl, block->bytes_used);
> > > > -		if (nents < 0)
> > > > -			return nents;
> > > > +		nents = sg_nents_for_dma(sgl, block->sg_table->nents, max_size);  
> > > 
> > > So this fun function will generally give us the number of sgl entries, but not
> > > quite always. It will give us how many chunks of up to max_size fit into
> > > a particularly large entry.
> > >   
> > > >  
> > > >  		vecs = kmalloc_array(nents, sizeof(*vecs), GFP_ATOMIC);
> > > >  		if (!vecs)
> > > > @@ -115,7 +121,7 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > >  
> > > >  		len_total = block->bytes_used;
> > > >  
> > > > -		for (i = 0; i < nents; i++) {
> > > > +		for (i = 0; i < nents && len_total; i++) {  
> > > So this needs to be more clever as we aren't just iterating entrees and filling
> > > them in, some of them could at least in theory be too big to fit
> > > in a single vec - hence you need to do a loop in here that sets
> > > multiple entries if that occurs.  
> > 
> > I see! But I think that merging means that we end up with more nents
> > (sg_nents_for_len()) entries than DMA ones which was the issue we had
> > because we were left with vecs with invalid addresses and 0 sized.
> 
> You can end up with a smaller set of DMA mappings than the CPU ones that
> were typically pushed in.  That covers what happens in the IOMMU.
> However those can be 'big' and so your DMA engines own ability to handle
> a particular size of contiguous block may be the problem and result in
> you needing more entrees on the hardware side of things.
> 
> > The other
> > way around should not happen on the IOMMU path at least given the assumption
> > that a single sg  entry must not be bigger than max_len [1].
> Hmm - do I understand this right - is the question: If you original CPU side
> mappings (the input scatter gather list entries) are less than max_len bytes each

That seems to be the assumption taken in the IOMMU merge path.
And it seems that there's even some debug configs we can use that
will trigger some warning about this [1].

> then can we end up with a large set of entries for the DMA Engine after
> the merge then split?  If so I think I think the answer is no (as long
> as no other constraints like alignment make a mess for us - I gave
> up trying to reason those out on a bit of paper).
> 
> > I think in theory
> > that can actually happen (if we end using a dma provider defaulting to 64K and 
> > cma dma_bufs) but maybe we can argue that's not our problem? Given
> > the assumptions of course.
> > 
> > But even if we somehow reach this path with sg_dma_address > max_size
> > and end up stuffing all of it in say, vec[0], the DMA controller should
> > also care to make sure it splits each vec if it exceeds the descriptor
> > max size. That's what both users of (ADI axi_dmac being one them)
> > .device_prep_peripheral_dma_vec() are doing today. But yes, I agree that
> > might be a bold assumption.
> 
> Then why we are we passing in max_size to the function to work out
> how many entrees?  If splits are handled elsewhere we don't need that
> limit.
> 

I guess it was what made sense to pass to sg_nents_for_dma() at this
level.

> > 
> > > 
> > > If that can't happen for some other reason then I think you can 
> > > just use block->sgtable->nents instead of the more complex call above.
> > >   
> > 
> > I was the one suggesting the other call because it seemed what we
> > actually wanted but I'm fine with just using the above. I'm more tempted
> > to keep it simple and use 'block->sgtable->nents' rather than jumping in
> > a more complex subloop without clear evidence we really need it.
> > Thoughts?
> 
> If they are split below this layer then indeed we don't need the call
> and can use the number DMA entries.

I want to reinforce that's what happening on both controllers
implementing the vector based callback. But I do think it's a fair
assumption given that there's no way we can actually know the
channel/descriptor size a dma controller can handle. AFAIK, it's not
exported anywhere. At this level we just know about the segment max_ size a
mapping can have.

If we also look at all users of sg_nents_for_dma(), we only see dma
controllers drivers using it (with the len argument being precisely what
looks like a descriptor max size). So yes, I'm more convinced this layer
is the wrong place to use such an helper and I'll just use number of
entries we got from the mappings.

[1]: https://elixir.bootlin.com/linux/v7.2/source/kernel/dma/debug.c#L1230
- Nuno Sá

> 
> > 
> > As a fun side note this also made visible another subtle issue. Given
> > that submitting a block might only happen when enabling the buffer (so
> > async to enqueueing it) when we hit this issue, we get -ENOMEM and
> > and go ahead  to wake up poll(). But AFAIK, we can't really propagate
> > the error code up to userspace so userspace wakes up just to get
> > garbage and thinking everything is fine. Easy way out would be to treat
> > this as and hard error and return error when enabling the buffer. But
> > that also raises the question that other blocks might have been properly
> > submitted though. Not really sure how to handle this but anyways a problem
> > for another day :)
> 
> Hmm. It is always tricky to cleanly surface errors when we get a problem
> somewhere random in DMA.  No idea off the top of my head on how to solve
> this case.
> 
> Jonathan
> 
> > 
> > [1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ab2cbeb0ed301a9f0460078e91b09f39958212ef
> > 
> > - Nuno Sá
> > 
> > > >  			vecs[i].addr = sg_dma_address(sgl);
> > > >  			vecs[i].len = min(sg_dma_len(sgl), len_total);
> > > >  			len_total -= vecs[i].len;
> > > > @@ -133,6 +139,8 @@ static int iio_dmaengine_buffer_submit_block(struct iio_dma_buffer_queue *queue,
> > > >  		 * before it can run, so always set the EOT flag.
> > > >  		 */
> > > >  		flags |= DMA_PREP_LOAD_EOT;
> > > > +		nents = i;
> > > > +
> > > >  		desc = dmaengine_prep_peripheral_dma_vec(dmaengine_buffer->chan,
> > > >  							 vecs, nents, dma_dir,
> > > >  							 flags);
> > > > 
> > > > ---
> > > > base-commit: b756b143e5391151e577ae645b1378a43f93c2f5
> > > > change-id: 20260818-iio-buffer-dmabuf-iommu-fic-1b281f15e5a4
> > > > --
> > > > 
> > > > Thanks!
> > > > - Nuno Sá
> > > >   
> > >   
> 
