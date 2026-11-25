Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795601985;
	b=RKIS75OdfIVXYEhzY78hpRVWM1IbtNlG/OfueWuQ0G0A+IYKxTxcKH1kwNdNQTaaOw4H
	 1f0FHT5wkdwDTWT84C2KU0dIBAyo9O2x3Nw0V6WGyj/rD0YqW21jhSFXUihIuhkFYMc8z
	 Qg9J5lKRFqfCHfZ0c+QRHFNuRHLZw08jtWob19Ieg1irLYFeNSMjuFePS+pqN0RD+m4ZF
	 BGzml6Oncj1fZLkreGMesEljpVGiQ2y05JaBLN0eUAjdx0pEDi9Gxn4wch1ZFn3dxA05z
	 5F6sIaBCMyXcF1Q0x8XHEq6w6zwLXfiPM/Su+wWNHeSeH2zTk86bUqT1N8YV8VlEpXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795601985;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:From:Subject:Date:Message-Id:Content-Type:
	 Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=Haawsvvv9HiDKheBQTcW2B49SV8G6MiMGZngUygEaIs=;
	b=xwrUiOvoC9VpslWTiDIqa5MLJpwXpPf1Yzf2dtcoiZn//0zYk7f70yysuaKl31+1pGJX
	 FA2Gz3Fww2t1e3+Xr9+fsGT6I4QuNC+QYnVW5lCovtwAe2507UvLRRzNbK4jpfym7QBE+
	 9YNuQBlssNzWxLtGkAeGlOE2E5Ij+TrOsrRSUF/+liEJyKYwGlMZI7wrVHQN/3WRRD7Lq
	 02csYp9rH+Xugc7QKexnN0nDqicxgY2E586k9uZdtJ5LNJOJ1epNHIuKPU0KONJR0JMx5
	 Imt6SkZXvJGrWdRfELp3kfSfMqnvDmXqKAaRtkwFMc4Qy7d8i3Jr1eL9Si9pqet2n0g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Xv1LREb6;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=k4OZ3WmA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B3B606A699;
	Wed, 25 Nov 2026 10:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79B3B606A699
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=Xv1LREb6;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=k4OZ3WmA
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AP9n1xL1940552;
	Wed, 25 Nov 2026 05:19:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:message-id:mime-version:subject:to; s=DKIM; bh=Haawsvvv9HiDKheB
	QTcW2B49SV8G6MiMGZngUygEaIs=; b=Xv1LREb6BTV7V7Lzc8QGG685mhvGAW2q
	ixaAVcgDH5yuNHEkxT5o9cWAbGSkKGJWNHO2kx23NPgul0x1x0R0P+xjMmRCrqgh
	SSU1Xn4Br2CVAPgx4zpZwTVhRUZGgBSPo9fw0PL2SyloKs06g67ez5X8cY6v7GYw
	I4XRxGS5BjkpgbG9afDwAmXy8BIOj5bCxVJ+XzzsdNp5UghdjL3YqUoNh5WseXJX
	PlJ6/Vtmk6d1FH6L3q8Yb7DRh/IRnI82BYFxcd0uCf7Fi3ZO3NX2KdqfsPe0Wztt
	Cg9lbOT6+mfejHFVAvPctzN8yqRiMVbs6uIyeDNoUyUXEs0omEnJJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=DKIM; bh=Haawsvvv9HiDKheBQTcW2B49SV8
	G6MiMGZngUygEaIs=; b=k4OZ3WmA7zCeQwSKki9MEFdfVNHSpEezBrukx8tMVsA
	Gq1lxE1IV/+dByF4ZMCRfQlQRRNfHIl6HrLgjOuXWtEuTY9S1f/Uv3zyVB2n9KxJ
	dFSlkojRFQRR5sYjS1rkXsUSZ4DEZPO04ytxNGNfSJ0GycgiH3PlF6x8/W0tiRFI
	/QFitBjD6boh6MduuZPvWnQNx3mtzahiQwNX8IO8x5sG7wZutaYW9L4Jkp/qIvYO
	wUPddg9JtzgZbOUiToCslmmcIL/oOtgt75IszvQ0ft3GhPRbI6oxMkxySJtEea+J
	yLA2YHyAUgq+rOlccmBmCe9ZHwrL32E5lNXEkSLIUwA==
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010048.outbound.protection.outlook.com [52.101.201.48])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4j59pyp2yn-2
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Nov 2026 05:19:26 -0500 (EST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DttHqkd4K8dnBJhln9rZ/0k8kW0mbuC8dCY9+Y5tMcpoEcH1xll7r5dWg1T0s5moM6rgJd97nQts/B3wL4IiTpVE6uiNxhepUNkQIJEg+uLMUmvPbd8/76/9LTXBT2H2xm5TVm8gNcvqXyy9D47PVpM6CrWcOpatfwxzJaAQWoaiibPuTWL52IwgSAVMpsWPCVidXFbZnMiE44UihGXqPWeulN3s5zxejoosLOgWPnEdAafPxEjcdd3BYlNSBMg7RRFGPq0SSXIpkcLeydzJrnRckSSd/mkQ7QcZCj1vQZFb5FCAiPfHwaZwSOOKZxWLLPMVwGgVw+bnVKW2MpTjpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Haawsvvv9HiDKheBQTcW2B49SV8G6MiMGZngUygEaIs=;
 b=exJAQPf5lG0xBlX0Q2S2oFawacgCwnq0J0iGQh2xMPaInrcReoAkWwc0QU06VWDF7GpRZfPXrQ6c5gryAwfI/v9GUamzCm0jcRT+rtyV1/6/UgL8kpe3AXqaGVY4sqG4OcS9CUp8Uehf6s1gZulhe5RuUl6sQ+E3KWSN41rELimZvEWn6vFh6h8gQfJtU3SZVQTO9qQzwOrWgI3q8Q/jaRCW7vahUJLDf/kr2g9UoBugMiMO/7OnCHGAvQytB79S/C4jcJ/+8ybcxMORMsgxUOFSf0l/xJ+K+uPg85+rwDwgyENZVGwLL6XGmbCDtBKODdh7J9R8QEjc1LTPZ4LCig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by MN6PR03MB7573.namprd03.prod.outlook.com (2603:10b6:208:4fa::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 10:19:23 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%5]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 10:19:23 +0000
From: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 0/6] iio: adc: drop platform data from some ADI ADC drivers
Date: Wed, 25 Nov 2026 10:19:16 +0000
Message-Id: <20261125-iio-adi-legacy-platdata-v1-0-54e4c8830b57@analog.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQqDMBCE4VeRPbsQDeTgq5QetslUt4hKkhZFf
 HdTndt3mH+nhKhI1FU7Rfw06TwVNHVFfpCpB2sopta0rilj1ZklKI/oxW+8jJKDZGFnIWJgrXG
 WynuJeOt6lR/P2+n7+sDnf46O4wRhx7UNewAAAA==
X-Change-ID: 20261111-iio-adi-legacy-platdata-63eaa0e33063
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795601958; l=2400;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=vqW34s7/AZiWIRas9dlo6dpS/PEsK41op0Ov6oW6chI=;
 b=SjhSm/KwU43hrxv/+mIiLImWhfn+77eKenyMdzrO5Vf8VFfq3RduKv6JGlOdChY8Ut6Jl8yIZ
 2j9KTJFi2eyCaCbkzguNSLE8hRSlmPluD9vNCqZIhzlsiWUpaXAW8M5
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: ZR2P278CA0062.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:52::10) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|MN6PR03MB7573:EE_
X-MS-Office365-Filtering-Correlation-Id: 212aa76f-a8f7-4d21-3c40-08df4add9390
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|23010399003|7416014|376014|261022105027099003|10067099003|261026140227099003|261022075727099003|261028144727099003|261021123027099003|261102123227099003|261021121427099003|261009223027099003|6133799003|18002099003|56012099006|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info:
 xie1TW+hR6yJPKneebtBL9rpmDB9GbILEYcrCfF7a1Dz7lcwCXfQ1BsSe4phAvfuku+a7DD09HUmPVTtwvQvaek75Jk3OZt1X2leR7nxWWZjt7gTBuwHxIFXGYrYhuIB3JYMmY0GVtgv4QYnx00P9eSSb+ME5HMUNMnqqcy/00HS1oyN2UXLXQaQhylmBEDPkaGubBJJUstHxJDd467XA8ERnnVxl7YRyuDqh5X1qN7hRazzm2gxYoBmhqIAD89yJ0107yKlyPmiSjhEe3MTg90nU3XHZyExUjLrqR1FwTCKyTgnqL3jd58k+d0RyCnFLJ+Gq3C9uIzWxrPjZbiXff/dSaXuZbkHrkTeq4OLWcD8N25I/ITnJGEGkgxaALB1dduypREye819BStr1F2dofGfpVBAt5UFTEHzz5LXJbNGDrqYxmprlWQmk/3dWjHhWblq7s2vhfugGuuGrbJxrT/raCPgs81c3TReKNgmVe5TbVrKKGxdCA6fG1XUGItsciCFOH04aPmfzXuVOIOQThKDU7oGY/ocykaEgzMTueMGdObNzPPiWZh4KYQfEl5pFMbrd1jq8inexGhoA9mHqtxQl8s3k1LOXBoP7z69Al7ZZw0vrkh+Swj6hqDh5yLmznshGdooG2hDqzRJ8iXszH8+Yg9ROwzK5/oL0zPDZWY=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(261022105027099003)(10067099003)(261026140227099003)(261022075727099003)(261028144727099003)(261021123027099003)(261102123227099003)(261021121427099003)(261009223027099003)(6133799003)(18002099003)(56012099006)(11063799006)(5023799004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TzN6VmljdHBVdDZ4cFFaallsQnlmOHhkVSthMVdwZGd3VDQwRXJKZmd1Lzhv?=
 =?utf-8?B?UFVhd1EwanYvQmJMVWRNUkVGNjJ1REJFYyt6aXc4QTB0K09PcUE3S0dkcXd4?=
 =?utf-8?B?dmxkUWYzVWVObEZJZ2l5d2RPcVlnVlVldGovbWZqZlBxOFhrV01VbE0xWVRm?=
 =?utf-8?B?V3FZc21LUVN5MmJtWmdYQnpLd21SMC9QQWphWjZmanNmVC93dU9NTHNiOXV5?=
 =?utf-8?B?aWdjNUVpZUMvekdMZ0NXMFJPcmZuelhWYXpVS0MrK1MyZ3dScmtUdDNFcnhD?=
 =?utf-8?B?ZCtCSk5tZjdhb1ExK3pHZ0lvQ1hocXJ1R2pKdC9NV00xT1FBNmRocVhpY1po?=
 =?utf-8?B?UExhQkFKNENJdU5Td3RleVJKVllxTUlKL2NxanROMktjMzh5U0k3Z2crN1dM?=
 =?utf-8?B?SXU5NW9mclJiWkRPdmRET2E0Wm5mdnBlK1dSc0VPQk9TcjBuUER0YndXUmgv?=
 =?utf-8?B?eFFweUFzSVRwNnJZNEVMcTFmUDdURnJPbHZGT2ZZMm1tZXY3aGFvWXZoV2t3?=
 =?utf-8?B?MnJjeTUycUJqcFovbjVJRkI0QUtoMS9XL3lGVExaL1ZnTlVtUTFQQ0lVeTNG?=
 =?utf-8?B?dXlrcHZaTXNDY1pNUmVPWXNna056bFN6Rmk1eldnZ3ExUUhLRTRpenpPekxa?=
 =?utf-8?B?TnVVWGVCQUVqVERoOWtQL2NVR0RTekk0Nm5uSFczNDBPOE50WDBzandPVDc4?=
 =?utf-8?B?UTFqa1lIWi9ocC8yNkxYcEdQNEZPQWE3VVFWajNuZTlOeUhuVmxabEVVWDRn?=
 =?utf-8?B?Y29jOE1Ic0tqUlFRYkphajd1djVIQWxjZStLRGxnL0ZQUTZBY0xZVzNHdlNm?=
 =?utf-8?B?KzZxdU9UVTkxeWd2RGUxNE1oZXZrbEFYZ2pNVEdjUUlUTFVuQ3NjeHZSdmR1?=
 =?utf-8?B?ZnZFam83WThIN2Y1UW8vNCszUjkvWXlYTDZYbkFsTlkrL1Y5Vmp3OWhOWTQ0?=
 =?utf-8?B?b0JMV2JSVlZ2UHErWWFTdVl4TFNNcU1IbXRScVMrY1o1TFAvNk5hZ0hIdEpY?=
 =?utf-8?B?b1FJR1licGtpQllOS1BDckt4Wmx3S3FldnQ3by93WTBHTTNlVVVNSGllcGJt?=
 =?utf-8?B?WFhPMDhhMkdlZEtsTElZS216eHJTSjRndWZ3TTIzZVdDREVBcDdEdm9aTXFP?=
 =?utf-8?B?bElMengrbWpJczR1ZTdvT1U2UGhNdVNlOExLM1A2WkJ5cDJUYVBKZ3pRVlQz?=
 =?utf-8?B?djhmN0pFaHdOMlp0MERTQnlTNnE2OUZXd0g4R0RHZGNlSFM0QVNWM2FIVTZU?=
 =?utf-8?B?ZGlMRG1uYzJRclg0MW0xK0VNRmRPZXZwNktGektRZnoydnBlVnhTNno5VE9h?=
 =?utf-8?B?MTFHek1FWVIrbklkY3paMkRZKy8vVkp5cG5uN3ZaMXE0Zno0Yk5BaWtYM29L?=
 =?utf-8?B?VmFWajNFMUgvbEV4Y2NaeGRzaCtCbkNOc2xzWElEQThNUENNWWFBa1ZpalAw?=
 =?utf-8?B?andNZlFPcEFmM3d4N09IQ0c5QnpkRms4SjRXLzZid0NDazZ5R2k2djdhdXh2?=
 =?utf-8?B?c2IrQ0c5aDMxeW5EVFUycjRTZWZlT1hjbUNaNzYya1ZRSzV4OHM0RWdLQ281?=
 =?utf-8?B?VHR4L09HK08wcXpCS2R3MGlDTEQ0czdycEMyQWVQR3g3bzlHb3JSajNXWFdu?=
 =?utf-8?B?Q0FuT1lDQmdVN0JYdjRmSGUrM1BNMmR2NUd6K3RUT0daTUYydkdNSCtvMEE1?=
 =?utf-8?B?ZHhkYzNId01sUDNxQU0vaTFiSnF3bmFIcVVYN1NxVktPMWg1aWZYamx4YmhV?=
 =?utf-8?B?OHhqemdSTUtVRWZqU1gxYXFHUDVlSllUWG9wSXhNR3ZpNm16QmhBZ09icURR?=
 =?utf-8?B?dmtYNm0rbmpDY2E2QmtURnI4YjlxN3pxcEFLRlNBWDR2dkNjM0ZYTjFxU3ZW?=
 =?utf-8?B?aHpjazVJZ0FLQUkySmhEM0o5ZjJiejF2VkNJQmFRMFM2UEFsclM3RkhzbnNI?=
 =?utf-8?B?eWJOeTYyZ3ErYWRpaWd6ekx5V29XZ0Y3M2wxbStQOWhDRFdlcWxZRHc3UGZB?=
 =?utf-8?B?ZW9NV1VrbmFDaDVoWE96aTJ2SzFUM3FRYTdxVE5aTFRPb1R6ZnErU0pnWG1R?=
 =?utf-8?B?SWh4UjF2dUI1WG9GcThDTkU5VHlkQ2R2TU5jQjVaME5uOWJDK3NlN2dRNTIz?=
 =?utf-8?B?NEI5RlZEZTFhbWxOR0NEb3VIeUFjcFN5Ly9GVUd5OEFFUXMzNGtrRXh1SmIy?=
 =?utf-8?B?NCtlWGoxUEpWNmVCVEpsT3VBdE9PVkZ2SVBDdTR2aDdDYVZyY284M0lFRmV6?=
 =?utf-8?B?YkpSZm5uQURjSDFqQy9pSDhJUzdFUHlsNk1xWGtFZ1ZVSGJwZEREZFhVRlRi?=
 =?utf-8?B?WWdQSVVucng3MlYzSXFlZnZudnBZSEcxUktvY0UrWUd5bHBjUUtLQT09?=
X-Exchange-RoutingPolicyChecked:
	JSIr6n6DB42mJNzICXuoEvtdKK3ShHFyWnZVIvOJI0nVL9M733uBwc8lQb9pjXOvQuDrNV0aXZe0Bu5tAAwZsQU8AVvBWY2nRqEZZx2wXGJiNp6ht5dJzaYU8olUmS5xrgh5PkiSUYha8pkdrWZXA9/fa7txWjoMqeCItCS1TjOziHhRBIiydh00y0IhaQPc+PRfs8veIJT/rPJobYfVSpwyD6Zbbu8ABaJeae6LtZEuYf8rYtG9N9k02pOlr4xbzT+kE216nevirpal/aMD2WsgK2LD1b9dOJ1EaaNLG0+KXKESLKes2CX4j0Ji/c+b2JzFoqlvJJJI6RzEQ19D6g==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212aa76f-a8f7-4d21-3c40-08df4add9390
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 10:19:23.5323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kNO+C+sM4RWfuAqWC539rod4OI4SRn1WchSN9TaUSg1xOkbZHD5TtdzZv+qvR90gcHUJN3jnGMrVr02lCa78DQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR03MB7573
X-Proofpoint-GUID: 1GMp4whaybvUugPqthlKkn-kz-UbhiIQ
X-Authority-Analysis: v=2.4 cv=HbOB3SE8 c=1 sm=1 tr=0 ts=6b06b62e cx=c_pps
 a=FHNT3LFbDro5wzOX4rYsGQ==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ugNRTJOwpmtT476g4l8T:22
 a=1QsOlD_ZWlWT4dNKVxQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 1GMp4whaybvUugPqthlKkn-kz-UbhiIQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfXzKp5hpUIfnjM
 9InsCGNhCvQ5Gnjp8xzVSeBIOVjG3S3aKZmCgfib1kbsa83sJHBvTjHzUc778oEZjWioIiLgt2Y
 UzfOVx2VFhSAQMTu6+frm1SxpHEnlxwcCsEiwQapAC1jnBdUeq2a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA0MCBTYWx0ZWRfXy/OAWTCBoNOE
 JgJIM83qt2mXxYy6tXHQxYRv+0MbDqkTvJurrdNbdW84pn9dYotWMpbJatPHdLnB/pdXtCHkZME
 olD1nQGuUd8SIgUFlRoI4RsZWznRreCTh7kWHooxMmdZsBNmbGdfDGwq2OJAg2gdUjSqt2A+A2S
 irjW74opNgntaxgi6TooHtiP18obyYQplYmIhkycHA9x2UdiYl2C5pxW+3drtheVGLTBQ+9ZHG2
 r1BBciKreJ6pviouu7IXkbREJrVxdZ17SJvnovR9uLBHYYgXnFMEu0zLlVJwXHer3bqFSTvMya7
 yhb3XDuYIuLng5KSntzY+59I16p4XJRs1PUmJa17unW7Xc1/t4erUSNbGNyXh/yBlWhe5jmhayo
 wJDACIPgTHjfBqiIZhH6/4yvENrBOHdVP4ZhEohiYh4hDcWic+nisv6Y9sv/Pv5z6LlXHmoSd9D
 KYraqTmToBnxDTxYvmQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-25_03,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 adultscore=0 phishscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611250040

The ad7266, ad7887, ad7791 and ad7793 drivers can still only be
configured through platform data headers, and nothing in tree uses them
anymore. This series removes them.

The ad7266, ad7887 and ad7791 drivers already work without platform
data, so the headers are just dropped and the drivers keep the
configuration they use today when no platform data is given. The
ad7793 driver refuses to probe without platform data, so it gets a
binding and firmware properties instead.

Patch 1 fixes an issue in ad7887 found while looking at the driver: the
on-chip reference gets disabled exactly when the driver relies on it.

For ad7266 and ad7887, the code for the modes that could only be
selected through platform data (address GPIOs, other sample modes and
input range on ad7266, dual channel mode on ad7887) is kept, so that
someone needing it can easily add firmware properties for it. I'm likely
being optimistic and odds are it will be just dead code so I'm glad to
drop all of it if that's the feedback I get.

I also want to keep changes to a minimal to not end up with big
refactors.

This series was also prepared with the help of AI tools.

---
Nuno Sá (6):
      iio: adc: ad7887: fix on-chip reference enable logic
      iio: adc: ad7887: drop platform data support
      iio: adc: ad7266: drop platform data support
      iio: adc: ad7791: drop platform data support
      dt-bindings: iio: adc: add AD7793 and similar ADCs
      iio: adc: ad7793: add firmware support and drop platform data

 .../devicetree/bindings/iio/adc/adi,ad7793.yaml    | 236 +++++++++++++++
 MAINTAINERS                                        |   9 +
 drivers/iio/adc/ad7266.c                           |  58 ++--
 drivers/iio/adc/ad7791.c                           |  26 +-
 drivers/iio/adc/ad7793.c                           | 315 ++++++++++++++++++---
 drivers/iio/adc/ad7887.c                           |  15 +-
 include/linux/platform_data/ad7266.h               |  50 ----
 include/linux/platform_data/ad7791.h               |  18 --
 include/linux/platform_data/ad7793.h               | 111 --------
 include/linux/platform_data/ad7887.h               |  21 --
 10 files changed, 575 insertions(+), 284 deletions(-)
---
base-commit: b70566610b48ba49dec636019da4d696db64b085
change-id: 20261111-iio-adi-legacy-platdata-63eaa0e33063
--

Thanks!
- Nuno Sá

