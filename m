Received: from ZRAP278CU002.outbound.protection.outlook.com (mail-switzerlandnorthazon11020136.outbound.protection.outlook.com [52.101.186.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F30270552;
	Fri, 23 Jan 2026 10:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.186.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769165418; cv=fail; b=Tsukj3xpng0qIx7HT7cOJK/mHP4mF7XVOfL2xIRE+H5T0Fgg2Vj4iwJJvJEMQTJ8M6rvK6rxQs261gBRD5ZVygfPe1c2emv9oJodmgpZ7Y6irtVroaXHiwWD7XVjon55EIXL/mSxzfcwmvhXal4Ta374A85N8Q7vYBSGEHCa2zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769165418; c=relaxed/simple;
	bh=Wu2mzgDxqvnxkmyH0b/M/XwgWKT/ANrn+5kB0TeXLz4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dDfabGBTaQTqXz4aw+iTwl9DoqVWTSIOwY/hpvA8qioAWen+WzM/cH6DmxxTOxqx09mhL/tL56TgjCgP9ruISQTiXS/ij8Y2ZqUeiE9JiqHnzaUNoBURGj8AQx0V31M9DJvT4KP50G+5JvM8UX2xw3DQ7f6Fcez15NI0IvTaHCM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com; spf=pass smtp.mailfrom=duagon.com; dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b=YM+mSHtF; arc=fail smtp.client-ip=52.101.186.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=duagon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=duagon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=duagon.com header.i=@duagon.com header.b="YM+mSHtF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8SV5TeebobrwlKLpFkGZgnWYP/L6+6Jjl3Ag+ydDf7UDxCS6hzbipXBoFEfqrlrFSLouTmFr79ty9U5M3+0ivIc9oYHnsP7EAS5dvHblOQpYhYwEsvbTCbS666wcDyyL3k/1SGEus/LS4JcWLi0qLLLuRYwX1OS+8sWpHqYYriVR1NqidPcLmfQnTmLAFeKNe0tposBBfcEsc02kLBUBF35bgcdssbou9gGLKw7L8N3eb428zUbyN3ehVqdizXV9MYAd8oUxSKJOzgpwjVtZbdsH1wr7VPrIwuroVYbB+ARFfU2CETSGZBg5Bk6/OvDJqNqPwnPCncNDTCvBBeYSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wu2mzgDxqvnxkmyH0b/M/XwgWKT/ANrn+5kB0TeXLz4=;
 b=WGSDmJuZSm6sa6KJEsCgJOn1mHRAR3l1RrvLlAlkEchwXR/X6UTXNnJ5n2kv8VbuECUwx3sPw/LLBjWamKeh1+YcE5upylyIOIurt2bMQ4ydhpP4+r8etfT0gn38sRQMwtMRJ4IA1I4+icbl8uOiTwxpSLRHEa2ybtuocjm/3y59KlLzUEzoDpNKibTJ5IIbRkgHWSxyJ4UdROw/LsLRCIoTz6PEj0lvG6pcy5IDvgMaSDuuDpGtIR0q/mxRGKgScRB5xsMi3WMG2BE6Cx740iyG02Kf3cc2ExV1pYKoJCji5+5tuYedrrdLHPg9uB2jbNZJOjTwwEQ8shegn0F7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 40.93.85.30) smtp.rcpttodomain=analog.com smtp.mailfrom=duagon.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=duagon.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=duagon.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wu2mzgDxqvnxkmyH0b/M/XwgWKT/ANrn+5kB0TeXLz4=;
 b=YM+mSHtFn/0DVMJ5K45/6BprBIVTeOnQz+KQ9mxhm1HJ/VHULPDb6XZpjouC8DtyYb7QoJ4/aikhfGMQTVT9rNkiaTpRsb7+GYly48sfraRPaxu5brdFDHPARztEpDHWo2VX9gD5M5bTRttQmiuHiEVYgXDy9ffo+jykfvruZyU=
Received: from AM8P190CA0029.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:219::34)
 by ZR0P278MB1364.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:50:13 +0000
Received: from AMS1EPF00000043.eurprd04.prod.outlook.com
 (2603:10a6:20b:219:cafe::9d) by AM8P190CA0029.outlook.office365.com
 (2603:10a6:20b:219::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.11 via Frontend Transport; Fri,
 23 Jan 2026 10:50:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 40.93.85.30)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 40.93.85.30 as permitted sender) receiver=protection.outlook.com;
 client-ip=40.93.85.30; helo=ZRZP278CU001.outbound.protection.outlook.com;
 pr=C
Received: from hz-deliver01.de.seppmail.cloud (162.55.72.219) by
 AMS1EPF00000043.mail.protection.outlook.com (10.167.16.40) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.3
 via Frontend Transport; Fri, 23 Jan 2026 10:50:12 +0000
Received: from hz-glue03.de.seppmail.cloud (unknown [10.11.0.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-deliver01.de.seppmail.cloud (Postfix) with ESMTPS id 4dyF7l5PZ3z4wxs;
	Fri, 23 Jan 2026 11:50:11 +0100 (CET)
Received: from hz-glue03.de.seppmail.cloud (unknown [172.18.0.4])
	by hz-glue03.de.seppmail.cloud (Postfix) with SMTP id 4dyF7l5473z1yWW;
	Fri, 23 Jan 2026 11:50:11 +0100 (CET)
X-SEPP-Suspect: ac11a6edad944869a26ce31a2d73de40
Received: from hz-scan03.de.seppmail.cloud (unknown [10.11.0.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	by hz-glue03.de.seppmail.cloud (Postfix) with ESMTPS id 4dyF7l4YD9z1yWK;
	Fri, 23 Jan 2026 11:50:11 +0100 (CET)
Received: from hz-scan03 (localhost [127.0.0.1])
	by hz-scan03.de.seppmail.cloud (Postfix) with SMTP id 4dyF7l3x8xz2XGP;
	Fri, 23 Jan 2026 11:50:11 +0100 (CET)
Received: from hz-m365gate01.de.seppmail.cloud (unknown [10.11.0.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by hz-scan03.de.seppmail.cloud (Postfix) with ESMTPS;
	Fri, 23 Jan 2026 11:50:10 +0100 (CET)
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazlp17011030.outbound.protection.outlook.com [40.93.85.30])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (2048 bits) client-digest SHA256)
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (not verified))
	by hz-m365gate01.de.seppmail.cloud (Postfix) with ESMTPS id 4dyF7h6JMhz2wdK;
	Fri, 23 Jan 2026 11:50:08 +0100 (CET)
Received: from AS8PR04CA0152.eurprd04.prod.outlook.com (2603:10a6:20b:331::7)
 by ZR0P278MB1414.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:96::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.11; Fri, 23 Jan
 2026 10:49:08 +0000
Received: from AMS0EPF000001B5.eurprd05.prod.outlook.com
 (2603:10a6:20b:331:cafe::39) by AS8PR04CA0152.outlook.office365.com
 (2603:10a6:20b:331::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.12 via Frontend Transport; Fri,
 23 Jan 2026 10:48:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.79.220.33)
 smtp.mailfrom=duagon.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=duagon.com;
Received-SPF: Pass (protection.outlook.com: domain of duagon.com designates
 20.79.220.33 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.79.220.33; helo=de1-emailsignatures-cloud.codetwo.com; pr=C
Received: from de1-emailsignatures-cloud.codetwo.com (20.79.220.33) by
 AMS0EPF000001B5.mail.protection.outlook.com (10.167.16.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Fri, 23 Jan 2026 10:49:08 +0000
Received: from ZRZP278CU001.outbound.protection.outlook.com (40.93.85.28) by de1-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS12) via SMTP; Fri, 23 Jan 2026 10:49:07 +0000
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=duagon.com;
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:34::6) by
 ZR4P278MB2012.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:b5::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.11; Fri, 23 Jan 2026 10:49:06 +0000
Received: from ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::30b2:3be9:48ab:c354]) by ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 ([fe80::30b2:3be9:48ab:c354%6]) with mapi id 15.20.9542.010; Fri, 23 Jan 2026
 10:49:06 +0000
From: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
CC: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dev-jorge.sanjuangarcia@duagon.com,
	Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@duagon.com>
Subject: [RESEND PATCH v2 1/1] iio: adc: men_z188_adc: drop unneeded MODULE_ALIAS
Date: Fri, 23 Jan 2026 11:48:05 +0100
Message-ID: <20260123104805.15975-2-dev-josejavier.rodriguez@duagon.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260123104805.15975-1-dev-josejavier.rodriguez@duagon.com>
References: <20260123104805.15975-1-dev-josejavier.rodriguez@duagon.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: MA3P292CA0035.ESPP292.PROD.OUTLOOK.COM
 (2603:10a6:250:46::14) To ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:34::6)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	ZR0P278MB0523:EE_|ZR4P278MB2012:EE_|AMS0EPF000001B5:EE_|ZR0P278MB1414:EE_|AMS1EPF00000043:EE_|ZR0P278MB1364:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d2071c-98ba-4341-0c58-08de5a6d2f3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|52116014|366016|376014|38350700014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?zMZ3UXyQxf440F7MNAokvn+XBWIaiDZ8xAdCQV89lqklr8MoVQGMi6/AmYmY?=
 =?us-ascii?Q?qGVHmu7XXUn/YzjMsGNHAa8iNCC/RQLgUf91gt2u9oQDVh0C2j2kJU86PU7Y?=
 =?us-ascii?Q?fYZxDkSXTfZIySREB2vE+0p5wH9eEws/1Xk6rAGqoejlXK+Zc5G4npGPIAI0?=
 =?us-ascii?Q?uLNcy7IHLX0dGgjUzZz8N63OOfkMk/cVSEZ843IbMcsmZ9TkoNL+w8zGoQ+S?=
 =?us-ascii?Q?AyqnBehtxlPCEKNP94S4ap74jt8vFSpkYcSb7/7oJnRCp8SmpM55vKXtmUkK?=
 =?us-ascii?Q?vAC6F6A/RzjCbIz77vBanbKw48hDsrQUFx+Gyt6gldq1GLxwHwoAc+GcPQfG?=
 =?us-ascii?Q?FJlg44EUMVW9+Y/9F++jn960KA6FpupB4iKlSRrUcniCMuzB9tHxQ6B48EMj?=
 =?us-ascii?Q?lQxrsCXpc86sJQTVlRNeGXBmKfQ4srguDHSnG1ZamNfa2xXQnYjT9ziWxwci?=
 =?us-ascii?Q?vAEmriHXm7NjwkUoXB+X1wsmmP4kIhDNeIypst55hCGbHtN7FKLII9O0qopU?=
 =?us-ascii?Q?N2q/nDJ2UYGSTrF2SUL4V6AjYEcws1nl2nJFZlrqQI04FVG6yve+zoSsAKYI?=
 =?us-ascii?Q?e2ak22hIlAxi+r6xOxfhCzABG8LZupjWhZ4qKxmJTxNvoIECBiVSWgw1gANp?=
 =?us-ascii?Q?ot6dLt2Es34CqUuGVvI+BHgGrDyTnZhzUdycQ8obhPvsOrjHNlkZgjJxc0gz?=
 =?us-ascii?Q?8xfZqRbjNC7SqN0kgQ7yByRfTO5UyAQAvven5q6/i7D+luyazEbCehrZxZr3?=
 =?us-ascii?Q?OmC6RvIr4pZisgq7RKAkkrubzJWmv1z56VxMGldUv487ntVcA2JLBDXfaeck?=
 =?us-ascii?Q?CrTdnZSmqCHEclODDJ3GJ6B2sda63PkRQUPdc5C8itj26SOq41OoXYQ6oAiI?=
 =?us-ascii?Q?tDvFdb/6mG2MJET6VMAlAp3mxIEGbU921MSRdIl5uBaGcv2+l3vujbbz4751?=
 =?us-ascii?Q?ANXdm+m5uYQNoTH2CBAvOcuK1sHEl0HefOuthJOfxTUD7ijA63IolmDKFasW?=
 =?us-ascii?Q?EP1pa0vKC6uIFTyLbhLlgSWyc5jaQOtQJLQKRBzXPcYVPN92gkHTAB189ccT?=
 =?us-ascii?Q?LERu4VPFddyDIZ4926CzZos/S9DoFI43ge0bM79jz6tVTBQOTEBy88c77RpI?=
 =?us-ascii?Q?CwrxCed+NAHnSPlKWaDAXNqP4hWJQVCTNDI4fysxf8ZKijQs3L4XkQR86e8D?=
 =?us-ascii?Q?ueS8qbSfYoGRcR50ULb3xDI0hMM4QzFpJ1Cl1TNDRNAWeODyfFjkrH3rViaq?=
 =?us-ascii?Q?qsK/U3byxKV4hO3iiyYoJy6xGMhlxYTwv0zUc5TTPqjPfsFMt+pWaoPq47PV?=
 =?us-ascii?Q?Q5GHsfslUi/+TbD7OlwM6kE8DOLKgwLxNIZrogccBoPUSx2tWwIHWsISMahQ?=
 =?us-ascii?Q?nnhSeeWTcEuywRev15z93Zh5IAZSVy160Kjwg94evfFLvQgMvWAl8qIZJE5c?=
 =?us-ascii?Q?sktKnDDALQxsRWOvZiSy8EyE8Ot+NMTxtzvnZU/+YEtomR7f5PCW/TmKdc5B?=
 =?us-ascii?Q?k23k6r4km+JU1xad8sd4kteVpevalUFZXNqC2ruh91CoBhnnKRskQQvafned?=
 =?us-ascii?Q?Mgzmta9NyeXG9KSG0RsIFW+fNOdXB/5wKmFooCHE43KhWyTRW/DYh5SyRCOl?=
 =?us-ascii?Q?SF3UBLXpIfN6NKS17fPfBUY=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR0P278MB0523.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(366016)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR4P278MB2012
X-CodeTwo-MessageID: 024ee10d-52e1-40cb-b639-ac709cfa7cea.20260123104907@de1-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 1
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B5.eurprd05.prod.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs:
 fbac2a05-a344-428a-5aca-08de5a6d079a
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|82310400026|376014|14060799003|1800799024|36860700013|35042699022;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?QC9EZJ294xcqw30OaqcZckQjqi6xwq3DWIU/4lnm6jfJE65ia8rvGkeGp10i?=
 =?us-ascii?Q?iHGuuBsJ7Eu9v+zbgMGI2qXwNcX7STK0HSqxrKqCB/VHbQAu3jz8eyrR6HPz?=
 =?us-ascii?Q?ilmUVZnQizO8oeVQNG5KcjO+4Ntxwi693OTFSfOJvjnidtenEGsoOnTEIF5Q?=
 =?us-ascii?Q?fkDIWP9doWpVxe5+ku4pNzGMDNHrVyFmY8lvaSez3UZHaf29W5mwhy92i8bH?=
 =?us-ascii?Q?pzQP9vYnPj/n7cfwxHx9EqaWlDbgGO98iA6QiXTytMvpwnid4uuFHjzc0dxt?=
 =?us-ascii?Q?J7kvx+s3uFJDyOpMIeUPQpHPdZTL4plk+J5Zx4BeoyZDepRcfrtoWdxqi2N8?=
 =?us-ascii?Q?MHPkpIP7ALuaGDP0CtPhnhtsLsvuRLr7q/BSAGCQLGpChuG4oadYiWBI78jX?=
 =?us-ascii?Q?5x9AHoA0Ul/hZj41gupA5bu9o/w7cmOdbn/gI4w8ewoLFinobf9kBC1m779v?=
 =?us-ascii?Q?xRzHFnncdWFAvZDgEd0JA6QiulM3c/rqSDQ0YvLIp6JwFppC3CKYEgLYj3Z7?=
 =?us-ascii?Q?Djy6cPcpcAZtQjtyMgnMZHnlKRBszPzqbc8K01f0Br7/nPnMekkoJMcZcyzN?=
 =?us-ascii?Q?FzWDyE1dDRq0pvqkQ+7v/bnkQWs2r+MEao0nT5plTvdAHPERsdFXlb5KbF1Y?=
 =?us-ascii?Q?iN+ywYKnQ6Tnre64hEoLMyGEl+aBNIfsYbmGVPCU9ihBVjCQKCDAqewZHU5i?=
 =?us-ascii?Q?W9BeJBlmLPju6UwoTblIksTfo5nWE9k6DB0mEBk+FqLG/REcc9bwN2bQ7Rda?=
 =?us-ascii?Q?wmB5lJWCL5lMp+8U/J+vEZciw5w0evSiK99/QeE8oSrXzNeycBdhy/ZhEMEH?=
 =?us-ascii?Q?sLGrDT26+eRZeKOdycY/Hk9++xWkJjXdMocR5/AYCSQn2wnUqgfn/HxtNFkZ?=
 =?us-ascii?Q?C7WGSlOEpC+ADvTQ6yboTU4guaIPP4Vz8/p0nQFGaPijU4QG2oJe/Zln21lk?=
 =?us-ascii?Q?dHD/4nj6bZD8UFUILOh4KYVjjA/I8nnhKeqtYSZ40B8la0owWPrrdGxEtXbc?=
 =?us-ascii?Q?eLMk7eZKC9hUJ2ApT1FYIRlFacVCHKpSnpvf9Q2cUkSBpFq6ncbq3edswJyb?=
 =?us-ascii?Q?3AdmJT/0l5vgQyLdncQnXiZ4kNEhcn325NdrzF/UxagJ3so5QJyQ9FHkVrlC?=
 =?us-ascii?Q?kV6GLnBE0POC8eUbj1uoGMqV1tHuu7lbtPZv2DkAxm90HAkTL8WZ/2BCoe29?=
 =?us-ascii?Q?V3SATS+gQIwTy3FKfeIzFfSbopvX/EvWrsSxt2iqIMJFxG4ZiEV1W5+UGyUU?=
 =?us-ascii?Q?CNtoHDfMCWmV+Utl83f6Hmkk07eUyTI1lXCV0TCLEFXFVSYJCo6Tvg9S/ZLc?=
 =?us-ascii?Q?uC2UNziVj4oG7v8M9vQJ7KiWxuBuBkVksDZwIdByVTE9cAvUP1CloE+sF4di?=
 =?us-ascii?Q?kfH3bsd/hSJx2ObrsECUiImpsVFNt0OwRQMA5tZ9vl88G0BImd68eFsEZTBQ?=
 =?us-ascii?Q?EicA/F2ITyhO6b0zFv4dRMBi6q1tDlsuzjplfYWnagsv1I0aOsVQuQgpqxPR?=
 =?us-ascii?Q?ddTyiTUoDu39EowgFJ+qm8FOPydDrI02migLManFSCoPRdKjKK3l402Zb/d2?=
 =?us-ascii?Q?0kgqxSt2htK1gXu6P9yFkCNfWlSrwYkndtetS2SzCTeK7S6uO31XXkli6Lqv?=
 =?us-ascii?Q?+Pn/jz9XDFLa4rJieMfwE389rXrmjeHuJB0qTyoqPSdlGv+5/zc1rKvZy6VU?=
 =?us-ascii?Q?/zAvng=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:20.79.220.33;CTRY:DE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:de1-emailsignatures-cloud.codetwo.com;PTR:de1-emailsignatures-cloud.codetwo.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(14060799003)(1800799024)(36860700013)(35042699022);DIR:OUT;SFP:1102;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1414
X-SEPP-CCCVersion: 2025-12-11T08:12:51+01:00 9ed91da2
X-MS-Exchange-SkipListedInternetSender:
 ip=[40.93.85.30];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-ExternalOriginalInternetSender:
 ip=[40.93.85.30];domain=ZRZP278CU001.outbound.protection.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	95b96aa4-69c4-4f0a-3450-08de5a6d093d
X-SM-ruleversion: 2.1.0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|156008|376014|82310400026|36860700013|1800799024|35042699022;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X8cCjDLy+zca3I6dPnAiIIqdx1S8aaSkTB6SBeDQdTy3DQt4zIh1Ge0UO9Am?=
 =?us-ascii?Q?Xhe7y1s1QSTgbxSzH5nfF4nmkSYIoT1e9M1soXY2l/dZq5vEIbZUBjXZfiUm?=
 =?us-ascii?Q?xumSvJiq0cYVZafg5XBTyQxmreqdnPMWTI9i8MxKMgfB1OVXUpv/HwlBWBCy?=
 =?us-ascii?Q?MsT3l8hGHWG1MP8LZBa4vyADgvlm5JR/1CYsbsgQUhZ6wiVUoTJWqg44qpHb?=
 =?us-ascii?Q?ru8fvnvH2Sk8wTTqDTQft+BtscCka4BdioUSwb8jnfXrxuYanPa5dw7xKBsZ?=
 =?us-ascii?Q?rhac/HWroKmL4HA1a9uoyof4fPNCqEVBmWUaWBbkM2sTZJUN+BcxWn9DeDrC?=
 =?us-ascii?Q?oxBlaN7Gj7j0740bR6ME1Y5YvX/t6bNtTg5V2I1YnHBUSHVsrOlcfNhQTi0z?=
 =?us-ascii?Q?wtx9qvaUhdsACFQBw3TxNAG7XwgvYOXat3Zn30nm4NolwIP1HAhencGWHBIf?=
 =?us-ascii?Q?RY/82S+cBHeY7/aQM1OWtwJlhOTuUN2CNDa6WQQ0PBrGdKCTSwfF1w+7zwZy?=
 =?us-ascii?Q?GgtRqKRjd/IBy/rY/99ZKhhTW/DUIPBHC5d2JPzVuHg4JewvMdW1HEXDIZOf?=
 =?us-ascii?Q?FXFsPdkOXtdARsV4fAkvK+8bjWG7Kd7yFD8SxbyURPEo6Hu7MKss3s2EQ3wa?=
 =?us-ascii?Q?aPT2UBjXA5nhhynRox3GR+aE8VLZ1TBMjlWCGAOmOmQdWiakVncTZj1H4lS+?=
 =?us-ascii?Q?zznwov2S9/kqtJUhhPi76CXwBpD8Clj37TqLYvDACaibeJv0AAsEj3DivC1+?=
 =?us-ascii?Q?Rrw8wjO8fmDZuFc7FGRufSWdck3FzqBDO3NqxMoxj+ByaCrrJAuOrASql0SF?=
 =?us-ascii?Q?xKshQrBeUfoape+EJPeTwGD+i1VIfE9VNdLHlCc8sMiIM65mixpGXhZiWh4/?=
 =?us-ascii?Q?Ux+X83UXKADoFfBn9649Kud95eA5JPiN6UW7HR7YRxLN7Q6BNUEvEJSU0Zhl?=
 =?us-ascii?Q?+yCD/7hkOoO6U3BE1/fe2wLuB4zfRJS7jP79PmALLn2uIrzE4OhWVMb1dnCH?=
 =?us-ascii?Q?8x+qEKZRqz0IPH3V9oQApCYxYHzv90UitvOvZCYEPuN2jtw3YgQfrUF/Inc7?=
 =?us-ascii?Q?PH9LqS8zMS1JEq+uQZAD0VpSg+xYrMxlAZNitavctA0IWH2txWUMdza5Ivbv?=
 =?us-ascii?Q?XXLp5Dy0iaG+?=
X-Forefront-Antispam-Report:
	CIP:162.55.72.219;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRZP278CU001.outbound.protection.outlook.com;PTR:mail-switzerlandnorthazlp17011030.outbound.protection.outlook.com;CAT:NONE;SFS:(13230040)(156008)(376014)(82310400026)(36860700013)(1800799024)(35042699022);DIR:OUT;SFP:1102;
X-OriginatorOrg: duagon.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jan 2026 10:50:12.2671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d2071c-98ba-4341-0c58-08de5a6d2f3a
X-MS-Exchange-CrossTenant-Id: e5e7e96e-8a28-45d6-9093-a40dd5b51a57
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5e7e96e-8a28-45d6-9093-a40dd5b51a57;Ip=[162.55.72.219];Helo=[hz-deliver01.de.seppmail.cloud]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000043.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB1364

Since commit 1f4ea4838b13 ("mcb: Add missing modpost build support")
the MODULE_ALIAS() is redundant as the module alias is now
automatically generated from the MODULE_DEVICE_TABLE().

Remove the explicit alias.

No functional change intended.

Reviewed-by: Jorge Sanjuan Garcia <dev-jorge.sanjuangarcia@duagon.com>
Signed-off-by: Jose Javier Rodriguez Barbarin <dev-josejavier.rodriguez@dua=
gon.com>
---
 drivers/iio/adc/men_z188_adc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/men_z188_adc.c b/drivers/iio/adc/men_z188_adc.=
c
index cf8a8c0412ec..90919d282e7b 100644
--- a/drivers/iio/adc/men_z188_adc.c
+++ b/drivers/iio/adc/men_z188_adc.c
@@ -171,5 +171,4 @@ module_mcb_driver(men_z188_driver);
 MODULE_AUTHOR("Johannes Thumshirn <johannes.thumshirn@men.de>");
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("IIO ADC driver for MEN 16z188 ADC Core");
-MODULE_ALIAS("mcb:16z188");
 MODULE_IMPORT_NS("MCB");
--=20
2.52.0
