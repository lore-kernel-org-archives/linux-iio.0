Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795626681;
	b=xTqmyMgI6yDwaU51LGpGjxbpf0bhA1mDxT6Rn6yUpzQxKeIHpwODs1+7I+4Bq5aDAyhK
	 tEDelZiNkpqCSYME1P0yPTQjG6l2WdwUD667JqHIT3MOQoXBbyVvnSrLwwoRGO3U3LwUk
	 doV1j/nSnrhj2tQLgzqYn2+OtH2EhXY4LLp0x+MQUe9YuK7cC6/Wbf+fDYRjuoJXvfOng
	 sPiQmzD7SbPiRRUuvYdtnbvUJf68ltYml+Wb75doXJWr6jck48wOPYhaew3Ry35aHxkSp
	 m5e55UJSWsbVvUnCB4aXmGUaCO3TNwqMzf5OIreo3DjseP/dPwCAl8MUTEiEK0GkZqA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795626681;
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
	bh=+ggZy1WC3YABp4wXlN/rAKd+bEevLo/hPD90b9j9V+A=;
	b=RCdKfSq7zuRGqcrJC5LTh5bxzccNbVmiriguc658sE8V5t3Wca8XU0355KDLbHFygzBj
	 yOGl8MWjK/g7mL/yUMZEBSaLuGxQxmzG+oPboRHnM3tI45T86Ln2bAaFPLlbjJaqGMvTY
	 XTFTmzlXnE5DChyIf5uKw8huzyDp2DJRDPp1A74vUfL1H2bJ2EeXfSzYb64CWYCxdzM+o
	 iOmRVCtBMS3BbStt50XrEnrxxUHKzyI7dQwCf8Atl97iC9iwoIIrJISCpkydLLjy+MixA
	 dsgUzpHmyoqaDoC1vtz4zBa4mA4ROskEe8sTLWcAgxVNY5LpUHEpR0l8RCv+JdgM3eA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lqeLmYQh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.53.61
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012061.outbound.protection.outlook.com [52.101.53.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2FC606A31E;
	Wed, 25 Nov 2026 17:11:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF2FC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=lqeLmYQh
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qb8BVo08pHVHBFJIFgfRCIWbr6+726iINiLgycFv7xvK1Giuxs5+ETFzcjpeC7aJJWQpeA+op9O1yNwwwWNFmh3+11jv5v0D4lHR6yB/CnOUwfu22Gd/hRjks3h2U3s5HMau/Xq+Fo/axGTTDT7oZvQv70exH20GNnjxl93aZ/m2vIoGd4RlI+sRwLziiLXa/gKOBlzeaZFVGwM7oXTRavuw1J2fgvMJcNPgZZFQli4NZRuJSqDZZvCifSN1d4hUg9GCs6BgNv9Pe9hJVMTx58L4GeG+ROtLH5ZCeNmqZEXKX6r5ubRhmNa5RZ8arsRhzOxEgwcFhOFNXnp7bFkgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ggZy1WC3YABp4wXlN/rAKd+bEevLo/hPD90b9j9V+A=;
 b=LSxgxK3DyDFkQPQ9wQ69z0RdfbQgwC64nvabqZJSgjVH6htwfMLHOr7Eo1ZVBDz/5ieXgL2M6stem9qNSff/nUZIk1D1+cw59ksVOg0PQiRac/vJ62rcVqo90RPpA+1pcWmeqhEoi3yo7nqDYe7MFUmPlLPz1V5av+pjdlZcGeU9Jhz8TG50PZbrMi/jOn6MHaiLf18Ab9SNTK8sZbpyMxKAuawx5sbv/3C2Oc0W/c9hgkuvTuPEV7l/DTRYI0sN4gT97ECKpgYDmm/KMC5NwItRVYy+jiP4SQiXSm4WJ4NwIIHcK4fTExewmYuhbTUlfUE5ZGLp7i/9BHhTCLArWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ggZy1WC3YABp4wXlN/rAKd+bEevLo/hPD90b9j9V+A=;
 b=lqeLmYQhWaZu6kwHk19MJ9egvtdqbNHDMtMMBYkEeluxKOKrDVoZcByQregAYoUSv2HIJFrWUo9NwGm9MwXvuyH3yLS9joIfKmiZU6YxFWuRPbJXNXIdNJ81YRLyaMA0P4rYVaKT/3AnnkaI9iJP84rOnKbV5Q8qjGy/EnutNAc=
Received: from LV3P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::11)
 by DS2PR12MB9639.namprd12.prod.outlook.com (2603:10b6:8:27a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 17:11:14 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:408:234:cafe::7) by LV3P220CA0019.outlook.office365.com
 (2603:10b6:408:234::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.7 via Frontend Transport; Wed, 25
 Nov 2026 17:11:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Wed, 25 Nov 2026 17:11:14 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 25 Nov
 2026 11:11:13 -0600
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.57 via Frontend
 Transport; Wed, 25 Nov 2026 11:11:09 -0600
From: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<dileepkumar.nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>, Joshua Crofts <crofts@kernel.org>
Subject: [PATCH v6 04/16] iio: adc: xilinx-xadc: Use kernel integer types
Date: Wed, 25 Nov 2026 22:40:18 +0530
Message-ID: <20261125171045.1246381-5-dileepkumar.nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|DS2PR12MB9639:EE_
X-MS-Office365-Filtering-Correlation-Id: e1e0c593-d952-4dc1-1ff0-08df4b171c56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|23010399003|376014|6133799003|22082099003|18002099003|56012099006|11063799006|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261009223027099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	qLvEhkT3kGLo3Ucde10a59EWU4Inb+HqN8YyjSSH7kzS4bEeqgDToKIvfIka4wErKxs8H8yJGEdZRNLNnWa6fGuOcM3FWJwZJO58N5UyAs/hELzp5d/Yncr8l/z08kpQ/4O+R8MZOcXFoACJZWnRPrGKFJ924oaWAxRLBRnNbbL1YEvoCK1veLgmt9cnzdqgTkw9eBWUMkVADP7Q/dwEamMsE/+ETCMibkbsKdw8+fOQsmyJmyaO3nWV7vfhxqQk+h1PyT8vw/Smv1a6b+zsnfAQsAh0qloR6DEM2eFvl9pTGn2u49DHYdHFO3k2C6VwTT2+7fhmMuuMWrd/VfM1s7f6kHNhgn04F+xh/IuIMwlhkOLfUyA6zu/8nDOl3B0NkLZr7galnerinDMyZAYIm1w/RsMbZNWenMJ/EPMeuQqgqolFNISmeYJGOThZNXHrkghQRBbsxK7nq6UgE+Ufd34v3I43sa1vK32TQEdiaYna5IWxRFyJ5kvUoCKIXMJkaEl/X5bHio5wXUYSg/hXqVwwpAHDtGJ+EDmXpEN88GjOfl+AtTPEik3huVJ1YCerKrOALcYvujf94jaL5GvwwEEmDSB3XSPdG9orwYo5/dM5ZhQjVTi2+LEuT1YAN9qZa/8OAd4woWsv+1Po4WZ/7eoGPYIXC/3djTFPp5zy/4M6FHp8akutu9o6r+iLmzpMcxdOtJU3kCgJ2CE9JRH0OQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(23010399003)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WqC3P2131/aO7d6pEbEd6KqMoBizwyEWhG3xCaf/b9IYFdGvKqFN+TFBcaBfNEFJuONFk5guc2jm7OeIIvHiUIKMgko3uTE+raBf96WnbS81PwS3JxZJl7UdmfqnIr7KYn7DTZx/98RoSru+nASWJRmmJZZDf6TSfAja6s+cXHwxWYr3rqZG0rYRVUI2pdDfnUKHgQ7U06sXhiznOo/BqE20//ziQtF2isgI6m2GKQdikwG9lI/YEyYFF7EgJQfTlWll5hv8q6Ce3OrZfwKLodlfErrch7LCEmAc3TQDvWYDs6Fk2NSgb1L+3CdIHx8YmQI/gRaWWwz4DY0SNZWvh0wlaPbJYuJSP5W4PHPsIjvR/4dSUbmuRNczM46g+OOFmNW07JyMnJlAOV0pN4Hiz8aIDbZq32dy3pLYZLRuo/2uTpmdWQetTQJylQa+idoM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 17:11:14.1214
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e0c593-d952-4dc1-1ff0-08df4b171c56
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9639

Replace stdint types with kernel types and include linux/types.h
to explicitly provide the corresponding type definitions.

No functional changes intended.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <dileepkumar.nagavarapu@amd.com>
Reviewed-by: Joshua Crofts <crofts@kernel.org>
---
 drivers/iio/adc/xilinx-xadc-core.c   | 49 ++++++++++++++--------------
 drivers/iio/adc/xilinx-xadc-events.c |  3 +-
 drivers/iio/adc/xilinx-xadc.h        | 19 ++++++-----
 3 files changed, 37 insertions(+), 34 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index 9b9a1e440af1..f7623b8050bf 100644
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
@@ -200,10 +201,10 @@ static int xadc_zynq_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t
 	return 0;
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
@@ -286,7 +287,7 @@ static irqreturn_t xadc_zynq_interrupt_handler(int irq, void *devid)
 {
 	struct iio_dev *indio_dev = devid;
 	struct xadc *xadc = iio_priv(indio_dev);
-	uint32_t status;
+	u32 status;
 
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_INTSTS, &status);
 
@@ -390,7 +391,7 @@ static int xadc_zynq_setup(struct platform_device *pdev, struct iio_dev *indio_d
 static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
 {
 	unsigned int div;
-	uint32_t val;
+	u32 val;
 
 	xadc_read_reg(xadc, XADC_ZYNQ_REG_CFG, &val);
 
@@ -415,7 +416,7 @@ static unsigned long xadc_zynq_get_dclk_rate(struct xadc *xadc)
 static void xadc_zynq_update_alarm(struct xadc *xadc, unsigned int alarm)
 {
 	unsigned long flags;
-	uint32_t status;
+	u32 status;
 
 	/* Move OT to bit 7 */
 	alarm = ((alarm & 0x08) << 4) | ((alarm & 0xf0) >> 1) | (alarm & 0x07);
@@ -449,9 +450,9 @@ static const unsigned int xadc_axi_reg_offsets[] = {
 	[XADC_TYPE_US] = XADC_US_AXI_ADC_REG_OFFSET,
 };
 
-static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *val)
+static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, u16 *val)
 {
-	uint32_t val32;
+	u32 val32;
 
 	xadc_read_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, &val32);
 	*val = val32 & 0xffff;
@@ -459,7 +460,7 @@ static int xadc_axi_read_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t *
 	return 0;
 }
 
-static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t val)
+static int xadc_axi_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 val)
 {
 	xadc_write_reg(xadc, xadc_axi_reg_offsets[xadc->ops->type] + reg * 4, val);
 
@@ -480,8 +481,8 @@ static irqreturn_t xadc_axi_interrupt_handler(int irq, void *devid)
 {
 	struct iio_dev *indio_dev = devid;
 	struct xadc *xadc = iio_priv(indio_dev);
-	uint32_t status, mask;
 	unsigned int events;
+	u32 status, mask;
 
 	xadc_read_reg(xadc, XADC_AXI_REG_IPISR, &status);
 	xadc_read_reg(xadc, XADC_AXI_REG_IPIER, &mask);
@@ -513,8 +514,8 @@ static irqreturn_t xadc_axi_interrupt_handler(int irq, void *devid)
 
 static void xadc_axi_update_alarm(struct xadc *xadc, unsigned int alarm)
 {
-	uint32_t val;
 	unsigned long flags;
+	u32 val;
 
 	/*
 	 * The order of the bits in the AXI-XADC status register does not match
@@ -568,9 +569,9 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.temp_offset = 280231,
 };
 
-static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t mask, uint16_t val)
+static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)
 {
-	uint16_t tmp;
+	u16 tmp;
 	int ret;
 
 	ret = _xadc_read_adc_reg(xadc, reg, &tmp);
@@ -580,7 +581,7 @@ static int _xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t ma
 	return _xadc_write_adc_reg(xadc, reg, (tmp & ~mask) | val);
 }
 
-static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, uint16_t mask, uint16_t val)
+static int xadc_update_adc_reg(struct xadc *xadc, unsigned int reg, u16 mask, u16 val)
 {
 	int ret;
 
@@ -741,7 +742,7 @@ static struct iio_trigger *xadc_alloc_trigger(struct iio_dev *indio_dev, const c
 
 static int xadc_power_adc_b(struct xadc *xadc, unsigned int seq_mode)
 {
-	uint16_t val;
+	u16 val;
 
 	/*
 	 * As per datasheet the power-down bits are don't care in the
@@ -872,7 +873,7 @@ static const struct iio_buffer_setup_ops xadc_buffer_ops = {
 static int xadc_read_samplerate(struct xadc *xadc)
 {
 	unsigned int div;
-	uint16_t val16;
+	u16 val16;
 	int ret;
 
 	ret = xadc_read_adc_reg(xadc, XADC_REG_CONF2, &val16);
@@ -891,7 +892,7 @@ static int xadc_read_raw(struct iio_dev *indio_dev,
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

