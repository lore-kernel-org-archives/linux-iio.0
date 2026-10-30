Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793369198;
	b=T/P9FIQubhpVo88yYHJzkB50IZ+MkAYQ6+jVEGeMdBRIa4wz9hwE7LldrWccIKxElGuC
	 v0o/lnKD7kdhyWkDuadUF6Lxtv0cdCbBAtEbDL4RL8c7Y6JZzI6K4Bb08FFzeqc/3Yc90
	 Aje5v6/MtvuzUcpYWpkbMBnttBd6QIsgpm51kgAP1a+5D8Q+RSGP0mrLsBebGVlU/94D+
	 jWjZ1J8hdD0SIKc8Mx366+eKwlF/Dq8xspsGIR7HcSOIQ0FhPscsueOd5waBXU06ispQM
	 wRC+NJDSH64EsFukpPrQtdNXu160H0jEAp69wAMOE5Utz2GYfOhlGZ3XM+oxMrOqhwA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793369198;
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
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=eL/EGy1NIXBR8RnMc0h3msMhub2Mww8ZgbIx8jxq57M=;
	b=dbbKSHAUcQ1LA2RPg0+JdqEoGnYCxcJZKd0dQMwH0f5kRFHvkEaZCPIhqe0f7BodVIyY
	 5m5M83l0QYz2K65/OSZWjsDPA+YOIqT3u2U35TfR8CiDJ86wyVavQ2qJRDudJ2EAma9Y5
	 PPg7DcZVwJdyJzb8pQZQZB/envr2n4HdMim5o82u4j4UVQqZwFcix8S4+ABVflmhUC4Rd
	 qwTvchgCkbk7+q8Tdihv2ZfdRmbkw/4/PqVfLR2jGyR7Ev7bNwSsHli3xsOZ+rLVX8WlJ
	 rrDHC0xR6XsFzULG+m+bo2pbZXexmQ1m6UcG+uE8GEQGJKMkBwZG2V2dqsejbxqu2/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pUpFPeXa;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b="YDaAq6o/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=148.163.139.77
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5158F606A31D;
	Fri, 30 Oct 2026 14:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5158F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=pUpFPeXa;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=YDaAq6o/
Received: from pps.filterd (m0516786.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69UBGeiO3931866;
	Fri, 30 Oct 2026 10:06:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=eL/EGy1NIXBR8RnMc0h3msMhub2Mww8ZgbIx8jxq57M=; b=pUpFPeX
	a6DwUuvd4z7jZ8hE21lh+9juHzRSXvIOiczpH4GqTvNQPr+RxL3lAolwCGuAXbwe
	c+fbO/He78Tj0rw4Mq9dY2yIfl2AWx1/OmRzawyGqtoF6dtxta1b6NYgOLRttU+m
	N1SZVJXwsPQJolWVMukipTYx7CCNYOQThWxhTxOGMY3SMtuV4a79r1bAgaw2B6yO
	DByYpcFacjJMW2G4NK//J3SOQ1RES9hWFlq5221wm0mk4ycPIXjEyv6DpK/K64+l
	2KAtHzIVRdG0jqYh1rHdAdLzZHgk6WUHv7epmljxo4DrVlXnvGNt4khYaT01HPS4
	BRxqfTx8g9QX7rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=eL/EG
	y1NIXBR8RnMc0h3msMhub2Mww8ZgbIx8jxq57M=; b=YDaAq6o/adUqjZpsKT6QJ
	9JI8ypmmMJqssrL+mcEYy2KrC1u8mxtLtZsbHSk/8Sp1X5b0FBcb0OPgJI9mznvm
	S2BwRub0KWi24PhddURQaOg9WDYU8VoHgp0VYoBPUxRQoHIIQDztQL6LUUhePna3
	r9Bi1y2YlXtb3yxjbBf8ISa7n3N/rpfYe37ViqZF3yp8the6zzzgKejaAqiWokNJ
	GW9Di8QJvgpBvHLaln650cBFKlPkTuac6/44HDqdvpPDPSiFFeKdeaVwmoQ2oHDs
	X5HZZewvouKh0C5mkJKUVZmS1TmJCo7RbGiei8FyqwKh5XyBC5EQwmQIqW5IU1Ll
	w==
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011029.outbound.protection.outlook.com [52.101.62.29])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hme7b4dab-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 30 Oct 2026 10:06:14 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMQXvXXSCMKnmtx33psS0CFf3J+o2NDWNnuLo60cuI4XP1RQ3t/djpQVmQGn9EduqXG/suZ1iq5Yzlpb4VlRChAEKcLBx4qbbdhgc/VBDWLuqn474mY/7zm3Z36w5DfDyHf7GxhwuS8OL04RlZkbGpoSKNhde6k502c0YpeNiNd4A6sdU+jnPrh/d1zWz/uBVb5w4mVC/9Pgj4GTMrWAarxLeJVH+Qvk8u+1sGHd1JwoMxQoDHn4EP2ThC/HMDjtSZN2GNybqPvBGmA5o0RjvXqUq6ZnzyBn+Ivp75PgPJUX87Oy4fTrB1j7DqAgLiwwtgy5PnOLIl7Mf6+5wdC8Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eL/EGy1NIXBR8RnMc0h3msMhub2Mww8ZgbIx8jxq57M=;
 b=QTuyicUtq3Ig1wzyQx/C3n+KQJnM7Ns8t8zWta3K8PUvDiDo2lnIgmZIbEHtuBOCcY+RknmChrEmRKvJbjVCDOGrTt2GIwL3RgIIAz6JqGqfxrQvkhiD58xBzaULg3TdFoqkxs0JSBPqz1POYmCpISvjaPIn2WazwV21AG/RXjymwm9og38VL8jvElJ4OaVH38fjs8S5ZHCirhmx7nnky086tJoFZoobXZnDVIJzSuEgJLaTMJQHmqCS8ctPXyWCasN2mF7e0dxUVloe+GGrck097FnYL7Fp+aj/DLMzqVxALkZ0emY9R4zt2K0o9XNLZja2+frzb0SkxJN3+OlXBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=analog.com;
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com (2603:10b6:a03:28a::17)
 by SA0PR03MB5529.namprd03.prod.outlook.com (2603:10b6:806:bc::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Fri, 30 Oct
 2026 14:05:43 +0000
Received: from SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a]) by SJ0PR03MB5469.namprd03.prod.outlook.com
 ([fe80::2a19:76b2:e731:8c5a%6]) with mapi id 15.21.0569.009; Fri, 30 Oct 2026
 14:05:42 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 2/8] iio: imu: adis: Fix custom reset dispatch in
 adislib
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
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux@analog.com
In-Reply-To: <20261023-adis16607-v4-2-a4d541ebfd13@analog.com>
References: <20261023-adis16607-v4-0-a4d541ebfd13@analog.com>
 <20261023-adis16607-v4-2-a4d541ebfd13@analog.com>
Date: Fri, 30 Oct 2026 14:06:58 +0000
Message-Id: <179336921871.155032.16860719113022909837.b4-review@b4>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793369220; l=556;
 i=nuno.sa@analog.com; s=20231116; h=from:subject:message-id;
 bh=YfB/GT8yFUaGJznbokBxtUX1b1R4911Kz75tZ36bBfk=;
 b=NZ8iM0I59pMBL1AkiBKSDMLu2GRUt5e/KFEQIqJvF4BiV4iyibpc+kT2rJbskYHDdFk1VlB0D
 ytXVSriECvXBdH+nz8dnLRxyTkfGXBk2T8+ddAxgcpNZb6qK4/zyApH
X-Developer-Key: i=nuno.sa@analog.com; a=ed25519;
 pk=3NQwYA013OUYZsmDFBf8rmyyr5iQlxV/9H4/Df83o1E=
X-ClientProxiedBy: MR1P264CA0165.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:55::13) To SJ0PR03MB5469.namprd03.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: SJ0PR03MB5469:EE_|SA0PR03MB5529:EE_
X-MS-Office365-Filtering-Correlation-Id: 313098f3-1d11-4b5a-ef0f-08df368ee1f8
X-LD-Processed: eaa689b4-8f87-40e0-9c6f-7228de4d754a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|10067099003|261022075727099003;
X-Microsoft-Antispam-Message-Info:
 O61QQu5kw5KPGERUlov9iyMpRudpssoTu8NpnwwUYLO5HtkcaxY2gKfRmdaSKZ5u6V+ml1AHYneZ6sn47JreOofS5EUunVJhFp9mpBbM2AfSYuF2Fu/P5+5QyQ/zB9+brs7/WvGr2HYbAcKvzLxK+nwYOli/9JHL1v965xF1CI9VO0Qu8kRbIO8TZr+rUhUeh0lb4GNC9Nu9N6bJyD6iEM9RSHM94NaBG/fNeMdCsuWfwzScpm7UPbh3j9txkLQ81L7kDXB3lZawgh7dvGsfJGZLlYdEn4GoxAWzKM7w/D1NiyS8ZYvXsIhkeuWirt1M6nDSnDz7F5K8mYW3XdHBZPsgPcyEP3w9PzTlbAPVcLNG1lQj09UQ9POr8Gu7T2427/DNGhPNQvm4vQpTwaU3whznL9CDzD5ju/eYPS1/sdu5+Hls+p4fDUq/CI36bTxuSYdDFwuxm7dwGE+VRg2RDTqCFPrLpK4t+XHYNX4xxZ9Up2xFotij0zZsZEbYwDTPOTySkEBma7U2JvQdroCm3FhYMSVNX6dCgjud9kcLRiHQut37sr090yHk3fEt5ISFcnByZ8fFRs3MlgzeZPl9zD1aDSF1PRDyBPA4UqG09FzmA+sjKWupGQkG7Wa5arlugw+OyN2fEkZiL9LWojB/YbhoD5Y+oknpFOUX6qZJZuw=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB5469.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(10067099003)(261022075727099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?Y0pDUTVJYTkxM3RTVEp2Ry96K3dwTWxrdlBnbk5FWnIyQithbXBLTFhpRm90?=
 =?utf-8?B?OGErODVNNTNZb2dEdTU1THptRGRJY2daUWtIR3dJSUFTc2JZOVQ1blVqNUJQ?=
 =?utf-8?B?NjFhN0t2VDM0cVd3dW41VHJCVjdRUGJ6UG95Rkc4aWNOWXpZUXIvbDNodmJP?=
 =?utf-8?B?bUU1dFYrVFZQS2lpM3J4clRZaVA0ZzJMRGRYZXVGYzZUcVpubUM4MGpqRHEv?=
 =?utf-8?B?czFHakRQVDZTZVZuREFCOStsL0xEQUlrVXB5Vy9jNzBGTFJzR044aDJQc2hJ?=
 =?utf-8?B?WFpBcy8yYWMwZ2VqeTRIaWhHZXBtZXVuM1RVYlZheG5jcC9hU2RhRlNvQ2Ey?=
 =?utf-8?B?SUp4N3NkSVJHejJUN2F1SUszQUpra0JjWmtSNEhDaFdFbFllVUFXU0E4d0dO?=
 =?utf-8?B?aTVvRmJiYWRXQzladllON0JUMmYwSWx0WThsV244MHNGRVF5Q3R4Y21YT0FR?=
 =?utf-8?B?Tml1V3NiQnQraDlua2VOTFdLcFNQS3VaVG82dVJqNS9yQ0tOSGs3alFrNjFj?=
 =?utf-8?B?MndhR0F2eVo0WVBoQnNVV0N2UjlyUFFBMzZVSFI2aTl3bDBCMURTMXlzOXNX?=
 =?utf-8?B?bTdPNlhOeUptVnpRbUttZGxwaCtDdGtmdzlJNEE3UkFYQ0lCL25ZU3N3TEpk?=
 =?utf-8?B?WnVreWt6dUFjcDdtNC9yUTY1U3Q1NnFqRjVwNlpxYmptRUpaOGg4RWUzSEth?=
 =?utf-8?B?QjVzMmgraUdFRzUyNmJLeW1sTGVmaVkwWVVjbk5USWFueFF6RUlQSDNFWjlQ?=
 =?utf-8?B?OVlLOHAvaXc1MEM4NTJVVGZZaWdaU0pxUHV3VGpoTlNBWXdCNFFwOWtYdzJK?=
 =?utf-8?B?NEErclVPWUltMmJkdlNFWjdvOHVyd3ZKeVV3eUFwRk50SlVOV1Jjb2dJR3M5?=
 =?utf-8?B?S1pEZTRScGs0QnFMZEl3RXNqT08zcklFTGswV1hKMWVkVlErYzV1SU1uNWp0?=
 =?utf-8?B?UzUzR2VlOXdrUklrMVp2TUJkeGNnN1Z3QUxjL3BVbkgrMTVJNE9pTUY5cEQx?=
 =?utf-8?B?TG9KZlN5WFpIRnZyTnloT0hhZmV1NWlPTHE2dXg5b2xyYjZQWGN4NWpUeUlD?=
 =?utf-8?B?SmZ0dTd1N1dMTGJKaS9yQWNqZmlDRC9YYjYvZzVja2JEbkFxQW1GNkdQLzdC?=
 =?utf-8?B?VUozTW5UeUFMWEJXbnQ0OXk0cWtCdUtDR0R6S3E4MnFnQk5zSXFBeURBSmVG?=
 =?utf-8?B?MzFIeEdBQTdDOXRYS3R6NXlBRzdEVjZvMlkyQTVHMnFGMldNSzdrY0dXT2Zu?=
 =?utf-8?B?UHg4SnlxZTI3WFZneWJyOU9MWHVXdld4VGs4KzRVWXE0V29PUFYzS29hVlNu?=
 =?utf-8?B?V1ZhMStDK1VEWUxIRk4zKzVOMDF6eG91WWZuMGhFWHlNcm0vTlV3VU1HWWps?=
 =?utf-8?B?UjVpb2lXNGM2U2hwOFQzS3lRNkZyUFdab3FxQ1JkWFhDK1Vmc21LYVlzSDZC?=
 =?utf-8?B?dVZLRXJJdzhnRkU1cWROL3cwY2V4OVNyaitMK25mVHlodDU1WnlxYVVGOXdU?=
 =?utf-8?B?UG54ampXU0owMW9FbFVZditRVUwyb0loMnJTaFpPM0gzUjZ2SVBReCtVRFZ1?=
 =?utf-8?B?MVBxczV0dWt3R0l0U0ZJallKNk1EMkZRNjZCOUV1ZU9Ma1VRQkgwMzdzL3BM?=
 =?utf-8?B?S2pxRTJXdjQwNy9keEtuSklGN1plTTJrUUpLRk1RYWhqLzg1Q1dnVk1TeXBn?=
 =?utf-8?B?TGRXV3dnNm9vQlAwR2w4bFhvQWpQaDNiYjZWQ0c0dzVGbUxlY2NkbUhxYmVl?=
 =?utf-8?B?MWZMei82MnYwbUduZEEzRmEzVCtEZWJQcWVtNlpiaTVEMFI1TncxeXlYMUha?=
 =?utf-8?B?QWpMNmtOWC85TUp0OWFUSWh1cVErMVVNdEU2QTNyeE5JZmFDSkFYRjFxSnVH?=
 =?utf-8?B?WGJRYlJCN1E2dk5ZREZkdXdCcTZjMmRNc0l2OWZRVjd2RkNzT0dqZGVybXgz?=
 =?utf-8?B?YlZwbkJ0aHVZY3IrOTVrSURXY2FMWXI5V292VUJwRXZER29CMDNkVG1rY0g3?=
 =?utf-8?B?QVBoWTYrTnlSd3c2S2RFYktaTEl2S2lnbU1uOWU5ZGRWakZYMkhmK1FjZWtM?=
 =?utf-8?B?RHRibllOQy9yTWxFckZXWUJWcWpkRFF3aXp2TTA2Skc2MWRoTXNoc1RGYmpv?=
 =?utf-8?B?TEZMNEFjNXhDUjhHeW9Va1pxd1loRUlxMGFzYkFjbjhFYldxdU5MTUxXaG04?=
 =?utf-8?B?RHg3NXNtODRFTXJUUU1Tc0pMTkg3Zm83SXY5MlZsSWJMWWpSZm5QLzB5R0di?=
 =?utf-8?B?MHdWRlVlTW9ldkZHUi90em0rMUMwSUNlWUlGcXdMMldNMFZCOWpCdUxCb0wz?=
 =?utf-8?B?eUViVzRsamxISTVrVGxhRDZuY1c3aDk2azBJZ2FHQU1KVjd4N0RPQT09?=
X-Exchange-RoutingPolicyChecked:
	KXu/MHQXBqjio0CHwpT4p8ObxRBio319/w4EyVzMEUZQ1ScnC80Cj/xrrQYVcUhWmNnh/G33qnFGLG4nN3wR4+hghMr0L23wHqBKRzvhux9hXxIdK85+OB12uXi0l1zRkcJesorlu7ij6WGLKzHoHcjXn6Cb0908uxJzCEWKIBEuFI4g+rzZGO3+wFt2OxmXbfjDKhr8JY700RTJWyhPnu0VDEe44AmXaz+l7VE0N630Uqc9Z8LZKyFm1zC/lmV4xAf8oXstr7MkEBG+c4N7GVAdxx4DoJAfKQKV4XRQn1chC16wSaQSKRoqD93TnFACaWw6MuDsbaxd0iYAbbT/gA==
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 313098f3-1d11-4b5a-ef0f-08df368ee1f8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB5469.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 14:05:41.6158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Osoow8V71e7cPbaGzSMUpP+nzjAYa5BGqOwlM4ae4uXwCCdY+aiJrw7U2UjhaCkjMpQs/Aef0RXZa+n5T8B2ZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR03MB5529
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfX5dtNwH+ity1B
 RTzkH85WqanhJDPaNWmDofmstDf3WyfdpRjlJNsiSmZUHrNSqzfzBVJmb4uCPpG4fdX2/uHxzig
 z0sllvOyxfaRzkFtuwKNGdq0rgpbSqmeIpdPonJMB0F1alzeRr12NQTK8DegznbOoJO/nY7CqFa
 GHH8qIErvmNvfGxsFA6hgpV91usmud6UI3DQI7WOcZ9STeYbIXO0oycZn+a6LI7guy7fBYvM9GY
 YRfLejZa5+jFYkIfPSbJguxmlQz/QHWmnUN7DrDo8YVF8rZRBLusXiuv8YdTC1SVbvWZe0N1alx
 39PkkWGjzrKKvE6QwkvtH0jn5KYwBPql/Y7jgUP/1uH2s5FPoUpzd+DnyJrxbSV14PIFXPYBXib
 jK7VQYR5ElPv8JwqkVVuJSfZg61zEOxh88roxE00jBzSsi8Vn2kj7XFZ4LbEAVZ50RV7sW1GFNk
 TmGHJ3bLUkoPBzG38RQ==
X-Authority-Analysis: v=2.4 cv=Od8NnRTY c=1 sm=1 tr=0 ts=6ae4a456 cx=c_pps
 a=KPt2yGXPmw0TDFl7M7pFkw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22 a=ZQxX5BWu6Z8IJBb2zLX7:22
 a=gAnH3GRIAAAA:8 a=kPT6GwePYnFsP_h6Q0cA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MTRLf8EWBLdBQWkF48cMy2DOZ0HZ7-Ct
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA1NiBTYWx0ZWRfXxj/qlef4Pi1t
 tEZLcs+36Irn2w10jGH348cSWUz71vc8GZ1sUbG5wjZZHbsaxDOXLHuicM4Fogf4qH+KD0We7bA
 vKxHWcjOj8lPgScOm+MF4n6TFIBSs+Tez3OwrYBpIsE8C7P4bjV8
X-Proofpoint-GUID: MTRLf8EWBLdBQWkF48cMy2DOZ0HZ7-Ct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610300056

On Fri, 23 Oct 2026 12:30:19 +0300, Radu Sabau <radu.sabau@analog.com> wrote:
> __adis_initial_startup()'s no-reset-gpio path called __adis_reset()
> directly instead of adis->ops->reset(), silently ignoring any driver's
> custom reset implementation. Invisible until now since
> adis_default_ops.reset is __adis_reset() itself. Dispatch through
> adis->ops->reset() instead - the same bug existed in the public
> adis_reset() wrapper, fixed here too.
> 
> [...]

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

-- 
Nuno Sá <nuno.sa@analog.com>
