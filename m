Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D244AA030;
	Fri, 11 Sep 2026 17:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789147799; cv=fail; b=i3srMoC+6agldWcZDGVOFxZ5Git/ifTBCSMRa9ebLc2iukCqk+melvPLM9MgEiuy78Ug5zdP1ENLprbvQyhxyPnHj+xJYsE02UIt74k07NZoCY6XE+qeQ/JJVehUtIJFGbX8lfyts8tGLGFMv+24h1AiZHnD3ZYPBMeNQOXNx2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789147799; c=relaxed/simple;
	bh=L3zTWoXqw5a5O5elg45zji72d5Z+MGFOr1XPYeUs5sQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=iZAfjc0WbmD8M+1t6TL0vUTm76FibCWqrphVTLEouAJhDiFdY7kGwizUiXwtaiEreDYfNTc6NVfXhVhZTa1kLxWxl8cjCQ9XSSKuckkKT9UMAb+HWnTCLAaAIcb77Sd8HPj+viAWdAla5gK79uyz0cv6bqym0t1cORUvnZyoJTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nhvAyABj; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nhvAyABj"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BEj96r2838484;
	Fri, 11 Sep 2026 13:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=KDDlD
	NpLMuKV4XAh2Dp6JCydXIqCfjFMue8NJHS97H0=; b=nhvAyABjZRMbM5t0ViV5v
	mSz3zPGkgWyhWB98+dPO0PaA9F9h3gfw8on1RQ3cEjS4e3QKLO05YYthS/lnOtiq
	mhccQ4llA2kSCuZaCf58yjwGGAjKC0RM3J8AZDisa0YE3dT+h68soM13J3cjrTtv
	t+P9+4QJ2W4jOKTxeOtGY93m2pFp3tK+cwVPZXEcSeRL4pn/MRQWJWcOYklI4185
	eKdaXEQ+zLoRtno1lWPPDYEVNrRDY3Pn2bhAHmW/3F0XTKKC5Nkw+Sw5fkXYXcZ2
	WTz35aExcNugfueV8m+PzqHDCOEDovHjv7YC690fq0nueTiRywmxaEO7bEPw+rrZ
	Q==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010002.outbound.protection.outlook.com [52.101.193.2])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxd26ux-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 13:29:18 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fPGwa+vvKL31Q7h7J3awZB1T1/5PA04D0MMczmZq5Wraw+y7zqPHpE+JL9974c14Pz6SB5t7+wEfqUz9oQPeNm9+onyN+8t1f7av/Ko/1PvqOv1QIIWm8d2QKCdJsCO+GiDMH/ezAAkav/6FYbU82BIMWpaYSxnJs7ePfQl+yOr0OimN+1Ku7l5lM0G65TeEzE0esd+cCvbxhbYfxw1DNFO3kDMQkc3EtnE4qQZGwxt/u3ExIlXiI68gZuZWWiQ+OxjzLEvBvhEdLPgZ35GiaGmXR29oBMeGhHnv9w3N7kd4VXwZRUSByWpT75sKLGyjo9AReNhRvZYzSUR+kYQXMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDDlDNpLMuKV4XAh2Dp6JCydXIqCfjFMue8NJHS97H0=;
 b=mD21eUryUlenyTr3Cgz90Y8Q2NOAoiWB0W/Tpel8kb624w4cKUTMXdZmUa6r+19h7W6m7r3fKKYHID45gG8n6oE3RLb3Wn8Zf8EUGZsuC0R6OadEhU92FmGqDt2vpdBzx/5tp4f9yTOjcPSRob3l4RpORAwn37wa70mLnQ3yb8DXoA04wCGbtyE49eqb2ILItvsMqCm5IrcCPWZVUzU+7/V1PYXHVjOIkMxIQ7vluNSZwwTIOzIZl389ndQCFTPPPK9fJ4ZmiCVZBczVKHAPefxI93gJLjme3Y8aljXCmPu26EV0I2HBD+3OmSa/flRRDz2cVkRYqhjK2tG7p/mlGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH2PR03MB8027.namprd03.prod.outlook.com (2603:10b6:610:280::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 17:29:14 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 17:29:14 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Fri, 11 Sep 2026 18:25:43 +0100
Subject: [PATCH v4 08/10] ALSA: pcm_dmaengine: Use dma_slave_caps bus width
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-dmaengine-support-wider-dma-masks-v4-8-72b8fd4cc78e@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789147798; l=2367;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=L3zTWoXqw5a5O5elg45zji72d5Z+MGFOr1XPYeUs5sQ=;
 b=WexmwxtRRICrMCsvBDW5+cZiZIhyh9+g6IcaG63e6amAp9zLbDuAeou9h2bMNQyiJMnVpY40w
 I0umw2ietNRAn2KdgV4dCW83BQJGJolT4RFdJw9WUL5oRPWBsFghEJ7
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0045.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:48::10) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH2PR03MB8027:EE_
X-MS-Office365-Filtering-Correlation-Id: 45858a28-5c29-4534-3ee3-08df102a3324
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|10067099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
 v9koXn6PtVIq3q4iRVOei6Yz49YOOiiEiEc3Lkm8ZJRxFbsAWM8v+yjF/h5jxtl4pswczeA+LGs1Mae3gobqkGPVoVwUnCD82KDyaP4QRAuk3nUCx/fk4kfRfG6ZQcCpK76mwYnHPj/BznUJreSLGPXWkcqk+PvUzAgqwBoJfO6JZbK0DgpMhWeSsMzGPk5xhhN8DlCu/qZH5xA1M/FmtO3yWtKCUjVA8KC+ULjP7h0hh4wGeuQbKj2rSvg+2novWSVWSOF4dfl7IQH672bswr3ItXlTenRAoEjRdMmT9VklWNHzygFLZzQXLQO5venraaA3e/7p4L1AqCTTDNteQDZBefEfa/7nYU4hbDoKBwe3xUNZfAiWZkfrKXvd00lknEVd2K0+BOcbxF+KxAOtLQJk/9eVIrMdTuzqw7AGA++fUz5H40pXhv/RJ5EjCUA9ejHjtja6PtaEEg7LW8rVdF1m6L2I0Fuy7JqdjQszVAPNVecmE75h1OvDX4CZN0W6F3nSErHHj4GXxsXJs7FCwN5yf0CYtjdnP2GDUVXhC6ezWJlJJSts4774Wio4RYrEHc5+DsZTDoAfGhawZN8l0aEpN/J73kJdALkV9bghSMW1wtQ3PjZ7Xr+mmWSUxksGWqcoKNjLeigI4+0RPunf78ktAC6WIhLwNmCmODkCRKI=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(10067099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y2NkS3BCVjdqRGZKUVhzazBDekpTaytDRU1nODZmR21kQmhsbGRZcVdHZW5W?=
 =?utf-8?B?QjZzOFY4anRHZC9IUGFORDgxdHBSSERUZzZEdkFneFZ5ZUZNcFJIeU1YcEV4?=
 =?utf-8?B?QzExRnd0QlV5YWo5Z01GQnRxYzBzZHlvMUpHaS83UHFveXZuS0hLL3lHY2ll?=
 =?utf-8?B?cFFSaTFjMHozNWhnNW1nb2hvZ2RuUVpkYjI3UkRGbis5NDBQaFZGVTgvOWZa?=
 =?utf-8?B?NGdWZUFybVVZV1BoUjI5T0ZheGh4Q1FBNnJ6SHQ2b3ZCRDkyelk2eGprY3Bp?=
 =?utf-8?B?S21oRGF4MlFiZ01PODh3dUd3NDFEZEtWVml4TFhGcmR0MUpFemxaSjBYYXNG?=
 =?utf-8?B?ZWdWTVNLemNSekF2eTVoRFFhTWo3Y1VqbEVhK1BVMWdydWtyaEMxY0xRU3hz?=
 =?utf-8?B?MUdjcXJ0QWYzV2tqS2NNemFFWERzbTdVYmxnRElYanRjZURockgyOTI0OXFG?=
 =?utf-8?B?Z0xSUFRMdmxESXJQWGVTZjd4UzJodk5WbHZVQWMxYThNb0F1R0dGeUphM3FV?=
 =?utf-8?B?SUdwM1lUUDM2NkIvblluaW9LVEFNRVZKdW1Nb1FzNFdNQVRydDZoVTVhL2Qr?=
 =?utf-8?B?RFNsQk8rMEpSZUR4VjdUSXR4citDWFBaQjAyMW5YN3kveTRTdzZnODJTZWdy?=
 =?utf-8?B?eTVzZzh4cTBxYUVhbm5mSjlUSWVXck41SFdoV0FLMmRiMHdxcmp4NWJrbldh?=
 =?utf-8?B?ck9vK0laZVNRUktLejJUazdhRm9GRFlkMkNlWEJFQkYwRVR1MzhaUEQzWDZL?=
 =?utf-8?B?RlJqbWliNk1hK1BINERoSEdOUHF5bHBiSEk5eWhtMzhjbjlMTllSTVZVaDBp?=
 =?utf-8?B?Zmt0RTR4SUVLRC9KeFpaZ21pVW84WVZpRERCWUkrTGw3TitybU9sSHE2THZY?=
 =?utf-8?B?c3B3cWdUYjloTk5TN08yOVlVSkxxMnpoQXh2S0poVC9sZk1TbWNnYk9hbDUv?=
 =?utf-8?B?UytybGI1bmJiSjVwY3VCYUUrZWcrMGhCNDJzbytSM3pMRmVvZ1lsUDdPTUtX?=
 =?utf-8?B?Q0NNakREamNZcE83ZFdGVStYOEhBVzcvU3lmZWFrZlZHRmppclRZYjZFM1VF?=
 =?utf-8?B?VFZHVzRQNGJlelNwZGs1R3J3cjVJZ0JGYUsxdDNPdjBWNVR6bmJTbm15M2wy?=
 =?utf-8?B?SFBlVTFIZXhtZ29EaXFuLy9QQllFY0VnVjFlS1pwbjhZSlpmbGJaWVpHdlQ2?=
 =?utf-8?B?bk91eVFqV210YUpWUFpaOGhmaWFJSUx1MEZNRm51WXcrYjZuMitYdm9VOXl3?=
 =?utf-8?B?MUhjVXdsWHhSZkJDYy9BN2gxZnFvVU9SbGNTaDlmUHpmVHk1ZHZ5UGtHUEtO?=
 =?utf-8?B?WXlmMFpIY1paVkxTRERYalowdDEvM0JENitrZ0w5TWkrbHhuaUJHUThtTkpN?=
 =?utf-8?B?WlA1aEtPTVFuQUZaSFNwRHdqbHdTVTBDUHZSVWNDZGhzejk1NW4xUno1Y1Fh?=
 =?utf-8?B?SjJVTGFvRkZOdkVLb2E3SDBUWEN6bGpZeWFwcllzaFRTL2JjNzdXdWYyLzdi?=
 =?utf-8?B?NHNuclpOV1pvUEF2cmxsRnc5ZVlNdGcreGFERDllcEpCSytabVVMZncxUXY0?=
 =?utf-8?B?TFZGWjM2S21pa0tOL2phN2pnZGhUdGxVY25mZXVJRmhLeWtQUmoySjNHWHhK?=
 =?utf-8?B?L1RBSDdVckVRTHpxT2pWTVF2elRmTzlCdDhxWm1ZVGxXeWtOQnZGb2E3Nkxa?=
 =?utf-8?B?aVJBOVRlYUlWZWFXZU1mSjBnOUFoZmNaVkxMMnB0M1M4ZTdyYk10TzBsMnFK?=
 =?utf-8?B?UjFZL1dyZkFjemZ6dmJ4LzdXd0FTUmxCZVphWnZ4cmNkem1IVTI3MFFRYWFQ?=
 =?utf-8?B?L2prVndMeWlzUE1hUjFkMXRmdWR3bW1QQWU1VVVlTlV4V3JBa0xZUUYvUDQx?=
 =?utf-8?B?ZWJDcmNXNHVkTXRGOUJOVVArZ0hycnEwUWNmVzlUSG4vRWhqaGVEZ0FWdlJw?=
 =?utf-8?B?WFpDZXF3WmRpUmowWmRlNlNINWV2V1ZXc2Y1TkxoYzVBZWFMU1luVDh0akNH?=
 =?utf-8?B?bVlJZFhnYXNEemJGTkVBVzBVSWpCeGZZVDhzc0NPRkQ2OEcyVWlyUElQcUll?=
 =?utf-8?B?SnQwTzR6NERGbFJHUWNiaEQvdFcwZjlOY2MrdUx2V2VJT3lacCtiUWtocmpa?=
 =?utf-8?B?OFFDLzFZMG1INHdUWWZhTHE0aDVHMUpsckdHajRPTzJ6WHliUk5lYW9rbUtS?=
 =?utf-8?B?b0R5aVNLUkxObFg3U1pjUE9KajZYUVMwM0pRZmNVS3BJUXNzZ0wvSFM4UE9Y?=
 =?utf-8?B?QWZ0dWFrbmlCVExsYnZPaFFySVQxYlpnd2szdnJIbXVPbDFqY3dFanpOczJM?=
 =?utf-8?B?OXZHRnJzYjljcEpVL2ZhblRCREx2dHo0bUNBQzk2WjFPSU41a1A4Zz09?=
X-Exchange-RoutingPolicyChecked:
	IStaPjFbEjyqLe5SUUmXgDnNK6REa3rmG5HmDK3NVbViRo18FF7GEPjlBWnhVtzZIDB/EanzB2oPhUz1jE5DB3vVbet35qLGQdfOfIDdGbxgT/KBgOtxpcsHYeKQwxsGJ7ZQqwnM/C5Jsr1Zm9hwcrXTSZCxH3sN2/6OoKvpKd6hDuxVwE3FpTD5mImJMbVx4P7qkPIriVHj5SJTVrGB4ESeB6i90JgsQfV5BzaptqIRRjfR1pQe5vO6uEg3xy3FDw9rxruTWmVEiPAOUAWNFyDM3kVswzM/CTS6wxdU4OxK9KFdjAJkXWSOyX/Ell9TU4VvsnpUVx/OnFsoCa0oUw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45858a28-5c29-4534-3ee3-08df102a3324
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 17:29:14.4360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /bfQie/Cxgoxpx9hiNBADqZZa8yOhNLbPv/Zt9XgH9l/GRFNkipGZxx3dF2nEBjh8og9Jle7g3M/7GDM9PpvzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR03MB8027
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX4xcOuGHjWlPj
 h0gcYJ+WqXRVtvc8cORpXYW/qz+lOxYNlDJp0lmNQ9Yab4ZDcvF3Tplh0qiRRr31CfUA/JWyEXq
 Q5cmFbGZnjfP3Xm40TNzqk5VPSB9bkAusXzi4bXX29ZYyyMFyRy+O0Ms0Er35bB/ZGk9u+S2HTN
 VaF4SoqUKg/OhjO4hgKD/9ZYr9kwTv3ZnrcqiBDcM1Z/YHI1duUvYOy7CWNRJGbY/jGX2yNzKuh
 STvxFBXNN1f4MU954WW+6SfjelXjOneOsArM8TZifpOxZ1+v8Jj+DS3GBekVjpsCLfVpNjPcacf
 7/UvN7oeBjV+MzkwKgObKxUGPl58aanlqirKmNBgK3wsn+mXHWhYWkBFpID0Z08K+Sve01YM5sH
 Ls9FnKpVMFpxqDZ2Mu1pgVm9j3PHmH/FsR9IJtUrXNcFPteM/AANSdYy6nj9/z1DFiVdtYzuFDr
 bfLO45y7QE02qFdGnZQ==
X-Authority-Analysis: v=2.4 cv=GoTXaU1C c=1 sm=1 tr=0 ts=6aa43a6e cx=c_pps
 a=NtDnjKqRhcbz7rYDj/0C3A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=RbNyKOt0vjK77hBBhwsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDI0NCBTYWx0ZWRfX/s43oxuRZKyy
 0trg91FbeiRelYBg/hXeIn+vAQxdvTX2ZxKLUqe1fL+3gucJ4ypyDacHe6fLlUbSgVdldaMW9EY
 1AuRwsmwxIJ9J7wB0k5dXDXNL9rWFHcTJV1mEaHtwjYgINABmwN0
X-Proofpoint-GUID: ZPoYXIDeZ-fHjtXSxhGW7I0HPMU_RHdF
X-Proofpoint-ORIG-GUID: ZPoYXIDeZ-fHjtXSxhGW7I0HPMU_RHdF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_05,2026-09-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 priorityscore=1501
 spamscore=0 clxscore=1015 impostorscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110244

Use the dma_slave_caps bus width helpers instead of reading the legacy
src_addr_widths and dst_addr_widths masks directly.

Keep the existing default assumption of 1, 2 and 4 byte widths when the
DMA channel does not report slave capabilities.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 sound/core/pcm_dmaengine.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 1306b04be171..2dbbdeae6c4c 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -11,6 +11,7 @@
  */
 #include <linux/module.h>
 #include <linux/init.h>
+#include <linux/dma/engine/widthmask.h>
 #include <linux/dmaengine.h>
 #include <linux/slab.h>
 #include <sound/pcm.h>
@@ -408,16 +409,24 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 	struct snd_pcm_hardware *hw,
 	struct dma_chan *chan)
 {
+	enum dma_slave_buswidth default_widths[] = {
+		DMA_SLAVE_BUSWIDTH_1_BYTE,
+		DMA_SLAVE_BUSWIDTH_2_BYTES,
+		DMA_SLAVE_BUSWIDTH_4_BYTES,
+	};
 	struct dma_slave_caps dma_caps;
-	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
-			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
-			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
+	dma_buswidth_mask_t bus_widths = {};
 	snd_pcm_format_t i;
 	int ret = 0;
 
 	if (!hw || !chan || !dma_data)
 		return -EINVAL;
 
+	ret = dma_bus_width_set_many(bus_widths, default_widths,
+				     ARRAY_SIZE(default_widths));
+	if (ret)
+		return ret;
+
 	ret = dma_get_slave_caps(chan, &dma_caps);
 	if (ret == 0) {
 		if (dma_caps.cmd_pause && dma_caps.cmd_resume)
@@ -426,9 +435,9 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			hw->info |= SNDRV_PCM_INFO_BATCH;
 
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
-			addr_widths = dma_caps.dst_addr_widths;
+			dma_bus_width_copy(bus_widths, dma_caps.dst_bus_widths);
 		else
-			addr_widths = dma_caps.src_addr_widths;
+			dma_bus_width_copy(bus_widths, dma_caps.src_bus_widths);
 	}
 
 	/*
@@ -460,7 +469,7 @@ int snd_dmaengine_pcm_refine_runtime_hwparams(
 			case 24:
 			case 32:
 			case 64:
-				if (addr_widths & (1 << (bits / 8)))
+				if (dma_bus_width_test(bus_widths, bits / 8))
 					hw->formats |= pcm_format_to_bits(i);
 				break;
 			default:

-- 
2.55.0

