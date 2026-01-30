Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020129.outbound.protection.outlook.com [52.101.186.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B74C242D6C;
	Fri, 30 Jan 2026 11:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.129
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769773241; cv=fail; b=KJASS7nXDyuFmv/coLla5+y9LzM9r/HOezKke2noEdW3efJWeyBs9Ejqn0J0wc5TcaahKo/fqeHK5mq36il9+brQe8USgXVD/4CEfyXdlV6hArn7xgdOFVksCPaEXVWPrd0wvNOKuDkbjQmZ5DJs8sskpBjv6m6TO2OdfgKmJPw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769773241; c=relaxed/simple;
	bh=r7bZULDlho1i0eDhZUAEfiY9FNtNBeoIafB486AZgyA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OOd1gT7bI2CgDZYa+wAXZyQEUd0ZuETQgTsBsiQJuuy6ulvOBCZa3nN5WmnBQ9+NdBaTwa+8aOqQcCQOA3+UomtjWomh0Kq1nPk8TeKkKlDq+G2gpF9RybrvAjeJFL11+eNYfl2tlwrgPIxla8DOQz92Q161D848W09iAVY1tJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=R44TRYBI; arc=fail smtp.client-ip=52.101.186.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="R44TRYBI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=El3EPkoesLvdLuKjioYDXNaKVfMdSvJNApNBnpEu1A3+adQYzDsB9nb9YZObnHajRRjpzGuDaqFuL/Ktc+WHh1mD1EWHc5M9Kh6Z3oPRWC1KT3A9x3xixwOt0Et0N22t3pwa9WkXx/nMcCMjbm3GzOIgJqkpAw6GHL9awvpkraw1R3C4Afl52676JxJy1U8aI/z5C7U89gVExqmiffbNPwBvKLbih+frApTYxaCksiDQxPPgFsh6IIUJ/BHCwhD2UW1RbbgENPGmpGP8H1xqjImhHTSHGPfFVLly4S2fz6mknkKhCjoOTT8LUo8gOZGBsKFCC9Yg6e8thnRRv+ptQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UVSEt9HVucJ5S4DuJ8VySeisLt3P8lMWCms+O8vLHm4=;
 b=B2eZMp5OqGL2qnqx/eD3t/rnSFnapzVvv9yfuSdMYZViIP0I3oCmx1iWT4oPVZPBdTxMYp8rpMOB6WmSKVK7mFDwazdFoGeAFLCESTmeMIOJzP7tbFAUho4TyefM3DRG/+5JrPj0Yoq9HCcBUQa/oStQ+lWbAV5JscRmUb+VwDH50NtwYtvWQQP3pEA5kxyYrPq3PH0rQdDhoQ+hhX2NQAWgwNT5nm8lzsJD2mlRnNoySQ6p2d8wTeVa+iIU8ZVVUsCoenMSOXfcRqjGOUs38qmsrVzGhPjDwdSxoy/P3vHEXV4KMBDZ9dlVU7LUHZc1Cz737t9AQIjpuPWY8YljoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.4) smtp.rcpttodomain=analog.com smtp.mailfrom=duagon.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=duagon.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UVSEt9HVucJ5S4DuJ8VySeisLt3P8lMWCms+O8vLHm4=;
 b=R44TRYBI902iVB7Xc6F+cGZfnsLQnfTHt0wOYd8iEGmvDij0PCA3Lmtxus/BGofmAZpAigLPeI1kr3nHKo6uZPO/C5+IgdrktQ8BrFS91w/gE/nP1kFux5YYcxK7VI1So3ReJiqT+fG/fAK5/M+sp9voGHik/tYmICFEYG/DF7I=
Received: from DUZPR01CA0339.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b8::17) by ZR1P278MB1119.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:5a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 11:40:37 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:4b8:cafe::8b) by DUZPR01CA0339.outlook.office365.com
 (2603:10a6:10:4b8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.11 via Frontend Transport; Fri,
 30 Jan 2026 11:40:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.4)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.4; helo=ZRAP278CU002.outbound.protection.outlook.com; pr=C
Received: from hz-deliver02.de.seppmail.cloud (162.55.72.218) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3 via
 Frontend Transport; Fri, 30 Jan 2026 11:40:36 +0000
Received: from hz-glue02.de.seppmail.cloud (unknown [10.11.0.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver02.de.seppmail.cloud (Postfix) with ESMTPS id 4f2Ywg4yMlz119s;
	Fri, 30 Jan 2026 12:40:35 +0100 (CET)
Received: from hz-glue02.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue02.de.seppmail.cloud (Postfix) with SMTP id 4f2Ywg4g5bz1vxD;
	Fri, 30 Jan 2026 12:40:35 +0100 (CET)
X-SEPP-Suspect: 3919b890d4ef4be6b2df5ba23cd20c94
Received: from hz-scan06.de.seppmail.cloud (unknown [10.11.0.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue04.de.seppmail.cloud (Postfix) with ESMTPS id 4f2Ywg4367z1yLH;
	Fri, 30 Jan 2026 12:40:35 +0100 (CET)
Received: from hz-scan06 (localhost [127.0.0.1])
	by hz-scan06.de.seppmail.cloud (Postfix) with SMTP id 4f2Ywg3bPHz1l0J;
	Fri, 30 Jan 2026 12:40:35 +0100 (CET)
Received: from hz-m365gate02.de.seppmail.cloud (unknown [10.11.0.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan06.de.seppmail.cloud (Postfix) with ESMTPS;
	Fri, 30 Jan 2026 12:40:34 +0100 (CET)
Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazlp17010004.outbound.protection.outlook.com [40.93.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate02.de.seppmail.cloud (Postfix) with ESMTPS id 4f2Ywd3mySz2wv6;
	Fri, 30 Jan 2026 12:40:33 +0100 (CET)
Received: from AS9PR04CA0065.eurprd04.prod.outlook.com (2603:10a6:20b:48b::21)
 by GV0P278MB0100.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:1e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.11; Fri, 30 Jan
 2026 11:40:31 +0000
Received: from AMS0EPF000001AF.eurprd05.prod.outlook.com
 (2603:10a6:20b:48b:cafe::9e) by AS9PR04CA0065.outlook.office365.com
 (2603:10a6:20b:48b::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.16 via Frontend Transport; Fri,
 30 Jan 2026 11:40:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 AMS0EPF000001AF.mail.protection.outlook.com (10.167.16.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 30 Jan 2026 11:40:30 +0000
Received: from ZR1P278CU001.outbound.protection.outlook.com (40.93.85.53) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 30 Jan 2026 11:40:30 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 GV1PPF0E9E70155.CHEP278.PROD.OUTLOOK.COM (2603:10a6:718::204) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.11; Fri, 30 Jan 2026 11:40:27 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::30b2:3be9:48ab:c354]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::30b2:3be9:48ab:c354%6]) with mapi id 15.20.9564.006; Fri, 30 Jan 2026
 11:40:27 +0000
Date: Fri, 30 Jan 2026 12:40:19 +0100
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	dev-jorge.sanjuangarcia@duagon.com
Subject: Re: [RESEND PATCH v2 0/1] iio: Remove MODULE_ALIAS from men_z188_adc
Message-ID: <aXyYi1qhaOodEZrN@MNI-190>
References: <20260123104805.15975-1-dev-josejavier.rodriguez@duagon.com>
 <20260129160502.33cb6a0a@jic23-huawei>
 <aXuPdgiszetBRSsx@MNI-190>
 <20260129182624.18e7ea5e@jic23-huawei>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260129182624.18e7ea5e@jic23-huawei>
X-ClientProxiedBy: MA3P292CA0041.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::16) To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|GV1PPF0E9E70155:EE_|AMS0EPF000001AF:EE_|GV0P278MB0100:EE_|DU6PEPF00009524:EE_|ZR1P278MB1119:EE_
X-MS-Office365-Filtering-Correlation-Id: bf48911e-9308-47a6-4ef7-08de5ff46284
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?w/H/xvbe3WRb3iZOtPJP5jF6R594DXMHyBUm3LjaYGFIT/dbdWH4zcaRxMcX?=
 =?us-ascii?Q?b/FckJOGZa/hfrl4xz7bdkfRbcO1LId10LTj0Ik3s/wSafff8orOZRaJjEfq?=
 =?us-ascii?Q?yLdQyYDKc7+Hpu8GZC0EFfMhY6qadi/OKAFdAfx8ljsTDKrvVdaRr4ljbM/t?=
 =?us-ascii?Q?SWCqnPO3h89w05AA2TjmSPaWzkkjwTlHKg0vIOJt1+qtxJqDoGJfzHW4qG9s?=
 =?us-ascii?Q?j3RZ8V7fUCTC0xmUafAesbyUw3TfKRX0l42qEunAGXTAmx8bH3eL7r9n28Jm?=
 =?us-ascii?Q?pd1nLeQ+4JqmFoqGI/5XA8GN1Qw7YFEO2hko1cqaU+sx65WJRbinB48UCGWG?=
 =?us-ascii?Q?qjobgwKhhvHyxv/N0dXIi5WEuElXv+U9SnTcPXsR9g0OykA29TnMqAs7Brtz?=
 =?us-ascii?Q?fe+Z2Enq9XFNP8x9dMOOc1ZY/TGWyjxnvPCam1PTgNYw3HTFP+6lADUWPXL3?=
 =?us-ascii?Q?imJIQtTSWjxoZSgPrsJB6VMi5Z3Uk7h4IfALHk0cD5+GDzhgaXihlpKUHlWV?=
 =?us-ascii?Q?q/1+olC/e5h6T9Greq7e8tBAZnAyyg8hffhtAask/ZWw/z91blnT399bchuZ?=
 =?us-ascii?Q?PEK2RM+3DDQuF8bKmNVbl9540himZ7xax3orPsXMAB3VL4SXWMHSEASEPorj?=
 =?us-ascii?Q?JQoWmvOo4u6MSYNRAAB3CrSyGdia91i5LarEkWwCRqpZcoFhfRovpLSuh/jp?=
 =?us-ascii?Q?OhIrKymgspvhhak+6gTULhjGcxUYTEDvt8JOaDa7PkldRP3Mz1ePs/cfeoVB?=
 =?us-ascii?Q?qHzFzc/1IEuoJ7uPE+V8y+74chKbf7tgB11tiA2cRmknG79/r2/VYaw6IrKL?=
 =?us-ascii?Q?FMKNGITuYjJYJiCdcpQ4srbKCh4sBaNOV/q5TZSaDl+/E9Tvm8K+/0fynG4R?=
 =?us-ascii?Q?CNgFc3tJJmvQUm1zgvAHBz29fhGj0GLfdXJn6pyAaCo/Bjjucuv8df0WEoVZ?=
 =?us-ascii?Q?SZexVOUAAxXsaUwP5dEnCgMAH9Xem8O4syetENYv8o2hivuxKhKAvRIn41M9?=
 =?us-ascii?Q?dMzJPCXGd8Yl+FdjHcpKe7g4SNjhnDC8bA3bkjEjA1TH1ktO5B0YvuxVgn6U?=
 =?us-ascii?Q?E+yPoBVC1bWBYGjXzoQ5BReCo7bs3V3T3eiYbwnBT7CxhBpNZ6KPzNgEvX+V?=
 =?us-ascii?Q?QHDD63vBcnc17hhDbV3yQQpC6+FLfRpsuLB9/TzTy3x43y8OmqybnDq86gzv?=
 =?us-ascii?Q?5pE1P/NzAonkDSGnxomTRO3kz6maGQ8RYri+JPN6iyE+P0LEFgfL3MejXi9a?=
 =?us-ascii?Q?J5reCS+yde7Mg9Nvs0oWetePmzQ8kxyjvezfqowBokE4pmPSBlefLYu7PBpd?=
 =?us-ascii?Q?OMrS3zOlZGxOIYNM5jyf+aLp0eWZWOyu3yak9UzWH7Ip1mkVIG/0ZRTyVsbN?=
 =?us-ascii?Q?8TuoJTGmTxWRi/Ir9O910rZvEvsgQ041bSLHMQsIewlRpsrL/gT+5tBhSKq8?=
 =?us-ascii?Q?ZvAlBuoJ16midre/vT79/467IS4sSkt0OJSKymenG8wf0AhSwBgxCCkEloAA?=
 =?us-ascii?Q?O6MuA68hWQJJqydknt2qxSzRvfdc0M5NdXn/tgRjjylwo9jW58s7KTXaL3gi?=
 =?us-ascii?Q?zHPNpoBvUrLhpLuwffkWhoX3eBpjCjVwvP1tpSIjxhIxUmy9DLhJuLQqqmK+?=
 =?us-ascii?Q?8pDgw7zpTKt10mnxg9HbkpE=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PPF0E9E70155
X-CodeTwo-MessageID: af43e1dc-fae2-4a4d-bc33-89b93dd2800a.20260130114030@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001AF.eurprd05.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 f08619d7-b87b-4ece-9146-08de5ff45bfc
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|35042699022|82310400026|36860700013|14060799003|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?n8YNYMzngVbeIOteLC6Rua1VnQhqgPCb71STYRvlYS9DM4QzvfS6QFlr8kSa?=
 =?us-ascii?Q?DCRtYj022AZBYO/RL+SxRh8GqMxde+Xjsxm06EdjwtuP7uW2nG0lkxHL/1/C?=
 =?us-ascii?Q?m14HZslR4WhzlibNYRj6BEtHuTq62WnMjVnwMRlSwxtFR8uZqiYOHuzWlTl+?=
 =?us-ascii?Q?+17ZHfSk+wSCd8xnZL0MglaQv7GN8msSFnroD7+n6scipiBiNtY12tCkrkah?=
 =?us-ascii?Q?vkshvuf9em9fk5qk0VPhaxhvw/QPFGb4wLuaOyMW6M0z1F+lkebGhggEWpHT?=
 =?us-ascii?Q?ExNvcJpP9g5PoH+J5m615DmhJBYGDoWaHZn2/SwSZvmRzlmzdtOjDYMASDDs?=
 =?us-ascii?Q?WMUC4+YC9XtX0oNtdqPSu6OK8Gw3tCd1W9Od8+XeMI7HQhXuFDFnhawPeQRv?=
 =?us-ascii?Q?Uhy+MnCdnpeUs+36dgAOS7vUpBKemNVHjpByckH39w/yIFNLvg9uD07g9yzg?=
 =?us-ascii?Q?2cISQPc2by3arRLHRp13H5j+1vGAWdwpg2NKrl/PyXxqXyeLex3E+J/mU/fI?=
 =?us-ascii?Q?xA6tiy4wSQmzmJGt+OufM+rl0/edhMg0IhIlF4hxOo4ZHqOtBtOVzUnSOyoe?=
 =?us-ascii?Q?XVtswZFRpi5oONX8smFDkm9rRkx97yQQ5+mw+VoA5EBgxLiqYLx6zmsj4xGj?=
 =?us-ascii?Q?CkpykXuA0Vr4x4W+b1jZAxjQzF9lAxzAwtMF2QrcTBaP2FMoWz3i2vw71TDr?=
 =?us-ascii?Q?QhSOaFQ0NW+xtO1xNDC3mtKHgKFknK0s4d+UuOriJSE3smVUcEBj8Egx572y?=
 =?us-ascii?Q?v5oJGwxTXzkXdN0hiNCxOjI+kZnoFFnKELy+DekqYvmbSEa9Pei1w9fohF7I?=
 =?us-ascii?Q?Rwva2F1mYmtaNLWOycysnTWxNiyDetCb7lMlSrUqVWfmpikVvCW38fk3WKJJ?=
 =?us-ascii?Q?GawXdf4EK7y03W4qlDC1NxQTBuE4vmFWKhaK8SMMX69XUC2/qVMtw6gGLvo1?=
 =?us-ascii?Q?/71EoqLWNYTVRPRu9L6suOLlAwjt4WdhANKb47UvcVZAxC9mvbwqE9xnidb7?=
 =?us-ascii?Q?7caRsw8jmkKkXtlfIxDXfVX3eIa3yvOaMgq10eAep2HsLS/M36zkMWcO+2QB?=
 =?us-ascii?Q?0q/FYrgEhhjVzYSOFzVFW9THJV3etoVfB+qAbTlYwxjk6nvldnRZjKJhmFrl?=
 =?us-ascii?Q?ohDa0RjcOT3MYPropKzuZhcb9wAvqj67Leg/f0Zhj257NqL7Mkn7pfxAgfGU?=
 =?us-ascii?Q?cCnQu64UwyBCKnvxq06Fm1G2lJoGezVoJtXLAYRQhJpksSvtTguvxOEBE+KA?=
 =?us-ascii?Q?5udKDGLFBLKq854INVP9P+0ZsDfda+h0Qj8gKMT+1hmY1QqmtXkA5hqkVKbF?=
 =?us-ascii?Q?JH4wkvSNdw88H0W+GnJjreC2xeCRi0CzTYn04ghhA1CT4BCFexAc+RKT8/I6?=
 =?us-ascii?Q?kZukmUxxvk7OD7rmv5cdUBm4OkK1WcB1FmFZRyY9k/YuzN791CGamXDxfq8B?=
 =?us-ascii?Q?nZJGE6H9W99ZQt4jER6j8OBPS0r/Q/3OLZCMiP0144sidG6eZCEEcLxRtM2E?=
 =?us-ascii?Q?NFxaq5Z2USTjGIJW0Zk8gEcpKVzq5SDOqXmTbUQP2OqitzUIpc2WyvlVMi/n?=
 =?us-ascii?Q?Zf0+zFqBRqy9dQUnqBRpDwPjaUF+GxELLo2MqgarpUjmfjqhTJk0YpHbmspI?=
 =?us-ascii?Q?JW9DhXrcMA9ReJOsCPcmGQL6xtFPtpgKENdXQkAnDwVKahFZoPS1O6JwZxwT?=
 =?us-ascii?Q?vhPwAA=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(1800799024)(35042699022)(82310400026)(36860700013)(14060799003)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0100
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.4];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.4];domain=ZRAP278CU002.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	007032e9-be1b-4cff-ce8d-08de5ff45f26
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|35042699022|156008;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SXAVLLVGRsLDCaQVI71wXojBe40YWTzB/SwBLCU6Gej+WYeu3I1aGjB3iwc3?=
 =?us-ascii?Q?X95Gp0PjdYogi+OGUQDw05YFIhgGBKX/xOqXMNiUNJs/Mr4Wg0rFyYS9iP4b?=
 =?us-ascii?Q?g/fJUZiEXG5IVqKSLgoSAbjYzPviLvtg/jHDq/3fNmLdqF+/8bE/3ZWG1PKd?=
 =?us-ascii?Q?NOhEYAz7jV2UMZj/E2KrlUmXK26LnLW5ggFhnB1IqLVIR61xZHihAYEenrzl?=
 =?us-ascii?Q?AMhcrWdyNTHzpeTyKh0HKHMr6zSNZNFnPHffYNzkJ7TfipxfTxxtoXUI89Pd?=
 =?us-ascii?Q?lOJF+3p5d4kzi8IHFn4T3kYlVInQIUROmzzgV6rTCPZ1mxp0f/sNK2xLs35n?=
 =?us-ascii?Q?NmukdCYdtVh77iA2yIqcUo64pO1vXlbG7rA+GsF1QcTidDP1xg3I86Wnrfgh?=
 =?us-ascii?Q?bNpW26zz4xf8Y15zAiCZX9yv25z6K4uhjDshI/7A8NxV82yfbQkdOGHJUiFH?=
 =?us-ascii?Q?zM/eJfEINBAUrIQ6ZPaxJJfEHfmAmsp2ZDGZl+gHFYmXDYauPkOIU6dVQBww?=
 =?us-ascii?Q?Bz1z+d/C7MJ7S/PF3XotPXOfrloycK3tTYtMDtV9Z/shmxdacijAoB0Hjzrq?=
 =?us-ascii?Q?NQCJ/0aDl1L22DtYRHTUMWkuhAezCs4qUG4zV6erazax22iedz3yq5tX1fG6?=
 =?us-ascii?Q?1SqsEIVOaSdSgsfpuqh6mDf10xgaxfEYSOTb3B7nBJvLYmnIWMF+pNKWG7/2?=
 =?us-ascii?Q?NfGSe2ykx0o/T03xgKTnxvajUgrgAmPfI2TK/U4yVnjMwaIUXBVGil/ehHK6?=
 =?us-ascii?Q?XqcUJFAhbjLGK95HB53C8CGet8HzVTKoF9jNsE+UVh822ZavJyPTZuaYod+i?=
 =?us-ascii?Q?FDNLwUBdeQ89tDZD+G3qYmI19C9CCCFj/ugbbDB4ub4GnpSb7aTN83n5LCtr?=
 =?us-ascii?Q?ZVynrIufGLoqxeyvLp2H8nP7VKBQSHGTY+sC1R7conZlMbFF1het5MUi6hQy?=
 =?us-ascii?Q?oOCUcdocCDgtjQy2D2diBEBKDMjBCHciw8x9ohOU7MmkFfvrdUu9RYkBN22h?=
 =?us-ascii?Q?Sy43xXJwLug1+wRZvl6KwagNsC6jy2XpjoNI6PW1VV00/3ZwL8DbREhOygmL?=
 =?us-ascii?Q?k1a4LvryxqJ/EPKC+jknWcovlJbKkGvkiA58e7l9GRjkO3nnriZCk96xwAGK?=
 =?us-ascii?Q?F8kDGm6Owlwc?=
X-Forefront-Antispam-Report:
	CIP:162.55.72.218;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278CU002.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17010004.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(35042699022)(156008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	UwUyChBs6V3WRrR2ZzSaKJ7e/ZgEk6LHsXTf0J6CAKrJV9i/570Cv7Jh8zjaph5584LdU7i3CDvWlMDdcg2yzFsV6HKwKtVW+BPqNP8UCDM8SZMb70J2TWpihfiL+KBBv75uoEp665m+rSp4pyZBWGJqTS9RzO/owO7iNrQGuLdh8tSqE7RGm/FQfFNpkYwRQ3ViGFlC76ilbJe2sSiAXPGWpPbCcDruewqJRDWiG0y+1pbbBHQpl4X4DEJJr8NHK4kyb0Gm4q7nk2JtX6D3sjtKDVYO52P8iGpSXtXAl/wc5ET8uHUalwlUSrhxvUDfQDgnmbhp9OLeC9Bkc/NXDxP43ziPbzUOBm/39cSMGY5xeEBi4Gv+PrAbBViciPe3MnK/6X1SFru3T5i9Vaa5OfKiOEupqEHhrdJ3abpjJ4vbwlkn1HhvxVCr+sAyYmHo
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2026 11:40:36.1362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf48911e-9308-47a6-4ef7-08de5ff46284
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[162.55.72.218];Helo=[hz-deliver02.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR1P278MB1119

On Thu, Jan 29, 2026 at 06:26:44PM +0000, Jonathan Cameron wrote:
> On Thu, 29 Jan 2026 17:48:54 +0100
> Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com> wrote:
> 
> > On Thu, Jan 29, 2026 at 04:05:02PM +0000, Jonathan Cameron wrote:
> > > On Fri, 23 Jan 2026 11:48:04 +0100
> > > Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com> wrote:
> > > 
> > > Hi Jose,
> > > 
> > > When resending the first thing we should see is a clear statement here
> > > at the top of the cover letter for why?  I applied the previous posted
> > > version and not seeing any indication here on why I would consider this one.
> > > 
> > > Jonathan
> > >   
> > 
> > Hi Jonathan,
> > 
> > Thanks for your answer. First of all I would like to apologize myself.
> > I just resent the patch because I was not aware the v2 patch was already
> > applied, I came across yesterday while updating my linux-next local copy.
> > 
> > For a reason I cannot understand, I didn't receive your previous answer.
> No problem. But a resend is rarely the way to address that unless
> a rebase is needed (in which case it's a new version anyway!)
> If it's been quite a long time, just reply to the original thread
> to ask if it got missed. 
> 
> Jonathan
> 

Thanks for the info. It is good to know how to proceed in the future.

I've just followed the guideline for submitting patches.

Regards,

Javier R.

> > 
> > My bad.
> > 
> > Regards,
> > 
> > Javier R.
> > 
> > >   
> > > > The first patches I sent for fixing the autoload problem encountered
> > > > on mcb device drivers were 2. The first [1] was focused on updating the
> > > > modpost process for letting kbuild to access to the data within
> > > > MODULE_DEVICE_TABLE and the second one [2] for removing the MODULE_ALIAS
> > > > on all mcb client drivers.
> > > > 
> > > > They were rejected and Andy suggested me to split the second patch
> > > > in a per-driver basis instead of sending all drivers' changes in a
> > > > single patch once the first patch was merged.
> > > > 
> > > > The first patch is already merged on Linus's Git repository for 6.19-rc4
> > > > 
> > > > commit 1f4ea4838b13 ("mcb: Add missing modpost build support")
> > > > 
> > > > So now I am sending this patch for removing MODULE_ALIAS on the mcb driver
> > > > in this subsystem as it is no longer required. This cleanup is being sent
> > > > to each affected subsystem separately, as per the review suggestion to ease
> > > > the handling for maintainers.
> > > > 
> > > > [1] https://lore.kernel.org/all/20251127155452.42660-2-dev-josejavier.rodriguez@duagon.com/
> > > > [2] https://lore.kernel.org/all/20251127155452.42660-3-dev-josejavier.rodriguez@duagon.com/
> > > > 
> > > > changes in v2:
> > > > - Renane commit message
> > > > 
> > > > Jose Javier Rodriguez Barbarin (1):
> > > >   iio: adc: men_z188_adc: drop unneeded MODULE_ALIAS
> > > > 
> > > >  drivers/iio/adc/men_z188_adc.c | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >   
> 
