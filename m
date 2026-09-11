Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580AE4A68A1;
	Fri, 11 Sep 2026 16:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789145980; cv=fail; b=XBgzRYkt8/aEps+O3jWO9Bfh17J2qYBe9GVBNvH65S3u6NUw5KPEpnI/aPaJqvq4CTMfE+rgaQ2qBR9QPN2HTm9JvSS6CTPVuo5ths1+D+rdA3A8Y4UBlCl0N5NgU9/0QWnnitv1rqiW0yYHv81rDcdmFt2tcqFT/tiBuZQtcjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789145980; c=relaxed/simple;
	bh=h0VDlGPfO22xj+imqTw+Z8YBqEuJK3tb2tg2rk/M5xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IZKjbdswu8cICMwKGGxO469g0lhLqG83uI90yG/0xlMie7spUbqz/Tlq15yFuodV3LxNDpdd4TyrNXq147kEhT/yTlDXPv8R+pyi12Dq4Yzg8pZFpE19ss1vp19LzXB1CiQ2zO12XOWr2xWytcwkMtOuiT3qT9RfZsnXkjIORts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ARjNLBgo; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ARjNLBgo"
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEinx1685441;
	Fri, 11 Sep 2026 12:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=jU5ln
	Cux5MoWJwvTX3ecr7/FRn+aWHmTCDSI/zvPia8=; b=ARjNLBgoXVvKdm3DiA1UL
	87FV53vT83Vy6fSCzjwwgrfrm3kLnhymBYA+g72N7U6WYgipZUTsqMShAYn6vvm9
	exT+J095nhgll286um31ioZi5ece4pY5c2h+7wzO23mqqPvkK/+AQ9WfDyej5eYB
	nMxuRyCI9xbwVZyNPudt7g5WJAd/PjGrYOfXaAN1hsoffiyX3BSfnz7wlbOovC05
	ApsviQHp8EnX5Ex2KfQLesjbfFVv1Rugplj1fEqmjR+XBkX6fLUuV/2n+igHLdZb
	EenmE2rFGKpUHphrTHMNDRfJt4qGbWBjjRhekhgyR9vt1jfSUNXJaP32ZwTmiOsQ
	w==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010040.outbound.protection.outlook.com [52.101.56.40])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcx8rd4t-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 12:58:42 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1FcOILGtpyTb6fn6QM9A6nGAJIJM48HgRcthVEDUXHoi0aXjaMkdjrLIIsArRnxhXT01U+0Fu7lNFyOkPAMg3DSD06rL7Z05TSgJ8tOLtM/MFj4Qt+hb+gBBXjY1v48kTXci3NMmtCo2k1lBLqdS9PqdDOP8eEbbK2UFRxduHQd0Mi+KayaWW8s6RodgPKauit0BUA/FLkfRijg/8K+oWSN5YunCFKfElGNxBS3QHWRS8EGcmBN5VB1Dp1JSUpjapWzm7bJbrro/x/mjC5NNO+fWz5ktFjyuxO0fxNaEpx55hBAedSb67/l95001+TuyyngmqzlZd4EqhXCeDUJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jU5lnCux5MoWJwvTX3ecr7/FRn+aWHmTCDSI/zvPia8=;
 b=ugzry2aSKFiId7+fDVm6iiArhnYQJmppzkvZTyXadN9kBbnEDkVVL5nqgG8zJmp7Drq5QDRDbMfgYFRdjvxUoio9hwdNCMNbgSFDTarU+N/N8JSH03FupV3WXRtk1Fitbzek91fn2AdMc6gScLarcpjLlyD0KOHMO5hbilZF6JTvAZRND/JZxBvwsYeKaW2W6ZdbAv4GXgAOcmeKHZpcoZ4z5sp/hutOK+UAb6Mf7wYpnHwd/Bo/hdystSAqxCe6MVbRmzfwvqVQ/V35KSCsitzwut+bqpgpzgTa5m/CWu8kZSQKb3cmV3M3G2dWzfxfZYUfsQfuuzzW1h9HWaHwEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH0PR03MB6082.namprd03.prod.outlook.com (2603:10b6:610:b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Fri, 11 Sep
 2026 16:58:38 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 16:58:38 +0000
Date: Fri, 11 Sep 2026 17:59:54 +0100
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
Message-ID: <aqQyiVxibcrCNCMs@nsa>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
 <20260831-dmaengine-support-wider-dma-masks-v3-1-507d97496f2d@analog.com>
 <apWFa4BFoAL2AhG3@ashevche-desk.local>
 <apWjMBvGA6yo_nCZ@nsa>
 <aqQaUx5Ok8uesHu5@nsa>
 <aqQnF9-Qtc-ZJJWa@ashevche-desk.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqQnF9-Qtc-ZJJWa@ashevche-desk.local>
X-ClientProxiedBy: MA3P292CA0039.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH0PR03MB6082:EE_
X-MS-Office365-Filtering-Correlation-Id: 31526200-3efb-4754-e687-08df1025ecdb
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|23010399003|366016|4143699003|11063799006|56012099006|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info:
 /ck9F4eZimXGgG9fQ8oodZcvW3Q7XaK8D1qHbG4sV3IEuY7WqtluopUyudGbA/y/edcABFZu/5zBwT5YQ+MwA8MLJqjz+nW06NMkwuaf2Vuu5bH/ROC2bdfeq75WdeQ5TwRu+oSgvq1ZWB43jSLpsJVJExF8Ey9KNvFhkxjST9m862guSGi0nKA14dc9XygpkNkypUwJT0pN9nXLnnj2gm8X9/XLt8HIGHhNPckTkpkushFa3MpgWnUqMu+2ww5nTBqOFeS4X8HuDuKEk4imbCjE744zIf0322rLpUAJwZBduftccObLEL1/Ch8YQ/Fyk2+Kn0lNLkTi10VMlHOAlrArZ7UFU7nHIGg7uequHqIHUvXcjJOsbI7BK4FPu27vRw8GfBC2DBMN/HKRMTEyUJhbr4Q1qUY/N49K04y9ZWLX1+a9MAyZw078PfYx9YBHF6fOmgx3lLhdWlSjd0ui9iBWF3OBj+gLSbzDQqRT0KKsgiV2ClawLdeDU2oOPBvQrEkTB7lUjbLv+CCA7GqY28y6rop3SD5Wd2TImsqOiuaJS4hlQ/3wf8BT3eYYyThgNsPNu+McVcK/f9S4F6f707u9GCbX9wRC4OWc5sKNrrvbZpsR3NrPQALU+m0NWQaWW8oDcDXQlzGEkiNvA/VVlZKwSlXWkdftLLw28AQi/yk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(23010399003)(366016)(4143699003)(11063799006)(56012099006)(22082099003)(18002099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?MFptOWFjdDhia29yU2tNblNQWFl1T3ZzZkpFbnBrM2tzbXhiZXJzK2VPdGt4?=
 =?utf-8?B?L2RKSzhqMXAxNmo5UW1zaTJtU0FLaTk0b2FzbnR1VmpYbUVDODQzSWhnV21s?=
 =?utf-8?B?aFVUMHdtZ2Y4ZEZYRFNVc25xRGZpMU1qTUNyNVM3MzJMazhMcVl1V0VERXRE?=
 =?utf-8?B?TmdsdGIyeXRJY2NuWENwZWJBRTdLdVV0SnZyNWprbFRudDlQTUwrMllSTkl4?=
 =?utf-8?B?Ymo2NzY1NUpQM3NVeTZlSFRxSitMQW44RTRKbDdNYWplenJXMlJZVHFCeHhr?=
 =?utf-8?B?c2RFU1IwOUZ6L25BM3pDNU5pYTBEYml1ZHBQWm8zd1hnbG9hakVQZnlYWTZu?=
 =?utf-8?B?Zmc0M2xFeXFpaGZmQnRmeXl1L3BscUFKbkZFL05VaGZwcTcyTzdhQ3hZQWNt?=
 =?utf-8?B?SklZbHh1cVNDbzNESnl5TUxsb3F6bk8yT1Z6eUV0cnprdDdMaW92STJRYjVF?=
 =?utf-8?B?c2xtZVRCaHl5UHplQWRuZUtIU3ZCb0ZXVEF5SWVrNGpWU0hDZmFyUmFjeWtn?=
 =?utf-8?B?L1pzTDhQVWhtU3EwejFYaElNUXJMOXZnRVptZkRlOUZCbUJnbzRpOXNCb1ZS?=
 =?utf-8?B?QXV4Y0dyendyZTg1ZGovaWpIR3hBM1l4Y2s2RzNYTVlrOElBbko5RVQvUHli?=
 =?utf-8?B?NE9WYnRLcDJKcXZLNCt1N1J4MlAvZW94U0xLdFN4dzVvSkNBNVpESDFuSEs2?=
 =?utf-8?B?ODQ2bWM2d1AwRCtYR3NjYm95MWFVZWlTMlczclkvL1R3NGozd0VBQXlKSVRD?=
 =?utf-8?B?NkpTYjVhejZJeFpsVllWc0Y5c21RWDZTZS9MREdPR0ZlcitKUUZqckFHRFEv?=
 =?utf-8?B?dWhId2xlWDU2YjVkTUVrS3ptelg4SGowUUk5RllmTkdwN2FNNEEvYUVveXJN?=
 =?utf-8?B?K3BaUldRUXFvTi8xMHpudUFQN0p5aHE0L1p5Rm00MHU3K01kdmdMNnI2V2pj?=
 =?utf-8?B?TmFnbE5KM2Q1aTUrdy9TaStIMGRFc25yZHQxWlR4c3lOMGxMNmI0SHd2Ly9y?=
 =?utf-8?B?Ni83WEhUQWxHcWVGK0dIdGlET3U5ZWJjQjNJb0FPdEdQb20wNW1vUEJDaE9k?=
 =?utf-8?B?L0ZGeCt3bXV6QjhSZUlGSEFLMDlLTm9WRVk1dHg4YmJIR1FpMEFCNzRORzV2?=
 =?utf-8?B?cWhYcjhNTUVNUUYwTzN5MzRZU3RNU1J0dTVHSkZESTdMdUdsdjBMR2pHczlT?=
 =?utf-8?B?aExZRW0vT2JJcWFWYnRrWTdqVGVWUjdXWTRBT3cvN1NVMFBSbmxrOFMzWHNR?=
 =?utf-8?B?WElsR0JLbllITW1zMW1GbzNwOS9HY2hpR0dyN2hZN09HcXlyenMwbUZQSGlM?=
 =?utf-8?B?RjBsVk8yeTFBa1JKcGorYk1JMi96MWhqNEQ3SndWeUZ5RTdDMXVaRVVycTM3?=
 =?utf-8?B?SVVWOVkzWStnTjNmWDZaUmh3WFhrKzdMdXJpYTJOTHFIYlZNZ1NYUjlVV2gy?=
 =?utf-8?B?RFJLOUtkUGdMdWVHS2toYzN0K0R4ZVd2VkJXTmo0ZU8rRXJlM09PN1h6WUt5?=
 =?utf-8?B?UjFrT3haRFNEZ3hoVk1NYm5sSjJGUWFTaDY1R0YxYk5lUTJRMmZ3WWdCNWc3?=
 =?utf-8?B?STZBcy9sUDBrL21ibER4K1VrUXMrOHlYOHBibGFXcWxvalp1L0JkbmY5TjVB?=
 =?utf-8?B?eUVhaDZhUnRHQ3NKdlB1VUZYemlRa0FIL2Ria29Dam5BUiswZHU3cVpYaDhW?=
 =?utf-8?B?T2VKTDZ1b0ZEc0lDUnFnVEdVNmJtRXkrMjJaMlBudjNkZTl3b2h3ampOZm9B?=
 =?utf-8?B?MEFEUllNMXpLSVRXcXZBOXhkeEo0QlNqTUJRYWM3Vm1LZDdnclJOWXdnL2hq?=
 =?utf-8?B?RzkyQngrd3pLN0R5K3dFcXRENjRJcWN1OExWczhnbG1WOUVnN3ptZzl1bHVi?=
 =?utf-8?B?SnltVjV4U2ZnZHk0U2RGLzAvUldMYUFvYXgxWkFsM0RaYzRSQklFVEord2Rz?=
 =?utf-8?B?ZkRvVCt3RGpRNGt2eE4xaEpmQitWUEEyVVFRQUYvdWJFbEZoQXUyYUVKYzdw?=
 =?utf-8?B?c3c2Mkh6NThwcG92Nk4xRk5KRE5SVXVIUlR6MlZrTzJocFBjcCs4ZHFiMllH?=
 =?utf-8?B?bHd0bVhsMktBM2d0Zks5NHNuNkJ2Y3RiQUJUMjZjQnNKdkpoS2JFNkVzRU01?=
 =?utf-8?B?cnRydDA1Z000RmRSUjNsWTY0TlBnSytObmtmWk9QUExLVEVPTGV1SUkzSXJu?=
 =?utf-8?B?OUFCcTRDY2ZHWjB3Q0pvVkRScGRScGdBNm80b2dvQVNhaGVOalBHZ1lrdGxQ?=
 =?utf-8?B?VjY2TjAxT2hXclQrUm84RitXL1ZOQ2JaNHFLK0ZwOFJPc05kOVhVaVNYZHRX?=
 =?utf-8?B?YkhuMDVjL1hHbmFJTjBEWkk1WU5WRFNaamR6MFRrUjN0ZTh2eEdhUT09?=
X-Exchange-RoutingPolicyChecked:
	X3tRaBDweVJQ0dObtmACRBFZ90zfmhBmQulGGj5wGby1aPTRv4NtDHJW71tvppYEf+FJJeddcB44k/LWY0StNvh+cv9AewynD/EKL75FrFaQE17RJxKdAm+BJlLmIigOJ77zsWFLq4+R64Pdt+7AZIWE9nuxQQc/+xwCsALZBUGyrn5/Q5sXP95vzLwvOdh05NNnTN5eoohncnS8mg8E3krl616lQcm/Rxe5yCcouQmz1B3f81q/MPuyEhKgc01p+a0Z0eP0mrEyhsWTrFe9GK6kzOe5Z/95/3mU8HQ8bsq+fIaWHIInxOTJTFSPBb7MtTATaT6ohH/2LPBAngtvAQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31526200-3efb-4754-e687-08df1025ecdb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 16:58:38.5935
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MbqucGkrNRoY9pb62a5AFfe1JlyCGkeDGnIPDTkttiieegE/2KaL3trnrU+ZsthNVItnQiGon0B7OPGr/Gk2jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR03MB6082
X-Proofpoint-GUID: sQbf1erA1II7khbraTX7fHujrZc6PbYB
X-Authority-Analysis: v=2.4 cv=JaApPkKV c=1 sm=1 tr=0 ts=6aa43342 cx=c_pps
 a=gS8+cbQEeirDoRw2OPG9zw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=_jAD5XSDOtq9-5Nde2OG:22
 a=qT16TcJSW1ifsEtkDAcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sQbf1erA1II7khbraTX7fHujrZc6PbYB
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDIzNiBTYWx0ZWRfX2RjgvNVK1uYr
 ic3tV5qkXQ1wPVNdEv5un6oolGNItbhfZ7KOZKfQ1osglNg0g9So8+ZSLk5lf6w8ZBhEi0MkWFs
 NybwWPadv/+AsfPrextVsUcVny1Ohyir/Oja2HKBW5RiC2ctluUF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDIzNiBTYWx0ZWRfX+h+zsRHNsoYf
 C9pJbSQuzQmi8tzx7tGnIGCmhEHQZGjO+PcUompDU77lzO5TjMMVV2eZQpZG9Bf6DmEdZHsYIKA
 quwQQGvJ7qBO7CsEV+/sG4toVAvB9mmfltGPpLrX/yKHJVaRH3il7ysDsCtLiF4VhF1a+QCfwAw
 pZ6UBJ4I1uhzRZm9Kp8hU31a9+NkJw83KPnUuGvzC9iBauMmlikvCu8mV7l8Sq3H2zNXRCMy7US
 HkNz16iFEpw2lNmvIu0bHdCu4uIAitP0m7Q79OPaN6O/XCn95vhC9vDRT1vwnwXKHSIQaIC7Apu
 Sa6curLmlxJnq1yLiWA7249zKhsLx2QsZj30LPt04MnTFGj6r23jD08KuWGf0o9pnnflxTtuUOV
 1176xUe1AewrEGyY7V+rTC6XVigDmOnuAy2HB8Dl6LTUxzIw1N9oF21xBagmBJLig7fiRfvcFpC
 0atKs5qzGB6lcmDBL7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 phishscore=0 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110236

On Fri, Sep 11, 2026 at 07:06:47PM +0300, Andy Shevchenko wrote:
> On Fri, Sep 11, 2026 at 04:14:20PM +0100, Nuno Sá wrote:
> > On Mon, Aug 31, 2026 at 04:56:18PM +0100, Nuno Sá wrote:
> > > On Mon, Aug 31, 2026 at 04:45:15PM +0300, Andy Shevchenko wrote:
> > > > On Mon, Aug 31, 2026 at 12:46:38PM +0100, Nuno Sá wrote:
> 
> ...
> 
> > > > > +/*
> > > > > + * Basic types shared by the DMA engine interfaces.
> > > > > + */
> > > > > +#ifndef LINUX_DMA_ENGINE_TYPES_H
> > > > > +#define LINUX_DMA_ENGINE_TYPES_H
> > > > > +
> > > > > +#include <linux/bitops.h>
> > > > 
> > > > Not yet? Perhaps next changes will use it, then they can add it.
> > > 
> > > Should be dropped!
> > 
> > In fact, I'll keep the above! DECLARE_BITMAP() needs BITS_TO_LONGS().
> 
> I'm not sure I follow.
> 
> The DECLARE_BITMAP() comes from types.h. It's the problem of types.h to include
> bitops.h for BITS_TO_LONGS() if required.

I do agree with that (that was the "not great" comment). Just wanting to
make sure this header compiles. But it's nasty I know!

Well, I'll drop it! I guess other's are also relying on bitops to be
available when types.h is included!

As for this series, don't want to keep adding patches!

- Nuno Sá
> 
> > Yeah, not great...
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
