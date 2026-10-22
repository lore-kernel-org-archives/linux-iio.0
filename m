Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792665077;
	b=AwRcRr0yadN8hyTp2V8XDeG40DyKZe6hVHxldsjcoYNeGU6o9pPyyaja6uqETxk2E9xa
	 dMeVap1vyybfqIy9dAugKL8g83SQUXxxXGE+6DunFvHLWWy1bUs3e4BSvHbxVwRFOQj39
	 QR9Fg8Zt1//vyvZjxk6cE8rmpAi8giCuPndktcBHFzRWYAIrf3a/zWfzYzMnI6RJzAiWp
	 Az/abutwkplf1ts9VkE8xd1fXE2zLgv1QYaT0XzJdlxRIejUVbrGDp0BhbuXadoJXOikC
	 AEaERQLNbnpJaSJPH6psTgeNzlw9AVbluLyvo7tp8MR2lzXUsPtgMh4bF1ifP42m57A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665077;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Content-Type:Content-Transfer-Encoding:Subject:From:
	 To:Cc:In-Reply-To:References:Date:Message-Id:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
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
	 X-Proofpoint-Spam-Info:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=S1muzaxcayNwPyh1v8QLSK8TBo6ZHG80bx2/U7PSVQs=;
	b=0spvmyc6fGD1n5sG9E9+vhN5kf9DKbKwOoF3jSSfW8WPB3/qCMoE74ZQUuvnYceP6jEv
	 UmuigCB3o/P1OFCd2Gd/btkjRv5K3ZA/wxovxsig41WuRI4XXOCPlhsryI0h0QBYjzGQh
	 8oOdGjIuOvDwbsX2wMBUJIo5fJu4IImZA0gr1sYf5+yt2cYIZGlFEXavOJQgs/sPVQLek
	 bpPyBgaFat7EM7kHuOAY7R/PVaetiBAaUFPXS/c3R2tJxAK3TPedcQQ2Kk5e64Ui/Ua/3
	 YXJ2MSoYYdc6RSGUs0hvFndp0WSNBvxRIwE+KyLxCjTZRUdchqAbOo/SERlH02DPFeg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=E6izzJnr;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=HGlljSep;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BC8606A319;
	Thu, 22 Oct 2026 10:31:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47BC8606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=E6izzJnr;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=HGlljSep
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MA1rQK1591205;
	Thu, 22 Oct 2026 06:31:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=S1muzaxcayNwPyh1v8QLSK8TBo6ZHG80bx2/U7PSVQs=; b=E6izzJn
	rDHLnXfzcFC8M9/ZTyoMpPKWlYqB+ew4gpEmXDGMPucEhosuUu6IbacikH0FXNmG
	wXu66jr5puGs5+PtP8iTVtRbmzCcOhTWu0kjm1c7JRUBuQyosQXMX90E0Gscv/GP
	3a3N7kWtz+97nqKhTprDDDXXslCGr0fSJx4+YaAFaoCm7LpA6KH4pqLs7F1krpga
	p1E6Y1uTFk3sDAS5QzMAv4/kAxOyP9aKT0HdgY1kxH3snGZkI/ZnXREeBxI4ERT2
	Rt6Ctp5YZlv/8iGFCobDkcabUYxuUdMru/YW7wQReQkTKDkdHqfKVHNcb91DSHtq
	g2LSO/tmX42qCiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=S1muz
	axcayNwPyh1v8QLSK8TBo6ZHG80bx2/U7PSVQs=; b=HGlljSep/dKoYs7SfXIwC
	UfGEXwdsN6jjohoWsqtMlpfHW+3T2PJShSkXTNSuXcQFhgByu0Cd8RiGN0+q2kmp
	snYiha6MmKnQYVl3e6UPUeuioS3cSkLDfAgp6j3q/geoqGCSXGDAJ3d6/h92mC49
	/FbN7AGNZ9nbXmOL6P6pXj9+DzHEHQRUgmUwufyfIYsQDVvZ/L2Kzex0SsJ04vVi
	jSUPu/z7I+CR0YA02vRrOFgg74092tSnj1csTTdyM21MYB5alaSmAjwzbl9zk1tL
	SBxzJYkgqrhg+n5iaBqbjqcUhfY7GLMy1j6blh4uFLWGSc/ckgUkmpXeCXpU3DTU
	A==
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010063.outbound.protection.outlook.com [52.101.85.63])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hf927tg98-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 06:31:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzdAWs1aWFwJ6Jy/xge5+MczNBIJ1TUKqAW1EUBdQTUDnTm9+Je8OBOU0UDjcIhlt55IdkUcKCxCbEJkohHsNkVxIlwg5uosPyi9SSSHzS6LWdyU94v+yuLJu9qm03pw2vJznwUkCaQb0vqbsbrpYqxdgWH1B7y9USk2uIUt7E1I86SyiK+Juaap2TpvuBsp41WpNAza8Em8iah6a7+kj3PWZu/WikdOZ3DuVMPTGKcn0AWwJMEbCW2aoKHTMpJYcr1tR5Vfe9vTVpTVM4TCgPzjyBLFhLUweKZ5wIGzPVef6p0AgPW+KOHi51Ito8JFhzbioqwl3th1fDkO9Hmozw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1muzaxcayNwPyh1v8QLSK8TBo6ZHG80bx2/U7PSVQs=;
 b=yfm8DosPDz2YUP2HcZD57FTDbw3ujfMnTEJTsKqBMUOz1yXMolXNlFQxvbjaWyjP+pg5sMgGu80b8EXUpFW9H8hKb6oi93u/ANLSRqdhEdLJD6baStyma0nQ6q/w6pbxBfkOBR6tQO9NSsnhZzoX3rRu4i+ojgwxp0cWiDva3Ry1VgY+4z2qtB9Qovfi4eNU9b0vBJEzT6mYcGAW/ry/nJxDiKiBpW5AIJSTb8pOpareBM9HmnRw/TMSfypJysIzJjMAjml3h0RuEjS/UZRJ1Z0/wLlHA7mo4lPoUwHjgTYOEKhDjusgk2mXFwdn7fQeWVBidFVTdsFFR67kS2ODIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from DS7PR03MB5464.namprd03.prod.outlook.com (2603:10b6:5:2cf::12)
 by CH3PR03MB7484.namprd03.prod.outlook.com (2603:10b6:610:19c::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Thu, 22 Oct
 2026 10:31:08 +0000
Received: from DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e]) by DS7PR03MB5464.namprd03.prod.outlook.com
 ([fe80::61a6:72a5:5a14:4e4e%5]) with mapi id 15.21.0522.016; Thu, 22 Oct 2026
 10:31:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: adc: lltc,ltc2497: add
 LTC2493 support
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>,
        Joshua Crofts <joshua.crofts1@gmail.com>, linux@analog.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
In-Reply-To: <20261022-submission-ltc2493-support-v1-v2-1-391d908d2877@analog.com>
References: <20261022-submission-ltc2493-support-v1-v2-0-391d908d2877@analog.com>
 <20261022-submission-ltc2493-support-v1-v2-1-391d908d2877@analog.com>
Date: Thu, 22 Oct 2026 11:32:19 +0100
Message-Id: <179266513948.3528.5327420779246894312.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792665141; l=425;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=q+sUsaYhMm8Md+tG6/qMaIaOSuRZWv07JfCGDDPy1vs=;
 b=7kwyJf7/B/zjBPR8lqAzBPQmOa9TuyX2BA9MiaAGDMBbrZOi860lY8+px5rIUPrKK+vSpwTN6
 tSZzBtx3DgrBQmXdlazyNyQK3FPZbrHa+A5gkRIvMvfmN+vZgyW96Og
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA2P292CA0018.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::8)
 To DS7PR03MB5464.namprd03.prod.outlook.com (2603:10b6:5:2cf::12)
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
X-MS-TrafficTypeDiagnostic: DS7PR03MB5464:EE_|CH3PR03MB7484:EE_
X-MS-Office365-Filtering-Correlation-Id: 16de8dfd-0638-4524-b13b-08df30279533
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|7416014|366016|376014|1800799024|18002099003|22082099003|261021123027099003|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
 UD97N4kEdB877oTCeflqaGy471gLnmD0Ps5OmcJsAGD535IWwLNVfT2mEdxL9y0KeicPzZhSuM1aZaF630XYKR6U3ZEmOptLXtfm89X1iX8NUz3CkX00GX9CEdBl4Anq3gsuG0kKQyyggY0zVAuEa44E0YHVKfyvH5jlt/Oa66TxwJs56XhUsKx9aS7GEg5LlUxEquvoGh8brDN/XnQBJOVT2vH6sUZD9BiQSFKasiv5Z+WqLubxAmeSKaCnqkIr5Fr54YtiCNmWCYc9K+hfT0W6baZODKBZLkD1BO7YE0yB7KB6LGudMNiYj6oESBf3xoMsasJsdO6jcxJrPhDRGy08TVun/zbVXyf/pSi8eueJyJWeMY2n2ltHhE0ypSzBX0173vzBe0mG4TwcZALBr/dO2CzhP6Pom5r6iESeNnWa0qTelmOznHOSB334c1sPmmVbyifFndgU3HKoSTa5NmCCda7bLAuOnMChyjwF4iKC1XeIPoGS42AErAgKL2VxcRCgqke/0kCImvQltlD85RCpZTmVquAeaw2IgozszBH2IIHE67rhdXMTs2awOVikW0AIG/yEamdJe4r2vfyHb2MUHhp3X9am/m8942sC40S98Xl8lEfcLmRso7kKpMHe8xdtPL2yinC/gHxwFASvGGG5UsGFBpTUIyCP1hTvW5o=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR03MB5464.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(366016)(376014)(1800799024)(18002099003)(22082099003)(261021123027099003)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?bEw2Zkx0a2dwNVdMZUFDbVhoak92SjBzL3J5TWlUY0Nub0pyTzU5NFZKaGw3?=
 =?utf-8?B?THE2eWhzZmFudVdUbHpCeFJIa3o2RnQ3a2s2N29MT0lzV0JwdnEralF6TnZy?=
 =?utf-8?B?aE1Cc2hKQTdiNFZOdVZEZnZPQTllMm4rWXhyRXArekFycW0wRUdMVHRJMHBz?=
 =?utf-8?B?V2MyR1NVbHhuTVBZVEtmRHBsVXFsZThMM3JqK0tEejJtbXJCRWxXWmtmMmVS?=
 =?utf-8?B?OFJINnVLVVoxWHVZMDkrRlBNRzN1MUpONG1lRllLL3ZXUkI5eVc0N2FrWWNj?=
 =?utf-8?B?Ti9KdFBXY0U3WS9RT0h2aGg0b2ZDUHpFaEVRSWFzWG9iQkpBUU9mRlVxMEJK?=
 =?utf-8?B?ZnFjdllEb01JSkRnNjFPbWpZOXl0MzZzcHRwZEdDaDNEbi81L09xM0I1dXFV?=
 =?utf-8?B?RFNFQmJWQlJOcXBVV2RZYzdJdGJYdmpSU3BuQndDV1ZyUW4rd000bW5ETEN2?=
 =?utf-8?B?QmF6OVEvT3ZKSHNld1crK3puMHhhYXQxaFgyK0tHN1VRSi9zeHQ3K2hQYWNE?=
 =?utf-8?B?Ym1VUHhXSWdDU0cyNndEUktERktKU2hIRnB6bHo4c3FUVjlkWStUSHhqSDh0?=
 =?utf-8?B?RGwxWG9waUV5cUVCajVkM3dPbWtTUnp6WDRIdEpSS3FJRk5mclFmZW1FaXpY?=
 =?utf-8?B?SEVWalkvSHc3eElreXphdDR2YjBwa3FqM2pnd1o0SUxHU0NkUVlNYVpRVVpr?=
 =?utf-8?B?bFQ1UzByLzNYUmxWVWQvUWxNd2RXL0ZVWDdLTmpRT1Q5c0hvWVY1NkpzRTB1?=
 =?utf-8?B?b3ZFb1lnbTNlRW9hSnZrQ1drWEIvcHozQ1AyZWtHenIrWWIxL0JxbkVKcFFs?=
 =?utf-8?B?TGpjTU9MVjZyUE8vNmgyUzYwYzVvZmZDQ2J6TzhQenB5Y01Ub3MwNWthK1Qx?=
 =?utf-8?B?a003Rklhelp6R2krdlR2cm5qS1E2MERXSHFpSGlsZWtUZlE2dFBhNjJJcGFY?=
 =?utf-8?B?d0ZzYUVCK3N2bkd0dTJYc3VsN2phWFJNckluZnFZNEpONU90cmxycUNhYlJN?=
 =?utf-8?B?TUdJcUZRWjdBYmJuV0EyU0pZY3Rud2N6TG91SVRLeUxHWHJNYVpFdVVjMW12?=
 =?utf-8?B?M1RTQkQ2bEdud1BTQXZoMFhWRUJwc0tiUU5qVUFqeEl0cWg4ZGZaajl5TXNp?=
 =?utf-8?B?UnVjbi9yMUtTM1h1M0VTcTdIVkowei9SYk5OUTFkRWk2ckgweGZ0NUhHRjVu?=
 =?utf-8?B?Zmk3WThXa3RQL2NsaGVtaXNneTlDU0ZJUmE1UnhOYThvajVOUitMemxGZkVq?=
 =?utf-8?B?dmdZODNyb2ZtTHBqanlUYWszeEpxVGk1M01ZQW91NU5IOWU4UmhraFdTZEQ1?=
 =?utf-8?B?c0ZxWG1LSmNESDhZOTQ5RHFiTGFpQkFwSENPaGVRU2FiSUo0cTE5bkJqVHEz?=
 =?utf-8?B?TjdqRzNENFArN1U1NitNMjVBbWlkRlR6NGR6MnJqSUNOUFliRU50S0tTOWNx?=
 =?utf-8?B?bjVMZ09UOUVsTE5tK091R3hmbC9MSWZGaHIvemgramJYVW9Odkd1L0RHNHlw?=
 =?utf-8?B?MUgyd01vUjk3c2NOQUFZbXlON0pzQzdUa1VZWEtrUVZlK0xyZjFCcU9tdjM0?=
 =?utf-8?B?UkNGQXdKeUxWWXMxV1R3SUFBUmlUV3dXUy9IYVFIa0hxMWxjSUd6S1p1Y1ZO?=
 =?utf-8?B?QkJoZEhuRGtreklDL0xNMWYxUWlmMTYxOVRWVktiNGxkcUt5YU5jdmZoRHMr?=
 =?utf-8?B?bndkVUdZODdtV3MvbFZoVzdKeDN1RW90TTFCUm5mTUloWlRvWkRycDFZaHNz?=
 =?utf-8?B?cmw3MXlpTWNrdEV6MUxFR2JGZFNGSDd3UHpIOHAxQmF3UUJBQkR4MnNpdTVx?=
 =?utf-8?B?MVhWalJEZE5nbC93MlFVVGcwOU9BSDhpaWhZc0lvaG9IdTllVkZWVU9GZmUz?=
 =?utf-8?B?STQ4QTlXRDlSRVVKcFRmUjRnVWhYUzZaU3cxRmJVdXhpbzUxVmVCQjYyUk1P?=
 =?utf-8?B?QTV2cFRnWm5sUzkwNUN1RnFSZVExN2wrTjY1WmpBc3FjUTA5Y2FIWTJXdEpr?=
 =?utf-8?B?TTF4aUlaWlJvZnUwdU1XcXQ1VGlqVnJ3RWNJMVFvL0hjYkdTR0JXTnNLMUVX?=
 =?utf-8?B?TDBCbjA1NkszQ1QvdGxtemNHdHdvOWdEa3lNVzlFUk5iWEhyREx0Q1JyT0ZP?=
 =?utf-8?B?M0NnUmRwVGtCOWdxakh0QXBhUlhybU9ZUmdybjNnTFVJOTRpNFRqSmV1bDVH?=
 =?utf-8?B?KzZ5WVpQRkZmWTh3Q094UGlEQ1FsMENEbDJqYk0reVc0TzllN2REVk9DRVhC?=
 =?utf-8?B?S05XZ0p2eWZzaG5ZMExKUW9MaFdHRUpvSXhhbmc0anBYQ3oxUnpsVXdXTFNu?=
 =?utf-8?B?R0gyby9hUzI3SWQ1bG1kOXg1Y2hFNXcvYXA2L1hGQjlPU1I5dlJqZz09?=
X-Exchange-RoutingPolicyChecked:
	Nxw9pKGihSF9Pu3ymTPMw2E0PjU9GwpDY3HNL0l+1ppe4cJj84bpE9xo0jfEC8XlSuwjI361Eoht8ifu++XD0BolURioisLw6apZWBdbIExsrcypGtkQskp0EI/JunGU8vie9K6OgeigiFl3/kjkCgY2eyB4M2PKmJVaTqq2zUNhQehVjvr/qvqeX9gjesiXBF0f6Nd/7ejXvrJAEsayD4h97rjlwdXJq8OHrgfmstH15e5YHMdf7yuMaTPDTrHM8RkFU3eRD6D0q/CNtlm0VPhxvsReqVOMQMQVf+Q2/DFpWKQhKqi1SVI39YI36arm6QGh01ZO56VBSqqT9dhCzQ==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16de8dfd-0638-4524-b13b-08df30279533
X-MS-Exchange-CrossTenant-AuthSource: DS7PR03MB5464.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 10:31:07.8395
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4pcEvnvRtuaHQypqGSC6nUbKgUBE4yJ5wq3J4/Az8AN3ujezuvw5ONkX9M0Xg9yFdio1RTyO/XbKkVS5+6n6ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR03MB7484
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfX4zbpqfw/en2p
 BdtwuNgtnDsagmDJ/ntsmIoM/FvdVrNbmmdf3e4mZ65V5rIE2y4ZDfY8J/vt8UiVhzfBgJZ1qIQ
 UPX7YGxOdTrQlRXM3sNdHFVpezGPkjyUgbkbYvDXVXQDHKe6UtDG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0MSBTYWx0ZWRfX7XOK4GNr7LjP
 cexi+TvLF+iT8SIv4vOFQfEPQoRmqnkmrszBjcUPTbK684VfL0yzz2PH87q6pDRrD4j9OYQlOW8
 UlW54YZvfU5VKjkIgb8q22fyRu5100rcggoWjLanMPtRgPgHLhPcT3npg9lBxKOSPQXmQ5ZmKMS
 AAfW4Yepu9gdPn0SgnIksGmP/DrcGLDDOfu8CHCRpLejBH3PJb23+/RYXlWrCqZpk50T5XAyQz+
 9/HlpOnijBwYuOSmZhzM++YAxPmVTH1RgkrT7nh8ia0kMIreh7U0xD6vcd3vpssohLcta7iIX2s
 oPWNEXjx1XD+qFh0/w3FL6yrVQ0zXSLbiBchfljKKJfPAajQq+TYpnl1yO+WucbJ+s8iBb7upE/
 HCuFCN55f63MDb7qXHFsufxqEneT/oGSId8E/NUxkigDiXqXyIHSdVV7YOfc5sAOFt/RQt89Hlu
 PvgR8vkWpQwj3F8HUOA==
X-Proofpoint-GUID: subhe-tTV62Z62g33d33XPw3APkPr8op
X-Authority-Analysis: v=2.4 cv=U/cHnuru c=1 sm=1 tr=0 ts=6ad9e5f1 cx=c_pps
 a=mOz+rD6hbbSUvRiPFvEd3g==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=gAnH3GRIAAAA:8 a=g8XXJ0pksu_Y19MBRcAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: subhe-tTV62Z62g33d33XPw3APkPr8op
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 spamscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220041

On Thu, 22 Oct 2026 12:58:18 +0300, Andrei Stancovici <andrei.stancovici@analog.com> wrote:
> The LTC2493 is a 24-bit delta-sigma ADC with 4 single-ended or 2
> differential inputs and an I2C interface. Its channel map matches no
> part already listed, so it gets its own compatible rather than a
> fallback; no new property is needed.

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
