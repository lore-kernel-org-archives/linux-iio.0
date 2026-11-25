Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795602011;
	b=K5XrOh//C7B0nvTExm+UiZOHlKe1gsqz2Z334aGDU+7MM3vcmgI8hjQavuB7G79wyQy2
	 aDgmfhVosQhMKpieC3YIr1Dlpqwh4OM8xkK3Tk/HEiKznxderZiRqcdHvWTaT7us7WPug
	 xGATMTpaN+oVyN9OcHj1U7YXWiD9AaAA28hh1loJCdfU41+mT8QEv++P2SkrqoesdEgTP
	 7v0Piv1wZWBy4EiXmrbC+2UseF7HifDFDNHmftQhZI7T463gI5OH1SIy0gIYD9Jm3Fnb6
	 iHXV1+uMeMUkELeZQgflJpLLluVmybVbs8fQ5zHQvLzS2spMyXcbMLNG6baHf424jfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795602011;
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
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=yMqFkxqV3ytGGgzvhZa6w+odaiXqFYBxHnA4vLGd6CM=;
	b=xbERsjnYMgOAAWq3tsfKIQMEcvVS3rVntwmygoW0WK6lMcJwRWhMinSAmCTbXhGD/1ur
	 dFy3xd6obi3mDiWHptheXRUzbLNoHhK8+fbhTx3jQOLxZmHB78v+SBQv4JxHBOOhb+EQM
	 Dsv9uwICc24JtvS3WqMOta9JZwGZTWKNhHJek9OvEPfbgDoAs9N3n0jl/PmoKiTj49pVJ
	 HC3nVloK3mocU0ydntskEFSxfPGgxWWg8q0YLMacALEjl5oumpzVVlgDDcBMrwAr94yoY
	 rZ0FKXFsAcLKOOdpYSfUwOOJMFEwSrR9eh3PQuoZTRNFGo2I8LoI8Mfu6NpVaGqE0Dw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b="h/gPG2Rj";
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=znSF1J92;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E365F606A32C;
	Wed, 25 Nov 2026 10:20:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E365F606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=h/gPG2Rj;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=znSF1J92
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9n1BL1257539;
	Wed, 25 Nov 2026 05:19:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=yMqFkxqV3ytGGgzvhZa6w+odaiXqFYBxHnA4vLGd6CM=; b=h/gPG2R
	jRgaQ+nSPhznoRPmW6S9SoGf5HJciwXPG9SWwkZ2gdEleszv6RKW/QI1DNUDM3We
	wRS9F7QhrgQWeqOluoBn3h1Kni+qe32MVHXwLYyJROMdhafC5mymh/tLZUOjEHNC
	Zt5m0wOko84MCTZIRvt+QjQglNrmxg5tRt6uhZpqOyek25x5tbE/4r91G8f3fqdO
	7l4rSnjPySkiFg0ZPvXVIu9hV+sy5qqX9u1TzckdkrgRFyqadaKeWR/qWTCFW98T
	YQQ+r1HfWhVWOmnK2shWdDcCpAaP5pKBHbSMAaHoRLzw2MDpGuZMwdM0s1nVGeJ1
	h+qk99p81wqyONg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=yMqFk
	xqV3ytGGgzvhZa6w+odaiXqFYBxHnA4vLGd6CM=; b=znSF1J92VI9lrbqI5xiDo
	1rWQlj85WE4QgYQR2ta3X4HXoCZ9lYSYGh2lMA8kw5LeSuPbCHsIFHr4UGjv44NM
	0/YZgH+TqTXhjvEx+GNzE6tt9dWOY6Txhy+fcGJs9XiO5MTjtdVELLpESebdZfqA
	Kf3APjLa3vu9L+HkKvnugkDYc/QHgviLRjuj9VzjK4NNL3v5MYG54fBJ1L6c66ur
	PexNGzyBbwFx0TuBePpiun0AAgdTzDxr4AdFmRdGiXh58nSB40bbarZ16+WUh4sr
	3vtAdtBVryW4RYz2iQ9Wh494q+f6e9j7nIJCXjLvPUV/zp8TEx6/KIKktJexZEoO
	w==
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011023.outbound.protection.outlook.com [52.101.57.23])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j5ctbw3gy-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 05:19:54 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kPe+f2Zo7FiCS9NXwZXMj9tWel9/PDLsZHavOEp2fiGRQgADkxnwz+bIj4raqCwBa+tinEAZyA6PuJw2jjg4dC9togmHhHvEoK61x5cBWzW0ljOtYLIQhorQhjwCzr24wW/KFctb25Wf73nYvCVGyc8Pwv15y0nN9mij7aMo6vGcYQCP7UmyG9hB9cHLkqvj3DwV7PwoQqoXdQ8sxrmpR7cfXHlY4QSWTcabtFmlHXNGU7w99s2yfBytg7JB1vpjEIDzifcaLQsdHzchBfsK01IDTaX297OoSSFqXdhNKt4nLzW+FVKBYjsWsKjvFDA/JOa3WaEU+o3e366Sj41GLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yMqFkxqV3ytGGgzvhZa6w+odaiXqFYBxHnA4vLGd6CM=;
 b=amv23Tbg5CZ3ClKWRcCz9KJUCbLBi3ftYlt5UkitrySy+Cc9LUWd3ZTS8iS+SrOhyaAVIdzfY96o8wcT8owB+6bag80pprttY4YMd4chkM/Xa/FyVEeRD2k6p7x0PD7tsT6okEpZSNT8Du/gBb84BIkf1WlMuu8WSyad5t7nFjjbohVETeYASMY9RXhA/NwpD+J6QmBtaoIoJBUxhkEtR9kFFCLPEphwPLG/CRIeK9ly6gk7P6SkKiSOymK4/GWZ2ER+EQS0zJjO8v1hN3/BtH0PXSs8nxdYGzq7k82N8NoP0WeY6tU8J4QKg2EK2iXRwEscPZQsoTk1W1hwCUPCag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by DM4PR03MB6048.namprd03.prod.outlook.com (2603:10b6:5:393::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 10:19:51 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 10:19:51 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Wed, 25 Nov 2026 10:19:22 +0000
Subject: [PATCH 6/6] iio: adc: ad7793: add firmware support and drop
 platform data
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261125-iio-adi-legacy-platdata-v1-6-54e4c8830b57@analog.com>
References: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
In-Reply-To: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc: linux@analog.com, Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795601958; l=21137;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YIzHt/F5r6vJchPg4ddznLhSRJ5bxD1ngYqC+yIAzbQ=;
 b=K/AM6Cwm3zxV9t9GGGslWFFXloolGeC9gT+r8KcmtbYzb8S3Wh80daFNkpk9WyHpBDtKgeY8v
 aoHWrYzt8pdC+03hodNny7Td9NbuMl5/Nvmdw56c8npvzZwlWO4voZF
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0157.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::16) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|DM4PR03MB6048:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5a8de3-bc6e-40cf-0021-08df4adda3ed
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|6133799003|22082099003|18002099003|11063799006|56012099006|261022075727099003|261028144727099003|261026121527099003|261102123227099003|261021121427099003|261021135927099003|261009223027099003|261026140227099003|261022105027099003|261021123027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
 XVG1QzceR8oxnRzZqENifCvgGcr9eG+tTLQvfKY1JFkc5MJScoEwucM+khC77tACKyoPFXH5c4SgdM3g4aTE0O96FLEa3Lci/cK1Y4qXWkK+W+vZGvRJG18EuRVQ8WATXgOq5QV1KKqMZ3rtAinZu+JY81R+wKNOEPmps5gRY4vGR72pIP6a8L6ntvbK+4AfMkN10jsuoOGQVp9/5h9AOpBXBw/oMdBBedAzbEohVBI7VJoIfs7iBe/sXGAgZlGjJuF6FyQbTNjiSX+SjEKQyepb5tHp2Wx6jSG3kPtHWt/J5Bgcz1D3hjG/GIarMODksYr2CJvaL+cah12IJ1W2x+HzlW7MsShFLX7jo1qN2GlhYdwSY3c8V15jgcMjyVYvQmALzdjctHxHWwMclFUgKWudaYPW6MCl09MwKrmz/mO1GwmUh45EjDFCKX1Qs4j/kj4Avxx2Qpk2z0zW3LTZ0+pHz4V9VtQg3JQGjmOR9cQpN1rSh9I11kb5V70a7pi4mEdvmqRJDg/Ho59cGG6lHFlJOoP29RnJ6aytPma6Oqsy2dE56RCt5UL6hN2mM5GzFeaZ4JP9EalJ05DbJI0hRVFp6E4RGmmGdYrb6RkpaUFFIT1BaOn6EOUMy3PFSwK4ETuLl12mMUmabO6JLExGmcW2lnYAEGhXnjSu1/T8kNU=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006)(261022075727099003)(261028144727099003)(261026121527099003)(261102123227099003)(261021121427099003)(261021135927099003)(261009223027099003)(261026140227099003)(261022105027099003)(261021123027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?YUpieXp4RFFBM0gyV3MxTFlXU0Yxc25EajhYQ3Z0dmxwa1pPR0pnWEw3a055?=
 =?utf-8?B?K29CaWlaZjJIK0xsZ2N4MkxVQUYzV2pGR2N2Zm42YXNRb1RrbzJIWlRtMHhP?=
 =?utf-8?B?cm03ajRxbTFpY2ZsZjdXeVh5endLRVZGeVFkS1RVazhaL2d2MGhjdThzcmFi?=
 =?utf-8?B?WmVFZ3AxYXNvb1NYMTc4MjByTUhwRDEySmpXc216ODlBUWViRlBsa3ZXcmNo?=
 =?utf-8?B?Q0o4QTgxNDNxMnRubmoyZ1c4anBlQ200L1pNK24ybFFCYVhNdXhHSUZBZElp?=
 =?utf-8?B?aFlSWnh3RTczY0lFR0xicHRzTHRYNmlVNCtGUUxBUnNxZ25MeWNBUFp3azVr?=
 =?utf-8?B?ODNxaEYyVjFSSHlIL1NBcU1UY2tnZ1ZEaCtqakZYaWRMbW0vWXUvOUZQVFlP?=
 =?utf-8?B?UnE2U1ZCdWlPRjh0MEUrMHJsTkQ4di9idktwKzJ1dldGSU5kTEdlTzNpVkNL?=
 =?utf-8?B?UVVJb25heVF5TVdaNUpDY1JMM3lyWm9SN3BraTJsR0twajFScWkrYWw1aWk1?=
 =?utf-8?B?TDE2aGs4RlR6T202dnZOZVRleWxjeWszbHNrSWtKYmtiYVlUSmFoODR0SEM1?=
 =?utf-8?B?U1hnWFNZbk16OEhRRVp0SHhid2V5VklhMU1iSE1GWVdTTktMZ0NlRmZoZGxU?=
 =?utf-8?B?VUs3NkQ2eklYQmt5NXI4a2UrTGdYdmFkM3ppRTFWNjRuQ1YyOGdZdlBYK1h2?=
 =?utf-8?B?ME1OQlJEY2NFRUt1RDk0RnN6NzV4UHEzc3RlK2RqUjkydm14ZENKaEROMy9O?=
 =?utf-8?B?cEczT2ZRZlVIbTlUR2x5bFBTdFFUZTFjMmoyeUxoNEFWZzhBd0lzL25Fcjd3?=
 =?utf-8?B?NW4wNGs0ZkFIa1BIYWxIZk1vSHhmTFpRbDNFSTZHWHlDNExIbmN1NTYvOE1O?=
 =?utf-8?B?ZzBkVkVQTnNBWW50U0IvUnkyU1BqbnpoSVhtalk2Qm9iWVowYm1ocFBFSjdz?=
 =?utf-8?B?aVF5TFBOUGFVdmZyZExDc2ZRZzFPVzFKb0VmbnNROUxJa1p3QmJWUjRYdHps?=
 =?utf-8?B?a2FTUDFYdk5vdXBDYktNRFh2ZE42TWlKdjk0ZzVtNnZCdnlVSjJUTjE3enQ2?=
 =?utf-8?B?NnhKQWpXUzB3K1EyYUZ5MG5kRDBXTnQ5MFV2WkNWRzZ5UStNNkhmY0pRblFu?=
 =?utf-8?B?NDJLTDV0bnVyanhsbWxrTWtjVXdhSHo0cldiNXc1bDBFZWZJVW9pZ0RtWm05?=
 =?utf-8?B?TVl4RzhJOHU1cFhFUUQzZFhYK1lFUGV3cVRrbWpTaUlMaTZsVi95Qk5IWlRs?=
 =?utf-8?B?N1hBR29lU0pYTG9sNENHNm9RTzN5UFFrejhMNjRESTByMTVpMmJuSVFDY0dO?=
 =?utf-8?B?Unl1YkEwNm9DRXB6bVJYTisrMDBlNjJGa1c2K24zbmNTWHJyQmM4blNQM0Jr?=
 =?utf-8?B?SlhNVmlXMTJHeGg4eUpsRU1xOUxNbkg3U09aWWQ5cE10YURHcnExUHNiVWtW?=
 =?utf-8?B?RmxoS1VEcnAwTlBmdnV0Y1F1am85dTgwMnlsaWllaGNkUFdSa2ZZMkRDYVJk?=
 =?utf-8?B?b2E5ZDFYTXBURFN6ajNqcGxudzkxdFdZby9XZy9uc2pKczd1bVAyV1Z4U3V3?=
 =?utf-8?B?L3U2NGlxcVRRVi9wK2toOHhrOFliUFZrYm9FVlNVRUhqZDRCbmJMMXlJVG1h?=
 =?utf-8?B?ZVlaQWFUZlZLdmdGNGY1T1hva0JVVXBVb0VxTVhGVnc5OWVsdTJaTUMyWEdQ?=
 =?utf-8?B?dzlieElyT3A0bDIyYzV1dUNON2VDZzBGU0FtRmo3WjF5ejlFcTNVc1B2SkY4?=
 =?utf-8?B?cHhTL2Y4NDlud2ZuR0hKOUNKRTJVWTNCMHZ4MEFkeTdmc0QwOXpJcHVaeGtY?=
 =?utf-8?B?U0x3R0hrUjdLRHhFelNNMCthOGNHb1pVeGkwZFhnVS8wZHYyUnMybkNoTVpF?=
 =?utf-8?B?OVZLYTI1NE5GcGIzb1Bkbmp0WTZxZVBUWDhBbVhHakRHL1VnTDNMZXZ6eU5I?=
 =?utf-8?B?THg4UVZSNWE5Tkx0NFdKRm5RbFZtVlU2eTltMnFxMldIVXkrQzd0QmNvQ285?=
 =?utf-8?B?WDdNM01GV1JLT2lQdFZKWk1TRi9YSWZJemNZdU5KMkJBYVg4cis3Uk1ubHhi?=
 =?utf-8?B?U2J4M2hGcDFVbDdXL1NaalVZbkdVa0VtUlQ0RzE2VW9WSzZZT3V1b3RtQnFE?=
 =?utf-8?B?VHY2SUVzUzBsTUg5K1VSTE85QTY2QzQ5YklqK2ZxbEEwdzRsZTdBaWp6SVFj?=
 =?utf-8?B?a2FCSkpzMW5EYk9zTWFoQzY1SmpvK3RLNG1MSVM0Qm9BUGtjTnRmN1BGU3VK?=
 =?utf-8?B?WHBOZ2pIazBNbSs5UktCSGN2bWk3RUk1dERJeTN3SFNTMkVKbXlNaUxtV1FI?=
 =?utf-8?B?WTBzQTBqQmFDWXJLTmpQTjdVRHZiWFoyRktOVU12STg3VXhud3pWQT09?=
X-Exchange-RoutingPolicyChecked:
	NpxU4SGVIf3xZ0EOfGQP4/czm5sHyRALcNgZs38IDsUCE5xR75CKXz+dmg7grqBjACyH5GryzrSUVOjqgl9YuFsWAJABrJZdfDgLK1FWIM/YQ3v1Vt4Aak2ihUpjIN9i+vG9DjdvDo9yBEQcc0PabLrD+Tmg3L+qjLQk3ht175Mk/DEcItChffpAwVCQ/DeIFjzZyYRyCntbsTzpP0mb9BayVB7GWr3EVWr0uHrfdXyvhymVcjFFopuv5BTQioakdZTQEd8Dz9N0qVYalNl1QVKTghjDp0GY79pLO0FwSt1tA2P56dZ1v6bSqHIbuN6CSZWDSDTvcnzbi3gLD5ydmA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5a8de3-bc6e-40cf-0021-08df4adda3ed
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 10:19:51.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yOuW/kaGdUoEF+5zReNfvMYPeurHmUaFre090rbYBwxd4zgCjmjXYKNnqO5yyDjHjzdWH2NLWilxcHLCdb+JOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR03MB6048
X-Authority-Analysis: v=2.4 cv=JrJkP84C c=1 sm=1 tr=0 ts=6b06b64a cx=c_pps
 a=n8CZQ1v8Y1OZ9xNCwzzv5Q==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=iZSIUCweCk2Oy3QsdGPA:22
 a=gAnH3GRIAAAA:8 a=8WIwqIt3IB_WqtUL12wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: OjYotIe-HHmOOoFUiaid89upNgOMfBkc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX2q4hQpaQfg7f
 FBzoBcX7dM3IVv4dgACO6DiSJtsFqbNg6y9Ky8TKc97hAKIj5W9R9NBticSM0roCooTv6aj2cKf
 Vv62NtHyRnsZqpliHA/u7DKZdRROm7UkXFmbCdr39t1Pk/BUEhNcvCSOXJVnhSOQWiHyBQoMOFS
 2fpnRwvcVAzLY/7uRhccLirGR5d99AaemHIbwo9BrRU1vHpUW+a/A+pPxLnGBdTFbt9MZpXZzZG
 RIp6H0FGh5sNb7FtnPEGTiiwQqwbtS5jpL4zkjMFaNl/B00eFs6NLBcWbpfPk5mArxr5RRcx1Y6
 19APvFFENH1SBqT9hcXktIGYVJBkSvtUt2uQ0YLZhUJAyee1pRsBQOZvle6hLwJlMxdlmQ/M6+t
 7mHSdtaEl5F8fGcu1LrrNwlvTF78IB8Eehm5HWWJTchZYY/rndftenfS63UiRFqH4l3RiSc0u5q
 sGSCtcka995vwBMnujg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfX+DjCi7k1laID
 6HARz67hrPtRQ+cs9UoybJMxg4/VxSadX5dv8oJ2NZ4IttxUTq1Q7Ia6hAk9H37Hdj6rYDHogva
 YK5b3CztcV7aeXYtdxhaj+Gos5lXfUlGlFaKEe5UKA2Ze144tFT3
X-Proofpoint-ORIG-GUID: OjYotIe-HHmOOoFUiaid89upNgOMfBkc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250040

The driver refuses to probe without struct ad7793_platform_data, and
there are no in-tree users of it. That means the driver can not be used
at all on a modern system.

Get the configuration from firmware properties instead, following the
new binding, and drop the platform data header:

- The reference is REFIN (REFIN1) if refin-supply is present, REFIN2 if
  refin2-supply is present, and the internal 1.17 V reference otherwise.
  Parts without an internal reference need refin-supply.
- An external clock on the CLK pin is used if given. A 128 kHz clock
  is divided by 2 internally.
- The input buffer stays enabled (as it is at power-up) unless
  adi,buffer-disable is set, and unipolar coding is used unless bipolar
  is set.
- The bias voltage generator, the burnout currents and the excitation
  current sources get their own properties.

While at it, also enable the AVDD and DVDD supplies, add an OF match
table and fold the platform data checks into the property parsing.

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 MAINTAINERS                          |   1 -
 drivers/iio/adc/ad7793.c             | 315 +++++++++++++++++++++++++++++++----
 include/linux/platform_data/ad7793.h | 111 ------------
 3 files changed, 278 insertions(+), 149 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e55236f4accb..fe88746df57e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1739,7 +1739,6 @@ S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,ad7793.yaml
 F:	drivers/iio/adc/ad7793.c
-F:	include/linux/platform_data/ad7793.h
 
 ANALOG DEVICES INC AD8366 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
diff --git a/drivers/iio/adc/ad7793.c b/drivers/iio/adc/ad7793.c
index b0f44c144f20..f3e3ca724ec2 100644
--- a/drivers/iio/adc/ad7793.c
+++ b/drivers/iio/adc/ad7793.c
@@ -5,10 +5,13 @@
  * Copyright 2011-2012 Analog Devices Inc.
  */
 
+#include <linux/clk.h>
 #include <linux/interrupt.h>
 #include <linux/device.h>
 #include <linux/kernel.h>
+#include <linux/property.h>
 #include <linux/slab.h>
+#include <linux/string.h>
 #include <linux/sysfs.h>
 #include <linux/spi/spi.h>
 #include <linux/regulator/consumer.h>
@@ -16,6 +19,7 @@
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/module.h>
+#include <linux/units.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -24,7 +28,6 @@
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 #include <linux/iio/adc/ad_sigma_delta.h>
-#include <linux/platform_data/ad7793.h>
 
 /* Registers */
 #define AD7793_REG_COMM		0 /* Communications Register (WO, 8-bit) */
@@ -140,6 +143,107 @@
 #define AD7793_FLAG_HAS_GAIN		BIT(4)
 #define AD7793_FLAG_HAS_BUFFER		BIT(5)
 
+/**
+ * enum ad7793_clock_source - AD7793 clock source selection
+ * @AD7793_CLK_SRC_INT: Internal 64 kHz clock, not available at the CLK pin.
+ * @AD7793_CLK_SRC_INT_CO: Internal 64 kHz clock, available at the CLK pin.
+ * @AD7793_CLK_SRC_EXT: Use external clock.
+ * @AD7793_CLK_SRC_EXT_DIV2: Use external clock divided by 2.
+ */
+enum ad7793_clock_source {
+	AD7793_CLK_SRC_INT,
+	AD7793_CLK_SRC_INT_CO,
+	AD7793_CLK_SRC_EXT,
+	AD7793_CLK_SRC_EXT_DIV2,
+};
+
+/**
+ * enum ad7793_bias_voltage - AD7793 bias voltage selection
+ * @AD7793_BIAS_VOLTAGE_DISABLED: Bias voltage generator disabled
+ * @AD7793_BIAS_VOLTAGE_AIN1: Bias voltage connected to AIN1(-).
+ * @AD7793_BIAS_VOLTAGE_AIN2: Bias voltage connected to AIN2(-).
+ * @AD7793_BIAS_VOLTAGE_AIN3: Bias voltage connected to AIN3(-).
+ *	Only valid for AD7795/AD7796.
+ */
+enum ad7793_bias_voltage {
+	AD7793_BIAS_VOLTAGE_DISABLED,
+	AD7793_BIAS_VOLTAGE_AIN1,
+	AD7793_BIAS_VOLTAGE_AIN2,
+	AD7793_BIAS_VOLTAGE_AIN3,
+};
+
+/**
+ * enum ad7793_refsel - AD7793 reference voltage selection
+ * @AD7793_REFSEL_REFIN1: External reference applied between REFIN1(+)
+ *	and REFIN1(-).
+ * @AD7793_REFSEL_REFIN2: External reference applied between REFIN2(+)
+ *	and REFIN1(-). Only valid for AD7795/AD7796.
+ * @AD7793_REFSEL_INTERNAL: Internal 1.17 V reference.
+ */
+enum ad7793_refsel {
+	AD7793_REFSEL_REFIN1 = 0,
+	AD7793_REFSEL_REFIN2 = 1,
+	AD7793_REFSEL_INTERNAL = 2,
+};
+
+/**
+ * enum ad7793_current_source_direction - AD7793 excitation current direction
+ * @AD7793_IEXEC1_IOUT1_IEXEC2_IOUT2: Current source IEXC1 connected to pin
+ *	IOUT1, current source IEXC2 connected to pin IOUT2.
+ * @AD7793_IEXEC1_IOUT2_IEXEC2_IOUT1: Current source IEXC2 connected to pin
+ *	IOUT1, current source IEXC1 connected to pin IOUT2.
+ * @AD7793_IEXEC1_IEXEC2_IOUT1: Both current sources connected to pin IOUT1.
+ *	Only valid when the current sources are set to 10 uA or 210 uA.
+ * @AD7793_IEXEC1_IEXEC2_IOUT2: Both current sources connected to Pin IOUT2.
+ *	Only valid when the current ources are set to 10 uA or 210 uA.
+ */
+enum ad7793_current_source_direction {
+	AD7793_IEXEC1_IOUT1_IEXEC2_IOUT2 = 0,
+	AD7793_IEXEC1_IOUT2_IEXEC2_IOUT1 = 1,
+	AD7793_IEXEC1_IEXEC2_IOUT1 = 2,
+	AD7793_IEXEC1_IEXEC2_IOUT2 = 3,
+};
+
+/**
+ * enum ad7793_excitation_current - AD7793 excitation current selection
+ * @AD7793_IX_DISABLED: Excitation current Disabled.
+ * @AD7793_IX_10uA: Enable 10 micro-ampere excitation current.
+ * @AD7793_IX_210uA: Enable 210 micro-ampere excitation current.
+ * @AD7793_IX_1mA: Enable 1 milli-Ampere excitation current.
+ */
+enum ad7793_excitation_current {
+	AD7793_IX_DISABLED = 0,
+	AD7793_IX_10uA = 1,
+	AD7793_IX_210uA = 2,
+	AD7793_IX_1mA = 3,
+};
+
+/**
+ * struct ad7793_config - AD7793 configuration
+ * @clock_src: Clock source selection
+ * @burnout_current: If set to true the 100nA burnout current is enabled.
+ * @boost_enable: Enable boost for the bias voltage generator.
+ * @buffered: If set to true configure the device for buffered input mode.
+ * @unipolar: If set to true sample in unipolar mode, if set to false sample in
+ *		bipolar mode.
+ * @refsel: Reference voltage selection
+ * @bias_voltage: Bias voltage selection
+ * @exitation_current: Excitation current selection
+ * @current_source_direction: Excitation current direction selection
+ */
+struct ad7793_config {
+	enum ad7793_clock_source clock_src;
+	bool burnout_current;
+	bool boost_enable;
+	bool buffered;
+	bool unipolar;
+
+	enum ad7793_refsel refsel;
+	enum ad7793_bias_voltage bias_voltage;
+	enum ad7793_excitation_current exitation_current;
+	enum ad7793_current_source_direction current_source_direction;
+};
+
 struct ad7793_chip_info {
 	unsigned int id;
 	const struct iio_chan_spec *channels;
@@ -223,36 +327,36 @@ static int ad7793_calibrate_all(struct ad7793_state *st)
 				   ARRAY_SIZE(ad7793_calib_arr));
 }
 
-static int ad7793_check_platform_data(struct ad7793_state *st,
-	const struct ad7793_platform_data *pdata)
+static int ad7793_check_config(struct ad7793_state *st,
+			       const struct ad7793_config *cfg)
 {
-	if ((pdata->current_source_direction == AD7793_IEXEC1_IEXEC2_IOUT1 ||
-		pdata->current_source_direction == AD7793_IEXEC1_IEXEC2_IOUT2) &&
-		((pdata->exitation_current != AD7793_IX_10uA) &&
-		(pdata->exitation_current != AD7793_IX_210uA)))
+	if ((cfg->current_source_direction == AD7793_IEXEC1_IEXEC2_IOUT1 ||
+	     cfg->current_source_direction == AD7793_IEXEC1_IEXEC2_IOUT2) &&
+	    cfg->exitation_current != AD7793_IX_10uA &&
+	    cfg->exitation_current != AD7793_IX_210uA)
 		return -EINVAL;
 
 	if (!(st->chip_info->flags & AD7793_FLAG_HAS_CLKSEL) &&
-		pdata->clock_src != AD7793_CLK_SRC_INT)
+		cfg->clock_src != AD7793_CLK_SRC_INT)
 		return -EINVAL;
 
 	if (!(st->chip_info->flags & AD7793_FLAG_HAS_REFSEL) &&
-		pdata->refsel != AD7793_REFSEL_REFIN1)
+		cfg->refsel != AD7793_REFSEL_REFIN1)
 		return -EINVAL;
 
 	if (!(st->chip_info->flags & AD7793_FLAG_HAS_VBIAS) &&
-		pdata->bias_voltage != AD7793_BIAS_VOLTAGE_DISABLED)
+		cfg->bias_voltage != AD7793_BIAS_VOLTAGE_DISABLED)
 		return -EINVAL;
 
 	if (!(st->chip_info->flags & AD7793_HAS_EXITATION_CURRENT) &&
-		pdata->exitation_current != AD7793_IX_DISABLED)
+		cfg->exitation_current != AD7793_IX_DISABLED)
 		return -EINVAL;
 
 	return 0;
 }
 
 static int ad7793_setup(struct iio_dev *indio_dev,
-	const struct ad7793_platform_data *pdata,
+	const struct ad7793_config *cfg,
 	unsigned int vref_mv)
 {
 	struct ad7793_state *st = iio_priv(indio_dev);
@@ -260,7 +364,7 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 	unsigned long long scale_uv;
 	u32 id;
 
-	ret = ad7793_check_platform_data(st, pdata);
+	ret = ad7793_check_config(st, cfg);
 	if (ret)
 		return ret;
 
@@ -292,19 +396,19 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 	st->conf = 0;
 
 	if (st->chip_info->flags & AD7793_FLAG_HAS_CLKSEL)
-		st->mode |= AD7793_MODE_CLKSRC(pdata->clock_src);
+		st->mode |= AD7793_MODE_CLKSRC(cfg->clock_src);
 	if (st->chip_info->flags & AD7793_FLAG_HAS_REFSEL)
-		st->conf |= AD7793_CONF_REFSEL(pdata->refsel);
+		st->conf |= AD7793_CONF_REFSEL(cfg->refsel);
 	if (st->chip_info->flags & AD7793_FLAG_HAS_VBIAS)
-		st->conf |= AD7793_CONF_VBIAS(pdata->bias_voltage);
-	if (pdata->buffered || !(st->chip_info->flags & AD7793_FLAG_HAS_BUFFER))
+		st->conf |= AD7793_CONF_VBIAS(cfg->bias_voltage);
+	if (cfg->buffered || !(st->chip_info->flags & AD7793_FLAG_HAS_BUFFER))
 		st->conf |= AD7793_CONF_BUF;
-	if (pdata->boost_enable &&
-		(st->chip_info->flags & AD7793_FLAG_HAS_VBIAS))
+	if (cfg->boost_enable &&
+	    (st->chip_info->flags & AD7793_FLAG_HAS_VBIAS))
 		st->conf |= AD7793_CONF_BOOST;
-	if (pdata->burnout_current)
+	if (cfg->burnout_current)
 		st->conf |= AD7793_CONF_BO_EN;
-	if (pdata->unipolar)
+	if (cfg->unipolar)
 		st->conf |= AD7793_CONF_UNIPOLAR;
 
 	if (!(st->chip_info->flags & AD7793_FLAG_HAS_GAIN))
@@ -320,8 +424,8 @@ static int ad7793_setup(struct iio_dev *indio_dev,
 
 	if (st->chip_info->flags & AD7793_HAS_EXITATION_CURRENT) {
 		ret = ad_sd_write_reg(&st->sd, AD7793_REG_IO, 1,
-				pdata->exitation_current |
-				(pdata->current_source_direction << 2));
+				cfg->exitation_current |
+				(cfg->current_source_direction << 2));
 		if (ret)
 			goto out;
 	}
@@ -776,16 +880,139 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
 	},
 };
 
+static int ad7793_parse_excitation(struct device *dev,
+				   struct ad7793_config *cfg)
+{
+	static const char * const iout_pins[] = { "iout1", "iout2" };
+	u32 pins[] = { 1, 2 };
+	const char *names[2];
+	u32 val;
+	int ret;
+
+	ret = device_property_read_u32(dev, "adi,excitation-current-microamp",
+				       &val);
+	/* Excitation pins only matter if the excitation current is enabled */
+	if (ret)
+		return 0;
+
+	switch (val) {
+	case 10:
+		cfg->exitation_current = AD7793_IX_10uA;
+		break;
+	case 210:
+		cfg->exitation_current = AD7793_IX_210uA;
+		break;
+	case 1000:
+		cfg->exitation_current = AD7793_IX_1mA;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL,
+				     "Invalid excitation current: %u\n", val);
+	}
+
+	if (device_property_present(dev, "adi,excitation-pins")) {
+		ret = device_property_read_string_array(dev,
+							"adi,excitation-pins",
+							names,
+							ARRAY_SIZE(names));
+		if (ret != ARRAY_SIZE(names))
+			return dev_err_probe(dev, ret < 0 ? ret : -EINVAL,
+					     "Invalid adi,excitation-pins\n");
+
+		/* IOUT pin number for IEXC1 and IEXC2 */
+		for (unsigned int i = 0; i < ARRAY_SIZE(names); i++) {
+			ret = match_string(iout_pins, ARRAY_SIZE(iout_pins),
+					   names[i]);
+			if (ret < 0)
+				return dev_err_probe(dev, ret,
+						     "Invalid adi,excitation-pins\n");
+
+			pins[i] = ret + 1;
+		}
+	}
+
+	if (pins[0] == 1 && pins[1] == 2)
+		cfg->current_source_direction = AD7793_IEXEC1_IOUT1_IEXEC2_IOUT2;
+	else if (pins[0] == 2 && pins[1] == 1)
+		cfg->current_source_direction = AD7793_IEXEC1_IOUT2_IEXEC2_IOUT1;
+	else if (pins[0] == 1)
+		cfg->current_source_direction = AD7793_IEXEC1_IEXEC2_IOUT1;
+	else
+		cfg->current_source_direction = AD7793_IEXEC1_IEXEC2_IOUT2;
+
+	return 0;
+}
+
+static int ad7793_parse_fw(struct device *dev, struct ad7793_config *cfg,
+			   unsigned int *vref_mv)
+{
+	static const char * const vbias_pins[] = { "ain1", "ain2", "ain3" };
+	static const char * const refin_names[] = { "refin", "refin2" };
+	unsigned long rate;
+	struct clk *clk;
+	int ret;
+
+	cfg->refsel = AD7793_REFSEL_INTERNAL;
+	for (unsigned int i = 0; i < ARRAY_SIZE(refin_names); i++) {
+		ret = devm_regulator_get_enable_read_voltage(dev, refin_names[i]);
+		if (ret < 0 && ret != -ENODEV)
+			return dev_err_probe(dev, ret, "Failed to get %s voltage\n",
+					     refin_names[i]);
+		if (ret == -ENODEV)
+			continue;
+
+		cfg->refsel = i;
+		*vref_mv = ret / 1000;
+		break;
+	}
+
+	if (cfg->refsel == AD7793_REFSEL_INTERNAL)
+		*vref_mv = 1170;
+
+	clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(clk))
+		return dev_err_probe(dev, PTR_ERR(clk), "Failed to get clock\n");
+
+	if (clk) {
+		rate = clk_get_rate(clk);
+		if (rate == 64 * HZ_PER_KHZ)
+			cfg->clock_src = AD7793_CLK_SRC_EXT;
+		else if (rate == 128 * HZ_PER_KHZ)
+			cfg->clock_src = AD7793_CLK_SRC_EXT_DIV2;
+		else
+			return dev_err_probe(dev, -EINVAL,
+					     "Invalid clock rate: %lu Hz\n", rate);
+	}
+
+	if (device_property_present(dev, "adi,vbias-pin")) {
+		ret = device_property_match_property_string(dev, "adi,vbias-pin",
+							    vbias_pins,
+							    ARRAY_SIZE(vbias_pins));
+		if (ret < 0)
+			return dev_err_probe(dev, ret, "Invalid adi,vbias-pin\n");
+
+		cfg->bias_voltage = AD7793_BIAS_VOLTAGE_AIN1 + ret;
+		cfg->boost_enable = device_property_read_bool(dev,
+							      "adi,vbias-boost-enable");
+	}
+
+	cfg->burnout_current = device_property_read_bool(dev,
+							 "adi,burnout-currents-enable");
+	cfg->buffered = !device_property_read_bool(dev, "adi,buffer-disable");
+	cfg->unipolar = !device_property_read_bool(dev, "bipolar");
+
+	return ad7793_parse_excitation(dev, cfg);
+}
+
 static int ad7793_probe(struct spi_device *spi)
 {
+	static const char * const supplies[] = { "avdd", "dvdd" };
 	struct device *dev = &spi->dev;
-	const struct ad7793_platform_data *pdata = dev_get_platdata(dev);
+	struct ad7793_config cfg = { };
 	struct ad7793_state *st;
 	struct iio_dev *indio_dev;
-	int ret, vref_mv = 0;
-
-	if (!pdata)
-		return dev_err_probe(dev, -ENODEV, "no platform data?\n");
+	unsigned int vref_mv;
+	int ret;
 
 	if (!spi->irq)
 		return dev_err_probe(dev, -ENODEV, "no IRQ?\n");
@@ -798,15 +1025,14 @@ static int ad7793_probe(struct spi_device *spi)
 
 	ad_sd_init(&st->sd, indio_dev, spi, &ad7793_sigma_delta_info);
 
-	if (pdata->refsel != AD7793_REFSEL_INTERNAL) {
-		ret = devm_regulator_get_enable_read_voltage(dev, "refin");
-		if (ret < 0)
-			return ret;
+	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(supplies),
+					     supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable supplies\n");
 
-		vref_mv = ret / 1000;
-	} else {
-		vref_mv = 1170; /* Built-in ref */
-	}
+	ret = ad7793_parse_fw(dev, &cfg, &vref_mv);
+	if (ret)
+		return ret;
 
 	st->chip_info =
 		&ad7793_chip_info_tbl[spi_get_device_id(spi)->driver_data];
@@ -821,7 +1047,7 @@ static int ad7793_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
-	ret = ad7793_setup(indio_dev, pdata, vref_mv);
+	ret = ad7793_setup(indio_dev, &cfg, vref_mv);
 	if (ret)
 		return ret;
 
@@ -842,9 +1068,24 @@ static const struct spi_device_id ad7793_id[] = {
 };
 MODULE_DEVICE_TABLE(spi, ad7793_id);
 
+static const struct of_device_id ad7793_of_match[] = {
+	{ .compatible = "adi,ad7785", .data = &ad7793_chip_info_tbl[ID_AD7785] },
+	{ .compatible = "adi,ad7792", .data = &ad7793_chip_info_tbl[ID_AD7792] },
+	{ .compatible = "adi,ad7793", .data = &ad7793_chip_info_tbl[ID_AD7793] },
+	{ .compatible = "adi,ad7794", .data = &ad7793_chip_info_tbl[ID_AD7794] },
+	{ .compatible = "adi,ad7795", .data = &ad7793_chip_info_tbl[ID_AD7795] },
+	{ .compatible = "adi,ad7796", .data = &ad7793_chip_info_tbl[ID_AD7796] },
+	{ .compatible = "adi,ad7797", .data = &ad7793_chip_info_tbl[ID_AD7797] },
+	{ .compatible = "adi,ad7798", .data = &ad7793_chip_info_tbl[ID_AD7798] },
+	{ .compatible = "adi,ad7799", .data = &ad7793_chip_info_tbl[ID_AD7799] },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ad7793_of_match);
+
 static struct spi_driver ad7793_driver = {
 	.driver = {
 		.name	= "ad7793",
+		.of_match_table = ad7793_of_match,
 	},
 	.probe		= ad7793_probe,
 	.id_table	= ad7793_id,
diff --git a/include/linux/platform_data/ad7793.h b/include/linux/platform_data/ad7793.h
deleted file mode 100644
index 7c697e58f02a..000000000000
--- a/include/linux/platform_data/ad7793.h
+++ /dev/null
@@ -1,111 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * AD7792/AD7793 SPI ADC driver
- *
- * Copyright 2011 Analog Devices Inc.
- */
-#ifndef __LINUX_PLATFORM_DATA_AD7793_H__
-#define __LINUX_PLATFORM_DATA_AD7793_H__
-
-/**
- * enum ad7793_clock_source - AD7793 clock source selection
- * @AD7793_CLK_SRC_INT: Internal 64 kHz clock, not available at the CLK pin.
- * @AD7793_CLK_SRC_INT_CO: Internal 64 kHz clock, available at the CLK pin.
- * @AD7793_CLK_SRC_EXT: Use external clock.
- * @AD7793_CLK_SRC_EXT_DIV2: Use external clock divided by 2.
- */
-enum ad7793_clock_source {
-	AD7793_CLK_SRC_INT,
-	AD7793_CLK_SRC_INT_CO,
-	AD7793_CLK_SRC_EXT,
-	AD7793_CLK_SRC_EXT_DIV2,
-};
-
-/**
- * enum ad7793_bias_voltage - AD7793 bias voltage selection
- * @AD7793_BIAS_VOLTAGE_DISABLED: Bias voltage generator disabled
- * @AD7793_BIAS_VOLTAGE_AIN1: Bias voltage connected to AIN1(-).
- * @AD7793_BIAS_VOLTAGE_AIN2: Bias voltage connected to AIN2(-).
- * @AD7793_BIAS_VOLTAGE_AIN3: Bias voltage connected to AIN3(-).
- *	Only valid for AD7795/AD7796.
- */
-enum ad7793_bias_voltage {
-	AD7793_BIAS_VOLTAGE_DISABLED,
-	AD7793_BIAS_VOLTAGE_AIN1,
-	AD7793_BIAS_VOLTAGE_AIN2,
-	AD7793_BIAS_VOLTAGE_AIN3,
-};
-
-/**
- * enum ad7793_refsel - AD7793 reference voltage selection
- * @AD7793_REFSEL_REFIN1: External reference applied between REFIN1(+)
- *	and REFIN1(-).
- * @AD7793_REFSEL_REFIN2: External reference applied between REFIN2(+)
- *	and REFIN1(-). Only valid for AD7795/AD7796.
- * @AD7793_REFSEL_INTERNAL: Internal 1.17 V reference.
- */
-enum ad7793_refsel {
-	AD7793_REFSEL_REFIN1 = 0,
-	AD7793_REFSEL_REFIN2 = 1,
-	AD7793_REFSEL_INTERNAL = 2,
-};
-
-/**
- * enum ad7793_current_source_direction - AD7793 excitation current direction
- * @AD7793_IEXEC1_IOUT1_IEXEC2_IOUT2: Current source IEXC1 connected to pin
- *	IOUT1, current source IEXC2 connected to pin IOUT2.
- * @AD7793_IEXEC1_IOUT2_IEXEC2_IOUT1: Current source IEXC2 connected to pin
- *	IOUT1, current source IEXC1 connected to pin IOUT2.
- * @AD7793_IEXEC1_IEXEC2_IOUT1: Both current sources connected to pin IOUT1.
- *	Only valid when the current sources are set to 10 uA or 210 uA.
- * @AD7793_IEXEC1_IEXEC2_IOUT2: Both current sources connected to Pin IOUT2.
- *	Only valid when the current ources are set to 10 uA or 210 uA.
- */
-enum ad7793_current_source_direction {
-	AD7793_IEXEC1_IOUT1_IEXEC2_IOUT2 = 0,
-	AD7793_IEXEC1_IOUT2_IEXEC2_IOUT1 = 1,
-	AD7793_IEXEC1_IEXEC2_IOUT1 = 2,
-	AD7793_IEXEC1_IEXEC2_IOUT2 = 3,
-};
-
-/**
- * enum ad7793_excitation_current - AD7793 excitation current selection
- * @AD7793_IX_DISABLED: Excitation current Disabled.
- * @AD7793_IX_10uA: Enable 10 micro-ampere excitation current.
- * @AD7793_IX_210uA: Enable 210 micro-ampere excitation current.
- * @AD7793_IX_1mA: Enable 1 milli-Ampere excitation current.
- */
-enum ad7793_excitation_current {
-	AD7793_IX_DISABLED = 0,
-	AD7793_IX_10uA = 1,
-	AD7793_IX_210uA = 2,
-	AD7793_IX_1mA = 3,
-};
-
-/**
- * struct ad7793_platform_data - AD7793 platform data
- * @clock_src: Clock source selection
- * @burnout_current: If set to true the 100nA burnout current is enabled.
- * @boost_enable: Enable boost for the bias voltage generator.
- * @buffered: If set to true configure the device for buffered input mode.
- * @unipolar: If set to true sample in unipolar mode, if set to false sample in
- *		bipolar mode.
- * @refsel: Reference voltage selection
- * @bias_voltage: Bias voltage selection
- * @exitation_current: Excitation current selection
- * @current_source_direction: Excitation current direction selection
- */
-struct ad7793_platform_data {
-	enum ad7793_clock_source clock_src;
-	bool burnout_current;
-	bool boost_enable;
-	bool buffered;
-	bool unipolar;
-
-	enum ad7793_refsel refsel;
-	enum ad7793_bias_voltage bias_voltage;
-	enum ad7793_excitation_current exitation_current;
-	enum ad7793_current_source_direction current_source_direction;
-};
-
-#endif /* IIO_ADC_AD7793_H_ */

-- 
2.56.0

