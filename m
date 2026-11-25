Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626692;
	b=rpUWtwC3Ay1gC0weQITzPY9HzkJYP1awEsguVriw1vqGqwH74WjZgGP6bisHC00/UjGZ
	 I3oGPdS2FruY68J34B3lIUedjdzggsbhBDzbJCXgU47KgPLFEiaZpNzef3njkAVJQFJba
	 sBo/6c5pX0BpA/yNM+Ed7iIc5zdC1q29a4Ytq7/9qm44tpaEWFkLmmiiASeWUtcy2s9OS
	 ABwo+ts6jKV8npRY3qZLv9OSplNrmEkjxieduc6xI/rF+2KOUq3yHfDwF8mG8NZ4I0ZkT
	 HWDZJtLU5BFW1+1YTTVZeyMU+hjOe/O0sF1wkchHU1aXgpF2/9k7Jj7n4lvZLlMfQhg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626692;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Content-Type:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=k+VW7hr31Vn2AoUrmvJTQWI1qH8QIccr08ETgo5uK6Y=;
	b=nvKb3l7ZjTLaVdjs/gMdctbdSJoDqe75cJZ3sDu19zWWoT5FWFdjYwAnZbwiefqZ4609
	 tLQSnR3DkcI1DUUetx1M95QKsw7zVhOfkO0kF6ZS5AVx1BLl34a7VHb/cGZXp5pGZzlyI
	 ScaoTGovb8MqXdOZJUVdliC7U7TvlTduTkVoxD8EULgmnaE3M3jCNimwdh9jOjcr+4W0F
	 07NkH2sQGnHEZqTcyDMZWsWqXoY2jrWQd5JATv8Dan3g1cMcvux2V8Yt+LamBFKITVLoe
	 hC5m4YbPrNz+IV9nFYBHRSLQQZNLT49Dha5yNuTsiCoUsp2yfTreCnfcXbECPsVCHkQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qeIey3dA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.13
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8DC606A335;
	Wed, 25 Nov 2026 17:11:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA8DC606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=qeIey3dA
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u9K10FEqe1o/9vH+8fZccN965qohuRwZX1Pe0h0QzdZGTF/PZZ00u2LKcOG8uD7L/LUef1yz4QZl0JUeUG01UcF8D8bV8D89gKT+AHw5Yt5ff6sZOrHGdYyfkUnQyw59viBU8hAyPPde/lQ3f+MLubf77bhVGj0QqgUl8BqpZdckp5MJNTts0x4SSLrP/e9w4rA2ubmQQ6VyVDs4kfZnui3UxMx28NyGyV2oJsRvRz5CwGG0bgdp7bXHgJgpiAR3VlmBVn7dWdikjhgJ2f7c20WCk7urU7MgSaYCXHlaJ76IAEXrjg0U3W5jPyX49gbvJ46m9P8J3sbvKoSUdDbpzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+VW7hr31Vn2AoUrmvJTQWI1qH8QIccr08ETgo5uK6Y=;
 b=qkpf+orothmTFjgDhQeLWMYZjwE5H7bRRuscGAQnHvW2xkXgiAlB5FpCOhb7Fpq16g4vb+FkRUEmIQNB6oO+XO8Mro0CnXdmwej2skdvkpSXnYT1fDbvBzLBWlv1Rzc6OVuTygQPS70A0EvbTDyPDj0zOfccHk8sq9vbqNvrq5dRy35ZQtf+lo9YeCcSPnpbrjKU5fDfjQ2uM6cD8UVhylzHtI/4RA6J80JvJR18bPM9aBtW7j+adm2UGo3zQ5+ZCR962PPwvon+rkwx2braihcJhPtZw2uQ+msTekw3oatyWFptwNohU2wP9SjCFlnF5v3pcPDh4kYY19J1c6LZVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+VW7hr31Vn2AoUrmvJTQWI1qH8QIccr08ETgo5uK6Y=;
 b=qeIey3dAm/QzFouP4yDqRYxg6Rdzd2nDWQh/LdwpyzxEQHYFrwwHFTr+MI6+PgZJFUcbbVJk58HhjMIQtfVBaZkHUxCgozo3S1XTaZRlwl/0acuzp4wBhSFBcftEN0+SXMF7b53JlwUxaMm1VCfMqHvvER+4hWl+67wSFZQKKyY=
Received: from MW4P222CA0019.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::24)
 by IA1PR12MB6625.namprd12.prod.outlook.com (2603:10b6:208:3a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Wed, 25 Nov
 2026 17:11:25 +0000
Received: from BY1PEPF00026966.namprd05.prod.outlook.com
 (2603:10b6:303:114:cafe::3f) by MW4P222CA0019.outlook.office365.com
 (2603:10b6:303:114::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:11:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF00026966.mail.protection.outlook.com (10.167.244.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 17:11:24 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:20 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:11:17 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v6 06/16] iio: adc: xilinx-xadc: Use bitfield helpers and bit macros
Date: Wed, 25 Nov 2026 22:40:20 +0530
Message-ID: <20261125171045.1246381-7-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.44.4
In-Reply-To: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
References: <20261125171045.1246381-1-dileepkumar.nagavarapu@amd.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF00026966:EE_|IA1PR12MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c66a450-f13f-4f6d-e359-08df4b172294
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|261026140227099003|10067099003|261009223027099003|56012099006|11063799006|261021121427099003|261021123027099003|261102123227099003|261022105027099003|261028144727099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	vmPGb/jpnvoT28/mp82GG2mmbaIHj0atzcCGXju36S7dvWfoHEbO+g+h5p1Fibvu6QTRT8cJh0bMiE2uF4KRh9QPc9cSsDqa8w+MBkvsvShUMbb6Xzf93siLKXfsfQ1OzBTdtCma5jhr/VlMbZnW1PoYjV5PNzBDR5AOGmkSNt27lTF4qBXdTuSv5gzkGZxRkozXrrEE18DQYvcUXMyzkoqBbNSJ1CLSfx6crhGnnmO9X2Be/pamTpqN8khFCrx9kL7fqCd+V6s3bqhdz4Hvt4LtbQNcC5DsrC4jiKN0f3vweeqipIXtxQEHx5ZGQVy6Qv9OWOE/7xH5NpH9ERm8UOweFegwGkEpMr/KoYV+oSEgYlqajZCv+C+GJ9d7hbwXRn2Z7F67lNSKcETDVQfA66trO/zWE8re5RA6c+XiWVvo8Re1xB9Upb50dD74hIseZAztyAIGpsoNgSL/1kNIleu4ivx0g/hcllyld1VaQ5emE1/UvYHVSxtz0HRUJ+zYt0f4NhiFiyuHAgbugNUpEzF0kSoyKCTsWvQZDkbbspnVqMgFdqY5wcoq7K2+bOh2Ag7z0+MEjUnRLX2oBkVh94nT9BERP9sZlhwhOEgbZGcBsyfK2xKjNH4XK2rjC4b8tVG6z3WnusorayfbL2jIeR34c4QF+TN9r1FOSNLlyLBIfWX5bw8iGaSQArgD4TV5IFf69OaG04D2/jvjmmh9dg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(261026140227099003)(10067099003)(261009223027099003)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(261102123227099003)(261022105027099003)(261028144727099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Ex8eHS/0ayt8rA6R2OqfzjEpMYmRqRbbz7hXxbVfHXlm9Z2ScE4S4OYWuIJVSoEB7HZWjlksWwo3mlc5sVRyXq1IDLLM7cPqNLOchNTLrbi3hnNXvRSbRXT7UG31Y1plFHMHCHOg4ZwVmPac+WZef1dAmA4qCKA9bk5nJ5Gg5zDVxKbOdVLTs4rGZ8rUU23fDSJx3+JrStT7Kqnfhws9vBbYCQaKO7J49dmmMKCJtqQCsoYh5FGNBKOB/HUHGEb9XeHAx+hSzx2GabEnnhF9CjHFVA3K/9ZmVs+/FOEU+OQiDPUoswLoxMMCsEBYTRJN1uzAJs5IPwnkbFqJ5LB3JcJHIWDbiAjHnRSNOMnZgJbOmJStUAwENP+D9nzEWV52oRT+0Gfc7my3ZTPBF9KntUWhvQNMSy6mXOo+qvPFlkIWFMF9zZP4BbfBLO+roNPx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:24.5330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c66a450-f13f-4f6d-e359-08df4b172294
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF00026966.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6625

Replace open-coded bit manipulation with FIELD_GET(),
FIELD_PREP(), BIT(), and GENMASK() helpers.

Using the kernel bitfield helpers improves readability and
makes bit operations less error-prone.

No functional changes intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 59 ++++++++++++++++--------------
 drivers/iio/adc/xilinx-xadc.h      | 30 ++++++++-------
 2 files changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 3f9bf75d9067..929e8973f49f 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -11,6 +11,8 @@
  *  - AXI XADC interface: Xilinx PG019
  */
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -47,29 +49,23 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
 #define XADC_ZYNQ_REG_CTL		0x18
 
 #define XADC_ZYNQ_CFG_ENABLE		BIT(31)
-#define XADC_ZYNQ_CFG_CFIFOTH_MASK	(0xf << 20)
-#define XADC_ZYNQ_CFG_CFIFOTH_OFFSET	20
-#define XADC_ZYNQ_CFG_DFIFOTH_MASK	(0xf << 16)
-#define XADC_ZYNQ_CFG_DFIFOTH_OFFSET	16
+#define XADC_ZYNQ_CFG_CFIFOTH_MASK	GENMASK(23, 20)
+#define XADC_ZYNQ_CFG_DFIFOTH_MASK	GENMASK(19, 16)
 #define XADC_ZYNQ_CFG_WEDGE		BIT(13)
 #define XADC_ZYNQ_CFG_REDGE		BIT(12)
-#define XADC_ZYNQ_CFG_TCKRATE_MASK	(0x3 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV2	(0x0 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV4	(0x1 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV8	(0x2 << 8)
-#define XADC_ZYNQ_CFG_TCKRATE_DIV16	(0x3 << 8)
-#define XADC_ZYNQ_CFG_IGAP_MASK		0x1f
-#define XADC_ZYNQ_CFG_IGAP(x)		(x)
+#define XADC_ZYNQ_CFG_TCKRATE_MASK	GENMASK(9, 8)
+#define XADC_ZYNQ_CFG_TCKRATE_DIV2	0
+#define XADC_ZYNQ_CFG_TCKRATE_DIV4	1
+#define XADC_ZYNQ_CFG_TCKRATE_DIV8	2
+#define XADC_ZYNQ_CFG_TCKRATE_DIV16	3
+#define XADC_ZYNQ_CFG_IGAP_MASK		GENMASK(4, 0)
 
 #define XADC_ZYNQ_INT_CFIFO_LTH		BIT(9)
 #define XADC_ZYNQ_INT_DFIFO_GTH		BIT(8)
-#define XADC_ZYNQ_INT_ALARM_MASK	0xff
-#define XADC_ZYNQ_INT_ALARM_OFFSET	0
+#define XADC_ZYNQ_INT_ALARM_MASK	GENMASK(7, 0)
 
-#define XADC_ZYNQ_STATUS_CFIFO_LVL_MASK	(0xf << 16)
-#define XADC_ZYNQ_STATUS_CFIFO_LVL_OFFSET	16
-#define XADC_ZYNQ_STATUS_DFIFO_LVL_MASK	(0xf << 12)
-#define XADC_ZYNQ_STATUS_DFIFO_LVL_OFFSET	12
+#define XADC_ZYNQ_STATUS_CFIFO_LVL_MASK	GENMASK(19, 16)
+#define XADC_ZYNQ_STATUS_DFIFO_LVL_MASK	GENMASK(15, 12)
 #define XADC_ZYNQ_STATUS_CFIFOF		BIT(11)
 #define XADC_ZYNQ_STATUS_CFIFOE		BIT(10)
 #define XADC_ZYNQ_STATUS_DFIFOF		BIT(9)
@@ -105,7 +101,12 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
 #define XADC_AXI_GIER_ENABLE		BIT(31)
 
 #define XADC_AXI_INT_EOS		BIT(4)
-#define XADC_AXI_INT_ALARM_MASK		0x3c0f
+#define XADC_AXI_INT_ALARM_OT		BIT(0)
+#define XADC_AXI_INT_ALARM_TEMP_SUPPLY		GENMASK(3, 1)
+#define XADC_AXI_INT_ALARM_SUPPLY		GENMASK(13, 10)
+#define XADC_AXI_INT_ALARM_MASK		(XADC_AXI_INT_ALARM_SUPPLY | \
+					 XADC_AXI_INT_ALARM_TEMP_SUPPLY | \
+					 XADC_AXI_INT_ALARM_OT)
 
 #define XADC_FLAGS_BUFFERED BIT(0)
 #define XADC_FLAGS_IRQ_OPTIONAL BIT(1)
@@ -217,7 +218,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
 	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-	tmp |= 1 << XADC_ZYNQ_CFG_DFIFOTH_OFFSET;
+	tmp |= FIELD_PREP(XADC_ZYNQ_CFG_DFIFOTH_MASK, 1);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
 
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
@@ -376,7 +377,8 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE |
-		       XADC_ZYNQ_CFG_REDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
+		       XADC_ZYNQ_CFG_REDGE | FIELD_PREP(XADC_ZYNQ_CFG_TCKRATE_MASK, tck_div) |
+		       FIELD_PREP(XADC_ZYNQ_CFG_IGAP_MASK, igap));
 
 	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
 		ret = clk_set_rate(xadc->clk, pcap_rate);
@@ -394,7 +396,7 @@ static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
 
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &val);
 
-	switch (val & XADC_ZYNQ_CFG_TCKRATE_MASK) {
+	switch (FIELD_GET(XADC_ZYNQ_CFG_TCKRATE_MASK, val)) {
 	case XADC_ZYNQ_CFG_TCKRATE_DIV4:
 		div = 4;
 		break;
@@ -763,7 +765,8 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 		break;
 	}
 
-	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK, val);
+	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK,
+				   FIELD_PREP(XADC_CONF2_PD_MASK, val));
 }
 
 static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
@@ -810,7 +813,8 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK, seq_mode);
+	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
+				  FIELD_PREP(XADC_CONF1_SEQ_MASK, seq_mode));
 	if (ret)
 		return ret;
 
@@ -825,7 +829,7 @@ static int xadc_preenable(struct iio_dev *indio_dev)
 	int ret;
 
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-				  XADC_CONF1_SEQ_DEFAULT);
+				  FIELD_PREP(XADC_CONF1_SEQ_MASK, XADC_CONF1_SEQ_DEFAULT));
 	if (ret)
 		goto err;
 
@@ -854,7 +858,8 @@ static int xadc_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto err;
 
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK, seq_mode);
+	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
+				  FIELD_PREP(XADC_CONF1_SEQ_MASK, seq_mode));
 	if (ret)
 		goto err;
 
@@ -879,7 +884,7 @@ static int xadc_read_samplerate(struct xadc *xadc)
 	if (ret)
 		return ret;
 
-	div = (val16 & XADC_CONF2_DIV_MASK) >> XADC_CONF2_DIV_OFFSET;
+	div = FIELD_GET(XADC_CONF2_DIV_MASK, val16);
 	if (div < 2)
 		div = 2;
 
@@ -987,7 +992,7 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
 		div = 0xff;
 
 	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_DIV_MASK,
-				   div << XADC_CONF2_DIV_OFFSET);
+				   FIELD_PREP(XADC_CONF2_DIV_MASK, div));
 }
 
 static int xadc_write_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index fb911ed87600..087c5c0bb0b2 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -9,6 +9,7 @@
 #ifndef __IIO_XILINX_XADC__
 #define __IIO_XILINX_XADC__
 
+#include <linux/bits.h>
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
@@ -159,22 +160,23 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 #define XADC_CONF0_MUX			BIT(11)
 #define XADC_CONF0_CHAN(x)		(x)
 
-#define XADC_CONF1_SEQ_MASK		(0xf << 12)
-#define XADC_CONF1_SEQ_DEFAULT		(0 << 12)
-#define XADC_CONF1_SEQ_SINGLE_PASS	(1 << 12)
-#define XADC_CONF1_SEQ_CONTINUOUS	(2 << 12)
-#define XADC_CONF1_SEQ_SINGLE_CHANNEL	(3 << 12)
-#define XADC_CONF1_SEQ_SIMULTANEOUS	(4 << 12)
-#define XADC_CONF1_SEQ_INDEPENDENT	(8 << 12)
-#define XADC_CONF1_ALARM_MASK		0x0f0f
+#define XADC_CONF1_SEQ_MASK		GENMASK(15, 12)
+#define XADC_CONF1_SEQ_DEFAULT		0
+#define XADC_CONF1_SEQ_SINGLE_PASS	1
+#define XADC_CONF1_SEQ_CONTINUOUS	2
+#define XADC_CONF1_SEQ_SINGLE_CHANNEL	3
+#define XADC_CONF1_SEQ_SIMULTANEOUS	4
+#define XADC_CONF1_SEQ_INDEPENDENT	8
+#define XADC_CONF1_ALARM_LOW_MASK	GENMASK(3, 0)
+#define XADC_CONF1_ALARM_HIGH_MASK	GENMASK(11, 8)
+#define XADC_CONF1_ALARM_MASK		(XADC_CONF1_ALARM_HIGH_MASK | XADC_CONF1_ALARM_LOW_MASK)
 
-#define XADC_CONF2_DIV_MASK	0xff00
-#define XADC_CONF2_DIV_OFFSET	8
+#define XADC_CONF2_DIV_MASK	GENMASK(15, 8)
 
-#define XADC_CONF2_PD_MASK	(0x3 << 4)
-#define XADC_CONF2_PD_NONE	(0x0 << 4)
-#define XADC_CONF2_PD_ADC_B	(0x2 << 4)
-#define XADC_CONF2_PD_BOTH	(0x3 << 4)
+#define XADC_CONF2_PD_MASK	GENMASK(5, 4)
+#define XADC_CONF2_PD_NONE	0
+#define XADC_CONF2_PD_ADC_B	2
+#define XADC_CONF2_PD_BOTH	3
 
 #define XADC_ALARM_TEMP_MASK		BIT(0)
 #define XADC_ALARM_VCCINT_MASK		BIT(1)
-- 
2.34.1

