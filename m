Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010018.outbound.protection.outlook.com [52.101.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5898B367F21;
	Mon, 29 Jun 2026 14:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782742154; cv=fail; b=r37Ia2PVnoVlW+VuTG2YYwXZYGT59mtJWHL/tkw7kzKjgaXcrAvVb52edftoJkaf1SBSHWvFXFzESABKmG/PUyeQxWnakwFaM8oLTFog407YNZk8d5OpCiCuXFMwFMoxXDC0x2NlRmd33DIyc42gSupAxpDlt5fRLE2g+R+yz+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782742154; c=relaxed/simple;
	bh=wP6ncce1DIZJ3s0wveO8DIkv2IYV67+Gv82AEh/GKw8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q3iuck+w07ZNbLdMV0TZtF5z/PMkbtZaOBPrchDi7eEjI2vlcm8F0Jz4YhLa6AvCpM0mQ26Bb4dcP0y1yHkpvA6ZznHLSptdXMsCj1o8u1Nr1e5D2aJk54L9fqI1r1sxXmt9kDQDIniX0ZH0kBr81CzCQdh2LmvfAngpfI0qEK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=M6ACQlS2; arc=fail smtp.client-ip=52.101.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="M6ACQlS2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkvCVdGPpkJpsMgqo/tfg7rokEm0LS7h7fxJP2q88GuIydgQoSQshdfJbTX8QRLFAsFxPtLK9uvSl48hJHgzmfbwJYbCQsSNmWqvxdymB223Mh//fffBuF55vKUZweXO+jEdEZnZyB632gjPzhQFZyy3rbsrxjNOZDgU3vuu9ttQXST+P6akev68dIXWcm22yek6CG4fesONEb761fF0krL/hJ0+18YRepNTWMSCdif9fC5t1Fcvmg9s9UOQ6WpLlUoFz7Xs+mmNyc2XuPVObcg0wMX3zMvn30qZbvbHQfFvfp2Y35iKwuzIXxQp6RZjJxhBq2as1ZpGQvPmasHTlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zlUrAIE/gSYEJZY3h51uB7asRBP7fR/tcpNsL+SJA/k=;
 b=MLxD2QWwFvza5Zy0RCYaGsIeRFj9nUgCw7U+vDmmrCaJlDp4hz5v4JIDvH7oflG2QLZPE4NsUeGNOmyFZWi2JnhQnUEdJtGBjqy3Wt1j1cTUOUt0Wrn4o4lk7Os2DOg3QLkxbA3iPg6UawvE7ifc4Spwz61k+6TP/2P2LZ1mhyN5NXY75ShwTHaxG26zNSzieCJ4z33auXLLJ7XT4SBlFvLOmZL1AybsObHwWiCroTBJS0hHk6s3a81y6GTpJhHUEKa+K8w6Mh2ACYI8b39GwkwHYTSyT0bCiaW5NSztD4k1oKqUrfSQqe6xVI+3Ikrje+Q6A+5KBAuPhgxXJcD2vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlUrAIE/gSYEJZY3h51uB7asRBP7fR/tcpNsL+SJA/k=;
 b=M6ACQlS2avNFBlO38rbBRIq/Lpnq9A9cPlJuxA13tUbJ+20NQ8Mre1R9M+2cvVbOH54zb9EMva87ImYyFjL9w7/0srGUAdP3+AGxsqhT+E9NAZ+ZRsFc3020LvRX3Mt8S4CObDHbG+wRMuU4qyi2bI5VXNz3jOqvxBgAyPvOHVo=
Received: from MW4PR03CA0105.namprd03.prod.outlook.com (2603:10b6:303:b7::20)
 by DS4PR12MB9657.namprd12.prod.outlook.com (2603:10b6:8:27f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:09:09 +0000
Received: from CO1PEPF00012E84.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::3) by MW4PR03CA0105.outlook.office365.com
 (2603:10b6:303:b7::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 14:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF00012E84.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 14:09:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 09:09:03 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 09:06:22 -0500
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 29 Jun 2026 09:06:20 -0500
From: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To: Conall O'Griofa <conall.ogriofa@amd.com>, Jonathan Cameron
	<jic23@kernel.org>, <michal.simek@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v2] MAINTAINERS: Update Xilinx AMS driver maintainers
Date: Mon, 29 Jun 2026 19:36:15 +0530
Message-ID: <20260629140615.213750-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E84:EE_|DS4PR12MB9657:EE_
X-MS-Office365-Filtering-Correlation-Id: 85e445e5-ccbb-4268-0dfa-08ded5e7fcdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|23010399003|376014|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	dY2LEBTrJBFjsJ6qzFXQQgUpA420/gk+xV0OYcJ8O/DsTIQpRDWK5Ek83pO839wXOgboRZWI/Iv5StQuKeCZ7l3UMDzp/JF8THNYm7k4wQS3viA0jG1Gleb0WCVWNzZGtmFRydmCYWKSso/xXsbtOVaYsr+JpTU3Q2VGdnptrSHXN0pWcSGErbethkhLjWPA+QIYVhjUaZoduhQ2+mf5ydkKRLtnSK6qve+nysaOBIoJR5Vuz27JwY91CDe16d9oWIxDH+rAG/FPASM/XGbUqoYM1XwEAkiksfpMW6cq8Ype2mGcGEPqyxXORmDwhAHGQLBO9VRvPvvMvjKtYM5cwtbAyr5+IEL5NMAwubDFSuyTHf0BMonhmrSCDOtd0kj8ZV9UwWKv8wxWGvH7Tq0H+51RXsf7w0VKflJhPFz53muDSCtGgY2bp51Ab4gMlOqvNvtDgS+qIfisA+xrUC5yJFkZwNeXubrqglLj8qE9hIuVX+t7HhG4Engn71H8JYxuMOJijn1caT3a785uoYuDo05J+jdrJDTw4VOz+tipNnscGCXSoMSA9bU4zleQprqNb6NazFNZAUHhu4SAGvj1INyEddhk9St0i/VKRb7AJBGklr7PjhPW2cSRzSGWWOfUcXJnDqkAicJqH1UT4HQwyjsiHZL/F2Q92+Ps3O6SlOcny4g9kaT4omqpYHRMz0+lu8gCRs+vKgYH3YVvzSUSrQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(23010399003)(376014)(36860700016)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RpRGi54n935/AaJT24OHreCusDykdMZEe3R9ek7qMPKvDasBzRF9P9vQ0zQ89jDepCB9kEY+3MZSlBoRpR7wLEDWHBeMxMTJSuiyBezlJDRvrOynop9hDLE16qI4DyIgevfdmjw8j1rrEnXCXnc7wnt4nqa8lPTxhgjtsIxdUAfHv3lsNrT8cNM05GieAGn4WDLp3919CRV7oB7d6mka7BIXKjFGjlqGhA00z9bFW1eqUkMoL6U+Z7aC201PczCDavwU27RfZwmtWQxq56uVBnbxJFDCwmUCWsth0MgFSiuwZYudOvoxbMTph6krxwcj+FxoeAxftIxkWaeSWZh57MiFAWRqNX6l1cNHaYEUh1kH2VOLMjKhKwomfmtzpLl+RQWeEsfPhMfkru6jUJtmlYldv7P5FuHbKm3CYHY/yEXT88M6QJE86NUwsTZhJ/Ay
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:09:08.8532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e445e5-ccbb-4268-0dfa-08ded5e7fcdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E84.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9657

Salih Erim is no longer with AMD to maintain the Xilinx AMS driver.
Replace Salih Erim with Sai Krishna Potthuri in the Xilinx AMS driver
MAINTAINERS entry for continued development and maintenance of the driver.

Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
---
v2:
- Replaced Salih Erim with Sai Krishna Potthuri.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6b4560681b51..d8591066f182 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -29458,7 +29458,7 @@ F:	include/uapi/linux/dqblk_xfs.h
 F:	include/uapi/linux/fsmap.h
 
 XILINX AMS DRIVER
-M:	Salih Erim <salih.erim@amd.com>
+M:	Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
 M:	Conall O'Griofa <conall.ogriofa@amd.com>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
-- 
2.25.1

