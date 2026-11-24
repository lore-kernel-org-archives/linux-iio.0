Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519299;
	b=HKFoEesera19+cMAMjCsBo6hFD0atTva8EK/oqx2lpErCODpiq89JmrvuYHmfXUHevGr
	 EJN9dLfWkTY+LZxjKMEeLoVuZ3SR215MnI4cddVaJqYzPe2DgrfuE7xur0XdEnhGCIJom
	 ux2cQTc3KQVk/BS+jfOk9w8aeod8TjNDq1CCqlKHhEcN7tySYJdyFJ++CvwVuEk231Ul6
	 ovlzEjgN75B2SiqcOSG4Nk1eOqj/CAxEPcIiyq3dc665g81gJRAslIVbb1XuZwOUlU1Yv
	 QPYtbW1vRlmL1VLhRcac5qmJxHbwTBu9pC/ASACXVkK81uauUIILZUGJadk0Y3Kw6Fg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519299;
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
	bh=Q2oJR/Vb7DT2ze8eI7ml62TFu5gg6vX3bw4x3yNdxao=;
	b=MIhzQr93eBAunid64iujivAWj/fedJJDWmEgJWMG7+U7BqPRqnntmMY4mZIEPPomX8+D
	 CEFJf5vwPfTUipu7JCs8bbpOBMlspveIeTr3GQMZZIPtb0NvXMbJbKB6v0dCHIEMS9GQo
	 sfggU08+JKmiz/CdYe/KCFUaR/YbmGYHnz9JzEMR3OPRtk+9ciZsp7sA6wOLIRwh/8ZES
	 0Q9YCjH15WPNi8bgZZA6YsCQNyU8RH9r7T9jY6ombU0nrOZYRLa5uD5qW7lliJPlBM4DS
	 x19zr73kBfg/8MmcVbPs71USPbT7tQhQoEkafznp45Ck5GI/buYajM2Xps9AvCcSvaw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=DEl+xxZY;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=beZMNhEQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E14D606A33B;
	Tue, 24 Nov 2026 11:21:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E14D606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=DEl+xxZY;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=beZMNhEQ
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAvJBA592340;
	Tue, 24 Nov 2026 06:20:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=Q2oJR/Vb7DT2ze8eI7ml62TFu5gg6vX3bw4x3yNdxao=; b=DEl+xxZ
	YTffl5lW0SF9pshR/+uRz3C6MGzjNmLL56sJdlAv2CEnsUMpOvd42GObsaeyVjQm
	muEQJhkhBWfpDSl+ulcNdxS5UF50Bj/0JzLCcOVRKOISfdJi6ZIcEjzLlXv+D370
	HlazEjF0SOgWDpAxP+NPjdEnTFffNLB+1+GYSBK9FbOeH1D1aSbFwEsiGgI8S1IE
	M6H+cN/nFB8lOS7k4jJeqizY+P23+42DUX8oA+0B3BKgd/Ty1P4NhhTM5TBbuNhr
	oJ/EEFzobszQu5ye5f1di3UoBPa3uW8g3XH4pYva91M4f/lcrV8bgoTfi5kmyA5+
	N4Bj4IiWK7nptHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Q2oJR
	/Vb7DT2ze8eI7ml62TFu5gg6vX3bw4x3yNdxao=; b=beZMNhEQ3Yh6Y3yieTG+7
	7d12GoVUXrDYmyF8+W2F65Xq8xczfbFBwZ3PJ6mdy6TPSEIu17MBqMoQXB5n/PWb
	ACP2wzNde0LAuKa/NVd/5hi+nE3Eo1bVaiSSXu4FYKAhnxaWB+chpVxPfT49HjVn
	URMzPFbCoNccQUida6QLO8YaRE+LXfqy1LKSRoyzftie/2hY+xS94TvWl+7LGD5S
	pw+Bdfiw6+bcNrqgAM2RW4BxPYRXsdzAFwtmKtxqNdkgJmxth1rolKdegYAxQ1o8
	X7j3yti/Gsgb7c0ia1xGCm7Ipc/b5rK/6yY6TJXp6L3SkqZIY31AxrXEtuddd5O5
	Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010041.outbound.protection.outlook.com [52.101.201.41])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j574h0rct-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:20:44 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NybbFfmKf0xNM/FeYKBxUimsAwKrN1nv+xGj5tR5gflWql/LA6jHjUiHW/nRcMfMoC80qlEUKSmzJrXQBoCNDDys0qzBo7qH46rGsR4aeV4IsdzjMSE+KGQ+4sw8jESLID8kBAlb0zQqwcNz1rpkLehZTn3alug0plqZ92Mr+p1pDNXHzX35AR2Yc22Hplmwzj1jEFWSecGtAX6eerXbKoC3272WDWwZmc/4t/CFzZ4qeE69evv2fxUoRpMzzzumxJbt4YzZUOJghtI5FwrKEKVM1tidZPdbLsbtlG4NFmMboJO/J6IWq75FK7AB5F1epbbutNgWMeGDz/tVfMKjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q2oJR/Vb7DT2ze8eI7ml62TFu5gg6vX3bw4x3yNdxao=;
 b=TwHVdDMcAgLFSlc1YJuyj9ido1rOYcYPZqAzAzZwDlY7g5tQD/ezztvMR9fKHjpTnuGLsN8KA4qXzJtlgoHvtg6NaorwwKScCWwpEz7QvNm3Cd8xco+ZA0vWbPYi7BjCNFlwEn1Wnonq3g6yIs+m8b1buGB++yrPRWdltsOD2KAsm+yGS0W71s3Xi8xGbl/I9ZwqJCd82oBPwTK16oUqRrJx9lWebVGlaDsI7CokH9wO/0xiQo0PtYr7VcfKRcuZlX80izALJdpxUYjGJhHUHQ8EQzFANnAMSBEslkunY4oHbuTkse6fR0p7GlVYyEo+2dGCS36hhqzRBlvV25fRmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5545.namprd03.prod.outlook.com (2603:10b6:806:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 11:20:42 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 11:20:41 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Tue, 24 Nov 2026 11:19:49 +0000
Subject: [PATCH v7 9/9] dmaengine: Drop legacy bus width fields from
 dma_slave_caps
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-dmaengine-support-wider-dma-masks-v7-9-5d57df2c3ebd@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795519198; l=4693;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=k2blmynj5khg6PJXMpcJZEFot8u4e5JVJoBtT6ReG1Q=;
 b=6Vzrnlfh6u/feF3eP45s4T+S8HRKWUpEl0d7Evaj+bEQz25k7X/ZHI8bd5pQIH4e8Qi3ivLFq
 1dL15vD75mVBYx69vU5QQCoLPgOZ9DaiVhY960z6epmalPKzhM19hzU
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: PA7P264CA0175.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:36f::12) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 8ee20954-ea6b-4d3d-36f6-08df4a1cf99c
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|11063799006|261022075727099003|261026121527099003|10067099003|261009223027099003|56012099006|261021121427099003|261021123027099003|261102123227099003|261102130727099003|5023799004|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
 2aGZ7OBjoF/XH2rRnJzz7zFB8Hn/n1W8q3XNRpRklUX63fJ5mjnlWkIdATGp1Cwfgn+GE+hrBoV3IW+y4QpLLrBzAsKg6bZUu87MXR9WH7ai/J6j5RD0Vngoow+qBp/mBirKhfaylSrWm2/rES/UEkDklzcrvs69MPSxxEFd603kKOEUCk4RDw/aANjVmSf3us9Dn8cZ3+0MSzoeuudHFRF43fDexB4fCo3Eg/zOF01doZ7TIjDrk3qqQKL2T2DPfwxQ0ZiN4kD0OlAZ8iuuWrvSOL30I+c9hBevsn1mCXuv4Zp2ujLhhCFAQmpyuqS213wfY/56vGJ/EP/DZtyKjmO5uUN5kqMEtDSDuS8sIB1mAQCkwTRsSp1GOpv4nEFnD61NWQXokAltkcPEvv+nQVry+x63lGBe9TeBXDF0JjxXZghFbKvMWcazK6KNL5cqJcjn+ac/rW7j9m3hjTla32VYqDyVgUaBmHyiLh1DYoh+iEB8Pue32WpI81I/XVXHt3NZwB3OB1s27JSnkXyhOgenP6cXYYHJtLnMvdYFSqrQDsY6oEzNVtNtr61mLj5f6QMLUHaclMIC4noGM2BS2f1dgJchcK07m+TkGpgvcPRIC42wc85KnPEZ7uoO/YGP/J8Oj0Nse2lYcJrH+TyQAcBV8NwwHuaC51HxwcOo3P4=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(11063799006)(261022075727099003)(261026121527099003)(10067099003)(261009223027099003)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(261102130727099003)(5023799004)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RjNsQWpxVFJkaXJJb3lzdEJtS1R0TklMWVc0d2xLMTJRcjB6M21kWEplRmYy?=
 =?utf-8?B?UTljMEthSHpyMG8zeWpjMVhMc2grSzBMS29Bd3BGRDBDQ3o0KzhLN25UblM0?=
 =?utf-8?B?WGUvSTM0YXVPWFM5U0Z5M3JHa3ljeHgwekY5QkM2NnJ0N2wyUGt6SnRadXZZ?=
 =?utf-8?B?LytzQTEyU0dzQ3ZKdWFRVFdIMThuUEIzYm13cGNFeW8rSHk0U1VKdm1IVDJF?=
 =?utf-8?B?UXFOc3RqR0tKNHpsSzRjaEJVQ2ZCL216WDRrZHNLTkJtRHNxRnRjc3ZKVVhO?=
 =?utf-8?B?V3NFQzlMZ2I1YVZDOWFiRHJqeEhDU2xYQnlXWFFScTJBZmduekI4WWg5dVN2?=
 =?utf-8?B?REIzSXhZK29tVzJCRkRoang0OTBOVEpqMXBQdW93UUtzbEQveGdsK1k3M1Q1?=
 =?utf-8?B?dVA3Rmx2VUIvUkdKN1hBdjZqNmx4N0tUK2JhYWhWM3Brb2NSSjEyaWVyWGRB?=
 =?utf-8?B?TXZTUmpPT29mR0syR1NzeXBKWFVoTTdCUUFGcWV3NFBqRUdmM0FEdDNCZzRJ?=
 =?utf-8?B?cjFmbWY1bDVLT1ZpM0d5bW9sNlUyaTNaVWtWVUh6ay9JRUpSbjhEbjdWUjVk?=
 =?utf-8?B?NzhlRi9lbzN1SEJPR3NJN3c4bzVJRGhTUitIK3Q0dldhRVhYTmNVeVNlYWhH?=
 =?utf-8?B?RCttZHRjUDRHWlhtVDg3R0UvdTl2d1pFVHhzQU5jQThRajkwTjQxY3h0LzZ5?=
 =?utf-8?B?SkRyTm84YmJoM0F4eE1mTkpFRDNrd212SWxxRXNpUHh6eGdmTlZzWWtVTGJM?=
 =?utf-8?B?M1R2QVpOT0R3SXorNGt1aWg3Ti9FK2xGaDhoOUVjejJJY1VMNHhRcW5oQXdx?=
 =?utf-8?B?ZHg4dHJHZ1U1QVNPczJLT3ZIeDZZVEJndjF3eXdXdkFZbjZXczNSZlRmaitV?=
 =?utf-8?B?S3BhUHNpNjl5Y1Zxd1J3dTRkV3FUaXJxS29ONjhQb0pLSk9uY21wZG9zTzB6?=
 =?utf-8?B?L0ljbUVCVFl4NzFJVk9yMCtJbWpsYzVIU0tkc3RHNktlM21TRTU0b3hRbW4v?=
 =?utf-8?B?SStMTXBpdHhtSnh4THpockRTRWJ0K3dTWUt1RFNEMDJwbE52akhQN2tNZFdF?=
 =?utf-8?B?V3pXNm1Vc1JmWG5FRHR4bUoyOTExck50VmdhOVQ4UXRRYzA5bm14b3dZT0c3?=
 =?utf-8?B?cGVTT2FvVEZaamxUNllKTGtZeEdNdC9VVG1ESmhzTXo3S05TNnV6UThCdkJ4?=
 =?utf-8?B?ajE2cXZncU5XY1lwWVUvTDY3Y2plcDJ1Y25NWVJxNmdKWllvRFJ5OHM4MnNY?=
 =?utf-8?B?N1dpZUJyTDBwS1lLcWdrdWQvanM4L3ZXejRzYis4emQ4RzZBd2tZU2pjcjVV?=
 =?utf-8?B?cjhjSHhvUm55NmwvY1k1dUZ2UkJ1RlVFdkpvOXRNaW12aG5uU3gwVHhJNFNi?=
 =?utf-8?B?bXBSYW5pMEhTVmd6T3NFbzdsYVVXcmtTaG9JclplV3N2d3NudVVqaEg1Qncv?=
 =?utf-8?B?MVRyMnZJSUJJNlA1SmtpMVIvRFVLVjB3K01QSTQ2cmdsVlB1dk9QbXBJcFA1?=
 =?utf-8?B?K1Y2R1NvZmdqcVE0dThZbHAwQnFYdlVtL1RDUnZmcnNucXdHOURHWm5oV210?=
 =?utf-8?B?NVVJQnpaemdVdjdieVhrbC94a3ZmTUJZTlN5M0VtUy8wMmJVRENZcmROSGlI?=
 =?utf-8?B?eFBhN0pPd3NTL0t6ZWdBQzVqZGFTUTdUdGVMajZzbXdPMlF3a05aN3RUOGlO?=
 =?utf-8?B?L2VMYVhMZzNLclVkcTNRdDl3blZVbXRSMXBuY2VQZ2RiN0VsT0xBNS8wdVpG?=
 =?utf-8?B?ZzlkanJyMkcxR3VQVVZyckVEV3hSWjNyT3FudXg4K0hoYkZreHYyQkVoczJO?=
 =?utf-8?B?aFU3WlE4VGdaeFpPbUZhVkhnZzFkTkdndm5KU2M5bVBwVDlzNTMrUEk0VHRa?=
 =?utf-8?B?bW9udjk2Z2dFZ0lqVTZ0c1JmUWtvT2JOUVd5Vkt6L21aQzdOUGpUSDFRRzI5?=
 =?utf-8?B?VUprUEFtL1BUNy8xaTR2SkNFajBBWGQyQXFQdVhMYWZJMEtxZ3B0NjZsQUFn?=
 =?utf-8?B?eC9jbEpoRG94Q1d6cVdnK1JwWncwdlBqcWpiKzNvMDZPUk5xdE8vU05uRStu?=
 =?utf-8?B?NkxNNTloUDZxRm9GK0luaXplSFpsUyt1RHhsdlpyNFo3YWwrZ1RMYUtsS0ty?=
 =?utf-8?B?MEthVVdLYUNrQ1NOT0cyZVhtbnpaWmR5Q1RKUDRGK0VuMmEyd3BRM0crL2xL?=
 =?utf-8?B?eFFPL1dLMXV0a1lqbFQvYjBBWmZIUlJBRXJmNVNXNTIrODR5aU1mMnd4QlpM?=
 =?utf-8?B?Si9uYXAzL01TRGdDeW5zZUxmOUlxU0E5SWR1V0xtRzF4Q3I1bkxRS0FSNzZl?=
 =?utf-8?B?WkNCMlhNdjlSK2J5dHZXeWhJZXo0SUpYU01oTnFsWFZvUXVKWTJqUT09?=
X-Exchange-RoutingPolicyChecked:
	EFFLMs82v3wbCRugP/6XkIS/+uZIgaFVYtNAFSPPcgGMR5tHPAvfeea3PWdDpg9SVnIQTC3g0EhgNqKXyQIIBAKqY3UGHtOJJ9rdZAVUky4SM5JM6jnlWV3AF0B76IgbAw4E8LeOAl3Zh7Fc6i2vJ6NVA9/BU75kRt3NnwhiUkqcBrfGC4FuCMmU7Q70b37koiprMTQL78/bHJv6jRG7AHd/L+0S0/sDhL+Q1vENMXdjHFg90x+Mq3sIgIAPJ+3SduRz7KmG1C6T7UfqJ5ihF0+unK5EUdMHM8hHtrGYiIIjKr81RQmZLy1fBLYU/rT0PQVfMkug2QTX2PUqzszA8Q==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee20954-ea6b-4d3d-36f6-08df4a1cf99c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:20:41.8967
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QUJAggu5gGYDLfkVoPzAVdZftgIk2OCc4rId+AA6edtrCekYTLh0wfeMKuPt5qL1lemnBuSnSXjOjSjAhzrPxQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5545
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX7Ltz4sHFOsf7
 Pi8CsKT2KpB8IamERUTElc1jhrZP6hhciGaRfka3JFJft8czqhWu7x4dwA+J2Ub3z1/7rJsxXVz
 JIJFp2QRZObzb6BqI6pvKHQZnGXhxesfmnUyfeGbHZown8G26SL6qmQJx+dX+alnJwznwibNr58
 HF60qyWVbbMn57wjnhJ/f7HjuK2MXFZ65o7B1x9dj2eZqXc5BgSYd2LDpfoNeV5E27Gs3Yrm7fo
 InHkyLnc35PRQhqfi7ng5Z1dXzx1iYAnXCOJRoUywoAFwJdKZ3mFX1MGZLnxhmbNeuPBTZtcmkK
 2zB17HoFdBTTy4GMwPlF/AhGT8aku0m4eS9zCooKKUJ34Jb56MmOu4PsQ3eS2KlvABhnlLwSxJ/
 38EByXFaKiDo1UOG663sOiQ/w01D12YMPBGjgqur6EnmhtDWYAfIR3Rk5xAV+KFeX2mGaiKMx36
 WAOE+r6iMZgZBZmaPnA==
X-Authority-Analysis: v=2.4 cv=Yt+a1IYX c=1 sm=1 tr=0 ts=6b05730c cx=c_pps
 a=xSIn1YjG+VojQN1dL9/zMw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=8AirrxEcAAAA:8 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8 a=CIoI50WrR_K_g9tIiWcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: zqXf_tHUslCCoDVfa5A37YNLJm6B_OrR
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfXxbGz7PC9k047
 I1KlXdDZwsd9t863EUVXpa86bBrxXm6hZGphTcHIbfLOP7zJVcqWB+fHaebwSF8bAVhkP2GmMAI
 zyeviHV5jMWY8vMnxoYZJ/Y5gj9MON3J2nfmi5614ir0te34dISV
X-Proofpoint-ORIG-GUID: zqXf_tHUslCCoDVfa5A37YNLJm6B_OrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240044

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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dmaengine.c   | 31 +------------------------------
 include/linux/dmaengine.h | 13 ++-----------
 2 files changed, 3 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index f81efcc75985..d3b57114108d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -623,8 +623,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 
 	dmaengine_bus_width_copy(&caps->src_bus_widths, &device->src_bus_widths);
 	dmaengine_bus_width_copy(&caps->dst_bus_widths, &device->dst_bus_widths);
-	caps->src_addr_widths = device->src_addr_widths;
-	caps->dst_addr_widths = device->dst_addr_widths;
 	caps->directions = device->directions;
 	caps->min_burst = device->min_burst;
 	caps->max_burst = device->max_burst;
@@ -642,31 +640,9 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
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
@@ -1237,14 +1213,9 @@ static void dma_device_fold_legacy_bus_widths(struct dma_device *device)
 {
 	if (bitmap_empty(device->src_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
 		bitmap_from_arr32(device->src_bus_widths.bits, &device->src_addr_widths, 32);
-	/* consumers not converted yet still read the legacy caps */
-	else if (!device->src_addr_widths)
-		device->src_addr_widths = bitmap_read(device->src_bus_widths.bits, 0, 32);
 
 	if (bitmap_empty(device->dst_bus_widths.bits, DMA_SLAVE_BUSWIDTH_MAX))
 		bitmap_from_arr32(device->dst_bus_widths.bits, &device->dst_addr_widths, 32);
-	else if (!device->dst_addr_widths)
-		device->dst_addr_widths = bitmap_read(device->dst_bus_widths.bits, 0, 32);
 }
 
 /**
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8f07eac6a877..07e1a6dc64fb 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -684,10 +684,7 @@ enum dma_residue_granularity {
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
@@ -706,14 +703,8 @@ enum dma_residue_granularity {
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
2.56.0

