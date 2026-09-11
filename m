Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107BC4A9D42;
	Fri, 11 Sep 2026 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147787; cv=fail; b=AHgxW61Azq4QAA+7EQdjXJjm3f/XE15h+Wkj5maBIU9crbjE2B1NFTOH5vkMz+19gqGT+SQ6TwqYGGgRsfLJD8hGDf9ZphUuvL1cWpSxYoMxa5DY/P4WOudWmZrHyEQHfs2r4La1umEK079kUT+bAkAN1XJ5uzk++nynQcP2O8w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147787; c=relaxed/simple;
	bh=K9CJIv6gWqA4R9j+4edOp8Q8yJcduc93BBDhknJylU0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=ZivTQodcpc5s15UFe1tRS+g1Uc88WLtqIVgXw2GpCZZ+ZoP98gdFYliqFZJgsbHU10V/QFu1kA1FIKdIvIg0pi5tc0VezQSzFe93j1rnzPk/SjOnBsr00eGGoOw7MkeUrOXaOx29T5P1yIHj4/Js/XFbDH+NAp2Gtvbyzh+YEQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Hvc9SdEk; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Hvc9SdEk"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEjXL72377428;
	Fri, 11 Sep 2026 13:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=Myz5u
	ZX4bj8X/wWn/3wPxxcd8C7XpIn8Rc8c6djDTsE=; b=Hvc9SdEkvOkcplyvpj0SD
	xTLKmW+64En5OcY6CKPe5yyl9kLA7nC751A3WtCXeaG/3XeeV3AxWULt0D5mIygF
	Sb/BJ/KR2uBkbJ2krt63u+mK2oxLM/H6c8W8kzakP2IkQbBpofoWHYODPuP67v+Q
	iuTtuX4VM2z6cuAx/ll19nG8AnwbAx/vZGCUTNVSsNZSzL+Ua+KoPHbW1Fri7OWE
	pwp6bujSViomLh2sPbsCVoW1v9XOK8FXkpPsOvasyohHeZk3ppXmCVXr5kxz7WOb
	h4MomcRjXuLHnu6dLXov6SWc5dA6wEdCvLJNc7ijud7dH15VMcRM4s5pWiBcoemF
	g==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010052.outbound.protection.outlook.com [52.101.193.52])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxaj66y-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 13:29:07 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e5nyi74tjlAUcGuVKoTYRon6Moo9vlj0/RPc3PtlbPwKWWeZMU8/VTGbxy3VQYm6pyyD1W2br6UyMoi34Zb70cxS5nKkVItJXQiTNn/+IM9N4ZHs5kTn1gVVNTafXqTADIOOndFjGfMKCwKBkriOTTNwPRFw/uAvTmO69ssiujVtgje3AXVBRTkouHBa4AlWYRsek7KUzvs0njzGoDBXXFR1Of1JnvmfgLiMV1JxKfkDmvGrzdfYvQ28DsnJZn2R0saY29nuYVcWvODnR0Rvt74+f0KALBjIhdLEnT+S0FDMkUBUhdctTqpPuczmPleT36EMVSV6Xs5NI/5+Q6l3Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Myz5uZX4bj8X/wWn/3wPxxcd8C7XpIn8Rc8c6djDTsE=;
 b=IoV8IEyFznQRCJf2TCWsbhN5ch1PZ8u7lB7ylAKKl/pdZFQtUgf/8w5xN0dT3TmUMyJTzJBvu+MNloNHgfuQ6MYcA6P9gn1edeB1w3H1fxCn0/KOWNtLwOoL199AcKsoSRwelhQ8i4dExUG6GsXN5kXpAcMF7y1IdlqkN8dXHH7+/tPoxJ8BcEFOSzFQdCPl5An64KFDBAX+5joryDQ8tn/7HVZ9WcQbdH+lB5yIp2CUUmOJ+U2YBYOvh9wskxyJESNGEsOHQlyFYV+db4iJzO7sQ8YC9VHv3KKQbtx8hvhxIb2Y7bpvKAlHHkeey4Uc2m+W0dVu2esJCNorLRFvwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:29:03 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:29:03 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 11 Sep 2026 18:25:40 +0100
Subject: [PATCH v4 05/10] dmaengine: qcom: gpi: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-dmaengine-support-wider-dma-masks-v4-5-72b8fd4cc78e@analog.com>
References: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
In-Reply-To: <20260911-dmaengine-support-wider-dma-masks-v4-0-72b8fd4cc78e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789147798; l=1660;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=K9CJIv6gWqA4R9j+4edOp8Q8yJcduc93BBDhknJylU0=;
 b=z5+O4fkf422lok7F0dm92cdN9JDhA7UyIbnX+9arjatUhj4Y8kE8V0wBLMNBIpT4+mxEknJ4e
 ebNSx4IDsfzCxTJAHJrshJXvdUE3X9yVAHadUrgAEaGohBdkaP4xzKY
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0213.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:56::18) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH2PR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 87262a7a-8c2b-4b4a-7134-08df102a2c3b
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
 B4jG6aFfxdjy+UYHpn6IX1OAQAHX/E4SOTC4KGliFoQPSCiSkgS9nexTkcjDTswqzhQPgKb6GN5vCm/x6In7RmnCLeR0lgYzN4g8nhklevTC5+Tv4RwIFaq5k7whEKSHJt07Zy44x+MOf3Z54u6UcOMzgoo5hjO+TrdC75vMY3nB6BNk15T7B73u2Bca2FT+p9aGHk6YsC7U7XN20UOaDoHPawMh/UirowpdWCVMKdyJGwkpUEL7aEmFy4YH8cgx0+5peDf313Vx9/fE8N91e2YFOZ+F1py5ccbxjcPWhbPLfOLXgwR0qJf8De0HK4b51blxyhc3YUz9ujWM6fESZ0HCfrJRzhHaRa8BIO4XWb1n3Z4PiMUKhJx3rWdICLIXlDDOwVJHLeBFgGdRdopeClmTbH8pGQticc4KA9uzFXeN23mDB3cHznqDoEEgSdASCnLI+h4ALjn9wLi6oP8nO2Z1wnt9PUoOTsWnRUsRZBWVqc2qa0+j1gbnrTwoFtmAFRM9W4kxTpOrTBbexCEPPBkt5ijW7N8xOTz9eeYE6yZxnS9Zv3vutAAh0UD54OAzOWvyjgIM0sYj/YervdL7sDG0h85XQ2zEYc/etKhvJdTIw41tg+50LJf5wdXrl3DGQNCWBPTNd4zjOCBVz7coffOwxHSGr/fSMxtXseiGmjU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VmVWWWVxN1o5RmJCYndtRlg4TFNXNXVUMjBzM21FNjN4YWlmWTNzT1MzYWhI?=
 =?utf-8?B?MzJCUjhrNEZJVi9tOUxLT2xBYlhqcWJpY3BBanFPNWVBa3BWZUlyMTRUZ1dW?=
 =?utf-8?B?QVZaTDZOcTB5UE1SNU92TGFCT2RvekhndE1SK2RSdzlubi94SUdRVGw2Wk5q?=
 =?utf-8?B?MFlqSXdsNDhudHRScTJhc3R6eWpBdWZWRGVQWWNTK0R1VzhXYnNHVGREL3Bk?=
 =?utf-8?B?cnJNeGsxdzRyRDFhSFJZMzEwWjNucEtNNDFuUXpzcDV5WUg2eXl0TXdoRTN0?=
 =?utf-8?B?V0NNd0VNRWNmaC9rWUgxMFpCWWV2QXROWW1jUzZLZm9qYUl0aWZHV2dXaENE?=
 =?utf-8?B?K04rNUt5ODM0SUVRaUlmQmtnY0hQa2NBZlp1OVdDdlRmYit6d1lkYythM09T?=
 =?utf-8?B?cTZsTmhRdWhNaVVuTXNVSklieGw4UDFzdGNyV25YbXFLOHpXc1VvNHI5ekpJ?=
 =?utf-8?B?ZkFSaEV5ODVNSms0K0t4TVVjanpXcXp5WDZzZUc2OWt0ZTErRyszNEh5K3Nk?=
 =?utf-8?B?S2V2U1BqalRWeEJUV1NCck12c2VFNnA3dlJoK2xUL1BtQXY2VjJwOHRvT01v?=
 =?utf-8?B?WG90N2RoYmtGc09SNTZ1VHpkVnBEL1NtVTUvdDlLakxvWEU4N3AyaWZpdllX?=
 =?utf-8?B?Q0ZnRnU1UXJIWFV4MzczTExZMVA4YlRIUG94cS8wSkVFWXVuMytZS0VhNGkv?=
 =?utf-8?B?TVdDUlhyY0ZHcjU3LzJyNUlidVBIRm5wQkhtVlZ1L0lnL01tUXMzSUcyS3dR?=
 =?utf-8?B?ZnlJNlVkRU53ai8ydVJKMWJsdHVpckppK1JLRzJwbEpDOExLbHV4ai9oU096?=
 =?utf-8?B?QkNHek1OdkZsZWJweWIyalI2eHdsMzUwaGdxTGNYUW94dFRCL29Sem5ZWmky?=
 =?utf-8?B?N016dnR1cWxoVFE5VXZBTDZTNzZaY004M1NrOTZvNkZkd1J5djgvTkRCMTIw?=
 =?utf-8?B?R0dwUXlUakZQd2gzNE9RemdqZlFTcGNDZ1pleXVGV05HVEllN283QXpLOEZo?=
 =?utf-8?B?RHM2OU5BWHZRWlBHcVFrVXVzYVZFWS95Wm1rTE4zZDlXVVpWRTJHK3pESDhk?=
 =?utf-8?B?dXQvci9odGMrNDA5TlpOczRGTG1DbUJib1lvbjBhSEJpQU4xb2ZtZmxnRDBk?=
 =?utf-8?B?MENtOFNvZXNyYjNDMzRhRjJJUTNBOVQ1V1ZGRVpJNkxTSDFwU0tJN2ZiMkVz?=
 =?utf-8?B?UXlUc2M3L3gxUEVpUlp0bFFWUzkyWmpxK2wxM29TVzFpbk5PZExLcHIzRVBp?=
 =?utf-8?B?Q2JBcEJHcW9NN2RwZEc0WmNtUzBRS0Q0UU1wMXljSHgvSFZyMGN4d1JQTFd5?=
 =?utf-8?B?MFNqR2YzeFgzZkFXeVpZZTJ5eHRrZGw0ekZLVkVwTFBCL1ZTQUxTS0pOSUo4?=
 =?utf-8?B?YkJWNWQvZUpWbVJNeHBtbmJBYlJEaDJNbDlzS3VxNytFWTV0WXlSbGRhSnJo?=
 =?utf-8?B?b2J4aU9wRnRwNDhVVkRpMHNuUS9xYmtXdi9qZXNoY1lRYzVIajBLOWlxU3ZG?=
 =?utf-8?B?NkZtaFNTVDcrZmQwcXVxMGoyZWMwQ1hVNEZHaXczZ2FCOFphMFJqYnd1ZVd0?=
 =?utf-8?B?Snh6VVFNeThFZEV1NzNWV2FnUGtxRW5hbDh3QzV0SXRWb3g1ZkNUUkV4V3V3?=
 =?utf-8?B?Nzd1ZzQ1WG1rZ0dlK1lJL08rRzdJR0g3YkswR2FZbnFVL21WOXJWU05LSURu?=
 =?utf-8?B?WGFmTVVuamp1ZlhzZWlaaHNETzV5aFdRRG8vWDFvQXEyZTdWRk5ibkpwamNL?=
 =?utf-8?B?SHluVDZsRjdYL1VDS3NjY3BqVzA5YW5qTHBsSTdENlVmNUg0TUFTRkZmN0E5?=
 =?utf-8?B?VUF2K2dWSXFBaHBtTWhLNG9xOFM1VWovSHpvSG4vTmFBNWtTQms2OTh0dDM4?=
 =?utf-8?B?djkxUVJnT3lnbElFSDI5RWV1RGloWWFqNCtpZG5hMXpjWUI2S3lpcEQ4YXda?=
 =?utf-8?B?eEMvZGJqdW1Yb2kvemU4WkM4aUVsUzlCcFZ6QmJnV28xQktHY2FxaisveGdq?=
 =?utf-8?B?azNaNW5XWlRkVjYwcjZhR1lUcXorV3pHYy90Z1ZvQXdFbDBwcEhqV0xrUzA4?=
 =?utf-8?B?YURMakhEWnlDc3RYbVBRQ2MzYW0zQlR0WVlnRW1UdGQyUGhUSFk0d1dQNXZp?=
 =?utf-8?B?MG1sUHdRcS84ajlseUx0UENzaTdINVlwNFgwOGw1VDJWSWJTNDl1K0NhQ2R6?=
 =?utf-8?B?aCtaUEh0VUNkbFZOWk1SVHY1c05EM25xSkVlaFJ1ZnNPWTRxb2RzR2hLeW05?=
 =?utf-8?B?MFBXLy9BTVBUNGo0Q2Z3UWZvUC9nSEtWYXp6dHZocjhxZzNtREhkdURSdG1a?=
 =?utf-8?B?WDZHczVqZGRiYWRFL3hZZVA0K0twaXhmUkFxSk9CazM0amFjNm5kZz09?=
X-Exchange-RoutingPolicyChecked:
	QShNoSCOovg9fatbc3M4uhz2JgG8yOtFgMVfc8ni2DrEJVEUcftS6f7HbuVwhIvE3xbxwt3/BtVGIUxPt2OiIBZB+Q+Xg7UNHldOJv+pDLB1c5E3n20C76qVmOSEcLny056U8J3o1TP3xHEfP728ME8ESG6QHQyhBBKo3VldoJvkcYKm40M9gfui/J2U7T37ARU4Hj25ymQvm/lxsGyXbZ6q1p+olbUXpLDgSxYq6CAKcxRgrOEgkKPvZ6JYwRKna+W2o30CO6ctmJBBAZXUnK5h7C7KxDeaDN5kpNG5HfVfdaXc1F0xeyxNS0t9xhzWz4FPkrjOie7v+oRsbT/lwA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87262a7a-8c2b-4b4a-7134-08df102a2c3b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:29:03.0117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUBqo1mtqXAEymAL2V8xc/oRj+yBh2I50o079aHxmOOoQyc+W9qwxh4DOfqj0S8dNkrxobXsdpBFLPRUPJFV7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfXyo+8uAk0AF+Z
 ghqtlMyKjmZx3dhPdmuv04wkgcK6TL08uL4Z1WArDwjySlZOrsilq8SlduiBta48LiK48RvJ4+7
 +s3tOujBmcaGyPo53nsYulnccMvubXSt4zsvvmAyiJ9Y1fsZFa+O
X-Authority-Analysis: v=2.4 cv=Ao17T+9P c=1 sm=1 tr=0 ts=6aa43a63 cx=c_pps
 a=N8fQrVaeAljVkTo8kKJ49A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=11eJKpf74FRv4loUduQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: Hh4BlkHbHMML-AHNt4Y56M-pDIOSfEDW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX2dB0FcES4yKo
 VvUMAEFyB8vHgosGeI3dT2ZJxwQXq3CkhDGvDTt1jwV7rLs8dU1xeXQsk6RCqzEZvlbOqO4tMqX
 gxIKpcu9NS7am9US05isJLUqF56sEeEvBJlkDlqswkKo0JktGiDw216TFd1kzUYZbGXigIzlLpA
 dbBHrDFDrq6DN2SR4z/P2zcYtvHKwwzYMQPtiSfU32HTtotKsIuz3mdhJhphb5kbjri8alfXETf
 NuLYCy6SF5knzn9XZIM7/yUzr2oyENI484OF57WeXX2DUIUL0sSqyBvTe9ndeTKIrFPxGvIvt9F
 Q+mSKxvRMBMUu8HC7S1sTJ0hmVo92tg67WvnC4tjEVultAgXcyfsf+mTn9mwwr5rj4Wnqt2kqg0
 NF92lFftqe5cIORPHG9MY1u7Zy1JDuWFTpt2vxqDRLU8TdbfawHb4clGthq/o/rfTHsWxGp9eW9
 BdmPNiVx52UOswKUcuQ==
X-Proofpoint-ORIG-GUID: Hh4BlkHbHMML-AHNt4Y56M-pDIOSfEDW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110244

Advertise the single supported source and destination bus width through
the new dma_bus_width_set() helper
instead of assigning the legacy u32 fields directly.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/qcom/gpi.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/qcom/gpi.c b/drivers/dma/qcom/gpi.c
index a5055a6273af..3a35bf4c3397 100644
--- a/drivers/dma/qcom/gpi.c
+++ b/drivers/dma/qcom/gpi.c
@@ -7,6 +7,7 @@
 #include <dt-bindings/dma/qcom-gpi.h>
 #include <linux/bitfield.h>
 #include <linux/dma-mapping.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/module.h>
 #include <linux/of_dma.h>
@@ -2265,8 +2266,15 @@ static int gpi_probe(struct platform_device *pdev)
 	/* configure dmaengine apis */
 	gpi_dev->dma_device.directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	gpi_dev->dma_device.residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
-	gpi_dev->dma_device.src_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
-	gpi_dev->dma_device.dst_addr_widths = DMA_SLAVE_BUSWIDTH_8_BYTES;
+	ret = dma_bus_width_set(gpi_dev->dma_device.src_bus_widths,
+				DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
+
+	ret = dma_bus_width_set(gpi_dev->dma_device.dst_bus_widths,
+				DMA_SLAVE_BUSWIDTH_8_BYTES);
+	if (ret)
+		return ret;
 	gpi_dev->dma_device.device_alloc_chan_resources = gpi_alloc_chan_resources;
 	gpi_dev->dma_device.device_free_chan_resources = gpi_free_chan_resources;
 	gpi_dev->dma_device.device_tx_status = dma_cookie_status;

-- 
2.55.0

