Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011034.outbound.protection.outlook.com [52.101.57.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F04519BA;
	Mon,  5 Oct 2026 09:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193376; cv=fail; b=D+JBJJgfE0ZGtQDXnEJbCgIMbpcU2T4GFO6M7IaL083MQUx9NHBWEewm7Pfd0DpUDcQWprmu6oE4/EL4/p4MTTNwvG+4RmBtju44nHJwliQN9YV0YfIv0nk9gKM60G1fnxC4g8Bs4LprwYLVRXGT517KYqlYkC8bhhV0BaUMnok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193376; c=relaxed/simple;
	bh=h7V9O0UtF3rJuPiCiyWd1Bmv2B8GkNYYTokOfIMi3mg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RJGSqjGWumxZ88vF6jySaQHTgW6onK8j/gcH4CQHAD5ySa8JufYIIG5piNdFi6r3kXL/F+mGA2nscnICL+QrAq+HL78ChZWhFQ0/I8Fk6lVlTsjy701AlXtfvmZyGXSxKvDNlG9IlVLJD88OqUqGnf4SFsDhEoLf0ocL6Scy3J8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wKLrVMYF; arc=fail smtp.client-ip=52.101.57.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wKLrVMYF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hhTkvoRy8RXnPf799tykSLA0UTeSojF7TiuxGkwqiQem4aK9OnPg0jdVeygl/X0Zy1NVhDeYoqRtt5K4PryWFvkuMWvYVfIfDQ08x3jSRA1GEGRCYs7Klf+Xe44NbXxQI1g50JDnG33kstTYb+P2QgiQVWduTf30xMbSVcgqEHNQDvx46gYcjpTr5IpQ3+pTmncZu4x2mYtu8O/OW4AUgjj1TW4coFurNBrBwvt6GNrBk1tp3s0Fd6CW/rU3nZcnt6yTtf8H3khzzSd3Kl9ZlnEsNCFhufZF9lkHF62nf2U78r52hhstvjbKhnLnCANV64mqbesNESe75pmu6oo0Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bowSnIts/WJv8n3lJ7NkE2huv52LLoGxKpMFsBehBpE=;
 b=oaOBfmwZZLIA1rr65oWQZQDaffROEEqHnQGrKfdNWnH3w0+JTRWF7yBy/bOAsNM1Uc0CF87ztd5jfFsNc+Ye3S0aJ/7MSn8cdlPj9Q7rvzxt4aNY5s8JgDU9a5Ts9p7q1U2jMf3mmhaNwaPWysY3Aqgo+mCQE6Rh/UkLeckyzfF1J0+bKMX9RLth4Ofk+uxaDkvkLfTj2v3uxiGJJOz+HOaJC+Waqj4Og4fk7sswvR+QGkUrMvH4X9PIYmDM8nuO6yKpxN2Xg+lt9Bg7x3EKlSoaSMFm6iOt6cfGI/rLZ/9kj5e1Wn7mhXaedZUt4LVY7IHAQBPsaxP7Fh6TXY6/pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bowSnIts/WJv8n3lJ7NkE2huv52LLoGxKpMFsBehBpE=;
 b=wKLrVMYF//9Xq6h20dWbZlHv1ttxszpxzCjkXkeEttuVSEZjibvLOlsvrtBAtVsUHg4/W8Jrfd8x00WpaRwkQDzkSGzGHMcmc8dEAtL+ToOI5wT53NkrkIa6hjh8OrP3U+kvSz6YjF/jIzmDjF7Afy8kco2pIbx8w20mjwAbVIc=
Received: from CH2PR04CA0010.namprd04.prod.outlook.com (2603:10b6:610:52::20)
 by LY0PR12MB390394.namprd12.prod.outlook.com (2603:10b6:408:3b9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 09:42:43 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:610:52:cafe::8f) by CH2PR04CA0010.outlook.office365.com
 (2603:10b6:610:52::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 09:42:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:42:42 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:41 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:40 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:42:37 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 06/15] iio: adc: xilinx-xadc: Use guard()/scoped_guard() for spinlock locking
Date: Mon, 5 Oct 2026 15:11:56 +0530
Message-ID: <20261005094205.1045874-7-dileepkumar.nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
References: <20261005094205.1045874-1-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|LY0PR12MB390394:EE_
X-MS-Office365-Filtering-Correlation-Id: d3a0980f-1b39-454d-54a7-08df22c500e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|10067099003|56012099006|6133799003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	J3CntOaqU+3vtyDd8MrYM298LXEb1HTKvzvx0uzZJFAF+x73KMrXNkRzAcvJSg9zse2uJ8Zgo+MQHpHtuYeL20xQeuOtUpscF+stjkLJfAoVmywocn2OPuaSOKl8nM9NCepWSnL6+uBI51IVvjmhr6dAfWyEgCsPT5pGJqhy02IDu8zAuar6jVqrkAjTkz16s1lcJwQiFfCqMRIgJ+RBDR5k9HSkLxPJ2+PieSatr6TQSLUNWvwhpR3HzGolpgQy6nDOgPU2qDMikcmMAAgdfRhdFq9oMVrMSLjFtXmecqK57QYX4iTuYM1AwGvIo1mLBjZuQjw9QYjJcSNI21k+E8rHSwCeNsaz8oc91WARRs1+x+co36CNswNrjbVJL5+tCcDb0xLEimn+TZrVbKymGJVjxwfzWs0fdCd3vhPWA2yOn9pBeCDMaOj/ALNZcE3HdoQRb5MHCdrC+MyZqaz7GMJZjFKcKrho0gVxmhNnP+LGaOCxZk+TW/8rBnrKKW+7nKOjwC1fOlze9mhGmH+fDJuyKrwQBNvd7q5WtUOCtQnpqwbxpGbTpNnql2j4Np+q+Upp4myrtzrakskqy/JPMb/z8Qy2buLkKsxxoob0GBwwzg7gRBYnToq/uGU5Z2PcrF1BT6vfpb2q5jKgSm+Kxt+Ph7rZZe8qXKRnJrj1d9w6JSIpKqmZIHGyZOtxIxW8XPPh1RmOPdjUrc0mB11Rcg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(6133799003)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lbEhhvSUWR/alokwbNg+POiqcSoaKdBrtuyGesnyRyPl8yDSCO1ogK2lRYenjomFSBAB2UA4QSVfqHAKfOSrQDzSl2gpqpvVHM41sglWXd5R/K6F4Indr7nX6cINJhyV5CjuJDtzOgC1OqWah51l9aHFlb5O8wvPU8FdvTxNICKnZBXNdJujhPddyh7tJKlLa+XSdU2CGQKcrJnEiSlfXgEBaPyHYNoMzPTyaMyzN7Kqu380kMfIlxX9o8K5MCO4KmH4JjR4ac//Rawa7qPUc41ZgLvHSaxHOFnaZxoKOgDQe4YZ88yLDpYDLfc7OanJS0Ili9FtfPz4LYGEMDsCBWqbByJOMvsDZZfyuFQ+rPXlrX4wHuTUfz5KERNe2l3fWNsGZeWVbVyRIP75BalZzOPqWHMinNvzRoh4HV9RBquAqdWTv6t8XpzSqo5NTQZK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:42:42.8048
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a0980f-1b39-454d-54a7-08df22c500e0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LY0PR12MB390394

Use guard() and scoped_guard() helpers for spinlock handling
instead of spin_lock/spin_unlock sequences.

This removes the need for explicit spin_unlock()

No functional change intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c | 97 ++++++++++++++----------------
 1 file changed, 45 insertions(+), 52 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 9e4955016bbc..0234c8301c2e 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -13,6 +13,7 @@
 
 #include <linux/bitfield.h>
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -155,19 +156,19 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
 	u32 tmp;
 	int ret;
 
-	spin_lock_irq(&xadc->lock);
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
+	scoped_guard(spinlock_irq, &xadc->lock) {
+		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
 
-	reinit_completion(&xadc->completion);
+		reinit_completion(&xadc->completion);
 
-	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_WRITE, reg, val);
-	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
-	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
+		cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_WRITE, reg, val);
+		xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
+		xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
+		tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
+		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
 
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
-	spin_unlock_irq(&xadc->lock);
+		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
+	}
 
 	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
 	if (ret == 0)
@@ -189,19 +190,20 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_READ, reg, 0);
 	cmd[1] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_NOP, 0, 0);
 
-	spin_lock_irq(&xadc->lock);
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
-	xadc_zynq_drain_fifo(xadc);
-	reinit_completion(&xadc->completion);
+	scoped_guard(spinlock_irq, &xadc->lock) {
+		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
+		xadc_zynq_drain_fifo(xadc);
+		reinit_completion(&xadc->completion);
 
-	xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
-	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
-	tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
-	tmp |= FIELD_PREP(XADC_ZYNQ_CFG_DFIFOTH_MASK, 1);
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
+		xadc_zynq_write_fifo(xadc, cmd, ARRAY_SIZE(cmd));
+		xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &tmp);
+		tmp &= ~XADC_ZYNQ_CFG_DFIFOTH_MASK;
+		tmp |= FIELD_PREP(XADC_ZYNQ_CFG_DFIFOTH_MASK, 1);
+		xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, tmp);
+
+		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
+	}
 
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, 0);
-	spin_unlock_irq(&xadc->lock);
 	ret = wait_for_completion_interruptible_timeout(&xadc->completion, HZ);
 	if (ret == 0)
 		ret = -EIO;
@@ -238,21 +240,19 @@ static void xadc_zynq_unmask_worker(struct work_struct *work)
 
 	misc_sts &= XADC_ZYNQ_INT_ALARM_MASK;
 
-	spin_lock_irq(&xadc->lock);
+	scoped_guard(spinlock_irq, &xadc->lock) {
+		/* Clear those bits which are not active anymore */
+		unmask = (xadc->zynq_masked_alarm ^ misc_sts) & xadc->zynq_masked_alarm;
+		xadc->zynq_masked_alarm &= misc_sts;
 
-	/* Clear those bits which are not active anymore */
-	unmask = (xadc->zynq_masked_alarm ^ misc_sts) & xadc->zynq_masked_alarm;
-	xadc->zynq_masked_alarm &= misc_sts;
+		/* Also clear those which are masked out anyway */
+		xadc->zynq_masked_alarm &= ~xadc->zynq_intmask;
 
-	/* Also clear those which are masked out anyway */
-	xadc->zynq_masked_alarm &= ~xadc->zynq_intmask;
+		/* Clear the interrupts before we unmask them */
+		xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, unmask);
 
-	/* Clear the interrupts before we unmask them */
-	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, unmask);
-
-	xadc_zynq_update_intmsk(xadc, 0, 0);
-
-	spin_unlock_irq(&xadc->lock);
+		xadc_zynq_update_intmsk(xadc, 0, 0);
+	}
 
 	/* if still pending some alarm re-trigger the timer */
 	if (xadc->zynq_masked_alarm) {
@@ -274,7 +274,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 	if (!status)
 		return IRQ_NONE;
 
-	spin_lock(&xadc->lock);
+	guard(spinlock)(&xadc->lock);
 
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status);
 
@@ -298,7 +298,6 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 		schedule_delayed_work(&xadc->zynq_unmask_work,
 				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
 	}
-	spin_unlock(&xadc->lock);
 
 	return IRQ_HANDLED;
 }
@@ -393,21 +392,18 @@ static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
 
 static void xadc_zynq_update_alarm(struct xadc *xadc, unsigned int alarm)
 {
-	unsigned long flags;
 	u32 status;
 
 	/* Move OT to bit 7 */
 	alarm = ((alarm & 0x08) << 4) | ((alarm & 0xf0) >> 1) | (alarm & 0x07);
 
-	spin_lock_irqsave(&xadc->lock, flags);
+	guard(spinlock_irqsave)(&xadc->lock);
 
 	/* Clear previous interrupts if any. */
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status & alarm);
 
 	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK, ~alarm & XADC_ZYNQ_INT_ALARM_MASK);
-
-	spin_unlock_irqrestore(&xadc->lock, flags);
 }
 
 static const struct xadc_ops xadc_zynq_ops = {
@@ -492,7 +488,6 @@ static irqreturn_t xadc_axi_interrupt_handler(int irq, void *devid)
 
 static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
 {
-	unsigned long flags;
 	u32 val;
 
 	/*
@@ -503,12 +498,11 @@ static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
 	 */
 	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) | ((alarm & 0xf0) << 6);
 
-	spin_lock_irqsave(&xadc->lock, flags);
+	guard(spinlock_irqsave)(&xadc->lock);
 	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
 	val &= ~XADC_AXI_INT_ALARM_MASK;
 	val |= alarm;
 	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
-	spin_unlock_irqrestore(&xadc->lock, flags);
 }
 
 static unsigned long xadc_axi_get_dclk(struct xadc *xadc)
@@ -651,7 +645,6 @@ static irqreturn_t xadc_trigger_handler(int irq, void *p)
 static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 {
 	struct xadc *xadc = iio_trigger_get_drvdata(trigger);
-	unsigned long flags;
 	unsigned int convst;
 	unsigned int val;
 	int ret = 0;
@@ -677,15 +670,15 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 		xadc->trigger = NULL;
 	}
 
-	spin_lock_irqsave(&xadc->lock, flags);
-	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
-	xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
-	if (state)
-		val |= XADC_AXI_INT_EOS;
-	else
-		val &= ~XADC_AXI_INT_EOS;
-	xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
-	spin_unlock_irqrestore(&xadc->lock, flags);
+	scoped_guard(spinlock_irqsave, &xadc->lock) {
+		xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
+		xadc_write_reg(xadc, XADC_AXI_REG_IPISR, XADC_AXI_INT_EOS);
+		if (state)
+			val |= XADC_AXI_INT_EOS;
+		else
+			val &= ~XADC_AXI_INT_EOS;
+		xadc_write_reg(xadc, XADC_AXI_REG_IPIER, val);
+	}
 
 err_out:
 	mutex_unlock(&xadc->mutex);
-- 
2.34.1

