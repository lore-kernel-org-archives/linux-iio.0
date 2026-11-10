Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.31
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794287574;
	b=U0Mi9jHkM8OTKWBoCMt/dPnNm0ULvLS4WKlW3gpuE4hI4zo1Jn4NUjCYFB7N+6C0hPeE
	 f2hbAiPTzmhPIjlDwdBISFRyUu2sEMDRmW0cXyMjyUm0VcRkG9IuBIepXZ46Jimob4HBR
	 lUmmcDBXWniTAxbrnIjrd/WIv6BNkhKnvOk2lAtpUfAQIB7S3i82YtIj1zyLuwuMJZFbe
	 zwX7/J7UU3q6wtpBzoO0ERG2YP9ro+uP5A+1HuzBqJc1Gz02J6lfsWTv+RbSCIhQlnX3Z
	 CB2tb7dITsZ1u6o/rpcquYX0K2cR1D580Pt3sKfkfoAs9uRkU7aODFTSX/rERnTxUyA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794287574;
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
	bh=aDC3X2/0hQMzOk/CCQezNsqY43CT12JCwO/DKFiVKfw=;
	b=FZk/UYnJOItjLNOr0rQVFca1Q5KSE+3XUO9E+QANUpChmz72tchO/ciaynCBe7J5ZOLy
	 rbjKRUtf0xdep02ltwXPhzt1KwtNP9qP9eBAONEEkkp/1YtkjvOHbuIttKb1Pd0pICVR/
	 CtJciMZh81WO9wPI/fH//BI0nwwyCgknJAc25LWhBhnV60LNvg1oazNTbG2j00FJNmPmR
	 EDtVL3yy+xTi4cCUtIdP6vMqE4DcHS+t4zVGhBn/k/DZ4Fzr3KDHyGjW1LqX1eZfJvYe9
	 AunwE7eqq/q5uonB0d0Mf7HuLtuPdh1hbOPPLuS0DyZI0IFSeDWYVYhKRCS5ZuEKJxw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sM2eVSAQ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.56.31
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010031.outbound.protection.outlook.com [52.101.56.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A136606A31C;
	Tue, 10 Nov 2026 05:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A136606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=sM2eVSAQ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IysAMCp+APQKJbexdaoSwOpcCMSVaLHHJ3E+r2GyAfAAo5a3WM6jIV0skuMXVnLcZCvd6YPhq4F2CXUtU0XXBri7dAx8YQt/h7nUvLJtFpTLsG42Rv903Ho8GztuMNmp9HWe6X3h8rDb9nMtzP5Xas7YERgCpuTclmJojLrdZYQK0esGlwtJ+hVhFaGvJylAWc9O2bm+4AKFYlLNUTkS6w9VCKvLkhaC1M3gCHDtcrBQE5bEvgXxSea0TDBGbII+EHRli1/Rgf4moXjs2JQN9CPL0RYQK7maVTE+r4qiCD/NxwF2yel1Gn7ZtWWGFSWLI0VTX2KIwK0nBQWa4s70Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aDC3X2/0hQMzOk/CCQezNsqY43CT12JCwO/DKFiVKfw=;
 b=sfaFvZMWgxWt5t+H4d4FJhrEmcqFWbjaiCOVNN2MZx3qJbDaLy7X9tsKrHojN7kzut3MvVq9UgvUkZNYgM+kbmqw0PL8wWbiOKFKRG3nEYJiYcu4woeZ69SCLCs4ITWO+yHqPufPoTVKVZotc3rYCHj7fhe77Y+wbzMzmitsdz3FKKc+ujAlqfia3BFhBg/8nzoZ/IA8kSknuAenfqMHk8VTwoLBBYXLaA42WaFR6vqvddC5wN7gdA4RMGWUnohNGr/M/ZpIpHufecUJIokB5HNCADzS8XV9JLFcqSpLVf+gHID4d3b4dq4QnPOxGh+0G3C/69EhXas2O1N+CpKK6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aDC3X2/0hQMzOk/CCQezNsqY43CT12JCwO/DKFiVKfw=;
 b=sM2eVSAQi6sPTJ+yE2qcMMfcip8LDHSKEm+L++95R3tYr17oXSYN6sFnVaMJTh+wdG36rWP9PLkr/d2srIis0XD4ywwWDX0oAu7gAAq97uh0sFfsFg2tJfmBtKgzTDUWJYOo5K5BWCHL3e2tcxyx5D/abLMCmtgyWwozolWhHaM=
Received: from MN0PR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:52f::29)
 by PH0PR12MB999112.namprd12.prod.outlook.com (2603:10b6:510:38c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Tue, 10 Nov
 2026 05:08:47 +0000
Received: from IA0PEPF0000003E.namprd03.prod.outlook.com
 (2603:10b6:208:52f:cafe::5f) by MN0PR03CA0019.outlook.office365.com
 (2603:10b6:208:52f::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Tue, 10
 Nov 2026 05:08:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003E.mail.protection.outlook.com (10.167.249.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 10 Nov 2026 05:08:46 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 9 Nov
 2026 23:08:41 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Mon, 9 Nov 2026 23:08:38 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v5 03/16] iio: adc: xilinx-xadc: Use kernel integer types
Date: Tue, 10 Nov 2026 10:31:48 +0530
Message-ID: <20261110050201.1850399-4-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003E:EE_|PH0PR12MB999112:EE_
X-MS-Office365-Filtering-Correlation-Id: 0269c52f-3ab0-4905-ceb9-08df3ee8b338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|36860700016|82310400026|261102123227099003|11063799006|261026121527099003|261022105027099003|261009223027099003|261021123027099003|261021121427099003|261026140227099003|261028144727099003|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	SXJWYwdj3rse0epCBpA5Cy6B/NGUdtNmjNazIkYCW+8YsrN5cyAUlykbgKvaJhZQixfhm5MKHxRjq8DnAtZTynIUTkCDFsHeTlHbH/V1tF3ZXb5riQv22LRMFxo9+pt+GUUHREVAOLbrx80TFicCnAp++Zh0dJCEHqatMKqpGQJDov0ODU8z5IixGLLjGy/ubDchsI2LItch8Tg8+uKGs88HBSrDHHdJuYwMbzD4Jtf/9IA80ir54MFYNO0S1rr42IKswHq8oZq+l3Gom+ROmmztF4i9GY9GQfIY5MlJIPZvhN4kUIF6euhDA45g1xVZH/RvDRlc+VFUHP4TWNxiEck71c7XG0ZmgGIi1zadHChDQ/ioMS4ZeQvMTXT5tEZpu61V/5T5j6wpUDrT+OiOnTGkPkS71mfmJmSLW+zdHK9tuPd+0Oj0/dU95zJZlPiv0FBZPDSRhlKUXQhLdA8ifbi/seQnfUhjfXi3jkqfhNPWDQRRTnTbCxNWxSIbP+tY26RpmyeeEXhlOL//xP4bgD2TxdS4l9vpKSqIAOCmOjHxa/QGrb+9mlM8E0pecRHBfcfrwGfAcGkrdPTo1i3kV8wdYpD5A1yUd77c48y4ura2ZeARyi/3VWTN93WSzX5aaCaOUl2CMhsAuAT3TWg8Vu8TUPHN2BI5ERhunxIP/7F1tAFp1/yK6zY/lwSzIxxjTHJ58MgEeUXO72JIAc52KA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(36860700016)(82310400026)(261102123227099003)(11063799006)(261026121527099003)(261022105027099003)(261009223027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261028144727099003)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MEqVCNTh2wrRGn5YtJ3wP7pFYLLpFWewOFckjgP6mRg/G40qyX1vX368blOu8klhg5oxPmJy8zUTsGcE1+9o3RelMqaxkgTxEusOaGJlNTx2HIhZWtROSzGNJRGJ0KbA0xbaq37CZe4LkHZavsGBbtROHtydGlFQq1I8/ngzlfWLkwBLwqOiUufm2McYFVf6irez4jEFtRniVs/S+e0++j/VU5lI1+p3Geipx9+iLvd0oIP+q+vKinazOEmkU5oTmwU45Dr0XtcF8w7U/30uKc2bQxJbz5tIJQoP2+x+0C++jUFP2SPLzZWXx1269GomGX6BRgUWeQfxbueDnv6X6scdkn92MLgpxTXYLFMt6EagmwnxTVzF/SZFkjI+fcW1WBqfFw80BR3WKRaR47Ki8u7D9weNOcELikfMSsdt4O0wRLMF+GtOqIq0rxCWojmi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 05:08:46.9707
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0269c52f-3ab0-4905-ceb9-08df3ee8b338
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	IA0PEPF0000003E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB999112

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
index 502aecb2a8b0..e9d5b7ebdccf 100644
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

