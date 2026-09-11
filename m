Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7E33E0C4F;
	Fri, 11 Sep 2026 17:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147888; cv=fail; b=hwoGCS2HS/zvhb5MMx7TCrPsmWz+pwLxrxgSpQA7zDVia1gT360UoVf0iXJRxcFRRwE6sc/2kslsGb23XRBX7mXNvM3I1K0FHNVmMZ3uH+b7sC78nBgQrMw183hzy4SAgCURBqk5SRaYMWIBEH9lMZg8n4NcINd5+q39rLTyAGs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147888; c=relaxed/simple;
	bh=9s2xSKUmjvpnSiCLGiGlOkijdsG0TcrAchxhIjBwN9M=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PUiHBLIaVKoKCB6cDE3n42zykDoCqIpTZ1NeMzqGXEVisjw+QTAPwaekWEJCBA2jOlXYqhPMf++xj0akd+ZyVtOWr2f1OhmkrKL3ppv/yKuuEvUjmCPiXcl6TQGJTVaN/PTU9mJI0wybta3DAk2vAzNhbjv5inGb21d23wTh3AY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Tp3MkZJp; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Tp3MkZJp"
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEir203945920;
	Fri, 11 Sep 2026 13:29:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=1MG6n
	wmrIdRIkADIv0DMlHSkRz46fNZ1RRkqgfB15rU=; b=Tp3MkZJpCwm9XlYLfBFlc
	erDy5U5d1uya2ulFn6u8FZup1ePFSJc5cOW/5+91iLZOsQUVJjmgT5ei9RmfqZkW
	ZYL3RxpJeK4TWl1Kr2X4RtGaL/jrPluyXh4upuVcvn8kh9s1Z8Di9IwDjW5uuBT+
	WJp547+HvIHj3M5i5KlooOAhawGfeq3f7yBafJF4q+jq7nOuQj/yfP5L9Wu8Chcg
	5XojiRtpNrj34hCjCMQoldJRjinWI87tjmHrpFoTExz94LfnGTo+C1Q6sZL17e7A
	rMbHTx5FHh2QhgwP2vjX5ZBXqULROtGwRuZqXerVMCyrmGeIKYGCdU3A/EHyjYeY
	w==
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011056.outbound.protection.outlook.com [52.101.52.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gmeeg9j7a-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 13:29:13 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ulGKGqJj9jYlD4gWFBet3AXQOaUSAuV2StfKNmt5x2xSND7TqWfUI+L55QNfMmqBFMTz7FEy6oyq5zNrXvql7myIesRaPl2ufPjp39oO44xI3cVv7R3rsq0BG3QdFdLF1rNzuc8GOuRjA4fDPWMO0pfFaIFvjZRIWGcjEl81En2LGlswp3dy/mB+1wuaAyWEl3uRQrNA5nqj0e2PfxSQhOz4QU4SI6PZruZrBPr1K+JLj+ucvJUjWil/BbXQ8XqZkxsLZwVLuG1lV+RIURIJEfGaZQSg2n7mJMb4JT3U+0pe8ldQWhzGEhtT0mmYSCmPfEf8rd4E8JaqrVOQqmjuYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1MG6nwmrIdRIkADIv0DMlHSkRz46fNZ1RRkqgfB15rU=;
 b=HNrbzZgYZyHkjgi0ifGy69TT9YCzo/ATrFst0031eImKDtSgmE4jvJHcAyC5dgB0n5x2zHjNK6mM7r9G577AE4nlkJam9EnD+7oSVB+LpHN0x0FkaUZc+AWRt7qFqzkDxsnjBgNVow8BWlFiD+U1BDkuTvK7DW6E7B/qMdJPHglfMfIiU/EqxE7b3crgNhdQQIH/FvtB0N5nqRzVsOPPWo72k9sVTCRYJHSJiMOeyvqojF3xLas9X3wdypL4y/Uq5l0oMu0K18d7N7AYzuoEzeSgCCSTyjm8CjB/vl79TkIEbXyyegfR1DrA+9/qHy7RTAV3DUxMM23pPse72NoaqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by LV2PR03MB293829.namprd03.prod.outlook.com (2603:10b6:408:3af::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:29:10 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:29:10 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 11 Sep 2026 18:25:42 +0100
Subject: [PATCH v4 07/10] iio: buffer-dmaengine: Use dma_slave_caps bus
 width accessors
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-dmaengine-support-wider-dma-masks-v4-7-72b8fd4cc78e@analog.com>
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
        Frank Li <Frank.Li@nxp.com>,
        Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789147798; l=1872;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=9s2xSKUmjvpnSiCLGiGlOkijdsG0TcrAchxhIjBwN9M=;
 b=Ss4aIRFpKgkCpNjuTcmF927RcE07VdD2D5Ds4Gj+R68sYWqPYRnU413WoW4KHJeW3VxCa318U
 Q6nov5CsQEpCKu+Kk/WzwwFQX5Lhm0CnSFvpIFSrwfXIKJhsH80buF4
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|LV2PR03MB293829:EE_
X-MS-Office365-Filtering-Correlation-Id: 421faddb-c584-476d-a0c1-08df102a3100
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|10067099003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
 E0G8MBatbaEIeAZaprCIYoZbaz9bzRyvY/AygUBa8WvavPJlAMjammU14VSIILbPgQUHTK5xMt2cyPioWKKPOLsKf5DTI07lZuXLL9YtVuZMdVvvESSGwYm0ASelQXx2KTXblYxS/WqepLA4NFZ+szLBn0cpjyH/eca0wpnzd6I3+ie31r/UcLrA7WFehZ5g2IWayTMSDCXSXN+62KgQn96oRvibAqCUTf91TGpkYXNoR2sgVNjKjBebhoumlbBvSuqKkBbjw0fZPJQpgnuNkxysQo/bnGLAl7celsJxziQ/bPAotl+xGg0ztI93bTYBIeTsJB/54/7BIrwED/hmtQlaqYaV3k4rTJon+F2P3cRESdwbis3ibWouPX5aDXdICziq89xzH8tZSHN2/bomB6quomrNLhPFeIvdjvdm7kxBsiGzJZMBdaj9gh5CD3kMIgG7P1D6mVlU3NkEdlR/gEtfHaeO56JpECfBiN//dxWCMD8Vsy3ZBDz9S5IFGi91WLthErfRAlaFXvjaAJaNlKXLiPE4eAhmtZpvSFNPc2mA8ud+9EQBzPlu0XQ9TUPACclNizvoNLdJHeSXidtK7jK2ZFxE6sWxQSmaFFip964QkfAIEPy9wWYWECHhuxVpM1wyDnRuvKQ75R8XsjmCa7FQAsDvy+LahLiUpj5OGeg=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(10067099003)(22082099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?ZFZiK2N5dWpqY2FVcVllcTlCeXFxd2xCUVU0VHZXcTFJdVBUblBIWUVrRmpy?=
 =?utf-8?B?bmVDQ1kzMHNBRCtBSGlIQlBub2NsSUtzTDJrOGZCQzZ0SldIQzU0LzdkUVVS?=
 =?utf-8?B?M2lpTUsxTTdwL3hyajNrUXhvbXVMUzFFMzRKV2JXamRpNDNsL1J2ekxIZW5t?=
 =?utf-8?B?T1krTFRsYjJoVE1iU1pSSE9oSFRsWFRKRGJVZWRlSEZLVXFDeDdKNmFERkw5?=
 =?utf-8?B?bTYyYWZOZHpFaHNURlNjOXl6dzdQbUdIUktNWUZVQmdRVk9zeWNiZEQrUVdq?=
 =?utf-8?B?QnZmamc2MlRCbzJIRGtQRG01b0dnTXhGdXFscVFRUUpUUEtrZEMwaE5iWTlw?=
 =?utf-8?B?V1p1RUY2bS9HRU5ZQi9GMGxkVG5tOGpYRS9tWjI0UUFQb3VlcXlOR1BGUTBT?=
 =?utf-8?B?WUI0Q2IxekUzZkl1QTNweVZTcUpXc2ZncWs2dHlqQ0FpSlFxME44SWd6WVVZ?=
 =?utf-8?B?a0NkWjIxRDA5ZFpBTHdabitTSEJyT1RUa2dETG5CYkdlL3BvSUhrSGt5Z094?=
 =?utf-8?B?V1pWUVB4UWdMOVBXMzBUMm1ZZGFTSVlVYUlIcEwyL3MyVGg3c2x5U2dqZXVE?=
 =?utf-8?B?aVpsU1IrUUJwaTVrNHJCMXZwdjFLTWM0Q3VoWjBQUHhVT3NGVVdjTE0wVlZB?=
 =?utf-8?B?aVVuampvMVcxaEl2UjcrNXR1U1NyM0pML2tzWGYvbHdyaFQySmhwSHcxYlhl?=
 =?utf-8?B?cHFmOTRjU1EwakVnQnJ0Y0phL1RjYXZGS1ZoN3V3QVExZS90REJqdHdnK2tr?=
 =?utf-8?B?dmZPaC8yOW93dndCRnkvWHJ4TVYzQ2NtYlNPUzE5TU5CRUVrRUlqdnE0aUlR?=
 =?utf-8?B?am9VcTRnckdEUGlpWmsyS2JPVEZaWVE4LzhGUlNXM3BtdVZxK3FHYk42N1Zy?=
 =?utf-8?B?WjVTK2lEeXY3aVg3ZXlwNW1CWXMrcHJFNzBZeUU4SzJTTVVNNlBHa2YvZUZZ?=
 =?utf-8?B?RGhFV0R0TlQyYW9Ga292WEd4NEt6NWRkN05BTXlVbEFyYS9VKzVDOGJFcEdT?=
 =?utf-8?B?aENFb0pCbStIelU1N0lodGx2dmlUQ1hqNWg3TlY0U2pQU1ROUGZqVUgyR1k3?=
 =?utf-8?B?b1NVbU5yZ3ZtUUdTOTVETjBIYTB4eTVWdGw0WkNjU0xRUkxGQWI5NW5TTUk1?=
 =?utf-8?B?NjBFaVdPQmFiWUgreFppSlRoZGNUb3NzQmp3NUg1UnpwK083Y2w2dTZDODVK?=
 =?utf-8?B?VHB1WGZKbi9kQkw1MmdRa25GcjF0TGlvazJQQXhIM1dnNGFHRWJNMVhpaFZi?=
 =?utf-8?B?ajRTdit5V09Ja0ZzdW93TkZCc2NnMERDbFlxRnljVXlXVnVFaHBKTlVmTWtm?=
 =?utf-8?B?OWZlVjFWL0E3eFduUTQrNUZoNDhsMkllVkhyMzRySktBcEZCREdJOUhYRm5F?=
 =?utf-8?B?MFdXcVJNb1FyTlliUWRMWDdqdGdFQTMxbVcyZS9nOFlOa3BwdGhqRVArZWJr?=
 =?utf-8?B?czJ2S21uZkg2ZnRvYWVvMkpZQXBjUThRdWl4TFJsRnRzUkxqaXR3WG4yZU5t?=
 =?utf-8?B?TFBuNE00cFF5VzA3OEU0bEZKbm5UZy9tRU5CNGNqZTJXbGNlSHR0cmppQlY3?=
 =?utf-8?B?NEtZcUx1UlhPdVNUeUovUlQ0QUtiU3JpSU1TaDlCSnBBV1h5ZElSSVZSZ1dx?=
 =?utf-8?B?V0d2MnUvQUZNUUJJSkwxckt0ZEsrTVZKbVZYNTVPNW13MDZwaWlxbmJzcEp2?=
 =?utf-8?B?b1lwZUZNYmNsMGRDNysvemJIanVuZWpIa1ZmRGZFbjRBS2RwUmhCb3l2T3NN?=
 =?utf-8?B?Nmp5VG0vTTBaTUUrWVdyVzM4Y3paU1JiMUsvL2xLcXJtcWIwZzNPRG12ZitO?=
 =?utf-8?B?M0piS0hLNkYxMlVLVUFVWCt6RzJkaXAzWFVEVXdaK210UVhkRE96VGI3K3V6?=
 =?utf-8?B?bEJpUUthblpBbUVHSHNGSkFJYkdvZWsxemlvclpoWkh5NDBGcmpmS01ZSThi?=
 =?utf-8?B?bStham52WEpKWEZxRll6c2JYdjJuMWluaVlCbGg2bVFJMTdQbDlRaDhzSGVS?=
 =?utf-8?B?ZVJIZmFtdjRkYjNBbkdvYXErZk1IWHdZK1JvNWpVUEp3QnIvTzlXVVBnWmJz?=
 =?utf-8?B?aDFXL2dDZXJXN0JaQVB2NVFNWTUwWGsyS3hvVU1LZXN1VGQxeDVsK2xhZHN6?=
 =?utf-8?B?dk1YdDBoUVY2UkFhSVIyc3RpVEFJQ2NwaFNXSnhQWXVSNnF1Ukh6R0tTR0Mz?=
 =?utf-8?B?VWI5QTA1aWc3c1o3czByWk1sYU12VHZFcFhmUzlsSjhXaW4vbW1JU2lQNlBZ?=
 =?utf-8?B?YnRFbjRJRWxNUlQvK3BlQW1vMzExYmNoOTNITE5OSGpFL3E0dkRvVHQ4OWhI?=
 =?utf-8?B?cDFvT0pyY3owQWlCSzNqb3hrZ2Q1UzRDeFU5SVVtUkcwMmdUQ0YvZz09?=
X-Exchange-RoutingPolicyChecked:
	GU3eXdhPBAjWJoiekMnP02lQJvxXQpODCUkKk2iaq+c0G+a+r6h1MxpPtoUqSqF/s8ajHGjNjCBlEgo6kpNoxtz81rL5eeFhskFhho2Ps8pS4NFjop61GulF6p0dkYeFLEqZtrgrvJoXTd5nEW7aO0uf/NlcKWdjgd9J1BUmmYbBYtJ6H/gjRbEyk7objaEth8U3s51kE086ML8HgydjqVi8kVDzQy/E9XrNBFiVDQJnSVxXk6sGqjfMwd99OMKfAiKBwyizSeB7HGsBdIA9/6QTHBPS0PK8syEUUDoqQHk7i5RaLFVzP3TNIRh0hBZf0dR/l+gOVZKCBkNQghM6yg==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 421faddb-c584-476d-a0c1-08df102a3100
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:29:10.8136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E+GVP/JuABBh9XULo3oCY7hJEGhgAQZIc2yhRX1xkfV+5oHZ+iPieXhOpt/3L921bQypWgUG1tXhl9bSU8e9Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR03MB293829
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX2DSJizaav5GQ
 9NwzpiQx/ay2HJJokRDKblZmWAsUcfkadKHpvcVBWuw+a6Qp9UMMxpUG1q4HivRf/PzHgoM44yi
 U/8fjT9YS4LAHl+3jaVSxxMOyplcjad6M+08p73mmHJduMUcdYN1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX1+Bj+fVbY0qd
 Fq4LGSdjEIFCrIe021PW1TDZUayVUzxHUUICBE5i97+hZwmbGopQqtgSMI4t5oJkTnSnu5K4aGS
 YxwBj/wNtYPSi1S+nmw0jl3SU/lxe8ad0/AqW1cWQ4tc6/XHu54NZzGqbfiGOL51JM47du6oDkI
 QaXi0+hPvTyCcDgDKPqgDZZdHmB2ck3rw+S1XO87iMxTEQIu1tQ8eofegUNWpJKhRzXtvDCf8HU
 HkHzG1VtZpOP3khAGhXk/uwUDnUG3cAcmBvtKboSXBHdNqUZh951Ft6Xx9Cs0AY8nWGCA5DaWLN
 iHu/cDKZJNdFg7hw7afXTHdo6yDYfWsJ9HKupqpE16lgjrWlWZxTIxMLZ6J/RwALOg9gn0DgCkD
 VX4uCcjn7CYNQwt9vmRWXXAZzUKaswrRepEo0i4oFCJ9DCU3T34whvWxEIEpF2bMEIM4TacRO9T
 0RIImkGdn2xsz+Yg8SA==
X-Proofpoint-GUID: 8SCtHunbAwPqcAw3hHxX1ZGYZarQelM_
X-Proofpoint-ORIG-GUID: 8SCtHunbAwPqcAw3hHxX1ZGYZarQelM_
X-Authority-Analysis: v=2.4 cv=HubjiETS c=1 sm=1 tr=0 ts=6aa43a69 cx=c_pps
 a=oQiTq6cBShE1BE+bdGc2Dw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=8AirrxEcAAAA:8 a=EUspDBNiAAAA:8 a=gAnH3GRIAAAA:8 a=PlQVE8PmvpCE9iZECF8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 suspectscore=0 malwarescore=0 adultscore=0
 phishscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110244

Query the minimum supported source and destination bus widths through
the new dma_bus_width_min() helper rather than decoding the raw legacy
u32 width masks. This keeps the buffer working
with DMA controllers that advertise bus widths via the new bitmap
representation.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
index 98acce909854..e1aea691b732 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -7,6 +7,7 @@
 #include <linux/slab.h>
 #include <linux/kernel.h>
 #include <linux/cleanup.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
 #include <linux/spinlock.h>
@@ -229,14 +230,13 @@ static struct iio_buffer *iio_dmaengine_buffer_alloc(struct dma_chan *chan)
 		return ERR_PTR(-ENOMEM);
 
 	/* Needs to be aligned to the maximum of the minimums */
-	if (caps.src_addr_widths)
-		src_width = __ffs(caps.src_addr_widths);
-	else
-		src_width = 1;
-	if (caps.dst_addr_widths)
-		dest_width = __ffs(caps.dst_addr_widths);
-	else
-		dest_width = 1;
+	src_width = dma_bus_width_min(caps.src_bus_widths);
+	if (src_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		src_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+	dest_width = dma_bus_width_min(caps.dst_bus_widths);
+	if (dest_width == DMA_SLAVE_BUSWIDTH_UNDEFINED)
+		dest_width = DMA_SLAVE_BUSWIDTH_1_BYTE;
+
 	width = max(src_width, dest_width);
 
 	INIT_LIST_HEAD(&dmaengine_buffer->active);

-- 
2.55.0

