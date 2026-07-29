Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011041.outbound.protection.outlook.com [52.101.52.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A7E48665E;
	Wed, 29 Jul 2026 12:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785329736; cv=fail; b=QcIxCu//0lTmEgzISVHbVLjP4mG7FDs2OXDiVpZ9qjVFhkL9uHEV8xEf4sQXhAwux77vTHOk152GF/AgzO6n8JxTMhOiFU3/eyh4rlYeDOM/XieVHrUcmlXM6mV9aPhvj6x8qDn05mLXBChcezbq8HfjEyshpg2QWS9pI1Ii+Rw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785329736; c=relaxed/simple;
	bh=w5GupznUJq2wo6WtqadMZ8n7/vLFPz+7OdNJ91d2KYE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=skwstX44Qa4AQeSE9ttSuPVY4sssHgTr2au0SYxUdkk3wD0lF0cAFr8GXDO87h0UvoeZucyZAnzosDzY13c/A6STa9O17KYQRdOj9EVZaeaQWl0JW+hrpc1zyJSsHTWVSvob9kM8V++mqznoNH8GR00aM2hsd+peS0Fhi6UP2ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2diW129M; arc=fail smtp.client-ip=52.101.52.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2diW129M"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nOZdksW9KHvmxEgOFk9pcwUqtBTjrjlKpcscsYh1svjIv9o2280Vz50VBInQvBJiP2vZ33ipEGcaVuOk4l4nbpDuln8+uh47NY4LNY155DjY46WwyTCbBRmTscr2UMCpvnSvibSt/wJzi/s/+MCdOLneIYqK/BSdNU2hdJ//+ztPBqhQjSHKkL60zbK1xl1C4qmokvch906tbK8YXLJsoNQCZJf7EKR9Fb6tbPu9LIJ1IsefD0esPk7UqaXk76xKHgsB64GMtvi4KDt08VECoYMSrWvwm26N8OYX4+JxHiMDoEdJwGcqKlD9S7n/7CS3+cY4Y2E2QjDQVfYnyjS9qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PY1MrCwdqriMyPC0+KQlB8q4wSKcvSpFbpyU+0OoSY=;
 b=L6/U2IG+sBsTYpy1Yyg2jDBIn9uiXrTeApxnopRXrBql3k2ODc9ZNl1bWQWSujQ97y66YmNxoMBFbFUVTB4POrv372YEjgmCS1BpFdvnxaJ6EAiPZmeVhdVU/BhbnGuvCrfAZqvTWv9TluIXyr031h/e8an3HCSONIXv4i0MTdUKCubJJmURC/BSkuKCcHJLUy15KqjcB22ev+3a0UTPqMjyJMLsSJStWoigFZJlyBOUeOqNzk/GsTsprJi4DcFJ28bqcF4jp8ZIaTAhJe6xklfB2xqbFeZLmFk59LHOy+x4wN646SgEWiHI+aUfwlc3g2I2UXjg5BIh+0qljukTEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PY1MrCwdqriMyPC0+KQlB8q4wSKcvSpFbpyU+0OoSY=;
 b=2diW129Mm3Kf8T6xrh4POzHYXalut3UHElM2D/cH06T6ciFP1PFFsLMdBLiqePupA0+AZfdS5+cl5BYz6zo0W1EhCrhkZJT67iDBLwVAWQqpHc2aXkYkTT31by6BmbmLA8sLXyb5/RimzBZBMxJT/8QvOwmLsm9N02VBbCJXYm4=
Received: from CH2PR19CA0022.namprd19.prod.outlook.com (2603:10b6:610:4d::32)
 by BY5PR12MB4067.namprd12.prod.outlook.com (2603:10b6:a03:212::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.13; Wed, 29 Jul
 2026 12:55:24 +0000
Received: from CH2PEPF00000143.namprd02.prod.outlook.com
 (2603:10b6:610:4d:cafe::84) by CH2PR19CA0022.outlook.office365.com
 (2603:10b6:610:4d::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Wed,
 29 Jul 2026 12:55:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000143.mail.protection.outlook.com (10.167.244.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 12:55:23 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 07:55:22 -0500
Received: from xhdappanad40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 07:55:18 -0500
From: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
To: Jonathan Cameron <jic23@kernel.org>, David Lechner
	<dlechner@baylibre.com>, =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Michal Simek <michal.simek@amd.com>,
	Conall O'Griofa <conall.ogriofa@amd.com>
CC: <linux-iio@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Dileep Kumar Nagavarapu
	<DileepKumar.Nagavarapu@amd.com>, Sai Krishna Potthuri
	<sai.krishna.potthuri@amd.com>
Subject: [PATCH v3 4/6] iio: adc: xilinx-xadc: Add .setup_channels() to struct xadc_ops
Date: Wed, 29 Jul 2026 18:24:53 +0530
Message-ID: <20260729125455.95893-5-DileepKumar.Nagavarapu@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
References: <20260729125455.95893-1-DileepKumar.Nagavarapu@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000143:EE_|BY5PR12MB4067:EE_
X-MS-Office365-Filtering-Correlation-Id: d24921fd-9549-432e-f326-08deed70a776
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700016|23010399003|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	sngyDBXMJJkGPQWM8ECBkK2a/bJJjEr8Qgxcs1w1+HhDU9iRv2GVmJh7HlEjlP5XjPuV7mwsTRkaDcUye5fpKWJ2W35ETWq3O0Fgviz6QXYIknR9g5RiG+a/y9n3ShnMAhDP3W4EfUdCsJjvGsRRwtGNcnkEcIvy72xRcw5bJucPyL0Y6oYMPt7vcBSzH3W7StGVLAqOw6OV95axfGow4dE6wyW67CtD9iINsGF/r5nfTlCFyuv05jLoOZOCOuYvMtMGPaOZ/6pmUvvEdRUy+aXOZV/qHzhOrc3v1ZF3sCm77pQtUJYUiiQrKULkcu/mzF3n3x9FlDdwbGQ2epcAcUKXPWWHShUo78yE4vI68239bZ23xhc7NRk6BtssJ1z+H9KhHjyz9+0v2MvCkiANAuJoOUPzq15/2hc+/929qRw5TQTvAPb2wTJRkWiwG8HwIT4ZQrWYa5Lf1lAFvaSfs/KzKPTWGqAq6A+okvpe/VcLOM6jHv744ONMbk3WY+1s0o5SLxwIrdmFPUeoBFUOPSngifhgb8G/6OfOel2S6VwL063uMJCT7iB5bsmgZXIaEouMoxTfvBRrM4tA6XowVs4GcFCAedzwmP8ggB8veIVgkWkcVdag5zLe7XhW6v3Qx49iM5oE3iAe3IB65+SQeBewVjK4xahuU5m1o7T4wJTBngXknA+nW477aSdmWBDG5GOsq78Xsl61ZJTdadFuVQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(23010399003)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	4SwlaPwJBW3GKgG0+hYICZq1KaPL/x8g/AaE61gmeDcxkRdIP20WP74KvyOHXDW348VZ7enFmuJViLcuRvbV8D6XczFj7qMyaswlYemOgzMxK/v5szW0dxqXHD9oPpMMEDbpMAcgNpDEFm+Q+nb6syC0vDQlLx1rKzk3o1Hw9fhYHxarWCSB9RXCu2KGy5cOouLmcFPLvcC16niqDNeokKY0u4DVBXd8NNaQztaU8bmvzWUsmbTkZxIf8XX4B6/LYdqRcfjPE9KvrFS1yxAPOBaRnsODehWiGenDq0I9ircVwUNg/doXg6eEEsso9GFWxy+qiC7ep63iBNFoU1NPdkj9d9CdgiuEXWkmVGvUIrCAshxlmDSLX3k0zNjLPPcpTNsoexQFKvEbfxVhoGhqHr5H0UPlPLSi/HW2ENRCt3mDAffMkpku0MqpCEY8gHNf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 12:55:23.4344
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d24921fd-9549-432e-f326-08deed70a776
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000143.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4067

Add .setup_channels() function pointer to struct xadc_ops to enable
different interfaces to have custom channel setup logic.

Co-developed-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Signed-off-by: Dileep Kumar Nagavarapu <DileepKumar.Nagavarapu@amd.com>
---
 drivers/iio/adc/xilinx-xadc-core.c     | 6 ++++--
 drivers/iio/adc/xilinx-xadc-platform.c | 3 +++
 drivers/iio/adc/xilinx-xadc.h          | 2 ++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/xilinx-xadc-core.c b/drivers/iio/adc/xilinx-xadc-core.c
index e3b1d5bebe98..d39ff54439ba 100644
--- a/drivers/iio/adc/xilinx-xadc-core.c
+++ b/drivers/iio/adc/xilinx-xadc-core.c
@@ -656,7 +656,7 @@ static const struct iio_info xadc_info = {
 	.update_scan_mode = &xadc_update_scan_mode,
 };
 
-static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
+int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 {
 	struct device *dev = indio_dev->dev.parent;
 	struct xadc *xadc = iio_priv(indio_dev);
@@ -762,6 +762,7 @@ static int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq)
 
 	return 0;
 }
+EXPORT_SYMBOL_NS_GPL(xadc_parse_dt, "IIO_XADC");
 
 static const char *const xadc_type_names[] = {
 	[XADC_TYPE_S7] = "xadc",
@@ -789,9 +790,10 @@ EXPORT_SYMBOL_NS_GPL(xadc_device_setup, "IIO_XADC");
 int xadc_device_configure(struct device *dev, struct iio_dev *indio_dev, int irq,
 			  unsigned int *conf0, unsigned int *bipolar_mask)
 {
+	struct xadc *xadc = iio_priv(indio_dev);
 	int ret;
 
-	ret = xadc_parse_dt(indio_dev, conf0, irq);
+	ret = xadc->ops->setup_channels(indio_dev, conf0, irq);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/xilinx-xadc-platform.c b/drivers/iio/adc/xilinx-xadc-platform.c
index 38748a38da15..bd033315c72f 100644
--- a/drivers/iio/adc/xilinx-xadc-platform.c
+++ b/drivers/iio/adc/xilinx-xadc-platform.c
@@ -405,6 +405,7 @@ static const struct xadc_ops xadc_zynq_ops = {
 	.get_dclk_rate = xadc_zynq_get_dclk_rate,
 	.interrupt_handler = xadc_zynq_interrupt_handler,
 	.update_alarm = xadc_zynq_update_alarm,
+	.setup_channels = xadc_parse_dt,
 	.type = XADC_TYPE_S7,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
 	.temp_scale = 503975,
@@ -509,6 +510,7 @@ static const struct xadc_ops xadc_7s_axi_ops = {
 	.get_dclk_rate = xadc_axi_get_dclk,
 	.update_alarm = xadc_axi_update_alarm,
 	.interrupt_handler = xadc_axi_interrupt_handler,
+	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_S7,
 	/* Temp in C = (val * 503.975) / 2**bits - 273.15 */
@@ -523,6 +525,7 @@ static const struct xadc_ops xadc_us_axi_ops = {
 	.get_dclk_rate = xadc_axi_get_dclk,
 	.update_alarm = xadc_axi_update_alarm,
 	.interrupt_handler = xadc_axi_interrupt_handler,
+	.setup_channels = xadc_parse_dt,
 	.flags = XADC_FLAGS_BUFFERED | XADC_FLAGS_IRQ_OPTIONAL,
 	.type = XADC_TYPE_US,
 	/**
diff --git a/drivers/iio/adc/xilinx-xadc.h b/drivers/iio/adc/xilinx-xadc.h
index 3a9cc87c43b5..67efa093157e 100644
--- a/drivers/iio/adc/xilinx-xadc.h
+++ b/drivers/iio/adc/xilinx-xadc.h
@@ -78,6 +78,7 @@ struct xadc_ops {
 	void (*update_alarm)(struct xadc *xadc, unsigned int alarm);
 	unsigned long (*get_dclk_rate)(struct xadc *xadc);
 	irqreturn_t (*interrupt_handler)(int irq, void *devid);
+	int (*setup_channels)(struct iio_dev *indio_dev, unsigned int *conf, int irq);
 
 	unsigned int flags;
 	enum xadc_type type;
@@ -223,6 +224,7 @@ static inline int xadc_write_adc_reg(struct xadc *xadc, unsigned int reg, u16 va
 void xadc_write_reg(struct xadc *xadc, unsigned int reg, uint32_t val);
 void xadc_read_reg(struct xadc *xadc, unsigned int reg, uint32_t *val);
 struct iio_dev *xadc_device_setup(struct device *dev, int size, const struct xadc_ops **ops);
+int xadc_parse_dt(struct iio_dev *indio_dev, unsigned int *conf, int irq);
 int xadc_device_configure(struct device *dev, struct iio_dev *indio_dev,
 			  int irq, unsigned int *conf0, unsigned int *bipolar_mask);
 int xadc_read_samplerate(struct xadc *xadc);
-- 
2.34.1

