Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877483F44E7;
	Mon, 10 Aug 2026 15:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.135.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786374392; cv=fail; b=ep9t9b2eefU56jN7DX18tn9St8P0UGU8SkhnoOpqvo09c2huHyAujYmyxDFqaknyh4CPjw3+LgVm9hxGclhtJkGTNFfLp8Rg1rHT1s31RSg9pIPJAHEldQaIdjuMUpjayJIPzka+cyfWLZftSBxpNRSdl3mrFJFgLXEbyjxMZ58=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786374392; c=relaxed/simple;
	bh=AK9yBOL+N3ujc9OOyqRZMKDJDC5VsgIYD/HHi5dsFlk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=oqclqXXp29mbAu8Jkwo8iqVBih+ZVEp48JvzphRPMRhmKN9swrZO3aG2XWieuh3ssEEMBhxqa+6d15n8FjP7R/9t5dr/LnxTjtSV0Koj9EnMZnip1b9JYMQeYiAr3EiuuBgmEjJJIUkbq4RE917huIeEHWkAZVX+0r4dgZVXaxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KaWG2y4Y; arc=fail smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KaWG2y4Y"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67ACsEWW2266401;
	Mon, 10 Aug 2026 11:06:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LdG9C
	IvDKCtZtmcIBqrL6OMIxdjflJGE8j4SSBX1OtA=; b=KaWG2y4YXCi/16eotkoBA
	H3UbilXuhd2OYcGD56mudWQ2qg5qZkMb2JP8dPE/8offU3xip8tX5X1nHbqGHK2s
	413M5tRfZ+S0FeWfBceMYpMRpLDkusdKfqFk592pc3VuFxaMwUFKgjU78cNvcMd6
	uL0xai4D3rSbfnx3PU/beokVJjujpwAOlzFAlm/cW3CtqRxhuSeX1HlO4MP1tbfE
	B0hq+pxgsRfu/a8So4O96ZUmilX0WLvbOUqdaEmGKOjjNkd/hpaljM9xLyUoM6tz
	leKxiOyPNnFjTXwmKkFeXsSOgxRAsdTiYasPoRm2Qo8I2hJKq5TCRLqE7YJ5KOhu
	Q==
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010056.outbound.protection.outlook.com [52.101.56.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fycsdgy4p-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 11:06:14 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KXPwcatDvpFaKfMA89TpJAIpldTNz/UGYrD3VwsdHr49p8oitilWMJLYpuBk41caCPAzzFlVacnL9bG4Ytmst3dMk1mUN1IBDOZBLKAWejBLMHWXsJnmsEqRWsc1lUTapDo8TYO0LMdY4S71PZJJ2mH0eNS/Hh4eLOeUWSNjT9N2JHoMekXcyVPexhc+Gs1iZ59CJzs2zrxByo0S8rUmTBzp8bcGzUBJPWsjnNLyg3iwenN5epBYPt0FPXICToEqaOZqjTQ6fJc7FZT/KIogHLCUcoZTlgQtNBgK535+X9WHRvvVMFesTcp1u2shhsqrBls3sRP9fqR++ESxM4g7Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdG9CIvDKCtZtmcIBqrL6OMIxdjflJGE8j4SSBX1OtA=;
 b=pUxyH0nCb5la9Aan+BGSxET3kjLkAt1xJU5SuPxo45moqFvnjll8208bYQ4yHSWwyX1khh69vAPuo0l4L7p/HWBKmxIFrQZasaut5TZencqIQhzYX7HIsGssuPzVTXIfts5bghFH+r71uLN13zQ2jhmF1ygX1y5uWtZozSGfr4n1iddw8axabFGwN2OrSVrDjN7BjAn/iRbz+ukklVuOi9UX3Gr5pDAiHiCmS/P2onAcliLCzrVmDPuyK8QKCsBWm8nzyk3rG8/y1Uo6Y7XSzwEMIxxuOQqbHtlk/onolPsmfD2gfhqRvEzfErg/6jtPA1DlU0qqS6xJc0GHgNd9ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by BL4PR03MB8038.namprd03.prod.outlook.com (2603:10b6:208:58d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 15:06:10 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 15:06:09 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Date: Mon, 10 Aug 2026 16:06:50 +0100
Subject: [PATCH v2 9/9] dmaengine: Drop legacy bus width fields from
 dma_slave_caps
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260810-dmaengine-support-wider-dma-masks-v2-9-1f7b798d035f@analog.com>
References: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
In-Reply-To: <20260810-dmaengine-support-wider-dma-masks-v2-0-1f7b798d035f@analog.com>
To: dmaengine@vger.kernel.org, linux-iio@vger.kernel.org
Cc: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786374404; l=3623;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=AK9yBOL+N3ujc9OOyqRZMKDJDC5VsgIYD/HHi5dsFlk=;
 b=jD9XgF7LsKt8chb3+NPLnUadxRNl1zIh4spzUpHvqzpBm3VGLY5GYlR/dDKq83SWDLNg8nGsw
 5XrB5BlBisgBgovyaDWoM+hN2hPGjli8DmfVF9pWn1RPdZwT5tKAXN9
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MA3P292CA0026.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:47::11) To SJ0PR03MB5469.namprd03.prod.outlook.com
 (2603:10b6:a03:28a::17)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|BL4PR03MB8038:EE_
X-MS-Office365-Filtering-Correlation-Id: 901a59e0-893a-464c-c9eb-08def6f0e91a
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|18002099003|22082099003|56012099006|10067099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
 +a9OYZeKcrLI/NZqabRe/NiORlbwAQQGVjaAo1OeXAXmZtQbICakokJ/lxclGYPGECvY5Mb8zL2BCSqfWoF9ei9aImEDAbVLHJehcnpfIgJdkANPudAvm1rS4WR9pnbXTwoSAI5xC+HAyc0JCQzocKTsgB+vh7oNHuFWgIoej3p7ggIbVC/fMJdwToDbiS76gpU+VS3RvtWpCBAkO6mWmPttwCxHHrTpvgHdxC3FvNWbp06ypkiQBV7Xn8F5jGYIqfSuaCfsakpPydeBKRk8lcRDu8F4fYNYcqEErSX6PqYpdbTGMksRMqSmKpYnaKiVt6+EkxD8sYPiNDkD8CjLYA/7ugvtJC/lWZXpjIynFycwInfcNprO1C0UQeAswFJdNXoVcxV7dwxVvT8OQy1+xZIe++sofqz1nyZX5p4gOnkJ3royz/Mdd+R4Ey596Hz5plEyvHf5j7pBAblYutAiJ2jtOtLR3w2Xf5m8HWEyFZQtFq0XZtj9mHsWJW7Kp9iS9jkyBAIa9vv2VDVMLzIbRnrQtX/SmAUpkHN16b76hl/gAmqDvo8MGCnzppC9simLMIYX5nvgoyeG3orqQJ9mRcU0oz1nca6DVbV7GDQsFxysb1d7fqro3oWq5hC4MoUs9Y3tbU+TV51jMos7Fu0bRbhXVCB2D2xB9+5VVpiN5hw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?WlNZMUQySEpHYTIwVkpnUHlYaWxqcTU1R0RqQk1tOHNyRlVzcmFiTkZDKy94?=
 =?utf-8?B?bGtleUpQZTZIaXR4eDZ2QVhDbXFhdDN5VXhhU2FOZkhZZWFZbDl1c01kb05w?=
 =?utf-8?B?MlVnc0lOZVhVd1ZzKzFoRFpYaHl1bmN0T3FGRmFmMUpiWDV2ZlVzZmQzQlVo?=
 =?utf-8?B?dlF4anJSMEtmYzhRdGNXQ09sOS8rYlYzR3JnYVgvditETERxWVIxSTVvc3BJ?=
 =?utf-8?B?RXExRjdVdkFSclJ1TGU5dldLenlUMERITjM0dnplT0N5dmNkNlhPdlVrTWRq?=
 =?utf-8?B?alV5ejFQeFoxelY2eUdQdVlWZnVwQlplZDF3VXk0dzhoUnhSOWNEMjdhd3o0?=
 =?utf-8?B?QjlVdjNOazJVbU1ybGV3UnY2VXRhSWh6THlMVEtJYXdoZVFZTVhYUExuM1ZD?=
 =?utf-8?B?UCs1ODB6MUFpaHpmajlnZHRValE3SFhDQ1lla3EwNG5DOFp5Y3M1dGk5RFlw?=
 =?utf-8?B?M2FyeStiWlAxTW1XMDkzb0lpenhnZEhTblhvNHhtTnJxeUdkNHdGa1BNeS9H?=
 =?utf-8?B?Y1BYVTh1NjhreExJV25QOVUrSi94ZGIvZDhuRk5vTmhoTC9CZForN0trS0I4?=
 =?utf-8?B?SnRiZUxsV0RINmNlaFN0WU9zRXF4RUs2QXdqU1JZVTZ5YUZJTnNqdDNhODhW?=
 =?utf-8?B?dFIxbXhNakZKOFNPK2xzakpmUzJsbmFFWE5DSi9QR1BpVGJ3NFlaV3lQNDdV?=
 =?utf-8?B?SFVDUWFjNE9JbFJzY25tbHRGeGZJcDJ3OTYyeUhKSDJ5ZE9BZTdWbnIrRmRv?=
 =?utf-8?B?V1Y2eTFuUytKcFhwa0g4U1R5cjd6T3ZZbGdCc2RTeEFlb05DbG9rMTVwZHNO?=
 =?utf-8?B?V1dQZ2oyYmJDV1lBUzNuRDhUZjE0NC9VSkVCMG5qS0VSbnFwaHE5Y0txbElR?=
 =?utf-8?B?SDhvVml0cndZQ1VBNlYrTXAvbmwrTHMzUXhSNEt2YnluanB4dzM3RHNGdis1?=
 =?utf-8?B?bTB2YWNmd1VVYzRONjRiZFIxQ1p4UFgwTE1WM2FjdzkvZWhvd0Z5TWw2QUFY?=
 =?utf-8?B?QTBGZS9HRXpwcmlWUUxYRktGTFk3bVVVbHFBTndjV241OGMwYjhVeEo3cmMw?=
 =?utf-8?B?dG85RXBXajdheDlPeDdzMlp6KzV0UEZ0M2lwcGFkMUZSaWpxUEttMm00cmY3?=
 =?utf-8?B?ZTh4Q21GMlRRUVJBaUwxL2xBTnlqV1Y3R2JDc3djb0swYm5xd1F0c0Q5NE8x?=
 =?utf-8?B?SDJyNGVHTm91NHI4L0xWaDBaZW4rMk00QkFpSGhxS0dGTE1zUDBneHdTaGw2?=
 =?utf-8?B?cnJsZkFzUWJHSEkyRWVQZVllbldNSERLMnlHRzFxNUthSlNFbnAyeWFkWlFI?=
 =?utf-8?B?V0dNNGxxQXpzSXpRRmVvZDBIcFowSnNnNm81dWxlSEMvQ0tPenBRLzA2Mld4?=
 =?utf-8?B?cm9XNm5KOVA0czhOZWxtRkp6OWozVlRXbFpYQVREZDljdDZoOXkzeHIzV3hF?=
 =?utf-8?B?c0VRYVFUYmx6bEFiLzUvV3hVcEJzcHNWTllCR3Jpei92MEhRWk1sSGNZVlZx?=
 =?utf-8?B?KzFZMXljTUdPZ3pTL1pqOWlSSVhTU3owb1VybWpNZldwWUhmOHJhRVViMnFJ?=
 =?utf-8?B?NmFEaXlmMWZKS0dQazJiUFVqQ0dPZDJEdVhRRmsyR05zNm04TFhYWEFBdllP?=
 =?utf-8?B?TU9mb1JMV2tlMGRSRE14eUNSeEcwc2JaaHdPbHV1ZmZyUEpzWE5RKytMSng1?=
 =?utf-8?B?UktOdHFsMG9YTEVCUVJKTW92L05FUmhocmRLelAzeDRhTDNoNlhyZXhUNTJw?=
 =?utf-8?B?Tkc5VGkrRVF6WkFzSkx2eWxkTlNaN3Iramp1S3FlSWdqYmE1QmxtTjFmdEdJ?=
 =?utf-8?B?MExUaW1POC95bmNBQjJKbXl4NlFkb0dUeTh0QUprZmc1Mml6dk56SDRqN0xz?=
 =?utf-8?B?YTl4S29ob1lyRmh1cHVsSGpoaklxcmNzZlhnRkRPNkVseU8rd29waFppV0R4?=
 =?utf-8?B?d2o2QzNHNXFoVTYreFlLb3orZ0RlZGU4cGxHT0Nqd1M2emEyWXV4WStCRWxj?=
 =?utf-8?B?UlpvRmc0bW41bXBNMmVsWFRydWs0Ykc5ZEp6cmlJM0hreForOU5YNDUxVUxU?=
 =?utf-8?B?MGtrMzBQRy9vanpYMlhvOWIrNXFhNndVck5JSGw2K1VZemRLUzVNRjBVQ3Jn?=
 =?utf-8?B?Yk5aUWNOK0d5UmlaMXh6LzV5VmhvZnkyaFdjWUw2b3hPN2w3QXMwcG9Oa0pJ?=
 =?utf-8?B?THhxUTVWK0FXN09mRDdWWWtPZW1kQWl6UHJqOWRnVkFtUC8ySk0wcG1GM1Vu?=
 =?utf-8?B?NnFoRnRNb0t1dDYrTXZxQ2hDVFN2cEFoQ3l6SnljM3lWWGtuNDkxeitvSGxo?=
 =?utf-8?B?RjZRRGtxdmZwVkVONVFOOWNWMXdFWjdGZ0tjUFoyQ2hXVWNibDZsdz09?=
X-Exchange-RoutingPolicyChecked:
	eSduvu2+HrrzYbTuSv4YzsaNu5vcgQA3Wzc5I3oSkaBHY2Z6N+UrKrMNbOhk80rLGRTA5j2mZi9n4AlaaGEhtZlT/cT96wlQxylzbQDp19MQ/tmxP1UgkAreuVddirAbhWEzATbTX4W/B/Sa9qrYu3mXXjpCG3kPkcY/GnzT84sYl7aNjnZWoopskNCHg6pJ+5nuODgBJj8bQ0SeINZHpAM7KVEcnbzVhDtFBEdWevGm66MB1vTaUNYrsoqb96Xad76ov1gDvjwZtHmbprYipzuzLX+qx71BARWWmFQjHYhFaTl4LZ0mXqMYXpBtraZ2hWv8QwxNeF4PIjfCDSUM0w==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 901a59e0-893a-464c-c9eb-08def6f0e91a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 15:06:09.8131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1h3+MYui9lQHv6lobxBVnv87THB4apAbpELfBQTZ5HXd5zu9nIU8IkgjJM6W5OrVYi9wK26G4Q9/48cWFmElwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR03MB8038
X-Proofpoint-GUID: moolN6R08CAhFPDaEcCePwuCVIUOBcrx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfXyAxM/XeLYWIH
 GTepa7eLtqBo3kr+R3ZlvC/bTzqI9TwpvRgDiUNUIO7/heFpwTzel/+08lQKDtkcfDdZfHTrZwT
 it4apdqPG+fZEJ8YfTkbGz8wMbrNGg75PVFuH9uDKXJn4YmymKhL
X-Authority-Analysis: v=2.4 cv=MbhcfZ/f c=1 sm=1 tr=0 ts=6a79e8e6 cx=c_pps
 a=T1Jff0mhgTaaoho+8HaPfw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22
 a=gAnH3GRIAAAA:8 a=-vuXWG5NF3_wGEhM7nIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDEzMCBTYWx0ZWRfXwHRdqH642O/O
 ExZigG/N4IsYWG57Le0+rk+zA9IoX0ToKKit+1uaTuq//IWiVX6aHvZil1Qd/Z3kf7vNEB0Jdli
 W0RCPTZecENtHCqFu+i317QS8iBq+O5Dl/c5+bf5pYEnwwuIq0Zl4bjJRKl8G7Y+iP8RvLvCj9s
 gilO51KVjzMQHcvSaOEH5qIBQfk6QEkyDU/PTXk07i7LhJpVbD50wjGY8pnFApZvFLAw8HwetYc
 W07SoZ5fMAyQc9XQ64HAjhQ3sonleKwf0hq2PomR7R2x1bf9HFDYdtciboQXjZrICUbpGa/u65N
 Ys7QwsNm3QaTst8Nrh8u2J2htAEe40dW12ipilvFkyuXOKWYuBFNVA1NcSzsPUpm+FlCOsyBfrj
 0JMDUTc9kV021FrFaoBZFBByajjkXxPURbko8WGeI7DuK0CCcf5zhUerVLs01PNoUIqrK/b83J7
 SUU1yRkIB0L+3/sp6QA==
X-Proofpoint-ORIG-GUID: moolN6R08CAhFPDaEcCePwuCVIUOBcrx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100130

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

Signed-off-by: Nuno Sá <nuno.sa@analog.com>
---
 drivers/dma/dmaengine.c   |  2 --
 include/linux/dmaengine.h | 16 ++--------------
 2 files changed, 2 insertions(+), 16 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index a80a84cf87eb..36e9b6ddd88d 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -592,7 +592,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 	if (!device->directions)
 		return -ENXIO;
 
-	caps->src_addr_widths = device->src_addr_widths;
 	if (bitmap_empty(device->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX)) {
 		bitmap_zero(caps->src_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
 		bitmap_from_arr32(caps->src_bus_widths,
@@ -602,7 +601,6 @@ int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps)
 			    DMA_SLAVE_BUSWIDTH_MAX);
 	}
 
-	caps->dst_addr_widths = device->dst_addr_widths;
 	if (bitmap_empty(device->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX)) {
 		bitmap_zero(caps->dst_bus_widths, DMA_SLAVE_BUSWIDTH_MAX);
 		bitmap_from_arr32(caps->dst_bus_widths,
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8697583e2ed3..4efaa27e9f7e 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -503,9 +503,7 @@ enum dma_residue_granularity {
  * @src_bus_widths: bitmap of source bus widths the channel supports.
  *	Width is specified in bytes, e.g. for a channel supporting
  *	a width of 4 the bitmap should have bit 4 set.
- * @src_addr_widths: legacy bit mask of source bus widths the channel supports.
  * @dst_bus_widths: bitmap of destination bus widths the channel supports.
- * @dst_addr_widths: legacy bit mask of destination bus widths the channel supports.
  * @directions: bit mask of slave directions the channel supports.
  *	Since the enum dma_transfer_direction is not defined as bit flag for
  *	each type, the dma controller should set BIT(<TYPE>) and same
@@ -524,14 +522,8 @@ enum dma_residue_granularity {
  * resubmitted multiple times
  */
 struct dma_slave_caps {
-	struct {
-		DECLARE_DMA_BUS_WIDTHS(src_bus_widths);
-		u32 src_addr_widths;
-	};
-	struct {
-		DECLARE_DMA_BUS_WIDTHS(dst_bus_widths);
-		u32 dst_addr_widths;
-	};
+	DECLARE_DMA_BUS_WIDTHS(src_bus_widths);
+	DECLARE_DMA_BUS_WIDTHS(dst_bus_widths);
 	u32 directions;
 	u32 min_burst;
 	u32 max_burst;
@@ -1922,8 +1914,6 @@ dma_slave_caps_clear_src_width(struct dma_slave_caps *caps,
 			       enum dma_slave_buswidth width)
 {
 	__clear_bit(width, caps->src_bus_widths);
-	if (width < DMA_SLAVE_BUSWIDTH_32_BYTES)
-		caps->src_addr_widths &= ~BIT(width);
 }
 
 /**
@@ -1936,8 +1926,6 @@ dma_slave_caps_clear_dst_width(struct dma_slave_caps *caps,
 			       enum dma_slave_buswidth width)
 {
 	__clear_bit(width, caps->dst_bus_widths);
-	if (width < DMA_SLAVE_BUSWIDTH_32_BYTES)
-		caps->dst_addr_widths &= ~BIT(width);
 }
 
 static inline int __dma_set_bus_widths(unsigned long *bus_widths,

-- 
2.55.0

