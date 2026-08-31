Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C854B34104E;
	Mon, 31 Aug 2026 11:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788176800; cv=fail; b=uYWU6JSZmovtEIgbDDJcXd0a0jhw8EQaEeGmYC5Cu28W1yB/O/oS/7RJQONt9w2cgTlQoJo55QorcAOky1HoLRpdrh5KOThNBlSU05lckoFZcRIsQUwF3dsDD/qQT7Q/Or4o7JUgGv1CbaZXfJIHtj9iv0HB0U+VLKS4ush3Zxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788176800; c=relaxed/simple;
	bh=2YNL3isFKrEqgbZ6bvPFxV5E8m4nMRz/vW0qdWRwnzo=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=D4tsrtrc50Q2pgcH2QDFasK8drp7E3ZcQtFul/6bE6YJhoB+vF7Z0p6xAnd0w7dSgLSK5eW3VuqrvavyIe4JYZMKA3rECj7VgKXZ5e1d7f7zzb02qF6h4RB2cNF3Hf0kGCG6vWGis6tgFSe72YQwxM5WTVAVdBdJp4PUElsS/iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TXlbhHGn; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TXlbhHGn"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67VBDV38513617;
	Mon, 31 Aug 2026 07:46:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=7OmzR
	8tZlIsVfcPhNYa0asN//4ZA6Wpxcc2KOZimLmM=; b=TXlbhHGnAYUe5WiMZOZPf
	8NI8yEfyEiowx6kXldeusXP8JYnOEmGod4KuG3WZknxbLuvvFNgjC5fsO6lBfp+f
	XT160dPsrVWw8Uj6/+F16RbVYHlkznr5xtaYHUbWRvIp2djvlqNnjNJ5ZSTE1tvI
	TOzgi/m5oP3/juv8uAmURe/WFe0aK3U83OdkVDGtfGzp2Z4C1JicTRmDqah7jAkG
	fSP8xsCaYvvt0qwfz+ygZj/XqP4n2Nbnit8mbEuruPb5w9kR6f4Rxcnm0SrPCwV1
	0LJQgj5E9HaWCh84FlpkMa/8pEszrrrn0vlxprP8bpXvHGGnQJBgiUm0zX7vsxFO
	Q==
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012040.outbound.protection.outlook.com [40.93.195.40])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gcdrdmhdy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:46:04 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLcUqCbiHbMD9nsLfdTojV7EYlBZIAOZkVn+V7t14AycMYLN/SsuFbEyQeSykMlFbrCF/LMnFu3nPsl9cgCzkqDQzID05ESTqWnnRmi65lypD/9AGe3boI4fTkO8qUZrv2IlYB2CjdfXLfx4LSp18eGVUsaVfQSY73asHCKQlgHNCpKk4LGBMCF3xeDcdNowmXY/+0fH/N3tG5S01bnaf20FCR+XpAA4SMobJHBZawWtfjgQ/4kvSOnszj3rie6Wj5EjN+uMvRm49EoNgn9JhyWol65R5thx+0b5jKveVpObYWF+6kBS5cg+JWA7C6gREaYdjSQgOl5KPjLtAIJzmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7OmzR8tZlIsVfcPhNYa0asN//4ZA6Wpxcc2KOZimLmM=;
 b=zQOs5Mwmc7Lm4F1ryLlAJNZFM9kYF1eVZcTTgJUfBDRd5h4C/JT9VXnuopYFli7uVUy+GJ9UI5FoQrgqBKblcwkjx5wq3w4Q1eFUdI46/BzYY8Va3Qs1EzEpt2By7C5cG/4n8bp4oRECEFXj951r00US5sJE/UeZ6R4Hru0Lr3A1lg8foD5QKmdJX3pk7+6WdI91+s7vaXxgH8TurIWY9Gr1Nf0eGoExRWLimW54h4UTAx8hKa6VkQZ02rIL60JHy0GHVRbAuVj2N0xfCOr0Yh1IJ5YyzuIRvIF1fdTqRaDaYF5kkYlZhBuR4AAX5LogKe18b+QWnjU44yvC4+Tt5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BY5PR03MB5077.namprd03.prod.outlook.com (2603:10b6:a03:1e2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Mon, 31 Aug
 2026 11:46:01 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0360.008; Mon, 31 Aug 2026
 11:46:01 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 31 Aug 2026 12:46:46 +0100
Subject: [PATCH v3 9/9] dmaengine: Drop legacy bus width fields from
 dma_slave_caps
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260831-dmaengine-support-wider-dma-masks-v3-9-507d97496f2d@analog.com>
References: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
In-Reply-To: <20260831-dmaengine-support-wider-dma-masks-v3-0-507d97496f2d@analog.com>
To: linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
        linux-sound@vger.kernel.org, linux-spi@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        =?utf-8?q?Am=C3=A9lie_Delaunay?= <amelie.delaunay@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>,
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788176799; l=3848;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=2YNL3isFKrEqgbZ6bvPFxV5E8m4nMRz/vW0qdWRwnzo=;
 b=2N8Kz4P2QFBTOT2ybhIy/9sgD2F0nABo9j647T68X6qzzghLv62bb7ZW+tR0SmE/W68cHyzjL
 18RveOtQiqxBpHTMEY7D/Cq3febK2hIe1d86ee3HKu3HJ+DJ3lBjTjA
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0061.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:49::14) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BY5PR03MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 8450952d-b554-4552-d2fe-08df07556e36
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|23010399003|366016|1800799024|6133799003|3023799007|10067099003|56012099006|11063799006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 q+eedsc0eBCXauPYbQVK7iqIhnBMFFo3NIfdnQ/P3V5AgUWD1NdECmr3xwd9UPCZs7cMPOT9mJs/v7c9eurY/kmjcf2zgKuzv4kvgHQRrM7JT8HqytmoK9znZRI+SagBOqAH0O93loNZfYhUoAna1N5TOSeV4XGz9RvS4Dz8s5vjnRORcxeee0WKflmxHho+8PkpMKpPhEwYLJjoAnT7n7vP+/m9ACRAke9matnw01YrhOwcfBcOft1u8afg0UHmcJFlyGZZCj3uzIo2mACFkjES0xnBPN8QjqE9gV71f9tbsuInDVywX5vWaCWLzxOdMlj+fkKR+IyHfPJ4JfCLlWqAPNa+af18QEDASQHH028JXvlVl3mzkW8Xyr+LsqzFIKKuQtOZhrwmkQUECOWWdFuMUxdeZSRVqCHUhZcz9ghSZukyAy/z8m72/Gk3hrYv6KHY2tPeFgEJIdfAHrQiLvq+/yR0/O6fen4C7pV6OOjejSCBh/oOiZgZhBfwfDtY8HY14R9ZK2ce7adkAqX1igf5k5YQna2w9TDNSMQqeAeC1Qc2oNmpGi0mTox30TokNwDJ5o0NUDsMkSzHOxIEwVtgqBRQSbA74WBquk8W+SCLX3Kv1duC7StPfOATEwzvzQYfuiXVgkzYQnFW/uPOUvJOr1fcmjV5gSl5HmZx+ac=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TUV2TFdGSGxlSWVmSzhiMUsrTGNOWmhrR1dneWFwQUhvZGcwUVdzVUZHNGdt?=
 =?utf-8?B?NFludnk5cDJxalR2V1NYbnFFVGVRenRXNktaUWJUTndqWUVCR2JHZGM3TTk0?=
 =?utf-8?B?RG8zcWgra0ZFRkoxTE55cUpnYWI0bDE3M21lcG9NMXBPaU81aTByVllOQVZa?=
 =?utf-8?B?Tnh2STRTb1o3ZFdSNVlNdjBNcTRzaXdkb0pTL1ZNV1d6NVVZckZScEtPTFow?=
 =?utf-8?B?Y1k2V1JpNXNTS3dmSUFBeW1NWHlIU25hWDkvMGYzTHFqdVRKR1h4ZGQyelIy?=
 =?utf-8?B?RnZGV0JEUFZoQ1M2dnlyeHlDRy9IVzJmT0pZQUFZK1BCZTdWaDdWSGJhdVNM?=
 =?utf-8?B?TWpiNEFWQ0NsRkpVb29EcXhzTExsU1JhMC9NSDB5akZialNqZTdIWlptdWF0?=
 =?utf-8?B?NTM3TVNwcmxnK1dQUC9RbGZQUzdBY3NNZnVQVDhpNDV2U0xTVzlFZCtMZzdL?=
 =?utf-8?B?MmU1WldpWk90anZCYlNmRW1SWlhhdnN6T3NmMEUrMWtoR2VMM2RhMFFzWDRu?=
 =?utf-8?B?cmxqbjFJSEVDeDVXaXl4SUQ5aXpIZVIzbzZwSld2U1F0TTRQeVZITVJMMXhM?=
 =?utf-8?B?MFZPMGRJWXgwVWxQZTVxenREOVVKTCt0V0l4WFBMTUdOb2VlYU9TQ3pNYThY?=
 =?utf-8?B?dkFjNVU0MTRab0Z2TUMzMW56NjVuVDR6SnhocUx2UjJoZ0Z6bkdnT0czWjhP?=
 =?utf-8?B?VU9rd1pPYVdKRUYvbEk5czBmQVRGcWhaSjJpd1A1SXloTmlCcUdTekw2N0RN?=
 =?utf-8?B?aFBiZVJ2WUdIR3lFN2lRLzFXQzRvbng5Rk5RajhYVXNiRnkya3dURkhJbWlp?=
 =?utf-8?B?bkVCU1RMMEpwVFdUSXNBWVNSV2gyWHBaZjhrR2ZOeWRiVTdaY3hFRE9zM0xC?=
 =?utf-8?B?ZzBOSGZFQkZHVUV0MUFGTVM2VWxIYkZnN3FRS2p2ZWZMWi9MdUpwaVVuTFRE?=
 =?utf-8?B?NXViNjVZNUw0dTAvTlFWaldVcUJsQU5uYSs1YkI2NFppWk54UGN6dk5MZXZW?=
 =?utf-8?B?dSs0MmUwZEVoU21YMzg3cXJVOWgzVG00dGpYT2drK1lleGdKbzBKNnBWRXli?=
 =?utf-8?B?MUxTZDlTZGprTkFMaU5sNHA1WVloaWxpNHI2aXJxaTZDUk4vbGJDLzlpZ29v?=
 =?utf-8?B?ZC84Z1U3VGM1d3NsOTJ4a016TkdnS1U4SWR4WndmOFYzdmkxSFIySnM3NzFp?=
 =?utf-8?B?RlFsR1JMWkZOUytnemh1S1pXUmtWRmhyb3pRaUxjSUNlbnVKUXVJSXVvWHBW?=
 =?utf-8?B?Q0xJR29KSTFFK1E3cW9iK0tQbkRHeFQ4SEErNWpHcVI1OS9MNTdaZzZYa0Nn?=
 =?utf-8?B?Yy9zU3orOGh6cTJDMlRaMVh4ZE1JUGlzUys1V3dZbmlYNkFwNWlXZzZaaWlr?=
 =?utf-8?B?UEJYRThDL1RyR3BWTHBTZWxMRWRPTGpUTDlEeDhrV293Tm5KOHdEbWpUY3F4?=
 =?utf-8?B?M1RrSlZtMk9wSTJyM1FSTTFvRmFjVVZjUDhyQ0xndElrTmIzUVBLQ2RndTBa?=
 =?utf-8?B?Kzc4aE1PWk1Fbk83SEpvaVA5ZDZoeWRDdGV2dnpMRzdWQXdUQUdCWjRCUWZY?=
 =?utf-8?B?elFiU2p3WDlTOFpTeTE5dnB6NjlURitWTlA3SnhwdURlMGZ0WnZ1MTJDYzVB?=
 =?utf-8?B?THF4dDdEeG8xdFM5bUNGWEUyQkFuanBzU2hnaGZoVWJUR1YyR0lIOWFyc0Rl?=
 =?utf-8?B?ZkF5TjFsWDBtZmRCeXZVRVcrbGlncEZuaDROM0c5RzFsMnlQcGNQUVFmT0lo?=
 =?utf-8?B?bXBiUmI4VGFBdk5PaG1jUTZ3VW9SLzVnSWVRNmdvNHVZK3Axbk03MVcxOSty?=
 =?utf-8?B?ektYRzVPdHJ0ZGQ1WVFud21NQmhEYkIrZFFqSWRMU0NhYzVnRVRGVmFqRUZk?=
 =?utf-8?B?UFB6Nm8wR0J6UDYzMWhXd0U5eHRMeXNNZ2hzMzJVdERJdW82bDNGNDNBaXZF?=
 =?utf-8?B?VFhFTnZIWHhId3NNTzlxUzNyWSs3aUVPZXZqMnNUNzlOVE9uWHU0SXpERUE2?=
 =?utf-8?B?QVBhZ3pRMlVBeUorMCtKTjhiTC81WTJpWGhDNXEydUNKaTY0UEwzb1dhN0hK?=
 =?utf-8?B?WjFOV2ZMNlRDa2g1dXVESGFpTkp6VEszeCsyaStudGs4K3M3ekZkUDVPb01E?=
 =?utf-8?B?YWluSEsyOHdNSk1ZaVg3cFhXcUpEOGhOeXgyVXByVTFYNW84dXR2M3ZsSzBp?=
 =?utf-8?B?cUpyNDJHYVZzZ0F5ZmlzVmI2cmlEbnowYWt3Z3dIeHJtVnVXMm5jQXBXMTd3?=
 =?utf-8?B?bVRxWWNkemY3Nk1mU0h0NXR4d2VNMHM1ZDIyWStWanVPazhEclVHcXhHb1ZX?=
 =?utf-8?B?ME9sV1NBbkpWUnQvOHNtd05sSWdwd05kMjk5UGtwYWlMT29zeTlYZz09?=
X-Exchange-RoutingPolicyChecked:
	y8tnpVpoDkgYYW+jToC8njsT2LUcIkvi/bZqvhGUdVCaSa+wSx01l7Fc7Qsjj8vTlXewq0iiiVgYYN51kiYpGpsQ+x4TsWV8jav6PnDoicJHLdKmzLyQLIjSmWVZsxZozSaNXUS1pC9bCuBcyuFKfn/k4pmxOoxjU1a8iwBK+ww4OziKySxyOTQ/4dezaqcSb+75MIXbzpzmz33G+wlxErGJZ4qxOo1vlJZCHbq1a5cfIWdA1mS76UiCv3U5MAbpCowre/txSu4+qX5/c+Ey8mF2htCMTR/tZY/N3gDLHtoPhLm+ZCwZg/FljPIAnKkmanDamXZ1FrNhnjfObETV4g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8450952d-b554-4552-d2fe-08df07556e36
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2026 11:46:01.3466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hM+yf0phCqmOHd4PUfnT3GjZmmd7XjNNq6jXr8JgOvUH1oyA0PRsxgu5oYiV/d6IA3armQuYIl5LsWLgSj5l+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5077
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfX+CX7IgDcMTjr
 0NTXwFwYQOzVy6ILzbXhCzwJVUTt5lCcu7urjkGbo0SqL/twM0gKqwJTysc9FEgygNfL/T2pL0W
 RQdk1SkgIMS9y72nHdlNWnBIbTdX7yEnTQDC2dLIkVx698QzZmKx
X-Authority-Analysis: v=2.4 cv=feSdDUQF c=1 sm=1 tr=0 ts=6a95697c cx=c_pps
 a=zWRuVz0++A3eh/KBGeICZg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=Kdv_YGyGnA_3IfjWuAwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: TCEDUKESBll3eSQ1XqmSkHvRFHgGvhYL
X-Proofpoint-GUID: TCEDUKESBll3eSQ1XqmSkHvRFHgGvhYL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDEwMSBTYWx0ZWRfXwhUJtmoSbQzi
 hX7/8k66EQPRSx0i39EorFC7nOFdx4H2o9qQPcJY9O2UdhmCRVXeTS3m+gCKuMBjOW1Es23YhTd
 baism8r5IOi3UvILIUPaq5noxO6NPgGOhMFVCIceG4kqs+Za2Tl77GTIhM4daIWKLcSpY8thzes
 8wXeVVDrSRQ40ufQVi0rLE5b1kWB3XV8GLCBoWbSs7LoYT+HQMow4z0Y449vy/WJXSER9607N3T
 lMNh3I5VPMRg03G/SSmLij8APqE1dERCPF+mrk6yxOow8ya9gboSMMrOmN10B6sLR5SBiAS4Lij
 2k5L/IXrwAEWGNyDdkOI9gW1KpL6NpZjEV3mVuZl/3DVTQ8M7DBpaY89DBxdZ0DOJWHammtRv9l
 OEMh+e/NNBsPxnMrHZzZz/7e4wllfdek9RVW9zwfETRgBQFDRO7LSPqmEwxUEZQcjbC4eR7zLfW
 i9zxQV8s3HKesqwlBGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0
 adultscore=0 bulkscore=0 clxscore=1015 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608310101

All users of dma_get_slave_caps() that inspect bus width capabilities now
use the bitmap helpers.

Hence, remove the legacy u32 src_addr_widths and dst_addr_widths fields
from struct dma_slave_caps and stop copying the dma_device masks into
them.

Note the legacy u32 src_addr_widths and dst_addr_widths fields in struct
dma_device are kept for now as every DMA controller driver setting them
still has to be converted to the new helpers. dma_get_slave_caps() keeps
folding those masks into the bitmaps it returns so unconverted producers
continue to work during the transition.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dmaengine.c   | 26 +-------------------------
 include/linux/dmaengine.h | 13 ++-----------
 2 files changed, 3 insertions(+), 36 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index ae85d26b4803..6346b8664228 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -596,8 +596,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 
 	dma_bus_width_copy(caps->src_bus_widths, device->src_bus_widths);
 	dma_bus_width_copy(caps->dst_bus_widths, device->dst_bus_widths);
-	caps->src_addr_widths = device->src_addr_widths;
-	caps->dst_addr_widths = device->dst_addr_widths;
 
 	caps->directions = device->directions;
 	caps->min_burst = device->min_burst;
@@ -616,31 +614,9 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	 * callback to override the generic capabilities with
 	 * channel-specific ones.
 	 */
-	if (device->device_caps) {
+	if (device->device_caps)
 		device->device_caps(chan, caps);
 
-		/*
-		 * A driver already converted to the bus width interface
-		 * adjusts the masks, so derive the legacy capabilities from
-		 * them for the consumers not converted yet. Drivers not
-		 * converted adjust the legacy capabilities directly, in which
-		 * case there is nothing to do.
-		 *
-		 * Goes away with the legacy dma_slave_caps fields.
-		 */
-		if (!bitmap_equal(caps->src_bus_widths.bits,
-				  device->src_bus_widths.bits,
-				  DMA_SLAVE_BUSWIDTH_MAX))
-			caps->src_addr_widths = bitmap_read(caps->src_bus_widths.bits,
-							    0, 32);
-
-		if (!bitmap_equal(caps->dst_bus_widths.bits,
-				  device->dst_bus_widths.bits,
-				  DMA_SLAVE_BUSWIDTH_MAX))
-			caps->dst_addr_widths = bitmap_read(caps->dst_bus_widths.bits,
-							    0, 32);
-	}
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(dma_get_slave_caps);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 31c57d3dcb53..7441702015c3 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -481,10 +481,7 @@ enum dma_residue_granularity {
 /**
  * struct dma_slave_caps - expose capabilities of a slave channel only
  * @src_bus_widths: mask of source bus widths the channel supports.
- * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
  * @dst_bus_widths: mask of destination bus widths the channel supports.
- * @dst_addr_widths: legacy bit mask of destination bus widths the channel
- *	supports.
  * @directions: bit mask of slave directions the channel supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -503,14 +500,8 @@ enum dma_residue_granularity {
  * resubmitted multiple times
  */
 struct dma_slave_caps {
-	struct {
-		dma_buswidth_mask_t src_bus_widths;
-		u32 src_addr_widths;
-	};
-	struct {
-		dma_buswidth_mask_t dst_bus_widths;
-		u32 dst_addr_widths;
-	};
+	dma_buswidth_mask_t src_bus_widths;
+	dma_buswidth_mask_t dst_bus_widths;
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;

-- 
2.55.0

