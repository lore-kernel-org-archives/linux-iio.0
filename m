Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020095.outbound.protection.outlook.com [52.101.186.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD812242D95;
	Thu, 29 Jan 2026 16:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769705363; cv=fail; b=djBTtGit0Fo0D4Iyd/h1V6MgPs1GKIdfcNmc+0qEmNnFHxizNS8Fsg426hSWfbSJsHNTADOwW+7eyhJeJyLNVn5TjxWHqow7umaA24NkMXm6e1BODqao7HhP7HsE+IwKMsiwwytFYUnepoqzuzh2CrwU2XEzdSmXwSDl0u4+kac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769705363; c=relaxed/simple;
	bh=gTQJxWqHOsOrIURekrodjQ/r+vZtU1r/+1uNAxcuvUc=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JhCEdLV9ktW4h9oX28MGH5zWUk3aVzcsFl8en/786Ci8ULnbj2IZrd9mlx5dDrk1BFK11sEcNFko0c8d4pAlzbCEw7T4NslsDZAdLGr5WWjf+biX072z8/S+wHlM8REvbuYKvFlwjrSWKtxe6hdv5spg3QI9NVi7dzDW5sX8Gbs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=nMl+ZVo3; arc=fail smtp.client-ip=52.101.186.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="nMl+ZVo3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaiLI5g3gNGx1AIA8zeveYkYmWQISSoN1/HPCqAckGKaO4RyURzmb6v9UPdo5iFXwcTO+ztgQ9M8kvsEs+DX3Js5OamTuTa89X1NG+ZMJ/INAxNSfT291317kJjun30o2kUmg2RekfcqV1DD7rfHgznhsOFhLuymk/VfqIiNSIz1RzazbIPstlLMusDGmx13LodVXpTipGEQWiU+LiYRwVzJJ9Ip7b85WLg55UzO8n4LNrHeVtANubqLjMTJxGkpPyMDp/GFBkNtznm5mKMsBhsconL/VT29rXvhVm0P+qLHbzeCxMyl913i20QxRdERUcqOUxDc6mPNZEYOnlehGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtljlQaob3IIVwjUVC4ql1jJwVr7pP+HifStoZg9MdM=;
 b=Lr8pqWBKfvMXDqii6QVxAcGTL8mMispucE9kQPCkeJeyFWbkdXWf9oPCLuqEb+dsdKgpdtMKMygxFIfhbpOtGFWjADX8x4J3AsBTDNA9YgBdOCiA62U0qbVKcH48ugUlS5byUXHXzA49ymlzp7qp71Oe9duYdnYDePY6dIt1rYY+XQBhr62PI72uHMIF+mSNEZ6v+XTl+KgLTyo1u0H7e1aOiXhQRWOFA9Dpg8h8Y8zTx3f5xjzJyYNFaTRQf6DVIr7+WCZjjByqfmcbY0ElHA12KKyC8J8K0fGAer+8wMRyObuoCuI7fHULSXag9uYzcu29R+pRI6//SVEP07AB5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.0) smtp.rcpttodomain=analog.com smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtljlQaob3IIVwjUVC4ql1jJwVr7pP+HifStoZg9MdM=;
 b=nMl+ZVo3MqlO9/fsP+bccoaFsFmlgsVGZQsyN1P+1UJeFMkzCNn/Ka/TZ8/SXmm2jB2sxVimITgYkoKU9HmjMh7YpRSSjWTnmFnoGVJVOgFMPl1hywIMST0qSdqnio4+Jmx/ve2gbg8KBAwDl08mRK8vGTvXO1uUEQUhZpNfFxo=
Received: from DUZP191CA0039.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::13)
 by GV0P278MB2075.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:70::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Thu, 29 Jan
 2026 16:49:18 +0000
Received: from DU6PEPF0000952A.eurprd02.prod.outlook.com
 (2603:10a6:10:4f8:cafe::24) by DUZP191CA0039.outlook.office365.com
 (2603:10a6:10:4f8::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Thu,
 29 Jan 2026 16:49:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.0)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.0 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.0; helo=ZRAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver01.de.seppmail.cloud (162.55.72.219) by
 DU6PEPF0000952A.mail.protection.outlook.com (10.167.8.11) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via
 Frontend Transport; Thu, 29 Jan 2026 16:49:17 +0000
Received: from hz-glue03.de.seppmail.cloud (unknown [10.11.0.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4f24qJ6xjKz4whH;
	Thu, 29 Jan 2026 17:49:16 +0100 (CET)
Received: from hz-glue03.de.seppmail.cloud (unknown [172.18.0.3])
	by hz-glue03.de.seppmail.cloud (Postfix) with SMTP id 4f24qJ6dWfz1yWW;
	Thu, 29 Jan 2026 17:49:16 +0100 (CET)
X-SEPP-Suspect: a7ad3b9db95f4714b5bf90dea9c95556
Received: from hz-scan09.de.seppmail.cloud (unknown [10.11.0.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue03.de.seppmail.cloud (Postfix) with ESMTPS id 4f24qJ49Xzz1y1Q;
	Thu, 29 Jan 2026 17:49:16 +0100 (CET)
Received: from hz-scan09 (localhost [127.0.0.1])
	by hz-scan09.de.seppmail.cloud (Postfix) with SMTP id 4f24qJ3bfvz19Gs;
	Thu, 29 Jan 2026 17:49:16 +0100 (CET)
Received: from hz-m365gate03.de.seppmail.cloud (unknown [10.11.0.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan09.de.seppmail.cloud (Postfix) with ESMTPS;
	Thu, 29 Jan 2026 17:49:15 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010000.outbound.protection.outlook.com [40.93.85.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate03.de.seppmail.cloud (Postfix) with ESMTPS id 4f24qF6SFvz1w4M;
	Thu, 29 Jan 2026 17:49:13 +0100 (CET)
Received: from AS9PR06CA0343.eurprd06.prod.outlook.com (2603:10a6:20b:466::26)
 by ZR0P278MB0075.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:17::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Thu, 29 Jan
 2026 16:49:11 +0000
Received: from AM3PEPF0000A79C.eurprd04.prod.outlook.com
 (2603:10a6:20b:466:cafe::f) by AS9PR06CA0343.outlook.office365.com
 (2603:10a6:20b:466::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.9 via Frontend Transport; Thu,
 29 Jan 2026 16:49:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 AM3PEPF0000A79C.mail.protection.outlook.com (10.167.16.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Thu, 29 Jan 2026 16:49:10 +0000
Received: from ZRZP278CU001.outbound.protection.outlook.com (40.93.85.28) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Thu, 29 Jan 2026 16:49:10 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR0P278MB0799.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:4d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.10; Thu, 29 Jan 2026 16:49:08 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::30b2:3be9:48ab:c354]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::30b2:3be9:48ab:c354%6]) with mapi id 15.20.9564.006; Thu, 29 Jan 2026
 16:49:08 +0000
Date: Thu, 29 Jan 2026 17:48:54 +0100
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	dev-jorge.sanjuangarcia@duagon.com
Subject: Re: [RESEND PATCH v2 0/1] iio: Remove MODULE_ALIAS from men_z188_adc
Message-ID: <aXuPdgiszetBRSsx@MNI-190>
References: <20260123104805.15975-1-dev-josejavier.rodriguez@duagon.com>
 <20260129160502.33cb6a0a@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260129160502.33cb6a0a@jic23-huawei>
X-ClientProxiedBy: MA2P292CA0025.ESPP292.PROD.OUTLOOK.COM (2603:10a6:250::9)
 To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|ZR0P278MB0799:EE_|AM3PEPF0000A79C:EE_|ZR0P278MB0075:EE_|DU6PEPF0000952A:EE_|GV0P278MB2075:EE_
X-MS-Office365-Filtering-Correlation-Id: 0575c323-7230-4461-4bf7-08de5f5657b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?p+Rn+AHDUd6OLThe6UgzeW6IUrlqHjIiwTl+Ju0R6C4K+tjO607V3JPWYSJJ?=
 =?us-ascii?Q?p9K/V78yqf7GjQFm35pdqETFWz7nw/2J4rX/Rgp9GymFVIsPjWfNK2z7kyV2?=
 =?us-ascii?Q?43nlDbP2vwCJSqh7M95Lgz3OfJe7Eg+lwBxHQCmOgbFv73MmRo154M9QqBCz?=
 =?us-ascii?Q?KJG7jab/Gy47jorL+y3LPjL15dQdf/8fSZwNBRZFGO+bY90NawhF2/ngP1x3?=
 =?us-ascii?Q?xT74nMafwtfe9cOtQPCvwEgMVM6VV7oXiPyf8gGpe8jMXDulQQloPT3Y2WWe?=
 =?us-ascii?Q?d14hR4lJncYFCuc1+2L/fNthnwzIphOWQlqNB9WY5YVxiEIrH/Hfd7npdvv4?=
 =?us-ascii?Q?W5lgzRNGbBO3kazX9xR0Az8y1k3NyTs54u4E8Bq56D6FeamkmzI7KHmrRUhN?=
 =?us-ascii?Q?83YrEJOZRRiCNThtf48pAM1X5+n7KqOO3l49MxjVHlTPWLVDsLVBxzAu5YmS?=
 =?us-ascii?Q?sN8MWjJu91LVX620uEpre+Y7OXgpGepAy40VlIX36hmTBeBe5+jTg/0iqC95?=
 =?us-ascii?Q?7UDiutZr73hEdSFqxkZxjXKMO9LaeFGLGFmTxxNMMoVU+m1WSXsZEgfL2mpM?=
 =?us-ascii?Q?bu3pnI71c/9gs5wz9/pSbK8bskO6Zo4VFgEiR7l0Zpo04PL6U7CemMKKS4rK?=
 =?us-ascii?Q?diU89D0sah9EWfYIhMhJ1F8+E0gfgBWGiMJbA7/qnNE650JjL3UleJOVKWOB?=
 =?us-ascii?Q?dvaPUnTi4pUlrsOKIUDVhF7zb+t3AChmlN5nyyQDAgDhXdVrxcUk1i5s7zaH?=
 =?us-ascii?Q?u/yqSUWgwPaLxjeKYp41F8fO941tWXDuTj+/VSoN3bnnWqjOvVYhdrWNodPZ?=
 =?us-ascii?Q?LtvbhB3RZfdvqLWfqOC1TjwiQd7cpxp8dHUa7sZRMH1GVvsIpNVjUmU4bdyK?=
 =?us-ascii?Q?e4o0HxBnKjK93mE0h2FhatVlBHjaVNAdHwNq6mU+y3EM9pDoW8qHK2PQkObL?=
 =?us-ascii?Q?ElRkPem+zC35q5scJ/ABdvND8F0aS0abAgqxZyXz6Z/p29vzlxoFED+sKo2r?=
 =?us-ascii?Q?tiza7vXtGlLFTiJ83jyChn2EO/Wv2Q0B5EhxgTpihXLGtIcWV5DcvT2BfEf0?=
 =?us-ascii?Q?EbcHBwMBxozxJdQjXgC/twdArB5P7peBOVVBFYMlWkdDX8ybGCT3FOe1ID+M?=
 =?us-ascii?Q?CSyGB6naFyzJI6NzzIEvk4YCjOKyLRHVwDJzA4Qa7Qq/7s+iWJDkmSUI9zQd?=
 =?us-ascii?Q?3AYh+qoh9airgyYkPfKMbqY5EzU0Rn2ehc2IkenybQ9xnZaPTrqn9zEr9FMi?=
 =?us-ascii?Q?JQkzlvx9bVD/KAKHnKBCWAtIAp/zrDIqLBvlaT7gI/U+CFnXLpDJoxE1z1/R?=
 =?us-ascii?Q?bTWn/a0MeEGoU/eXBNsLVQKbkmnXuHpeSXf04YIiIB8UWxCZwuwozQIAwm1G?=
 =?us-ascii?Q?UaEBouK4E2KH9hk0pTdsIQLYnqxtKRny7B3DX7GX5XIsLOLq5EOWts+R8PhA?=
 =?us-ascii?Q?hhKlpM85aNm9gMP7K0Tk1v7uaigw15npY7yztoXVYC14glCKmtzfBmdKH0Dg?=
 =?us-ascii?Q?ECXI8qq0qxWy4qICsr4IChi2MYiB3YuqQJN8atBgtgitTqlAWtuOQt8Bt3G3?=
 =?us-ascii?Q?mXoAAUhhGoqRi5WUvHpKl5Ffnj6RybsFHxpUVrVhgaRveRiF4m8n0tlzr9L5?=
 =?us-ascii?Q?SBsJlfcPFq9LxDrNKaDOrxo=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0799
X-CodeTwo-MessageID: 9ab14611-fbae-4b99-b519-2f890a26545b.20260129164910@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM3PEPF0000A79C.eurprd04.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 aa9a996c-b940-4d7c-bb0d-08de5f565257
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|35042699022|82310400026|36860700013|14060799003|1800799024;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?g2qzEXlPS7zQ5fIgBU6jHRHvfpj+0MA/q6sGEkvNJd1cZS7Wuq4K/mHz4Pli?=
 =?us-ascii?Q?lfWZw9+DxzSUFoMXRKfa8Bd9kO9c3IS2ybaYze+GDQcfo0avfBB4uUkAMnbQ?=
 =?us-ascii?Q?OaknoQrde8UCOYAUsRkpHyd3Mtkunu35HOy8/1pse2PAuEFBCTXRqKUlbudn?=
 =?us-ascii?Q?jGejuCUOlmtP0pte4mcypxGjiWWBrg/ZY91tGB16mEystuMAWOwyXp++KaBp?=
 =?us-ascii?Q?FUc/kySrhDqQyA5Ka8ujfvEBueyjkRxahdGAnjXGdKrhmdJCvvyTIcRYcjkw?=
 =?us-ascii?Q?ya+vW3Z+BIPTzOhkWSjVyL581FbEZL+6wkuaHYlpC82b65oKjDI9R5a+GIPO?=
 =?us-ascii?Q?4PjRQVJzAgzskY+SByHF+YcTSSkY6eInBr/kDq7kLNfvMfX6aXE6q2ZxWKgr?=
 =?us-ascii?Q?L3fgh5hltgnJgz8kKvkEqoGVtAd37UG/EuBokJ54JL7MfbApzA8dm7cSHB2K?=
 =?us-ascii?Q?h3coIoigKlqaVips4UiHBY+YdiM1l35JhOw0LJQkrkuK36w2/MfLj+9PhQh3?=
 =?us-ascii?Q?UKftc/qg99neWiQMu6J4JP1CM8fHcbDrv3BAGSGpHjzyjQn3mEJvDEFKoD/C?=
 =?us-ascii?Q?ouffaNvOfH1Ig+GXO/D1yjE0z6BRS6EQ8W6mcbttQqcc6ivjdqyoedlIVILK?=
 =?us-ascii?Q?DqKRvn8S1NHPpL5ivwxpkfvj6PuN5PoHmXSybM40WCEedvoKZdJGJZbvdkTx?=
 =?us-ascii?Q?voMFr2SmLqDXZvVgdObXALkr0A0cYZ9inpTvlGst5awy5Hxtjz/uw1pfATyB?=
 =?us-ascii?Q?YBiO9l3M+3SF4aTZ6luZcTXtZ3u/t2M+fzw8SRSEkTQljHLTJBq0WBXB5mq9?=
 =?us-ascii?Q?+kESHbmmUt0h+BVHO3BqIjkzWE7KYgQ6XlxRg2eT/MKFLQh297pqT32+AbXD?=
 =?us-ascii?Q?cXRDCQxfsyM7FYYysUNOISGmtFaiouXHJyF/iBzo0cvOItHbxlF5QT1IP7XM?=
 =?us-ascii?Q?9snnB4jz1qwjVNdaLbL5PD2wX9O3Dw0Fb/HAMQ1f/4V4vx31Nk5o+DYm1VVk?=
 =?us-ascii?Q?7FRizKXU+LcdctV/ID8vFygZNisyQL07i0Kpk5svrftxWYZblUPd1sBkcXve?=
 =?us-ascii?Q?5bEu3qQ9EPoLBYckv10ZwiGLFZhnFq/iNFVH1V125qTiMzpRapdVMyOcf/ms?=
 =?us-ascii?Q?u0nHJD97abkcxVR3EslTqbhKBnKkgeEld6MHXRHSmv+MTY/il3wTE1O4XfTJ?=
 =?us-ascii?Q?E7qYVkAOP96HJN3+Cmp9yYXD2WvsfsOB1GMMU/M8Wwuc/+c/VzKeWle52o7Y?=
 =?us-ascii?Q?nAy1PA0OidG30GTh99C3iDL6WlRwJgzhxPTl/fGlCzjGTipGjobPFYkZog/F?=
 =?us-ascii?Q?o6YTiPMSoiqAfoGjk6tUTPaKjEFzE46gxnO6XhJUae/79RpgUybgV60zuA/D?=
 =?us-ascii?Q?V1dTr3u1nhSNMEzoJltKXeGQraRpn7lzazGa3rdLZm/VFSyaXX08tYASjF2n?=
 =?us-ascii?Q?ehEKy2ZqiN0B5ALKo0oPUXre2l1eZ06DWOy3yZY1bx3ZS982iszsLJqN+afo?=
 =?us-ascii?Q?XwMxxdfk0RHDaep4SMQa0BXBJN/6m9fi52yyY08vU9mlr05psCCGMQoPx+mk?=
 =?us-ascii?Q?80inEs06IrLGlWVyAoP6FRjhpwFKTj5akBvzQrt7G98qsXWQuuBCg0nHvUc/?=
 =?us-ascii?Q?nYsu03LtjLh446RvsegM4EV7SxbzDA9byfXdLgGJRZpDl679bevZdLwyC2F6?=
 =?us-ascii?Q?oiQaAg=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(82310400026)(36860700013)(14060799003)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0075
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.0];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.0];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	16fca9b2-873a-4be6-973a-08de5f5653ae
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|156008|35042699022|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yphsbOXj8DUEIg4Ja/MXScqPUW66/LmQFlG71TU3sz2prPPnj40FrYgavOlc?=
 =?us-ascii?Q?2TKo/OC5+b9p27gXPpJ2Ug7rgOX3XFX7kjN6I+td27NOCCPGv0HV0vi4UJJW?=
 =?us-ascii?Q?d2yTWxvjOtraJ9b8zaeeauswC9mhk9fxuvpkooS04P3egcm4u0L9lKdRwNOt?=
 =?us-ascii?Q?3Su/48Sd6YX7yVbxTMZuWjuFqitWj8u3f+xnvy517FFRxJ9mr23Dt4pzjjV6?=
 =?us-ascii?Q?MAAsogw6nQjeC3w6Y2FgvDj+ZFaf3/jaWXRZTjVmm1cSWzZLPwAfr3LlSQuR?=
 =?us-ascii?Q?vcpRBG+9bEkflxczIRDdOiN/VN8N9JpUingHCTjX8r5whki2Pr+k2wAD9O7i?=
 =?us-ascii?Q?Z8Ii7QSd1X0LXWncU5uh9o4Qu/231mv6WifcxiDmRMvjrsugTgK6L22PavXR?=
 =?us-ascii?Q?qSPe7lYXxXRTKzCgIfLjP8JmyU/xLgiGpWfivY1ljjeCQn6QS4GhLXgBi6u1?=
 =?us-ascii?Q?r0bLq6oSu7YTlTlcPbBE9CqX4uv4ZqPMb3fcbQRas3geEyLATLsbjIYDkfkN?=
 =?us-ascii?Q?P9yMKrTyQZW5pjGRichUErTAeAdyoKH7cCJOR1juutrIdlZrn3KOqJQi/XXR?=
 =?us-ascii?Q?V2C7AOLo9NcPbhqDBOz9xLfuPiU2GRvc3po6BKwIxFh1tT27UMYtNE345I1N?=
 =?us-ascii?Q?xyIZuYrYuS9G3W62YiwCaFJktx4SrsRJ0gBuCrtG02UJvOd4s2G6glGhjd9j?=
 =?us-ascii?Q?6t4vHEpl44kdDbxcwXAg8Y0BxoXWTBPlnFRWPo3MPH9T2LlSflFUkouHwjtw?=
 =?us-ascii?Q?e2CT0xhuDl95Jk3CpbUvntg3VUJRK0b7JFeYcdwwyfWKf1q09Ig5QSwWSunM?=
 =?us-ascii?Q?r6j38ETpfBvO44+c4boHlsxFXYe8EINgGtUb+hEhiJsfE0C50KQx4+s0/AG2?=
 =?us-ascii?Q?XSj+5tRWlX/kWuk2vL32GMGImKanX07voooh4piJ0687TtFwR6q/uQga4ZP9?=
 =?us-ascii?Q?bWdeUdG5tWEiuL4JiAAvQj9lWLvMdjDdJlSflFV1/rn583EQl81t5wiIZMMZ?=
 =?us-ascii?Q?RoP4VJMrhSFU28X2CqF870+aYYq6X40P5TFR47Sh9J7tJd+k378KqBQrgcOQ?=
 =?us-ascii?Q?Ub9fJig/OIwDFlHqKQKFmXUB5jp5BscQqC2Z6P5zZUwsS18+zzO7C7CqVaHK?=
 =?us-ascii?Q?4oZWjumfRUNw?=
X-Forefront-Antispam-Report:
	CIP:162.55.72.219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17010000.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(36860700013)(156008)(35042699022)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nwlXcMvdT4yPB/v1EqpITq81JlUZ9yAoXeuMp5hviJ6Zp/NMVz4HfNJEVx8FMibG7UhYqBZqdY6eHrIK3T6A/vbPvWgynvuvb7hkYw41YxPFFgZ5iYgtWbiNIXvgRHFEM81p6b+o7FD3MxgB8pEa2UFR0uwabKBYgynrE3w4a/XTYNpX9YvfE/SYf7gwhaOnLPxShmeY9kcjwkAqza4j3aw96AzIvCPBqgbmaWTG/Z5HN0yqXG4c6tn5soOXbPIwLqvWWgFbuZUUBG0RTAsSk39boR36EYz0lrObB+SkIKeELWbPNEQ4cD5YxldciTqkMHrDB73zDdzBOBZAfXoWtNKZRkXA8uv25pEMl7rsp5ZyhvA8g3P1GeorzjuhLeos+OeMWW35nRNeQj5WV5A6cY5PiHJQ0Qtbw+Gwt2oScPx6iCHDunZA83AnYGQ9iayL
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2026 16:49:17.5371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0575c323-7230-4461-4bf7-08de5f5657b6
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[162.55.72.219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000952A.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB2075

On Thu, Jan 29, 2026 at 04:05:02PM +0000, Jonathan Cameron wrote:
> On Fri, 23 Jan 2026 11:48:04 +0100
> Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com> wrote:
> 
> Hi Jose,
> 
> When resending the first thing we should see is a clear statement here
> at the top of the cover letter for why?  I applied the previous posted
> version and not seeing any indication here on why I would consider this one.
> 
> Jonathan
> 

Hi Jonathan,

Thanks for your answer. First of all I would like to apologize myself.
I just resent the patch because I was not aware the v2 patch was already
applied, I came across yesterday while updating my linux-next local copy.

For a reason I cannot understand, I didn't receive your previous answer.

My bad.

Regards,

Javier R.

> 
> > The first patches I sent for fixing the autoload problem encountered
> > on mcb device drivers were 2. The first [1] was focused on updating the
> > modpost process for letting kbuild to access to the data within
> > MODULE_DEVICE_TABLE and the second one [2] for removing the MODULE_ALIAS
> > on all mcb client drivers.
> > 
> > They were rejected and Andy suggested me to split the second patch
> > in a per-driver basis instead of sending all drivers' changes in a
> > single patch once the first patch was merged.
> > 
> > The first patch is already merged on Linus's Git repository for 6.19-rc4
> > 
> > commit 1f4ea4838b13 ("mcb: Add missing modpost build support")
> > 
> > So now I am sending this patch for removing MODULE_ALIAS on the mcb driver
> > in this subsystem as it is no longer required. This cleanup is being sent
> > to each affected subsystem separately, as per the review suggestion to ease
> > the handling for maintainers.
> > 
> > [1] https://lore.kernel.org/all/20251127155452.42660-2-dev-josejavier.rodriguez@duagon.com/
> > [2] https://lore.kernel.org/all/20251127155452.42660-3-dev-josejavier.rodriguez@duagon.com/
> > 
> > changes in v2:
> > - Renane commit message
> > 
> > Jose Javier Rodriguez Barbarin (1):
> >   iio: adc: men_z188_adc: drop unneeded MODULE_ALIAS
> > 
> >  drivers/iio/adc/men_z188_adc.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
