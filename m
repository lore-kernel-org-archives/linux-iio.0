Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795519296;
	b=0aFp+JiMOx7x5TZQPzARPLcNs5i5DliHFhweQcIxmqwWbrt8PtYp1L7p0Hf140hiI++f
	 ssVpDPHOnGV6cWRmdjNxAWQyApP55GaUDcIPUtNpnHCDZqg/J42acti2IGid0jURYI1z+
	 eYsw6sJSznEy4mWugX7vVrAGE5Fa4Di7Fp+7zOlbzCfx+x/2Xn1/bA7mYPKHNJhpxbRyA
	 d53O7qSS8D2sWKAdg0qFWBAEvjlKfnZ2HEUS4up5X3MnbWf6CIJR1SVpDKvRFfGy7P6ok
	 dw6h8XX2ToaGelDjKvXA7+r6xXyRsJWD8Wunyd4ULPhqbNx465VWa/GhY+yTnTkrOdA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519296;
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
	bh=j37ZzyLbPwnayVJ+0FDwohLl4xSF/kBLFForAgI6Qpk=;
	b=Jr+WKnf/1X/D/l+Xv9cFGsenHa5PJXw72Sbb7k3jtKo2HhEsUgXBMayiZAUU7PmfjRpn
	 Vi58UOvVyFWbfDpmNjxdLQkfTIDPXB0JZZ8VlIN1axjqco2TWDmolLgbByAiAw9ysuhh8
	 X++c+IpVefF6+7QLJLPn+JkSHGhi4GW9ddHGYu07SICwD1pOEUMBTNwwbr8smRQR0e0Ch
	 EDxzh78BoSVlU7zILK5TAu11JOUPpgPWMIrrH121rYPKGgtf9lmorG4MfocOe1LtwBo3s
	 I0EDoExqP4M9Mpep//G3kOBGLwzw9Fv+Mhf+buPqlxfaKW+ovtg14gNGc4GZQHrtySg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ZXJ0OSOQ;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jHiBZ9XX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFC3606A321;
	Tue, 24 Nov 2026 11:21:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EFC3606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=ZXJ0OSOQ;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=jHiBZ9XX
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AOAvRG3592387;
	Tue, 24 Nov 2026 06:20:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=j37ZzyLbPwnayVJ+0FDwohLl4xSF/kBLFForAgI6Qpk=; b=ZXJ0OSO
	QkImiKWd7bTDwoeMQTNMnISVoebfq6u1mIDXwdmkgdx09OW3weou1npZeTvtltNf
	5YaeRspgLpQEahJaOTH1OT953LSXjRyhtLJAa6Tvaxb7eGcyQXFU3LhN0Yg+NNZ5
	2ocI3duboHftInYKMiUbIcmRetTBYmDfIhljp1v9/btTWSfFnMzchfjnL6eRN/ZA
	ZPnP0fVOrg3JgQASMwE5NdptLRF2u15BNCheFr4DTS9QJamzTQOCjht492aAEmEQ
	e9AFnneG0Mj1jkKU8X4wbUbCtkMwy2Z0o/0/VknrvH4ZNFRN41B0bugyTI/iEtvY
	JobT+6Vcm+CjnEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=j37Zz
	yLbPwnayVJ+0FDwohLl4xSF/kBLFForAgI6Qpk=; b=jHiBZ9XXfXk8D8a4Nfx6s
	TAJ/tLxeYRvIGhHt9cwGZsKAho7ED20oUvQ/2kKl5vR8Mv4sEQ+MdG4LP3qnlebN
	WwINDDl4RaUoBNUZSZnw/R4lrtEttMbph6KLaxwLA996n0DYdem/mUfgHdcis7nA
	KxKU5gHHs2SzHCPlabqqwEzkxJMFNvF/3RxcxRbWoBWkHAeIZyPtS5hQ187HVVk0
	k6whUMRvhKZ51733xwNec0gRh0Kw44LZKSM6+LRn380TK/5NW5CQL1X3mMkdK0+c
	dza33TZ728an2OO4xT6Hzf6QYUK25MJo6x80nXKGl22hWyblC4fNz4rfE6TSK9uW
	w==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011046.outbound.protection.outlook.com [52.101.57.46])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j574h0raj-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 24 Nov 2026 06:20:23 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTcamVsYzxMt+9aoHthx17Z6BAPrpfToIy3lDIiewd+Mh+mQx6ML77loAK5SXEdHs3UYSVBcgO7gjlo09ZPFyCH5lUVanYRiGwDg+ZZbwgs6CdIQkuel5XPNMFvW3zgxELPImI3/0tf9eIQZyvDItzscBRPG+60hdCT5QgNL8v9nYY+5XB9m9NjBhWnPUZ15KP2mByLpbBOuG+6bDDtP5sCrUPDxGdnl4eiCmGaqvUnze+EOhdYc8u3ez4UqpHySRTgIulYaUNrtwMzzsW8Dt6sSAahUQyy9j8YXpAVai6MC40AxHCgS5CkzFnqfG63Llo+ylDqMYm9LGYc2bc8aSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j37ZzyLbPwnayVJ+0FDwohLl4xSF/kBLFForAgI6Qpk=;
 b=xg54IMYpWkQxIxmnz9guq/FiAqwWEc4ob4BlXfVTDJoXTLunDmksw5pYxzai/+j5DKReqQew8/+AbCFu5bblgq4LB2eMCOV8wpoEPLuZ/yQb6Kwbp8+NK0KNPEGPmvgSD8ypRb+nOh9MzrvzmkSRRtpEmZxXuWn3zZ+Yq40Zti7remYJUpwYGpPC9vyl2hYgAsgwwbZ19fK8FWe9tYfSNiUZbK3qKiZbjxaC6VKyMRwREG6odJwbPWycIt3CWuaE/Vm+ZZqokDm+jnWvEVSOfA9iYtpmeXRMxcLE125LDk/A4UhTvpUtg/nFS6GRzsUrcJUUhxDkHaPRcrDR/v90YQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5545.namprd03.prod.outlook.com (2603:10b6:806:c0::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 11:20:11 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 11:20:11 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Tue, 24 Nov 2026 11:19:42 +0000
Subject: [PATCH v7 2/9] dmaengine: dma-axi-dmac: Use bus width capability
 helpers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261124-dmaengine-support-wider-dma-masks-v7-2-5d57df2c3ebd@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795519198; l=1850;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=r79UlESOjVE1LfAC4DHPkWolGc3uVaPOz4o3MdPT2Iw=;
 b=1qxGmhv4LwUL+IftqomUwkmKNINYuDMCTenN1qm6SAqTImFaoURquyYCQSf2lLgPEFAuN5VJn
 39ejfAwTqkqD/49hc/CiBGXGiWBMo26n+uxvJFixgF1iOkawY9oWRdl
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0189.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:58::16) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-Office365-Filtering-Correlation-Id: 9d0fbf24-fc56-45c1-5d84-08df4a1ce798
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|23010399003|7416014|366016|1800799024|11063799006|261022075727099003|10067099003|261009223027099003|56012099006|261021121427099003|261021123027099003|261102123227099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
 k+w6E7cAZ/C2j3gGj4SjakWbvEWC3hpPLgfOBH647au7eMcvMKhbrQFQ0AabXfZg/PABhyBfyYyHNsm9ymr62lZmWXcUznfdp/SmsngjIEBAhA54NY/b7Kq+VSyD7waEh/v2sA2810JzkbjMehoZAoOFG7KgaujRFv+WZwVk9hDzQQT/1rrr26nezBvbATMX62V50Ak5Qu8a+OIKzkTjw4gB5keLsJHVxoKlFXoC8cYtWbUiE8rHXu/yLBA4kRGaGSz8ocvYPUBHm6quiCDT0JLhSkxA0SaOahNUPmla0b2UqY3bRpEFGswVxe9Bt1if5qfbj7krIJy0peEkRyUzhKneUJNxkZ6xeUQp+HV9sx5p35y+I0Lc2mvcaL8b3x54qJbsWHQYFnFh+0dNeFG+eBl9+qU1oDKbi+SalUxgtjmX+MiSldHPyQkcv94QPwofSSgHnYruGPM3Y0JD6zToQmE9jWxGnUIBxQMRPtYSXMbub8n+Qn3pyUJ2GW+hV5A5jnj24GS0s6Ahz+aFhdeLM8YDR3qg6NE2DOUXPX0poPrh/lFcK6rdQz3U5nCFBHOhKZliE2A124uO19cODN4gmCOn0upkUX4E3+BMXicI9yEp31RpeKHjbjbE98sGFbvB16VAIbxyTEHb43xz4RIBkLhBJ/AosKLbXgr72pZwdHM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(11063799006)(261022075727099003)(10067099003)(261009223027099003)(56012099006)(261021121427099003)(261021123027099003)(261102123227099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RS9teXgwVEd5MmhvV3A1OXFlZWJFbnl2TkZFTURCMW0vQUR1VGhaSnIyWkJ2?=
 =?utf-8?B?WTNyWDQ2SVBnM1ZlaUEvQjNlYmZHaTNMUEt0ajNGVjVzTU43bWdZN0FHVFps?=
 =?utf-8?B?TkFibExCNDRxT0lNRjA4NUdWdCtMalJFQWp4RmZtSmluL3JJaTkvaGVPOUF0?=
 =?utf-8?B?eGhudFhLdisyZm9URWtJMktxRnJhYlh0bkFTVXp3VEdsZFdPR01QRTFORTBq?=
 =?utf-8?B?UU1QVW1ULzF6VndTY3lGcGNxQUZ0NmFheEFxUEkvcVdMV08vSk12enA2cVdy?=
 =?utf-8?B?L0RXU0duTGQ0MEVFSTU1WG93UjFxRFRaV2pnRFdRd3VtR1RHL1RLSDNoRFpE?=
 =?utf-8?B?cFBaeWtxSDh1TWZLaWJJTGVnUFhMK05Kb1JXcUJTaWFhZ0dudHZEV0xSL3Z1?=
 =?utf-8?B?WUFUZnAvd0tGQUVpV1BhTDVsTTd3QkI0RVdyczEwRDMzQzhHenU3bGZHckQ5?=
 =?utf-8?B?d0p1OGdiS1M4cnNzUTcyZytSeG9xMG5BQWNSanpsTjAyWmlaTUJiUlc1WEV3?=
 =?utf-8?B?QkJQVlA1L2h2RCtiTDRNR1lVb1h5aitwTGRvTE5zTG5lMnllMVVoRkRmTVpk?=
 =?utf-8?B?a2FiUDFJT1VjZ1AyVSs5anBSa3dNQkZjUW9wR0ljV1Q0c0RCUzZIalZFYnFN?=
 =?utf-8?B?eXM4Zk9KTU15cm4xYmJjdW5TTkRoMldZbFg5Y0hOZUd5YTlodnVIMXFvRDR2?=
 =?utf-8?B?OG00UVpxbkNLeFpXTVQzeTRLZk9Ob0M4UE5oV3cxV2h2M3g1VGxyazZZZThW?=
 =?utf-8?B?KzNSQi9kQmNoV1JYTGZPaTV2UzQ0Qm5SQUlwUko2RHVUV1l6UEpMR1ZHNHBa?=
 =?utf-8?B?a2xOSHVRaWtVN2Q2dUdGcGY1WHpVUEk5OC9uRkE4OFd5cVZUb0p6YW1qc2hN?=
 =?utf-8?B?Qzd5RW92eUhwNmdBQVJvWjRHTGhGTGpMQUM2UHR4VGhFaWdHaFVxVktzWlVs?=
 =?utf-8?B?R1pOL3lGcWd3OHZ3SEY3MFYxOTBqajhLcy9neHBIak1GaTNiMkliVW5oQjlP?=
 =?utf-8?B?SkpwZVhNaHRUNDl4SmNhOERZN3dyWm5hRExTbEFvU3dVMEZoaGhTTmcwL01Q?=
 =?utf-8?B?amRQR1Q5STF0eFpzOFV6aktOMmI5Q1J3R1ovNm9YZHZTcEd2dUNQVXVjNm5K?=
 =?utf-8?B?NFNuTzNSUkZQNWpMK21iN2QzSHMvZnVKWHFpR2xGcTBtNzV4d2ovYy9hMldw?=
 =?utf-8?B?MVZtam9NY1BGcEVRY0VJb0cxTHZLZGxDYkN5Qnp2ZUNoNis2UFErbG1IK21W?=
 =?utf-8?B?SHowelRQRkFSWmZBUFJqdkd1bWphMy9oeWs1cUp5M1ZxRlAyWGNmQVpqRDMz?=
 =?utf-8?B?Z2dWdm0yL2J6YkpmQVpJNnA1NWhiS0F5NE9FVFVpamNaeUlQV1orYVRPUEVO?=
 =?utf-8?B?M3pRa2RCaUZYd01EMTYra3RqWEcxbzRQcTJjbkZOaWRqZGV5R2hielgvT0l4?=
 =?utf-8?B?VzV3YytQNi96MlpzbWVLd3BIUXZrbDc4UExUMGFHTXZwaG5VWFlHRnd2ZTJ2?=
 =?utf-8?B?NWxWdFk5RVIyYkVjN3pXNlVCaGpoK0Y2dlZFdExMc3lQMG8rODBtU3lYWDgr?=
 =?utf-8?B?RElma21WQW1leUQ4M0FqUXNRRVh2OElTdUVKc2xaOTZKNnpGbVJYUWJqa2I5?=
 =?utf-8?B?YWM3M2p0OVRFZXloZTdIWVczVDNEUjc0bUVpWklndUFFYVJmK0lwRUtsdWt2?=
 =?utf-8?B?aHVneE4wUU5BakZYeElpNk5Ub3hMUGVIYU9JMU9ST1FPdExhN1JwZjBvOU9V?=
 =?utf-8?B?dlBLQ292bVdTUkd0dGRXblFTQmtCeVlFTFQ1dElZZ3hTcHhyTXUwSitubkZX?=
 =?utf-8?B?YUMwVExnR2gzYVZldlRQWENmYXREZFhSUEtVaG1HeHNYZG9nV2VZSlNYUkZl?=
 =?utf-8?B?SUpWVCtJVDJxSkVIR3M4V0pXeWFLNU41dk9pQnpzaVFwSkd3Z2M5TCtuQzBt?=
 =?utf-8?B?ajZGSzlNSU92OVlSampISXE2OCtuUXRFNEFzMlNlelpHS3NaaEhhWnpPdGdv?=
 =?utf-8?B?a2Ixei9UYmFFWmw2UzgrdjBHNXd1ZGhudVVTU0tzempJa3c1NlkyK09QNUpQ?=
 =?utf-8?B?UkFjOGR3NURMeFQrNWFlVnpEMzlSREkvRUNaQ3ZuSSsvUzlnQXFOU3pranRV?=
 =?utf-8?B?emRWY0JVOUs5TXBSQWpNWkt1WHM5ME9XRWZXZkl3Ullna2QvOGJwSHZLTzBa?=
 =?utf-8?B?NlpCRWVpK1IzU0pOcnZDdFQ5ZDRNbFEwT0lUdmVrR2MvWXBTdmRtMEdTUVM1?=
 =?utf-8?B?TCtyZlBxblJUNS90RGEzS1VoNENWK3BJUHk0d0tvN2xNNVZnREdnaDhVOGlZ?=
 =?utf-8?B?VmNkamNaY1NRanVMVzRNSnlQZTQ4ekl3MThVRWFud2YzMFhSUHZ6Zz09?=
X-Exchange-RoutingPolicyChecked:
	E6cZj2blDWY7My8aXD70s7BRv3fQWUu0xI+tawIKRrr+ezQPLho4D3ZfRnylymmFdA1TsY7QbKQfX5IPWRkbTqQfv48bwPeben72irK+A9PoUranpb5jM3nqPtna/rtQNokHtN1T8p3zK1vb4BsYSmFzB8fooqUR8UkbPS5D5cerOvCaq9qpsQZ2o4IAArG1N9dBpYk9whXvVCXf0vBD8gkxZU130wrOq1lfjeRJ3HcmmMpfDEX8OQF1trY8PfKubz+lmMMDDITI0NMz2AsuIcA3XWksP8G2jgPN4YpBi2h5MMuHnTh4H2CeBDlF3/C/nPr+ZUURrbMGamhgntHRnA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d0fbf24-fc56-45c1-5d84-08df4a1ce798
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:20:11.5862
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m5Zv34ZthYFNm4ynHsUFMXv3Ti6CaaMlutDCqwiX+LKgU3qqknRVXoJBbEBxLobD0hIPGUsgxRl4/ACFSFwBbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5545
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX1LS8tGxHTXrM
 ni43b+jpmFMoQZJHWyWHrVLHE8iWE7iJhDtS53ZnTscDBddccJrEIs3QRVKKjiM3kE8zJB2RAz8
 wP5COs7eHvraJoS1OcNUHGBLJGVNaHLuKut0O2mW0H2utkX99dOrsZptW1Xxbz/UAA1ApxHRRLO
 hKW8GWhuXrMa0JbOeJoIJrQf6k0Q7pTdc+zqMdq0bzlCZFR2R+qs9JBOqx5vH/o0FCo7NenFhdF
 NXoX857EqYHabhA0556DAP/1oO6qinYIDo7iWnSQjydlUfQf9gnGGdkgnrGTBel904T4Gtm0OHI
 EzIABmkVj2utJ0LVJYsXC8I37IpfxUuEUovVWhclrXXoMLbp9ItFmffGb8JOC5/BMFly0endiOk
 /xM/nUetrlgLoqd3HEI3Ht4OB1R2przbvmbVZlyMcgBvwEU+i/wFfU/WVuPvbHJhnk7VB3htuQB
 Gzw9JRjfYrdhf3d7nSg==
X-Authority-Analysis: v=2.4 cv=Yt+a1IYX c=1 sm=1 tr=0 ts=6b0572f7 cx=c_pps
 a=foOfPl9YvWvIvXDtd8Rkbw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22
 a=8AirrxEcAAAA:8 a=gAnH3GRIAAAA:8 a=VO7gjKh9a35wxgc9tPQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: RikhpRJo-jrPZxFgOK1RZPmFtA3annSw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA0NCBTYWx0ZWRfX0UzxmlGbz8p0
 aSYvFi6VhzsWDoE7JTmhsx6TIml7Wpm6UL+BFYVkaMeT/khz3He+EovmDFrDliFZ7dIOCg4vCkR
 V9XRPbJ0ZpbH4HGtfFVVpy2dPV3pOlCX9RzHX5fCM4Pk177ci9F2
X-Proofpoint-ORIG-GUID: RikhpRJo-jrPZxFgOK1RZPmFtA3annSw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_02,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1011 spamscore=0 lowpriorityscore=0
 impostorscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240044

Advertise the source and destination bus widths through the new
dmaengine_bus_width_set() helper instead of open-coding the legacy
BIT() mask. This moves the driver onto the representation that can
express widths of 32 bytes and above while keeping the legacy u32 fields
populated during the transition.

While at it, give the channel width members their proper
enum dma_slave_buswidth type.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dma-axi-dmac.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/dma-axi-dmac.c b/drivers/dma/dma-axi-dmac.c
index d47ff27e1408..ab436e9d6cbc 100644
--- a/drivers/dma/dma-axi-dmac.c
+++ b/drivers/dma/dma-axi-dmac.c
@@ -152,8 +152,8 @@ struct axi_dmac_chan {
 	struct list_head active_descs;
 	enum dma_transfer_direction direction;
 
-	unsigned int src_width;
-	unsigned int dest_width;
+	enum dma_slave_buswidth src_width;
+	enum dma_slave_buswidth dest_width;
 	unsigned int src_type;
 	unsigned int dest_type;
 
@@ -1262,8 +1262,13 @@ static int axi_dmac_probe(struct platform_device *pdev)
 	dma_dev->device_terminate_all = axi_dmac_terminate_all;
 	dma_dev->device_synchronize = axi_dmac_synchronize;
 	dma_dev->dev = &pdev->dev;
-	dma_dev->src_addr_widths = BIT(dmac->chan.src_width);
-	dma_dev->dst_addr_widths = BIT(dmac->chan.dest_width);
+	ret = dmaengine_bus_width_set(&dma_dev->src_bus_widths, dmac->chan.src_width);
+	if (ret)
+		return ret;
+
+	ret = dmaengine_bus_width_set(&dma_dev->dst_bus_widths, dmac->chan.dest_width);
+	if (ret)
+		return ret;
 	dma_dev->directions = BIT(dmac->chan.direction);
 	dma_dev->residue_granularity = DMA_RESIDUE_GRANULARITY_DESCRIPTOR;
 	dma_dev->max_sg_burst = 31; /* 31 SGs maximum in one burst */

-- 
2.56.0

