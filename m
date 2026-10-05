Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5423A44F55B;
	Mon,  5 Oct 2026 09:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791193358; cv=fail; b=sgi6535m6JPqZduevCSM/XczXo8OpPFLBhZXLZ4D/lEZ2QNxg2ce4F5ULiPS3iD3Si5ZPHcmx3ztFk69iBtddaitg8rgTPeIVO/0zRkDdMfqbhCtLkXWydN4LqFQdhJEp0AgKcjq0JdlBGHlFmaLKwOCcPljA2kRZSjhDW4DUOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791193358; c=relaxed/simple;
	bh=oSGjkf7AoKIocIsQfdQ5FJWv+wiaKS6jwxdQGp+4Gvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ehbRVzW2Rly0h6KWpvuS98JoVXxY7yQLWmwfay5+Jw2GJJTy/2AURg/CMdSCAAxtd+kTffJsDQstEQhYLqn3sKRsj/21dTmbN4Nkr9tWy37S0QjBBdId+4SRnZpLVy8F+cLkfqq49eLYsIezhonmhQgEi/71c8MsDs7X19kAnPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fxfQC56q; arc=fail smtp.client-ip=40.107.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fxfQC56q"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/gCC8kFe0xXBaEGHaNaDdyiHnmzEKYSils38vRfjm6mmm/41QV25Gzq3E2JlwXvs8SQ0IKEwcNXhozcEEjyfupo5dT1a9ebaQbN6G04k+kLQ6pm9OH8RtWyA+WFyQAuhmtigLaHG3ani+/eyR0HA0/0Vl02Zmt9nrMx/8BiwVSTOyXtpCRvKCd7t9h83J/NG0wDMSt2SYVAFstLRj/H7Sy5oELvVzHjMt+SBNmgD8lTV0NhJVnOf+ZunI4J7daUhMS4KVLmFT0q+2f1HlLg++3eveLoTjedAy8WhHXz6wDGbgzF+NTbf27GfzFk6T985EATSGgY1iLxShooIY+4Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EdRJok1SlndBtdw6BGdgupCYM2HLXzZwOinc4uKVMCU=;
 b=eMNjBx8GEtEUJaLKidBoASQpwOtE0Vr6XQprMCx26pDLbXuiH/v/B8qL0TXyleSRBPAczdfi1t31hKpELRLILWTFDSPCBIKOB+r1FOGJW/lSyc0dvwYGF/kpAm//EBWSHwDGo1cSsYuw7pWu7VGJJ2hOE8D/OWbb0hqgguUanfh0tFr9TMzd4vWNHER+338KGh3y/lJnHL5FO94WGjJpeb8WUMi4duxDmTxPLyFTTlPxiykQ8QUymLtw8tV2SfjBJsOsUuIzG0344MFyNIyOD4oK1zYEQavKHOADYah3suiTyb4MQ4PIBV/5OlF/vJiWHqBEWjB2ytwyRrCJCriWsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EdRJok1SlndBtdw6BGdgupCYM2HLXzZwOinc4uKVMCU=;
 b=fxfQC56qDyjbaeO7aYXu8/IvsdOW2/k+kxzpmVTiWX0hcp2NXx6ZcoB9K989PTVeIBLxGd+S2D9iy4EHO2OK6F9eIZ7fxQx5+k0u/YVHE1Bn8GaF+nQ/mUJCKQIzX8og9vPJIokjcsPXdUScy1P5qZsl3EoPZGMAiPGCQ4NRukE=
Received: from BN9PR03CA0562.namprd03.prod.outlook.com (2603:10b6:408:138::27)
 by MN2PR12MB4061.namprd12.prod.outlook.com (2603:10b6:208:19a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 09:42:28 +0000
Received: from BN3PEPF00022BDA.namprd03.prod.outlook.com
 (2603:10b6:408:138:cafe::36) by BN9PR03CA0562.outlook.office365.com
 (2603:10b6:408:138::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.14 via Frontend Transport; Mon, 5
 Oct 2026 09:42:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF00022BDA.mail.protection.outlook.com (10.167.248.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 09:42:28 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 04:42:26 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 5 Oct 2026 04:42:22 -0500
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v4 03/15] iio: adc: xilinx-xadc: Use kernel integer types
Date: Mon, 5 Oct 2026 15:11:53 +0530
Message-ID: <20261005094205.1045874-4-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BDA:EE_|MN2PR12MB4061:EE_
X-MS-Office365-Filtering-Correlation-Id: e6d4fa39-5f4c-46d4-8b2a-08df22c4f80f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|82310400026|36860700016|10067099003|56012099006|11063799006|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iISsPPsKO9J/p+j3mAJJrWdqNA6m6UjO46rS/DZ2/d8JW+0VqYVFvspD5a/4dYPF1+89rP4KJ0G+E8s6gqTPNenRF+oggwO3jWYcRmipyq4lF9DhNECnS3KireDq4NMNIJ/LQ4106Uw5MCTSEBgBFsmhCFkEPVh6AndeIyz2NLmfdRQrWjrTEIt7aJjtiJC3iOcza0Yl/LqJKT68bBlsJXM/0sL5xiSo57rWX8PkcCoKIr1p3Uw7xmfa7lnwLAIjJzwPgMzShSn47JIP+nykl4zLFfYYcuTn5pPvkGyjUkj9emhdxU5m+CqSSIukOyQTM+WMQwbgz5e7wEKhYLyl4EEltd7urKy0MtO0Nt4NOSgC04c9PzCyPEpY7K4XERu0YJmqqJZLEJ6b3ZRk2aEOkauzcYDRDWtq0WOvby2++MGVLNL76YuCK+iSwT/3RCMVyLkCy1FqxwVCZXDMEmcyQ6s18AJfnMDMDX4wyyqbeADDecHzS+zjC41jh4NtfbfyrAZsfGvaW2ubS/ePeEzm27LrfaXph5Zbprl1HwzeI4J+FK/CHBU9ESvmqvkDca/jidB/h3mSHQktqksabuER7MEnOQTP3SivC6poA5lzeCeLAjcLjp76aKG33waPUGVQULDqFJMIzRWjqhu+g7mII3IsAz69/URpnP0Q4bG8tMaYEWQWLvfZAfOQJaTcZUjq6raEbNlD1Ae8pzgh3l686Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(82310400026)(36860700016)(10067099003)(56012099006)(11063799006)(6133799003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Hk0gOcMFxWIWodVHo2ydy3zOBrC+X/k3ULI0w1CqePndkq79U7oWHtqK5/pu86WfmEI9VMatCRVZha75B3zErFHRmcpingtxllB1qszSUnWhoQoUxkrGu/evWSLekTX7XS6or63HOfq5ONErGJZFQTvMvrurEuSc4WTV3nzXC5XH89oOJDKRVSCj5AUlOxHIpMkvMRDwDUhZ6dUuVe/iJ3KolJgFNkIyvO1O1v9YePyc0TNq9CDbQjQkdI5/pPB3EE6hVMgjyKHtlMiiXie5+WCOA4IVMYrMuaji2Cc5tEVuBQJZb4hIHbuOroqYGdRxYOVpBMdezmgJy8IogkuXrD9bAIJAFa4VMgM3joxfWgeRG9yx1gfsVruSY0bkZt3iDUy/V2Ijt05WUU/cxHCi/sIVi46JNCpndUQ4wf0wNO941WaAwJ4RdiFy8dz8qY3w
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 09:42:28.0126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6d4fa39-5f4c-46d4-8b2a-08df22c4f80f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BDA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4061

Replace stdint types with kernel types and include linux/types.h
to explicitly provide the corresponding type definitions.

No functional changes intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c   | 49 ++++++++++++++--------------
 drivers/iio/adc/xilinx-xadc-events.c |  3 +-
 drivers/iio/adc/xilinx-xadc.h        | 19 ++++++-----
 3 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 472246b6a1c7..1c60d4f38ffe 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -23,6 +23,7 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
@@ -119,12 +120,12 @@ static const unsigned int XADC_ZYNQ_UNMASK_TIMEOUT = 500;
  */
 #define XADC_MAX_SAMPLERATE 150000
 
-static void xadc_write_reg(struct xadc *xadc, unsigned int reg, uint32_t val)
+static void xadc_write_reg(struct xadc *xadc, unsigned int reg, u32 val)
 {
 	writel(val, xadc->base + reg);
 }
 
-static void xadc_read_reg(struct xadc *xadc, unsigned int reg, uint32_t *val)
+static void xadc_read_reg(struct xadc *xadc, unsigned int reg, u32 *val)
 {
 	*val = readl(xadc->base + reg);
 }
@@ -138,7 +139,7 @@ static void xadc_read_reg(struct xadc *xadc, unsigned int reg, uint32_t *val)
  * sleep and wait for an interrupt that signals that a response is available in
  * the data FIFO.
  */
-static void xadc_zynq_write_fifo(struct xadc *xadc, uint32_t *cmd, unsigned int n)
+static void xadc_zynq_write_fifo(struct xadc *xadc, u32 *cmd, unsigned int n)
 {
 	unsigned int i;
 
@@ -148,7 +149,7 @@ static void xadc_zynq_write_fifo(struct xadc *xadc, uint32_t *cmd, unsigned int
 
 static void xadc_zynq_drain_fifo(struct xadc *xadc)
 {
-	uint32_t status, tmp;
+	u32 status, tmp;
 
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_STATUS, &status);
 
@@ -166,10 +167,10 @@ static void xadc_zynq_update_intmsk(struct xadc *xadc, unsigned int mask, unsign
 	xadc_write_reg(xadc, XADC_ZYNQ_REG_INTMSK, xadc->zynq_intmask | xadc->zynq_masked_alarm);
 }
 
-static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
+static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
 {
-	uint32_t cmd[1];
-	uint32_t tmp;
+	u32 cmd[1];
+	u32 tmp;
 	int ret;
 
 	spin_lock_irq(&xadc->lock);
@@ -198,10 +199,10 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t
 	return ret;
 }
 
-static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
+static int xadc_zynq_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 {
-	uint32_t cmd[2];
-	uint32_t resp, tmp;
+	u32 cmd[2];
+	u32 resp, tmp;
 	int ret;
 
 	cmd[0] = XADC_ZYNQ_CMD(XADC_ZYNQ_CMD_READ, reg, 0);
@@ -283,7 +284,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 {
 	struct iio_dev *indio_dev = devid;
 	struct xadc *xadc = iio_priv(indio_dev);
-	uint32_t status;
+	u32 status;
 
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
 
@@ -387,7 +388,7 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
 {
 	unsigned int div;
-	uint32_t val;
+	u32 val;
 
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &val);
 
@@ -412,7 +413,7 @@ static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
 static void xadc_zynq_update_alarm(struct xadc *xadc, unsigned int alarm)
 {
 	unsigned long flags;
-	uint32_t status;
+	u32 status;
 
 	/* Move OT to bit 7 */
 	alarm = ((alarm & 0x08) << 4) | ((alarm & 0xf0) >> 1) | (alarm & 0x07);
@@ -446,9 +447,9 @@ static const unsigned int xadc_axi_reg_offsets[] = {
 	[XADC_TYPE_US] = XADC_US_AXI_ADC_REG_OFFSET,
 };
 
-static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
+static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 {
-	uint32_t val32;
+	u32 val32;
 
 	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, &val32);
 	*val = val32 & 0xffff;
@@ -456,7 +457,7 @@ static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *
 	return 0;
 }
 
-static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
+static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
 {
 	xadc_write_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, val);
 
@@ -477,8 +478,8 @@ static irqreturn_t xadc_axi_interrupt_handler(int irq, void *devid)
 {
 	struct iio_dev *indio_dev = devid;
 	struct xadc *xadc = iio_priv(indio_dev);
-	uint32_t status, mask;
 	unsigned int events;
+	u32 status, mask;
 
 	xadc_read_reg(xadc, XADC_AXI_REG_IPISR, &status);
 	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &mask);
@@ -510,8 +511,8 @@ static irqreturn_t xadc_axi_interrupt_handler(int irq, void *devid)
 
 static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
 {
-	uint32_t val;
 	unsigned long flags;
+	u32 val;
 
 	/*
 	 * The order of the bits in the AXI-XADC status register does not match
@@ -565,9 +566,9 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.temp_offset = 280231,
 };
 
-static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t mask, uint16_t val)
+static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)
 {
-	uint16_t tmp;
+	u16 tmp;
 	int ret;
 
 	ret = _xadc_read_adc_reg(xadc, reg, &tmp);
@@ -577,7 +578,7 @@ static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t ma
 	return _xadc_write_adc_reg(xadc, reg, (tmp & ~mask) | val);
 }
 
-static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t mask, uint16_t val)
+static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)
 {
 	int ret;
 
@@ -738,7 +739,7 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev, const c
 
 static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 {
-	uint16_t val;
+	u16 val;
 
 	/*
 	 * As per datasheet the power-down bits are don't care in the
@@ -869,7 +870,7 @@ static const struct iio_buffer_setup_ops xadc_buffer_ops = {
 static int xadc_read_samplerate(struct xadc *xadc)
 {
 	unsigned int div;
-	uint16_t val16;
+	u16 val16;
 	int ret;
 
 	ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
@@ -888,7 +889,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
 {
 	struct xadc *xadc = iio_priv(indio_dev);
 	unsigned int bits = chan->scan_type.realbits;
-	uint16_t val16;
+	u16 val16;
 	int ret;
 
 	switch (info) {
diff --git a/drivers/iio/adc/xilinx-xadc-events.c b/drivers/iio/adc/xilinx-xadc-events.c
index f92776cd90c0..f5b5aad6e313 100644
--- a/drivers/iio/adc/xilinx-xadc-events.c
+++ b/drivers/iio/adc/xilinx-xadc-events.c
@@ -9,6 +9,7 @@
 #include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/kernel.h>
+#include <linux/types.h>
 
 #include "xilinx-xadc.h"
 
@@ -125,7 +126,7 @@ int xadc_write_event_config(struct iio_dev *indio_dev, const struct iio_chan_spe
 {
 	unsigned int alarm = xadc_get_alarm_mask(chan);
 	struct xadc *xadc = iio_priv(indio_dev);
-	uint16_t cfg, old_cfg;
+	u16 cfg, old_cfg;
 	int ret;
 
 	mutex_lock(&xadc->mutex);
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index b36510450982..fb911ed87600 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 struct iio_dev;
 struct clk;
@@ -42,11 +43,11 @@ struct xadc {
 
 	const struct xadc_ops *ops;
 
-	uint16_t threshold[16];
-	uint16_t temp_hysteresis;
+	u16 threshold[16];
+	u16 temp_hysteresis;
 	unsigned int alarm_mask;
 
-	uint16_t *data;
+	u16 *data;
 
 	struct iio_trigger *trigger;
 	struct iio_trigger *convst_trigger;
@@ -70,8 +71,8 @@ enum xadc_type {
 };
 
 struct xadc_ops {
-	int (*read)(struct xadc *xadc, unsigned int reg, uint16_t *val);
-	int (*write)(struct xadc *xadc, unsigned int reg, uint16_t val);
+	int (*read)(struct xadc *xadc, unsigned int reg, u16 *val);
+	int (*write)(struct xadc *xadc, unsigned int reg, u16 val);
 	int (*setup)(struct platform_device *pdev, struct iio_dev *indio_dev, int irq);
 	void (*update_alarm)(struct xadc *xadc, unsigned int alarm);
 	unsigned long (*get_dclk_rate)(struct xadc *xadc);
@@ -83,19 +84,19 @@ struct xadc_ops {
 	int temp_offset;
 };
 
-static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
+static inline int _xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 {
 	lockdep_assert_held(&xadc->mutex);
 	return xadc->ops->read(xadc, reg, val);
 }
 
-static inline int _xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
+static inline int _xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
 {
 	lockdep_assert_held(&xadc->mutex);
 	return xadc->ops->write(xadc, reg, val);
 }
 
-static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
+static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 {
 	int ret;
 
@@ -105,7 +106,7 @@ static inline int xadc_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_
 	return ret;
 }
 
-static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
+static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
 {
 	int ret;
 
-- 
2.34.1

