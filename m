Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519297;
	b=iLXlbjzb490R1sg3SwH2LJnIUdxQoiEOK9IypmDarDhZMuEb9M2T/5oymKRSH0srjq49
	 Aki/8a+K+6wGkI+/APtgCPrPzqHoAw3motY3f8IYMdGmNbtSIoYDh5hvl0ObCC2l4pg+w
	 N4m7PCSDwgquO18Ns0EJFj8/ueFmc6zQhnNgukfMWdDzSsZ42N9YNRLgdRDMoUs+MUgnW
	 M/vB9MM+rRq3S7hIX0PAMnpmZ3ep8XdtBFFHj0sxlI4UevuOSJkIglsM29zUCDE79vW40
	 yeH2oMp0HLnR8XAy47V8TdIbLxwaKGxfdTu+IzQ9n9RAo1IRJvFTQgBL7t4x/BppaDg==
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
	bh=D5ZwTzYHKzHL5Ux1C7O63dT8kPtv6AivxTbc4hQLfqQ=;
	b=wUG5Bq0Noy2C7BIyZ14P9M0gfWhIb4/UtzVxUSOcP2Tgkyb+ugyyzbwXWEEVj9nUnRks
	 iC9bfPfGAqg4G/HJWCYZ52JsLUYERVqWbBcySZ6l0feLoSKx+jHeVds0IKKZ8EglU2bmP
	 fQpTmzTFvIMPqy7tZMiETpS/8xGtfXkQYqihEZmAUyoqEdWdcgV7WNYWs1e4WZ+KM5BsC
	 oiihExyPoqGWnepLm2gzYs0F5nR5EXiFgQ5ta2Sw66chntPLp0dDeC1CpBU/WrSdfuXKI
	 wmYMEFJdLDL8G72GXIsi+AC1Fd1b3I8Wtc9dHTwcbUwFX/hv1N/5UOr1zeKN2+fHrTA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GRSsnMub;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=wnAZVpmp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599E606A33E;
	Tue, 24 Nov 2026 11:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6599E606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=GRSsnMub;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=wnAZVpmp
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAvRGB592387;
	Tue, 24 Nov 2026 06:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=D5ZwTzYHKzHL5Ux1C7O63dT8kPtv6AivxTbc4hQLfqQ=; b=GRSsnMu
	bVs3VNCfVAbtzyoIXMdiTLfAlxQie1TeyoDvmYzOyHWO3QuMlchKQ+yLhOGzKJPi
	vPxBt9PtIUqnyxvhEQaw0agi7x2QdHoNcEJQpp2ujMjwKgOzz6nj5eQyV7b9757L
	r1ijgyFzlaxIkSxXKdZkF+3ykOFq1jRAmeaOmyEGsadJPH+urBmlwtp8byvWPxZW
	dFYhC0/tIUU1D7YvYE4JN2KN2BW5JVFznAhpfw0z+wPSshuy3pdXVrW5a03DdRT0
	9JgutFWpFhvgrYeLku/ozGZFsDfhSds6+EvxopzBe6P6RaUIhn2z52qXLe22KQXE
	hUds395TbyCblNw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=D5ZwT
	zYHKzHL5Ux1C7O63dT8kPtv6AivxTbc4hQLfqQ=; b=wnAZVpmprEKB32HoIP0D3
	5WZH4nm474AXwLyVUNT7UbzrRa9mcwhdCsSiQHzAbuxq0G8ysAGWiOgAlDJ3L3H5
	dtdPtm9N3tbDNc/MENaCIAodRjpjpodDCflydAYdWCB8VSj97RJxLA50+gSeSAQF
	WrsM6h+sYKMGHoaUALp6kouiRzKjwAY55mcHm9GWY+szB/zS9QguTIo/SbT2Ik48
	Ad2A4jgFFNfqCiSL66C4Ghl/UwcQoJtw8m8fTZhf4q2aOuDwBiZK1xaCjDRFYAxb
	baw5lvT0m5CYM7kn3kAiyKJ17g5yKo8KHtbhKDOoMJXzvLwNcY7UGF9PXEJk2tLP
	Q==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j574h0raj-8
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:20:31 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XpSVaSw/F1aM5eu6Z/xT3/Y2a9+Qb/bApSufwo40uu0/IQ4U3N6MiyKEHW3f1ggtU7MVN5zk5KBsIyzJXqP2I5QuxDlT3PUA9bzGzbgeKVKvCvVa1qts0Dn8oVxyYjj2BaVqmZMmC8pDFlxxEFYuW3pNN8FW8bK2dsGqGyz7yGQpriP8V5VY2DY6GPLWxJKtrJj830TQgcQrELwA5XxAtbtX5Mbs3GAN4RiwsiLFISof9/EphcemgAcJXDsY4440BsDJcJLNg5/xHr+bibjMI8/Eo2hmNX0gLdgibXE3wmGOxYfkSpK4ENYcA/QAkt8UMkWI1LEGhZKCTR6qAjwS6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5ZwTzYHKzHL5Ux1C7O63dT8kPtv6AivxTbc4hQLfqQ=;
 b=sjDmCfhH+SbxJID360jN+kZplXnnzAcyAvmyVWRUdQU3ppQOx3dpu+xDQB5bcSDxfw7lsIk6rheO0FxKWkYjYYiuyuEkErWf0SQKzIuoVdvEwOOOcZk37OC5MJOW96vTdjIvua1tBt+UYAN1jdb8S4UNiq1nfWg5y5meDIvgr8OjEBUngwWq/ZxOu49Nab+80BoY+1jlOKLAJhvPyn2nz56Kbr05dTEhqXLpsUDyD30QcFHDaZd0oL2hjYjs29FmCby0Zl5R6mYCPwkMVCXvKSIzXzmLmu7kroDOnTJyFe4azhzvDvq5xG8vLrcjLF1N8HFoCRXp3vGFjwDJC9qyPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5545.namprd03.prod.outlook.com (2603:10b6:806:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 11:20:26 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 11:20:26 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Tue, 24 Nov 2026 11:19:45 +0000
Subject: [PATCH v7 5/9] dmaengine: stm32-dma3: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-dmaengine-support-wider-dma-masks-v7-5-5d57df2c3ebd@analog.com>
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
        Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795519198; l=3868;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=/sigtXVh+YweK63iNRI9Kc4B5quKprdvmw+/YvhEXNY=;
 b=CCzyOmyDJ9gcYf8zBK/rsos3GEYIG/XxccdUCpWhZoFaF5B6tJdBZDlh7RtkO1hHUQ/iGm1ia
 ylxIRhVaicpDamNcGYB5IH/h8dRQG67Z0uvff3CRm5BPS40KNsEvhzN
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: PR3P191CA0003.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:102:54::8) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: c1c73c0f-552e-427b-30d4-08df4a1cf052
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|11063799006|261026121527099003|10067099003|261009223027099003|56012099006|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
 oSLS9OvR+47tzguPrOOgGQZZHDo2Itbg3E9O61+osPbJGL5Q/3IzyvLQKtWZEufPrvJRi3jH7JgBmcBV1W6ng/J1HHEHJWNEVDNTljdDISxgHJTTTzeFHL8HRjTrFkj3t+2/pOTbq1OO3IWZXCtI0fufNlOCtMjHIbjr9t1L3bdmjGcYALlbJrVjMNiLBYIXM1bsE0UQHZkN02KT+6xS37oZ63jpZ3tD8pbu0RK/Ip716ytaV4TPmXYGSS6DDzWSP9RzWKHxWEzP+GaZhQ/FWdrrw1kvx0d7all1X2IQTC+ehbyR3FwTdpIbsg3pCG+aGKg4dNiLmfhBnHsGJhyQc9CSBaKeDbfatq1vxLq0CuITRzAPiUVZRIG/Cst0/JvlM03psr3miSdQ8Lob1CtLIR2G9CfuCoz+C40eaQDMwYBKFTPR3rS2ZE5Bxah3XicIkYbv4ixESiQQgGfvFZsfui/VhQs0pYdMW9pRsVhbZbbiiz+zFPuclbe7EDkopTEqmTQH09rhIcQZrfEJAZ3urx+gjAAogNdyiv+iEvkHRzE0iy4sDWWASRGghRofyrjj0VmfoGuRmHfQoSFEnJmXlkGZaI5tW23BCQgmdl5miXFhIrL/gzRHoTPorXggLBuZmQoKx593s0cYrD/CVm4gojNNgLkbrEl3Bh8EP6K5URk=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(11063799006)(261026121527099003)(10067099003)(261009223027099003)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?UXQ0Njl0dGc5WDFGOW5SQVRvUzd6TEdXTXRteEM3WDdFZEFhV2tqYzBla0pX?=
 =?utf-8?B?a1ZtTE0yejcwRTlBa3czOE9hcHN5clVIS2lMc3BpSDZMV0tLUThlVmZPSy9J?=
 =?utf-8?B?UEw1eFRaT3pJTGJEZDhteU9FcVVwdW5tVjBwT2ovUk1sMmFTOFpYcHlVVjY5?=
 =?utf-8?B?c2YxcEJyY1AxeEZYZFRJR0tDMmdxN3dpcDlzRkR1dm0rOCtvbjhpMTFlRnh4?=
 =?utf-8?B?SVFzK1RTd1U1T244V2NnZ0pleXJaQjB4SjVBazNYbTFLV1RPTy9ScVVYWDhO?=
 =?utf-8?B?U3ZSSHJxYlJwOEp5bng2ZDNRSTlPdHlGUllLeU5Ma0plT3VMOVRaR2xNekZE?=
 =?utf-8?B?eXlvZDNuMnlVbHZIMjZPWk5uTTFOSStKbHN1djNIdFNQRnFLMktkbWpKTVpo?=
 =?utf-8?B?SWhMT0Vqc1RZVFp1bXR6ODVDeFNtVzRZenUzQ0taVklNMnBBR0c0Wm1Sbk9Q?=
 =?utf-8?B?Q1ozWkFwM2lJZFhUVGhVYXdSaWlDTURBOXZ5V3pBQnFhcXZlSzlNMmVjLzRV?=
 =?utf-8?B?T1QrTE92cU85S2xIcGNLc0pLZ1hOQnpXY05IY1I5SVZrZXB3MW5Jb3JSc1F3?=
 =?utf-8?B?bzlzbmIvTWdqcDRUSTFySWtkRlNVNHlJd2JVVSt1ZUFERnBVRXo3dXYvT3FD?=
 =?utf-8?B?ZWVHQStwNlRCaHF4bGRlSWtmOGJVNUhLUS82WFRESFFxK1BUc09hTE9hOTVD?=
 =?utf-8?B?clZLc3BmR3lDTkFSY2lGR1l1NEt1RDJUOTVVZWU4bUc4V3ZvemxMZG1qWE5C?=
 =?utf-8?B?MGJ4SFRSVGJiZE03SUFFUFFBR2VMRHdBd3lka3RJenZJMit5YkgvWkh4Q2t2?=
 =?utf-8?B?UW0rVWtHK1l5M3pYcEk1SEdtNlczVUZvT1ovaEdyZmdYU08vMENuKzVNRmd2?=
 =?utf-8?B?MHVUK1JsOHB0dEc2Vk15QkpIcDI4ejdDa0g4SmdSNlJCdlJlckNyQXpuQzhQ?=
 =?utf-8?B?SzVmMHJFaTcvcm9mcW45UTdKMHIraS8xd1ZndThYdUdBVnJTcXR6dnpuc3Ay?=
 =?utf-8?B?RENDTG5TRTNhd0dMbzRtbDR6bmI2S1NBMW5UeGc4dm5pUmFKVWxIYUlnOWR2?=
 =?utf-8?B?dUpaVkFMSUx2MGFyMWFhLzVjOVpJZ29wK2QzZ2dWMTNoZ01yYldRQXhaYWRJ?=
 =?utf-8?B?SUFZc2x4Z2lNckx6SzhYQ3FIYmJzSHEzRTRHZGQ4azNPSzR0L2RoaFdkelI1?=
 =?utf-8?B?RVFCQmtmbytFWWdmeVBmaitOanJyYmx3a05ya1VmdVFZY3ZYZG4xbDFXNHVq?=
 =?utf-8?B?aXFFem0wSHUvcHVsZDdVWXNTNnkxSk05SmNsRXdwZVBMYm1FN1dHR2JodmFv?=
 =?utf-8?B?ZlJlT0Z1MzZiVEVrWGtPdjZObWdxRDhiengxOWExRTFJWU5nYzJpeXIrNzJm?=
 =?utf-8?B?WEcxR3Z1L1pDOEtVeVIrVWM0VFdjb3htV2xhZmFKWFhQMEMwWEx0K0IxdU04?=
 =?utf-8?B?bE9md2gwcTQ3N0FaQmRNcFdnWk9YVWRMc0dCKzlJUkJSVFppQ0EzTGpQd1Ft?=
 =?utf-8?B?MjdqeUVrdzU0SGdHNC9ZdDNLQ3oyL2NseE1RT09heStTdXBvS0FrOGowQ2R4?=
 =?utf-8?B?ampNU3p6UEhGME9ES25NcGE2VlI3VU5BSWxybFBHTno1dlNhaldZM25ySnZF?=
 =?utf-8?B?YlVWaHphMFI5L2t4WklzSStTT1V3QUJGL3FBRkpQbDFsR3BqaE1ob1ZtQU51?=
 =?utf-8?B?ZkV4N29pUTdiVVNYOXJObVdvYUg3TUFUaTU2NFZJd0t1UTRUSjROQjZEOS9F?=
 =?utf-8?B?Y1dFOWFnaXQ1UXZhVVJFbGE2djhXaTdOcXljeE9KUFpkNHl6MzVQMnZSbnc1?=
 =?utf-8?B?b1AzTGQ2c0ppNUlRSDdkL0wrcS9QM0ZVdklUdWp0SEtHVGZJcXlnbEJyNGxr?=
 =?utf-8?B?SEgxdFVkcFplOXo5N0JMWnlndlBUQ3Y0S3c1dnZ0VVNSZFM4Y0p4eVhNY2JW?=
 =?utf-8?B?Nnp5OGVDaTNGSWlLeWdSaTd2bXhZR0Q0bHFITmNKVDVCY0ttZjRrYk4wQ2Zh?=
 =?utf-8?B?R0ZJeSs3OW96Z1lqWkhHb0VoVzZFR1BFRjhCTloraHZ4TUJ3R0Fab1pCZmVQ?=
 =?utf-8?B?NjlNbFpCbjkyZFlkcWJBajB3YlM5UVp4NmRBK3lUZDNPMUdmY0ozc05qSHpN?=
 =?utf-8?B?SWdLNDBob3FjMzNqZVB0d2dkNVlITjNaL3QwUktKdW9tdkVmbHozUmEzdUwz?=
 =?utf-8?B?VzlveCs3NisrQTdYUWp1eEsxS1NERVRGeGFpb2Q1ZENvY3l2aG5XeDN6N2JZ?=
 =?utf-8?B?RkJUYktsV0F2MVREczBWOG9nWVpLZ09DWmJNWTJkcHFjYkxabnJHWk5NU28v?=
 =?utf-8?B?Mk1VV0xOWVN1cHAwa0c3YVZ6bUdiYTdQd0c3eHN3NTBqRUhoM0c5UT09?=
X-Exchange-RoutingPolicyChecked:
	Rvz393EkTtwS95cxWvc2vLwtUvddujnBfngdfHxcbL83PFDYGZZAEdHvPgv4Vqqvv3G1cjpf/rSTPMMcJ5K4Tme5sb07eSkdIJbfqxnHB9K5z9jcd9TfjxceSVeaGmcMX1oKD1ShrhDGzXtAtAUxbp7enFKArK+cLevqPre1TL7ZvwvD5G+xgSdNRkDz+UJCk7V7avUeA7m7x1/fkTZ5zAaZOwwmy46V/XQOpX7GRbEGurS3ipruxvdJATXcFgN1wmVRijalXIvBc+i2zp4u1e6VpicvayD+qKyVTfEe/k+wQ2HMRvH1npFPdO55vYFYisn30k8PU39J5KSIRTUdqg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c73c0f-552e-427b-30d4-08df4a1cf052
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:20:26.2297
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0qjPH0WbRdfzQk5JpMGiNxFHUW+F7cHzqaCf9sURwjc7h9Hp22hvHrZk/RswX+FGiBtcBmMDMZTV9Sh1kNQerw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5545
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX2WlNmGwOjq+r
 2sOWcwvYFuVhUKFvVkX8GSk+f3y3f7JYv0Koo73pkeLHSFH8yrfHq60gcSxWSrUUYTrCmxc2Bpl
 59o5Im0a7OoALTPKHeG6H2AeDQR4x/Lrai79nNF7fpqPUgS4keaDumTmjiknbXf05sUF0THr1K4
 7c5OKpmYFEwDhfKsn/L33dj6R9/Ux9n3u9uiTR1OyIl3c76zXc+24Iu8oPl97CoNuA+4t+upNXK
 djQ1/ZmjZtraLvUiwYMlH6nYYk9lHP7GKn+eRLJ3DFw/hkHoUSNCiKyqHlqAjUZm7ykY9k7I2uW
 BzIHfGS0Y33nRQWBEEj1TQ+s4t+4NnFLCyzV8gwEXsVu1RmiP2fbG02IaMFONB4m1xVma2IoAei
 lrlE5Ovs9GUxAXH8hcJ8c8mDgLmn6BqYt7+IwtJATJ2ZcWsP/3vPexvSe7Ja/kuiXIzlZ+lyEEo
 Al9pOhyL+g6RH788zzw==
X-Authority-Analysis: v=2.4 cv=Yt+a1IYX c=1 sm=1 tr=0 ts=6b0572ff cx=c_pps
 a=foOfPl9YvWvIvXDtd8Rkbw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=8AirrxEcAAAA:8 a=8b9GpE9nAAAA:8 a=gAnH3GRIAAAA:8 a=hoLHniV83FUdLTyWGJsA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
 a=T3LWEMljR5ZiDmsYVIUa:22
X-Proofpoint-GUID: BCKlIaDvQ4bgVLY0Kfeju6Dzd8LN_qt7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX6sZ6H9H4g9/8
 Z+3r0QKM28CTCrBnllrdwBA7iym0acVivW2/m6fp6X6N7jf55wInYW3uMGs9e5zjpZt/PlNx6dS
 XFSPKuuqg/Y7/gh1OhLpnl1tq1HPXIIN7dyXELyncVEhI3/oW9aH
X-Proofpoint-ORIG-GUID: BCKlIaDvQ4bgVLY0Kfeju6Dzd8LN_qt7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240044

Advertise the controller-wide bus width capabilities through the new
dmaengine_bus_width_set_many() helper and clear the per-channel
unsupported widths through dmaengine_bus_width_clear().

While at it, validate the requested transfer bus widths against the new
capability mask instead of the legacy u32 one, so the driver does not
depend on the legacy field anymore.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/stm32/stm32-dma3.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 4fe226541efa..5d0a4ac4d2cf 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -583,7 +583,8 @@ static int stm32_dma3_chan_prep_hw(struct stm32_dma3_chan *chan, enum dma_transf
 	dbl_max = chan->dma_config.dst_maxburst ? : 1;
 
 	/* Following conditions would raise User Setting Error interrupt */
-	if (!(dma_device.src_addr_widths & BIT(sdw)) || !(dma_device.dst_addr_widths & BIT(ddw))) {
+	if (!dmaengine_bus_width_test(&dma_device.src_bus_widths, sdw) ||
+	    !dmaengine_bus_width_test(&dma_device.dst_bus_widths, ddw)) {
 		dev_err(vchan_chan_dev(&chan->vchan), "Bus width (src=%u, dst=%u) not supported\n", sdw, ddw);
 		return -EINVAL;
 	}
@@ -1464,14 +1465,16 @@ static void stm32_dma3_caps(struct dma_chan *c, struct dma_slave_caps *caps)
 
 	if (!chan->fifo_size) {
 		caps->max_burst = 0;
-		caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-		caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+		dmaengine_bus_width_clear(&caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
+		dmaengine_bus_width_clear(&caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_8_BYTES);
 	} else {
 		/* Burst transfer should not exceed half of the fifo size */
 		caps->max_burst = chan->max_burst;
 		if (caps->max_burst < DMA_SLAVE_BUSWIDTH_8_BYTES) {
-			caps->src_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-			caps->dst_addr_widths &= ~BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+			dmaengine_bus_width_clear(&caps->src_bus_widths,
+						  DMA_SLAVE_BUSWIDTH_8_BYTES);
+			dmaengine_bus_width_clear(&caps->dst_bus_widths,
+						  DMA_SLAVE_BUSWIDTH_8_BYTES);
 		}
 	}
 }
@@ -1729,6 +1732,12 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	struct reset_control *reset;
 	struct stm32_dma3_chan *chan;
 	struct dma_device *dma_dev;
+	enum dma_slave_buswidth buswidths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+		DMA_SLAVE_BUSWIDTH_8_BYTES,
+	};
 	u32 master_ports, chan_reserved, i, verr;
 	u64 hwcfgr;
 	int ret;
@@ -1770,14 +1779,16 @@ static int stm32_dma3_probe(struct platform_device *pdev)
 	 * channel, and can only access address at even boundaries, multiple of the buswidth.
 	 */
 	dma_dev->copy_align = DMAENGINE_ALIGN_8_BYTES;
-	dma_dev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
-	dma_dev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-				   BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_4_BYTES) |
-				   BIT(DMA_SLAVE_BUSWIDTH_8_BYTES);
+	ret = dmaengine_bus_width_set_many(&dma_dev->src_bus_widths, buswidths,
+					   ARRAY_SIZE(buswidths));
+	if (ret)
+		goto err_clk_disable;
+
+	ret = dmaengine_bus_width_set_many(&dma_dev->dst_bus_widths, buswidths,
+					   ARRAY_SIZE(buswidths));
+	if (ret)
+		goto err_clk_disable;
+
 	dma_dev->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV) | BIT(DMA_MEM_TO_MEM);
 
 	dma_dev->descriptor_reuse = true;

-- 
2.56.0

