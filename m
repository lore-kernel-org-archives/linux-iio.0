Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519297;
	b=BBw1SHBvsWgCVc+8itVXrU4MNic9ttUozSIwqH1iFxhJNfbT1bGnce30/jcyFV8uF7va
	 Sq7SkCb6v7pcbRRcPYgtLu8JfjjPm/nI05wz5puoA/lXKjR0EqnL1gX14/esbD0ietyno
	 ZYdVzchAkT9Mq+o7sPtFcLFIpLTlaNiEJLs6xRdkTdA74N4yzy3mkqD9AgjqGiBGHj/dN
	 bmhffYnibOy4lOc/te2aT8lfqBAACUmTUDioSq+79JeODHmbCX88RfqenVjzF6CZjEXhz
	 GmqkTKs2F/62Wps0peCWxWlGcPfw8tPhWms2z5HRioumnutMSD4hZkErtDdzN0G+Stg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519297;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Date:Subject:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-LD-Processed:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-Exchange-RoutingPolicyChecked:
	 X-OriginatorOrg:X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=l7Prh5Cg/8w7dgmLbdnWlhSzPDdTFV5MVBX3KzHqT2M=;
	b=4h0H1dUr7QPas+oNiMVljtJoj0gIrRXn/oRI1Ev080koYK8XzFsIZSE+ENjz5XC9/yVx
	 r7f7OYtCcJ1stTtqAS+Y1xpVwq7Pbtbv+NOPGb5A/7Jj7AOFWLQGb5tOkiONsLzuts+00
	 l1b4PsKJZZN0d53jK/0flU1cQ0Ep2FvTb7n+Nld9XLdXh4YgOCkaTFz++7edk/MSq+ZGc
	 LZ4lT1H16vSWVIpKwZk8hlhx8R1rcvCCDNk2+ppxk50O0xJS3RtBF86k7MhjJhHNkYSbr
	 jzDBGIS6qdr4m/7Ih0TGAjR71D6N4XQm6Vu0kNs379Sx4UCP/eE01EbGzdqSSrpnkKQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ffAhc9Cb;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=iPA8qK12;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F050606A327;
	Tue, 24 Nov 2026 11:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F050606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ffAhc9Cb;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=iPA8qK12
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAvMm3592354;
	Tue, 24 Nov 2026 06:20:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=l7Prh5Cg/8w7dgmLbdnWlhSzPDdTFV5MVBX3KzHqT2M=; b=ffAhc9C
	bD71D9FCdMu0EZGa/aS35I+ElkrOYace5y4FsKw5ZAyA9LhATh1aQgksZusTr0Pi
	w6dYXVasMwtL5YHss+b/FiALkq1bnrBt/tWFi7bLANcVAQ/b4G51oNdC0lLZArfE
	d97I1aqcIG+H5SUqPnVgcnv45nB0ohMrc6CtCyE9tYka85GXfnMfEay8ibSPTG8Q
	AMq5qtd17Ua9nhjGYFyNc30Cr9iwUDi5rSznH6T8hRvjedl1ItLv1DIC76TbiR60
	BzOARzxKcuM2jB7nLwvaprl4lpr4tnG79AoDcdFlfGFBhQIB8Jxt+4J3F6AHORa9
	/VF8uKXDnUvfMkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=l7Prh
	5Cg/8w7dgmLbdnWlhSzPDdTFV5MVBX3KzHqT2M=; b=iPA8qK12FTyAx2PGBQWXA
	76hLwFWRXvPksphegTuN0kpa5nIBqxVUpe3dYo3Midd87cY/0Opq019uCCFfQb7K
	HiN5ZDexRtzz4FH56C5M3sPTorUrRk2XgY4mQC6FMVuCTm3Viqs8Fm0oMZSNfK2z
	u1s15A0nqBn2trRSO1bXPywhmUrz9F+a7tLeNQHRr/9D+09GKSviJKvB8NkU2dg5
	oJcv5EcSRVFCprJX3UOE4EtlJEYE9J3ZsLbb/Km4vtEZDBj0E5SVvNPrkIMMYiZC
	THcd1S8jY7p6ai5bfp0mB5aHzqXt7Ye19g+NPVcgg4OUuXmlJGPpnuoUKCSW7fTW
	A==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010031.outbound.protection.outlook.com [52.101.201.31])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j574h0rce-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:20:41 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sM4p0dLTWxHNI/7vSRca7LK2C1hB282ChilcV4+i75vLOjUGGEmk1Px3g4RrNiiHNH6dcqwpI0Bl2WBLV0CMDMvGTPIe5E/HZ5dsJjiBG1e8HSLeLeP7YtSj/n9TRhoKtHrL3z5ZiOoZP75dMHX5zvOYSyODINepLt/cSJC/MqkMVmiI8NyHmUPjIL31qmkmj1eLGKGwa17PNbzQVVdP4Srs+/jMxBSV6sD6krAXds5H9TITJfn1lkL+hfF3hmUqafHkKxmB3TCmEU0LhWtr/OG5puepxUsfL53ee/IGhcplLvVOgnmmrRSuveZ4wI47g10ihQJ2xBwvgNFCqKX7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l7Prh5Cg/8w7dgmLbdnWlhSzPDdTFV5MVBX3KzHqT2M=;
 b=WkpzJQqkJEHiXThtWvGafbLu1+LwfyXHacJCHFFCYO0zekRPhMHsT4EOVlOu/aoNrmmEKHutYtlwEMpNO74qzs0mxNRqQ/ORzQ4f4H1VEmNOXHyxEcl708imBsvZAJNg7SJ8q5+FFfYEi/741wa5HYP6y/gO30fX661wFfMizwC2S+dzcYoC4Q7EEtj42infqgwE09rMtBPLVInqHz6c3zpFX+oC/GblyyCK9qSlRxWFcAUvtUxVId8zjnaTpUeTLofeBrOrzRheH2HgghbhU7tgqwYSiQEM2DGhRRC6XtAl/PoHullIMVAiyBO/hheIixlluqNVDZiMv1aYWHfqEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5545.namprd03.prod.outlook.com (2603:10b6:806:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 11:20:37 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 11:20:37 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Tue, 24 Nov 2026 11:19:48 +0000
Subject: [PATCH v7 8/9] spi: dw: Use dma_slave_caps bus width helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-dmaengine-support-wider-dma-masks-v7-8-5d57df2c3ebd@analog.com>
References: <20261124-dmaengine-support-wider-dma-masks-v7-0-5d57df2c3ebd@analog.com>
In-Reply-To: <20261124-dmaengine-support-wider-dma-masks-v7-0-5d57df2c3ebd@analog.com>
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
        Frank Li <Frank.Li@nxp.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795519198; l=3254;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=pSFbB9Q63qhcEtL8d8CS8WtAh/mXEa4IyY/WM5X2Pk8=;
 b=mc8tOFIer0WrOZbOGEdRIrLqxwK9qwFMcwm+asd8+oApdOWSZZK5mituoC5ZQqHfcUi9mLAvr
 l3Gbwl2Irc0C2deNYBLNdOWs2ja4XicJxLvgWmDOerSVX2rxEbmrAvb
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA4P292CA0015.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:2d::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA0PR03MB5545:EE_
X-MS-Office365-Filtering-Correlation-Id: ad2678ee-e76e-47f5-4325-08df4a1cf70b
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|11063799006|10067099003|261009223027099003|56012099006|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 voZmVc7K4Lg/ccKHs5v96YvTbUMxfpGhwk+8Yaaq2ZGt5dlcXlvCHwFGJcA+35voWrVKIS0kbKOhUDtzj149i4du/oY5Z3e4BDsr86Vmo7tpKezeraCSGzhIHWH6H+TdAWnlbpKiOXMWwfEUsi311AA8FK8xIvqINVP+H/oAR8O9cYyfLaYybvg++70p2uynXGpZJY0Wjbuy9NSwrLKayX8Rwlg+aIk8G7t+C+zRfEEFVL8GYLbGKcfjs5ykcM1aVVkuvJ4zUBQxLM4l2isHdhBSCqdEIOKR2ZZEREEcPedp0ns02EOshPmI07o1sDZgCdN906KaX69vhpke88Q5eUNlHPl8Ajmm9pjVyUgfsPqBd5tpY8sbzWAzRkIF9iYx7WjP6KANRNY1FJU0SkwjGhg6dtBNBlbw2pGYjMYRKC3FoPIBzj9fTpWH1HaVny/FpzdKxDDQro7fZPeRTRXh3ahkidTdQ6P9XjWi1h3fMuUck7vBoUJnecYLUW6B8bRHgBXitw2XvN1f0+zzRz7CQG0VFy00L5nYjJUDGPnpYjHm8jS4pNxFPhNCbZGLoC6dgi8xP7kjSCXM0QXU5L3FmLhsKvgj7Lk74UZ8IDghnSSKAFLCMHABHlDO0ALqE6l1XpetUmfLuacUI32b7h0EqYex6Db+BSrNaexcm4VKgPs=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(11063799006)(10067099003)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?OHJGaHRHZXpBZ09aSlY4QVNpZmpTRXhka2pQZWJsQXpOb1pVQmpKVExUZ01D?=
 =?utf-8?B?NkFacDN1c1ExR2JrR1hUZzhDRGh3S2dzN1RDdmJkVVNwOU5FRVpwRnpxT1BH?=
 =?utf-8?B?VG5iTGJXRmQ5WlF3VHh4S3NPSE1veTJHdnRGRHNHTzg2TitzU2pIVWxzRGkz?=
 =?utf-8?B?WkJFcVNEOWsvamdKbHBTc28veHd1QlJuNEhSaTNDcldtNDQyK3R0VkFQbW9u?=
 =?utf-8?B?TDNvK0dQbkQrOFZwOEc1dGFVZWpwZUpzN0thTTNVSmdCMkIvbllnZlh0ZG9M?=
 =?utf-8?B?K2o1NE52WDhKSTJCcjh0K2RsK3YrbkFpdGw1NEpxanA3cE5GNnJ4TG1VNmF2?=
 =?utf-8?B?WGZ4WllFOUVwb0hmbUw4T2RySHVnMGVhUDZsaGMwMkJ5M1RDS2dkL3puenMz?=
 =?utf-8?B?QnZMaHh4RXZFMlZISVFpR1BvQnFmTmFIbGFtRkxrajRQMWl6UnNBL2JhMk55?=
 =?utf-8?B?K2xLUDR2WFlDRHJkL3M3RTZqS0RzOFlXeUlieXc3WVNPUjRGZk5WbTR0c05F?=
 =?utf-8?B?OCtyaklLOWlKeGtOVzBYUmJ3SGVYMkgxVHpVUGFiQWpRODdhSWtjQjcya3pz?=
 =?utf-8?B?b1pmc0UvL0tETURUNGhJTHUvY0dodmNhT3I3Z2Q4MmF4MnpxTlp3VFBQSUE0?=
 =?utf-8?B?aVU2czJNSWZ2Mk5WNjRHbHlGSFR3TnhXVnpHZ0tCZ0dWc21HZm94T0pwY1Yw?=
 =?utf-8?B?Ym1xOURtbXRTNTVuQzRyaGUwa2NkQ2RkOS96b2dPRHVUVnBwMXdRVUhxS0ZR?=
 =?utf-8?B?SXppckx4aW5qR3lPcWxzWllXUGJiY2MxWmd4RElaTER6OXREdUNNV2VlVTZa?=
 =?utf-8?B?aHdjbXB2SmYzakpGcldtdFZzMy9ZZ2k2MFFqajRrSXZJMCsvU0p3eTNsMXlH?=
 =?utf-8?B?eDJlMk0xU05oNWhVdHpRaDhVNFlqL0FjQ2RwalJ3SUlzQjN3Vno1aTJETXBr?=
 =?utf-8?B?UE5CSE1GbkdITWwwRHgrcFFSNW9HeGZwMHdNOGpxM0ZqWTFnOURHeGpraEZn?=
 =?utf-8?B?TDJUK0tjdW5hZlRDY20zWVBEMDU0TmlneWJtMzh2Y2RVSXFYL21yTmZtUGNx?=
 =?utf-8?B?bWFoMXJmL2w5UW90WllrbWhwWWxRY1g3Mk90NDU0c0JPWnZjT0ZsazJHbUov?=
 =?utf-8?B?NHdtMzBmTjRwUnBRdnFmS3Z2L2Z1VGdhQmhiZ2pwZnpWWmJHdnA0VkxCa3Vy?=
 =?utf-8?B?V1pYQUZPV0Q4Tmdjb1VRM3BCRk85eDZHZ2M3a2cyaVNUcXVCOUV4SHdxUzVs?=
 =?utf-8?B?WHE1VnRCUFhWVjBXMG1sbWU5UDI3UE9vWHRQVng3ZWk5Z3lOc1hsRVFUYndX?=
 =?utf-8?B?NEx4OWpHamdiSlpLRUxoUURGMGZVRmpzMzFJbWdFOHZZZStmUVY4SEFySm1T?=
 =?utf-8?B?NlFoMXd4VjZyakRTckRQZEFLMjFCTjdTRlJieW9CSkorUU0wZjNJZVJxT01r?=
 =?utf-8?B?QVM3dks2c1JXdzhINXZQVXU2MEkrcThoSUNYUkMvcUFVTjRRMkllaFNyV2xy?=
 =?utf-8?B?RWY0UG56VFNiYTJNSkpVKzJxSmoxYnhSa045akZmRUJkTEh6aHJjZXJPdVFJ?=
 =?utf-8?B?ZDdGSTJWdXVvRDZaZWRHbURKcVZoUEMrYmNnbjg2VFYzc3E2QmcvWXRjYS9l?=
 =?utf-8?B?OXRkQXdYODdMTWFoeDZMeExkN0x4NVA5UGdkYTFoRGw1Tjd1eUcvMnFpYWZK?=
 =?utf-8?B?RWhvckFXazNVSHVEODBRSVRPUXBkOWNPRG5neGlrbzlpeVlmeGpjRGtSU3RI?=
 =?utf-8?B?anRjY1hqZkdIWFJjbHBEZjUzaFRhQUlnQUI4bDBaTkJmV1lNeEovWTdHRW12?=
 =?utf-8?B?bkdvcE5nZm44WDhhRjc0SkNDSmRQTXV4djNKZ2x0WDdzdGgzM1NXZ085cHVZ?=
 =?utf-8?B?Y1ZvZW83SmZUdi96MmNRRit4bTE2VkdYV2RQNUtEdmRKUGxrUHZiUmVQTFZS?=
 =?utf-8?B?b05LYUhCc1lSMHdTOHFtS1pvb1VWdVk5K1RaaThJeFpNb2t6U2d6cU1VQmNn?=
 =?utf-8?B?NkFsSFlLK3FrUndoMEVJQ2JmdWF2RzR1K1lMWWFuZ2pVKzBUVm1tSzAwczhI?=
 =?utf-8?B?dTEvaDJwbVRCSXJybGYyYngvSTl1RXRJdEdqYnc1T0o1dEp1SFVTbUdDd3Mw?=
 =?utf-8?B?eXIwSlZxTzN5SkN2UGtPMXBaRHBuaDFoRkdGNktGZDF2MGd5a3g2NGs4Qitz?=
 =?utf-8?B?a09KWnpNa0g5OHkzc05NSVJIdmtMemxDNVRzS0NMS3hGdk4yRnIxbVg3MGFR?=
 =?utf-8?B?T2dXUkpZZFhGdUxFenMvcmlrbDhQRm5xK0tmcXNEL3E0WERUbG16NlhFeU1n?=
 =?utf-8?B?c01jWWJ1c3U0eS9HdEwxdXB6TXV0THNqMTAwd2FxdmFxd3BVaXNaUT09?=
X-Exchange-RoutingPolicyChecked:
	OxXomh/xGCzY+cYrbQPxfqblZN/P2z6fuB3L5BjmMKpj4DoS+olehlfb4qCjf89VO8gIdaODFNj9ZSP95eNE7/LHHEX6qMhDC3ExUjYkxIvCpNt1ZVi8Ryt77NA/n5mDez1F/OguJxtfgsJbgRz7zOH5aW3jK5DKR2duVS3kbGXDJut1/tIeyDmuPscS0GH4Y/jJOf+bA2P/REIMyDv3rWvSxKcwlIMIN8xiWGRPl0H7dyJ1GYNdMWSxvtQ9vMMS9fBAdiJmuuaYaasr685gwnZ1ZHIF6uN9di+5MMKV0yF/mhRnVAlROVLDruLB9a5SuJGyOlcn4dA8b7654NXW9Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad2678ee-e76e-47f5-4325-08df4a1cf70b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:20:37.5366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Otcb8aJbklijpLDsaW3pQGhQ2731CO1MhUbSgeGuRtgr7xrxlWoNN/2TNwjK3L/Cg+pRbCf2bqjF7oEKwaIerg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5545
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX/YUH4ell4jq7
 lubwp3ivQWJyGsz1EXNC7BpEnd4y1LZwHdt0sDm9114LHFtARG1Z67GOz/mCLIh7nRgSfu9HL83
 Qr6Ep95rggC4Cd7U3ZBI1A8ZKy9sjXzcsNJ7qDBbCEsWT4eK2J3bP/nEBoe2yZmbg7Y1/a0+jjH
 D50JPVoj+cZ4R2Ihnie2RFdnMxbtiQ24Q+G2QCJ+hYlBv24lQMMl9+k/BOal3tA0DCp+5g7OoKO
 9uCA2H9DeNE6ohJ2vR+E0GyFSsAx2Q1j3EmlH+GedBhf3dbwJ/SHrBTRyMn4ZPSO/VecRMmlnnK
 qNj8YSuzl98SxjK+9YQP9P15WPgO/JRneU7V2Wdn/RkJp3dmLPnV9Sx/4EUGS0NbdYPGaUvQ6CY
 4u1oCW1U444QY9VWkkZ2HSAkAVpMcBQU9erHa5qlmOomsrxYYFDs7U6tb7RGvEoIlaJ9k/w/bn4
 8amC/SRxgLFLj/N/laQ==
X-Authority-Analysis: v=2.4 cv=Yt+a1IYX c=1 sm=1 tr=0 ts=6b057309 cx=c_pps
 a=FTqHLmxhk7TnHmysD/QBZQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=8AirrxEcAAAA:8 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=tW7m8UHSMEukmECeRAcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: Vm3vb9XLub9V6ibKyB7NDUPK3b5r7RHd
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfXwzPOsvDVaPVv
 NA/QUqgOLLkSV7S/b+PV2T2HYbmDx8WN+/bN+EJumQsjyKM2htKlCSJk3VFahUHUosOYKnKyxzw
 GDOILzFC995D/G3IKt639R4RA+m8KTLUAG+lLvFivicsx4sJcEBc
X-Proofpoint-ORIG-GUID: Vm3vb9XLub9V6ibKyB7NDUPK3b5r7RHd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240044

Store the common TX destination and RX source bus widths in a
driver-owned DMA bus width bitmap and populate it through the
dma_slave_caps helper.

This avoids depending on the legacy src_addr_widths and dst_addr_widths
masks returned by dma_get_slave_caps().

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Mark Brown <broonie@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/spi/spi-dw-dma.c | 13 +++++++------
 drivers/spi/spi-dw.h     |  3 ++-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/spi/spi-dw-dma.c b/drivers/spi/spi-dw-dma.c
index b706770334a6..f151dac59174 100644
--- a/drivers/spi/spi-dw-dma.c
+++ b/drivers/spi/spi-dw-dma.c
@@ -103,13 +103,13 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
 	/* With a single channel only one direction is available at a time */
 	if (!dws->rxchan) {
 		dws->dma_sg_burst = tx.max_sg_burst;
-		dws->dma_addr_widths = tx.dst_addr_widths;
+		dmaengine_bus_width_copy(&dws->dma_bus_widths, &tx.dst_bus_widths);
 		return 0;
 	}
 
 	if (!dws->txchan) {
 		dws->dma_sg_burst = rx.max_sg_burst;
-		dws->dma_addr_widths = rx.src_addr_widths;
+		dmaengine_bus_width_copy(&dws->dma_bus_widths, &rx.src_bus_widths);
 		return 0;
 	}
 
@@ -124,10 +124,11 @@ static int dw_spi_dma_caps_init(struct dw_spi *dws)
 
 	/*
 	 * Assuming both channels belong to the same DMA controller hence the
-	 * peripheral side address width capabilities most likely would be
+	 * peripheral side bus width capabilities most likely would be
 	 * the same.
 	 */
-	dws->dma_addr_widths = tx.dst_addr_widths & rx.src_addr_widths;
+	dmaengine_bus_width_and(&dws->dma_bus_widths, &tx.dst_bus_widths,
+				&rx.src_bus_widths);
 
 	return 0;
 }
@@ -292,7 +293,7 @@ static bool dw_spi_can_dma(struct spi_controller *ctlr,
 
 	dma_bus_width = dw_spi_dma_convert_width(n_bytes);
 
-	return dws->dma_addr_widths & BIT(dma_bus_width);
+	return dmaengine_bus_width_test(&dws->dma_bus_widths, dma_bus_width);
 }
 
 static int dw_spi_dma_wait(struct dw_spi *dws, unsigned int len, u32 speed)
@@ -845,7 +846,7 @@ static bool dw_spi_enh_mem_can_dma(struct spi_controller *ctlr)
 
 	dma_bus_width = dw_spi_dma_convert_width(dws->n_bytes);
 
-	return dws->dma_addr_widths & BIT(dma_bus_width);
+	return dmaengine_bus_width_test(&dws->dma_bus_widths, dma_bus_width);
 }
 
 static int dw_spi_enh_mem_dma_transfer(struct spi_mem *mem, const struct spi_mem_op *op)
diff --git a/drivers/spi/spi-dw.h b/drivers/spi/spi-dw.h
index c16225c5c887..ecbcca50026e 100644
--- a/drivers/spi/spi-dw.h
+++ b/drivers/spi/spi-dw.h
@@ -5,6 +5,7 @@
 #include <linux/bits.h>
 #include <linux/completion.h>
 #include <linux/debugfs.h>
+#include <linux/dmaengine.h>
 #include <linux/irqreturn.h>
 #include <linux/io.h>
 #include <linux/scatterlist.h>
@@ -220,7 +221,7 @@ struct dw_spi {
 	unsigned int		dma_nr_chans;
 	bool			tx_dir;
 	u32			dma_sg_burst;
-	u32			dma_addr_widths;
+	dma_buswidth_mask_t	dma_bus_widths;
 	unsigned long		dma_chan_busy;
 	dma_addr_t		dma_addr; /* phy address of the Data register */
 	const struct dw_spi_dma_ops *dma_ops;

-- 
2.56.0

