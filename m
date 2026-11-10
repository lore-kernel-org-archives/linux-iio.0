Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.12
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287349;
	b=xwi4YoWI/bg4b0UoNpdDvZZjgwgm7V1yimKB6SS9nO13zeGs3qtsMu8yGTKxL38EuO8w
	 GBsaZFbL1YL7aZgkwLzPyyPJavamXNT+S0oio+34UufjcSdj1YxQ/euyGy/t3i+Eon5Gu
	 gEOLdSA9baxmmA6JIE5E/qqD52De/VEOugs4OTyN3an/5cILxd7Wk5xjZL8bc2LDme6vZ
	 Xx6wJy1/cKbu2ba/cCAX3YJuXFvWdCjjedB3K6OPEJCGQ91wj8p6HxOv4DgCwMMzmf4ew
	 sOJ0Jn8XWHF0dRoXsSsHAjP5Z4FKZKxgCO49IfTH9wrtgQIjmY82nbTB/S7pIozrqKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287349;
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
	bh=HBIzyYfWaWfrxhyqqo6fxxsGZAcxkOjXNSkU/+9k1vw=;
	b=1rBMu1SVtR1X4hhKA9wUmQGHVDTHhWKnXcnID8mB3uzhM/2qUQW5QvUFhD/OOAaQ6gCD
	 HOa0dX8b9nLP7mZDTM4MXsHZiUicSnBP7jYfwKs7ssYcqpavc013GfvOseYx/eBuXkpJQ
	 MgQXvRMABX7Is7Lkpkuaf3in1t1RV802pcwvl8WrQ9Dsi3DNlwx3vhoB/k2x18Zb9Lr0f
	 9ydwibHKCxP9eZl0E0rkCzTowWIn5Ybk3jeCBab1zwWk2l5MRljujJudxDP6crZ6t5D/F
	 mOR2PdQmFqb83lQM7to0U7evXe9ZH+RkYhblPm4BTfllIQw0vGz1DvLfw0BBxhQPsew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rFBSQVyj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.201.12
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010012.outbound.protection.outlook.com [52.101.201.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE5860A2611;
	Tue, 10 Nov 2026 05:09:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AE5860A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=rFBSQVyj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hI5Md4v/NQj/oauqIuvg2zNc4b6ZrCwGGDsdFl37IwsTDbuH6QnAqFe+7M+wwHhp4ivEe0yFoXYEhhR6z7DNHTAghnblHQxKm+grWHhRp6UXmS4aipm/zGl6R/W5D5g6S/XVimliK094Qn6krKzUF1vj67v44/nohPJI9kCX5xujm9NBb7YO1ezp3ar1ZtANpiVbmEGLX9G0FnWFPOywQW9B0Mf+PAYtSwz3s2HGBjwZd2vKUUl/EeKKxCg20aLRw/v2pEtZXFOjKPYDEqxJ2KceRdJgaCn3Enc3iW8kMQFsVZPNa331h4ZLektl2iWxyCGsK7HbZ6i7amlN2rhItw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HBIzyYfWaWfrxhyqqo6fxxsGZAcxkOjXNSkU/+9k1vw=;
 b=FrI4PcN7bvd2tlf+kTwb4nRVYdUkE+B7Sn92FauHbGpR27hlMxnus437UEaEazIaiZEqIms+yBEm2Bx2NCX9cctG7TwAR3o0yd2ahUEVYatfAgrl9wjJCleoJQpPcJfG5F2uXnFD/jhkIzrSQphYUyx2Gd7Nnd7a6KMBeGB8erP3JxndOAWSIgCmeCeFK6slgp0lDUiqHVXGsvWM7fHMfXitFtoq+HzTJyASLQtxhNZ1LXwK3ygfYwS+49RbtpgNyiBF5IcMzJklD8bmZ+InV51BVVh9e72Y36yF81+YeupQeBTuc8CdGcEH7WYo82rSYS35EiY6t7OsN+RbxHe90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HBIzyYfWaWfrxhyqqo6fxxsGZAcxkOjXNSkU/+9k1vw=;
 b=rFBSQVyjKnobcYV0mTL8rKzJ/cVUPrpETQyy++9eiOdFpHWenqHsfizCwb7N/+taWPtKfikcmrGotNq4jGnXysjCFN+EXWBDxwpdMMPh4K2jtaUDLKcibt0OdecNvERsE+SicqiWfL0zxOua5ULTDRk2ns5uvWhs8wLGz00CZuM=
Received: from BYAPR21CA0004.namprd21.prod.outlook.com (2603:10b6:a03:114::14)
 by SJ0PR12MB6830.namprd12.prod.outlook.com (2603:10b6:a03:47c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Tue, 10 Nov
 2026 05:09:04 +0000
Received: from BY1PEPF0002695A.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::44) by BYAPR21CA0004.outlook.office365.com
 (2603:10b6:a03:114::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Tue, 10
 Nov 2026 05:09:04 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695A.mail.protection.outlook.com (10.167.244.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:09:04 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:09:03 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:09:02 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:08:59 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v5 09/16] iio: adc: xilinx-xadc: Add unit suffixes to macro names
Date: Tue, 10 Nov 2026 10:31:54 +0530
Message-ID: <20261110050201.1850399-10-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
References: <20261110050201.1850399-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695A:EE_|SJ0PR12MB6830:EE_
X-MS-Office365-Filtering-Correlation-Id: 149e4f55-90d7-4ba3-1c86-08df3ee8bdd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|11063799006|261009223027099003|261021121427099003|56012099006|261022105027099003|261022075727099003|261021123027099003|261026140227099003|261028144727099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	05YYWS0yBm4MwRDc5U81wfYz3gPrYqGSr8Y81oIXm7oIPN9c59YdxTJYUvIOdHAur/g5/ruF9iVGO3QgiUOdllj1I14RGACAMfckUsfqxHVPAic09Xv75m6R2y60z6Xmf0UZeIp5GXUPcdY4+kkHT6lKkzcxkO5qqKzZfBpZ1k0vB2XyZm983PakN7ERiv8Eo0sv/newrTWQggaYfsvWPEJDjNTgZp8IBYPCzzxKv+u/Zva8OclPN0A4UXkmMlwYrbl34l7bawpNkqMvzhe4D7H9Z5CY723qparS6L2puOY7as9Qa1l4cJQjX4XkUXCVj/OEWhMCDXTBJcfzMtTMP3W8969sZ9TyTI4hJQeoGgS4y3GRKj9/qYIS4q/1R7uLnHT/j0xkShtg/K+w+BAA9hDn2lopFzgz1QZStKP7T9fg/ojmPAaJh5I7qp4JOobmZki7nkpIFU3vIJCudAIH9QQbOTheahr0psFzkvr1zMR83Q8hvv933Fyg5IcL1hbbpHfgHAF5CnKpARudKI6a5zNHnHNX1oGfvN5JuUy3UPQks5zXe5RsMYMMdQlV8u8b/F1QKj81VQhXgPMRzgtc+QjakKiGmwZW61vOHtlU2gIPGUfZogdJsqDbmtXUvlL7doLGPN560ehLmBsJ8PdhB+NR+BYcbbXS+vvnX3IqIDbZEemUBoKVeDK6NsJqNg0Gdz9ValZEDASohl9/zhRdrg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(11063799006)(261009223027099003)(261021121427099003)(56012099006)(261022105027099003)(261022075727099003)(261021123027099003)(261026140227099003)(261028144727099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nzcWX6EJStRbPmV9i+s9eQg7dq4u8ETOZ0YBodad3BNwcgablE7JucPo0gM4cfXMz4ijqMIO1g7v2SDDrln3qJm7LvC8n1VBl43EBykDBY82VcN0FKlpEcGaYOMsHoNT4zcUjUT+y0f/spylbKmoajnesUhMiWj+2GrBAJZqpYUi0LlGj0IOwD6s1jk6YZ5psZoEWdsP3zptNW7spo0BJRQR2913rMYNnGSADiRtK943MT1sloIaKjL4aT4fbriiXvNCSbObGe5+9cfPz41d3jnqeZAG2GcBnrYiRWgKiUYo8XiD4y/KM3irHWhxnnR9Hu44tw85h8onrbwVrXU9ySac2xIXQGao1s8IVc4ir++uaEN3V7AUiBOt7DPyJkqYYG1rUh32P4fIsmrkpU4ftCqDdT+PHc36bOHRsp2BzFdBFmdTA57oRQmP1AEiyjHo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:09:04.7057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 149e4f55-90d7-4ba3-1c86-08df3ee8bdd0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002695A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6830

Append the unit to the relevant macro names (_HZ, _MS, _CYCLES, _SPS)
so that the expected unit of each value is clear at the point of use
and to avoid ambiguity.

No functional change intended

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 36 +++++++++++++++---------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 7dc43a3bf3c3..145bb7614523 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -38,7 +38,7 @@
 
 #include "xilinx-xadc.h"
 
-static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
+static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT_MS = 500;
 
 /* ZYNQ register definitions */
 #define XADC_ZYNQ_REG_CFG	0x00
@@ -126,7 +126,7 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
  * limits the maximum samplerate 150kSPS. At this rate the CPU is fairly busy,
  * but still responsive.
  */
-#define XADC_MAX_SAMPLERATE 150000
+#define XADC_MAX_SAMPLERATE_SPS 150000
 
 static void xadc_write_reg(struct xadc *xadc, unsigned int reg, u32 val)
 {
@@ -279,7 +279,7 @@ static void xadc_zynq_unmask_worker(struct work_struct *work)
 	/* if still pending some alarm re-trigger the timer */
 	if (xadc->zynq_masked_alarm) {
 		schedule_delayed_work(&xadc->zynq_unmask_work,
-				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
+				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT_MS));
 	}
 }
 
@@ -318,15 +318,15 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 
 		/* unmask the required interrupts in timer. */
 		schedule_delayed_work(&xadc->zynq_unmask_work,
-				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
+				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT_MS));
 	}
 
 	return IRQ_HANDLED;
 }
 
-#define XADC_ZYNQ_TCK_RATE_MAX 50000000
-#define XADC_ZYNQ_IGAP_DEFAULT 20
-#define XADC_ZYNQ_PCAP_RATE_MAX 200000000
+#define XADC_ZYNQ_TCK_RATE_MAX_HZ	50000000
+#define XADC_ZYNQ_IGAP_DEFAULT_CYCLES	20
+#define XADC_ZYNQ_PCAP_RATE_MAX_HZ	200000000
 
 static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
 {
@@ -339,8 +339,8 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 	int ret;
 
 	/* TODO: Figure out how to make igap and tck_rate configurable */
-	igap = XADC_ZYNQ_IGAP_DEFAULT;
-	tck_rate = XADC_ZYNQ_TCK_RATE_MAX;
+	igap = XADC_ZYNQ_IGAP_DEFAULT_CYCLES;
+	tck_rate = XADC_ZYNQ_TCK_RATE_MAX_HZ;
 
 	xadc->zynq_intmask = ~0;
 
@@ -348,8 +348,8 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 	if (!pcap_rate)
 		return -EINVAL;
 
-	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
-		ret = clk_set_rate(xadc->clk, (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
+	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX_HZ) {
+		ret = clk_set_rate(xadc->clk, (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX_HZ);
 		if (ret)
 			return ret;
 	}
@@ -358,7 +358,7 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 		div = 2;
 	} else {
 		div = pcap_rate / tck_rate;
-		if (pcap_rate / div > XADC_ZYNQ_TCK_RATE_MAX)
+		if (pcap_rate / div > XADC_ZYNQ_TCK_RATE_MAX_HZ)
 			div++;
 	}
 
@@ -379,7 +379,7 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 		       XADC_ZYNQ_CFG_REDGE | FIELD_PREP(XADC_ZYNQ_CFG_TCKRATE_MASK, tck_div) |
 		       XADC_ZYNQ_CFG_IGAP(igap));
 
-	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
+	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX_HZ) {
 		ret = clk_set_rate(xadc->clk, pcap_rate);
 		if (ret)
 			return ret;
@@ -957,8 +957,8 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
 		return -EINVAL;
 
 	/* Max. 150 kSPS */
-	if (val > XADC_MAX_SAMPLERATE)
-		val = XADC_MAX_SAMPLERATE;
+	if (val > XADC_MAX_SAMPLERATE_SPS)
+		val = XADC_MAX_SAMPLERATE_SPS;
 
 	val *= 26;
 
@@ -971,7 +971,7 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
 	 * limit.
 	 */
 	div = clk_rate / val;
-	if (clk_rate / div / 26 > XADC_MAX_SAMPLERATE)
+	if (clk_rate / div / 26 > XADC_MAX_SAMPLERATE_SPS)
 		div++;
 	if (div < 2)
 		div = 2;
@@ -1348,8 +1348,8 @@ static int xadc_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 
-		if (ret > XADC_MAX_SAMPLERATE) {
-			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE);
+		if (ret > XADC_MAX_SAMPLERATE_SPS) {
+			ret = xadc_write_samplerate(xadc, XADC_MAX_SAMPLERATE_SPS);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.34.1

