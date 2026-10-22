Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792679794;
	b=MfP22zmHVfdtBxvWbW+VC/0pyQTZj/qKXPwhTRY20S+s+83/9l5GUMX4ngfEntHdOqei
	 fwUgiM54V+f7e/d+K7X+2go7dMUiqq2JAXyPd5yRMqQEiE1KifqQDpfwgB6ZY7Gms4zG0
	 xk1YwjcLsjzHzBD6bDfEl6WNtjOGiLvoH0OQ56hUyiwS17GD1P+uBmZLnAqklKakt4vTo
	 FyYSVa4G+5Khp1cPdD2WPPtHYmGO8RnTXHmjftxnXo4XGKYVnRVMYVWEu7W/q3bCNTnmg
	 Oa4N/2dh9DSRrtKJuGOQ74mWHLd6/3Zbx7FmOIpqX4kaGVDdYNjkEIzkmRyS470nc7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792679794;
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
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=861aIYq/9wkdzN0iYc5c8DQAVm2U4zR8hTikYxyv+R0=;
	b=CaqzYLnMwpETPgp5ORhQ931E4WW6sPrqFaK1B4im5c4kENr6U8r8WvqXNpHxYJWGK6l5
	 vskCRQGLZ3VHBlontPF+N7F6ZEw2rrz+wPNmtj7iGZdrEPcacPhJa1Vst+ZcZFQoxemYy
	 rEglxBBoBq9NXJ8xPrV234qGnFD0EflstURjsdvLAbOwu7tmE3zGJSKwL4eZGe4wHioMO
	 MJK4hvmR0aWfuVQoKerNoyD+lTROgwUSyGYe1m561edSJRSPkTUOXcvbBqStv9DGQtP0Y
	 wRIRK6fw3NvD2SmZ1NTGzaRrs4HY79ju3yxsoKW6/x7Iq1qDMEIrY77Wp7iPla3jx3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=N91AJ+o+;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=pfo7kIZQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80765606A319;
	Thu, 22 Oct 2026 14:36:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80765606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=N91AJ+o+;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=pfo7kIZQ
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69MECR0u1631570;
	Thu, 22 Oct 2026 10:36:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=861aIYq/9wkdzN0iYc5c8DQAVm2U4zR8hTikYxyv+R0=; b=N91AJ+o
	+ZePD91KZWQeHvxCTTXWCUaCW74KpAC1Rh3SJHmeMr0M3mebj6hTctL66qXJP2Hu
	Z3/0B91ZycL2WTbSFtZfioXpIDbe9UZPsuYkWKaoDYK2fH8SEkNGNHOsV6qe/wuT
	mgXiGRZJBTBNWa3KP+Ub/jYI32GUF8nOQq///gNtU5+B+i2yvqZhw8f5+rFhO6BU
	s0brfuhkamRFAqaB8QX5KqRU+jCvtV0KesNz/lKPx+2g4HNJF/Ne9tcMDXE72bMC
	cayBp39UccCIfUy1S8/5YA6KXhmf7D18E7j7QVOfUjhHGCuhoy6DF3qq1VUq2slT
	M6kpytvvzU29IzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=861aI
	Yq/9wkdzN0iYc5c8DQAVm2U4zR8hTikYxyv+R0=; b=pfo7kIZQNSVJjb0K4iDD1
	0EeMYDUg14JSoUpGIsghf2wzc2L+aFruNo4t36xNcvDBcF3jd3OQy8pZ1AtlVDHA
	PAvt2ipMxOJU+c5uy2cLbMD8JYsrA+GAdFcpTkPbiXjzLws+wCVXixnMVyHqUmQ7
	toKQ8OhdK5YU5CAT2pgM93twG+Ir/UMtEqbizyYHaQ9spEP+Y722vxTUU9jEsthr
	R3kNZg5RRLCmmLRpm2a6MPWM0NI1MyuVkFl16Fm6wxvDHjluiuFxrVQtv9vqkxn5
	h5OLqUtnudammSKLsoo+3IlUTcyWA+TPaSrj9CrU/XRX6WAQZdasz881un2JEmNR
	Q==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010036.outbound.protection.outlook.com [52.101.201.36])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hf927bhdv-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 22 Oct 2026 10:36:14 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ch04YGvlJH4WqfunAeQEDXmX/z+2zsf+EC36TDCO+yOtuvlq6PwOxf+kj0SnFK9AaWG4oG04IZAh7t8Q0LmbFg+11joq2RuAZ+5KfowP3aBxnSFqMFeUt0q6WPd86RBeEF5WC5RRb1p9eDpp4/fYIY803CB0npvN5XRDpJ5s6iyqPOq29JTIKOfstkVN57VCs+gKTHKAZVVqQsxCyxhyH48ve1x2Cl/eapZyTnoiF2m2UzhnrRJh97ZqpQv19gpmFnzRuz7o4dMHaUFV5JuCOHMeDoAXJzw+murIC9CT6eMg/9ZtwxkLMrgXbq+1d/HGz5/XMUmD+f3BLZ447DLNBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=861aIYq/9wkdzN0iYc5c8DQAVm2U4zR8hTikYxyv+R0=;
 b=OcllxcaIZwKaEBlhpnj4gaxBNtUqG6wNGtbWSmdxvUY3D/xxqevvZKp2nLlgNh33KK9SNcPOPv9ulMOb2scChHSrjN2rSZGmdVL7jO+AA8couu+8AHNomFxE4jCvgCIShErCZIXoU1Ew31u1WyWDh0LQ9fX5eMyk7w7fCsU14PjZr1E2jUIiycpj4L+IbkmdYmQh/0nY3XvrNRTi7hTP4V54X8+ftn7jjTRAEgIjd1gNicOkpMLbYBMbHrWcO4Ms4PYchW4QmDz82Ba3vwDg32MnoA1MAHrx8WM7STIfmgcgPXAq0Vt9v6o5jL7FYVbyXsMSE+mKV56sE8eaPlO6NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by CH5PR03MB7982.namprd03.prod.outlook.com (2603:10b6:610:214::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.16; Thu, 22 Oct
 2026 14:36:11 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 14:36:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 3/6] iio: imu: Add driver for the ADI ADIS16607
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
To: Radu Sabau <radu.sabau@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20261015-adis16607-v3-3-f972d4efee85@analog.com>
References: <20261015-adis16607-v3-0-f972d4efee85@analog.com>
 <20261015-adis16607-v3-3-f972d4efee85@analog.com>
Date: Thu, 22 Oct 2026 15:37:18 +0100
Message-Id: <179267983876.3584.17615959762286431338.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792679840; l=3466;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=yuwKnDzhAf4SM/I9bNOrTRjyCA3tNR6gxlk7E8wixEo=;
 b=m7LoofyDeGJuyd2WlepTR4kLvKBoSjruwM5PtPxFZCwbMxkWRPZEawhBkvWMiUgYiU+LgevbN
 EARaoHxo+ndDu2FLDUlH8eE0WL3DMAEUKFe3q7+5u6JXfNj9dCSnQRb
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0159.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::19) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|CH5PR03MB7982:EE_
X-MS-Office365-Filtering-Correlation-Id: 576a3b7d-3e5f-42f0-3ebc-08df3049d120
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|11063799006|4143699003|56012099006|261021135927099003|261021123027099003|261021121427099003|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
 wU3tK/HucKAWoihlt3IVktyvG8ERWutKuo6qMLM6fu04DDN4xiUfx7Zk9UHH0cANiNuwafJso16T+o5llFx/6d2ZYlUOiVHY4SrPgRv9l0DWaTfnPOj6s4cTIvMUN997mAsWoOVaBZtRihS4ywKx3BSX4lkTqur9ZJaT4onwEOz9H185+v2tCG+vNPkqh/+QfvepkIJvLUOwk4OWRhoGKh/K8RdsJW/LMMpDraDS3dsWZ81e+rNDJcDyqstvkn6KLG+vHfy79OQOFs7mjZsQIDVGrzAjctCoPS5z9MxXYVrqrUXLJhP5mMIlcIABfeTT6O+V4R7Iq9cAEoB3hsHN+EUWQVjcS67gHnULY7OkMm07k1Op2pRCNgPHpNTxZSLxbTNXkh072VNofDGaPggoAcfT1EKAb4nUv5Bb75ukRy1K6I6B5MVt86QTdQvI8N/bZOXuyrHOaCjWWW3pOKUgvDtPxyJjxyenlKZm+AJ8K7DtA1E0ijwyfo0OrBQyBDVMwyEaMty0Ch0wdWT5x26P///9fqDnIRcn2MwYCveq0fVsXfYPMuqOwvKrYr676CrEhRg04RFj1IozMwr6nT79hw/RL/u/GJWoKwjr51+wBS7afDPAj/CUqz3hRTu4dCeGR4ac4qFnkgVxPSFbpnz4Vk3k6ovjsMcBu2XZ3A8IrbM=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(11063799006)(4143699003)(56012099006)(261021135927099003)(261021123027099003)(261021121427099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?RHlIUlZnUVdGM2cwYlBDN2JvMkpwUzB3NlJNY2l5ZUZOVGU4aFNnanc2QVRV?=
 =?utf-8?B?NzV3YlZWeW5JMkkrSDVQV0VmaGtMQ1BlY3pzSGovZDc5YUROWXppem0wbWw4?=
 =?utf-8?B?YitkOXZ0dzI5SW53TXJyT1F6Ni9tOUo4VVlyV2hhKzIrRm9UVDk2TU4xYU8w?=
 =?utf-8?B?NTY1S1NrOWNaSERQTzFkQzFTU0ZIUTN6Y0dnN1c1aHQwWnpKRG9QcUExalc0?=
 =?utf-8?B?TVlTMFVwZlJtSmhNeWw5b0dUa0dZTU1LZ0FqV1REbThyM3VQTHRYbHJpcjMr?=
 =?utf-8?B?bDJxSnVlV010SldrcTVna2dDQUcvZU1GSXlNdS9aOWg2eVkvL3k5bTlRd05T?=
 =?utf-8?B?QmZxN1NtaitjUEdpQ1FpbEFwWmJ1QjZ2SWRwTXlBUUdGWXAxZXBVb3kyUDFG?=
 =?utf-8?B?NHR4cUF1anExNEZuQmdkeDZCNWc5dHV0QS9nNEdJTEw5VGtNVnNFd3p6RExI?=
 =?utf-8?B?VVhzeDdzUkw0TTRDWnJZRGZ0YlRBWDVrSHErMk9qQnNYUDU2TFF1TzNjUmEx?=
 =?utf-8?B?VGVMdkx1NnAyRURQQlNZaGpwVTZRZDdmdjcrL0Fnc2c4WERPYmovQ1NqTmM1?=
 =?utf-8?B?Szg4SDRqM1FiNnlPTEtQUUVrdnpVb2JwMWxiOGE0ejREVFN5MXFzTUJJOVRY?=
 =?utf-8?B?Uy9FODJjR1FEU2J1cFB2WVRScSs5RXlYa1NEM1ZydTk4ZmlvaHFEbWRaOVNm?=
 =?utf-8?B?anJQTlpuRDV3dXlzaXBJTVc5QUU4emp5NjFtWTMyZnpaYzNlMWtoMFN3enZQ?=
 =?utf-8?B?M3MxTGFTMnl4VUZ3NXZhS1R5MmRTMGxiTHErMjU2bnNRWkY0QnJnMDlQaWFI?=
 =?utf-8?B?clBIMmcwbzRsOTQwbDlmSGprR09lcU9wSWoyOWhpNC9nc3Y4WUdvL0JNb2FS?=
 =?utf-8?B?TFNNQlZaMzRJQ3pQMmRIRU11eE1EMWNzNm93aVlLdS85eEtkYllodVp4MGdJ?=
 =?utf-8?B?TmZFYTg5NnlUUTExS0lFcnZnNVQwTnV1K0ZYL0Vib2dXS0k0R2FsK0ZEeWdM?=
 =?utf-8?B?dnV1Kzg0WGlmOHozNTMreUhKQ0Nnck1tSXBLdk84UjBUR296Y0ZiL0kvZFZV?=
 =?utf-8?B?a1A3QXowcGZob1YxOS85dUhPQU9PRDgySE1uU0hnMFU0dzg1RFRGTWJ3bHN1?=
 =?utf-8?B?MkRiUytCY0dEVm9qU2xuNDIvRTlIdU5kK084dnJNcnBHcXJlaFMremNQUjlx?=
 =?utf-8?B?NDE2L0Q3dEpCa2ZWREM5SWRrcW5QVHNpQm5uTHJlT2VCcnlwZkFMeDdqeElS?=
 =?utf-8?B?UWFYTHdIWE5Xc2oxMkxOQjJoZVYvQlZRcVk3MGhZaW9IUGlwd29YQzlVcWpM?=
 =?utf-8?B?d0YvNFp0YWNRMVlGYzNidkhwbHA5aE5HVnNNNy9tcndYbHFxdWJkWm1Ya0tP?=
 =?utf-8?B?NnFBeVVNTHVja3pRSS9KaFdMZ0RnN3cwMGpGQWVOczNPU0xmOU5wMkdNNE9v?=
 =?utf-8?B?dGVGT0pMSEIrT1dBdzRlWmcyWExLU1J6NXpEZExOYk1pQ01BUFlJSll4Mm1k?=
 =?utf-8?B?MnZUYjZSMmpFM2haNGR0YUd5N2xUOGVVcWhKMi9ZQXE5a0x0UzFIL2IxTndv?=
 =?utf-8?B?UkJHSnlmVVVjL2lPTkhyNTR0ano3WEluODZsbS9Wb0JNdG90dDhPRFVseTZs?=
 =?utf-8?B?Q0NiaFZ4d2hHd3VKMEtlTmtQVkxxUS9LdVgvL25NcWpudGdPdWZuM3d3aFBD?=
 =?utf-8?B?SVA5eE5DdVlkM3Q0YytacTh4a1NHeUpIRmFrWmltb1RRSFBKVE9mRy9tSFFu?=
 =?utf-8?B?SjJiQ3ROWVZRZmo3VEowVEpPbm5uZTZhR1NHZlFtV05YS2hEY3dqdWcrSUEr?=
 =?utf-8?B?YjdEZndqWUpmZUVrVXNzcDBYT1dnOEFKQmtmU3NQQ2pKZFJwejA0L0pNWVk5?=
 =?utf-8?B?UERkenhHYWpYUjRjUUJEQnFNMWZmejdEeGZIdFNUdWJNeVhDSXBqejNVbzYz?=
 =?utf-8?B?dk1YaVFoTzNVTjBIUE1uKzF1TVdFaURoeTB0WlcrZTN0bmFqWVpUQStsN0hq?=
 =?utf-8?B?cUdodFpTemZaVXB5dkR1aks3NWY1eWRzeVFDZnowYzFGQjRUZER2eVdzY1dM?=
 =?utf-8?B?Y092emIrR2lINHFLM0U1cG1kOVdJUFBKVjRGZVhpR0VaUlVBNkZaRi91d3VH?=
 =?utf-8?B?dVlOT0J5MUR3Z1hidGtBcHZ4c0F0cGVLb1dWZ0tJRVovVWN0dFpWQk1OVzBu?=
 =?utf-8?B?YU1KY1hyMEhhRC9BRlpBNE9pdm1kVzZ1VzlibXNCVGVQVHVGSEx1RklWTG1m?=
 =?utf-8?B?VWZ5M2U0dzE3cExON0Z4bzRDdXpXVG5MU2VBdmZPTy93WE9yMWZsYTQrTkVn?=
 =?utf-8?B?dHh4OEd1YlF5NlptWXMxSjJRL3p2YXRGbCt6V1FGdlVkNU5MY0FPZz09?=
X-Exchange-RoutingPolicyChecked:
	wLniyk2Nizxr/jfbc8shgYfpgMMV2RrC1wxYcDmf6oT8/yJRh6W08484JtwxDMhC30rw2nf4JjvyDZ+JAp7ktiq90800BQrKqzWBknAN2dzJEA+b3KGXlnev65FWYqPjwnd6FrVWdzd1oVBLFbrkrzb1TjjmQ5NRRg2Pp7E7b0ZykxsDmJffk5+t4EzmZOU5uICsKywarc9Vw8bZAXvhdIRgO9KOgDpGuj4AS1N+qgaPEV0V0elj2SakdnbQ5AjOp02jOuKjQG1HeZN0rg93KqJUVUt9DKD7gpeynQb1+VdpPXcV3BrjI3zfafbBKhXH6lJMAmL86c36ZBC3iyRKgw==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 576a3b7d-3e5f-42f0-3ebc-08df3049d120
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 14:36:11.0776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27QJOLKPjSY5Y0zEhJj/m2ogMrqsAd4CF9JnwFfruqo/agjS56Bgd1HFqcBI1zq9bZ9bdn6Ts31ntUobiwJ5vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH5PR03MB7982
X-Authority-Analysis: v=2.4 cv=AtN7T+9P c=1 sm=1 tr=0 ts=6ada1f5e cx=c_pps
 a=0/XwxnXJ+7qPZvmcTWkk5A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=gAnH3GRIAAAA:8 a=VAojRd_uCLd9EKjSh1IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA1OCBTYWx0ZWRfXwAmt0VvP3ZQ1
 PeMywgOaZUxU/uYNHUVak50JEC0bME2ad08OBtnmU/kAA9gR/jzDPbaKYO9/ybCv9uq9c6OEGIg
 dCs0v31YccJaLJIQccdEfw0cHCOf+VSR/bIIG0B3yroiq0bfuWP3E/GOf4NS3JxYZSoTbijsSJ+
 zveEXOGUn1O1S1cDMpaRKE7ShiHyXJusP10daYEsDneBve0r5PvTsfSYOFX4OdUvHtMf2RDkpDS
 vyOx5gpZdtRG9Tsxk3P/uyEr7PpXHzWJ5tyYbvBhuz0CZV7CwqTugxKzIIlsGPVE73uaBHsnos2
 UHef9DRJQP2rTspKnT1pWkRy+ldTdCMxlJ6l1sPLmDRtaXMTZkylSTWWRATSDmxy8CntqjuzhNG
 5fyDOzFEfW817cS63kkIm3e2/hmpe/CsCs0CKLODU2d1TTFA9Uz+8Gu6+K8+hZuLoGBQ5khdAWr
 3D2nINfXLBzk8eiWSbA==
X-Proofpoint-ORIG-GUID: XcclGU2-zpTuSOgwuIZYf5JBDpASFXlG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA1OCBTYWx0ZWRfX2dvEsBfNcp46
 Jvw0LovPMQY4dOuhVQEegSmPbSYmG98vxziNvu0i4I2KTcQCjzsVJNfbkyzZalfIMqKDRxV1Jg/
 vRz6vpxmGX8SP2ZAGsbedI6fwYHF8AsaOWQkT7yKj9DDTmbHEuSr
X-Proofpoint-GUID: XcclGU2-zpTuSOgwuIZYf5JBDpASFXlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220058

On Thu, 15 Oct 2026 12:33:00 +0300, Radu Sabau <radu.sabau@analog.com> wrote:
> The ADIS16607 is a Precision MEMS IMU from Analog Devices with
> triaxial gyroscope and accelerometer, delta angle/velocity, and
> temperature channels, communicating over a custom SPI Half-Duplex
> protocol. ADIS16607-2 has a ±450°/s gyroscope range, ADIS16607-3
> ±2000°/s; both share a ±40g accelerometer range and an 8 kHz internal
> clock.
> 
> This is the base driver: probe, raw channel reads, sampling-frequency
> control, startup/self-test via adislib, and debugfs identity entries.
> No buffered capture, external clock sync, or calibration bias yet -
> those follow in later patches.
> 
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>

Hopefully I did not repeated too much feedback.

>
>
> diff --git a/drivers/iio/imu/adis16607.c b/drivers/iio/imu/adis16607.c
> new file mode 100644
> index 000000000000..1d471f59f043
> --- /dev/null
> +++ b/drivers/iio/imu/adis16607.c
> @@ -0,0 +1,855 @@
> [ ... skip 285 lines ... ]
> +
> +		if (!adis16607_delta_check((s16)st1_val[i], (s16)st2_val[i],
> +					   delta_max[i])) {
> +			dev_err(&adis->spi->dev,
> +				"Self-test failed for axis %d: delta out of range\n", i);
> +			return -EINVAL;

Only used in probe no? If so dev_err_probe()

> +		}
> +	}
> +
> +	/* Clear self-test register */
> +	ret = __adis_write_reg_16(adis, ADIS16607_REG_SELF_TEST, 0);
> +	if (ret)
> +		return ret;
> +

Just return __adis_write_reg_16()

> +	return 0;
> +}
> +
> +/*
> + * Post-reset bring-up callback for struct adis_data (see adis16607_data
> + * below). __adis_initial_startup() calls this, unlocked, right after it
> + * has handled reset (hardware GPIO or SW reset, adislib's own job) and
> + * before self-test - no mutex is taken here either, matching that
> + * convention. Does the device-specific startup steps adislib has no
> + * concept of: SPI Half-Duplex locking, dev_id verification, the
> + * bootloader-busy check, and (if wired up) a reset-status GPIO output.
> + */
> +static int adis16607_post_reset_setup(struct adis *adis)

The below API seems a bit over commented!

> [ ... skip 78 lines ... ]
> +	if (ret)
> +		return ret;
> +
> +	ret = __adis_check_status(adis);
> +	if (ret)
> +		dev_err(dev, "status check after self-test failed: %d\n", ret);

Internally the API already logs the individual errors so the above is
more noise.

> [ ... skip 125 lines ... ]
> +	int ret;
> +
> +	if (!freq)
> +		return -EINVAL;
> +
> +	mutex_lock(&st->adis.state_lock);

As mentioned, use the existing helpers.

> +
> +	dec = DIV_ROUND_CLOSEST(st->clk_freq, freq);
> +	if (dec)
> +		dec--;
> +
> +	dec = min_t(u32, dec, st->info->max_dec);

min() should be enough no?

> [ ... skip 16 lines ... ]
> +	u32 tmp;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW:
> +		return adis_single_conversion(indio_dev, chan, 0, val);
> +

No new line.

> [ ... skip 23 lines ... ]
> +		}
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		/* Temperature: 0 raw counts = 25°C; offset = 25000 mdeg / 5 mdeg per LSB = 5000 */
> +		*val = 5000;
> +		return IIO_VAL_INT;

same

> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = adis16607_get_freq(st, &tmp);
> +		if (ret)
> +			return ret;
> +		*val = tmp / 1000;
> +		*val2 = (tmp % 1000) * 1000;
> +		return IIO_VAL_INT_PLUS_MICRO;

ditto

-- 
Nuno Sá <nuno.sa@analog.com>
