Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013058.outbound.protection.outlook.com [40.93.196.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77922427F85;
	Mon,  5 Oct 2026 09:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193360; cv=fail; b=VFkOC/2jos5WhNE5qgzuXItp1nLNut6vrPrAI0GoyqF+lqe9o0pBfJD7ucnryGguE/63qEk0PbbI7bCYFPGjBzCCjEaooAB9QCXz0R9OFlXhn8msVwTNWMqubnDwCm9VKGEOffdPsCVh4h1/aYYSSiPrpMhercNSSTSeTNqWci4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193360; c=relaxed/simple;
	bh=qVRzFhAIJeJlhpd1HVKEOcufBRo4a9Lm2ztqI0KBNMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bp2dy3X2eDhRGeRmJJ/DWOrTo1lqlz15wNu5fnei1OsxjCTV/Kgbq0mRUP/e0QMlZx6PIZjFoJrPrGsprW6fBFX2ORI/wtLDjT4rbpFie/dwZaVj9CyYVxpdhGUr3mAbEKDcf7VZ8Kkv9rNFvpdVRs6IcqZZQwAFEfIFCW3TRxs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wAN+FbPC; arc=fail smtp.client-ip=40.93.196.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wAN+FbPC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KEOQw3Nm7tWWI/NU6bli8ZKdZ8qr589GlysZqb4Kn8o5TPGg863JuUfUgGMYp9o8GVugrEBXBVDZUDDTKA++ncgyf8QBL6YTfnVFKiospAZOlNV4ZdwKdbA3SW3N5wUXewmpM3RBtrpbqXzqKi0HMJTwE/EFgCJYZZ5zLcypWOcleZ00piauHyvhhXilI7QT4a4zMrShsLQ8qJGZvj6EHpkMWA4q3jOumdleiAtD8CWykF5M85AkcJwmAuWD2mMESt4BB6+Yhay3g90bSGudGpU1nD1yJ/lmna9MCTHIxWEFA0zIqkSl9sW3QQc+NRMedkM4mE+iJxKD8xa/qRyRZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GpejxqvnJOL3cxPbY4OqEX+7x4vsVHXPgVP/mQ6i+Sg=;
 b=c4O1XLzC4VY3OihYHQRvOjNDIuv15ERoXytAs8uiksdFQ2j6wR1aOa3FT+CXUYdOlNN5iHl1uriLxm5wgoWspotlZu1T88DjZJWFW18NErNHUHOIFxBPi1+eRP0SgoOnFTDuCBgYWDlj4gwRyXYHjehB7VguN156SUcV4P2fRTFdWfErL1eQeMvwA55fu0zkMCR38zx2rlukBnHGujb3PcxzzNZca7i3bgEKKFqpgw5I+x0bmrIEZe0WaZSjPOn9RM0T7HD8rp1IboNP9TA9ZN8VQwn0/qi6hFuAWc1slIxRxMyJDVxSTWiltJONp/AffOjOC140T+NNBD4lPnxUmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GpejxqvnJOL3cxPbY4OqEX+7x4vsVHXPgVP/mQ6i+Sg=;
 b=wAN+FbPCF/UXe1OEUJAowLv6P6H7YE98ilxURmC7txl7qqTpukHiPmmoCG6L98UVRD4TDNPB/rjzVRJ87RriozAsUl5//PHTsqaUQ4LnLEdbwDsBO3C9Bl8g9X6SthR6y3fUEqFWgGTdkTqijnMR7ghbVlPoTKcWV29uIfE3feI=
Received: from BN9PR03CA0958.namprd03.prod.outlook.com (2603:10b6:408:108::33)
 by CY8PR12MB7538.namprd12.prod.outlook.com (2603:10b6:930:95::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Mon, 5 Oct
 2026 09:42:24 +0000
Received: from BN3PEPF00022BD5.namprd03.prod.outlook.com
 (2603:10b6:408:108:cafe::1a) by BN9PR03CA0958.outlook.office365.com
 (2603:10b6:408:108::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 09:42:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BD5.mail.protection.outlook.com (10.167.248.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:42:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:22 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:42:19 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 02/15] iio: adc: xilinx-xadc: Fix coding style issues
Date: Mon, 5 Oct 2026 15:11:52 +0530
Message-ID: <20261005094205.1045874-3-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BD5:EE_|CY8PR12MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b259803-90e1-4b17-ee79-08df22c4f5a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|376014|10067099003|56012099006|11063799006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mvzERrUzRF8713ZIG3DEUFLqhvEhEOc+h9Kc08hYdmknqMfNbzUPPAS7iIJJSqvKsqUWiLuEPXmndFOXy3bVTyECeLAAulhrO9a8HkyJbfT5cwwgQPBB1bESCdHm/ccM1SUkS2/RLolVzqxbhsErGzwy7IG7KgXXroLC06lmE+/zBv8AQzYesbBIBvga7CPy5IIAXlm3y9Qrb9FV1AxTCDdwAdilNcSM1DGDjCf0/0LnrMcyYBdvkXUkRAnx3cSoMDJVaS6sLLkvq6bZulTOAYrGsfcHRT54cUxEPFWJsLlSVX1ExMgdGgyuvy4FNT2JsDjFp6CClNond8BNCfAMgPXJsFsrswXnIRVPKc2vJ35BKvSOTT06reanwsWXrgTb9AkIuY/UO1FHIHC35fGolvxiD8HRvxxMQAwNB0pkA5FMTBgaJ5z1jh38nyAJy//DMJS1BLla5HakO47EX9+ZrRXXoHD1QMRL5kKil4SdGTHqXwcNsj3FdzdiXvt1io5UN3/TQcmHkcWdXuMy4hBwcTJeyRzd3S/SeCmEKEiwd6g7b5t/IDa1b7lUfvck2fwUs9nkCLoZKPsgx1IQOx/b/RRoTtDqMfjGUHbFtrQTzwc+RmMpIHqFgwA6Bp+Ce3i79OZaRVt93cFYIKSzUjXASz6uKXKpHBE3oDd0al2DlaQrmYqANdTGg1Et61VXb8Vg9UCmfWBh2NVF81Z2tk1dfQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(376014)(10067099003)(56012099006)(11063799006)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MbyK6A4tBgMn+fVgk8uYBsCh7u8D/xwBLD5QwSxH/wx3jE1Mc2uM+Cgmb2wtD+0yiTAX3BFh5nrcuLDiI4jOFhapckfIK4m8QQVZNhXs2ZWV71Im6T51E4kq2nwoOyTCTH5HcKCAKWelgqMxathu8lL2wkEOIWcGOpnCDPX4giML4EafSvDjI2Ga3g9SmVMQ9/e/3JuxuT12aLoEZVpxVRXcdrYwtY1fNs3pLp6LYsz4vqRzs3JDftgKY+rQM+NIYqB0uqaNl4gstC3nmC7rcpBo53LDHVc5VGCxhp/LI/ceQiAaG4AJTEetilX/5ZbUKMIAvUKNLXM0R6+TEe70rNEuE6Xf8vEiWDhCtaSFpGH6VUm4ef2qsykXDbfIcuks3fN2w+slKwAGXq19OoGAV3g2C+YoFPnkcSupIOs37Ihbf/hw6pG5w6XqoQeYga7x
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:42:23.9958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b259803-90e1-4b17-ee79-08df22c4f5a9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7538

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
---
 drivers/iio/adc/xilinx-xadc-core.c   | 143 ++++++++++-----------------
 drivers/iio/adc/xilinx-xadc-events.c |  50 +++++-----
 drivers/iio/adc/xilinx-xadc.h        |  40 +++-----
 3 files changed, 90 insertions(+), 143 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index bfabe78b66e3..472246b6a1c7 100644
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
 
@@ -206,8 +198,7 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg,
 	return ret;
 }
 
-static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t *val)
+static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
 {
 	uint32_t cmd[2];
 	uint32_t resp, tmp;
@@ -217,8 +208,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
 	cmd[1] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_NOP, 0, 0);
 
 	spin_lock_irq(&xadc->lock);
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
-			XADC_ZYNQ_INT_DFIFO_GTH);
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
 	xadc_zynq_drain_fifo(xadc);
 	reinit_completion(&xadc->completion);
 
@@ -246,9 +236,7 @@ static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg,
 
 static unsigned int xadc_zynq_transform_alarm(unsigned int alarm)
 {
-	return ((alarm & 0x80) >> 4) |
-		((alarm & 0x78) << 1) |
-		(alarm & 0x07);
+	return ((alarm & 0x80) >> 4) | ((alarm & 0x78) << 1) | (alarm & 0x07);
 }
 
 /*
@@ -287,9 +275,8 @@ static void xadc_zynq_unmask_worker(struct work_struct *work)
 	/* if still pending some alarm re-trigger the timer */
 	if (xadc->zynq_masked_alarm) {
 		schedule_delayed_work(&xadc->zynq_unmask_work,
-				msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
+				      msecs_to_jiffies(XADC_ZYNQ_UNMASK_TIMEOUT));
 	}
-
 }
 
 static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
@@ -310,8 +297,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status);
 
 	if (status & XADC_ZYNQ_INT_DFIFO_GTH) {
-		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH,
-			XADC_ZYNQ_INT_DFIFO_GTH);
+		xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_DFIFO_GTH, XADC_ZYNQ_INT_DFIFO_GTH);
 		complete(&xadc->completion);
 	}
 
@@ -324,12 +310,11 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
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
 
@@ -340,8 +325,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 #define XADC_ZYNQ_IGAP_DEFAULT 20
 #define XADC_ZYNQ_PCAP_RATE_MAX 200000000
 
-static int xadc_zynq_setup(struct platform_device *pdev,
-	struct iio_dev *indio_dev, int irq)
+static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_dev, int irq)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned long pcap_rate;
@@ -362,8 +346,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 		return -EINVAL;
 
 	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
-		ret = clk_set_rate(xadc->clk,
-				   (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
+		ret = clk_set_rate(xadc->clk, (unsigned long)XADC_ZYNQ_PCAP_RATE_MAX);
 		if (ret)
 			return ret;
 	}
@@ -390,7 +373,7 @@ static int xadc_zynq_setup(struct platform_device *pdev,
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, ~0);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_CFG, XADC_ZYNQ_CFG_ENABLE |
-			XADC_ZYNQ_CFG_REDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
+		       XADC_ZYNQ_CFG_REDGE | tck_div | XADC_ZYNQ_CFG_IGAP(igap));
 
 	if (pcap_rate > XADC_ZYNQ_PCAP_RATE_MAX) {
 		ret = clk_set_rate(xadc->clk, pcap_rate);
@@ -440,8 +423,7 @@ static void xadc_zynq_update_alarm(struct xadc *xadc, unsigned int alarm)
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTSTS, status & alarm);
 
-	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK,
-		~alarm & XADC_ZYNQ_INT_ALARM_MASK);
+	xadc_zynq_update_intmsk(xadc, XADC_ZYNQ_INT_ALARM_MASK, ~alarm & XADC_ZYNQ_INT_ALARM_MASK);
 
 	spin_unlock_irqrestore(&xadc->lock, flags);
 }
@@ -464,29 +446,24 @@ static const unsigned int xadc_axi_reg_offsets[] = {
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
 
@@ -542,8 +519,7 @@ static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
 	 * passed the alarm mask in the same order as in the XADC alarm enable
 	 * register.
 	 */
-	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) |
-			((alarm & 0xf0) << 6);
+	alarm = ((alarm & 0x07) << 1) | ((alarm & 0x08) >> 3) | ((alarm & 0xf0) << 6);
 
 	spin_lock_irqsave(&xadc->lock, flags);
 	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &val);
@@ -589,8 +565,7 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.temp_offset = 280231,
 };
 
-static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t mask, uint16_t val)
+static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t mask, uint16_t val)
 {
 	uint16_t tmp;
 	int ret;
@@ -602,8 +577,7 @@ static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
 	return _xadc_write_adc_reg(xadc, reg, (tmp & ~mask) | val);
 }
 
-static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg,
-	uint16_t mask, uint16_t val)
+static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t mask, uint16_t val)
 {
 	int ret;
 
@@ -619,17 +593,16 @@ static unsigned long xadc_get_dclk_rate(struct xadc *xadc)
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
 
@@ -715,8 +688,7 @@ static int xadc_trigger_set_state(struct iio_trigger *trigger, bool state)
 			else
 				convst = 0;
 		}
-		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC,
-					convst);
+		ret = _xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF0_EC, convst);
 		if (ret)
 			goto err_out;
 	} else {
@@ -743,8 +715,7 @@ static const struct iio_trigger_ops xadc_trigger_ops = {
 	.set_trigger_state = &xadc_trigger_set_state,
 };
 
-static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev,
-	const char *name)
+static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev, const char *name)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct iio_trigger *trig;
@@ -789,8 +760,7 @@ static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 		break;
 	}
 
-	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK,
-		val);
+	return xadc_update_adc_reg(xadc, XADC_REG_CONF2, XADC_CONF2_PD_MASK, val);
 }
 
 static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
@@ -804,8 +774,7 @@ static int xadc_get_seq_mode(struct xadc *xadc, unsigned long scan_mode)
 	if (xadc->external_mux_mode == XADC_EXTERNAL_MUX_DUAL)
 		return XADC_CONF1_SEQ_SIMULTANEOUS;
 
-	if ((aux_scan_mode & 0xff00) == 0 ||
-		(aux_scan_mode & 0x00ff) == 0)
+	if ((aux_scan_mode & 0xff00) == 0 || (aux_scan_mode & 0x00ff) == 0)
 		return XADC_CONF1_SEQ_CONTINUOUS;
 
 	return XADC_CONF1_SEQ_SIMULTANEOUS;
@@ -838,8 +807,7 @@ static int xadc_postdisable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-				  seq_mode);
+	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK, seq_mode);
 	if (ret)
 		return ret;
 
@@ -854,7 +822,7 @@ static int xadc_preenable(struct iio_dev *indio_dev)
 	int ret;
 
 	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-		XADC_CONF1_SEQ_DEFAULT);
+				  XADC_CONF1_SEQ_DEFAULT);
 	if (ret)
 		goto err;
 
@@ -883,8 +851,7 @@ static int xadc_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		goto err;
 
-	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK,
-		seq_mode);
+	ret = xadc_update_adc_reg(xadc, XADC_REG_CONF1, XADC_CONF1_SEQ_MASK, seq_mode);
 	if (ret)
 		goto err;
 
@@ -917,7 +884,7 @@ static int xadc_read_samplerate(struct xadc *xadc)
 }
 
 static int xadc_read_raw(struct iio_dev *indio_dev,
-	struct iio_chan_spec const *chan, int *val, int *val2, long info)
+			 struct iio_chan_spec const *chan, int *val, int *val2, long info)
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned int bits = chan->scan_type.realbits;
@@ -1017,11 +984,11 @@ static int xadc_write_samplerate(struct xadc *xadc, int val)
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
 
@@ -1035,9 +1002,8 @@ static const struct iio_event_spec xadc_temp_events[] = {
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
 
@@ -1293,9 +1259,8 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
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
@@ -1303,7 +1268,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 	return 0;
 }
 
-static const char * const xadc_type_names[] = {
+static const char *const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
 	[XADC_TYPE_US] = "xilinx-system-monitor",
 };
@@ -1332,8 +1297,7 @@ static int xadc_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	irq = platform_get_irq_optional(pdev, 0);
-	if (irq < 0 &&
-	    (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
+	if (irq < 0 && (irq != -ENXIO || !(ops->flags & XADC_FLAGS_IRQ_OPTIONAL)))
 		return irq;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*xadc));
@@ -1360,10 +1324,8 @@ static int xadc_probe(struct platform_device *pdev)
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
 
@@ -1372,8 +1334,7 @@ static int xadc_probe(struct platform_device *pdev)
 			if (IS_ERR(xadc->convst_trigger))
 				return PTR_ERR(xadc->convst_trigger);
 
-			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev,
-				"samplerate");
+			xadc->samplerate_trigger = xadc_alloc_trigger(indio_dev, "samplerate");
 			if (IS_ERR(xadc->samplerate_trigger))
 				return PTR_ERR(xadc->samplerate_trigger);
 		}
@@ -1416,8 +1377,7 @@ static int xadc_probe(struct platform_device *pdev)
 		return ret;
 
 	for (i = 0; i < 16; i++)
-		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i),
-			&xadc->threshold[i]);
+		xadc_read_adc_reg(xadc, XADC_REG_THRESHOLD(i), &xadc->threshold[i]);
 
 	ret = xadc_write_adc_reg(xadc, XADC_REG_CONF0, conf0);
 	if (ret)
@@ -1433,8 +1393,7 @@ static int xadc_probe(struct platform_device *pdev)
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

