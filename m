Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.65
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287358;
	b=4jickwuDby4evyh39UGDtCeW4TeKdA9fX32i0GXN/9p/noI6cySVlhQlEA5hTJQLlEva
	 wZjpPRdk1ojUVPjglMZ9MgfHmgUDBLnMUPgpUtqv3TG8BvI+HtC/VuWjDKkZo6xe678pA
	 M7F09rFUC13gPK+Gwf+TFfKfp0yrVN2OgZWJgifW3SnYlesDWL3BfH1Wc7s54XE9f3Xpn
	 lHCD4N7LpFoRfEu0l0onxiDQh53TXzWByo0/pQsxDkGgJoQkDwvy1k/Ko+VjviKMrpIdy
	 0GzBX1Mft5N53ocVZdZfupz1Pp1+n93Br/Y3R2LEhekFdb7WBw+4gFpZk/DCCth3/tA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287358;
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
	bh=2f+FslZRTorb5QGfmTB/DO2eteFLxHkEWin1wZpZcmQ=;
	b=BuJCQtPbR8PfL+2mLk0Rob/t/9CtsVSTfvAU5AKrCnIgR22fHDnFtqiVJ7/wazPBlupg
	 ErWDhNCNKvKEizNHHZLsohhUhKWNRV9w2KW9IXjkP7kPqPz9ZmoziyzVTOFt35OhhrZFT
	 hQCuLenSJn/26tth2NNAXfEyGb8OxrHqIQK3iIlLptE3Mgj0BU4M8HMCWPFyFdnRnVod4
	 Rn29RRLVgkAoi+zPmHC6Vwf2xxE7RHKxQ+s7mln1i9hrPJbO+UPSKiO8uur1GfPwEES/B
	 Qt+yaQhQaHla6q/jg7iOaO2N5LN1/DDURBLMiRusNe1gwb70c61M4tHWXCkCu6s415w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ENAOMT1U;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.196.65
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013065.outbound.protection.outlook.com [40.93.196.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C91E606A32E;
	Tue, 10 Nov 2026 05:09:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C91E606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ENAOMT1U
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8PY/rXWNdLgZPbGSAFqrWUCleQOzSK67a707z0Npupr6mQZYWJ43XUZHtzYCOCJOnAFZdKMA6vRc/XHGr0CNJgdybgEr1s23/d+oPF0+NZrM9AYMVQa0CsDAOj8phgcs5eqlEMRcxts2y37vlEgWAmabktaG8XX9Zo4Gh1708J6/TO75df6t46fOVzMlZTidbsfz5vbahAzGRLdk3VEE8nzvli4sFdrDANjY0MLXKzWAcFZ4bHS3nJwVac92w40VegnrSmftqZg6P+sJcHve1upRoiKvy/8b7hTwyeKc556r6uSUNMM9cMIzjwQMDLX+XArOVpBI0KEHnTxKhmyqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2f+FslZRTorb5QGfmTB/DO2eteFLxHkEWin1wZpZcmQ=;
 b=YSlvOcjXJyW4EmRB5rIc3uRP+X1SnY5O7OVcmCR1RowQr6TVjwFvO3uYOMBLCACXghBfjyGplVJt0lyz/rV4CclDb4298LWLZZpbRn5AVJ1jhGst7GXfdQ2I2yDJwTFqSsesFIkXVt2f2GTwOxpnvfjRzyAtqiLzi40e6tyacaucZu25QDUQRbjcXbPdxai0Gp78823PBeP44P35gVyZvQk81mKrc1POOE2XmGAydNAotKqytt9iISnjT8TwDRcvb5np3AQgKJQWHVMvG9dYei8aeqYA+UsSf9DwwYJ67bPSBzOPAI/QHzBnUbdnfbYOhdGQM2wshkEWIUb4uhFGxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2f+FslZRTorb5QGfmTB/DO2eteFLxHkEWin1wZpZcmQ=;
 b=ENAOMT1UOhKv4fVi9npf2n4RvC0Tothh78dBB6o7HVJSjjvvb6ITrZwpppAloN60Iw70rfqxQ8TFeFrEATSOur0GqjB6UmsUIpYgY0v42PmzG6wA8DazjZ/xO5MnyZ1frInUcUOb2VKWUETz0B6+mijtyvi3PlbH55EO1ax649U=
Received: from PH8PR02CA0037.namprd02.prod.outlook.com (2603:10b6:510:2da::35)
 by IA0PPF8CAB220A1.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bd9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Tue, 10 Nov
 2026 05:09:15 +0000
Received: from BY1PEPF0002695A.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::2) by PH8PR02CA0037.outlook.office365.com
 (2603:10b6:510:2da::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.13 via Frontend Transport; Tue,
 10 Nov 2026 05:09:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0002695A.mail.protection.outlook.com (10.167.244.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:09:14 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:09:11 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:09:10 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:09:07 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>, Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH v5 11/16] iio: adc: xilinx-xadc: Add clarifying comments
Date: Tue, 10 Nov 2026 10:31:56 +0530
Message-ID: <20261110050201.1850399-12-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0002695A:EE_|IA0PPF8CAB220A1:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c95e4b-4c47-4d58-ba85-08df3ee8c3ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|22082099003|6133799003|10067099003|11063799006|261102123227099003|261028144727099003|261022105027099003|261009223027099003|261022075727099003|261021121427099003|261021123027099003|56012099006|261026140227099003;
X-Microsoft-Antispam-Message-Info:
	upVHJBMUvjbBcM97m/69Fy8Auu6Z2jtVZ/wSrMgqOCR6Vu2LilZkpZ3bV/zsaWPHSNKxs8Kj+cur0EgO9aTJM+uma4U8NGS0I24IaITdGXWFIcqgpoAOMIm7cUPH1xEDoADHZSvArJB0/Ye+XWdJ7pwYb+L8bEKrZdaLfpv1buYrMO0L9YvvC9xHMhKBkLoF/iaaRr5s4HqpA4hD8BnZM8F7MNBkPSypD23h2dmT1rozhEnfMft8+vvI1jIsWJQrwfSkDWcPOO0lTaVwV5ZgtpJo3/HVIsGYguEVqvzWaBS4jd+qXv2ex2MLmXNqE34Kj2BZGrRUKNcqlwvbXUjnNTEm3xJ0ZAoRxJ9/32rUu/viCjlhIEEEY9iZqZLoABiO3JVMA2NzWrVhnzsQxiTMpD60Ex6lWIjrz9JoN/2a+iHmV+rZPNxDqV2XFBdHNbuCA9lxVj02LpzlOczNfLYiUYeF6w3RzbhnBqMmeQw6hb+2eqpEWjoqmvMIlSHyhK+c92BK90Wn4GFhj2BhDj+O09AzmFiOAgyTKxzC6fUWZLrjlqvxkpA8TRWSWyvOpbWVy6la+d2w19fqwjmPkrAhR5AMhZq0zEAzKFIfk1t8CI2SYC1IkjMEv1qUT6FXIYA1YURaFSYTTcgAiP0/aXMklTm7qgVbZehWrXd19BmQ1FPKpACsb05QCemjzTChwJrmB0g+v19De9rd16TgNZWT/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(261102123227099003)(261028144727099003)(261022105027099003)(261009223027099003)(261022075727099003)(261021121427099003)(261021123027099003)(56012099006)(261026140227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Vb4Q3I1zS2PWsexDJLJasvoObCQHP7lzLtOeh3swYufMHxlZE+DMj8E9pqz8ZKSXE3NyBjSlGPKVA2Yl6hy4ALyMM1X8+2dAt+GwWwu4dc4owP4LRuqitrC8UV6bwRJtT8aTeWse2Yt8cAvz6QheQNDF8E8Q/2d719MmBbPm2/u6TmbsEQLgeJxLe/MDGut7JNpButwQcSCNjKN76b+CZBNSwGG2tpBjuFItVy8MbJUI4dMISUbKBOJ7YwVwPjaIWjvSMlkLPx6wh1DkVQAPVrSlxgwd3p8eh2a669r1Ud+4hbVmrhp4K+zEWaTmEGLtchMn48I1OTL1/NZ5RPNOdjWYA164T1koUg2Rdfe6ceOaF1qsRfV8Mmjs/naW84Qhos2KIGh3MSrtqhixfwK/I6/kU9ha34f9toHjHkYtSVjTrf0Lf0VLde+1SRtkp435
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:09:14.5322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c95e4b-4c47-4d58-ba85-08df3ee8c3ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0002695A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF8CAB220A1

Add missing comments on struct mutex and spinlock_t in struct xadc
(per checkpatch.pl), and explain the non-obvious FIFO-drain loop and
Zynq alarm-bit reordering logic.

No functional change intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 9 +++++++++
 drivers/iio/adc/xilinx-xadc.h      | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 12df599358b8..9269b63d0f2c 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -158,6 +158,11 @@ static void xadc_zynq_drain_fifo(struct xadc *xadc)
 
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
 
+	/*
+	 * Reading XADC_ZYNQ_REG_DFIFO pops one entry from the data FIFO.
+	 * The loop therefore removes one pending entry per iteration and
+	 * terminates once the hardware reports the FIFO empty.
+	 */
 	while (!(status & XADC_ZYNQ_STATUS_DFIFOE)) {
 		xadc_read_reg(xadc, XADC_ZYNQ_REG_DFIFO, &tmp);
 		xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
@@ -241,6 +246,10 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 
 static unsigned int xadc_zynq_transform_alarm(unsigned int alarm)
 {
+	/*
+	 * Reorder the Zynq PS-XADC alarm bits defined in UG585 to match the common
+	 * XADC driver alarm layout.
+	 */
 	return ((alarm & 0x80) >> 4) | ((alarm & 0x78) << 1) | (alarm & 0x07);
 }
 
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 90fa3e77b1a5..1bbc19ac6333 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -60,7 +60,9 @@ struct xadc {
 	unsigned int zynq_intmask;
 	struct delayed_work zynq_unmask_work;
 
+	/* Serializes register access and device configuration updates */
 	struct mutex mutex;
+	/* Protects interrupt state and FIFO operations */
 	spinlock_t lock;
 
 	struct completion completion;
-- 
2.34.1

