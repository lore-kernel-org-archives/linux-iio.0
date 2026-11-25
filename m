Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626677;
	b=eVu6nF5WAWr+6gZpbeea9YbTa1E32NYYmOs7H7498D8+rFr+4ZyiGhjNop6/ml1FUv/n
	 rBzbKsDzM7o9uu5m4mKy9yuBf3mXwr34g2w+4XXULbQVAL+Sb11Y6rUFp39wm2KW9mw8H
	 xFBjdT2bJ/yVxHL1lkTzuOBWc/quBTyUWqAVrb7G4B8tF1CcJuarKIDaA3MQoiaU1oSEf
	 byoP4cz9ciO3B5J/6unHRDmbiqHsaICqAw6lEzWuCChrwCVGkkA5lhZiL+fGqJvl8SijA
	 pQ+Vd7mU0o0hW3Hpt65QT25HDifyeUzBd1PsUmjY42OqThqH7qYO0VmCWOXyz8ZJ1qQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626677;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 Content-Type:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=7iwozW1dDPpy33hvqt16KME+JA40Rqgdt3vdVAkfZ18=;
	b=aH0Gqsy+j2A5j2Z34W4mQPj6/fakYqRLkHgFVLaOmxVLsTgUkVeCCNMstgSwlsIuzrnP
	 HLS8+OwHrM3wYPfXh6gPINiC2f1Hx9S9l7W4F78ewHtZpogd78G8R7eMavC5Ye4ttDz99
	 lGBMjJV8ozv5VNqI8pPFwqOrJ2LmvpThUFgIklc4tw3MiTOQQBEiqPN0UprtLjisQxpE1
	 rrp8OM3aBzUULfwf9mtyuJQuzsllQ9AK8aCsT6v20ROtPR6onZhvMYqKjhXKesYQMn/I+
	 0aI3LQE/82PvYGOnmH89TlUZqc+Ue76HIlWBlcXDmLZrQJUQq9tUfyyDt/kxPFtpK2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pOjjL8Xe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.44
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010044.outbound.protection.outlook.com [52.101.201.44])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDB5606A32C;
	Wed, 25 Nov 2026 17:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DDB5606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=pOjjL8Xe
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a3c7SdCqpigYv9Vctja9WixrSGxMepSt1FfF5RbbZqhSEOky/SSdAZzAqtRPV7rnIxH6Q6+AnYd853Z6OnI2tfbrDW+RbjbsScaC/As/RI2Kb5sC1+iCV7W52wplRImG9Y0C9lqaXqI0+9+pZfZD0jvSRJYSXyx37Eu3Kms3iAJXTCiLGT4BO230t4TJmPCGTJYKACt4EWqq0xRhan48blyozf+47gEz/RosZfqKiR5+ZNkq3qjIyei167XxOP41WSRLxzzWqnOPMMs7MNkNB189rMuct54mBpObScRCjr0K6smZdWKJMl/2v5KAZvd9Zh3k82yq5zgOG+nN8MGSOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iwozW1dDPpy33hvqt16KME+JA40Rqgdt3vdVAkfZ18=;
 b=GEvL/lcwHBhffpofYjWwG37JuqyBujlMCflRz09nWYzmHbWXDpj+Z7WVjjpEWKJKK96B/JjLK+JeHQrIb1a6Z6fv2QEnzwsQg4i1o3cuwwCQkQNVVmmH+0XmX2qqTVtTgy4S6HZVy+yTcXJzw8FO6ttO+p8uifGEawvZGR07OrHj3MIhpHWqWiKq8YbJdS7sDteFAdymOu0TQ4gHeqW2c3lLKOctFEcAf25y3nP2GuznMOhUObPMlDVxZ5Cr3z/TaHCqthJ3jJ+6ud5LKdJJxw2yBN2RefZQ0GOMNIsZeHFdNJcNd3Dj1F9JkWKVx+BWrH6kPH1TauHz4FbqDX7ZLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iwozW1dDPpy33hvqt16KME+JA40Rqgdt3vdVAkfZ18=;
 b=pOjjL8XeydkKmk1gOswbwBmOjfVtg/SNFwChzeA/qVTt7RrqvsQ/lSxt1VB3vumm3/IdiPmvO+3Uvvb16oguplMiM6SObkjtFWozJvawc7yFXIg5HYFDnzj+MmNbwq+tYHZiPohGXTyzNjeXWmKdGilJ2WyphCWU8svXLB7Aypw=
Received: from CH2PR08CA0020.namprd08.prod.outlook.com (2603:10b6:610:5a::30)
 by IA4PR12MB9787.namprd12.prod.outlook.com (2603:10b6:208:54d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Wed, 25 Nov
 2026 17:11:11 +0000
Received: from BN3PEPF0000B36E.namprd21.prod.outlook.com
 (2603:10b6:610:5a:cafe::5a) by CH2PR08CA0020.outlook.office365.com
 (2603:10b6:610:5a::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 25
 Nov 2026 17:11:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B36E.mail.protection.outlook.com (10.167.243.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Wed, 25 Nov 2026 17:11:11 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:10 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:09 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:11:05 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>, Joshua Crofts <crofts@kernel.org>
Subject: [PATCH v6 03/16] iio: adc: xilinx-xadc: Fix coding style issues
Date: Wed, 25 Nov 2026 22:40:17 +0530
Message-ID: <20261125171045.1246381-4-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36E:EE_|IA4PR12MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e2e9abe-d8bd-4257-6096-08df4b171aa3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|261022075727099003|10067099003|56012099006|11063799006|261021121427099003|261102123227099003|261009223027099003|261026121527099003|261026140227099003|261022113327099003|261022105027099003|261021123027099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	X3SceumUCkhQEPh6v9kiZ5P9IN0pMcFUMTTEbBTLb358xrZ7g61DUgioVP11zdY1bBqbhi92d9oRLAcYrYOMw9gFdXNAVquImnUpWWmoH0xfe8ytB5t7w/zY8dlw1Gc9g5rhjn61LUa2ViVYcP8kszm5dl3zwlt/gtsynUU+ZykrCGMsoMpzdyy50OtiSIIneywX3X8csvkUD8xmgX+phCPQDiY0WuKcMbh1xo+4xTgg/sTOS/GY/uhYJMiawlwGtc6BEfVarUsKbr3rRZPSj84Vduj0OlTHCqVxwBaN5mcPmBX4fJJ17QnlkuN/RKk45iqhzEHVJSYjFu8TVwpUSTqNcgzYcyFJ2XHrdUQMwJFjoPzmNFhtiliMPVBiFzB+J7z7bqXA2Bhv+5ODNRxqczX7QrIOxpz8/tCxyX1+P3WJvCNhifaiVxifrLGPahitJ3t3aRSMUBB6gVOFuGm8MnGV4wFUIAbUgl3k91AYg+SvgJHFhAWoiBir8KD7KDv6+G3umPtKxQuMUIyb98wAaJFWnX6BAAknAeXiRD6+leTvz/mA2TIH/MuuWw+Z0pgAPfnPYf9McQsSNUv9x2RS/oFt1jIA+2upsZPnvkl8H0HpAYnGn9kR+RZbWfHkdFd1/z3nxl0d9fA/JLwniqNOQwtBWwBmxvKCmlSBVqHWIfEmM6X16fq8AL+8wl4RCEr0t5d0wqVLqIxuOTeL9yD1og==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(261022075727099003)(10067099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261009223027099003)(261026121527099003)(261026140227099003)(261022113327099003)(261022105027099003)(261021123027099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	rVRPzDMFtfwllIuyBB4F9UBjqfoC+Yeui2zjG1icKgHgSLKbw/y6awitGi6QUhLY8FBQuzxhhVPglor5msLpozHgn1XkBVOpo9/nPj8v1hsJSaZX8Vz2lUIJp3cA3jiaCZtYO8yzwjvOy8YamFAywP56SqBYyNSOSg0cy10gYuvRrLTXChGnPmpnGtRyR9RvVsLEBtHyll6V34D1e/Xrc3lfKqvaN6iUML6F69QrVugQc/0HvCEJaVktgi79QlmwAzleizg1Hqb7i4wBbmqVX4jBYpYIV1M9SDsOKla+vBZAuWSDNsF/xIheG2WrGZUbQ8Vo/dEgX+VQo3rXLvvfVmCHwtRZJ99ZO9B90kpf11aZO1d/DoG8KWflPC70f5D1hyNIsin+rPbpkfruA4PD+r1fD65tFikfp0WqNrjCYoe3snKawuupw2h04SX1LEjg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:11.2725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e2e9abe-d8bd-4257-6096-08df4b171aa3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9787

Address checkpatch.pl warnings in the XADC driver:
- function prototypes/definitions split across lines that now
  fit within the line length limit
- Realign remaining multi-line statements to the opening parenthesis
- Add a missing space around a binary operator
- Fix pointer/const spacing ("*const" vs "* const")
- Adjust blank lines around a few statements
- Reorder the local declarations (size_t n and void *data) in
  xadc_update_scan_mode(), the only token-order change
  (not a checkpatch warning)

No functional changes intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Reviewed-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/adc/xilinx-xadc-core.c   | 143 ++++++++++-----------------
 drivers/iio/adc/xilinx-xadc-events.c |  50 +++++-----
 drivers/iio/adc/xilinx-xadc.h        |  40 +++-----
 3 files changed, 90 insertions(+), 143 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 55cb75d4239b..9b9a1e440af1 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -119,14 +119,12 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
  */
 #define XADC_MAX_SAMPLERATE 150000
 
-static void xadc_write_reg(struct xadc *xadc, unsigned int reg,
-	uint32_t val)
+static void xadc_write_reg(struct xadc *xadc, unsigned int reg, uint32_t val)
 {
 	writel(val, xadc->base + reg);
 }
 
-static void xadc_read_reg(struct xadc *xadc, unsigned int reg,
-	uint32_t *val)
+static void xadc_read_reg(struct xadc *xadc, unsigned int reg, uint32_t *val)
 {
 	*val = readl(xadc->base + reg);
 }
@@ -140,9 +138,7 @@ static void xadc_read_reg(struct xadc *xadc, unsigned int reg,
  * sleep and wait for an interrupt that signals that a response is available in
  * the data FIFO.
  */
-
-static void xadc_zynq_write_fifo(struct xadc *xadc, uint32_t *cmd,
-	unsigned int n)
+static void xadc_zynq_write_fifo(struct xadc *xadc, uint32_t *cmd, unsigned int n)
 {
 	unsigned int i;
 
@@ -162,26 +158,22 @@ static void xadc_zynq_drain_fifo(struct xadc *xadc)
 	}
 }
 
-static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask,
-	unsigned int val)
+static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask, unsigned int val)
 {
 	xadc->zynq_intmask &= ~mask;
 	xadc->zynq_intmask |= val;
 
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK,
-		xadc->zynq_intmask | xadc->zynq_masked_alarm);
+	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask | xadc->zynq_masked_alarm);
 }
 
-static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t val)
+static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
 {
 	uint32_t cmd[1];
 	uint32_t tmp;
 	int ret;
 
 	spin_lock_irq(&xadc->lock);
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
-			XADC_ZYNQ_INT_DFIFO_GTH);
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
 
 	reinit_completion(&xadc->completion);
 
@@ -208,8 +200,7 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg,
 	return 0;
 }
 
-static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t *val)
+static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
 {
 	uint32_t cmd[2];
 	uint32_t resp, tmp;
@@ -219,8 +210,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
 	cmd[1] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_NOP, 0, 0);
 
 	spin_lock_irq(&xadc->lock);
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
-			XADC_ZYNQ_INT_DFIFO_GTH);
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
 	xadc_zynq_drain_fifo(xadc);
 	reinit_completion(&xadc->completion);
 
@@ -249,9 +239,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
 
 static unsigned int xadc_zynq_transform_alarm(unsigned int alarm)
 {
-	return ((alarm & 0x80) >> 4) |
-		((alarm & 0x78) << 1) |
-		(alarm & 0x07);
+	return ((alarm & 0x80) >> 4) | ((alarm & 0x78) << 1) | (alarm & 0x07);
 }
 
 /*
@@ -290,9 +278,8 @@ static void xadc_zynq_unmask_worker(struct work_struct *work)
 	/* if still pending some alarm re-trigger the timer */
 	if (xadc->zynq_masked_alarm) {
 		schedule_delayed_work(&xadc->zynq_unmask_work,
-				msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
+				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
 	}
-
 }
 
 static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
@@ -313,8 +300,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status);
 
 	if (status & XADC_ZYNQ_INT_DFIFO_GTH) {
-		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
-			XADC_ZYNQ_INT_DFIFO_GTH);
+		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
 		complete(&xadc->completion);
 	}
 
@@ -327,12 +313,11 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 		 */
 		xadc_zynq_update_intmsk(xadc, 0, 0);
 
-		xadc_handle_events(indio_dev,
-				xadc_zynq_transform_alarm(status));
+		xadc_handle_events(indio_dev, xadc_zynq_transform_alarm(status));
 
 		/* unmask the required interrupts in timer. */
 		schedule_delayed_work(&xadc->zynq_unmask_work,
-				msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
+				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
 	}
 	spin_unlock(&xadc->lock);
 
@@ -343,8 +328,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 #define XADC_ZYNQ_IGAP_DEFAULT 20
 #define XADC_ZYNQ_PCAP_RATE_MAX 200000000
 
-static int xadc_zynq_setup(struct platform_device *pdev,
-	struct iio_dev *indio_dev, int irq)
+static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned long pcap_rate;
@@ -365,8 +349,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 		return -EINVAL;
 
 	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
-		ret = clk_set_rate(xadc->clk,
-				   (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
+		ret = clk_set_rate(xadc->clk, (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
 		if (ret)
 			return ret;
 	}
@@ -393,7 +376,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE |
-			XADC_ZYNQ_CFG_REDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
+		       XADC_ZYNQ_CFG_REDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
 
 	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
 		ret = clk_set_rate(xadc->clk, pcap_rate);
@@ -443,8 +426,7 @@ static void xadc_zynq_update_alarm(struct xadc *xadc, unsigned int alarm)
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status & alarm);
 
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK,
-		~alarm & XADC_ZYNQ_INT_ALARM_MASK);
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK, ~alarm & XADC_ZYNQ_INT_ALARM_MASK);
 
 	spin_unlock_irqrestore(&xadc->lock, flags);
 }
@@ -467,29 +449,24 @@ static const unsigned int xadc_axi_reg_offsets[] = {
 	[XADC_TYPE_US] = XADC_US_AXI_ADC_REG_OFFSET,
 };
 
-static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t *val)
+static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
 {
 	uint32_t val32;
 
-	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4,
-		&val32);
+	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, &val32);
 	*val = val32 & 0xffff;
 
 	return 0;
 }
 
-static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t val)
+static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
 {
-	xadc_write_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4,
-		val);
+	xadc_write_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, val);
 
 	return 0;
 }
 
-static int xadc_axi_setup(struct platform_device *pdev,
-	struct iio_dev *indio_dev, int irq)
+static int xadc_axi_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 
@@ -545,8 +522,7 @@ static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
 	 * passed the alarm mask in the same order as in the XADC alarm enable
 	 * register.
 	 */
-	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) |
-			((alarm & 0xf0) << 6);
+	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) | ((alarm & 0xf0) << 6);
 
 	spin_lock_irqsave(&xadc->lock, flags);
 	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
@@ -592,8 +568,7 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.temp_offset = 280231,
 };
 
-static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t mask, uint16_t val)
+static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t mask, uint16_t val)
 {
 	uint16_t tmp;
 	int ret;
@@ -605,8 +580,7 @@ static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
 	return _xadc_write_adc_reg(xadc, reg, (tmp & ~mask) | val);
 }
 
-static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t mask, uint16_t val)
+static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t mask, uint16_t val)
 {
 	int ret;
 
@@ -622,17 +596,16 @@ static unsigned long xadc_get_dclk_rate(struct xadc *xadc)
 	return xadc->ops->get_dclk_rate(xadc);
 }
 
-static int xadc_update_scan_mode(struct iio_dev *indio_dev,
-	const unsigned long *mask)
+static int xadc_update_scan_mode(struct iio_dev *indio_dev, const unsigned long *mask)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
-	size_t n;
 	void *data;
+	size_t n;
 
 	n = bitmap_weight(mask, iio_get_masklength(indio_dev));
 
-	data = devm_krealloc_array(indio_dev->dev.parent, xadc->data,
-				   n, sizeof(*xadc->data), GFP_KERNEL);
+	data = devm_krealloc_array(indio_dev->dev.parent, xadc->data, n,
+				   sizeof(*xadc->data), GFP_KERNEL);
 	if (!data)
 		return -ENOMEM;
 
@@ -718,8 +691,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 			else
 				convst = 0;
 		}
-		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC,
-					convst);
+		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC, convst);
 		if (ret)
 			goto err_out;
 	} else {
@@ -746,8 +718,7 @@ static const struct iio_trigger_ops xadc_trigger_ops = {
 	.set_trigger_state = &xadc_trigger_set_state,
 };
 
-static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
-	const char *name)
+static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev, const char *name)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_trigger *trig;
@@ -792,8 +763,7 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 		break;
 	}
 
-	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK,
-		val);
+	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK, val);
 }
 
 static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
@@ -807,8 +777,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
 	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
 		return XADC_CONF1_SEQ_SIMULTANEOUS;
 
-	if ((aux_scan_mode & 0xff00) == 0 ||
-		(aux_scan_mode & 0x00ff) == 0)
+	if ((aux_scan_mode & 0xff00) == 0 || (aux_scan_mode & 0x00ff) == 0)
 		return XADC_CONF1_SEQ_CONTINUOUS;
 
 	return XADC_CONF1_SEQ_SIMULTANEOUS;
@@ -841,8 +810,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-				  seq_mode);
+	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK, seq_mode);
 	if (ret)
 		return ret;
 
@@ -857,7 +825,7 @@ static int xadc_preenable(struct iio_dev *indio_dev)
 	int ret;
 
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-		XADC_CONF1_SEQ_DEFAULT);
+				  XADC_CONF1_SEQ_DEFAULT);
 	if (ret)
 		goto err;
 
@@ -886,8 +854,7 @@ static int xadc_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto err;
 
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-		seq_mode);
+	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK, seq_mode);
 	if (ret)
 		goto err;
 
@@ -920,7 +887,7 @@ static int xadc_read_samplerate(struct xadc *xadc)
 }
 
 static int xadc_read_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int *val, int *val2, long info)
+			 struct iio_chan_spec const *chan, int *val, int *val2, long info)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned int bits = chan->scan_type.realbits;
@@ -1020,11 +987,11 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
 		div = 0xff;
 
 	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_DIV_MASK,
-		div << XADC_CONF2_DIV_OFFSET);
+				   div << XADC_CONF2_DIV_OFFSET);
 }
 
 static int xadc_write_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int val, int val2, long info)
+			  struct iio_chan_spec const *chan, int val, int val2, long info)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 
@@ -1038,9 +1005,8 @@ static const struct iio_event_spec xadc_temp_events[] = {
 	{
 		.type = IIO_EV_TYPE_THRESH,
 		.dir = IIO_EV_DIR_RISING,
-		.mask_separate = BIT(IIO_EV_INFO_ENABLE) |
-				BIT(IIO_EV_INFO_VALUE) |
-				BIT(IIO_EV_INFO_HYSTERESIS),
+		.mask_separate = BIT(IIO_EV_INFO_ENABLE) | BIT(IIO_EV_INFO_VALUE) |
+				 BIT(IIO_EV_INFO_HYSTERESIS),
 	},
 };
 
@@ -1296,9 +1262,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 	}
 
 	indio_dev->num_channels = num_channels;
-	indio_dev->channels = devm_krealloc_array(dev, channels,
-						  num_channels, sizeof(*channels),
-						  GFP_KERNEL);
+	indio_dev->channels = devm_krealloc_array(dev, channels, num_channels,
+						  sizeof(*channels), GFP_KERNEL);
 	/* If we can't resize the channels array, just use the original */
 	if (!indio_dev->channels)
 		indio_dev->channels = channels;
@@ -1306,7 +1271,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 	return 0;
 }
 
-static const char * const xadc_type_names[] = {
+static const char *const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
 	[XADC_TYPE_US] = "xilinx-system-monitor",
 };
@@ -1335,8 +1300,7 @@ static int xadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	irq = platform_get_irq_optional(pdev, 0);
-	if (irq < 0 &&
-	    (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
+	if (irq < 0 && (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
 		return irq;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
@@ -1363,10 +1327,8 @@ static int xadc_probe(struct platform_device *pdev)
 		return ret;
 
 	if (xadc->ops->flags & XADC_FLAGS_BUFFERED) {
-		ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
-						      &iio_pollfunc_store_time,
-						      &xadc_trigger_handler,
-						      &xadc_buffer_ops);
+		ret = devm_iio_triggered_buffer_setup(dev, indio_dev, &iio_pollfunc_store_time,
+						      &xadc_trigger_handler, &xadc_buffer_ops);
 		if (ret)
 			return ret;
 
@@ -1375,8 +1337,7 @@ static int xadc_probe(struct platform_device *pdev)
 			if (IS_ERR(xadc->convst_trigger))
 				return PTR_ERR(xadc->convst_trigger);
 
-			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
-				"samplerate");
+			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev, "samplerate");
 			if (IS_ERR(xadc->samplerate_trigger))
 				return PTR_ERR(xadc->samplerate_trigger);
 		}
@@ -1420,8 +1381,7 @@ static int xadc_probe(struct platform_device *pdev)
 		return ret;
 
 	for (i = 0; i < 16; i++)
-		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
-			&xadc->threshold[i]);
+		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i), &xadc->threshold[i]);
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
 	if (ret)
@@ -1437,8 +1397,7 @@ static int xadc_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1),
-		bipolar_mask >> 16);
+	ret = xadc_write_adc_reg(xadc, XADC_REG_INPUT_MODE(1), bipolar_mask >> 16);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index c188d3dcab48..f92776cd90c0 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -12,8 +12,8 @@
 
 #include "xilinx-xadc.h"
 
-static const struct iio_chan_spec *xadc_event_to_channel(
-	struct iio_dev *indio_dev, unsigned int event)
+static const struct iio_chan_spec *xadc_event_to_channel(struct iio_dev *indio_dev,
+							 unsigned int event)
 {
 	switch (event) {
 	case XADC_THRESHOLD_OT_MAX:
@@ -23,7 +23,7 @@ static const struct iio_chan_spec *xadc_event_to_channel(
 	case XADC_THRESHOLD_VCCAUX_MAX:
 		return &indio_dev->channels[event];
 	default:
-		return &indio_dev->channels[event-1];
+		return &indio_dev->channels[event - 1];
 	}
 }
 
@@ -43,9 +43,10 @@ static void xadc_handle_event(struct iio_dev *indio_dev, unsigned int event)
 		 * events.
 		 */
 		iio_push_event(indio_dev,
-			IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
-				IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING),
-			iio_get_time_ns(indio_dev));
+			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_RISING),
+			       iio_get_time_ns(indio_dev));
 	} else {
 		/*
 		 * For other channels we don't know whether it is a upper or
@@ -53,9 +54,10 @@ static void xadc_handle_event(struct iio_dev *indio_dev, unsigned int event)
 		 * channel value if it wants to know.
 		 */
 		iio_push_event(indio_dev,
-			IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
-				IIO_EV_TYPE_THRESH, IIO_EV_DIR_EITHER),
-			iio_get_time_ns(indio_dev));
+			       IIO_UNMOD_EVENT_CODE(chan->type, chan->channel,
+						    IIO_EV_TYPE_THRESH,
+						    IIO_EV_DIR_EITHER),
+			       iio_get_time_ns(indio_dev));
 	}
 }
 
@@ -68,7 +70,7 @@ void xadc_handle_events(struct iio_dev *indio_dev, unsigned long events)
 }
 
 static unsigned int xadc_get_threshold_offset(const struct iio_chan_spec *chan,
-	enum iio_event_direction dir)
+					      enum iio_event_direction dir)
 {
 	unsigned int offset;
 
@@ -110,18 +112,16 @@ static unsigned int xadc_get_alarm_mask(const struct iio_chan_spec *chan)
 	}
 }
 
-int xadc_read_event_config(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir)
+int xadc_read_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			   enum iio_event_type type, enum iio_event_direction dir)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 
 	return (bool)(xadc->alarm_mask & xadc_get_alarm_mask(chan));
 }
 
-int xadc_write_event_config(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, bool state)
+int xadc_write_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			    enum iio_event_type type, enum iio_event_direction dir, bool state)
 {
 	unsigned int alarm = xadc_get_alarm_mask(chan);
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -155,10 +155,9 @@ int xadc_write_event_config(struct iio_dev *indio_dev,
 	return ret;
 }
 
-int xadc_read_event_value(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, enum iio_event_info info,
-	int *val, int *val2)
+int xadc_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			  enum iio_event_type type, enum iio_event_direction dir,
+			  enum iio_event_info info, int *val, int *val2)
 {
 	unsigned int offset = xadc_get_threshold_offset(chan, dir);
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -180,10 +179,9 @@ int xadc_read_event_value(struct iio_dev *indio_dev,
 	return IIO_VAL_INT;
 }
 
-int xadc_write_event_value(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, enum iio_event_info info,
-	int val, int val2)
+int xadc_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			   enum iio_event_type type, enum iio_event_direction dir,
+			   enum iio_event_info info, int val, int val2)
 {
 	unsigned int offset = xadc_get_threshold_offset(chan, dir);
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -227,9 +225,9 @@ int xadc_write_event_value(struct iio_dev *indio_dev,
 			xadc->threshold[offset + 4] = 0;
 		else
 			xadc->threshold[offset + 4] = xadc->threshold[offset] -
-					xadc->temp_hysteresis;
+				xadc->temp_hysteresis;
 		ret = _xadc_write_adc_reg(xadc, XADC_REG_THRESHOLD(offset + 4),
-			xadc->threshold[offset + 4]);
+					  xadc->threshold[offset + 4]);
 		if (ret)
 			goto out_unlock;
 	}
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index b4d9d4683117..b36510450982 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -19,21 +19,16 @@ struct xadc_ops;
 struct platform_device;
 
 void xadc_handle_events(struct iio_dev *indio_dev, unsigned long events);
-
-int xadc_read_event_config(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir);
-int xadc_write_event_config(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, bool state);
-int xadc_read_event_value(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, enum iio_event_info info,
-	int *val, int *val2);
-int xadc_write_event_value(struct iio_dev *indio_dev,
-	const struct iio_chan_spec *chan, enum iio_event_type type,
-	enum iio_event_direction dir, enum iio_event_info info,
-	int val, int val2);
+int xadc_read_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			   enum iio_event_type type, enum iio_event_direction dir);
+int xadc_write_event_config(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			    enum iio_event_type type, enum iio_event_direction dir, bool state);
+int xadc_read_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			  enum iio_event_type type, enum iio_event_direction dir,
+			  enum iio_event_info info, int *val, int *val2);
+int xadc_write_event_value(struct iio_dev *indio_dev, const struct iio_chan_spec *chan,
+			   enum iio_event_type type, enum iio_event_direction dir,
+			   enum iio_event_info info, int val, int val2);
 
 enum xadc_external_mux_mode {
 	XADC_EXTERNAL_MUX_NONE,
@@ -77,8 +72,7 @@ enum xadc_type {
 struct xadc_ops {
 	int (*read)(struct xadc *xadc, unsigned int reg, uint16_t *val);
 	int (*write)(struct xadc *xadc, unsigned int reg, uint16_t val);
-	int (*setup)(struct platform_device *pdev, struct iio_dev *indio_dev,
-			int irq);
+	int (*setup)(struct platform_device *pdev, struct iio_dev *indio_dev, int irq);
 	void (*update_alarm)(struct xadc *xadc, unsigned int alarm);
 	unsigned long (*get_dclk_rate)(struct xadc *xadc);
 	irqreturn_t (*interrupt_handler)(int irq, void *devid);
@@ -89,22 +83,19 @@ struct xadc_ops {
 	int temp_offset;
 };
 
-static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t *val)
+static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
 {
 	lockdep_assert_held(&xadc->mutex);
 	return xadc->ops->read(xadc, reg, val);
 }
 
-static inline int _xadc_write_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t val)
+static inline int _xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
 {
 	lockdep_assert_held(&xadc->mutex);
 	return xadc->ops->write(xadc, reg, val);
 }
 
-static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t *val)
+static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
 {
 	int ret;
 
@@ -114,8 +105,7 @@ static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg,
 	return ret;
 }
 
-static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t val)
+static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
 {
 	int ret;
 
-- 
2.34.1

